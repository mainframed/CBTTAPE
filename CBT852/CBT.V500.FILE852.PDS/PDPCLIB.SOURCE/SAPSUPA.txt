***********************************************************************
*
*  This program written by Paul Edwards.
*  Released to the public domain
*
*  Extensively modified by others
*
***********************************************************************
*
*  MUSSUPA - Support routines for PDPCLIB under MUSIC
*
*  It is currently coded for GCC, but IBM C functionality is
*  still there, it's just not being tested after any change.
*
***********************************************************************
*
* Note that the VBS support may not be properly implemented.
* Note that this code issues WTOs. It should be changed to just
* set a return code an exit gracefully instead. I'm not talking
* about that dummy WTO. But on the subject of that dummy WTO - it
* should be made consistent with the rest of PDPCLIB which doesn't
* use that to set the RMODE/AMODE. It should be consistent one way
* or the other.
*
* Here are some of the errors reported:
*
*  OPEN input failed return code is: -37
*  OPEN output failed return code is: -39
*
* FIND input member return codes are:
* Original, before the return and reason codes had
* negative translations added refer to copyrighted:
* DFSMS Macro Instructions for Data Sets
* RC = 0 Member was found.
* RC = -1024 Member not found.
* RC = -1028 RACF allows PDSE EXECUTE, not PDSE READ.
* RC = -1032 PDSE share not available.
* RC = -1036 PDSE is OPENed output to a different member.
* RC = -2048 Directory I/O error.
* RC = -2052 Out of virtual storage.
* RC = -2056 Invalid DEB or DEB not on TCB or TCBs DEB chain.
* RC = -2060 PDSE I/O error flushing system buffers.
* RC = -2064 Invalid FIND, no DCB address.
*
***********************************************************************
*
         COPY  PDPTOP
*
         CSECT
         PRINT NOGEN
         YREGS
SUBPOOL  EQU   0
         EXTRN @@CONSDN
*
*
*
         AIF ('&ZSYS' EQ 'S370').AMB24A
AMBIT    EQU X'80000000'
         AGO .AMB24B
.AMB24A  ANOP
AMBIT    EQU X'00000000'
.AMB24B  ANOP
*
*
*
***********************************************************************
*
*  AOPEN - Open a dataset
*
*  Note that under MUSIC, RECFM=F is the only reliable thing. It is
*  possible to use RECFM=V like this:
*  /file myin tape osrecfm(v) lrecl(32756) vol(PCTOMF) old
*  but it is being used outside the normal MVS interface. All this
*  stuff really needs to be rewritten per normal MUSIC coding.
*
*
*  Note - more documentation for this and other I/O functions can
*  be found halfway through the stdio.c file in PDPCLIB.
*
***********************************************************************
**********************************************************************
*                                                                    *
*  AOPEN - Open a file                                               *
*                                                                    *
*  Parameters are:                                                   *
*  DDNAME - space-padded, 8 character DDNAME to be opened            *
*  MODE - 0 = READ, 1 = WRITE, 2 = UPDATE (update not supported)     *
*  RECFM - 0 = F, 1 = V, 2 = U. This is an output from this function *
*  LRECL - This function will determine the LRECL                    *
*  BLKSIZE - This function will determine the block size             *
*  ASMBUF - pointer to a 32K area which can be written to (only      *
*    needs to be set in move mode)                                   *
*  MEMBER - *pointer* to space-padded, 8 character member name.      *
*    If pointer is 0 (NULL), no member is requested                  *
*                                                                    *
*  Return value:                                                     *
*  An internal "handle" that allows the assembler routines to        *
*  keep track of what's what when READ etc are subsequently          *
*  called.                                                           *
*                                                                    *
*                                                                    *
*  Note - more documentation for this and other I/O functions can    *
*  be found halfway through the stdio.c file in PDPCLIB.             *
*                                                                    *
**********************************************************************
         PUSH  USING
         DROP  ,
         ENTRY @@AOPEN
@@AOPEN  DS    0H
         SAVE  (14,12),,@@AOPEN
         LR    R12,R15
         USING @@AOPEN,R12
         LR    R11,R1
*         GETMAIN R,LV=WORKLEN,SP=SUBPOOL
         LA    R1,WORKAREA
         ST    R13,4(R1)
         ST    R1,8(R13)
         LR    R13,R1
         LR    R1,R11
         USING WORKAREA,R13
*
         L     R3,0(R1)         R3 POINTS TO DDNAME
         L     R4,4(R1)         R4 POINTS TO MODE
         L     R4,0(R4)         R4 now has value of mode
* 08(,R1) has RECFM
* Note that R5 is used as a scratch register
         L     R8,12(,R1)         R8 POINTS TO LRECL
* 16(,R1) has BLKSIZE
* 20(,R1) has ASMBUF pointer
*
         L     R9,24(,R1)         R9 POINTS TO MEMBER NAME (OF PDS)
         LA    R9,0(,R9)          Strip off high-order bit or byte
