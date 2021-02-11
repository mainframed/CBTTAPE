
## $$$DOC.txt
```
               SYS1.BRODCAST NOTES - THE BRODCAST MANAGER


Note:  Please see the new member $$EXPAND for instructions how to
       expand your SYS1.BRODCAST dataset, without losing any messages.


      The BRODCAST MANAGER is a set of programs designed to help the
systems programming staff in maintaining the SYS1.BRODCAST dataset, so
it doesn't fill up, leaving the staff helpless.  In the past, when this
happened, we would be forced to run the SYNC command or the SYNC
subcommand of ACCOUNT.  This would completely initialize SYS1.BRODCAST
and wipe out every userid's notification messages.  IBM in its wisdom,
has not even provided us with a means of determining which users had
the messages waiting for them.

      Normal updating of SYS1.BRODCAST is done by the IBM programs,
SEND and LISTBC.  SEND adds messages to a userid's message chain.
LISTBC displays and clears all messages from the userid's message
chain.  All NOTIFY messages from a job's JCL, are translated into
SEND commands by the operating system.

      Usually, the clogging of SYS1.BRODCAST happens when a TSO userid
accumulates messages and is not logged onto.  At logon time, the normal
processing invokes the LISTBC command, which (as we said) displays and
deletes all user messages in SYS1.BRODCAST that have accumulated for
that userid.  If the user does not ever logon, then LISTBC is not
invoked, and these messages pile up.  Sometimes, a user leaves the
installation, and all NOTIFY messages for running production jobs which
go to that ID, will continually accumulate.  IBM's lack of a display
command makes it impossible, using purely IBM means, to detect and
remedy such a condition.  (IBM recommends to do a SYNC.  Ha!)

      We have presented this package of programs to remedy the clogging
of SYS1.BRODCAST.  There are programs to summarize the condition of
SYS1.BRODCAST, to display any userid's messages, to display all userid
messages, to delete any userid's messages, and to diagnose corruption
conditions in the SYS1.BRODCAST dataset.

      To summarize the condition of SYS1.BRODCAST, there is the
BCMSCAN batch program, which displays how full SYS1.BRODCAST is,
which users have waiting messages, and how many messages there are.
As far as listing and deleting a userid's messages, there are several
other programs which handle that situation.

      We have written several programs which list outstanding messages
for a userid (or all userids having messages).  These programs do not
delete the messages which have been listed.  The difference between
these listing programs concerns how much diagnostic detail is displayed
along with the messages themselves.  BCMLIST is similar to the LISTBC
display that everyone is used to.  BCMLIST only displays user messages
themselves.  A second program called BCMLIS, in addition, displays the
relative record address of each message in the userid's chain.  A third
program, BCMLISY, in addition to the above, displays the contents of
each userid's message pointers--the relative record address of the
first and last message chained to that userid.  These two addresses
should match the displayed relative addresses of the first message and
the last message, when they are written out by the BCMLISY program.
If you run any of these programs against the special "userid" ALL$#@,
then all user messages are displayed.  BCMLISX, in addition to what
BCMLISY displays, will display the position of userid records in
SYS1.BRODCAST, even if there are no outstanding messages for that id.
You can run BCMLISX against the special id ALL$#@, to find out all
the userids that are defined to that SYS1.BRODCAST dataset.  (The
display might be very long.)

      There are three programs which will list and delete all messages
in the chain for any given userid (usually not your own).  Each of
these programs works according to a different principle.  The three
message delete programs are called BCMDEL, BCMDEL1, and BCMDEL2.

      BCMDEL probably is the only one of these programs which will
delete any user's messages from TSO user logs, if they are present.
BCMDEL works as follows:  BCMDEL temporarily changes the userid field
in your PSCB control block.  Then, BCMDEL invokes LISTBC to display and
delete all messages for the other user.  Since LISTBC is an IBM
program, it knows about TSO user logs (if they are there).  It follows
that BCMDEL, working on the other userid's name, will probably do
whatever IBM intended for LISTBC to do, regarding that userid.

      BCMDEL1 does not invoke LISTBC against the other userid.
BCMDEL1 invokes LISTBC against your own id, but it deletes the other
id's messages.  BCMDEL1 works as follows:  BCMDEL1 saves your userid's
message pointers, and then places the other userid's pointers in your
userid's slot.  Then BCMDEL1 invokes LISTBC against your own userid.
To clean up, BCMDEL1 goes and zeros the other userid's pointers and
finally replaces your own userid's saved pointers back.   BCMDEL1 uses
LISTBC only against your own userid, not against the other one.

      BCMDEL2 works directly with SYS1.BRODCAST internals, and does
not invoke LISTBC at all.  BCMDEL2 does the following processing:
First, BCMDEL2 displays the userid's messages in its chain, and
deletes each message after the display.  Afterwards, BCMDEL2 zeroes
out the userid's message pointers, and readjusts the Type X'05' free
search record address pointer to point to the earliest deleted message
relative record address (if that address is earlier than the previous
setting of the X'05' pointer).

      Since BCMDEL1 and BCMDEL2 work directly with SYS1.BRODCAST
internals, care is taken to try and ensure that normal broadcast
dataset updates will not clash with our programs' operation.  Hopefully
appropriate enqueues are invoked, to momentarily stop further updating
of SYS1.BRODCAST by the SEND and LISTBC commands, while BCMDEL1 and
BCMDEL2 are working.

      We must emphasize that this package of programs was not written
in a shop where TSO message USER LOGS have been set up.  If user logs
have been set up, BCMDEL will delete messages in them, because it
changes the userid and invokes IBM's LISTBC, which knows about the
user logs.  BCMDEL2 works directly on SYS1.BRODCAST internals, and
does not affect the user logs at all.  If user logs have not been set
up, all deferred TSO messages go to SYS1.BRODCAST.  If user logs have
been set up in TSO, and there is an old userid which has not since then
logged on to TSO, its TSOULOG dataset will not have been created yet.
If you want to delete SYS1.BRODCAST messages for that id, you have
to use BCMDEL2 or BCMDEL1.  BCMDEL will try to allocate the non-
existent user log dataset, and will not delete the messages from
SYS1.BRODCAST.

      The BCMDIAG program attempts to detect user message records
which are not attached to any userid chain.  Such orphaned records can
result from corruption of SYS1.BRODCAST; they are not created by
normal processing.  The action that should be taken to clean up these
records, at this time, is a matter of human judgment and knowledge.  I
have not yet perfected a program to handle and clean up all possible
situations.  However, I have developed some diagnostic techniques
using BCMDIAG, BCMLISY, the REVIEW TSO command, and the ZAP TSO
command.  Using all these programs, I have personally been able to
clean up a corrupted SYS1.BRODCAST dataset by fixing the chains and
deleting the orphaned records.

     I would recommend that even if your SYS1.BRODCAST dataset is not
full, and even if you have TSO Userlogs, you should still look at this
package to see what it can do for you.  In addition to what I've
described above, the BCMUSADD and BCMUSDEL programs allow you to add or
delete an arbitrary userid name in the SYS1.BRODCAST dataset.  This has
absolutely nothing to do with RACF, or ACCOUNT or SYNC.  My two programs
use the official IBM interface to SYS1.BRODCAST, so they work cleanly.

     One application:  You can monitor production jobs that belong to
userids which don't have TSO, by (temporarily) using BCMUSADD to put a
userid into SYS1.BRODCAST for that userid name.  In fact, the userid
can be completly arbitrary (and unique to that job).  You just insert
a NOTIFY= keyword into the job's JCL, for that userid name.

      After you do this, the NOTIFY messages for the production job
will be written to SYS1.BRODCAST, but will never be deleted by IBM
means.  Using my tools, you can display and/or delete these messages
for that userid, so you know if the job bombed, or completed
successfully, and when.  When you've finished testing, just use
BCMUSDEL to delete that userid and all its messages, from the
SYS1.BRODCAST dataset, to complete the cleanup.  (An ACCOUNT SYNC
will delete this userid (and everybody else's messages too), because
there's no such userid with a TSO extension, defined to RACF, UADS,
or whatever security system you have.)

      This is a very novel idea, and it can be very useful if you
have a troublesome production job and want to trace its recent
history.


      All of the message display programs use the TSO PUTLINE
interface for writing their messages.  Therefore, they may be run
via TSO-in-batch, and the messages will be displayed to SYSTSPRT.

      If you have any questions or problems, please feel free
      to contact me:

           Sam Golob,  P.O. Box 906,  Tallman, NY 10982-0906

           phone:
           email:   sbgolob@att.net   or sbgolob@cbttape.org




       BELOW IS A PICTORIAL VIEW OF SYS1.BRODCAST WHICH SHOULD
       HELP ONE TO BE ABLE TO NAVIGATE IT SUCCESSFULLY.

        This picture deals with user messages only, not global
        notices.  User messages are chained off a userid directory
        record.  There are nine userid directory records in a
        SYS1.BRODCAST user record.  A pointer to the first user
        record is in the broadcast header record, pictured below.

        Global notices utilize a different system within
        SYS1.BRODCAST.  For them, the header record points to the
        first notices index record.  Those index records activate
        and point to each notice line separately.  We are not
        concerned with the notice message lines here, or with the
        index pointers that activate them.  Our emphasis is on
        user messages which are associated with each TSO userid.

        Each userid record consists of 13 bytes:  7 bytes for the
        userid name, 3 bytes for the Relative Record Pointer to the
        first user message (which points to the next one, etc. until
        the last one, which contains zeros as the next record
        pointer).  The last 3 bytes are for the Relative Record
        Pointer to the last user message in the chain.  LISTBC uses
        the first pointer, to go through the entire message chain for
        that userid.  SEND uses the last message pointer, to tack on
        a new message after the previous last one.





                     S Y S 1 . B R O D C A S T
   ===============================================================
   =                                                             =
   =   *--*--------*---------*----------------------------*---*  =
   =   *04*        * R1USPTR *  'SYS1.BRODCAST DATA SET'  *   *  =
   =   *--*--------*-----+---*----------------------------*---*  =
   =                     +                                       =
   =    ++++++++++++++++++                                       =
   =    +     1ST USER MAIL DIRECTORY RECORD  (EACH USERID       =
   =    +       ENTRY CONSISTS OF A 13 BYTE AREA; THE USERID,    =
   =    +       NEXT RBA POINTER AND ENDING RBA POINTER.         =
   =    +                                                        =
   =   *--*-------*---*----* /// *------*---*----*--*-----*      =
   =   *01* USERID*RBA*ERBA* /// *USERID*RBA*ERBA*7F* RBA *      =
   =   *--*-------*---*----* /// *------*---*----*--*--+--*      =
   =                                                   +         =
   =    +++++++++++++++++++++++++++++++ //// +++++++++++         =
   =    +                                                        =
   =    +    LAST USER MAIL DIRECTORY RECORD                     =
   =    +                                                        =
   =    +    NOTE: '000' ENDS THE CHAIN OF X'01' RECORDS.        =
   =   *--*-------*---*----* /// *------*---*----*--*-----*      =
   =   *01* USERID*RBA*ERBA* /// *USERID*RBA*ERBA*7F* 000 *      =
   =   *--*-------*---*----* /// *------*-+-*-+--*--*--+--*      =
   =                                      +   +                  =
   =    +++++++++++++++++++++++++++++++++++   +++++++++++++++++  =
   =    +                                                     +  =
   =    +     1ST MESSAGE RECORD FOR USER                     +  =
   =   *--*-----------------------------------------*-----*   +  =
   =   *03*                                         * RBA *   +  =
   =   *--*-----------------------------------------*--+--*   +  =
   =                                                   +      +  =
   =    ++++++++++++++++++++++++++ //// ++++++++++++++++      +  =
   =    +                                                     +  =
   =    +++++++++++++++++++++++++++++++++++++++++++++++++++++++  =
   =    ++    LAST MESSAGE RECORD FOR USER                       =
   =    ++   NOTE: '000' ENDS THE CHAIN OF X'03' RECORDS.        =
   =   *--*-----------------------------------------*-----*      =
   =   *03*                                         * 000 *      =
   =   *--*-----------------------------------------*-----*      =
   =                                                             =
   =             FREE  SPACE  (deleted record)                   =
   =   *--*-----------------------------------------------*      =
   =   *FF*RR                                             *      =
   =   *--*-----------------------------------------------*      =
   =                                                             =
   =     (RR is the record number of this record from CCHHR)     =
   =                                                             =
   ===============================================================
```

