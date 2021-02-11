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
         REGS
         MUSVC
SUBPOOL  EQU   0
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
         ENTRY $$AOPEN
$$AOPEN  DS    0H
         ENTRY @@AOPEN
@@AOPEN  DS    0H
         SAVE  (14,12),,@@AOPEN
         LR    R12,R15
         USING @@AOPEN,R12
         LR    R11,R1
         GETMAIN R,LV=WORKLEN,SP=SUBPOOL
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
         AIF   ('&ZSYS' EQ 'S390').BELOW
* CAN'T USE "BELOW" ON MVS 3.8
         GETMAIN R,LV=ZDCBLEN,SP=SUBPOOL
         AGO   .CHKBLWE
.BELOW   ANOP
         GETMAIN R,LV=ZDCBLEN,SP=SUBPOOL,LOC=BELOW
.CHKBLWE ANOP
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
         BNZ   WRITING
* READING
         USING IHADCB,R2
         MVC   ZDCBAREA(INDCBLN),INDCB
         LA    R10,JFCB
* EXIT TYPE 07 + 80 (END OF LIST INDICATOR)
         ICM   R10,B'1000',=X'87'
         ST    R10,JFCBPTR
         LA    R10,JFCBPTR
         LA    R4,ENDFILE
         ST    R4,DCBEODAD
         ST    R10,DCBEXLST
         MVC   DCBDDNAM,0(R3)
         MVC   OPENMB,OPENMAC
*
         RDJFCB ((R2),INPUT)
         LTR   R9,R9
         BZ    NOMEM
         USING ZDCBAREA,R2
         MVC   JFCBELNM,0(R9)
         OI    JFCBIND1,JFCPDS
NOMEM    DS    0H
*         OPEN  ((R2),INPUT),MF=(E,OPENMB),MODE=31,TYPE=J
* CAN'T USE MODE=31 ON MVS 3.8, OR WITH TYPE=J
         OPEN  ((R2),INPUT),MF=(E,OPENMB),TYPE=J
         TM    DCBOFLGS,DCBOFOPN  Did OPEN work?
         BZ    BADOPEN            OPEN failed
         B     DONEOPEN
WRITING  DS    0H
         USING ZDCBAREA,R2
         MVC   ZDCBAREA(OUTDCBLN),OUTDCB
         LA    R10,JFCB
* EXIT TYPE 07 + 80 (END OF LIST INDICATOR)
         ICM   R10,B'1000',=X'87'
         ST    R10,JFCBPTR
         LA    R10,JFCBPTR
         ST    R10,DCBEXLST
         MVC   DCBDDNAM,0(R3)
         MVC   WOPENMB,WOPENMAC
*
         RDJFCB ((R2),OUTPUT)
*        LTR   R9,R9
         BZ    WNOMEM
         USING ZDCBAREA,R2
         MVC   JFCBELNM,0(R9)
         OI    JFCBIND1,JFCPDS
WNOMEM   DS    0H
*         OPEN  ((R2),OUTPUT),MF=(E,WOPENMB),MODE=31,TYPE=J
* CAN'T USE MODE=31 ON MVS 3.8, OR WITH TYPE=J
         OPEN  ((R2),OUTPUT),MF=(E,WOPENMB),TYPE=J
         TM    DCBOFLGS,DCBOFOPN  Did OPEN work?
         BZ    BADOPEN            OPEN failed
*
* Handle will be returned in R7
*
         LR    R7,R2
         AIF   ('&OUTM' NE 'M').NMM4
         L     R6,=F'32768'
* Give caller an internal buffer to write to. Below the line!
*
* S/370 can't handle LOC=BELOW
*
         AIF   ('&ZSYS' NE 'S370').MVT8090 If not S/370 then 380 or 390
         GETMAIN R,LV=(R6),SP=SUBPOOL  No LOC= for S/370
         AGO   .GETOENE
.MVT8090 ANOP  ,                  S/380 or S/390
         GETMAIN R,LV=(R6),SP=SUBPOOL,LOC=BELOW
.GETOENE ANOP
         ST    R1,ASMBUF
         L     R5,20(,R11)        R5 points to ASMBUF
         ST    R1,0(R5)           save the pointer
