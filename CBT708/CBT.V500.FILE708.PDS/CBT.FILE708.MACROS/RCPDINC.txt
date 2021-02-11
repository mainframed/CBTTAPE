         MACRO
         RCPDINC &L1
         GBLA  &DTUO,&DTUPO
         GBLC  &DYNP
         AIF   ('&L1' EQ '').T2
         ST    R15,&DYNP.TUP+&DTUPO    STORE TEXT UNIT ADDRESS
         LA    R15,&L1.(R15)           BUMP TEXT UNIT PTR TO NEXT SLOT
&DTUPO   SETA  &DTUPO+4
&DTUO    SETA  &DTUO+&L1
         MEXIT
.T2      ST    R14,&DYNP.TUP+&DTUPO    STORE TEXT UNIT ADDRESS
&DTUPO   SETA  &DTUPO+4
         MEND
