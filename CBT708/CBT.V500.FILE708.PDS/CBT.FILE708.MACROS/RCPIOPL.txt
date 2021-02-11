         MACRO
&NAME    RCPIOPL
         GBLC  &RCPPRE
         GBLB  &RCPIOPL(2)
         GBLB  &RCPSTPB(2),&RCPPTPB(2),&RCPPGPB(2),&RCPGTPB(2)
         LCLC  &P,&L,&L1
&P       SETC  '&RCPPRE'
         EJECT
         AIF   (&RCPIOPL(2)).BYPIOPL
&RCPIOPL(2) SETB 1
         IKJIOPL
L#IOPL   EQU   *-IOPL                  LENGTH OF IO PARAM LIST
&SYSECT  CSECT                         RESUME PROGRAM CSECT
         SPACE 3
.BYPIOPL RCPDS
&P.IOPL  DS    CL(L#IOPL)              RESERVE SPACE FOR IOPL
         RCPDS
         SPACE 5
***********************************************************************
***   THIS CODE GENERATES AN I/O SERVICE ROUTINE PARAMETER LIST     ***
***********************************************************************
         LA    R1,&P.IOPL              LOAD IOPL ADDRESS
         USING IOPL,R1                 IOPL ADDRESSABLE
         MVC   IOPLUPT,CPPLUPT         MOVE IN ADDRESS OF UPT
         MVC   IOPLECT,CPPLECT         MOVE IN ADDRESS OF ECT
         LA    R15,&P.ECB              LOAD ADDRESS OF ATTN ECB
         ST    R15,IOPLECB             AND STORE IN IOPL
         DROP  R1
  AIF (&RCPSTPB(1) OR &RCPGTPB(1) OR &RCPPGPB(1) OR &RCPPTPB(1)).I
         MEXIT
.I       EJECT
         AIF   (NOT &RCPSTPB(1) OR &RCPSTPB(2)).TPT
         IKJSTPB
&RCPSTPB(2) SETB 1
L#STPB   EQU   *-STPB         LENGTH OF STPB
&SYSECT  CSECT
.TPT     AIF   (NOT &RCPPTPB(1) OR &RCPPTPB(2)).TGT
         IKJPTPB
&RCPPTPB(2) SETB 1
L#PTPB   EQU   *-PTPB         LENGTH OF PTPB
&SYSECT  CSECT
.TGT     AIF   (NOT &RCPGTPB(1) OR &RCPGTPB(2)).TPG
         IKJGTPB
&RCPGTPB(2) SETB 1
L#GTPB   EQU   *-GTPB         LENGTH OF GTPB
&SYSECT  CSECT
.TPG     AIF   (NOT &RCPPGPB(1) OR &RCPPGPB(2)).STO
         IKJPGPB
&RCPPGPB(2) SETB 1
L#PGPB   EQU   *-PGPB         LENGTH OF PGPB
&SYSECT  CSECT
.STO     SPACE 3
&L       SETC  ''
         RCPDS
         AIF   (NOT &RCPSTPB(1)).XPT
&P.STPB  DS    CL(L#STPB)              RESERVE SPACE FOR STPB
&L       SETC  '&L.+L#STPB'
.XPT     AIF   (NOT &RCPPTPB(1)).XGT
&P.PTPB  DS    CL(L#PTPB)              RESERVE SPACE FOR PTPB
&L       SETC  '&L.+L#PTPB'
.XGT     AIF   (NOT &RCPGTPB(1)).XPG
&P.GTPB  DS    CL(L#GTPB)              RESERVE SPACE FOR GTPB
&L       SETC  '&L.+L#GTPB'
.XPG     AIF   (NOT &RCPPGPB(1)).XC
&P.PGPB  DS    CL(L#PGPB)              RESERVE SPACE FOR PGPB
&L       SETC  '&L.+L#PGPB'
.XC      RCPDS
&L1      SETC  '&L'(2,K'&L-1)
&L       SETC  '&P'.'&L1'(3,4)
         XC    &L.(&L1.),&L            CLEAR IOPB AREA
         MEND
