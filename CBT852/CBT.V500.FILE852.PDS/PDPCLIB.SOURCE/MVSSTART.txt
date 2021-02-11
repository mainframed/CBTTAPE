MVSSTART TITLE 'M V S S T A R T  ***  STARTUP ROUTINE FOR C'
***********************************************************************
*                                                                     *
*  This program written by Paul Edwards.                              *
*  Released to the public domain                                      *
*                                                                     *
***********************************************************************
***********************************************************************
*                                                                     *
*  MVSSTART - startup code for MVS.                                   *
*  It is mainly tested with GCCMVS, but it should also                *
*  work with IBM C. To choose which compiler you are using,           *
*  change the "&COMP" switch in PDPTOP                                *
*                                                                     *
***********************************************************************
*
         COPY  PDPTOP
*
         PRINT GEN
* YREGS was not part of the SYS1.MACLIB shipped with MVS 3.8j
* so may not be available, so do our own defines instead.
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
* correctly. ie you need to specify the entry point
* explicitly rather than letting it default to 0 and putting
* this module first in the link. If you default to 0 you
* will abend on this eyecatcher. The real entry point is
* actually @@MAIN (auto generated at the same time as
* plain MAIN), but that simply does an immediate branch to
* @@CRT0, so for all practical purposes, @@CRT0 is the
* actual entry point. But don't code that in linkage
* editor statements, code @@MAIN instead. For IBM C you
* need to code @@CRT0.
*
         DC    C'PDPCLIB!'
*
         ENTRY @@CRT0    make this globally visible
@@CRT0   DS    0H        defacto entry point
         AIF ('&COMP' NE 'IBMC').NOCEES
         ENTRY CEESTART  I don't think IBM should be polluting
*                        the namespace with this
CEESTART DS    0H
.NOCEES  ANOP
* For this next line to work there must be no intervening instructions
* since it is based on reference to @@CRT0
         SAVE  (14,12),,@@CRT0   Save caller's registers
         LR    R10,R15           R15 points to @@CRT0 on entry, but
*                                since R15 will be trashed when we
*                                call other functions (it is used
*                                as both the called function address
*                                and for the return code), we need to
*                                establish a different base register,
*                                R10 in this case.
         USING @@CRT0,R10
         LR    R11,R1            R1 points to the parameters passed
*                                by MVS to this program, but the
*                                GETMAIN to allocate the stack will
*                                trash R1, so we need to save that,
*                                in R11 in this case.
* Keep stack BTL so that the save area traceback works on MVS/380 2.0
         AIF ('&ZSYS' EQ 'S370').NOBEL
         GETMAIN RU,LV=STACKLEN,SP=SUBPOOL,LOC=BELOW
         AGO .GETFIN
.NOBEL   GETMAIN RU,LV=STACKLEN,SP=SUBPOOL
.GETFIN  ANOP
         ST    R13,4(,R1)        Remember the R13 that MVS gave us
         ST    R1,8(,R13)        Let MVS know our new R13 (save area)
         LR    R13,R1            Switch to using our new R13
         LR    R1,R11            Restore R1 as MVS gave us
         USING STACK,R13
*
         LA    R1,0(,R1)         Clean address, just for good measure
*
         LA    R2,0              Set R2 to 0
         ST    R2,DUMMYPTR       We are not using a CRAB at this stage
*                                but the PDPCLIB target of GCC
*                                reserves this spot for a CRAB, so we
*                                set it to 0 for now.
         LA    R2,MAINSTK        This is where the next called function
*                                can start writing their own data. We
*                                don't touch that memory at all
         ST    R2,THEIRSTK       When we give the caller our R13, they
*                                know they can find a pointer to the
*                                next free spot in the stack at a
*                                predictable spot - offset 76 from R13
*                                It seems that GCC and IBM C share this
*                                convention.
         LA    R12,ANCHOR        R12 seems to be reserved by IBM C
*                                for its answer to the SAS/C CRAB
*                                apparently called an "ANCHOR"
         ST    R14,EXITADDR      possibly used by IBM C for early
*                                exit, but not applicable when using
*                                PDPCLIB, unless IBM C generates prolog
*                                code to call this in case of error
         L     R3,=A(MAINLEN)    get length of the main stack
         AR    R2,R3             point to top of the stack
         ST    R2,788(,R12)      IBM C needs to know stack end
*                                (GCC not currently checking overflow)
         LA    R2,0
         ST    R2,116(,R12)      IBM C probably calls this offset when
*                                it needs to obtain more memory. We
*                                presumably crash instead. This offset
*                                and the entire ANCHOR in fact, is not
*                                used by GCC.
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
* Find out if this is TSO or not
         LA    R5,0              preset to non-TSO
         L     R3,PSAAOLD-PSA    get address of my ASCB
         USING ASCB,R3
         ICM   R4,B'1111',ASCBASXB
         BZ    FINTSO
         USING ASXB,R4
         ICM   R5,B'1111',ASXBLWA
