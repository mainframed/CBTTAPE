*---------------------------------------------------------------------*
*                                                                     *
* Name:        PDSEGDEL                                               *
*                                                                     *
* Function:    REXX function to delete a pdse member and/or member    *
*              generation.                                            *
*                                                                     *
* Syntax:      X=PDSEGDEL(MEMBER,GEN,DDNAME,MGFLAG)                   *
*                                                                     *
*              Where:                                                 *
*                                                                     *
*              MEMBER is the member to be deleted                     *
*                                                                     *
*              GEN is the absolute generation to be deleted           *
*                                                                     *
*              DDNAME is the ddname where the member resides          *
*                                                                     *
*              MGFlag is a flag indicating if the PDSE has            *
*              member generations (D for plain delete                 *
*              or DG for delete generation)                           *
*                                                                     *
*              Defaults:                                              *
*                                                                     *
*              MEMBER:   none                                         *
*              GEN:      none                                         *
*              DDNAME:   none                                         *
*              MGFLAG:   DG                                           *
*                                                                     *
*---------------------------------------------------------------------*
* Link Edit information:  Rent, Reus                                  *
*---------------------------------------------------------------------*
* Return Codes:                                                       *
*                                                                     *
*         0    processing has completed successfully                  *
*         4    delete failed                                          *
*         8    invalid parm                                           *
*        20    no parm provided                                       *
*                                                                     *
*---------------------------------------------------------------------*
* Author:      Lionel B. Dyck                                         *
*---------------------------------------------------------------------*
* HISTORY:                                                            *
*                                                                     *
*        01/25/18  -  Correct move of ddname                          *
*        01/24/18  -  Correct test for MGFLAG D (JK)                  *
*                  -  Other corrections for non-member gen pds/pdse   *
*        11/20/17  -  Add MGFLAG and test                             *
*                     - if D then use STOW D (no generations)         *
*                     if DG then use STOW DG (member generations)     *
*        06/19/17  -  Always use STOW DG                              *
*        04/25/17  -  Use STOW D if Gen 0                             *
*        01/09/17  -  Change to AMODD 24                              *
*        01/06/17  -  Remove comments about relative generation       *
*        08/05/16  -  Moved workdcb to workarea so code is reentrant  *
*                     Thanks to Bill Fleury                           *
*        08/04/16  -  finally got it working                          *
*        08/02/16  -  creation from ddlist                            *
*                                                                     *
*---------------------------------------------------------------------*
PDSEGDEL CSECT
PDSEGDEL AMODE 24
*----------------------------------------------------------*
*        Housekeeping occurs here                          *
*----------------------------------------------------------*
         STM   R14,R12,12(R13)     SAVE REGISTERS
         LR    R12,R15             LOAD BASE REG
         USING PDSEGDEL,R12        INFORM ASSEMBLER
         B     STARTIT
         DC    CL8'PDSEGDEL'
         DC    C'-'
         DC    CL8'&SYSDATE'       COMPILE DATE
         DC    C'-'
         DC    CL8'&SYSTIME'       COMPILE TIME
STARTIT  DS    0H
         SPACE 2
         LA    R0,72+4000          get savearea plus workarea
         GETMAIN R,LV=(0)
         MVI   0(R1),X'00'         MOVE X'00' TO FIRST BYTE
         LR    R2,R1               SAVE POINTER IN EVEN REG
         LA    R4,1(R1)            SET RECEIVING POINTER
         LR    R5,R0               SET RECEIVING LENGTH
         BCTR  R5,R0               DECREMENT LENGTH
         LA    R5,0(R5)            CLEAR HIGH ORDER BYTE
         LA    R3,1                SET SENDING LENGTH
         MVCL  R4,R2               INSTRUCTION PADS WITH X'00'
         ST    R13,4(R1)           SAVE BACK CHAIN
         ST    R1,8(R13)           SET FORWARD CHAIN
         LR    R2,R1               SAVE NEW SAVEAREA ADDRESS
         L     R15,16(R13)         RESTORE REG 15
         ST    R0,16(R13)          SAVE SAVEAREA LENGTH
         LM    R0,R1,20(R13)       RESTORE REGS USED IN GETMAIN
         LR    R13,R2              SET SAVEAREA POINTER
         USING WORK,R13            USING ON WORKAREA VIA R13
         EJECT
