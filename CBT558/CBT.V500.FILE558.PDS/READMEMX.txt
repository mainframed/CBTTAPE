         TITLE  'SCAN ASSEMBLER SOURCE FOR EXTERNAL REFERENCES'
SCANXREF SVLNK R3
**********************************************************************
* READ AN ASSEMBLER SOURCE PROGRAM AND SCAN FOR EXTERNAL REFERENCES  *
* SUCH AS CALLS, LINKS, LOADS, AND CICS LINKS, LOADS, AND XCTLS.     *
* CSECTS ARE ALSO TRACKED. EACH EXTERNAL REFERENCE CAUSES AN OUTPUT  *
* RECORD CONTAINING THE SOURCE PROGRAM MEMBER NAME, CSECT NAME IN    *
* WHICH THE REFERENCE OCCURRED, TYPE OF REFERENCE (CALL, LINK, ETC), *
* AND NAME OF THE EXTERNAL REFERENCE.                                *
* AUTHOR R THORNTON NOV 1996                                         *
**********************************************************************
         OPEN  (PRINT1,OUTPUT,READER1) OPEN FILES
         CALL  READMEM,OPEN            OPEN PDS FOR INPUT
**********************************************************************
* EXECRTN: READ THE READER1 FILE TO GET THE NEXT MEMBER NAME TO BE   *
* PROCESSED. CALL THE READMEM ROUTINE TO FIND THE MEMBER, THEN THE   *
* MAINLINE ROUTINE TO PROCESS IT. AT END OF FILE ON READER1 GO TO    *
* END OF JOB.                                                        *
**********************************************************************
EXECRTN  GET   READER1,MEMRECD         READ NEXT MEMBER RECORD
         MVC   MEMBER,MEMNAME          COPY MEMBER NAME
         MVC   FINDNAME,MEMBER         MEMBER NAME TO PARM LIST
         CALL  READMEM,FIND            GO FIND MEMBER
         CLI   FINDNAME,0              MEMBER FOUND?
         BE    EXECRTN                 NO
**********************************************************************
* MAINLINE: READ INPUT SOURCE PROGRAM TO EXHAUSTION. FOR EACH INPUT  *
* RECORD, CALL SCAN ROUTINE TO IDENTIFY ANY EXTERNAL REFERENCES. IF  *
* ANY EXTERNAL REFERENCES ARE FOUND, CALL THE PRINT ROUTINE TO WRITE *
* AN OUTPUT RECORD.                                                  *
**********************************************************************
MAINLINE L     R9,ML9                  GET RETURN ADDRESS
READMEM  CALL  READMEM,(READ,RECORD)   READ NEXT RECORD
         CLI   RECORD,X'FF'            END OF MEMBER?
         BE    MLXIT                   YES, RETURN TO CALLER
         CLI   RECORD,C'*'             COMMENT RECORD?
         BE    READMEM                 YES, SKIP IT
         BAL   R9,SCANEXT              GO SCAN FOR EXTERNAL REFERENCES
         CLI   EXTFND,0                ANY EXTERNAL REFERENCE FOUND?
         BE    READMEM                 NO
         BAL   R9,PRINT                YES, GO WRITE AN OUTPUT RECORD
         B     READMEM                 AND CONTINUE
MLXIT    L     R9,ML9                  GET RETURN ADDRESS
         BR    R9                      RETURN TO CALLER
**********************************************************************
* EOJ: END OF JOB ROUTINE ENTERED AT END OF FILE ON INPUT. CLOSE     *
* FILES AND RETURN TO CALLER.                                        *
**********************************************************************
EOJ      CLOSE (READER1,,PRINT1)       CLOSE FILES
         L     R13,4(R13)              POINT TO CALLER'S SAVE AREA
         LM    R14,R12,12(R13)         RESTORE CALLER'S REGS
         SR    R15,R15                 CLEAR RETURN CODE TO 0
         BR    R14                     RETURN TO CALLER
