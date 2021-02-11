         MACRO
         RCPVCHAR &KEY,&LEN,&C,&N=1
         GBLC  &DYNP
         AIF   ('&C'(K'&C,1) EQ '/').BM
         AIF   ('&C'(1,1) EQ '''').QM
         RCPSR2
         AIF   ('&C'(1,1) EQ '(').RM
         LH    R2,&C+4                 LOAD LENGTH OF TEXT UNIT
         LTR   R2,R2                   TEST FOR ZERO
         BZ    *+30                    IF NO TEXT UNIT, SKIP
         L     R14,&C                  LOAD ADDRESS OF TEXT UNIT
         AGO   .STHM
.RM      LH    R2,4&C                  LOAD LENGTH OF TEXT UNIT
         LTR   R2,R2                   AND TEST FOR ZERO
         BZ    *+30                    IF NO TEXT UNIT, SKIP
         L     R14,0&C                 LOAD ADDRESS OF TEXT UNIT
.STHM    STH   R2,S99TULNG             STORE LENGTH OF TEXT UNIT
         BCTR  R2,0                    DECREMENT FOR EXECUTE
         EX    R2,&DYNP.MVC            MOVE IN TEXT UNIT
         MVI   S99TUKEY+1,&KEY         MOVE IN TEXT UNIT KEY
         AIF   ('&N' EQ '1' OR '&N' EQ '').N1
         LA    R14,&N                  LOAD TEXT UNIT NUMBER
         STH   R14,S99TUNUM             AND STORE IT IN TEXT UNIT
         AGO   .ENDN
.N1      MVI   S99TUNUM+1,1            SET NUMBER FIELD
.ENDN    RCPDINC &LEN
         MEXIT
.BM      RCPTUBFR &KEY,&LEN,&C
         MEXIT
.QM      RCPBTU &KEY,&N,&C
         MEND