*---------------------------------------------------------------------*
*        PROCESS THE INPUT PARAMETER LIST                             *
*---------------------------------------------------------------------*
         LR    R5,R0               -> ENVIRONMENT BLOCK
         ST    R5,ENVBADDR         Save Environment Block Address
         USING ENVBLOCK,R5
         L     R5,ENVBLOCK_IRXEXTE -> EXTERNAL VECTOR TABLE
         DROP  R5
         USING IRXEXTE,R5
         L     R5,IRXEXCOM         LOAD IRXEXCOM EPA
         ST    R5,EXCOM            SAVE IRXEXCOM EPA
         DROP  R5
         LR    R4,R1               -> EFPL
         USING EFPL,R4             ESTABLISH ADDRESSABILITY TO EFPL
         L     R5,EFPLEVAL         -> EVAL BLOCK ADDRESS POINTER
         L     R5,0(0,R5)          -> EVAL BLOCK
         ST    R5,EVALADDR         SAVE IT'S ADDRESS
         L     R4,EFPLARG          -> ARGUMENT LIST
         DROP  R4
*
         LTR   R4,R4               ANY ARGUMENT LIST ?
         BZ    EXIT20              YES
*
         MVC   SPMEM,BLANKS        INITIALIZE THE MEMBER VALUE
         MVC   DDNAME,BLANKS       INITIALIZE THE DDNAME VALUE
*
         USING ARGTABLE_ENTRY,R4   ESTABLISH ADDRESSABILITY TO ARG
         CLC   =8X'FF',ARGTABLE_ARGSTRING_PTR  ANY REAL ARGUMENTS
         BE    EXIT20              NO - SO EXIT
         L     R2,ARGTABLE_ARGSTRING_PTR    -> ARGUMENT
         L     R3,ARGTABLE_ARGSTRING_LENGTH LOAD LENGTH
         BCTR  R3,R0               LESS 1 FOR MVC
         EX    R3,MOVEMEM          MOVE THE MEMBER
         LA    R4,ARGTABLE_NEXT
*
         CLC   =8X'FF',ARGTABLE_ARGSTRING_PTR  ANY Generation?
         BE    EXIT8               NO - SO EXIT
         L     R2,ARGTABLE_ARGSTRING_PTR    -> ARGUMENT
         L     R3,ARGTABLE_ARGSTRING_LENGTH LOAD LENGTH
         BCTR  R3,R0               LESS 1 FOR MVC
         LTR   R3,R3
         BM    EXIT8               NO Generation
*
         PACK  DWK(8),0(*-*,R2)    <<Executed>>
         EX    R3,*-6             << Executes Pack >>
         CVB   R1,DWK
         ST    R1,SPGEN
*
         LA    R4,ARGTABLE_NEXT
         CLC   =8X'FF',ARGTABLE_ARGSTRING_PTR  ANY DDname ?
         BE    EXIT8               NO - SO EXIT
         L     R2,ARGTABLE_ARGSTRING_PTR    -> ARGUMENT
         L     R3,ARGTABLE_ARGSTRING_LENGTH LOAD LENGTH
         BCTR  R3,R0               LESS 1 FOR MVC
         LTR   R3,R3
         BM    EXIT8               NO DDName
         EX    R3,MOVEDDN          MOVE DDName
*
         MVC   MGFLAG(2),=C'DG'    Default to Delete Generation
         LA    R4,ARGTABLE_NEXT
         CLC   =8X'FF',ARGTABLE_ARGSTRING_PTR  ANY MGFLAG ?
         BE    NOMGF               NO - SO EXIT
         L     R2,ARGTABLE_ARGSTRING_PTR    -> ARGUMENT
         L     R3,ARGTABLE_ARGSTRING_LENGTH LOAD LENGTH
*$$$     BCTR  R3,R0               LESS 1 FOR MVC
         EX    R3,MOVEMGF          MOVE MGFlag
NOMGF    EQU   *
         EJECT
*---------------------------------------------------------------------*
*        INITIALIZE ALL WORK AREAS FROM OUR CONSTANTS                 *
*---------------------------------------------------------------------*
START    DS    0H
*
         MVC   WORKDCB,XDCB                                        *BF*
         MVC   WORKDDN(8),DDNAME   SET UP DDNAME
         LA    R1,WORKDCB
         ST    R1,SPDCBA
         LA    R1,20
         STH   R1,SPLEN
*
         EJECT
         MVC   WORKOPEN,XOPEN     OPEN PARAMETER LIST              *BF*
         OPEN  (WORKDCB,OUTPUT),MODE=31,MF=(E,WORKOPEN)            *BF*
         CLC   MGFLAG(2),=C'DG'           * Delete non-Gen
         BNE   STOWD                      * No - use stow D
         STOW  WORKDCB,SPLIST,DG
         B     STOWOK