*********************************************************************
* SCAN INPUT RECORD FOR CSECTS AND EXTERNAL REFERENCES. WHEN A CSECT*
* IS FOUND, SAVE ITS NAME IN THE CSECT OUTPUT RECORD FIELD. WHEN AN *
* EXTERNAL REFERENCE IS FOUND, SET THE EXTFND SWITCH AND PUT THE    *
* REFERENCED NAME IN THE EXTNAME FIELD OF THE OUTPUT RECORD.        *
*********************************************************************
SCANEXT  ST    R9,SE9                  SAVE RETURN ADDRESS
         MVI   EXTFND,0                CLEAR THE EXTERNAL REF FOUND SW
         LA    R1,RECORD               POINT TO THE INPUT RECORD
         CLI   CONTSW,1                WORKING ON A CONTINUATION?
         BNE   NOTCONT                 NO
         MVI   CONTSW,0                RESET SWITCH
         CLC   RECORD(15),BLANKS       COLS 1-15 BLANK?
         BNE   NOTCONT                 NO, IGNORE
         CLI   RECORD+15,C' '          COL 16 BLANK?
         BE    NOTCONT                 YES, IGNORE
         CLC   MACRO,BLANKS            ANY STORED MACRO?
         BE    NOTCONT                 NO
         CLC   MACRO(5),=CL5'EXEC '    IN AN EXEC MACRO?
         BNE   NOTEXEC                 NO
         CLC   CICSOPND,=C'CICS'       GOT CICS OPERAND YET?
         BE    CKCICSOP                NO, GO LOOK FOR OPERAND
         BAL   R9,FINDPROG             YES, GO GET PROGRAM NAME
         B     SCANEXIT                THEN RETURN
NOTEXEC  BAL   R9,FINDEP               GO LOOK FOR EP= OPERAND
         B     SCANEXIT                AND THEN RETURN
NOTCONT  MVC   UNIQUE,BLANKS           CLEAR ANY UNIQUE FIELDS
         CLI   CONTCOL,C' '            THIS RECORD CONTINUED?
         BE    GETMACR                 NO
         MVI   CONTSW,1                YES, SET SWITCH
GETMACR  TRT   0(80,R1),SCANBLNK       FIND FIRST BLANK
         BZ    SCANEXIT                NONE FOUND, EXIT
         C     R1,ENDREC               FOUND PAST END OF RECORD?
         BH    SCANEXIT                YES
         TRT   1(80,R1),SCANONBK       SCAN FOR NON-BLANK
         BZ    SCANEXIT                NONE FOUND, EXIT
         C     R1,ENDREC               FOUND PAST END OF RECORD?
         BH    SCANEXIT                YES
         CLC   0(6,R1),=CL6'CSECT '    THIS A CSECT?
         BNE   TESTMACR                NO
         MVC   CSECT,RECORD            YES, MOVE NAME TO OUTPUT RECORD
         B     SCANEXIT                AND EXIT
TESTMACR CLC   0(5,R1),=CL5'EXEC '     EXEC MACRO?
         BE    EXECMAC                 YES
         CLC   0(5,R1),=CL5'LINK'      LINK MACRO?
         BE    LINKMAC                 YES
         CLC   0(5,R1),=CL5'LOAD'      LOAD MACRO?
         BE    LOADMAC                 YES
         CLC   0(5,R1),=CL5'XCTL'      XCTL MACRO?
         BE    XCTLMAC                 YES
         CLC   0(7,R1),=CL7'ATTACH'    ATTACH MACRO?
         BE    ATCHMAC                 YES
         CLC   0(5,R1),=CL5'CALL'      CALL MACRO?
         BNE   SCANEXIT                NO, IGNORE THE RECORD
         MVC   MACRO(4),0(R1)          MACRO NAME TO OUTPUT RECORD
         LA    R1,4(R1)                STEP PAST "CALL"
         TRT   1(80,R1),SCANONBK       FIND NEXT NON BLANK
         C     R1,ENDREC               FOUND WITHIN RECORD?
         BH    SCANEXIT                NO
         MVC   EXTREF,0(R1)            MOVE PROGRAM NAME TO OUTPUT
         MVC   SEQNO,SEQNCE            MOVE SEQUENCE NUMBER TO OUTPUT
         MVI   EXTFND,1                INDICATE EXTREF FOUND
         B     SCANEXIT                EXIT TO CALLER
ATCHMAC  MVC   MACRO,0(R1)             MOVE MACRO TO OUTPUT RECORD
         MVC   SEQNO,SEQNCE            MOVE SEQUENCE NUMBER TO OUTPUT
LINKMAC  DS    0H
LOADMAC  DS    0H
XCTLMAC  DS    0H
         MVC   MACRO(4),0(R1)          MOVE MACRO TO OUTPUT RECORD
         MVC   SEQNO,SEQNCE            MOVE SEQUENCE NUMBER TO OUTPUT
         BAL   R9,FINDEP               GO SEARCH FOR EP=
         B     SCANEXIT                EXIT TO CALLER
