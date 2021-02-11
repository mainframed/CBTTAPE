         MACRO - BREAK A RANGE PARAMETER INTO TWO
         RCPRNGE &P
         GBLC  &RCPRNGE(2)
         LCLA  &I,&J,&K
&K       SETA  K'&P
&RCPRNGE(1) SETC ''
&RCPRNGE(2) SETC ''
.LOOP    ANOP
&I       SETA  &I+1
         AIF   (&I GT &K).NR
         AIF   ('&P'(&I,1) NE '-' AND '&P'(&I,1) NE ':').LOOP
&RCPRNGE(1) SETC '&P'(1,&I-1)
&RCPRNGE(2) SETC '&P'(&I+1,&K-&I)
         MEXIT
.NR      ANOP
&RCPRNGE(1) SETC '&P'
         MEND
