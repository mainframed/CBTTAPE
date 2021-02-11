         TITLE ' READMEM - SUBROUTINE TO READ MEMBER OF PDS'
READMEM  CSECT
         REQU
* SUBROUTINE TO FIND, READ, AND PASS RECORDS FOR THE MEMBER
* OF A PDS TO THE CALLING PROGRAM. STANDARD LINKAGE CONVENTIONS ARE USE
* WITH THE FOLLOWING PARAMETER REQUIREMENTS -
* OPEN - FIRST POSITION IS O, NEXT 8 ARE DDNAME
* FIND - FIRST POSITION IS F, NEXT IS T IF TTR IS SUPPLIED, OR N IF
*        NAME IS SUPPLIED, NEXT 3 ARE TTR OF BEGINNING OF MEMBER FOR
*        T REQUESTS, OR NEXT 8 ARE MEMBER NAME IF N IS REQUESTED.
* READ - FIRST PARAMETER IS R. SECOND PARAMETER IS RECORD WORK AREA
*        ADDRESS. RECORDS MAY BE FIXED OR VARIABLE AND ARE MOVED TO
*        THE CALLER'S RECORD WORK AREA.
* CLOSE - FIRST PARAMETER IS C.
* EOF - END OF FILE IS INDICATED BY RETURNING A HEX STRING CONTAINING
*       X'FFFEFDFCFDFEFF' BEGINNING IN THE FIRST POSITION OF THE
*       RECORD WORK AREA. THIS MINIMIZES INCORRECT DETECTION OF EOF
*       DUE TO DATA FOUND IN AN INPUT RECORD.
*
* AUTHOR R THORNTON, APR 1972.
*
*********************************************************************
*   SUBROUTINE READMEM     PROJECT  965294     4/28/97
*   THIS SUBROUTINE HAS BEEN ANALYZED BY CGA AND DETERMINED TO CONTAIN
*   NO DATES AND TO BE Y2000 COMPLIANT.  THEREFORE, THE CDC CORE TEAM
*   HAS CONCLUDED NO CHANGES ARE NECESSARY.  IT WILL REMAIN UNDER
*   BCBS01/COMMON/COMMON ON ENDEVOR.
**********************************************************************
         USING READMEM,R3              ESTABLIST ADDRESSABILITY
         STM   R14,R12,12(R13)         SAVE CALLING PROG REGISTERS
         LR    R3,R15                  INITIALIZE BASE REG
         ST    R13,SAVE+4              SAVE RETURN POINTER
         LA    R15,SAVE                GET SAVE AREA ADDR
         ST    R15,8(R13)              STORE FORWARD POINTER
         LR    R13,R15                 INITIALIZE SAVE AREA POINTER
         L     R4,0(R1)                GET FIRST PARAMETER ADDRESS
         L     R5,4(R1)                GET SECOND PARAMETER ADDRESS
         CLI   0(R4),C'O'              OPEN REQUESTED
         BE    OPEN                    YES
         CLI   0(R4),C'F'              FIND MEMBER REQUESTED
         BE    FIND                    YES
         CLI   0(R4),C'R'              READ REQUESTED
         BE    READ                    YES
         CLI   0(R4),C'C'              CLOSE REQUESTED
         BE    CLOSE                   YES
INVPRM   ABEND 201,DUMP                INVALID PARAMETER
RETURN   L     R13,SAVE+4              GET RETURN POINTER
         LM    R14,R12,12(R13)         RESTORE CALLING PROGRAM REGISTER
         SR    R15,R15                 CLEAR RETURN CODE TO 0
         BR    R14                     RETURN TO CALLER
*
*
*
OPEN     EQU   *             *** OPEN FILE ROUTINE ***
         MVC   PDS+40(8),1(R4)         MOVE DDNAME TO DCB
         OPEN  PDS                     OPEN FILE FOR INPUT
         LH    R12,PDS+62              GET BLOCKSIZE
         GETMAIN EU,LV=(R12),A=BLKADDR GET STORAGE FOR BLOCK
         L     R1,4(R13)               POINTER TO CALLER'S SAVE
         LA    R12,PDS                 @ DCB
         LA    R12,0(R12)              CLEAR HI-ORDER
         ST    R12,24(R1)              SAVE DCB @ IN REG 1 FOR CALLER
         MVC   LRECL,PDS+82            SAVE LRECL
         B     RETURN                  GO BACK TO CALLER
*
*
*
CLOSE    EQU   *             *** CLOSE FILE ROUTINE ***
         LH    R12,PDS+62              GET BLOCKSIZE
         FREEMAIN EU,LV=(R12),A=BLKADDR FREE GOTTEN STORAGE
         CLOSE PDS                     CLOSE FILE
         STH   R0,REMBYTS              RESET REMAINING BLOCK COUNT
         FREEPOOL PDS                  FREE THE BUFFER
         B     RETURN                  GO BACK TO CALLER