EXECMAC  MVC   MACRO(4),0(R1)          MOVE MACRO TO OUTPUT RECORD
         MVC   SEQNO,SEQNCE            MOVE SEQUENCE NUMBER TO OUTPUT
         LA    R1,4(R1)                STEP PAST "EXEC"
         TRT   1(80,R1),SCANONBK       FIND NEXT NON BLANK
         C     R1,ENDREC               FOUND WITHIN RECORD?
         BH    SCANEXIT                NO
         CLC   0(5,R1),=CL5'CICS'      IS IT A CICS EXEC MACRO?
         BNE   CLRUNIQ                 NO
         MVC   CICSOPND,0(R1)          MOVE CICS OPERAND
         MVC   SEQNO,SEQNCE            MOVE SEQUENCE NUMBER TO OUTPUT
GOTCICS  LA    R1,4(R1)                STEP PAST "CICS"
         TRT   1(80,R1),SCANONBK       FIND NEXT NON BLANK
         C     R1,ENDREC               FOUND WITHIN RECORD?
         BH    CLRUNIQ                 NO
CKCICSOP CLC   0(5,R1),=CL5'EXEC '     EXEC MACRO?
         BE    GETPROG                 YES
         CLC   0(5,R1),=CL5'LINK'      LINK MACRO?
         BE    GETPROG                 YES
         CLC   0(5,R1),=CL5'LOAD'      LOAD MACRO?
         BE    GETPROG                 YES
         CLC   0(5,R1),=CL5'XCTL'      XCTL MACRO?
         BNE   CLRUNIQ                 YES
GETPROG  MVC   CICSOPND,0(R1)          SAVE EXEC CICS OPERAND
         MVC   SEQNO,SEQNCE            MOVE SEQUENCE NUMBER TO OUTPUT
         BAL   R9,FINDPROG             GO FIND PROGRAM NAME
         B     SCANEXIT                AND RETURN TO CALLER
CLRUNIQ  MVC   UNIQUE,BLANKS           NO, CLEAR UNIQUE FIELDS
SCANEXIT L     R9,SE9                  GET RETURN ADDRESS
         BR    R9                      RETURN TO CALLER
**********************************************************************
* FINDEP: FIND THE EP= OPERAND. IF FOUND, MOVE THE NAME TO THE OUTPUT*
* RECORD EXTREF FIELD AND SET THE EXTFND SWITCH. IF THIS IS NOT      *
* CONTINUED, SET EXTFND ANYWAY SO IT CAN BE RESEARCHED.              *
**********************************************************************
FINDEP   CLI   CONTCOL,C' '            THIS STATEMENT CONTINUED?
         BNE   EPCKND                  YES
         MVI   EXTFND,1                NO, FORCE AN OUTPUT RECORD
EPCKND   C     R1,ENDREC               PAST END OR INPUT RECORD?
         BH    FEEXIT                  YES
         CLC   0(3,R1),=CL3'EP='       FOUND THE EP= PARAMETER?
         BE    GOTEP                   YES
         LA    R1,1(R1)                NO, STEP TO NEXT COLUMN
         B     EPCKND                  CONTINUE SEARCH
GOTEP    MVC   EXTREF,3(R1)            MOVE EXTREF NAME
         MVC   SEQNO,SEQNCE            MOVE SEQUENCE NUMBER TO OUTPUT
         MVI   EXTFND,1                SET EXT REF FOUND SWITCH
FEEXIT   BR    R9                      RETURN TO CALLER
**********************************************************************
* FINDPROG: FIND THE PROGRAM('......') FIELD. IF FOUND, MOVE THE NAME*
* TO THE OUTPUT RECORD EXTREF FIELD AND SET THE EXTFND SWITCH. IF    *
* THIS STATEMENT IS NOT CONTINUED, SET THE EXTFND SWITCH SO THE      *
* STATEMENT CAN BE RESEARCHED.
**********************************************************************
FINDPROG CLI   CONTCOL,C' '            THIS STATEMENT CONTINUED?
         BNE   PGCKND                  YES
         MVI   EXTFND,1                NO, FORCE AN OUTPUT RECORD
PGCKND   C     R1,ENDREC               PAST END OR INPUT RECORD?
         BH    PGEXIT                  YES
         CLC   0(8,R1),=CL8'PROGRAM('  FOUND THE PROGRAM PARM?
         BE    GOTPG                   YES
         LA    R1,1(R1)                NO, STEP TO NEXT COLUMN
         B     PGCKND                  CONTINUE SEARCH
