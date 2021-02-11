//INITPWUP JOB (RAKF),
//             'RAKF Customization',
//             CLASS=A,
//             MSGCLASS=X,
//             MSGLEVEL=(1,1)
//* ------------------------------------------------------------------*
//* Allocate the RAKF password queue dataset SYS1.SECURE.PWUP         *
//*                                                                   *
//* Expected return codes: Step DELETE:  08 or lower                  *
//*                        Step SCRATCH: 08 or lower                  *
//*                        Step ALLOC:   00                           *
//* ------------------------------------------------------------------*
//*
//* ------------------------------------------------------------------*
//* Delete SYS1.SECURE.PWUP                                           *
//* ------------------------------------------------------------------*
//LISTCAT  EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
 DELETE SYS1.SECURE.PWUP
/*
//* ------------------------------------------------------------------*
//* Scratch SYS1.SECURE.PWUP                                          *
//* ------------------------------------------------------------------*
//SCRATCH EXEC PGM=IEHPROGM
//SYSPRINT DD  SYSOUT=*
//DD1      DD  VOL=SER=rrrrrr,DISP=OLD,UNIT=tttt
//SYSIN    DD  *
   SCRATCH VOL=tttt=rrrrrr,DSNAME=SYS1.SECURE.PWUP
/*
//* ------------------------------------------------------------------*
//* Allocate SYS1.SECURE.PWUP                                         *
//* ------------------------------------------------------------------*
//ALLOC   EXEC PGM=IEFBR14
//PWUP     DD  DISP=(,CATLG),DSN=SYS1.SECURE.PWUP,VOL=SER=rrrrrr,
//             UNIT=tttt,DCB=(RECFM=F,LRECL=18,BLKSIZE=18),
//             SPACE=(TRK,(1,1))
//
