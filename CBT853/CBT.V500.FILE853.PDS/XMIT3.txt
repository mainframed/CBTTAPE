//GCCGEN   JOB CLASS=C,REGION=0K
//*
//* Note that by nature, the file from the PC is in an
//* undefined format, since it's contents could be
//* anything. We know it is in XMIT format though, but
//* the generic tape setup facility doesn't know that
//* unless you specifically tell it. This procedure
//* assumes it is still in undefined format, and that
//* this program (COPYFILE, rather that IEBGENER), will
//* reform it into an FB80.
//*
//* Also note that the use of COPYFILE is just an example
//* of assisted file transfer on one system. There's a
//* very good chance that you won't even have the COPYFILE
//* program unless you have previously installed an older
//* version of GCC.
//*
//TRANSFER PROC GCCPREF='GCC',PDPPREF='PDPCLIB'
//*
//COPY     EXEC PGM=COPYFILE,PARM='-bb dd:in dd:out'
//STEPLIB  DD DSN=&PDPPREF..LINKLIB,DISP=SHR
//IN       DD DSN=HERC02.IN,DISP=OLD,
//         UNIT=TAPE,VOL=SER=PCTOMF,LABEL=(1,NL),
//         DCB=(RECFM=U,LRECL=0,BLKSIZE=6233)
//OUT      DD DSN=&GCCPREF..GCC.SEQ.XMIT,DISP=OLD
//SYSIN    DD DUMMY
//SYSPRINT DD SYSOUT=*
//SYSTERM  DD SYSOUT=*
//         PEND
//*
//S1 EXEC TRANSFER
//
