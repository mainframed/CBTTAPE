         MACRO
&NAME    RCPENDD
         GBLB  &RCPECT(2),&RCPUPT(2),&RCPPSCB(2),&RCPS99(2)
         GBLC  &RCPPRE,&RCPWKDS,&RCPDS
         LCLC  &P,&CS
&CS      SETC  '&RCPDS'                PROGRAM CSECT
         AIF   (NOT &RCPS99(1)).TDS
         DYNSPACE
.TDS     AIF   ('&RCPWKDS' EQ '').RCPDS
         DS    0D                      ALIGN TO DOUBLEWORD
&P       SETC  '&RCPPRE'
&P.WKLEN EQU   *-&RCPWKDS              LENGTH OF WORK AREA
.RCPDS   RCPDS
         EJECT
         AIF   (NOT &RCPECT(1) OR &RCPECT(2)).TRYUPT
         IKJECT
&CS      CSECT                         REENTER MAIN CSECT
         EJECT
&RCPECT(2)     SETB           1
.TRYUPT  AIF   (NOT &RCPUPT(1) OR &RCPUPT(2)).TRYPSCB
         IKJUPT
&CS      CSECT                         REENTER MAIN CSECT
         EJECT
&RCPUPT(2) SETB  1
.TRYPSCB AIF   (NOT &RCPPSCB(1) OR &RCPPSCB(2)).TRYS99
         IKJPSCB
&CS      CSECT                         REENTER MAIN CSECT
         EJECT
&RCPPSCB(2) SETB  1
.TRYS99  AIF   (NOT &RCPS99(1) OR &RCPS99(2)).TRYREST
         IEFZB4D0
         EJECT
         IEFZB4D2
&CS      CSECT                         REENTER MAIN CSECT
         EJECT
&RCPS99(2) SETB  1
.TRYREST MEND
