         MACRO
         RCPFDISP &DISP
         LCLB  &B(4)
         LCLA  &I
         SPACE
***********************************************************************
**       OVERRIDING DISPOSITION                                      **
***********************************************************************
&B(1)    SETB  ('&DISP' EQ 'KEEP')
&B(2)    SETB  ('&DISP' EQ 'DELETE')
&B(3)    SETB  ('&DISP' EQ 'CATLG')
&B(4)    SETB  ('&DISP' EQ 'UNCATLG')
         AIF   (&B(1) OR &B(2) OR &B(3) OR &B(4)).OK3
         MNOTE 8,'&DISP IS INVALID, DISP=KEEP USED'
&B(1)    SETB  1
.OK3     ANOP
&I       SETA  8*&B(1)+4*&B(2)+2*&B(3)+&B(4)
         MVC   S99TUKEY(8),=Y(DUNOVDSP,1,1,X'0&I.00')
         RCPDINC 8
.EXIT    MEND
