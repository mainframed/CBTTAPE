         MACRO
         RCPTYPE &T
         GBLC  &RCPTYPE
         LCLA  &I,&K
&K       SETA  K'&T
&RCPTYPE SETC  ''
         AIF   (&K EQ 0).EXIT
&RCPTYPE SETC  'C'
.LOOP    ANOP
&I       SETA  &I+1
         AIF   ('&T'(&I,1) LT '0' OR '&T'(&I,1) GT '9').EXIT
         AIF   (&I LT &K).LOOP
&RCPTYPE SETC  'N'
.EXIT    MEND
