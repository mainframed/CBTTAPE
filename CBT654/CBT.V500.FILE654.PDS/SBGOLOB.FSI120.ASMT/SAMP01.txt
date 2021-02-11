SAMP01   CSECT ,
         SAVE  (14,12),,*
*
         LR    R12,R15
         USING SAMP01,R12
*
         LA    R11,SAVEA
         ST    R13,4(,R11)
         ST    R11,8(,R13)
         LR    R13,R11
*
*
         $VDEF ('PF03',PF03,2,8,0)
*
         $VDEF ('PF15',PF15,2,8,0)
*
*
         $VDEF ('ZSTAT',ZSTAT,2,2,0)
*
         $VDEF ('USERID',USERID,2,8,0)
*
         $VDEF ('PASSWD',PASSWD,2,8,0)
*
         $VDEF ('ZCMD',ZCMD,2,50,0)
*
         $VDEF ('HITS',HITS,1,4,0)
*
*/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z
*
         XC    ERRSTAT,ERRSTAT
LOGIN    DS    0H
         MVC   ERRSTAT1,ERRSTAT
         XC    ERRSTAT,ERRSTAT
*
         $DISPLAY ('SAMP01A',MSGID,CSRFLD)
*
         L     R1,HITS
         LA    R1,1(,R1)
         ST    R1,HITS
*
         MVC   MSGID,=CL8' '
         MVC   CSRFLD,=CL8' '
*
*
         OC    ZCMD,=CL50' '
         CLC   =C'END ',ZCMD
         BE    GOOD900
*
*
         CLC   =CL8' ',USERID
         BE    LOG010
*
         OC    PASSWD,=CL8' '
         CLC   =CL8'SECRET',PASSWD
         BNE   LOG020
*
         B     GOOD010
*
*
LOG010   DS    0H
         MVI   ERRSTAT,C'U'
         CLI   ERRSTAT1,C'U'
         BE    LOG015
*
         MVC   MSGID,=CL8'SAMP0101'
         B     LOGIN
*
*
LOG015   DS    0H
         MVC   MSGID,=CL8'SAMP0102'
         B     LOGIN
*
*
LOG020   DS    0H
         MVC   PASSWD,=CL8' '
*
         MVI   ERRSTAT,C'P'
         CLI   ERRSTAT1,C'P'
         BE    LOG025
*
         MVC   MSGID,=CL8'SAMP0103'
         MVC   CSRFLD,=CL8'PASSWD'
         B     LOGIN
*
*
LOG025   DS    0H
         MVC   MSGID,=CL8'SAMP0104'
         MVC   CSRFLD,=CL8'PASSWD'
         B     LOGIN
*
*
*
*/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z
*
*
GOOD010  DS    0H
*
GOOD020  DS    0H
         $DISPLAY ('SAMP01B',MSGID,CSRFLD)
*
         L     R1,HITS
         LA    R1,1(,R1)
         ST    R1,HITS
*
         MVC   MSGID,=CL8' '
         MVC   CSRFLD,=CL8' '
*
         OC    ZCMD,=CL50' '
         CLC   =C'END ',ZCMD
         BE    GOOD900
*
         MVC   MSGID,=CL8'SAMP0105'
         B     GOOD020
*
*
GOOD900  DS    0H
         TPUT  HELLOMSG,HELLOLEN
*
*
          L     R13,4(,R13)
          LM    R14,R12,12(R13)
          SLR   R15,R15
          BR    R14
*
*
*
*
*
*
*
PDSMBR   DC    CL8'TEST01'
CSRFLD   DC    CL8' '
*
*
MSGID    DC    CL8' '
*
*
*
*
HITS     DC    F'0'
*
PF03     DC    CL8'END'
PF15     DC    CL8'END'
ZSTAT    DC    CL2'OK'
USERID   DC    CL8' '
PASSWD   DC    CL8' '
ZCMD     DC    CL50' '
*
*
ERRSTAT  DC    C' '
ERRSTAT1 DC    C' '
*
*
         DS    0H
HELLOMSG DC    C'THE USERID=<'
HELLOUSR DC    CL8' ',C'> PASSWORD=<'
HELLOPWD DC    CL8' ',C'>'
HELLOLEN EQU   *-HELLOMSG
*
*
          LTORG ,
*
*
SAVEA     DC    18F'0'
*
*
*
*
R0        EQU   0
R1        EQU   1
R2        EQU   2
R3        EQU   3
R4        EQU   4
R5        EQU   5
R6        EQU   6
R7        EQU   7
R8        EQU   8
R9        EQU   9
R10       EQU   10
R11       EQU   11
R12       EQU   12
R13       EQU   13
R14       EQU   14
R15       EQU   15
*
*
          END   ,
