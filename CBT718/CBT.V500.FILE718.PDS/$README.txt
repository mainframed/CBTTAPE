                   WHAT DOES THIS SOFTWARE DO


This file contains a TSO Logon Pre-Prompt exit (IKJEFLD1) and a
corresponding TSO Logoff exit (IKJEFLD2).

The TSO Logon exit permits logging on to TSO using any JES subsystem,
including the Master subsystem (MSTR), since it too is a JES subsystem.

This provides the capability of logging onto secondary JES2's, for
example.  Unfortunately, to my knowledge, such a capability is beyond
JES3 - as the commercial goes, "if JES3 could do it, we'd support it.

As well, it provides the ability to logon under the MSTR Subsystem,
which is a life saver if JES2/JES3 will not start (e.g. JCL Error).

There have been various flavors of this modification in distribution.
Some did not support specifying the target subsystem; some required
adding special TSO userids to the IEFSSN member of parmlib; some
required zapping a module of MVS (MVS's STC component).

But I always prefer that if there is going to be any "zapping" going on,
that it be done in memory rather than on dasd.  The elimination of SMPE
maintenance issues, and ease of installation and backout should make
this obvious.

<======================================================================>

                  CHANGES YOU SHOULD MAKE


These exits support logging on to TSO, but the requirement still remains
that VTAM and TCAS can start.  These too can start under the MSTR
subsystem, by:

  1) Eliminating SYSOUT datasets in their JCL Procs (the MSTR subsystem
     does not support the SYSOUT SSI interface)

  2) Putting their JCL procs in a proclib @ by the IEFPDSI DD statement
     in your Master JCL (Parmlib member MSTJCLnn); note that it is NOT
     sufficient to put their JCL in a proclib specified to your Primary
     JES (i.e. in its JCL Proc, or dynamically); remember, we want these
     tasks to start EVEN if the primary JES does not.

     e.g.

     //MSTJCL00 JOB MSGLEVEL=(1,1),TIME=1440
     //         EXEC PGM=IEEMB860,DPRTY=(15,15)
     //STCINRDR DD SYSOUT=(A,INTRDR)
     //TSOINRDR DD SYSOUT=(A,INTRDR)
     //IEFPDSI  DD DSN=SYS2.PROCLIB,DISP=SHR
     //         DD DSN=SYS1.PROCLIB,DISP=SHR
     //         DD DSN=SYS1.IBM.PROCLIB,DISP=SHR
     //SYSUADS  DD DSN=SYS1.UADS,DISP=SHR
     //SYSLBC   DD DSN=SYS1.BRODCAST,DISP=SHR
     //SYSRACF  DD DSN=SYS1.RACF,DISP=SHR
     //VARYOFF  DD DSN=SYS2.VARYOFF,DISP=SHR

  3) Changing the command used to start them

     From:  S  NET
            S  TSO

     To  :  S  NET,SUB=MSTR,TIME=1440
            S  TSO,SUB=MSTR,TIME=1440

     Adding the TIME=1440 is a good idea, since the default time limit
     for jobs executing under the MSTR Subsystem is 0!!!

You can choose to have the capability of running VTAM and TCAS and TCP
under the Primary JES, for normal circumstances, with the ability to run
them under the MSTR subsystem in emergencies; this can be accomplished
by removing the SYSOUT datasets, then either placing their JCL Procs in
a single Proclib that is on both the MSTJCL's IEFPDSI DD statement AND
on your regular JES Proclib concatenation, or placing a copy of their
procs in two proclibs - one defined to the Master Subsystem, and one to
your Primary JES Subsystem.

If you do this, then your regular IPL Start commands would remain
unchanged.  If your Primary JES fails to start, you can manually issue
the MSTR versions of the START command for them, as shown above.

I can remember the response when I asked a staff member of mine who
handled VTAM if he had any issues with running VTAM under the MSTR
Subsystem.  His comment was that if VTAM all of a sudden had a great
urge to start submitting jobs via the internal reader (something that
since it uses a SYSOUT interface, cannot be done from a job executing
under MSTR), he'd want to know about it!!!

My point is that it really should be no issue eliminating SYSOUT
datasets from VTAM and TCAS (and TCP/Telnet) JCL Procs.

<======================================================================>

                  AUDITORS and the MASTER SUBSYSTEM


For your auditors, there are no security issues created by running
critical STC's under the Master Subsystem; in fact, it adds to your
system's reliability, so they should fully endorse it.

