         MACRO
         RCPFREE &FREE
         SPACE
***********************************************************************
**      UNALLOC AT CLOSE TEXT UNIT                                   **
***********************************************************************
         MVI   S99TUPAR+1,DALCLOSE     MOVE IN CLOSE TEXT UNIT KEY
         RCPDINC 4
         MEND