*
* Point directly to ZDCBAREA
         LA    R1,ZDCBAREA
         LR    R2,R1
         LR    R0,R2              Load output DCB area address
         LA    R1,ZDCBLEN         Load output length of DCB area
         LR    R5,R11             Preserve parameter list
         LA    R11,0              Pad of X'00' and no input length
         MVCL  R0,R10             Clear DCB area to binary zeroes
         LR    R11,R5             Restore parameter list
* R5 free again
* THIS LINE IS FOR GCC
         LR    R6,R4
* THIS LINE IS FOR IBM C
*         L     R6,0(R4)
         LTR   R6,R6
         LA    R1,ABRDW           point to RDW before ABUFFER
*         LA    R1,ABUFFER
         ST    R1,ASMBUF
         L     R5,20(,R11)        R5 points to ASMBUF
         ST    R1,0(R5)           save the pointer
* R5 now free again
*
DONEOPEN DS    0H
         LR    R7,R2
         SR    R6,R6
         LH    R6,=H'254'         Hardcode to 250 bytes of data
         ST    R6,0(R8)
FIXED    DS    0H
*         L     R6,=F'0'
*         B     DONESET
VARIABLE DS    0H
         L     R6,=F'1'
DONESET  DS    0H
         L     R5,8(,R11)         Point to RECFM
         ST    R6,0(R5)
* Finished with R5 now
         LR    R15,R7
         B     RETURNOP
BADOPEN  DS    0H
*         FREEMAIN RU,LV=ZDCBLEN,A=(R2),SP=SUBPOOL  Free DCB area
         L     R15,=F'-1'
         B     RETURNOP           Go return to caller with negative RC
*
ENDFILE  LA    R6,1
         ST    R6,RDEOF
         BR    R14
EOFRLEN  EQU   *-ENDFILE
*
RETURNOP DS    0H
         LR    R1,R13
         L     R13,SAVEAREA+4
         LR    R7,R15
*         FREEMAIN RU,LV=WORKLEN,A=(R1),SP=SUBPOOL
         LR    R15,R7
         RETURN (14,12),RC=(15)
         LTORG
         POP   USING
* OPENMAC  OPEN  (,INPUT),MF=L,MODE=31
* CAN'T USE MODE=31 ON MVS 3.8
OPENMAC  OPEN  (,INPUT),MF=L,TYPE=J
OPENMLN  EQU   *-OPENMAC
* WOPENMAC OPEN  (,OUTPUT),MF=L,MODE=31
* CAN'T USE MODE=31 ON MVS 3.8
WOPENMAC OPEN  (,OUTPUT),MF=L
WOPENMLN EQU   *-WOPENMAC
*INDCB    DCB   MACRF=GL,DSORG=PS,EODAD=ENDFILE,EXLST=JPTR
* LEAVE OUT EODAD AND EXLST, FILLED IN LATER
INDCB    DCB   MACRF=GL,DSORG=PS,EODAD=ENDFILE,EXLST=JPTR
INDCBLN  EQU   *-INDCB
JPTR     DS    F
*
* OUTDCB changes depending on whether we are in LOCATE mode or
* MOVE mode
         AIF   ('&OUTM' NE 'L').NLM1
OUTDCB   DCB   MACRF=PL,DSORG=PS
.NLM1    ANOP
         AIF   ('&OUTM' NE 'M').NMM1
OUTDCB   DCB   MACRF=PM,DSORG=PS
.NMM1    ANOP
OUTDCBLN EQU   *-OUTDCB
*
*
*
**********************************************************************
*                                                                    *
*  AREAD - Read from file                                            *
*                                                                    *
**********************************************************************
         PUSH  USING
         DROP  ,
         ENTRY @@AREAD
@@AREAD  DS    0H
         SAVE  (14,12),,@@AREAD
         LR    R12,R15
         USING @@AREAD,R12
         LR    R11,R1
         AIF ('&ZSYS' EQ 'S370').NOMOD1
         CALL  @@SETM24
.NOMOD1  ANOP
*         AIF   ('&ZSYS' NE 'S370').BELOW1
* CAN'T USE "BELOW" ON MVS 3.8
*         GETMAIN R,LV=WORKLEN,SP=SUBPOOL
*         AGO   .NOBEL1
*.BELOW1  ANOP
*         GETMAIN R,LV=WORKLEN,SP=SUBPOOL,LOC=BELOW
*.NOBEL1  ANOP
         L     R2,0(R1)         R2 CONTAINS HANDLE
         USING ZDCBAREA,R2
         LA    R1,SAVEADCB
         ST    R13,4(R1)
         ST    R1,8(R13)
         LR    R13,R1
         LR    R1,R11
         USING WORKAREA,R13
*
*        L     R2,0(R1)         R2 CONTAINS HANDLE
         L     R3,4(R1)         R3 POINTS TO BUF POINTER
         L     R4,8(R1)         R4 point to a length
         LA    R6,0
         ST    R6,RDEOF
         GET   (R2)
         ST    R1,0(R3)
*         LH    R5,DCBLRECL
         L     R15,RDEOF
*
RETURNAR DS    0H
         LR    R1,R13
         L     R13,SAVEAREA+4
         LR    R7,R15