*
*
*
FIND     EQU   *             *** FIND MEMBER ***
         SR    R0,R0                   SET R0 TO ZERO
         STH   R0,REMBYTS              SET REMAINING BLOCK COUNT
         CLI   1(R4),C'N'              FIND IS FOR NAME
         BE    FINDNAME                YES
         CLI   1(R4),C'T'              FIND IS FOR TTR
         BNE   INVPRM                  NO, ERROR
         MVC   RELTTR,2(R4)            MOVE TTR FOR FIND
         FIND  PDS,RELTTR,C            FIND MEMBER BY TTR
         B     RETURN                  GO BACK TO CALLER
FINDNAME MVC   MEMBER,2(R4)            MOVE MEMBER NAME FOR FIND
         FIND  PDS,MEMBER,D            FIND MEMBER BY NAME
         LTR   R15,R15                 ANY ERROR
         BZ    RETURN                  NO, RETURN TO CALLER
         MVI   2(R4),0                 INDICATE NOT FOUND
         B     RETURN                  GO BACK TO CALLER
*
*
*
READ     EQU   *             *** READ MEMBER RECORD ***
         LH    R12,REMBYTS             GET NBR BYTES REMAINING IN BLOCK
         LTR   R12,R12                 ANY DATA LEFT IN BLOCK
         BP    SAMBLK                  YES
         L     R12,BLKADDR             GET BLOCK ADDRESS
         READ  INDECB,SF,PDS,(R12),'S' READ NEXT BLOCK
         CHECK INDECB                  WAIT FOR COMPLETION
         L     R12,PDS+68              GET IOB PREFIX ADDRESS
         MVC   REMBYTS,22(R12)         RESIDUAL COUNT FROM IOB CSW
         LH    R12,PDS+62              BLOCKSIZE FROM DCB
         SH    R12,REMBYTS             RECORD LEN=BLKSIZE-RESID CT
         STH   R12,REMBYTS             STORE CALCULATED RECORD LENGTH
         MVC   NEXREC,BLKADDR          MOVE BLOCK ADDRESS
         TM    PDS+36,X'80'            FIXED LENGTH RECORDS?
         BO    SAMBLK                  YES
         TM    PDS+36,X'10'            BLOCKED RECORDS?
         BZ    SAMBLK                  NO
         L     R1,NEXREC               NO, GET BLOCK ADDRESS
         LH    R2,0(R1)                PICK UP BLOCK LENGTH
         SH    R2,=H'4'                DEDUCT BDW LENGTH
         STH   R2,REMBYTS              SAVE BYTES REMAINING IN BLOCK
         LA    R1,4(R1)                STEP PAST BDW
         ST    R1,NEXREC               SAVE NEXT RECORD ADDRESS
SAMBLK   TM    PDS+36,X'80'            FIXED SIZED RECORDS?
         BO    GETBYTS                 YES
         L     R1,NEXREC               GET RECORD ADDR
         MVC   LRECL,0(R1)             SET RECORD LENGTH
GETBYTS  LH    R12,REMBYTS             GET NBR BYTES REMAINING
         SH    R12,LRECL               SUBTRACT RECORD LENGTH
         STH   R12,REMBYTS             STORE REMAINING BYTES IN BLOCK
         L     R12,NEXREC              GET NEXT RECORD ADDRESS
         LH    R1,LRECL                GET LRECL
CKLEFT   CH    R1,=H'256'              < 256 BYTES LEFT?
         BL    LASTMV                  YES
         MVC   0(256,R5),0(R12)        NO, MOVE 256 BYTES
         LA    R12,256(R12)            TO NEXT RECORD LOC
         LA    R5,256(R5)              TO NEXT USER LOC
         SH    R1,=H'256'              DEDUCT BYTES MOVED
         BZ    SAVNEX                  NO MORE, ALL THRU
         B     CKLEFT                  CONTINUE MOVE
LASTMV   BCTR  R1,0                    DEDUCT 1 FOR MOVE LENGTH
         EX    R1,LSTMOV               MOVE LAST BYTES
         LA    R12,1(R1,R12)           COMPUTE NEXT RECD ADDR
SAVNEX   ST    R12,NEXREC              STORE UPDATED RECORD ADDRESS
         B     RETURN                  GO BACK TO CALLER
LSTMOV   MVC   0(1,R5),0(R12)          EXECUTED MOVE
*
*
*
EOF      EQU   *             *** END OF FILE ROUTINE ***
         MVC   0(7,R5),EOFSTRG         INDICATE EOF TO CALLER
         B     RETURN                  GO BACK TO CALLER
*
*
*
*                            *** DATA AND FILE AREAS ***
*
EOFSTRG  DC    XL7'FFFEFDFCFDFEFF'
SAVE     DS    18F
BLKADDR  DS    F
REMBYTS  DC    H'0'
LRECL    DS    H
NEXREC   DS    F
RELTTR   DS    CL3
         DC    X'00'
MEMBER   DS    CL8
*
*
*
PDS      DCB   DDNAME=PDS,DSORG=PO,MACRF=R,EODAD=EOF
         END
