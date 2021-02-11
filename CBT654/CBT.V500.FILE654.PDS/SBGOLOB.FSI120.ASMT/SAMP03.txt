SAMP03   CSECT ,
         SAVE  (14,12),,*
*
         LR    R12,R15
         USING SAMP03,R12
*
         LA    R11,SAVEA
         ST    R13,4(,R11)
         ST    R11,8(,R13)
         LR    R13,R11
*
*
         $VDEF ('PF03',PFK03,2,8,0)
*
         $VDEF ('PF15',PFK15,2,8,0)
*
         $VDEF ('PF01',PFK01,2,8,0)
*
         $VDEF ('PF13',PFK13,2,8,0)
*
         $VDEF ('PF04',PFK04,2,8,0)
*
         $VDEF ('PF16',PFK16,2,8,0)
*
         $VDEF ('ZCMD',ZCMD,2,50,0)
*
         $VDEF ('NUMBER',NUMBER,1,4,0)
*
*
*/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z
*
*
LOOP     DS    0H
*
         $DISPLAY ('SAMP03A',MSGID)
*
         MVC   MSGID,=CL8' '
*
         OC    ZCMD,=CL50' '
         CLC   =C'END ',ZCMD
         BE    EXIT
*
*
         CLC   =C'X ',ZCMD
         BE    EXIT
*
         B     LOOP
*
*
*/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z/Z
*
*
EXIT     DS    0H
*
         L     R13,4(,R13)
         LM    R14,R12,12(R13)
         SLR   R15,R15
         BR    R14
*
*
ZCMD     DC    CL50' '
*
*
         LTORG ,
*
*
MSGID    DC    CL8' '
PFK01    DC    CL8'HELP    '
PFK13    DC    CL8'HELP    '
PFK03    DC    CL8'END     '
PFK15    DC    CL8'END     '
PFK04    DC    CL8'RETN    '
PFK16    DC    CL8'RETN    '
NUMBER   DC    F'0'
*
*
SAVEA    DC    18F'0'
*
*
R0       EQU   0
R1       EQU   1
R2       EQU   2
R3       EQU   3
R4       EQU   4
R5       EQU   5
R6       EQU   6
R7       EQU   7
R8       EQU   8
R9       EQU   9
R10      EQU   10
R11      EQU   11
R12      EQU   12
R13      EQU   13
R14      EQU   14
R15      EQU   15
*
*
         END   ,
