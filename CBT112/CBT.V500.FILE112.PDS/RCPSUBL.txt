         MACRO - BREAK DOWN A SUBLIST
         RCPSUBL &L
         GBLA  &RCPSUB#                NO OF ELEMENTS FOUND
         GBLC  &RCPSUBL(100)           ELEMENTS
         LCLA  &I,&J,&K
&RCPSUB# SETA  0                       INITIALIZE
         AIF   ('&L' EQ '').EXIT       EXIT IF NULL STRING
         AIF   ('&L'(1,1) NE '(').NOSUB
&K       SETA  K'&L-1
&I       SETA  2
&J       SETA  1
.LOOP    ANOP
&J       SETA  &J+1
         AIF   (&J  GT &K).LAST
         AIF   ('&L'(&J,1) NE ',').LOOP
&RCPSUB# SETA &RCPSUB#+1
         AIF   (&J EQ &I).NULL
&RCPSUBL(&RCPSUB#) SETC '&L'(&I,&J-&I)
&I       SETA  &J+1
         AGO   .LOOP
.NULL    ANOP
&RCPSUBL(&RCPSUB#) SETC ''
&I       SETA  &J+1
         AGO   .LOOP
.LAST    AIF   (&J EQ &I).LASTNUL
&RCPSUB# SETA  &RCPSUB#+1
&RCPSUBL(&RCPSUB#) SETC '&L'(&I,&J-&I)
         AGO   .EXIT
.LASTNUL ANOP
&RCPSUB# SETA  &RCPSUB#+1
&RCPSUBL(&RCPSUB#) SETC ''
         AGO   .EXIT
.NOSUB   ANOP
&RCPSUBL(1) SETC '&L'
&RCPSUB# SETA 1
.EXIT    MEND