*        FREEMAIN RU,LV=WORKLEN,A=(R1),SP=SUBPOOL
         AIF ('&ZSYS' EQ 'S370').NOMOD2
         CALL  @@SETM31
.NOMOD2  ANOP
         ST    R5,0(R4)         Tell caller the length read
         LR    R15,R7
         RETURN (14,12),RC=(15)
         POP   USING
*
*
*
***********************************************************************
*
*  AWRITE - Write to an open dataset
*
***********************************************************************
         PUSH  USING
         DROP  ,
         ENTRY @@AWRITE
@@AWRITE DS    0H
         SAVE  (14,12),,@@AWRITE
         LR    R12,R15
         USING @@AWRITE,R12
         L     R2,0(,R1)          R2 contains GETMAINed address
         L     R3,4(,R1)          R3 points to the record address
         L     R4,8(,R1)          R4 points to the length
         L     R4,0(,R4)          R4 now has actual length
         USING ZDCBAREA,R2
*        GETMAIN RU,LV=WORKLEN,SP=SUBPOOL
         LA    R1,SAVEADCB
         ST    R13,4(,R1)
         ST    R1,8(,R13)
         LR    R13,R1
*        USING WORKAREA,R13
*
         AIF   ('&ZSYS' NE 'S380').N380WR1
*         CALL  @@SETM24
.N380WR1 ANOP
*
*         STCM  R4,B'0011',DCBLRECL
*
         AIF   ('&OUTM' NE 'L').NLM2
*         PUT   (R2)
.NLM2    ANOP
         AIF   ('&OUTM' NE 'M').NMM2
         L     R7,=V(@@CONSDN)
         L     R7,0(R7)
         LTR   R7,R7
         BZ    DODIAG
         S     R4,=F'4'   assume RECFM=V
         ST    R4,PARM1
         L     R3,0(R3)
         LA    R3,4(R3)   assume RECFM=V
         ST    R3,PARM2
         LA    R1,1
         ST    R1,PARM3   set PARM3 = 1 = carriage return wanted
         LA    R1,PARM1
         CALL  @@CONSWR
         B     DONEDIAG
DODIAG   DS    0H
* Extra 6 bytes for the MSG *, minus 4 for RDW
         LA    R4,2(R4)
* Move in MSG * prefix
         MVC   ABMSG(6),MSGSTAR
         LA    R6,ABMSG
*         DIAG  6,4,0(8)
         DC    X'83640008'
DONEDIAG DS    0H
         LA    R15,0
*         PUT   (R2),(R6)
.NMM2    ANOP
         AIF   ('&OUTM' NE 'L').NLM3
         ST    R1,0(R6)
.NLM3    ANOP
*
         AIF   ('&ZSYS' NE 'S380').N380WR2
*         CALL  @@SETM31
.N380WR2 ANOP
*
*        LR    R1,R13
*        L     R13,SAVEAREA+4
         L     R13,SAVEADCB+4
*        FREEMAIN RU,LV=WORKLEN,A=(1),SP=SUBPOOL
         RETURN (14,12),RC=0
         POP   USING
*
**********************************************************************
*                                                                    *
*  ACLOSE - Close file                                               *
*                                                                    *
**********************************************************************
         PUSH  USING
         DROP  ,
         ENTRY @@ACLOSE
@@ACLOSE DS    0H
         SAVE  (14,12),,@@ACLOSE
         LR    R12,R15
         USING @@ACLOSE,R12
         LR    R11,R1
         LA    R1,WORKAREA
         ST    R13,4(R1)
         ST    R1,8(R13)
         LR    R13,R1
         LR    R1,R11
         USING WORKAREA,R13
*
         L     R2,0(R1)         R2 CONTAINS HANDLE
         USING ZDCBAREA,R2
* If we are doing move mode, free internal assembler buffer
         AIF   ('&OUTM' NE 'M').NMM6
         L     R5,ASMBUF
         LTR   R5,R5
         BZ    NFRCL
         L     R6,=F'32768'
*         FREEMAIN RU,LV=(R6),A=(R5),SP=SUBPOOL
NFRCL    DS    0H
.NMM6    ANOP
*         MVC   CLOSEMB,CLOSEMAC
*         CLOSE ((R2)),MF=(E,CLOSEMB),MODE=31
* CAN'T USE MODE=31 WITH MVS 3.8
*         CLOSE ((R2)),MF=(E,CLOSEMB)
*         FREEPOOL ((R2))
*         FREEMAIN RU,LV=ZDCBLEN,A=(R2),SP=SUBPOOL
         LA    R15,0
*
RETURNAC DS    0H
         LR    R1,R13
         L     R13,SAVEAREA+4
         LR    R7,R15
*         FREEMAIN RU,LV=WORKLEN,A=(R1),SP=SUBPOOL
         LR    R15,R7
         RETURN (14,12),RC=(15)
         LTORG
         POP   USING
