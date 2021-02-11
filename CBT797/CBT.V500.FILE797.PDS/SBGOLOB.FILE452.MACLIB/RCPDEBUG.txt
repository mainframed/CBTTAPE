         MACRO
         RCPDEBUG &ON
         GBLA  &RCPBGN#,&RCPSWS(10)
         GBLB  &RCPDBUG
         GBLC  &RCPPRE,&RCPWKDS,&RCPWKCS
         AIF   ('&ON' EQ '').TSW
&RCPDBUG SETB 1
.TSW     AIF   (&RCPDBUG).DEBUG
         MEXIT
.DEBUG   MNOTE *,'RCPBGN# IS &RCPBGN#'
         MNOTE *,'RCPSWS(1) IS &RCPSWS(1)'
         MNOTE *,'RCPSWS(2) IS &RCPSWS(2)'
         MNOTE *,'RCPSWS(3) IS &RCPSWS(3)'
         MNOTE *,'RCPSWS(4) IS &RCPSWS(4)'
         MNOTE *,'RCPSWS(5) IS &RCPSWS(5)'
         MNOTE *,'RCPWKCS IS ''&RCPWKCS'''
         MNOTE *,'RCPWKDS IS ''&RCPWKDS'''
         MNOTE *,'RCPPRE IS ''&RCPPRE'''
         MEND
