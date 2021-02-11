         MACRO
         RCPDSNPD &PDE
         AIF   ('&PDE'(1,1) EQ '(').RPDE
         RCPDSN &PDE,8+&PDE
         RCPPSWD 16+&PDE
         MEXIT
.RPDE    RCPDSN &PDE,8&PDE
         RCPPSWD 16(&PDE)
         MEND
