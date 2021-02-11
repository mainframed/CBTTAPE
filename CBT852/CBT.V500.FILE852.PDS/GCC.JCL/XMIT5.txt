//GCCGEN   JOB CLASS=C,REGION=0K
//*
//* Submit the job that receive the various XMITs
//* Also the job that submits the example.
//* And the cleanup job.
//*
//SUBMIT   PROC GCCPREF='GCC',MEMBER=''
//*
//SUBJOB   EXEC PGM=IEBGENER
//SYSUT1   DD  DSN=&GCCPREF..GCC.PDS.XMIT(&MEMBER),DISP=SHR
//SYSUT2   DD  SYSOUT=(A,INTRDR)
//SYSPRINT DD  SYSOUT=*
//SYSIN    DD  DUMMY
//*
//         PEND
//*
//S1 EXEC SUBMIT,MEMBER='XMIT6'
//*
//S2 EXEC SUBMIT,MEMBER='XMIT7'
//*
//S3 EXEC SUBMIT,MEMBER='XMIT8'
//*
//
