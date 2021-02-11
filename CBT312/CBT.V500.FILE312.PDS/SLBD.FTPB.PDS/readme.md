
## $DOC.txt
```
Installation

This application is distributed in a PDS with the primary members (EXEC
and PANELS) in TSO Transmit (IDTF) format.  To use this dialog you
need to issue TSO EXEC 'restored.dsname(RECEIVE)' which will convert
the EXEC and PANELS members into an EXEC library and a PANELS library
from which you can copy them into other datasets.

There will be 7 members:

   $DOC     -  What you are now reading
   CHANGES  -  What's changed
   EXEC     -  The REXX Execs in TSO Transmit format.
   NETRC    -  Information on using a personal NETRC data set.
   PANELS   -  The ISPF Panels in TSO Transmit format.
   PDSE     -  Information on how to send PDSE data sets
   RECEIVE  -  used to receive members EXEC and PANELS into
               partitioned datasets

After creating the installation data set:

1.  Process members EXEC and PANELS using the RECEIVE exec as described
    above.

2.  Copy FTPB.PANELS into an ISPF Panel library in your ISPPLIB concatenation.

3.  Copy FTPB.EXEC into a library in your SYSPROC or SYSEXEC concatenation.

    These REXX procedures are written to be installed in a library that is
    DCB=(RECFM=FB,LRECL=80) or one that is DCB=(RECFM=VB,LRECL=255) to
    support the format of your SYSEXEC or SYSPROC libraries.

4.  Edit the FTPBCUST exec and make make any updates as required for your
    installation.

5.  Panel FTPBHF2 needs to be updated with your TCP/IP Host names
    **** IMPORTANT ****

6.  Test by entering from the ISPF Command line:  TSO %FTPB

Comments, questions, suggestions can be directed to (please mention the
release of the code you are using):

Fun note:  Enter a source dsname of "egg" and see what happens.

   Lionel B. Dyck
   Internet:  lbdyck@gmail.com

Introduction and Doc.

           FTPB - The File Transfer Protocol Batch ISPF Dialog
                        by Lionel B. Dyck


This ISPF dialog provides a simple to use ISPF interface for using the
TCP/IP FTP function to transfer data sets from the current MVS host
system to other host systems that support a TCP/IP FTP Server (e.g. MVS,
VM, OS/2, most Unix, ...).

The dialog present the user with a simple ISPF panel from which to
specify the source (original) data set, the target host, optionally the
name of the target data set if it is different from the source, and
signon information (userid and password).  Once this information is
complete the dialog generates the necessary JCL and FTP statements to
allow the user to execute the FTP in the foreground (execpt for load
library transfers) or to submit the JCL for a batch execution of FTP.
Prior to submission the user is allowed to review and change (edit) the
generated JCL and FTP control statements if they desire.

The JCL will be submitted using an FTP service that will wait for 10
minutes (as defined by the FTP.DATA used by the installation) and if the
JOB ends within 10 minutes the sysout will be retrieved and printed in
the FTPPRINT generated step.  The PRINT job step will print the report
to the //REPORT DD and will process the data to generate a return code
equal to the max return code for the remote job.

For partitioned data sets the dialog provides member selection if a
member is not specified as part of the source data set name.  Two
options are provided for the transfer of a PDS.  One option is to unload
the data set using IEBCOPY and to transfer that sequential data set,
while generating the JCL to reload the data set at the target host.  The
other option is to not unload in which case the dialog processed a member
at a time.

For VSAM and DA data sets the dialog will prompt to ask if the target
data set should be Replaced or not on the restore.  The transfer will
occur in batch using generated JCL. To transfer VSAM/DA the dialog uses
IBM's DFSMSdss (PGM=ADRDSSU) to DUMP the data set (using the SPHERE
option) and then the restore JCL and the dump'd data set are FTP'd to
the target host.  Once these FTP's are complete the JCL is submitted to
the target system for processing where ADRDSSU will be used to RESTORE
the data set.  The batch process is the same as described above for load
library transfers except that ADRDSSU is used instead of IEBCOPY.

Also supported are pattern dsnames which will then consist of a set
of data sets dump'd and restore'd using ADRDSSU.

Known Problems/Challenges:

NOTE: that 2 and 4 have been fixed and the dialog has been
      updated but if you have these problems you can uncomment
      the code to return these restrictions.

1.  There exists a problem when using FTP to transfer load modules
    caused by the inability of FTP to correctly transfer the directory
    information for the load module.  The 'solution' for this is to
    use IEBCOPY to unload the load library into a sequential data set
    and then transfer that with a reload using IEBCOPY at the target
    site.

2.  The FTP of an IEBCOPY UNLOAD'd PDS where the original PDS had a
    BLKSIZE of 32753 or greater results in a data set that FTP is
    unable to successfully transfer.  The dialog will detect this and
    present the user with a warning panel and not perform the
    transfer.  The data set must be reblocked prior to the IEBCOPY
    UNLOAD.

    ** This has been fixed (YES) but you must have the maintenance to
       support VBS dataset transfers.

3.  The submitted JOB's SYSOUT will remain at the remote executiion
    site in the SPOOL until the SPOOL cleanup removes it as it is
    submitted with an OUTPUT JCL statement to be held so that it can
    be retrieved by the FTP GET (when filetype=jes is used) and thus
    included in the originating JOBs SYSOUT.

4.  The FTP of a RECFM=VBS dataset will not work directly until IBM
    fixes the FTP Client (target is with OS/390 2.5 release maybe).
    This transfer will use DFSMSdss just as VSAM for now.

    ** This has been fixed (YES) but you must have the maintenance to
       support VBS dataset transfers.

5.  When using DFSMSdss to dump/ftp/restore a PDSE the target may not
    restore if PDSE is not enabled and you will need to use the CONVERT
    statement (check the manual for syntax) in the restore.

Product Components

The product consists of the following elements:

    ISPF Panels:

    FTPB             Primary ISPF Panel called by FTPB
    FTPBEXEC         Patience panel displayed for online FTP executions
    FTPBGS           Submit/Exec ISPF Menu for non-unload transfers
    FTPBGSU          Submit ISPF Menu for unload transfers
    FTPBGSUP         Information on submitted job if reload used
    FTPBHF*          ISPF field level tutorial panels
    FTPBHFx          Field level help
    FTPBH0           ISPF Tutorial Panel for FTPB
    FTPBH1           ISPF Tutorial Panel for FTPBGS
    FTPBH2           ISPF Tutorial Panel for FTPBGSU
    FTPBM            ISPF member selection Panel
    FTPBSHST         Host selection panel
    FTPBPDSS         Transfer Prompting when using DFSMSdss
    FTPBPPDS         PDS Transfer Prompting
    FTPBPRCL         Prompt to recall for himgrated datasets
    FTPBSITE         Panel display of target allocation options
    FTPBPWRN         Warning for Unsupported Blksize Transfer  **

    ** - not used unless you uncomment code in the FTPB exec
         as this is only used if you are running without the
         current maintenance for vbs support.

    Panels removed:  FTPBHHST, FTPBHOST

    REXX Execs:

    FTPB              Primary Exec and the starting point for FTPB
    FTPBEM            ISPF Edit Macro called by FTPB to set key PROFILE info
    FTPBEME           ISPF Edit Macro when the END command/key is used
    FTPBEMS           ISPF Edit Macro when the SAVE command/key is used
    FTPBJOB2          Exec used to process the remote job

Note that an ISPF Table is built and maintained in Library(ISPPROF)
that contains the jobcard information for each target node.

```

