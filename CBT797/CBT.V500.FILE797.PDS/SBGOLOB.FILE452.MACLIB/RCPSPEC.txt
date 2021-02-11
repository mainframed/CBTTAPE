         MACRO - SET UP USER DEFINED TEXT UNIT
         RCPSPEC &T
         LCLA  &I,&J
&I       SETA  1
&J       SETA  K'&T
         SPACE
***********************************************************************
**       PROCESS SPECIAL TEXT UNITS                                  **
***********************************************************************
.LOOP    RCPVCHAR &T(&I),&T(&I+2),&T(&I+3),N=&T(&I+1)
&I       SETA  &I+4
         AIF   (&I LE &J).LOOP
         MEND
