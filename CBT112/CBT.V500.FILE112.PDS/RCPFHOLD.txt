         MACRO
         RCPFHOLD &H
         AIF   ('&H' EQ 'YES').YES
         AIF   ('&H' EQ 'NO').NO
         MNOTE 4,'HOLD PARMETER VALUE INCORRECT - IGNORED'
         MEXIT
.YES     ANOP
         SPACE 1
***********************************************************************
**       OVERIDING SYSOUT HOLD TEXT UNIT                             **
***********************************************************************
         SPACE 1
         MVI   S99TUKEY+1,DUNOVSHQ MOVE IN TEXT UNIT KEY
         RCPDINC 4
         MEXIT
.NO      ANOP
         SPACE 1
***********************************************************************
**       OVERIDING SYSOUT NO HOLD TEXT UNIT                          **
***********************************************************************
         SPACE 1
         MVI   S99TUKEY+1,DUNOVSHQ MOVE IN TEXT UNIT KEY
         RCPDINC 4
         MEND
