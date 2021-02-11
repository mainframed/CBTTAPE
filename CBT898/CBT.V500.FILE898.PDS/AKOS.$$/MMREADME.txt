 Member Manager.
 ~~~~~~~~~~~~~~~
 MM is a routine to perform member comparisons between two datasets.

 To enable MM facility.
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Upload the XMITed file onto your MVS TSO session. Ensure the dataset
 has minimum attributes of RECFM=FB,LRECL=80.

 Under ISPF 3.4 issue command "RECEIVE INDA(/)" against your uploaded
 dataset. Suggest you receive it into the default dataset.

 If you used the default for both receives, no further action is
 required.

 Exit ISPF into native TSO (READY prompt) and enter:

     EX 'userid.MM.REXX(MMALLOC)'

 Once in ISPF you can go into ISPF 3.4 and enter "MM" against any
 PDS (not RECFM=U).
 Enter '?' on the command line to get help.  Alternatively you can enter
   "TSO BR MM ?" on any command line to get the same help.

