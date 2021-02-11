         MACRO  - BUILD TEXT UNIT FROM BUFFER
         RCPTUBFR &KEY,                TEXT UNIT KEY                   X
               &L,                     MAXIMUM LENGTH VALUE            X
               &C,                     TEXT UNIT                       X
               &N=1                    TEXT UNIT NUMBER
         GBLC  &EXECNAM
         LCLC  &C1,&C2
         LCLA  &I,&K
         MVI   S99TUKEY+1,&KEY         SET TEXT UNIT KEY
         AIF   ('&N' EQ '' OR '&N' EQ '1').N1
         LA    R14,&N                  LOAD TEXT UNIT NUMBER
         STH   R14,S99TUNUM             AND STORE INTO TEXT UNIT
         AGO   .ENDN
.N1      MVI   S99TUNUM+1,1            SET TEXT UNIT NUMBER
.ENDN    ANOP
&K       SETA  K'&C
&I       SETA  &K-1
.LOOP1   ANOP
&K       SETA  &K-1
         AIF   (&K LE 0).STD
         AIF   ('&C'(&K,1) NE '/').LOOP1
&C2      SETC  '&C'(&K+1,&I-&K)
&C1      SETC  '&C'(1,&K-1)
         AIF   ('&C1'(1,1) NE '(').TC2
&C1      SETC  '0&C1'
.TC2     AIF   ('&C2' EQ '0000').V2B
         AIF   ('&C2' EQ '00').V1B
         AIF   ('&C2' EQ '0').V0B
         AIF   ('&C2'(1,1) EQ '(').RL
         MVI   S99TULNG+1,&C2          SET LENGTH FIELD
         MVC   S99TUPAR(&C2.),&C1      MOVE IN TEXT UNIT
         RCPDINC &L
         MEXIT
.STD     ANOP
&K       SETA  &L-6
         MVI   S99TULNG+1,&K           SET TEXT UNIT LENGTH
&C1      SETC  '&C'(1,&I)              REMOVE TRAILING SLASH
         MVC   S99TUPAR(&K),&C1        MOVE IN TEXT UNIT
         RCPDINC &L
         MEXIT
.V2B     LH    R14,&C1                 LOAD TEXT UNIT LENGTH
         S     R14,=A(4)               EXCLUDE LENGTH OF HEADER
&C1      SETC  '4+&C1'
         AGO   .MOVE
.V1B     LH    R14,&C1                 LOAD TEXT UNIT LENGTH
&C1      SETC  '2+&C1'
         AGO   .MOVE
.V0B     SLR   R14,R14                 CLEAR FOR IC
         IC    R14,&C1                 INSERT TEXT UNIT LENGTH
&C1      SETC  '1+&C1'
         AGO   .MOVE
.RL      ANOP
&C2      SETC  '&C2'(2,K'&C2-2)
         LR    R14,&C2                 LOAD TEXT UNIT LENGTH
.MOVE    STH   R14,S99TULNG             AND STORE INTO LENGTH FIELD
         BCTR  R14,0                   GET MACHINE LENGTH
         EXECUTE ,MVC,S99TUPAR-S99TUNIT(0,R15),&C1
         EX    R14,&EXECNAM            MOVE IN TEXT UNIT
         RCPDINC &L
         MEND
