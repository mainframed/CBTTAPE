         MACRO
         RCPDSNRT
         SPACE
***********************************************************************
**    DSNAME RETURN TEXT UNIT                                        **
***********************************************************************
         MVI   S99TUKEY+1,DALRTDSN     SET RETURN DSNAME KEY
         MVI   S99TUNUM+1,1            SET NUMBER FIELD
         MVI   S99TULNG+1,44           SET LENGTH FIELD
         RCPDINC 50
         MEND
