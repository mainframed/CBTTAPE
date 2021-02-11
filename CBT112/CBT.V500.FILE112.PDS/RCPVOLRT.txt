         MACRO
         RCPVOLRT
         SPACE 1
***********************************************************************
**    VOLUME SERIAL RETURN TEXT UNIT                                 **
***********************************************************************
         MVI   S99TUKEY+1,DALRTVOL     SET RETURN VOLUME SERIAL KEY
         MVI   S99TUNUM+1,1            SET NUMBER FIELD
         MVI   S99TULNG+1,8            SET LENGTH FIELD
         MVC   S99TUPAR(8),=CL8' '     INITIALIZE FIELD TO BLANKS
         RCPDINC 14
         MEND