* CLOSEMAC CLOSE (),MF=L,MODE=31
* CAN'T USE MODE=31 WITH MVS 3.8
CLOSEMAC CLOSE (),MF=L
CLOSEMLN EQU   *-CLOSEMAC
*
*
*
***********************************************************************
*
*  GETM - GET MEMORY
*
***********************************************************************
         ENTRY @@GETM
@@GETM   DS    0H
         SAVE  (14,12),,@@GETM
         LR    R12,R15
         USING @@GETM,R12
*
         L     R2,0(,R1)
         AIF ('&COMP' NE 'GCC').GETMC
* THIS LINE IS FOR GCC
         LR    R3,R2
         AGO   .GETMEND
.GETMC   ANOP
* THIS LINE IS FOR IBM C
         L     R3,0(,R2)
.GETMEND ANOP
         LR    R4,R3
         LA    R3,8(,R3)
*
* To avoid fragmentation, round up size to 64 byte multiple
*
         A     R3,=A(64-1)
         N     R3,=X'FFFFFFC0'
*
* Assume heap location has been provided in global variable
* Note that this function will only work if the C library
* is compiled with MEMMGR option.
         L     R1,=V(@@HPLOC)
         L     R1,0(R1)
* WE STORE THE AMOUNT WE REQUESTED FROM MVS INTO THIS ADDRESS
         ST    R3,0(R1)
* AND JUST BELOW THE VALUE WE RETURN TO THE CALLER, WE SAVE
* THE AMOUNT THEY REQUESTED
         ST    R4,4(R1)
         A     R1,=F'8'
         LR    R15,R1
*
RETURNGM DS    0H
         RETURN (14,12),RC=(15)
         LTORG
*
***********************************************************************
*
*  FREEM - FREE MEMORY
*
***********************************************************************
         ENTRY @@FREEM
@@FREEM  DS    0H
         SAVE  (14,12),,@@FREEM
         LR    R12,R15
         USING @@FREEM,R12
*
         L     R2,0(,R1)
         S     R2,=F'8'
         L     R3,0(,R2)
*
* Do nothing
*
RETURNFM DS    0H
         RETURN (14,12),RC=(15)
         LTORG
***********************************************************************
*
*  GETCLCK - GET THE VALUE OF THE MVS CLOCK TIMER AND MOVE IT TO AN
*  8-BYTE FIELD.  THIS 8-BYTE FIELD DOES NOT NEED TO BE ALIGNED IN
*  ANY PARTICULAR WAY.
*
*  E.G. CALL 'GETCLCK' USING WS-CLOCK1
*
*  THIS FUNCTION ALSO RETURNS THE NUMBER OF SECONDS SINCE 1970-01-01
*  BY USING SOME EMPERICALLY-DERIVED MAGIC NUMBERS
*
***********************************************************************
         ENTRY @@GETCLK
@@GETCLK DS    0H
         SAVE  (14,12),,@@GETCLK
         LR    R12,R15
         USING @@GETCLK,R12
*
         L     R2,0(,R1)
         STCK  0(R2)
         L     R4,0(,R2)
         L     R5,4(,R2)
         SRDL  R4,12
         SL    R4,=X'0007D910'
         D     R4,=F'1000000'
         SL    R5,=F'1220'
         LR    R15,R5
*
RETURNGC DS    0H
         RETURN (14,12),RC=(15)
         LTORG
***********************************************************************
*                                                                     *
*  GETTZ - Get the offset from UTC offset in 1.048576 seconds         *
*                                                                     *
***********************************************************************
         ENTRY @@GETTZ
@@GETTZ  DS    0H
         SAVE  (14,12),,@@GETTZ
         LR    R12,R15
         USING @@GETTZ,R12
*
         LA    R15,0
*
RETURNGS DS    0H
         RETURN (14,12),RC=(15)
         LTORG ,
         SPACE 2
***********************************************************************
*
*  SYSTEM - execute another command
*
***********************************************************************
         ENTRY @@SYSTEM
@@SYSTEM DS    0H
         SAVE  (14,12),,@@SYSTEM
         LR    R12,R15
         USING @@SYSTEM,R12
         LR    R11,R1
*
         GETMAIN RU,LV=SYSTEMLN,SP=SUBPOOL
         ST    R13,4(,R1)
         ST    R1,8(,R13)
         LR    R13,R1
         LR    R1,R11
         USING SYSTMWRK,R13
*
         LA    R15,0
*
RETURNSY DS    0H
         LR    R1,R13
         L     R13,SYSTMWRK+4
         FREEMAIN RU,LV=SYSTEMLN,A=(1),SP=SUBPOOL
*
         LA    R15,0
         RETURN (14,12),RC=(15)   Return to caller
         LTORG
SYSTMWRK DSECT ,             MAP STORAGE
         DS    18A           OUR OS SAVE AREA
CMDPREF  DS    CL8           FIXED PREFIX
CMDLEN   DS    H             LENGTH OF COMMAND
CMDTEXT  DS    CL200         COMMAND ITSELF
SYSTEMLN EQU   *-SYSTMWRK    LENGTH OF DYNAMIC STORAGE
         CSECT ,