* R5 now free again
*
.NMM4    ANOP
DONEOPEN DS    0H
         LR    R7,R2
         SR    R6,R6
         LH    R6,DCBLRECL
         ST    R6,0(R8)
         TM    DCBRECFM,DCBRECF
         BNO   VARIABLE
* This looks really whacky, but is correct
* We check for V, in order to split between F and U
* Because U has both F and V
         TM    DCBRECFM,DCBRECV
         BNO   FIXED
         L     R6,=F'2'
         B     DONESET
FIXED    DS    0H
         L     R6,=F'0'
         B     DONESET
VARIABLE DS    0H
         L     R6,=F'1'
DONESET  DS    0H
         L     R5,8(,R11)         Point to RECFM
         ST    R6,0(R5)
* Finished with R5 now
         LR    R15,R7
         B     RETURNOP
BADOPEN  DS    0H
         FREEMAIN RU,LV=ZDCBLEN,A=(R2),SP=SUBPOOL  Free DCB area
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
         FREEMAIN RU,LV=WORKLEN,A=(R1),SP=SUBPOOL
         LR    R15,R7
         RETURN (14,12),RC=(15)
         LTORG
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
         ENTRY $$AREAD
$$AREAD  DS    0H
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
         LH    R5,DCBLRECL
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
*
*
*
***********************************************************************
*
*  AWRITE - Write to an open dataset
*
***********************************************************************
         ENTRY $$AWRITE
$$AWRITE DS    0H
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
         CALL  @@SETM24
.N380WR1 ANOP
*
         STCM  R4,B'0011',DCBLRECL
*
         AIF   ('&OUTM' NE 'L').NLM2
         PUT   (R2)
.NLM2    ANOP
         AIF   ('&OUTM' NE 'M').NMM2
* In move mode, always use our internal buffer. Ignore passed parm.
         L     R3,ASMBUF
         PUT   (R2),(R3)
.NMM2    ANOP
         AIF   ('&OUTM' NE 'L').NLM3
         ST    R1,0(R3)
.NLM3    ANOP
*
         AIF   ('&ZSYS' NE 'S380').N380WR2
         CALL  @@SETM31
.N380WR2 ANOP
*
*        LR    R1,R13
*        L     R13,SAVEAREA+4
         L     R13,SAVEADCB+4
*        FREEMAIN RU,LV=WORKLEN,A=(1),SP=SUBPOOL
         RETURN (14,12),RC=0
*
**********************************************************************
*                                                                    *
*  ACLOSE - Close file                                               *
*                                                                    *
**********************************************************************
         ENTRY $$ACLOSE
$$ACLOSE DS    0H
         ENTRY @@ACLOSE
@@ACLOSE DS    0H
         SAVE  (14,12),,@@ACLOSE
         LR    R12,R15
         USING @@ACLOSE,R12
         LR    R11,R1
         AIF   ('&ZSYS' EQ 'S390').BELOW3
* CAN'T USE "BELOW" ON MVS 3.8
         GETMAIN R,LV=WORKLEN,SP=SUBPOOL
         AGO   .NOBEL3
.BELOW3  ANOP
         GETMAIN R,LV=WORKLEN,SP=SUBPOOL,LOC=BELOW
.NOBEL3  ANOP
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
         FREEMAIN RU,LV=(R6),A=(R5),SP=SUBPOOL
NFRCL    DS    0H
.NMM6    ANOP
         MVC   CLOSEMB,CLOSEMAC
*         CLOSE ((R2)),MF=(E,CLOSEMB),MODE=31
* CAN'T USE MODE=31 WITH MVS 3.8
         CLOSE ((R2)),MF=(E,CLOSEMB)
         FREEPOOL ((R2))
         FREEMAIN RU,LV=ZDCBLEN,A=(R2),SP=SUBPOOL
         LA    R15,0
*
RETURNAC DS    0H
         LR    R1,R13
         L     R13,SAVEAREA+4
         LR    R7,R15
         FREEMAIN RU,LV=WORKLEN,A=(R1),SP=SUBPOOL
         LR    R15,R7
         RETURN (14,12),RC=(15)
         LTORG
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
         ENTRY $$GETM
