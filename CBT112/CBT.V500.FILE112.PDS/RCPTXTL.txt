         MACRO - TO COUNT CHARACTERS IN A STRING
         RCPTXTL &S
         GBLA  &RCPTXTL
         LCLA  &I,&K,&L
&RCPTXTL SETA  0
         AIF   (K'&S LT 3).MEND
&RCPTXTL SETA  K'&S-2
&L       SETA  &RCPTXTL
&I       SETA  1
.LOOP    ANOP
&I       SETA  &I+1
.LOOP2   AIF   (&I GT &L).MEND
         AIF   ('&S'(&I,2) NE '''''' AND '&S'(&I,2) NE '&&').LOOP
&I       SETA  &I+2
&RCPTXTL SETA  &RCPTXTL-1
         AGO   .LOOP2
.MEND    MEND