FINTSO   DS    0H
         ST    R5,TYPE           non-zero means TSO, 3rd parm to START
         L     R2,0(,R1)         get first program parameter
         LA    R2,0(,R2)         clean address
         N     R2,=X'7FFFFFFF'   clean the top bit in AM32/64
         ST    R2,ARGPTR         this will be first parm to START
         LA    R2,PGMNAME        find program name
         ST    R2,PGMNPTR        this will be second parm to START
*
* For GCC, and also presumably IBM C, in order to exit early, we
* need to be able to get back to the position on the stack as
* identified by the current value of R13
* We could save R13 directly but for some reason I coded it to
* reobtain the start of the stack. We should probably change that
* to a simple ST R13,SAVER13
         LA    R5,SAVEAREA
         ST    R5,SAVER13
*
         CALL  @@SETUP           Give assembler code a chance to init
*
         LA    R1,PARMLIST       Standard MVS convention parameters
*                                for calling assembler, also used by C
*
         CALL  @@START           C code can now do everything else
*                                ie all initialization, and then it
*                                will call main() itself.
*
* At this point, main() has returned to start() and now to here,
* and all we need to do is free the stack and return to MVS.
* Well, that is one possible design. The other possible design
* is that after main() returns to start(), it can do some
* cleanup and then call exita() below, as a different way of
* exiting. This startup code allows either way to work.
RETURNMS DS    0H
         LR    R1,R13            R13 is restored to our save area,
*                                which is also the start of our stack
         L     R13,SAVEAREA+4    Offset 4 has backchain to OS save area
         LR    R14,R15           Preserve the return code
         FREEMAIN RU,LV=STACKLEN,A=(R1),SP=SUBPOOL   free entire stack
         LR    R15,R14           Restore the return code
         RETURN (14,12),RC=(15)  Restore all registers, retaining
*                                return code in R15
SAVER13  DS    A      So that everyone can find the start of the stack
         LTORG
         DS    0H
         AIF ('&COMP' NE 'IBMC').NOCEES2
         ENTRY CEESG003
CEESG003 DS    0H
         ENTRY CEEBETBL
CEEBETBL DS    0H
         ENTRY CEEROOTA
CEEROOTA DS    0H
         ENTRY EDCINPL
EDCINPL  DS    0H
.NOCEES2 ANOP
* This function enables GCC and probably IBM C programs to do an
* early exit, ie callable from anywhere.
         ENTRY @@EXITA
@@EXITA  DS    0H
* Since this is actually called as a function, the return
* code to give to MVS (in R15) will actually be a parameter,
* and in addition we need to restore the original R13 that
* points to our stack so that we can both free it as well
* as get back MVS's save area to restore registers
         LR    R10,R15       Use R10 as base register
         USING @@EXITA,R10
         L     R9,0(,R1)     Get return code into R9
         L     R13,=A(SAVER13)  Switch R13 back to saved R13
         L     R13,0(,R13)   Now R13 points to stack again
*
         LR    R1,R13        R1 also points to stack, to be freed
         L     R13,4(,R13)   Go back to MVS's save area
         LR    R14,R9        Keep return code in R14 instead of R9
*                            I think we should change this to use
*                            R9 instead
         FREEMAIN RU,LV=STACKLEN,A=(R1),SP=SUBPOOL
         LR    R15,R14       Restore the saved return code
         RETURN (14,12),RC=(15)  Return to MVS with return code
         LTORG
*
         IKJTCB
         IEZJSCB
         IHAPSA
         IHAASCB
         IHAASXB
         IHARB
         IHACDE
STACK    DSECT
SAVEAREA DS    18F     Standard save area for anyone we call
DUMMYPTR DS    F       Reserved for future CRAB usage
THEIRSTK DS    F       Called C function needs to know where they can
*                      put their own save area and stack variables
PARMLIST DS    0F      Standard parameter list to call start()
ARGPTR   DS    F       Argument provided by MVS
PGMNPTR  DS    F       Pointer to MVS program name
TYPE     DS    F       Flag to indicate TSO, passed by value
PGMNAME  DS    CL8     MVS program name itself
PGMNAMEN DS    C       NUL byte for C
*                      The start() function will do the
*                      NUL-termination. All we need to do
*                      here is reserve space.
*
* This ANCHOR convention is only used by IBM C I think
* but is harmless to keep for GCC too, and even populate it
* at runtime, even though it isn't used. We can reconsider
* this at some point and have conditional code
ANCHOR   DS    0F
EXITADDR DS    F     This seems to be the address that a module built
*                    by IBM C can call to immediately exit. In this
*                    startup code we just set it to the R14 that we
*                    received at entry, but it should probably instead
*                    be EXITA instead, to do cleanup. But it is a moot
*                    point anyway, because the PDPCLIB code completely
*                    ignores the entire ANCHOR. Unless this offset is
*                    automatically referenced in IBM C generated
*                    assembler.
         DS    200F  Not sure how big ANCHOR should be, but
*                    this is enough to cover what we actually
*                    populate in this startup code, which in turn is
*                    determined by what I observed IBM C
*                    generated assembler actually producing in the
*                    prolog.
MAINSTK  DS    65536F   Hardcoded stack size while we decide how a
*                       flexible stack size should be designed. For
*                       now it is good to be simple.
MAINLEN  EQU   *-MAINSTK
STACKLEN EQU   *-STACK
         END
