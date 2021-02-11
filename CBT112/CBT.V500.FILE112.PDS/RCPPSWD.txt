         MACRO
         RCPPSWD &PASSW
         GBLC  &DYNP
         SPACE
***********************************************************************
**   BUILD THE PASSWORD TEXT UNIT                                    **
***********************************************************************
         RCPVCHAR DALPASSW,14,&PASSW
         MEND
