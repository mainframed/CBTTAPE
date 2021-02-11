//GCCGEN   JOB CLASS=C,REGION=0K
//*
//* Delete datasets no longer required.
//*
//* We keep S2, which should be identical to S3 (if it
//* exists) so that people without the compiler can
//* take the assembler code and reassemble to create
//* the load module on another system.
//*
//CLEAN    PROC GCCPREF='GCC'
//DELETE   EXEC PGM=IEFBR14
//DD9      DD DSN=&GCCPREF..S,DISP=(MOD,DELETE),
//       UNIT=SYSALLDA,SPACE=(TRK,(0))
//DD15     DD DSN=&GCCPREF..S3,DISP=(MOD,DELETE),
//       UNIT=SYSALLDA,SPACE=(TRK,(0))
//DD17     DD DSN=&GCCPREF..TMPLOAD,DISP=(MOD,DELETE),
//       UNIT=SYSALLDA,SPACE=(TRK,(0))
//*
//         PEND
//*
//S1       EXEC CLEAN
//*
//
