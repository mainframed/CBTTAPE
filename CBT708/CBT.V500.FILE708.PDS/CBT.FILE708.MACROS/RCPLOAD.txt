         MACRO
&NAME    RCPLOAD &MOD,&EP1
         GBLC  &RCPPTEP,&RCPGTEP,&RCPPGEP
         GBLC  &RCPDFEP,&RCPSTEP,&RCPPREP
         GBLC  &RCPPRE
         LCLA  &I,&J
         LCLB  &EPXISTS
         LCLC  &OFFSET,&C,&EP,&MODULE
&EP      SETC  '&EP1'
&MODULE  SETC  '&MOD'
         AIF   ('&MODULE' EQ '').ERROR
         AIF   ('&MODULE'(K'&MOD,1) NE ')').NOBR
&I       SETA  K'&MOD
.LOOP    ANOP
&I       SETA  &I-1
         AIF   (&I LT 2).NOLB
         AIF   ('&MOD'(&I,1) NE '(').LOOP
&MODULE  SETC  '&MOD'(1,&I-1)
&J       SETA  K'&MOD-1-&I
&EP      SETC  '&MOD'(&I+1,&J)
         RCPDS
&EP      DS    F                       TO STORE MODULE ADDRESS
         RCPDS
.NOBR    ANOP
&EPXISTS  SETB  ('&EP' NE '')
         AIF   ('&MODULE' NE 'IKJPARS').T1
&OFFSET  SETC  '524'
&RCPPREP SETC '&EP'
         AIF   (&EPXISTS).START
         RCPDS
&RCPPREP SETC '&RCPPRE.PREP'
&EP      SETC  '&RCPPREP'
&RCPPREP DS    F                       TO HOLD ADDRESS OF IKJPARS
         RCPDS
         AGO   .START
.T1      AIF   ('&MODULE' NE 'IKJDAIR').T2
&OFFSET  SETC  '732'
         AGO   .START
.T2      AIF   ('&MODULE' NE 'IKJEHDEF').T3
&RCPDFEP SETC  '&EP'
&OFFSET  SETC  '736'
         AIF   (&EPXISTS).START
&RCPDFEP SETC  '&RCPPRE.DFEP'
         RCPDS
&RCPDFEP DS    F                       ADDR OF DEFAULT SERVICE ROUTINE
         RCPDS
&EP      SETC  '&RCPDFEP'
         AGO   .START
.T3      AIF   ('&MODULE' NE 'IKJEHCIR').T4
&OFFSET  SETC  '740'
         AGO   .START
.T4      AIF   ('&MODULE' NE 'IKJPUTL').T5
&RCPPTEP SETC  '&EP'
&OFFSET  SETC  '444'
         AIF   (&EPXISTS).START
&RCPPTEP SETC  '&RCPPRE.PTEP'
&EP      SETC  '&RCPPTEP'
         RCPDS
&RCPPTEP DS    F                       ADDR OF PUTLINE ROUTINE
         RCPDS
         AGO   .START
.T5      AIF   ('&MODULE' NE 'IKJGETL').T6
&RCPGTEP SETC  '&EP'
&OFFSET  SETC  '348'
         AIF   (&EPXISTS).START
&RCPGTEP SETC  '&RCPPRE.GTEP'
&EP      SETC  '&RCPGTEP'
         RCPDS
&RCPGTEP DS    F                       ADDR OF GETLINE ROUTINE
         RCPDS
         AGO   .START
.T6      AIF   ('&MODULE' NE 'IKJSCAN').T7
&OFFSET  SETC  '480'
         AGO   .START
.T7      AIF   ('&MODULE' NE 'IKJPTGT').T8
&RCPPGEP SETC  '&EP'
&OFFSET  SETC  '464'
         AIF   (&EPXISTS).START
&RCPPGEP SETC  '&RCPPRE.PGEP'
&EP      SETC  '&RCPPGEP'
         RCPDS
&RCPPGEP DS    F                       ADDR OF PUTGET ROUTINE
         RCPDS
         AGO   .START
.T8      AIF   ('&MODULE' NE 'IKJSTCK').T9
&RCPSTEP SETC  '&EP'
&OFFSET  SETC  '472'
         AIF   (&EPXISTS).START
&RCPSTEP SETC  '&RCPPRE.STEP'
&EP      SETC  '&RCPSTEP'
         RCPDS
&RCPSTEP DS    F                       ADDR OF STACK ROUTINE
         RCPDS
         AGO   .START
.T9      ANOP
&NAME    DS    0H
*
 MNOTE *,' EP OF &MODULE. NOT IN CVT. STANDARD LOAD USED'
*
         AGO   .LOAD
.START   ANOP
&NAME    L     R15,16                  LOAD CVT ADDRESS
         L     R0,&OFFSET.(R15)        LOAD MODULE ADDRESS
         LTR   R0,R0                   IS MODULE LOADED?
&C       SETC  'RCP&SYSNDX'
         BM    &C                      IF SO, BYPASS LOAD MACRO
.LOAD    LOAD EP=&MODULE.
         AIF   ('&EP' EQ '').EPERR
&C       ST    R0,&EP                  STORE ENTRY POINT ADDRESS
         MEXIT
.EPERR   MNOTE 4,'EP RETURN FIELD NOT SPECIFIED'
         MEXIT
.ERROR   MNOTE 4,'NO MODULE NAME SPECIFIED'
         MEXIT
.NOLB    MNOTE 4,'INVALID MODULE NAME ''&MOD'''
         MEND
