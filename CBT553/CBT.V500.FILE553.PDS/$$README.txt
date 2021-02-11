Information on the SUBMITC ISPF edit macro - 2002-02-15
-------------------------------------------------------

SUBMITC is an ISPF edit macro that submits the file (or selected lines)
to the JES2/JES3 internal reader.

Oh big deal you say, but wait there's more:

Passwords:
---------
When reading the input, it looks for certain password locations in the
jobsteam and prompts you for them so you don't have keep passwords in
datasets (bad) and don't have to remember to cancel out or change the
password before saving.

Passwords are specifed as "?" and are only looked for in specific
locations. See Process_Line for more details.

Passwords are put into the jobstream asis (mixed case)
except for jobcard passwords which are folded to uppercase.

For passwords on the jobcard, USER= and PASSWORD= must
be on the same line and in that order.  In this case, I
will append a comma after the password if found in the
input stream otherwise I just overlay password beginning
at the question mark.

You must leave enough room after the "?" where the password
is to go because it is *assumed* the jobstream was prepped
for SUBMITC usage.

Usually you will need to put an exclamation point before
SUBMITC so ISPF will find it.  For example:

EDIT       IBMUSER.IN.CNTL(TCPFTP)
Command ===> !SUBMITC
****** ********************************
000001 //IBMUSERF  JOB  (ACCT#),'MY NAM

An allocation to the JES INTRDR is dynamically allocated
and SUBMITC writes directly from the ISPF line variables
to the JES input queue.  We do NOT write any data to a
DASD dataset (unlike IBM's ISPF submit). WHO HA!

Sample jobstream showing the passwords we try to detect and change:

  //IBMUSERF  JOB  (ACCT#),'MY NAME HERE',
  //          USER=IBMUSER,PASSWORD=?,                        (1)
  //          MSGCLASS=X,CLASS=U
  //*
  //PS0130  EXEC PGM=FTP,PARM='FIREWALL (EXIT TI 720'
  //NETRC     DD *
  MACHINE FIREWALL LOGIN ibmuser PASSWORD ?                   (2)
  //SYSPRINT  DD SYSOUT=*
  //OUTPUT    DD SYSOUT=*
  //INPUT     DD *
  user bozo@clown.net                                         (3)
  ?                                                           (3)
  dir
  quit

  (1) USER=user,PASSWORD=?  on the jobcard
  (2) Instream machine statements in //NETRC file
  (3) Instream user statements followed by ? in //INPUT file


Note: SUBMITC is NOT robust.  It was designed for specific
      types of jobstreams, not every possibility is supported.
      Your mileage may vary.

Symbols
-------
IBM currently does support system symbolics in batch jobs.  You can
optionally use SUBMITC to translate system symbolics in your instream
jobstream using two methods:

   1) Use the parm SYM when invoke SUBMITC to translate all lines (or
      until a SUBMITC::NOSYM control card is reached).

   2) Use the special control cards in the jobstream to turn on and
      off translation.  Use the SYM or NOSYM on one of the 3 types
      of control card formats:

      //*SUBMITC::SYM
      /* SUBMITC::SYM
      *SUBMITC::SYM

      Line(s) to translate with symbolics here

      *SUBMITC::SYM
      /* SUBMITC::SYM
      //*SUBMITC::SYM

See member $SAMPSYM for a job that has symbolics.

BTW: SUBMITC calls the IBM system symbolic routine ASASYMBM to do the
translation.
