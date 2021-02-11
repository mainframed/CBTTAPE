         MACRO
         RCPDSN &DSN,&MEM
         LCLC  &MEMBER
         GBLC  &DYNP
         SPACE
***********************************************************************
**   BUILD THE DSNAME TEXT UNIT                                      **
***********************************************************************
         AIF   ('&DSN'(1,1) EQ '''').Q
         AIF   ('&DSN'(K'&DSN,1) EQ '/').BD
         AIF   ('&DSN'(1,1) EQ '(').REG
         AIF   ('&DSN'  EQ '*').TERM
         RCPSR2
         L     R14,&DSN                LOAD ADDRESS OF DSNAME
         LH    R2,&DSN+4               LOAD LENGTH OF DSNAME
.STH     STH   R2,S99TULNG             STORE DSNAME LENGTH
         BCTR  R2,0                    DECREMENT FOR EXECUTE
         EX    R2,&DYNP.MVC            MOVE DSNAME
         MVI   S99TUKEY+1,DALDSNAM     MOVE IN DSNAME KEY
         MVI   S99TUNUM+1,1            SET NUMBER FIELD
         RCPDINC 50
         AGO   .TMEMBER
.REG     L     R14,0&DSN               LOAD ADDRESS OF DSNAME
         RCPSR2
         LH    R2,4&DSN                LOAD LENGTH OF DSNAME
         AGO   .STH
.TERM    MVI   S99TUKEY+1,DALTERM
         RCPDINC 4
         MEXIT
.BD      RCPTUBFR DALDSNAM,50,&DSN
         AGO   .TMEMBER
.Q       RCPBTU DALDSNAM,1,&DSN
.TMEMBER AIF   ('&MEM' EQ '').EXIT
         SPACE
***********************************************************************
**   BUILD THE MEMBER NAME TEXT UNIT                                 **
***********************************************************************
&MEMBER  SETC  '&MEM'
         AIF   ('&MEM' NE '*').MOK
         AIF   ('&DSN'(1,1) NE '''').MAST
         MNOTE 8,'MEMBER=* INVALID WITH QUOTED DSNAME'
         MEXIT
.MAST    ANOP
&MEMBER  SETC  '8+&DSN'
.MOK     ANOP
         AIF   ('&MEMBER'(K'&MEMBER,1) EQ '/').BM
         RCPSR2
         AIF   ('&MEMBER'(1,1) EQ '(').RM
         LH    R2,4+&MEMBER            LOAD LENGTH OF MEMBER NAME
         LTR   R2,R2                   TEST FOR ZERO
         BZ    *+30                    IF NO MEMBER, SKIP
         L     R14,&MEMBER             LOAD ADDRESS OF MEMBER
         AGO   .STHM
.RM      LH    R2,4&MEMBER             LOAD LENGTH OF MEMBER
         LTR   R2,R2                   AND TEST FOR ZERO
         BZ    *+30                    IF NO MEMBER, SKIP
         L     R14,0&MEMBER            LOAD ADDRESS OF MEMBER
.STHM    STH   R2,S99TULNG             STORE LENGTH OF MEMBER
         BCTR  R2,0                    DECREMENT FOR EXECUTE
         EX    R2,&DYNP.MVC            MOVE IN MEMBER NAME
         MVI   S99TUKEY+1,DALMEMBR     MOVE IN MEMBER KEY
         MVI   S99TUNUM+1,1            SET NUMBER FIELD
         RCPDINC 14
         MEXIT
.BM      RCPTUBFR DALMEMBR,14,&MEMBER
         MEXIT
.QM      RCPBTU DALMEMBR,1,&MEMBER
.EXIT    MEND
