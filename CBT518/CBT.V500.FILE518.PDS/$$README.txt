Sam Knutson's utilities

   Here are some odds and ends that I wrote or got from someone
   else that have yet to find a better home on the CBT Tape.

   Contact me at sam@knutson.org if you have suggestions or a
   modification to one of these programs to share.

   The contents of this collection are to be used at your own
   risk and are not supported by me or my employer's past or present.
   All are public domain with no rights reserved.

   AUXBOOST
   This program will modify the in storage defaults used by ASM to
   determine when an AUX STORAGE SHORTAGE exists.  It is based on
   IRA200E RESOLVE zap job by Thierry Falissard in CBT Tape file 432.
   This memory zap allows you to change the 70% and 85 % thresholds to
   more aggressive values : 90% and 95 %.

   IEFUSIG                                        ADD April 2006
   IEFUSI exit I am currently using derived from Mike Loos IEFUSI
   exit in file 425.  I added code to calculate the maximum REGION
   above as well as below and it either provides MAX-BELOW/DEFAULT ABOVE
   or if you code REGION=0M MAX-BELOW/MAX-ABOVE.  I need to get back
   to this and add some code to provide MEMLIMIT which I currently
   specify in SMFPRMxx in PARMLIB.

   HZSRACF                                        ADD April 2006
   Very simple ISPF edit macro to filter the output of the
   RACF_SENSITIVE_RESOURCES check output from the Health Checker
   for z/OS.

   PUTPARM
   Simple utility posted by Perry Winter in 1993 on IBM-MAIN
   which provides very nice generation of control cards on the fly
   from a PARM.  This program writes 80 character records based on user
   supplied parm.  All symbolics used in parm are expanded before
   execution of program.  The semicolon is used as a record separator in
   the parm therefore several 80 character records can be generated from
   one 100 char parm field. The output records are written on ddname
   parm where the lrecl is always 80 characters.  The user can select
   any blocking factor on the parm dd card.  The output file can be
   concatenated before or after any 80 char LRECL data file in the job
   stream.

   SC
   Simple edit macro to SUBMIT a job then CANCEL out of the EDIT or VIEW
   of the current member.

   SUBX
   REXX edit macro to submit the current job to a dynamically allocated
   internal reader.  This avoids space abends using the IBM SUBMIT
   command and can be used to bypass IKJEFF10 the TSO/E SUBMIT exit.

   MAKEXMI & MAKEXMIU
   XMIT a data set to a data set suffixed .XMI or to a file prefixed with
   your TSO userid and suffixed .XMI

   ME
   Set your TSO profile the same as your userid

   NOTME
   Set your TSO profile to null