$$GETM   DS    0H
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
         AIF   ('&ZSYS' NE 'S380').N380GM1
*         GETMAIN RU,LV=(R3),SP=SUBPOOL,LOC=ANY
* Hardcode the ATL memory area provided by latest MUSIC.
* Note that this function will only work if the C library
* is compiled with MEMMGR option.
         L     R1,=X'02000000'
         AGO   .N380GM2
.N380GM1 ANOP
         GETMAIN RU,LV=(R3),SP=SUBPOOL
.N380GM2 ANOP
*
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
         ENTRY $$FREEM
$$FREEM  DS    0H
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
         AIF   ('&ZSYS' NE 'S380').N380FM1
* On S/380, nothing to free - using preallocated memory block
*         FREEMAIN RU,LV=(R3),A=(R2),SP=SUBPOOL
         AGO   .N380FM2
.N380FM1 ANOP
         FREEMAIN RU,LV=(R3),A=(R2),SP=SUBPOOL
.N380FM2 ANOP
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
         ENTRY $$GETCLK
$$GETCLK DS    0H
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
*
*
*
**********************************************************************
*                                                                    *
*  GETAM - get the current AMODE                                     *
*                                                                    *
*  This function returns 24 if we are running in exactly AMODE 24,   *
*  31 if we are running in exactly AMODE 31, and 64 for anything     *
*  else (user-defined/infinity/16/32/64/37)                          *
*                                                                    *
*  Be aware that MVS 3.8j I/O routines require an AMODE of exactly   *
*  24 - nothing more, nothing less - so applications are required    *
*  to ensure they are in AM24 prior to executing any I/O routines,   *
*  and then they are free to return to whichever AMODE they were in  *
*  previously (ie anything from 17 to infinity), which is normally   *
*  done using a BSM to x'01', although this instruction was not      *
*  available in S/370-XA so much software does a BSM to x'80'        *
*  instead of the user-configurable x'01', which is unfortunate.     *
*                                                                    *
*  For traditional reasons, people refer to 24, 31 and 64, when what *
*  they should really be saying is 24, 31 and user-defined.          *
*                                                                    *
**********************************************************************
         ENTRY $$GETAM
$$GETAM  DS    0H
         ENTRY @@GETAM
@@GETAM  DS    0H
         SAVE  (14,12),,@@GETAM
         LR    R12,R15
         USING @@GETAM,R12
*
         L     R2,=X'C1800000'
         LA    R2,0(,R2)
         CLM   R2,B'1100',=X'0080'
         BE    GAIS24
         CLM   R2,B'1000',=X'41'
         BE    GAIS31
         LA    R15,64
         B     RETURNGA
GAIS24   DS    0H
         LA    R15,24
         B     RETURNGA
GAIS31   LA    R15,31
*
RETURNGA DS    0H
         RETURN (14,12),RC=(15)
         LTORG ,
         SPACE 2
***********************************************************************
*                                                                     *
*  GETTZ - Get the offset from GMT in 1.048576 seconds                *
*  dummy function for MUSIC - not sure if supported                   *
*                                                                     *
***********************************************************************
         ENTRY $$GETTZ
$$GETTZ  LA    R15,0
         ENTRY @@GETTZ
@@GETTZ  LA    R15,0
         BR    R14
         SPACE 2
*
*
*
***********************************************************************
*
*  SYSTEM - execute another command
*
***********************************************************************
         ENTRY $$SYSTEM
$$SYSTEM DS    0H
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
         MVC   CMDPREF,FIXEDPRF
         L     R2,0(R1)
         CL    R2,=F'200'
         BL    LENOK
         L     R2,=F'200'
LENOK    DS    0H
         STH   R2,CMDLEN
         LA    R4,CMDTEXT
         LR    R5,R2
         L     R6,4(R1)
         LR    R7,R2
         MVCL  R4,R6
         LA    R1,CMDPREF
         SVC   $EXREQ
*
RETURNSY DS    0H
         LR    R1,R13
         L     R13,SYSTMWRK+4
         FREEMAIN RU,LV=SYSTEMLN,A=(1),SP=SUBPOOL
