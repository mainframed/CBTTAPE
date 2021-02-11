         MACRO
         RCPTU &TU            TEXT UNIT LIST
         GBLA  &DTUPO         TEXT UNIT POINTER OFFSET
         GBLC  &DYNP          ALLOC SYMBOL PREFIX
         LCLA  &I,&J
         LCLC  &C
         SPACE 1
***********************************************************************
**       ADD SPECIAL TEXT UNITS                                      **
***********************************************************************
&J       SETA  N'&SYSLIST
.LOOP    ANOP
&I       SETA  &I+1
         AIF   (&I GT &J).EXIT
         AIF   ('&TU(&I)'(1,1) EQ '(').R
         LA    R15,&TU(&I)             LOAD TEXT UNIT ADDRESS
         ST    R15,&DYNP.TUP+&DTUPO     AND STORE IT IN POINTER LIST
&DTUPO   SETA  &DTUPO+4
         AGO   .LOOP
.R       ANOP
&C       SETC  '&TU(&I)'(2,K'&TU(&I)-2)
         ST    &C,&DYNP.TUP+&DTUPO     STORE TEXT UNIT ADDR IN PTR LIST
&DTUPO   SETA  &DTUPO+4
         AGO   .LOOP
.EXIT    MEND
