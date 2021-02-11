         MACRO
         RCPDDNRT
         SPACE 1
***********************************************************************
**    DDNAME RETURN TEXT UNIT                                        **
***********************************************************************
         MVI   S99TUKEY+1,DALRTDDN     SET RETURN DDNAME KEY
         MVI   S99TUNUM+1,1            SET NUMBER FIELD
         MVI   S99TULNG+1,8            SET LENGTH FIELD
         MVC   S99TUPAR(8),=CL8' '     INITIALIZE FIELD TO BLANKS
         RCPDINC 14
         MEND