***********************************************************************
*
*  IDCAMS - dummy function to keep MVS happy
*
***********************************************************************
         ENTRY @@IDCAMS
@@IDCAMS DS    0H
         SAVE  (14,12),,@@IDCAMS
         LR    R12,R15
         USING @@IDCAMS,R12
*
         LA    R15,0
*
         RETURN (14,12),RC=(15)
         LTORG
*
**********************************************************************
*                                                                    *
*  DIAG8 - do a diag 8                                               *
*                                                                    *
**********************************************************************
         ENTRY @@DIAG8
@@DIAG8  DS    0H
         SAVE  (14,12),,@@DIAG8
         LR    R12,R15
         USING @@DIAG8,R12
*
         L     R6,0(R1)
         L     R4,4(R1)
*         DIAG  4,6,0(8)
         DC    X'83460008'
         LA    R15,0
*
         RETURN (14,12),RC=(15)
         LTORG
*
**********************************************************************
*                                                                    *
*  @@CONSWR - write to console                                       *
*                                                                    *
*  parameter 1 = buffer length                                       *
*  parameter 2 = buffer                                              *
*                                                                    *
**********************************************************************
         ENTRY @@CONSWR
@@CONSWR DS    0H
         SAVE  (14,12),,@@CONSWR
         LR    R12,R15
         USING @@CONSWR,R12
         USING PSA,R0
*
         L     R10,=V(@@CONSDN) Device number
         L     R10,0(R10)
         L     R7,0(R1)        Bytes to write
         L     R2,4(R1)        Buffer to write
         L     R8,8(R1)        Is CR required?
         MVI   CCHAIN,X'01'    Assume no CR required
         LTR   R8,R8
         BZ    NOCRREQ
         MVI   CCHAIN,X'09'    Need a CR
* For some reason the CCW doesn't like an empty line of 0 bytes.
* Need to find out why. Until then, assume that's the way that
* it's meant to be, and force a space
         LTR   R7,R7
         BNZ   NOSPACE
         LA    R2,=C' '
         LA    R7,1
NOSPACE  DS    0H
NOCRREQ  DS    0H
         AIF   ('&ZSYS' EQ 'S390').CHN390G
         STCM  R2,B'0111',CCHAIN+1   This requires BTL buffer
         STH   R7,CCHAIN+6     Store length in WRITE CCW
         AGO   .CHN390H
.CHN390G ANOP
         ST    R2,CCHAIN+4
         STH   R7,CCHAIN+2
.CHN390H ANOP
*
* Interrupt needs to point to CCONT now. Again, I would hope for
* something more sophisticated in PDOS than this continual
* initialization.
*
         MVC   FLCINPSW(8),CNEWIO
         STOSM FLCINPSW,X'00'  Work with DAT on or OFF
* R3 points to CCW chain
         LA    R3,CCHAIN
         ST    R3,FLCCAW    Store in CAW
*
*
         AIF   ('&ZSYS' EQ 'S390').SIO31M
         SIO   0(R10)
*         TIO   0(R10)
         AGO   .SIO24M
.SIO31M  ANOP
         LR    R1,R10       R1 needs to contain subchannel
         LA    R9,CIRB
         TSCH  0(R9)        Clear pending interrupts
         LA    R10,CORB
         MSCH  0(R10)
         TSCH  0(R9)        Clear pending interrupts
         SSCH  0(R10)
.SIO24M  ANOP
*
*
         LPSW  CWAITNER     Wait for an interrupt
         DC    H'0'
CCONT    DS    0H           Interrupt will automatically come here
         AIF   ('&ZSYS' EQ 'S390').SIO31N
         SH    R7,FLCCSW+6  Subtract residual count to get bytes read
         LR    R15,R7
* After a successful CCW chain, CSW should be pointing to end
         CLC   FLCCSW(4),=A(CFINCHN)
         BE    CALLFIN
         AGO   .SIO24N
.SIO31N  ANOP
         TSCH  0(R9)
         SH    R7,10(R9)
         LR    R15,R7
         CLC   4(4,R9),=A(CFINCHN)
         BE    CALLFIN
.SIO24N  ANOP
         L     R15,=F'-1'   error return
CALLFIN  DS    0H
         RETURN (14,12),RC=(15)
         LTORG
*
*
         AIF   ('&ZSYS' NE 'S390').NOT390P
         DS    0F
CIRB     DS    24F
CORB     DS    0F
         DC    F'0'
         DC    X'0080FF00'  Logical-Path Mask (enable all?) + format-1
         DC    A(CCHAIN)
         DC    5F'0'
.NOT390P ANOP
*
*
         DS    0D
         AIF   ('&ZSYS' EQ 'S390').CHN390I
* X'09' = write with automatic carriage return
CCHAIN   CCW   X'09',0,X'20',0    20 = ignore length issues
         AGO   .CHN390J
.CHN390I ANOP
CCHAIN   CCW1  X'09',0,X'20',0    20 = ignore length issues
.CHN390J ANOP
CFINCHN  EQU   *
         DS    0D
