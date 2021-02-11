         MACRO
         RCPQNAME &QNAME
         GBLC  &DYNP
         SPACE
***********************************************************************
**   BUILD THE QNAME TEXT UNIT                                       **
***********************************************************************
         RCPVCHAR DALQNAME,14,&QNAME
         MEND
