******************************************************
*                                                    *
*    (C) COPYRIGHT 1999, 2016 zOS.JES2@Gmail.com     *
*    All Rights Reserved.                            *
*                                                    *
******************************************************

Licensed material-program, Property of zOS.JES2@Gmail.com
All Rights Reserved by zOS.JES2@Gmail.com

As with the CBT source rules, this code may be freely distributed.
However I retain ownership of this code.  Thus it may not be used, fully
or in part in a commercial product or sold in any way.

The files included are all in TSO TRANSMIT format (XMIT).

They must be transferred to your mainframe using BINARY FB80 format.

After the files have been uploaded, they can be expanded back into their
original PDS format using the following commands:

     RECEIVE INDATASET(this.pds(HELP))
     RECEIVE INDATASET(this.pds(LOADLIB))
     RECEIVE INDATASET(this.pds(MACLIB))

The HELP file contains TSO help members for the various command
processors.

The LOADLIB file contains executable formats of all of the tools.

The MACLIB file contains various macros required for assembly of the
tools.

The SOURCE file contains the tool source as well as JCL to assemble and
LINK.

If any updates are made at your installation, I would like to hear about
them.  If any modifications are required, and you do not feel
comfortable updating the source, send an email to me, and I'll be glad
to see what I can do.

Lastly, if you need assistance with any of this code,feel free to email
me.  I would like to hear of any installation or documentation problems
you encounter.  Please email the address below with any comments.

Thank you,
Dan D.
zOS.JES2@Gmail.com



Installation Instructions:

Most of these tools require no special installation instructions.
Simply assemble and linkedit them into a library of your choice.  The
LOAD.XMI file is provided to allow you to try them without even
performing this step.

ADDTO, CATL, LDS, USERINFO and WHOSGOT are all command processors that
must reside in either your STEPLIB, ISPLLIB or a LINKLISTED library.
STEPLIB must reside in an authorized LINKLISTED library and the IKJTSOxx
member of SYS1.PARMLIB must be updated to include STEPLIB in the
AUTHCMD section.

PACKMAP, RETCODE and PRU may be run from any library.  PACKMAP will
enqueue on the volume's VTOC while it is being read if it is authorized.
RETCODE will not issue appropriate error messages for invalid PARM= if
it is not authorized.


TSO HELP members are provided for the various command processors.
A REXX to invoke PRU has also been provided by Oscar Omar Ortega Ortega.
Another REXX to invoke WhosGot (mainly for use with ISPF DSLIST) has
been provided by Greg Shirey.  Greg also contributed modifications to
the PRU REXX.
Thanks to all for making these tools better for everyone.

Sample Batch JCL:

//PACKMAP   JOB   ...jobcard...
//PACKMAP   EXEC  PGM=PACKMAP,REGION=4096K,TIME=1440
//STEPLIB    DD   DSN=userid.MVS.LOAD,DISP=SHR
//DISK       DD   UNIT=SYSALLDA,VOL=SER=volser,DISP=SHR
//SYSPRINT   DD   SYSOUT=*

//PRU       JOB   ...jobcard...
//PRU       EXEC  PGM=PRU,REGION=4096K,TIME=1440
//*     PARM=ALL <--- COPY "LIVE" MEMBERS AS WELL
//STEPLIB    DD   DSN=userid.MVS.LOAD,DISP=SHR
//SYSPRINT   DD   SYSOUT=*
//INPUT      DD   DSN=original.PDS.file,DISP=SHR
//OUTPUT     DD   DSN=new.PDS.file,DISP=(,CATLG),
//                UNIT=SYSDA,SPACE=(CYL,(30,10,90))

//RETCODE   JOB   ...jobcard...
//JOBLIB     DD   DSN=userid.MVS.LOAD,DISP=SHR
//RC00      EXEC  PGM=RETCODE,PARM='RC(0)'
//RC04      EXEC  PGM=RETCODE,PARM='RC(4)'
//RC08      EXEC  PGM=RETCODE,PARM='RC(8)'
//RC12      EXEC  PGM=RETCODE,PARM='RC(12)'
//USER99    EXEC  PGM=RETCODE,PARM='USER(99)'
//SYSTEM99  EXEC  PGM=RETCODE,PARM='SYSTEM(99)',COND=EVEN

Dan D.
zOS.JES2@Gmail.com
