         MACRO - TO SET UP SVC 99 TEXT UNIT 'FOR USER'
         RCPFORUS &T
         SPACE 1
***********************************************************************
**       'FOR USER' TEXT UNIT                                        **
***********************************************************************
         RCPVCHAR 0,5,&T,N=X'7701'
         MEND