<======================================================================>

                           MISCALLANEOUS


I don't believe in adding unnecesary code that really doesn't add
anything, other than maintenance and debugging, therefore the LOGON exit
does not check to see if the subsystem entered is a valid and active
subsystem that supports running jobs (i.e. the Job Select SSI function).

<======================================================================>

                   TSO LOGON EXIT IKJEFLD1


If a TSO LOGON is perfomed, this exit gets control and if its special
format is not present, passes thru to regular logon (with one small
transparent exception).

If the logon exit encounters a LOGON command, followed by exactly one
blank, then a question mark, it invokes its extended logic.

1) Blank out the ?
2) Prompt the user to enter the subsystem they want to logon under; if
the user just presses enter, or enters the name of the Primary JES, then
the exit just passes thru.

Use something similar to the following command:

  LOGON ? Ýany data usual at your installation¨

Note the following changes:

1) Any SYSOUT requests from your TSO job will be directed to the
subsystem that your TSO job is executing under.  SDSF, the TSO Status,
Output and Submit commands, to name a few.

For example, if you submit a job while logged on under a secondary
JES2, the job will be submitted to the same secondary JES2.  Since MSTR
does not support SYSOUT, you cannot submit jobs from it - they would be
sent to the MSTR subsystem, which would tell you in no uncertain terms
that it is not the least bit interested (no system damage - just some
error messages).

2) If you are executing under a subsystem other than the Primary JES,
due to a technical limitation, you must LOGOFF when finished - you
cannot use the TSO LOGON command to re-logon.  The TSO LOGOFF exit
catches this and informs you of this limitation, should you be devious
and try.

<======================================================================>

                     TSO LOGOFF EXIT IKJEFLD2


The 2nd exit is a TSO Logoff exit.  It handles 2 conditions:

1) If an attempt is made to (re)LOGON using the TSO LOGON command, while
logged on to other than the Primary JES, you will receive a message
indicating that this is not possible - it will then force a LOGOFF.  The
logoff exit does not have access to the name of the subsystem used by
the TSO job that is logging off, so the LOGON exit passes its name in
the TSO Exit to Exit Communications Word.  If a vanilla (i.e. no "?")
logon is being performed, this is the only change that is performed -
the Primary JES' name will be passed from the logon exit to the logoff
exit.

2) If you are logging off of the MSTR subsystem, the Master Subsystem
sets a non-zero return code, which is expected and normal, however, the
TSO logon/logoff routines interpret any non-zero return code as an error
and issue an error message; the logoff exit resets the error code to 0
so that everyone is happy.  This is purely cosmetic.

<======================================================================>

                         INSTALLATION


This XMI file contains the following members:

  $README   - The member that you are reading
  IKJEFLD1  - The source code for the TSO Logon Exit
  IKJEFLD2  - The source code for the TSO Logoff Exit
  LOADLIB   - The already assembled source code in load module format
  ENTER     - A macro required to assemble the exits

If you want to use the already compiled binaries, issue the following
command:

  RECEIVE INDSN(this.pds(LOADLIB)) - enter

  At the prompt, specify the chosen LPA or Linklist library

Whether you choose to use the precompiled binaries, or to assemble from
source, the exits must reside in one of two locations:

LPA (recommended):

Copy these exits to a library that is on your LPA concatenation, then
do:
  SETPROG LPA,ADD,MOD=IKJEFLD1,DSN=lpalib-where-you-copied-it
  SETPROG LPA,ADD,MOD=IKJEFLD2,DSN=lpalib-where-you-copied-it

Note that if you IPL, you must do a CLPA; if not, then you will need to
re-issue the two SETPROG commands to again load the exits.

LINKLIST:

Copy these exits to an APF authorized, Linklist library (don't forget
to do an LLA Refesh (F LLA,REFRESH)

If you choose to recompile the source, the Link Edit attributes for both
modules are:

    AC(0), REFR, AMODE(24), RMODE(24)

They are entered in Key 8, Supervisor State (per IBM Documentation).

<======================================================================>

                        LEGAL INFORMATION


These programs are copyright 2005 Futurity Software International Inc.

They are hereby released to the public on the sole condition that the
program commentary header remain intact, displaying the copyright
information and the author's name, including any derivative works.

Futurity Software does not accept responsibility for any damage
resulting from the use of the supplied software.

The software is supplied "As Is".

Any use of this software implies acceptance of these conditions.


Garry G. Green
Futurity Software International Inc.
garry@futuritysoftware.com
