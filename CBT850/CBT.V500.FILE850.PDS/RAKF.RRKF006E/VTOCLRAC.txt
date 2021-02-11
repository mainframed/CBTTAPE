//VTOCLRAC JOB (RACIND),
//             'Set RACF Indicator',
//             CLASS=A,REGION=4M,
//             MSGCLASS=X,
//             MSGLEVEL=(0,0)
//********************************************************************
//*
//* Name: VTOCLRAC
//*
//* Desc: List RACF Indicator for all none VSAM datasets
//*       on all online DASDs
//*
//********************************************************************
//*
//PRTVTOC EXEC PGM=IKJEFT01,DYNAMNBR=20
//VTOCOUT  DD SYSOUT=*
//SYSTSPRT DD DUMMY
//SYSTSIN  DD *
VTOC ALL LIM(DSO NE VS) P(NEW (DSN V RA)) S(RA,D,DSN,A) -
  LIN(66) H('1RACF STATUS')
/*
//
