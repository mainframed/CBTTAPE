DISCLAIMER
----------

This code is supplied on an as-is basis.  No warranty is provided.  Use
at your own risk!  I will try to answer questions though.

                  Bill Horton
                  Tennessee Eastman Company
                  Building 284
                  Kingsport, TN 37662-1973

                  (615) 229-3388

INTRODUCTION
------------

This dialog may be used to recover a dataset which has been backed up
using IBM's DFHSM.  Syntax:

  %VRECOV {LEVEL(level) DSN(dsname) QUIET}

  where "level" is the dsname level to be recovered.  If LEVEL is
  specified, the dialog will generate a list of all datasets matching
  the specified level, from which the dataset to be recovered can be
  selected.

  "dsname" is the fully qualified name of a dataset to be recovered.  If
  DSN is specified, the dialog will generate a list of backup version of
  the datasets from which the desired version can be selected.

  QUIET turns off the "progress" messages normally displayed by the
  dialog.

If neither LEVEL nor DSN is specified, the dialog will prompt for a
dataset name/level.

The dialog may be invoked for a particular dataset by entering:

  %RECOV dsname

  where "dsname" is the same as above.

To invoke the dialog from ISPF 3.4, enter "%recov" on the line which has
the dataset you want to recover.

INSTALLATION INSTRUCTIONS
-------------------------

1. Create a PDS from the IEBUPDTE source, if desired, using JCL similar
   to:

//IEBUPDTE JOB (91004,8),'name       ',CLASS=A,NOTIFY=userid
//        EXEC PGM=IEBUPDTE,PARM=NEW
//SYSPRINT DD  SYSOUT=$
//SYSUT2   DD  DSN=userid.VRECOV.CNTL,UNIT=SYSDA,SPACE=(TRK,(5,3,45)),
//             DCB=(LRECL=80,RECFM=FB,BLKSIZE=23440),
//             DISP=(NEW,CATLG)
//SYSIN    DD  *
<- the downloaded PC file ->
/*

2. Copy the message member TECZ00 to your ISPF message library.

3. Copy the panel members VRECOV0-5 to your ISPF panel library.

4. Copy the CLISTs member RECOV and VRECOV to your TSO CLIST library.

5. If desired, create a menu panel entry and / or  ISPF command table
   entry to invoke the dialog.

