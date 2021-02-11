         MACRO
         RCPDSRGR
         SPACE
***********************************************************************
**    DSORG RETURN TEXT UNIT                                         **
***********************************************************************
         MVI   S99TUKEY+1,DALRTORG     SET RETURN DSORG KEY
         MVI   S99TUNUM+1,1            SET NUMBER FIELD
         MVI   S99TULNG+1,2            SET LENGTH FIELD
         XC    S99TUPAR(2),S99TUPAR    INITIALIZE FIELD TO ZERO
         RCPDINC 8
         MEND
