Basic documentation about the REVIEW package
--------------------------------------------

REVIEW is a decades-old public domain application intended for
the TSO environment running on MVS-family operating systems.

The Release Notes are in member REVNOTES of the REVIEW.DATA data set.

See below for Installation Notes.

As of Release 43:

(1) All BASSM and BSM instructions have been removed.

    This means that under OS/390 and z/OS REVIEW is now expected
    to run as a pure 31-bit application.  It also means that
    REVIEW will no longer run under MVS/XA and MVS/ESA with
    back levels of DFP which do not allow AMODE=31 BPAM and SAM.

    Naturally, REVIEW continues to be a pure 24-bit application
    under MVS/370.

    Also note that REVIEW/RFE is only tested under MVS 3.8J
    and most supported (at the time) releases of z/OS.


(2) The REVIEW Front End (RFE) is now introduced.

    RFE is a basic menu system allowing navigation to the various
    components of the package.  The initial release of RFE
    delivers the "Data Set List" and the "TSO Command" options.


The REVIEW/RFE package includes the following data sets:

- REVIEW.DATA
  This contains a copy of these notes, and intallation process
  samples and other information such as the Release Notes.

- REVIEW.LOAD
  This contains the load modules of the REVIEW package which get
  updated each release of REVIEW.

- REVIEW.CLIST
  This contains TSO CLISTs, some of which pertain to or are invoked
  by REVIEW/RFE, and some of which have nothing to do with REVIEW.

- REVIEW.HELP
  This contains the members for the SYSHELP file.  It forms the
  online documentation of the package outside the ISPF environment.

- REVIEW.PANELS
  This contains ISPF panels which may be of use if you want to
  run REVIEW as an ISPF application.
* NOTE: This data set is NOT included in the package for MVS/370.


Installation Notes
==================

This package is made available for download as several ZIP archives.

Installation Steps:
------------------

1. Download each ZIP you require.
2. UNZIP each archive to acquire the XMIT sequential file.
3. RECEIVE each XMIT file to reconstruct a partitioned data set.
4. Install each PDS as appropriate.
   Other members in this data set supply sample jobs for some of these.


Sample JCL for uploading a file via a card reader:
-------------------------------------------------


Assumptions for this scenario are:
(1) The file to be uploaded has fixed-length 80-byte records.
(2) The file is not a job stream to be submitted, but is simply data.
(3) The file is to be copied into a new data set called
    HERC01.FB80.DATA
(4) The carder reader to be used is device number 00C.
(5) The carder reader is online to the system but not allocated
    to any other address space such as JES2 or JES3.

    ÝFor example, if the card reader is known to JES2 as
    "Reader 1" then the JES2 operator command
    $PRDR1
    will "drain" the card reader, and so it will be deallocated
    by JES2 (when the current work, if any, has finished),
    thus making it available for allocation by other jobs.¨

//HERC01G  JOB ,GENER,CLASS=A,MSGCLASS=X,MSGLEVEL=(1,1),
//             REGION=4096K,NOTIFY=HERC01
//STEP1   EXEC PGM=IEBGENER
//SYSPRINT DD  SYSOUT=*
//SYSUT1   DD  UNIT=00C,DCB=(RECFM=FB,LRECL=80,BLKSIZE=80)
//SYSUT2   DD  DSN=HERC01.FB80.DATA,DISP=(NEW,CATLG,DELETE),
//             UNIT=SYSALLDA,SPACE=(TRK,(500,20),RLSE),
//             DCB=(DSORG=PS,RECFM=FB,LRECL=80,BLKSIZE=3120)
//SYSIN    DD  DUMMY
//



Performing the RECEIVE
----------------------

For z/OS, use the TSO/E RECEIVE command to process each XMIT file.


For MVS 3.8, a sample job to perform the RECEIVE assumming
the prerequisite RECV370 program is installed now follows:

//HERC01R  JOB ,RECV370,CLASS=A,MSGCLASS=X,MSGLEVEL=(1,1),
//             REGION=4096K,NOTIFY=HERC01
//*
//RECVREV PROC LLQ=
//RDEL    EXEC PGM=IEFBR14
//RECVDEL  DD  DSN=HERC01.REVIEW.&LLQ,DISP=(MOD,DELETE),
//             UNIT=SYSALLDA,SPACE=(TRK,0)
//RECV370 EXEC PGM=RECV370
//RECVLOG  DD  SYSOUT=*
//XMITIN   DD  DSN=HERC01.REV&LLQ..XMI,DISP=SHR
//SYSPRINT DD  SYSOUT=*
//SYSUT1   DD  DSN=&&SYSUT1,
//             UNIT=VIO,
//             SPACE=(CYL,(5,1)),
//             DISP=(NEW,DELETE,DELETE)
//SYSUT2   DD  DSN=HERC01.REVIEW.&LLQ,
//             UNIT=SYSALLDA, VOL=SER=??????,
//             SPACE=(CYL,(15,2,20),RLSE),
//             DISP=(NEW,CATLG,DELETE)
//SYSIN    DD  DUMMY
//        PEND
//*
//CLIST   EXEC RECVREV,LLQ=CLIST
//DATA    EXEC RECVREV,LLQ=DATA
//HELP    EXEC RECVREV,LLQ=HELP
//LOAD    EXEC RECVREV,LLQ=LOAD
//