*
         LA    R15,0
         RETURN (14,12),RC=(15)   Return to caller
* For documentation on this fixed prefix, see SVC 221
* documentation.
FIXEDPRF DC    X'7F01E000000000'
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
*  TEXTLC - switch terminal to lower case mode
*
***********************************************************************
         ENTRY $$TEXTLC
$$TEXTLC DS    0H
         ENTRY @@TEXTLC
@@TEXTLC DS    0H
         SAVE  (14,12),,@@TEXTLC  Save caller's regs.
         LR    R12,R15
         USING @@TEXTLC,R12
         LR    R11,R1
*
         GETMAIN RU,LV=WORKLEN,SP=SUBPOOL
         ST    R13,4(,R1)
         ST    R1,8(,R13)
         LR    R13,R1
         LR    R1,R11
         USING WORKAREA,R13
*
         LA    R1,LCOPTS
         SVC   $SETOPT
*
RETURNLC DS    0H
         LR    R1,R13
         L     R13,SAVEAREA+4
         FREEMAIN RU,LV=WORKLEN,A=(1),SP=SUBPOOL
*
         LA    R15,0              Return success
         RETURN (14,12),RC=(15)   Return to caller
*
LCOPTS   DC    X'A0'              Constant
         DC    X'01'              Set bit on
         DC    X'01'              Option byte 1 (1-based)
         DC    X'06'              Bit number 6 (0-based)
***********************************************************************
*
*  IDCAMS - dummy function to keep MVS happy
*
***********************************************************************
         ENTRY $$IDCAMS
$$IDCAMS DS    0H
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
***********************************************************************
*                                                                     *
*  CALL @@SVC99,(rb)                                                  *
*                                                                     *
*  Execute DYNALLOC (SVC 99)                                          *
*                                                                     *
*  Caller must provide a request block, in conformance with the       *
*  MVS documentation for this (which is very complicated)             *
*                                                                     *
***********************************************************************
         ENTRY $$SVC99
$$SVC99  DS    0H
         ENTRY @@SVC99
@@SVC99  DS    0H
         SAVE  (14,12),,@@SVC99   Save caller's regs.
         LR    R12,R15
         USING @@SVC99,R12
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
         ENTRY $$SETJ
$$SETJ   DS    0H
         ENTRY @@SETJ
@@SETJ   DS    0H
         USING @@SETJ,R15
         L     R15,0(R1)          get the env variable
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
         ENTRY $$LONGJ
$$LONGJ  DS    0H
         ENTRY @@LONGJ
@@LONGJ  DS    0H
         USING @@LONGJ,R15
         L     R2,0(R1)           get the env variable
         L     R15,60(R2)         get the return code
         LM    R0,R14,0(R2)       restore registers
         BR    R14                return to caller
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
         IEZIOB                   Input/Output Block
*
*
WORKAREA DSECT
SAVEAREA DS    18F
WORKLEN  EQU   *-WORKAREA
*
         DCBD  DSORG=PS,DEVD=DA   Map Data Control Block
         ORG   IHADCB             Overlay the DCB DSECT
ZDCBAREA DS    0H
         DS    CL(INDCBLN)
         DS    CL(OUTDCBLN)
OPENCLOS DS    F                  OPEN/CLOSE parameter list
         DS    0H
EOFR24   DS    CL(EOFRLEN)
         IHADECB DSECT=NO         Data Event Control Block
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
         IECSDSL1 (1)             Map the Format 1 DSCB
DSCBCCHH DS    CL5                CCHHR of DSCB returned by OBTAIN
         DS    CL47               Rest of OBTAIN's 148 byte work area
SAVEADCB DS    18F                Register save area for PUT
CLOSEMB  DS    CL(CLOSEMLN)
         DS    0F
OPENMB   DS    CL(OPENMLN)
         DS    0F
WOPENMB  DS    CL(WOPENMLN)
RDEOF    DS    1F
ASMBUF   DS    A                  Pointer to an area for PUTing data
MEMBER24 DS    CL8
ZDCBLEN  EQU   *-ZDCBAREA
*
         END
