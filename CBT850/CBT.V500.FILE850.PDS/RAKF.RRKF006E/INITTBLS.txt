//INITTBLS JOB (RAKF),
//             'RAKF Customization',
//             CLASS=A,
//             MSGCLASS=X,
//             MSGLEVEL=(1,1)
//* ------------------------------------------------------------------*
//* Allocate PDS SYS1.SECURE.CNTL and populate it                     *
//* with initial users and groups tables                              *
//*                                                                   *
//* Expected return code:  Step TABLES: 00                            *
//* ------------------------------------------------------------------*
//*
//TABLES  EXEC PGM=IEBCOPY
//SAMPLES DD DISP=SHR,DSN=hlq.SAMPLIB
//RAKF    DD DISP=(,CATLG),DSN=SYS1.SECURE.CNTL,VOL=SER=rrrrrr,
//           UNIT=SYSDA,DCB=(RECFM=FB,LRECL=80,BLKSIZE=19040),
//           SPACE=(TRK,(10,3,3))
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
 COPY INDD=SAMPLES,OUTDD=RAKF
 SELECT MEMBER=((uuuuuuuu,USERS),(MINPRF,PROFILES))
/*
//
