//GCCGEN   JOB CLASS=C,REGION=0K
//*
//* This is an example of how to compile using the
//* proc. If your installation has not installed the
//* proc, you will need to execute the compiler
//* directly, using the other example.
//*
//S1 EXEC GCCCL,
//  INFILE='PDPCLIB.SOURCE(PDPTEST)',
//  OUTFILE='PDPCLIB.LINKLIB(PDPTEST)',
//*  COPTS='-DLOOP',
//  LOPTS='MAP'
//*
//* Note if you have multiple source files in your
//* project, you MAY need specific includes for them,
//* in which case uncomment and add them to this:
//*LKED.SYSIN DD DUMMY
//* You will also need to add an "ENTRY @@MAIN" if you
//* have created an intermediate NCAL for your main
//* program so that the linkage editor can no longer
//* see the original object code.
//*
//*
//*
//* Note - if you want this program to loop, uncomment
//* the COPTS above.
//*
//S2 EXEC PGM=PDPTEST,PARM='Fred was here'
//STEPLIB  DD DSN=PDPCLIB.LINKLIB,DISP=SHR
//SYSIN    DD DUMMY
//SYSPRINT DD SYSOUT=*
//SYSTERM  DD SYSOUT=*
//
