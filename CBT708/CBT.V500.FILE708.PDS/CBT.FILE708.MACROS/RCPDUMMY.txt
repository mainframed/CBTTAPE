         MACRO
         RCPDUMMY &DUMMY
         SPACE
***********************************************************************
**      DUMMY DATASET TEXT UNIT                                      **
***********************************************************************
         MVI   S99TUPAR+1,DALDUMMY     MOVE IN DUMMY DS TEXT UNIT KEY
         RCPDINC 4
         MEND