CWAITNER DC    X'060E0000'  I/O, machine check, EC, wait, DAT on
         DC    A(AMBIT)     no error
CNEWIO   DC    X'000C0000'  machine check, EC, DAT off
         DC    A(AMBIT+CCONT)  continuation after I/O request
*
         DROP  ,
*
*
*
*
*
**********************************************************************
*                                                                    *
*  @@CONSRD - read from console                                      *
*                                                                    *
*  parameter 1 = buffer length                                       *
*  parameter 2 = buffer                                              *
*                                                                    *
**********************************************************************
         ENTRY @@CONSRD
@@CONSRD DS    0H
         SAVE  (14,12),,@@CONSRD
         LR    R12,R15
         USING @@CONSRD,R12
         USING PSA,R0
*
         L     R10,=V(@@CONSDN) Device number
         L     R10,0(R10)
         L     R7,0(R1)        Bytes to read
         L     R2,4(R1)        Buffer to read into
         AIF   ('&ZSYS' EQ 'S390').CRD390G
         STCM  R2,B'0111',CRDCHN+1   This requires BTL buffer
         STH   R7,CRDCHN+6     Store length in READ CCW
         AGO   .CRD390H
.CRD390G ANOP
         ST    R2,CRDCHN+4
         STH   R7,CRDCHN+2
.CRD390H ANOP
*
* Interrupt needs to point to CRCONT now. Again, I would hope for
* something more sophisticated in PDOS than this continual
* initialization.
*
         MVC   FLCINPSW(8),CRNEWIO
         STOSM FLCINPSW,X'00'  Work with DAT on or OFF
* R3 points to CCW chain
         LA    R3,CRDCHN
         ST    R3,FLCCAW    Store in CAW
*
*
         AIF   ('&ZSYS' EQ 'S390').CRD31M
         SIO   0(R10)
*         TIO   0(R10)
         AGO   .CRD24M
.CRD31M  ANOP
         LR    R1,R10       R1 needs to contain subchannel
         LA    R9,CRIRB
         TSCH  0(R9)        Clear pending interrupts
         LA    R10,CRORB
         MSCH  0(R10)
         TSCH  0(R9)        Clear pending interrupts
         SSCH  0(R10)
.CRD24M  ANOP
*
*
         LPSW  CRWTNER      Wait for an interrupt
         DC    H'0'
CRCONT   DS    0H           Interrupt will automatically come here
         AIF   ('&ZSYS' EQ 'S390').CRD31N
         SH    R7,FLCCSW+6  Subtract residual count to get bytes read
         LR    R15,R7
* After a successful CCW chain, CSW should be pointing to end
         CLC   FLCCSW(4),=A(CRDFCHN)
         BE    CRALLFIN
         AGO   .CRD24N
.CRD31N  ANOP
         TSCH  0(R9)
         SH    R7,10(R9)
         LR    R15,R7
         CLC   4(4,R9),=A(CRDFCHN)
         BE    CRALLFIN
.CRD24N  ANOP
         L     R15,=F'-1'   error return
CRALLFIN DS    0H
         RETURN (14,12),RC=(15)
         LTORG
*
*
         AIF   ('&ZSYS' NE 'S390').CRD390P
         DS    0F
CRIRB    DS    24F
CRORB    DS    0F
         DC    F'0'
         DC    X'0080FF00'  Logical-Path Mask (enable all?) + format-1
         DC    A(CRDCHN)
         DC    5F'0'
.CRD390P ANOP
*
*
         DS    0D
         AIF   ('&ZSYS' EQ 'S390').CRD390I
* X'0A' = read inquiry
CRDCHN   CCW   X'0A',0,X'20',0    20 = ignore length issues
         AGO   .CRD390J
.CRD390I ANOP
CRDCHN   CCW1  X'0A',0,X'20',0    20 = ignore length issues
.CRD390J ANOP
CRDFCHN  EQU   *
         DS    0D
CRWTNER  DC    X'060E0000'  I/O, machine check, EC, wait, DAT on
         DC    A(AMBIT)     no error
CRNEWIO  DC    X'000C0000'  machine check, EC, DAT off
         DC    A(AMBIT+CRCONT)  continuation after I/O request
*
         DROP  ,
*
*
*
*
*
**********************************************************************
*                                                                    *
*  @@C3270R - read from 3270 console                                 *
*                                                                    *
*  parameter 1 = buffer length                                       *
*  parameter 2 = buffer                                              *
*                                                                    *
**********************************************************************
         ENTRY @@C3270R
@@C3270R DS    0H
         SAVE  (14,12),,@@C3270R
         LR    R12,R15
         USING @@C3270R,R12
         USING PSA,R0
*
         L     R10,=V(@@CONSDN) Device number
         L     R10,0(R10)
         L     R7,0(R1)        Bytes to read
         L     R2,4(R1)        Buffer to read into
         AIF   ('&ZSYS' EQ 'S390').C3R390G
         STCM  R2,B'0111',C3RCHN+1   This requires BTL buffer
         STH   R7,C3RCHN+6     Store length in READ CCW
         AGO   .C3R390H
