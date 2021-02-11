//GCCGEN   JOB CLASS=C,REGION=0K
//*
//* Allocate space for the sequential XMIT
//* and the PDS of XMITs that it will be converted into
//*
//CREATE   PROC GCCPREF='GCC'
//DELETE   EXEC PGM=IEFBR14
//DD1      DD DSN=&GCCPREF..GCC.SEQ.XMIT,DISP=(MOD,DELETE),
//       UNIT=SYSALLDA,SPACE=(TRK,(0))
//DD2      DD DSN=&GCCPREF..GCC.PDS.XMIT,DISP=(MOD,DELETE),
//       UNIT=SYSALLDA,SPACE=(TRK,(0))
//*
//ALLOC    EXEC PGM=IEFBR14
//* Put an explicit DSORG=PS to cater for buggy ftp programs
//* that inspect a new dataset when they are the ones who are
//* meant to be setting that attribute on the open-for-write
//DD1      DD DSN=&GCCPREF..GCC.SEQ.XMIT,DISP=(,CATLG),
// DCB=(DSORG=PS,RECFM=FB,LRECL=80,BLKSIZE=3120),
// SPACE=(3120,(30000,30000)),UNIT=SYSALLDA
//DD2      DD DSN=&GCCPREF..GCC.PDS.XMIT,DISP=(,CATLG),
// DCB=(RECFM=FB,LRECL=80,BLKSIZE=3120),
// SPACE=(3120,(30000,30000,44)),UNIT=SYSALLDA
//         PEND
//*
//S1 EXEC CREATE
//*
//
