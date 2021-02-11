**********************************************************************
*                                                                    *
*  THIS PROGRAM WRITTEN BY PAUL EDWARDS.                             *
*  RELEASED TO THE PUBLIC DOMAIN                                     *
*                                                                    *
**********************************************************************
**********************************************************************
*                                                                    *
*  MTSSTART - STARTUP ROUTINES FOR MTS FOR USE WITH GCC.             *
*                                                                    *
**********************************************************************
         COPY  PDPTOP
.NOMODE ANOP
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
* We comment this out for now, while waiting for the
* proper @@MAIN entry point to become active
         DC    C'PDPCLIB!'
         ENTRY @@CRT0
@@CRT0   DS    0H
*         ENTRY CEESTART
*CEESTART DS    0H
         SAVE  (14,12),,@@CRT0
         LR    R10,R15
         USING @@CRT0,R10
         LR    R11,R1            save R1 which has the parameter
*                                as a halfword length followed by
*                                the text from the PAR= parameter
*                                on the $RUN command
*         GETMAIN R,LV=STACKLEN,SP=SUBPOOL
         L      R1,=A(STACKLEN)
         GETSPACE
         ST    R13,4(R1)
         ST    R1,8(R13)
         LR    R13,R1
         USING STACK,R13
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
* Now let's get the program name and parameter list.
*         USING NUCON,R0          why do this? to access cmndline!
*         MVC   PGMNAME,CMNDLINE  get the name of this program
         MVC   PGMNAME,=C'XXXXYYYY'
         L     R2,0(R11)         point to parameter
         LA    R2,0(R2)          clean up parameter pointer
         ST    R2,ARGPTR         store first argument for C
*
* Set R4 to true if we were called in 31-bit mode
*
         LA    R4,0
         AIF   ('&ZSYS' EQ 'S370').NOBSM
         BSM   R4,R0
.NOBSM   ANOP
         ST    R4,SAVER4
         LR    R2,R11            get original R1
         LTR   R4,R4
         BZ    AMODE24
         AIF   ('&ZSYS' EQ 'S370').NOSAVE
         USING USERSAVE,R9
         L     R2,USECTYP        get old style R1 flag byte
.NOSAVE  ANOP
AMODE24  EQU   *
* At this point, the high order byte of R2 contains the
* traditional CMS R1 flag byte.  A x'0B' or x'01' indicates the
* presence of an extended parameter accessable via R0.
         CLM   R2,8,=X'01'       called from EXEC, EXEC 2 or REXX?
         BE    EPLIST            yes use the eplist
         CLM   R2,8,=X'0B'       called from command line?
         BE    EPLIST            yes, use the eplist
NOEPLIST EQU   *
         LA    R2,0              signal no eplist available
         B     ONWARD
EPLIST   EQU   *
         LR    R2,R8             point to eplist
ONWARD   EQU   *
*
         ST    R2,ARGPTRE        store eplist for C
         LA    R2,PGMNAME
         ST    R2,PGMNPTR        store program name
*
* FOR GCC WE NEED TO BE ABLE TO RESTORE R13
         LA    R5,SAVEAREA
         ST    R5,SAVER13
*
         LA    R1,PARMLIST
*
         AIF   ('&ZSYS' NE 'S380').N380ST1
* If we were called in AMODE 31, don't bother setting mode now
         LTR   R4,R4
         BNZ   IN31
         CALL  @@SETM31
IN31     DS    0H
.N380ST1 ANOP
*
         CALL  @@START
         LR    R9,R15
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
         LR    R14,R9
*         FREEMAIN R,LV=STACKLEN,A=(R1),SP=SUBPOOL
         FREESPAC
         LR    R15,R14
         RETURN (14,12),RC=(15)
SAVER4   DS    F
SAVER13  DS    F
         LTORG
*         ENTRY CEESG003
*CEESG003 DS    0H
         DS    0H
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
*         FREEMAIN R,LV=STACKLEN,A=(R1),SP=SUBPOOL
         FREESPAC
         LR    R15,R14
         RETURN (14,12),RC=(15)
         LTORG
*
STACK    DSECT
SAVEAREA DS    18F
DUMMYPTR DS    F
THEIRSTK DS    F
PARMLIST DS    0F
ARGPTR   DS    F
PGMNPTR  DS    F
ARGPTRE  DS    F
TYPE     DS    F
PGMNAME  DS    CL8
PGMNAMEN DS    C                 NUL BYTE FOR C
ANCHOR   DS    0F
EXITADDR DS    F
         DS    49F
MAINSTK  DS    65536F
MAINLEN  EQU   *-MAINSTK
STACKLEN EQU   *-STACK
*         NUCON
         AIF   ('&ZSYS' EQ 'S370').N380ST4
         USERSAVE
.N380ST4 ANOP
         END
