         MACRO
         RCPBTU &KEY,&NUM,&PAR
         GBLA  &DTUPO
         GBLC  &DYNP
         LCLA  &L
.*
.*  INNER MACRO FOR ALLOC, TO BRANCH AROUND TEXT UNIT AND
.*  CREATE TEXT UNIT
.*
&L       SETA  K'&PAR+8                GET LENGTH TO BRANCH AROUND
         AIF   (&L/2 EQ (&L+1)/2).LOK  MAKE SURE LENGTH IS EVEN
&L       SETA  &L+1
.LOK     BAL   R14,*+&L                BRANCH AROUND TEXT UNIT
&L       SETA  K'&PAR-2
         DC    Y(&KEY,&NUM,&L),C&PAR   TEXT UNIT
         LA    R14,0(R14)              CLEAR HIGH ORDER BYTE
         ST    R14,&DYNP.TUP+&DTUPO    STORE TEXT UNIT ADDRESS
&DTUPO   SETA  &DTUPO+4
         MEND
