AFCLOGR1 is a program I developed to scan through an OPERLOG datastream,
printing out selected records in hardcopy SYSLOG format.  I find it
convenient to use for a number of purposes:

  Finding something in the log when I don't have the time or patience to
  keep hitting PF5 in SDSF to look for it.

  Filtering out all the garbage messages in a given time span, when the
  thing I am looking for may be "hidden" amongst many other messages.

  Finding more than one keyword or message ID.

  Filtering based on jobname, jobid, or system name.

  Running a daily job to scan for "interesting" messages since the last
  time I ran the job.  I have an automated process for building and
  submitting this job when I log on in the morning.

I'm sure you can find other uses for it as well.

One note about the program design - I could have added SYSIN parameters to
specify the date and time, then dynamically allocate and read the
logstream, but I decided against it.  Too much like reinventing the wheel.
The subsystem JCL already has that capability, and it just didn't seem
worth the effort.

Our logstream name is SYSPLEX.OPERLOG - if yours is different, you'll
have to change the name in the AFCLOGSC proc, or whatever JCL you use
to run the program.

This program has been run on z/OS 1.3 - 1.9, but I see no reason it can't
run on later levels.  HOWEVER, due to the heavy use of relative addressing,
it will only run on a box with the relative addressing instructions
available.  I'm not sure at which architectural level they were introduced,
but I'm pretty sure they've been around for a while.

UPDATES:

2010/12/28
I decided I didn't like the U200 abend that I had introduced for "too large"
records, so I added code to handle them, at least as much as possible.  Although
the logstream LRECL can be as large as 65535, we only receive up to 32752 bytes
on a GET.  And then, it may be cut off in the middle of a section, so the
MDBTLEN may be incorrect.  It doesn't happen very often (just really big
commands like "D TCPIP,TN3270,TELNET,CONN,MAX=*".  But as far as I can tell,
this version works correctly within those restrictions.

2008/12/31
Fixed a bug where the program would get into a tight loop.  This was due
to me assuming that the OPERLOG LRECL was somehow fixed at 4100.  When I
tried running it at my new job, I discovered that this wasn't so.  Now the
program will check the LRECL against the MDB length, and ABEND with a
U200 if it isn't big enough.  If this happens, just increase the LRECL
in the LOGIN JCL.

2006/09/25
This version has a couple of small enhancements - multiple SYSID statements
honored, and FIND=QUIT.  It was also "adjusted" so as not to use a base
register for the code - it's all relative now.  I haven't seen a program
written this way before, and I couldn't resist experimenting with it.  There
are undoubtedly better ways to do it, but this at least has the small virtue
of actually working.

--------------------------------------------------------------------------------

SYSIN statements:

JOBNAME=XXXXXXXX
  Limit the search to records produced by this jobname.

JOBID=JOBXXXXX
  Limit the search to records produced by this jobid.

JOBNAME and JOBID are not guaranteed to find every message
related to the specified jobname and/or jobid.  Not sure why this
is so, but sometimes the messages just don't seem to have this data
in the right fields.

SYSID=XXXXXXXX
  Limit the search to records produced from this system (or systems -
  up to 16, each specified on a separate SYSID= card).

Note that the following text and msgid keywords refer to "selected"
records.  These are records "selected" by any of the preceeding
keywords.  If none of these are specified, "selected" becomes all
operlog records in the JCL-controlled timespan.

TEXT='TEXT YOU ARE LOOKING FOR'

  The first character after the "=" is the string delimiter and is
  required.  This can be any character, but must be matched at the
  end.  Maximum string length is 127.  The text of all selected
  messages (including multi record) will be scanned for this text.

MSGID='MSGID YOU ARE LOOKING FOR'

  The first character after the "=" is the string delimiter and is
  required.  This can be any character, but must be matched at the
  end.  Maximum string length is 127.  Only the first 3 columns of
  the 1st line of each selected message will be scanned for the
  beginning of this text, so it is faster than the TEXT= keyword.

FIND=EXCLUDE

  Entered as shown.  The result of this keyword is that if any of
  the text or msgids are found, the record will not be printed.
  Use this to print everything except the matches.

FIND=QUIT

  Entered as shown.  Use this if you are scanning through a long
  time span for the 1st occurrance of something, and dont want to
  waste the time searching through the rest of the log after you
  found it.  Causes execution to end after the 1st hit.

The order of the keywords does not matter.  A record is printed if
it matches any of the text strings and the jobname, jobid, and/or
sysid criteria (or not printed, if "FIND=EXCLUDE").

If you just want to print out all the log records in a given
timespan, leave out the sysin parameters (or only include comments).

A "*" in column 1 indicates a comment record.

Examples:

//LOGCOPY  EXEC PGM=AFCLOGR1
//SYSUDUMP DD   SYSOUT=*
//LOGIN DD DSN=SYSPLEX.OPERLOG,RECFM=VB,LRECL=32756,BLKSIZE=32760,
// SUBSYS=(LOGR,,'FROM=(2001/339,07:00),TO=(2001/339,07:01),LOCAL')
//LOGOUT   DD   SYSOUT=*
//SYSIN    DD   *
* THIS COMMENT INTENTIONALLY LEFT MEANINGLESS
TEXT=' INVALID '
MSGID='IEF403I'

This jobstep scans the operlog from 07:00 December 5, 2001 to
07:01 December 5, 2001 for any message containing the word
" INVALID ", or any message starting with "IEF403I".



//LOGCOPY  EXEC PGM=AFCLOGR1
//SYSUDUMP DD   SYSOUT=*
//LOGIN DD DSN=SYSPLEX.OPERLOG,RECFM=VB,LRECL=32756,BLKSIZE=32760,
// SUBSYS=(LOGR,,'FROM=(2001/339,07:00),TO=(2001/339,07:01),LOCAL')
//LOGOUT   DD   SYSOUT=*
//SYSIN    DD   *
* ANOTHER POINTLESS COMMENT
MSGID="ICH408"
TEXT=%INDICATED FOR%
FIND=EXCLUDE

This jobstep scans the same period, but prints every message
that does not start with "ICH408" or contain the phrase
"INDICATED FOR".


Abends and return codes:

Abend U100:  The login buffer overflowed.  I did an abend
  rather than set a return code because this way we can see
  what kind of huge record caused the overflow.

RC 12: SEARCH-FOR text buffer overflow.  Too much SYSIN, too much to
       look for.  Or too many SYSID= cards.

RC 8: Delimiter error on a SYSIN statement.

RC 1: Nothing found.

RC 0: Normal return, we found at least one hit.

--------------------------------------------------------------------------------

The members in this dataset are:

$README  - I guess you already know about this one.
AFCLOGR1 - The assembler source for the log scanner.  AFC stands for
           'Airborne Freight Corporation', by the way - my employer
           when I wrote the original version.
AFCLOGSC - JCL proc to run the program.
ASMINFO  - A macro, used by INR to build a human-readable program header.
ASMJCL   - JCL to assemble and link the program.
BR2JMP   - A macro, used by INR to OPSYN branch instructions to jumps
CLEAR    - A macro, used by AFCLOGR1 to clear a storage field to blanks.
INR      - A macro, used by AFCLOGR1 for entry housekeeping.  No base reg.
EXECJCL  - JCL to run the program (uses proc AFCLOGSC)
OUTR     - A macro, used by AFCLOGR1 for exit housekeeping.

This program may be used, modified, and/or shared by anyone.  Just don't
sell it, and please give me some credit.

Richard Hobt
Arizona Department of Public Safety
2310 N. 20th
Phoenix, AZ.  85009
(602) 223-2519
RHobt@azdps.gov

September 25, 2006
