         MACRO
         RCPBTU &KEY,&NUM,&PAR
         LCLA  &L
.*
.*  INNER MACRO FOR ALLOC, TO GENERATE TEXT UNITS ENTERED
.*  IN QUOTES
.*
&L       SETA  K'&PAR-2                GET LENGTH OF TEXT UNIT
         MVI   S99TUKEY+1,&KEY         SET TEXT UNIT KEY
         MVI   S99TUNUM+1,&NUM         SET NUMBER FIELD
         MVI   S99TULNG+1,&L           MOVE IN LENGTH
         MVC   S99TUPAR(&L.),=C&PAR    MOVE IN TEXT UNIT
&L       SETA  &L+6
         AIF   (&L/2 EQ (&L+1)/2).LOK
&L       SETA  &L+1
.LOK     RCPDINC &L
         MEND
