```
//***FILE 718 contains two TSO LOGON exits from Gary Green.         *   FILE 718
//*           A detailed description of the file follows:           *   FILE 718
//*                                                                 *   FILE 718
//*     Garry G. Green                                              *   FILE 718
//*     Futurity Software International Inc.                        *   FILE 718
//*     garry@futuritysoftware.com                                  *   FILE 718
//*                                                                 *   FILE 718
//*     <=====================================================>     *   FILE 718
//*                                                                 *   FILE 718
//*     File Description:                                           *   FILE 718
//*                                                                 *   FILE 718
//*     This file contains a TSO Logon Pre-Prompt exit              *   FILE 718
//*     (IKJEFLD1) and a corresponding TSO Logoff exit              *   FILE 718
//*     (IKJEFLD2).                                                 *   FILE 718
//*                                                                 *   FILE 718
//*     The TSO Logon exit permits logging on to TSO using any      *   FILE 718
//*     JES subsystem, including the Master subsystem (MSTR),       *   FILE 718
//*     since it too is a JES subsystem.                            *   FILE 718
//*                                                                 *   FILE 718
//*     This provides the capability of logging onto secondary      *   FILE 718
//*     JES2's, for example.  Unfortunately, to my knowledge,       *   FILE 718
//*     such a capability is beyond JES3 - as the commercial        *   FILE 718
//*     goes, "if JES3 could do it, we'd support it.                *   FILE 718
//*                                                                 *   FILE 718
//*     As well, it provides the ability to logon under the         *   FILE 718
//*     MSTR Subsystem, which is a life saver if JES2/JES3 will     *   FILE 718
//*     not start (e.g. JCL Error).                                 *   FILE 718
//*                                                                 *   FILE 718
//*     There have been various flavors of this modification in     *   FILE 718
//*     distribution.  Some did not support specifying the          *   FILE 718
//*     target subsystem; some required adding special TSO          *   FILE 718
//*     userids to the IEFSSN member of parmlib; some required      *   FILE 718
//*     zapping a module of MVS (MVS's STC component).              *   FILE 718
//*                                                                 *   FILE 718
//*     But I always prefer that if there is going to be any        *   FILE 718
//*     "zapping" going on, that it be done in memory rather        *   FILE 718
//*     than on dasd.  The elimination of SMPE maintenance          *   FILE 718
//*     issues, and ease of installation and backout should         *   FILE 718
//*     make this obvious.                                          *   FILE 718
//*                                                                 *   FILE 718
//*     <=====================================================>     *   FILE 718
//*                                                                 *   FILE 718
//*                     CHANGES YOU SHOULD MAKE                     *   FILE 718
//*                                                                 *   FILE 718
//*                                                                 *   FILE 718
//*     These exits support logging on to TSO, but the              *   FILE 718
//*     requirement still remains that VTAM and TCAS can start.     *   FILE 718
//*     These too can start under the MSTR subsystem, by:           *   FILE 718
//*                                                                 *   FILE 718
//*       1) Eliminating SYSOUT datasets in their JCL Procs         *   FILE 718
//*          (the MSTR subsystem does not support the SYSOUT        *   FILE 718
//*          SSI interface)                                         *   FILE 718
//*                                                                 *   FILE 718
//*       2) Putting their JCL procs in a proclib @ by the          *   FILE 718
//*          IEFPDSI DD statement in your Master JCL (Parmlib       *   FILE 718
//*          member MSTJCLnn); note that it is NOT sufficient       *   FILE 718
//*          to put their JCL in a proclib specified to your        *   FILE 718
//*          Primary JES (i.e. in its JCL Proc, or                  *   FILE 718
//*          dynamically); remember, we want these tasks to         *   FILE 718
//*          start EVEN if the primary JES does not.                *   FILE 718
//*                                                                 *   FILE 718
//*          e.g.                                                   *   FILE 718
//*                                                                 *   FILE 718
//*          //MSTJCL00 JOB MSGLEVEL=(1,1),TIME=1440                *   FILE 718
//*          //         EXEC PGM=IEEMB860,DPRTY=(15,15)             *   FILE 718
//*          //STCINRDR DD SYSOUT=(A,INTRDR)                        *   FILE 718
//*          //TSOINRDR DD SYSOUT=(A,INTRDR)                        *   FILE 718
//*          //IEFPDSI  DD DSN=SYS2.PROCLIB,DISP=SHR                *   FILE 718
//*          //         DD DSN=SYS1.PROCLIB,DISP=SHR                *   FILE 718
//*          //         DD DSN=SYS1.IBM.PROCLIB,DISP=SHR            *   FILE 718
//*          //SYSUADS  DD DSN=SYS1.UADS,DISP=SHR                   *   FILE 718
//*          //SYSLBC   DD DSN=SYS1.BRODCAST,DISP=SHR               *   FILE 718
//*          //SYSRACF  DD DSN=SYS1.RACF,DISP=SHR                   *   FILE 718
//*          //VARYOFF  DD DSN=SYS2.VARYOFF,DISP=SHR                *   FILE 718
//*                                                                 *   FILE 718
//*       3) Changing the command used to start them                *   FILE 718
//*                                                                 *   FILE 718
//*          From:  S  NET                                          *   FILE 718
//*                 S  TSO                                          *   FILE 718
//*                                                                 *   FILE 718
//*          To  :  S  NET,SUB=MSTR,TIME=1440                       *   FILE 718
//*                 S  TSO,SUB=MSTR,TIME=1440                       *   FILE 718
//*                                                                 *   FILE 718
//*          Adding the TIME=1440 is a good idea, since the         *   FILE 718
//*          default time limit for jobs executing under the        *   FILE 718
//*          MSTR Subsystem is 0!!!                                 *   FILE 718
//*                                                                 *   FILE 718
//*     You can choose to have the capability of running VTAM       *   FILE 718
//*     and TCAS and TCP under the Primary JES, for normal          *   FILE 718
//*     circumstances, with the ability to run them under the       *   FILE 718
//*     MSTR subsystem in emergencies; this can be accomplished     *   FILE 718
//*     by removing the SYSOUT datasets, then either placing        *   FILE 718
//*     their JCL Procs in a single Proclib that is on both the     *   FILE 718
//*     MSTJCL's IEFPDSI DD statement AND on your regular JES       *   FILE 718
//*     Proclib concatenation, or placing a copy of their procs     *   FILE 718
//*     in two proclibs - one defined to the Master Subsystem,      *   FILE 718
//*     and one to your Primary JES Subsystem.                      *   FILE 718
//*                                                                 *   FILE 718
//*     If you do this, then your regular IPL Start commands        *   FILE 718
//*     would remain unchanged.  If your Primary JES fails to       *   FILE 718
//*     start, you can manually issue the MSTR versions of the      *   FILE 718
//*     START command for them, as shown above.                     *   FILE 718
//*                                                                 *   FILE 718
//*     I can remember the response when I asked a staff member     *   FILE 718
//*     of mine who handled VTAM if he had any issues with          *   FILE 718
//*     running VTAM under the MSTR Subsystem.  His comment was     *   FILE 718
//*     that if VTAM all of a sudden had a great urge to start      *   FILE 718
//*     submitting jobs via the internal reader (something that     *   FILE 718
//*     since it uses a SYSOUT interface, cannot be done from a     *   FILE 718
//*     job executing under MSTR), he'd want to know about          *   FILE 718
//*     it!!!                                                       *   FILE 718
//*                                                                 *   FILE 718
//*     My point is that it really should be no issue               *   FILE 718
//*     eliminating SYSOUT datasets from VTAM and TCAS (and         *   FILE 718
//*     TCP/Telnet) JCL Procs.                                      *   FILE 718
//*                                                                 *   FILE 718
//*     <=====================================================>     *   FILE 718
//*                                                                 *   FILE 718
//*                AUDITORS and the MASTER SUBSYSTEM                *   FILE 718
//*                                                                 *   FILE 718
//*                                                                 *   FILE 718
//*     For your auditors, there are no security issues created     *   FILE 718
//*     by running critical STC's under the Master Subsystem;       *   FILE 718
//*     in fact, it adds to your system's reliability, so they      *   FILE 718
//*     should fully endorse it.                                    *   FILE 718
//*                                                                 *   FILE 718
//*     <=====================================================>     *   FILE 718
//*                                                                 *   FILE 718
//*                         MISCELLANEOUS                           *   FILE 718
//*                                                                 *   FILE 718
//*     I don't believe in adding unnecesary code that really       *   FILE 718
//*     doesn't add anything, other than maintenance and            *   FILE 718
//*     debugging, therefore the LOGON exit does not check to       *   FILE 718
//*     see if the subsystem entered is a valid and active          *   FILE 718
//*     subsystem that supports running jobs (i.e. the Job          *   FILE 718
//*     Select SSI function).                                       *   FILE 718
//*                                                                 *   FILE 718
//*     <=====================================================>     *   FILE 718
//*                                                                 *   FILE 718
//*                     TSO LOGON EXIT IKJEFLD1                     *   FILE 718
//*                                                                 *   FILE 718
//*                                                                 *   FILE 718
//*     If a TSO LOGON is perfomed, this exit gets control and      *   FILE 718
//*     if its special format is not present, passes thru to        *   FILE 718
//*     regular logon (with one small transparent exception).       *   FILE 718
//*                                                                 *   FILE 718
//*     If the logon exit encounters a LOGON command, followed      *   FILE 718
//*     by exactly one blank, then a question mark, it invokes      *   FILE 718
//*     its extended logic.                                         *   FILE 718
//*                                                                 *   FILE 718
//*     1) Blank out the ?                                          *   FILE 718
//*     2) Prompt the user to enter the subsystem they want to      *   FILE 718
//*     logon under; if the user just presses enter, or enters      *   FILE 718
//*     the name of the Primary JES, then the exit just passes      *   FILE 718
//*     thru.                                                       *   FILE 718
//*                                                                 *   FILE 718
//*     Use something similar to the following command:             *   FILE 718
//*                                                                 *   FILE 718
//*       LOGON ? Ýany data usual at your installation¨             *   FILE 718
//*                                                                 *   FILE 718
//*     Note the following changes:                                 *   FILE 718
//*                                                                 *   FILE 718
//*     1) Any SYSOUT requests from your TSO job will be            *   FILE 718
//*     directed to the subsystem that your TSO job is              *   FILE 718
//*     executing under.  SDSF, the TSO Status, Output and          *   FILE 718
//*     Submit commands, to name a few.                             *   FILE 718
//*                                                                 *   FILE 718
//*     For example, if you submit a job while logged on under      *   FILE 718
//*     a secondary JES2, the job will be submitted to the same     *   FILE 718
//*     secondary JES2.  Since MSTR does not support SYSOUT,        *   FILE 718
//*     you cannot submit jobs from it - they would be sent to      *   FILE 718
//*     the MSTR subsystem, which would tell you in no              *   FILE 718
//*     uncertain terms that it is not the least bit interested     *   FILE 718
//*     (no system damage - just some error messages).              *   FILE 718
//*                                                                 *   FILE 718
//*     2) If you are executing under a subsystem other than        *   FILE 718
//*     the Primary JES, due to a technical limitation, you         *   FILE 718
//*     must LOGOFF when finished - you cannot use the TSO          *   FILE 718
//*     LOGON command to re-logon.  The TSO LOGOFF exit catches     *   FILE 718
//*     this and informs you of this limitation, should you be      *   FILE 718
//*     devious and try.                                            *   FILE 718
//*                                                                 *   FILE 718
//*     <=====================================================>     *   FILE 718
//*                                                                 *   FILE 718
//*                    TSO LOGOFF EXIT IKJEFLD2                     *   FILE 718
//*                                                                 *   FILE 718
//*                                                                 *   FILE 718
//*     The 2nd exit is a TSO Logoff exit.  It handles 2            *   FILE 718
//*     conditions:                                                 *   FILE 718
//*                                                                 *   FILE 718
//*     1) If an attempt is made to (re)LOGON using the TSO         *   FILE 718
//*     LOGON command, while logged on to other than the            *   FILE 718
//*     Primary JES, you will receive a message indicating that     *   FILE 718
//*     this is not possible - it will then force a LOGOFF.         *   FILE 718
//*     The logoff exit does not have access to the name of the     *   FILE 718
//*     subsystem used by the TSO job that is logging off, so       *   FILE 718
//*     the LOGON exit passes its name in the TSO Exit to Exit      *   FILE 718
//*     Communications Word.  If a vanilla (i.e. no "?") logon      *   FILE 718
//*     is being performed, this is the only change that is         *   FILE 718
//*     performed - the Primary JES' name will be passed from       *   FILE 718
//*     the logon exit to the logoff exit.                          *   FILE 718
//*                                                                 *   FILE 718
//*     2) If you are logging off of the MSTR subsystem, the        *   FILE 718
//*     Master Subsystem sets a non-zero return code, which is      *   FILE 718
//*     expected and normal, however, the TSO logon/logoff          *   FILE 718
//*     routines interpret any non-zero return code as an error     *   FILE 718
//*     and issue an error message; the logoff exit resets the      *   FILE 718
//*     error code to 0 so that everyone is happy.  This is         *   FILE 718
//*     purely cosmetic.                                            *   FILE 718
//*                                                                 *   FILE 718
//*     <=====================================================>     *   FILE 718
//*                                                                 *   FILE 718
//*                        INSTALLATION                             *   FILE 718
//*                                                                 *   FILE 718
//*                                                                 *   FILE 718
//*     This XMI file contains the following members:               *   FILE 718
//*                                                                 *   FILE 718
//*       $README   - The member that you are reading               *   FILE 718
//*       IKJEFLD1  - The source code for the TSO Logon Exit        *   FILE 718
//*       IKJEFLD2  - The source code for the TSO Logoff Exit       *   FILE 718
//*       LOADLIB   - The already assembled source code in load     *   FILE 718
//*                   module format                                 *   FILE 718
//*       ENTER     - A macro required to assemble the exits        *   FILE 718
//*                                                                 *   FILE 718
//*     If you want to use the already compiled binaries, issue     *   FILE 718
//*     the following command:                                      *   FILE 718
//*                                                                 *   FILE 718
//*       RECEIVE INDSN(this.pds(LOADLIB)) - enter                  *   FILE 718
//*                                                                 *   FILE 718
//*       At the prompt, specify the chosen LPA or Linklist         *   FILE 718
//*       library                                                   *   FILE 718
//*                                                                 *   FILE 718
//*     Whether you choose to use the precompiled binaries, or      *   FILE 718
//*     to assemble from source, the exits must reside in one       *   FILE 718
//*     of two locations:                                           *   FILE 718
//*                                                                 *   FILE 718
//*     LPA (recommended):                                          *   FILE 718
//*                                                                 *   FILE 718
//*     Copy these exits to a library that is on your LPA           *   FILE 718
//*     concatenation, then do:                                     *   FILE 718
//*       SETPROG LPA,ADD,MOD=IKJEFLD1,DSN=lpalib-copied-to         *   FILE 718
//*       SETPROG LPA,ADD,MOD=IKJEFLD2,DSN=lpalib-copied-to         *   FILE 718
//*                                                                 *   FILE 718
//*     Note that if you IPL, you must do a CLPA; if not, then      *   FILE 718
//*     you will need to re-issue the two SETPROG commands to       *   FILE 718
//*     again load the exits.                                       *   FILE 718
//*                                                                 *   FILE 718
//*     LINKLIST:                                                   *   FILE 718
//*                                                                 *   FILE 718
//*     Copy these exits to an APF authorized, Linklist library     *   FILE 718
//*     (don't forget to do an LLA Refesh (F LLA,REFRESH)           *   FILE 718
//*                                                                 *   FILE 718
//*     If you choose to recompile the source, the Link Edit        *   FILE 718
//*     attributes for both modules are:                            *   FILE 718
//*                                                                 *   FILE 718
//*         AC(0), REFR, AMODE(24), RMODE(24)                       *   FILE 718
//*                                                                 *   FILE 718
//*     They are entered in Key 8, Supervisor State (per IBM        *   FILE 718
//*     Documentation).                                             *   FILE 718
//*                                                                 *   FILE 718
//*     <=====================================================>     *   FILE 718
//*                                                                 *   FILE 718
//*                      LEGAL INFORMATION                          *   FILE 718
//*                                                                 *   FILE 718
//*                                                                 *   FILE 718
//*     These programs are copyright 2005 Futurity Software         *   FILE 718
//*     International Inc.                                          *   FILE 718
//*                                                                 *   FILE 718
//*     They are hereby released to the public on the sole          *   FILE 718
//*     condition that the program commentary header remain         *   FILE 718
//*     intact, displaying the copyright information and the        *   FILE 718
//*     author's name, including any derivative works.              *   FILE 718
//*                                                                 *   FILE 718
//*     Futurity Software does not accept responsibility for        *   FILE 718
//*     any damage resulting from the use of the supplied           *   FILE 718
//*     software.                                                   *   FILE 718
//*                                                                 *   FILE 718
//*     The software is supplied "As Is".                           *   FILE 718
//*                                                                 *   FILE 718
//*     Any use of this software implies acceptance of these        *   FILE 718
//*     conditions.                                                 *   FILE 718
//*                                                                 *   FILE 718

```
