**********************************************************************
*                                                                    *
*  THIS PROGRAM WRITTEN BY PAUL EDWARDS.                             *
*  RELEASED TO THE PUBLIC DOMAIN                                     *
*                                                                    *
**********************************************************************
**********************************************************************
*                                                                    *
*  MUSSTART - startup routines for MUSIC/SP                          *
*  It is currently coded to work with GCC.                           *
*                                                                    *
**********************************************************************
*
         COPY  PDPTOP
*
         PRINT GEN
* YREGS IS NOT AVAILABLE WITH IFOX
*         YREGS
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
SUBPOOL  EQU   0
         CSECT
*
* Put an eyecatcher here to ensure program has been linked
* correctly.
         DC    C'PDPCLIB!'
*
         ENTRY $CSTART
$CSTART  DS    0H
         ENTRY @@CRT0
@@CRT0   DS    0H
         SAVE  (14,12),,@@CRT0
         LR    R10,R15
         USING @@CRT0,R10
         LR    R11,R1
         GETMAIN RU,LV=STACKLEN,SP=SUBPOOL
         ST    R13,4(R1)
         ST    R1,8(R13)
         LR    R13,R1
         LR    R1,R11
         USING STACK,R13
*
         LA    R1,0(R1)          Clean up address (is this required?)
*
         LA    R2,0
         ST    R2,DUMMYPTR       WHO KNOWS WHAT THIS IS USED FOR
         LA    R2,MAINSTK
         ST    R2,THEIRSTK       NEXT AVAILABLE SPOT IN STACK
         LA    R12,ANCHOR
         ST    R14,EXITADDR
         L     R3,=A(MAINLEN)
         AR    R2,R3
         ST    R2,12(R12)        TOP OF STACK POINTER
         LA    R2,0
         ST    R2,116(R12)       ADDR OF MEMORY ALLOCATION ROUTINE
         ST    R2,ARGPTR
*
         USING PSA,R0
         L     R2,PSATOLD
         USING TCB,R2
         L     R7,TCBRBP
         USING RBBASIC,R7
         LA    R8,0
         ICM   R8,B'0111',RBCDE1
         USING CDENTRY,R8
         MVC   PGMNAME,CDNAME
*
         L     R2,TCBJSCB
         USING IEZJSCB,R2
         LH    R2,JSCBTJID
         ST    R2,TYPE
         L     R2,0(R1)
         LA    R2,0(R2)
         ST    R2,ARGPTR
         LA    R2,PGMNAME
         ST    R2,PGMNPTR
*
* FOR GCC WE NEED TO BE ABLE TO RESTORE R13
         LA    R5,SAVEAREA
         ST    R5,SAVER13
*
         LA    R1,PARMLIST
*
         AIF   ('&ZSYS' NE 'S380').N380ST1
*
* Set R4 to true if we were called in 31-bit mode
*
         LA    R4,0
         BSM   R4,R0
         ST    R4,SAVER4
* If we were called in AMODE 31, don't bother setting mode now
         LTR   R4,R4
         BNZ   IN31
         CALL  @@SETM31
IN31     DS    0H
.N380ST1 ANOP
*
* Watcom needs $$START
*         CALL  $$START
         CALL  @@START
*
         AIF   ('&ZSYS' NE 'S380').N380ST2
* If we were called in AMODE 31, don't switch back to 24-bit
         LTR   R4,R4
         BNZ   IN31B
         CALL  @@SETM24
IN31B    DS    0H
.N380ST2 ANOP
*
RETURNMS DS    0H
         LR    R1,R13
         L     R13,SAVEAREA+4
         LR    R14,R15
         FREEMAIN RU,LV=STACKLEN,A=(R1),SP=SUBPOOL
         LR    R15,R14
         RETURN (14,12),RC=(15)
SAVER4   DS    F
SAVER13  DS    F
         LTORG
         DS    0H
*         ENTRY CEESG003
*CEESG003 DS    0H
         ENTRY $$EXITA
$$EXITA  DS    0H
         ENTRY @@EXITA
@@EXITA  DS    0H
* SWITCH BACK TO OUR OLD SAVE AREA
         LR    R10,R15
         USING @@EXITA,R10
         L     R9,0(R1)
         L     R13,=A(SAVER13)
         L     R13,0(R13)
*
         AIF   ('&ZSYS' NE 'S380').N380ST3
         L     R4,=A(SAVER4)
         L     R4,0(R4)
* If we were called in AMODE 31, don't switch back to 24-bit
         LTR   R4,R4
         BNZ   IN31C
         CALL  @@SETM24
IN31C    DS    0H
.N380ST3 ANOP
*
         LR    R1,R13
         L     R13,4(R13)
         LR    R14,R9
         FREEMAIN RU,LV=STACKLEN,A=(R1),SP=SUBPOOL
         LR    R15,R14
         RETURN (14,12),RC=(15)
         LTORG
*
         AIF   ('&OS' EQ 'MUSIC').MUSIC1
*         CVT   DSECT=YES
.MUSIC1  ANOP
         IKJTCB
         IEZJSCB
         IHAPSA
         IHARB
         IHACDE
STACK    DSECT
SAVEAREA DS    18F
DUMMYPTR DS    F
THEIRSTK DS    F
PARMLIST DS    0F
ARGPTR   DS    F
PGMNPTR  DS    F
TYPE     DS    F
PGMNAME  DS    CL8
PGMNAMEN DS    C                 NUL BYTE FOR C
ANCHOR   DS    0F
EXITADDR DS    F
         DS    49F
MAINSTK  DS    65536F
MAINLEN  EQU   *-MAINSTK
STACKLEN EQU   *-STACK
         END
