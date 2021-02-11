         MACRO
         RCPNTU &KEY,&LEN,&PAR
.*
.*     THIS IS AN ALLOC/FREE MACRO TEXT UNIT PROCESSOR SUBROUTINE
.*     MACRO. IT BUILDS NUMERIC TYPE TEXT UNITS.
.*
         LCLA  &L,&R
         LCLC  &C
         GBLC  &RCPTYPE
.*  ALLOC/FREE INNER MACRO TO SET UP NUMERIC TEXT UNITS
&L       SETA  1                       DEFAULT LENGTH
         AIF   ('&LEN' EQ '').NL
&L       SETA  &LEN
.NL      MVI   S99TUKEY+1,&KEY         SET KEY FIELD
         MVI   S99TUNUM+1,1            SET NUMBER FIELD
         MVI   S99TULNG+1,&L           SET LENGTH FIELD
         AIF   ('&PAR'(1,1) EQ '(').REG
         RCPTYPE &PAR                  ANALYSE PARAMETER
         AIF   ('&RCPTYPE' EQ 'N').NUMERIC
&R       SETA  4-&L
         MVC   S99TUPAR(&L),&R+&PAR    MOVE IN QUANTITY
         RCPDINC 10
         MEXIT
.NUMERIC AIF   (&L EQ 1).NL1
         MVC   S99TUPAR(&L.),=AL&L.(&PAR) MOVE IN QUANTITY
&R       SETA  &L+6
         AIF   (&R/2 EQ (&R+1)/2).LOK ENSURE LENGTH EVEN
&R       SETA  &R+1
.LOK     RCPDINC &R
         MEXIT
.NL1     MVI   S99TUPAR,&PAR           MOVE IN QUANTITY
         RCPDINC 8
         MEXIT
.REG     ANOP
&C       SETC  '&PAR'(2,K'&PAR-2)
         AIF   (&L EQ 3).STCM
         AIF   (&L EQ 2).STH
         AIF   (&L EQ 1).STC
         ST    &C,S99TUPAR             STORE TEXT UNIT QUANTITY
         AGO   .RCPDINC
.STH     STH   &C,S99TUPAR             STORE TEXT UNIT QUANTITY
         AGO   .RCPDINC
.STC     STC   &C,S99TUPAR             STORE TEXT UNIT QUANTITY
         AGO   .RCPDINC
.STCM    STCM  &C,7,S99TUPAR           STORE TEXT UNIT QUANTITY
.RCPDINC RCPDINC 10
         MEND
