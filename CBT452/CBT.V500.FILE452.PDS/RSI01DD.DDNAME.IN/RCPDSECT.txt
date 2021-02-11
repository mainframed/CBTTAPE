         MACRO
&NAME    RCPDSECT &LTORG=YES
         AIF   ('&LTORG' NE 'YES').RCPDS
***********************************************************************
****                  LITERALS                                     ****
***********************************************************************
         SPACE 3
         LTORG
         EJECT
.RCPDS   RCPDS
         MEND