.C3R390G ANOP
         ST    R2,C3RCHN+4
         STH   R7,C3RCHN+2
.C3R390H ANOP
*
* Interrupt needs to point to CUCONT now, for an
* unsolicited interrupt.
*
         MVC   FLCINPSW(8),CUNEWIO
         STOSM FLCINPSW,X'00'  Work with DAT on or OFF
*
         LPSW  C3RWTNER     Wait for an interrupt
         DC    H'0'
CUCONT   DS    0H           Interrupt will automatically come here
*
* Interrupt needs to point to C3CONT now. Again, I would hope for
* something more sophisticated in PDOS than this continual
* initialization.
*
         MVC   FLCINPSW(8),C3NEWIO
         STOSM FLCINPSW,X'00'  Work with DAT on or OFF
* R3 points to CCW chain
         LA    R3,C3RCHN
         ST    R3,FLCCAW    Store in CAW
*
*
         AIF   ('&ZSYS' EQ 'S390').C3R31M
         SIO   0(R10)
*         TIO   0(R10)
         AGO   .C3R24M
.C3R31M  ANOP
         LR    R1,R10       R1 needs to contain subchannel
         LA    R9,C3RIRB
         TSCH  0(R9)        Clear pending interrupts
         LA    R10,C3RORB
         MSCH  0(R10)
         TSCH  0(R9)        Clear pending interrupts
         SSCH  0(R10)
.C3R24M  ANOP
*
*
         LPSW  C3RWTNER     Wait for an interrupt
         DC    H'0'
C3RCONT  DS    0H           Interrupt will automatically come here
         AIF   ('&ZSYS' EQ 'S390').C3R31N
         SH    R7,FLCCSW+6  Subtract residual count to get bytes read
         LR    R15,R7
* After a successful CCW chain, CSW should be pointing to end
         CLC   FLCCSW(4),=A(C3RFCHN)
         BE    C3RALFIN
         AGO   .C3R24N
.C3R31N  ANOP
         TSCH  0(R9)
         SH    R7,10(R9)
         LR    R15,R7
         CLC   4(4,R9),=A(C3RFCHN)
         BE    C3RALFIN
.C3R24N  ANOP
         L     R15,=F'-1'   error return
C3RALFIN DS    0H
         RETURN (14,12),RC=(15)
         LTORG
*
*
         AIF   ('&ZSYS' NE 'S390').C3R390P
         DS    0F
C3RIRB   DS    24F
C3RORB   DS    0F
         DC    F'0'
         DC    X'0080FF00'  Logical-Path Mask (enable all?) + format-1
         DC    A(C3RCHN)
         DC    5F'0'
.C3R390P ANOP
*
*
         DS    0D
         AIF   ('&ZSYS' EQ 'S390').C3R390I
* X'06' = read modified
C3RCHN   CCW   X'06',0,X'20',0    20 = ignore length issues
         AGO   .C3R390J
.C3R390I ANOP
C3RCHN   CCW1  X'06',0,X'20',0    20 = ignore length issues
.C3R390J ANOP
C3RFCHN  EQU   *
         DS    0D
C3RWTNER DC    X'060E0000'  I/O, machine check, EC, wait, DAT on
         DC    A(AMBIT)     no error
C3NEWIO  DC    X'000C0000'  machine check, EC, DAT off
         DC    A(AMBIT+C3RCONT)  continuation after I/O request
CUNEWIO  DC    X'000C0000'  machine check, EC, DAT off
         DC    A(AMBIT+CUCONT)  continuation after I/O request
*
         DROP  ,
*
*
*
*
*
***********************************************************************
*                                                                     *
*  CALL @@DYNAL,(rb)                                                  *
*                                                                     *
*  Execute DYNALLOC (SVC 99)                                          *
*                                                                     *
*  Caller must provide a request block, in conformance with the       *
*  MVS documentation for this (which is very complicated)             *
*                                                                     *
***********************************************************************
         ENTRY @@SVC99
@@SVC99  DS    0H
         ENTRY @@DYNAL
@@DYNAL  DS    0H
         SAVE  (14,12),,@@DYNAL   Save caller's regs.
         LR    R12,R15
         USING @@DYNAL,R12
         LR    R11,R1
*
         GETMAIN RU,LV=WORKLEN,SP=SUBPOOL
         ST    R13,4(,R1)
         ST    R1,8(,R13)
         LR    R13,R1
         LR    R1,R11
         USING WORKAREA,R13
*
* Note that the SVC requires a pointer to the pointer to the RB.
* Because this function (not SVC) expects to receive a standard
* parameter list, where R1 so happens to be a pointer to the
* first parameter, which happens to be the address of the RB,
* then we already have in R1 exactly what SVC 99 needs.
*
* Except for one thing. Technically, you're meant to have the
* high bit of the pointer on. So we rely on the caller to have
* the parameter in writable storage so that we can ensure that
* we set that bit.
*
         L     R2,0(R1)
         O     R2,=X'80000000'
         ST    R2,0(R1)
         SVC   99
         LR    R2,R15