GOTPG    CLI   8(R1),C''''             QUOTED NAME?
         BE    GOTPG1                  YES
         MVC   EXTREF,8(R1)            NO
         B     PGSETSEQ
GOTPG1   MVC   EXTREF,9(R1)            MOVE EXTREF NAME
PGSETSEQ MVC   SEQNO,SEQNCE            MOVE SEQUENCE NUMBER TO OUTPUT
         MVI   EXTFND,1                SET EXT REF FOUND SWITCH
PGEXIT   BR    R9                      RETURN TO CALLER
**********************************************************************
* PRINT (WRITE) THE CURRENT OUTPUT RECORD AND CLEAR THE UNIQUE FIELDS*
* THE EXTREF FIELD IS PURIFIED FROM TRAILING GARBAGE.                *
**********************************************************************
PRINT    LA    R1,EXTREF               POINT TO EXTREF FIELD
         TRT   0(8,R1),INVCHR          SCAN FOR INVALID CHARS.
         BZ    PRINTIT                 NONE FOUND
PCKND    C     R1,EXRFND               PAST FIELD END?
         BH    PRINTIT                 YES, ALL THRU
         MVI   0(R1),C' '              NO, CLEAR GARBAGE
         LA    R1,1(R1)                STEP TO NEXT
         B     PCKND                   LOOP TO CLEAR TRASH
PRINTIT  PUT   PRINT1,PRINTREC         WRITE THE OUTPUT RECORD
         MVC   UNIQUE,BLANKS           CLEAR UNIQUE FIELDS
         BR    R9                      RETURN TO CALLER
**********************************************************************
* WORKING STORAGE AND FILES                                          *
**********************************************************************
BLANKS   DC    CL80' '                 BLANKS
*
MEMRECD  DS    0CL80                   MEMBER RECORD
MEMNAME  DS    CL8                     MEMBER NAME
         DS    CL72
*
OPEN     DC    CL9'OINPUT1'            OPEN PARAMETER
READ     DC    C'R'                    READ PARAMETER
CLOSE    DC    C'C'                    CLOSE PARAMETER
*
FIND     DS    0CL5                    FIND PARAMETER
         DC    C'FN'                   FIND BY NAME
FINDNAME DS    XL3                     MEMBER NAME TO FIND
*
PRINTREC DS    0CL80                   OUTPUT RECORD
MEMBER   DC    CL8' '                  MEMBER NAME
         DC    CL1' '
CSECT    DC    CL8' '                  CSECT NAME
UNIQUE   DS    0CL63                   UNIQUE FIELDS
         DC    CL1' '
MACRO    DC    CL6' '                  MACRO NAME
         DC    CL1' '
CICSOPND DC    CL4' '                  CICS MACRO OPERAND
         DC    CL1' '
EXTREF   DC    CL8' '                  EXTERNAL REFERENCE NAME
         DC    CL1' '
SEQNO    DC    CL8' '                  INPUT SEQUENCE NUMBER
         DC    CL33' '
*
RECORD   DS    0CL80                   INPUT RECORD
         DS    CL71                    BODY OF RECORD (COL 1-71)
CONTCOL  DS    CL1                     CONTINUATION COLUMN
SEQNCE   DS    CL8                     SEQUENCE NUMBER
*
EXTFND   DC    XL1'00'                 EXTERNAL REFERENCE FOUND SWITCH
CONTSW   DC    XL1'00'                 CONTINUED INPUT SWITCH
SE9      DS    A                       RETURN ADDRESS FOR SCANEXT
ML9      DS    A                       RETURN ADDRESS FOR MAINLINE
ENDREC   DC    A(RECORD+79)            END OF INPUT RECORD ADDRESS
EXRFND   DC    A(EXTREF+7)             END OF EXTREF FIELD
SCANBLNK DC    256X'00'                TRT TABLE TO SCAN FOR BLANKS
         ORG   SCANBLNK+C' '
         DC    X'FF'
         ORG
SCANONBK DC    256X'FF'                TRT TABLE TO SCAN FOR NON-BLANKS
         ORG   SCANONBK+C' '
         DC    X'00'
         ORG
INVCHR   DC    256X'FF'                SCAN TBL FOR INVALID LABEL CHARS
         ORG   INVCHR+C' '
         DC    X'00'
         ORG   INVCHR+C'A'
         DC    9X'00'
         ORG   INVCHR+C'J'
         DC    9X'00'
         ORG   INVCHR+C'S'
         DC    8X'00'
         ORG   INVCHR+C'0'
         DC    10X'00'
         ORG
READER1  DCB   DSORG=PS,MACRF=GM,DDNAME=READER1,EODAD=EOJ,             X
               RECFM=FB,LRECL=80
PRINT1   DCB   DSORG=PS,MACRF=PM,DDNAME=PRINT1,                        X
               RECFM=FB,LRECL=80
         END
