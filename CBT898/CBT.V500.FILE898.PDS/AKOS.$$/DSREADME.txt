 DS.
 ~~~
 DS is a derivative/rehash of the original DASDSPCE roaming CBT many
 years ago.
 It has a few god features:
  - colourisation for easier readability.
  - direct passthrough to ISPF 3.4 volume based dataset display.
  - quick total space calculator.
  - quick free space calculator.
  - user exit interface (make data available to your application).
  - multiple DASD commands to authorised users, eg. defrag, backup,
    initialise, VTOC index toggle and more.

 To enable DS.
 ~~~~~~~~~~~~~
 Upload the XMITed file onto your MVS TSO session. Ensure the dataset
 has minimum attributes of RECFM=FB,LRECL=80.

 Under ISPF 3.4 issue command "RECEIVE INDA(/)" against your uploaded
 dataset. Suggest you receive it into the default dataset.

 Load module LMAC has been XMITed into member LMACLMOD of distribution
 dataset. To create the required load library with member LMAC, issue
 command "RECEIVE INDA(/(LMACLMOD))" against the above "received into"
 dataset (after entering REFRESH on the ISPF 3.4 command line).

 If you used the default for both receives, no further action is
 required.

 Exit ISPF into native TSO (READY prompt) and enter:

     EX 'userid.DASDSPCE.REXX(DSALLOC)'

 to allocate the libraries to the appropriate ISPF concatenations.

 Back under ISPF enter "TSO DS" on any line command and follow the
 spherical bouncing ball.

 Notes:
 ~~~~~~
 1. To enable ISPF 3.4 pass through, you will need to customise the IBM
    supplied panel ISRUDLP. This can be achied as follows:
       - Enter "TSO %IBMPCUST" on the command line (for red screen
         data) or "TSO %BR %IBMPCUST" for a browse display. The display
         should identify the ISPPLIB concatenated dataset that contain
         all the IBM supplied ISPF panels.
       - Copy panel ISRUDLP into the above REXX dataset. (The DSALLOC
         command will concatenate the REXX dataset to ISPPLIB.)
       - Edit YOUR copy of ISRUDLP and enter "IBMPCUST /CONV" on the
         command line. This process will update th panel with the
         appropriate code to bypass the 3.4 screen on entry and exit. It
         will also replace the "Command" prompt with the system id which
         serves as a handy reminder in a multi LPAR environment.
       - You wll need to refresh the panel by either exiting to the
         READY prompt and coming back in or invoking ISPF opt 7 in split
         screen mode while invoking ISPF 3.4 in the other.
 2. IBMPCUST has basically 4 uses:
      a) Readily identifies IBM panel dataset. (Default "/FIND".)
    Parameter "/CUST",
      b) Updates ISRUDLP as mentioned above.
      c) Can be used to quickly customise an ISPF panel to change the
         command prompt to system id. This is a very simple procedure
         and can be recustomised within minutes after an ISPF upgrade,
         if required.
      d) Customise panel ISRUDSL0 to permit you to set ISPF 3.4 option
         "S" to any valid value you want. You no longer need to look at
         and PF3 out of the dataset info display. Just enter "S=V" on
         the command line to make view your default Selection. "S=?"
         will display your current setting.
         Note, this function is made available through program PANELI34
         shiped in the load library. Source along with DASDSPCE can be
         made available on demand.
 3. BR is a routine to trap output and present under browser.
 4. REAL is a powerfull ISPF dataset allocation routine. To discover
    it's power, enter "TSO %BR REAL ?" on any command line.