*
RETURN99 DS    0H
         LR    R1,R13
         L     R13,SAVEAREA+4
         FREEMAIN RU,LV=WORKLEN,A=(1),SP=SUBPOOL
*
         LR    R15,R2             Return success
         RETURN (14,12),RC=(15)   Return to caller
*
         DROP  R12
***********************************************************************
*
*  SETJ - SAVE REGISTERS INTO ENV
*
***********************************************************************
         ENTRY @@SETJ
         USING @@SETJ,R15
@@SETJ   L     R15,0(R1)          get the env variable
         STM   R0,R14,0(R15)      save registers to be restored
         LA    R15,0              setjmp needs to return 0
         BR    R14                return to caller
         LTORG ,
*
***********************************************************************
*
*  LONGJ - RESTORE REGISTERS FROM ENV
*
***********************************************************************
         ENTRY @@LONGJ
         USING @@LONGJ,R15
@@LONGJ  L     R2,0(R1)           get the env variable
         L     R15,60(R2)         get the return code
         LM    R0,R14,0(R2)       restore registers
         BR    R14                return to caller
         LTORG ,
**********************************************************************
*                                                                    *
* DOLOOP - dummy function                                            *
*                                                                    *
**********************************************************************
         ENTRY @@DOLOOP
@@DOLOOP DS    0H
         BR    R14
*
*
*
***********************************************************************
*
*  GETPFX - dummy function
*
***********************************************************************
         ENTRY @@GETPFX
         USING @@GETPFX,R15
         LA    R15,0
@@GETPFX BR    R14
         LTORG ,
*
* S/370 doesn't support switching modes so this code is useless,
* and won't compile anyway because "BSM" is not known.
*
         AIF   ('&ZSYS' EQ 'S370').NOMODE If S/370 we can't switch mode
***********************************************************************
*
*  SETM24 - Set AMODE to 24
*
***********************************************************************
         ENTRY @@SETM24
         USING @@SETM24,R15
@@SETM24 ICM   R14,8,=X'00'       Sure hope caller is below the line
         BSM   0,R14              Return in amode 24
*
***********************************************************************
*
*  SETM31 - Set AMODE to 31
*
***********************************************************************
         ENTRY @@SETM31
         USING @@SETM31,R15
@@SETM31 ICM   R14,8,=X'80'       Set to switch mode
         BSM   0,R14              Return in amode 31
         LTORG ,
*
.NOMODE  ANOP  ,                  S/370 doesn't support MODE switching
*
*
*
         DS    0H
MSGSTAR  DC    C'MSG * '
ABMSG    DS    2C                 Extra characters for MSG * move
ABRDW    DS    4C                 Storage for a RDW
ABUFFER  DS    CL250
WORKAREA DS    0F
SAVEAREA DS    18F
PARM1    DS    F
PARM2    DS    F
PARM3    DS    F
WORKLEN  EQU   *-WORKAREA
*
ZDCBAREA DS    0H
         DS    CL(INDCBLN)
         DS    CL(OUTDCBLN)
SAVEADCB DS    18F                Register save area for PUT
RDEOF    DS    1F
ASMBUF   DS    A                  Pointer to an area for PUTing data
         ORG   ZDCBAREA           Overlay the DCB DSECT
*         DCBD  DSORG=PS,DEVD=DA  Map Data Control Block
         ORG
OPENCLOS DS    F                  OPEN/CLOSE parameter list
         DS    0H
EOFR24   DS    CL(EOFRLEN)
*         IHADECB DSECT=NO         Data Event Control Block
BLKSIZE  DS    F                  Save area for input DCB BLKSIZE
LRECL    DS    F                  Save area for input DCB LRECL
BUFFADDR DS    F                  Location of the BLOCK Buffer
BUFFEND  DS    F                  Address after end of current block
BUFFCURR DS    F                  Current record in the buffer
VBSADDR  DS    F                  Location of the VBS record build area
VBSEND   DS    F                  Addr. after end VBS record build area
VBSCURR  DS    F                  Location to store next byte
RDRECPTR DS    F                  Where to store record pointer
RDLENPTR DS    F                  Where to store read length
JFCBPTR  DS    F
JFCB     DS    0F
         IEFJFCBN LIST=YES        SYS1.AMODGEN JOB File Control Block
* Format 1 Data Set Control Block
DSCB     DS    0F
*         IECSDSL1 (1)             Map the Format 1 DSCB
DSCBCCHH DS    CL5                CCHHR of DSCB returned by OBTAIN
         DS    CL47               Rest of OBTAIN's 148 byte work area
CLOSEMB  DS    CL(CLOSEMLN)
         DS    0F
OPENMB   DS    CL(OPENMLN)
         DS    0F
WOPENMB  DS    CL(WOPENMLN)
MEMBER24 DS    CL8
ZDCBLEN  EQU   *-ZDCBAREA
         IEZIOB                   Input/Output Block
*
         CVT   DSECT=YES
         IKJTCB
         IEZJSCB
         IHAPSA
         IHARB
         IHACDE
         IHASVC
         END