STOWD    DS    0H
         LA    R1,16
         STH   R1,SPLEN
         STOW  WORKDCB,SPMEM,D
STOWOK   DS    0H
         LR    R5,R15   * Save RC
         MVC   WORKCLOS,XCLOSE    CLOSE PARAMETER LIST             *BF*
         CLOSE WORKDCB,MODE=31,MF=(E,WORKCLOS)                     *BF*
         LTR   R5,R5
         BNZ   EXIT4
         B     EXIT0
         EJECT
*---------------------------------------------------------------------*
*        ALL OF THE EXIT ROUTINES FOLLOW                              *
*---------------------------------------------------------------------*
SETRC    DS    0H
         L     R11,EVALADDR
         USING EVALBLOCK,R11
         MVC   EVALBLOCK_EVLEN(4),=A(2)
         MVC   EVALBLOCK_EVDATA(2),RC
         DROP  R11
         SPACE 2
         LR    R1,R13              GET SAVEAREA ADDRESS
         L     R13,4(R13)          GET BACK CHAIN POINTER
         L     R0,16(R13)          GET SAVEAREA LENGTH
         ST    R15,16(R13)         SAVE REGISTER 15 (RETCODE)
         FREEMAIN R,LV=(0),A=(1)   FREE SAVEAREA
         LM    R14,R12,12(R13)     RESTORE CALLERS REGS
         LA    R15,0                                        $1/95$
         BR    R14
*---------------------------------------------------------------------*
EXIT0    DS    0H
         MVC   RC,=C'00'           SET RC TO ZERO
         B     SETRC
EXIT4    DS    0H
         MVC   RC,=C'04'           SET RC
         B     SETRC
EXIT8    DS    0H
         MVC   RC,=C'08'           SET RC
         B     SETRC
EXIT20   DS    0H
         MVC   RC,=C'20'           SET RC
         B     SETRC
         EJECT
*---------------------------------------------------------------------*
*        EXECUTED INSTRUCTIONS                                        *
*---------------------------------------------------------------------*
MOVEDDN  MVC   DDNAME(0),0(R2)     ** EXECUTED
MOVEMEM  MVC   SPMEM(0),0(R2)      ** EXECUTED
MOVEMGF  MVC   MGFLAG(0),0(R2)     ** EXECUTED
         SPACE 2
*---------------------------------------------------------------------*
*        LITERAL POOL                                                 *
*---------------------------------------------------------------------*
         LTORG
         EJECT
*---------------------------------------------------------------------*
*        CONSTANTS                                                    *
*---------------------------------------------------------------------*
BLANKS   DC    CL80' '
         EJECT
XDCB     DCB   DSORG=PO,DDNAME=WORKDDN,MACRF=(R,W)                 *BF*
XDCBLEN  EQU   *-XDCB                                              *BF*
XOPEN    OPEN  0,MODE=31,MF=L      OPEN PARAMETER LIST             *BF*
XOPENL   EQU   *-XOPEN                                             *BF*
XCLOSE   CLOSE 0,MODE=31,MF=L      CLOSE PARAMETER LIST            *BF*
XCLOSEL  EQU   *-XCLOSE                                            *BF*
         EJECT
*---------------------------------------------------------------------*
*        WORK AREA DSECTS                                             *
*---------------------------------------------------------------------*
WORK     DSECT
SAVE     DS    18F
DWK      DS    D
*
WORKDCB  DS    CL(XDCBLEN)                                         *BF*
WORKDDN  EQU   WORKDCB+40,8                                        *BF*
         DS    0F
WORKOPEN DS    CL(XOPENL)                                          *BF*
WORKCLOS DS    CL(XCLOSEL)                                         *BF*
*
SPLIST   DS    CL20
         ORG   SPLIST
SPLEN    DS    CL2
SPFUNC   DS    C
         DS    C
SPDCBA   DS    F
SPMEM    DS    CL8
SPGEN    DS    F
MGFLAG   DS    CL4
*
EVALADDR DS    F
EXCOM    DS    A                   ADDRESS OF IRXEXCOM LOAD MODULE
ENVBADDR DS    A                   Environment Block Address
DDNAME   DS    CL8                 PASSED DDNAME
MEMBER   DS    CL8                 PASSED MEMBER NAME
RC       DS    XL2                 RETURN CODE
         EJECT
         IRXEFPL DSECT=YES
         EJECT
         IRXARGTB
         EJECT
         IRXSHVB
         EJECT
         IRXEVALB
         EJECT
         IRXEXTE
         EJECT
         IRXENVB
         EJECT
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
         END   ,
