//AUXINST JOB (UTILITY),
//            'Install Utilities',
//            CLASS=A,
//            MSGCLASS=X,
//            MSGLEVEL=(0,0)
//* ------------------------------------------------------------------*
//* Install auxiliary utilities needed by sample RACF-indication jobs *
//*                                                                   *
//* Expected return codes: Step RECEIVE: 00                           *
//*                        Step INSTALL: 00                           *
//* ------------------------------------------------------------------*
//*
//* ------------------------------------------------------------------*
//* Receive distribution library                                      *
//* ------------------------------------------------------------------*
//*
//RECEIVE  EXEC PGM=RECV370
//RECVLOG   DD SYSOUT=*
//XMITIN    DD DSN=hlq.SAMPLIB(AUXUTILS),DISP=SHR
//SYSPRINT  DD SYSOUT=*
//SYSUT1    DD DSN=&&SYSUT1,UNIT=SYSDA,SPACE=(CYL,(100,50)),
//             DISP=(,DELETE,DELETE)
//SYSUT2    DD DSN=&&AUX,DISP=(,PASS),SPACE=(TRK,(50,0,1),RLSE),
//             DCB=(LRECL=0,BLKSIZE=19069,RECFM=U),UNIT=SYSDA
//SYSIN     DD DUMMY
//SYSUDUMP  DD SYSOUT=*
//*
//* ------------------------------------------------------------------*
//* Copy utilities to system libraries                                *
//* ------------------------------------------------------------------*
//*
//INSTALL  EXEC PGM=IEBCOPY
//AUX      DD  DISP=(OLD,DELETE),DSN=&&AUX
//LINKLIB  DD  DISP=SHR,DSN=SYS2.LINKLIB <--+
//CMDLIB   DD  DISP=SHR,DSN=SYS2.CMDLIB  <--+---- change if necessary
//LPALIB   DD  DISP=SHR,DSN=SYS1.LPALIB  <--+
//SYSPRINT DD  SYSOUT=*
//SYSIN    DD  *
 COPY INDD=((AUX,R)),OUTDD=LINKLIB
 SELECT MEMBER=(MAWK)
 COPY INDD=((AUX,R)),OUTDD=CMDLIB
 SELECT MEMBER=(VTOC,CDSCB)
 COPY INDD=((AUX,R)),OUTDD=LPALIB
 SELECT MEMBER=(IGC0024D)
/*
//
