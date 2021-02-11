         MACRO
         RCPDS
         GBLB  &RCPDSBR
         GBLC  &RCPWKDS,&RCPWKCS,&RCPDS
         AIF   ('&RCPDS' NE '').RESUME
&RCPDS   SETC  '&SYSECT'
         AIF   ('&RCPWKDS' EQ '').CSECT
&RCPWKDS DSECT                         ENTER WORKAREA DSECT
         MEXIT
.CSECT   AIF   ('&RCPWKCS' EQ '').BRANCH
&RCPWKCS CSECT                         ENTER WORKAREA CSECT
         MEXIT
.RESUME  AIF   (&RCPDSBR).BRTO
&RCPDS   CSECT                         RESUME PROGRAM CSECT
&RCPDS   SETC  ''
         MEXIT
.BRANCH  ANOP
&RCPDS   SETC  'RCP&SYSNDX'
&RCPDSBR SETB  1
         B     &RCPDS                  BRANCH AROUND CONSTANTS
         MEXIT
.BRTO    ANOP
&RCPDS   DS    0H
&RCPDSBR SETB  0
&RCPDS   SETC  ''
         MEND
