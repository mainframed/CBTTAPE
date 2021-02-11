         MACRO
&NAME    RCPLINK &MODULE
         LCLC  &OFFSET,&C
         AIF   ('&MODULE' EQ '').ERROR
         AIF   ('&MODULE' NE 'IKJPARS').T1
&OFFSET  SETC  '524'
         AGO   .START
.T1      AIF   ('&MODULE' NE 'IKJDAIR').T2
&OFFSET  SETC  '732'
         AGO   .START
.T2      AIF   ('&MODULE' NE 'IKJEHDEF').T3
&OFFSET  SETC  '736'
         AGO   .START
.T3      AIF   ('&MODULE' NE 'IKJEHCIR').T4
&OFFSET  SETC  '740'
         AGO   .START
.T4      AIF   ('&MODULE' NE 'IKJPUTL').T5
&OFFSET  SETC  '444'
         AGO   .START
.T5      AIF   ('&MODULE' NE 'IKJGETL').T6
&OFFSET  SETC  '348'
         AGO   .START
.T6      AIF   ('&MODULE' NE 'IKJSCAN').T7
&OFFSET  SETC  '480'
         AGO   .START
.T7      AIF   ('&MODULE' NE 'IKJPTGT').T8
&OFFSET  SETC  '464'
         AGO   .START
.T8      AIF   ('&MODULE' NE 'IKJSTCK').T9
&OFFSET  SETC  '472'
         AGO   .START
.T9      ANOP
&NAME    DS    0H
*
 MNOTE *,' EP OF &MODULE. NOT IN CVT. STANDARD LINK USED'
*
         AGO   .LINK
.START   ANOP
&NAME    L     R15,16                  LOAD CVT ADDRESS
         L     R15,&OFFSET.(R15)       LOAD MODULE ADDRESS
         LTR   R15,R15                 IS MODULE ADDRESS THERE?
&C       SETC  'RCP&SYSNDX'
         BNM   &C.L                     IF NOT, BRANCH TO LINK
         BALR  R14,R15                  ELSE BALR TO IT
         B     &C.B                      AND BYPASS LINK
&C.L     LINK  EP=&MODULE
&C.B     DS    0H                      BRANCHED TO IF LINK BYPASSED
         MEXIT
.LINK    ANOP
&NAME    LINK  EP=&MODULE
         MEXIT
.ERROR   MNOTE 4,'NO MODULE NAME SPECIFIED'
         MEND
