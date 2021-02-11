 ISPF Edit Macros & Dialogs
 July 16, 1998

 John Kalinich
 USA Logistics Systems
  Support Center
 AMSEL-SE-BSD-LS-TD, Room 7.103
 1222 Spruce Street
 St. Louis, MO.  63103-2834

 314-331-4521
 314-331-4520 (FAX)

 SHARE Installation Code:  ALM
 Internet mailbox:  kalinichj@lssc.army.mil  OR
                    kalinichj@st-louis-exch01.army.mil

 .----------------------------------------------------------------.
 | Feel free to call if you have any problems with this code.     |
 | If you can't reach me by phone, then send me an e-mail or fax. |
 '----------------------------------------------------------------'


File     Ext    Description

$CHANGE  LOG    Changes to macros/dialogs since SHARE 78
$INSTALL ME     An attempt at install instructions
$READ    ME     What you are reading
$WARRAN  TEE    The standard "mods" disclaimer
#ACFCOMP PAN    Tutorial panel for ACFCOMP macro
#ACFTRAP PAN    Tutorial panel for ACFTRAP macro
#ASA2PC  PAN    Tutorial panel for ASA2PC macro
#BROWSE4 PAN    Tutorial panel for BROWSE4 macro
#EOL     PAN    Tutorial panel for EOL macro
#FX      PAN    Tutorial panel for FX macro
#FXC     PAN    Tutorial panel for FXC macro
#GO      PAN    Tutorial panel for GO macro
#JC      PAN    Tutorial panel for JC macro
#LISTDSI PAN    Tutorial panel for LISTDSI macro
#MEMLIST PAN    Tutorial panel for MEMLIST macro
#OPER    PAN    Tutorial panel for OPER macro
#PLUG    PAN    Tutorial panel for PLUG macro
#PROFSET PAN    Tutorial panel for PROFSET macro
#RUN     PAN    Tutorial panel for RUN macro
#RUNACF  PAN    Tutorial panel for RUNACF macro
#SHOWCUT PAN    Tutorial panel for SHOWCUT macro
#TESTACF PAN    Tutorial panel for TESTACF macro
#UNX     PAN    Tutorial panel for UNX macro
#WEAVE   PAN    Tutorial panel for WEAVE macro
ACFCOMP  REX    ACFCOMP macro - Compile the ACF2 rule currently being edited
ACFTRAP  REX    ACFTRAP macro - Queue ACF subcommands and trap output
ASA2PC   REX    ASA2PC macro - Convert ASA printer control to ASCII code
BROWSE4  CLI    BROWSE4 macro - Invoke ISPF Browse/View while in edit
BROWZE   CLI    CLIST dialog to browse data sets (for ISPF command table usage)
CALCP    PAN    Pop-up window used in CALC command/COMPUTE dialog
CEILING  REX    REXX function to find smallest integer >= argument
CLONEID  REX    REXX dialog to decomp a logonid into INSERT format for cloning
COMPUTE  REX    REXX dialog to calculate Rexx arithmetic expressions
DSK33XX  CLI    CLIST dialog for disk space calculation (3350/3380/3390)
DSK33XX  PAN    ISPF panel for disk space calculation (3350/3380/3390)
DVOL     CLI    CLIST dialog to display disk free space stats from DVOL command
DVOL     PAN    ISPF panel for DVOL dialog
DVOLTBLH PAN    Tutorial panel for DVOL table display (short)
DVOLTBLL PAN    ISPF panel used by DVOL table display (long)
DVOLTBLS PAN    ISPF panel used by DVOL table display (short)
EB       CLI    CLIST dialog to Edit/Browse by the numbers from a menu of DSNs
EBH01A   PAN    Tutorial panel for Edit/Browse menu
EBH01B   PAN    Turorial panel for Edit/Browse set default modes and libraries
EB00     MSG    ISPF messages for Edit/Browse dialog
EB01A    PAN    ISPF panel for Edit/Browse menu
EB01B    PAN    ISPF panel for Edit/Browse set default modes and libraries
EDET     CLI    CLIST dialog to edit data sets (for ISPF command table usage)
EOL      REX    EOL macro - Set cursor at end of current screen line
FLOOR    REX    REXX function to find largest integer <= argument
FX       CLI    FX macro  - FIND 'str' ALL after EXCLUDE ALL
FX       SPF    FX macro  - REXX version for SPF/PC Version 3.0
FXC      CLI    FXC macro - FIND 'str @ cursor' ALL after EXCLUDE ALL
GETACCT  REX    REXX sub-function to get accounting info from ACT
GETACF2  REX    REXX sub-function to get ACF2 release identifier from ACCVT
GETATTR  REX    REXX sub-function to get TSO user attributes from PSCB
GETCIB   REX    REXX sub-function to get command verb code from 1st CIB
GETCPUM  REX    REXX sub-function to get CPU model from CVT prefix
GETDEST  REX    REXX sub-function to get TSO SYSOUT destination from PSCB
GETDFPL  REX    REXX sub-function to get DFP level from DFA
GETGRPN  REX    REXX sub-function to get group connect name from ACEE
GETIPLD  REX    REXX sub-function to get IPL date from SMCA
GETIPLT  REX    REXX sub-function to get IPL time from SMCA
GETJES2  REX    REXX sub-function to get JES2 product name from HASPSSSM
GETJOBID REX    REXX sub-function to get JES2 job id from SSIB
GETLPAR  REX    REXX sub-function to get LPAR mode from SCCB
GETNAME  REX    REXX sub-function to get user name from ACEE
GETPLEX  REX    REXX sub-function to get SYSPLEX name from ECVT
GETPRGNM REX    REXX sub-function to get programmer name from ACT
GETREALM REX    REXX sub-function to get real memory size at IPL
GETREGK  REX    REXX sub-function to get region size from LDA
GETSCPN  REX    REXX sub-function to get MVS SCP name from CVT prefix
GETSMFID REX    REXX sub-function to get smfid from SMCA
GETSMS   REX    REXX sub-function to get SMS status from JESCTEXT
GETSWA   REX    REXX sub-function to get location of SWA from JCT
GETTRID  REX    REXX sub-function to get terminal id from ACEE
GETUID   REX    REXX sub-function to get ACF2 userid string
GO       CLI    GO macro - SUBMIT job then invoke IOF
IDCAMS   REX    IDCAMS macro - execute IDCAMS commands (like =3.2.V 'exec')
IEBUPDTE BAT    DOS batch file #2 to consolidate members for upload to MVS
INFO     ABC    Action bar choice panel code to display system information
ISFP     CLI    World's shortest CLIST
ISFPANEL PAN    SDSF panel modifications for OPER macro
ISPCMDS  TBL    ISPF commands to be added to ISPCMDS for dialog invocation
ISR@PRIM PAN    ISPF Primary Option Menu (Version 3.3)
ISRUTIL  PAN    ISPF (Version 2.3) utility panel modifications for =3.14B
ISRZ00   MSG    ISPF messages ISRZ000W and ISRZ001W displayed in windows
JC       CLI    JC macro - JOB card generator
JC       PAN    ISPF panel used by JC and JCI macros
JCI      CLI    JCI macro - JOB card generator (for use after file tailoring)
LIBDIR   REX    REXX exec to display a CA-Librarian index
LISTDSI  CLI    LISTDSI macro - List dataset info in OPT32 format
LOGLIST  CLI    CLIST dialog to define output descriptors for ISPLOG/ISPLIST
LOGLIST  JCL    ISPF skeleton used by LOGLIST dialog
LOGLIST  PAN    ISPF panel used by LOGLIST dialog
MEMLIST  CLI    MEMLIST macro - Display member list of PDS on =NOTE= lines
MVS      BAS    MVS basica program - Pseudo-display of ISPF Primary Option Menu
NOWARN   REX    REXX exec that issues RECOVERY OFF NOWARN (used with PROFSET)
OPER     CLI    OPER macro - Issued canned operator commands via SDSF
PDSDIR   REX    REXX exec to display a PDS directory
PDSFTP   PAN    ISPF pop-up panel used by PDSFTP dialog
PDSFTP   REX    REXX dialog to automate PDS member FTP's
PDSFTPLM PAN    ISPF member list panel used by PDSFTP
PDSFTPT  PAN    Tutorial panel for PDSFTP
PLUG     REX    PLUG macro - Plug data into a range of lines at a given column
PLUG     SPF    PLUG macro - REXX version for SPF/PC Version 3.0
PROFSET  REX    PROFSET macro - Mass change all edit profiles for an applid
RESETID  REX    REXX exec to reduce ACF2 password violation count by 1
RUN      CLI    RUN macro - EXECute the CLIST/EXEC that is being edited
RUNACF   REX    RUNACF macro - Issue ACF subcommands currently being edited
SHOWCUT  CLI    SHOWCUT macro - Browse the ISPF CUT table(s) - PDS 8.5 CUT
SHOWCUTP PAN    ISPF panel used by SHOWCUT table display
SORTWORK PAN    ISPF panel used by SORTWORK dialog
SORTWORK REX    REXX dialog to calculate SYNCSORT sortwork space
STARTUP  CLI    CLIST code run during TSO start-up to execute @LOGLIST
SUPERC   CLI    CLIST dialog for SEARCH-FOR batch job (OPT314B)
SUPERC   JCL    ISPF skeleton JCL to invoke SUPERC program in batch
SYSLOG   CLI    CLIST dialog for browsing of current or previous SYSLOG
SYSLOG   PAN    ISPF panel used by SYSLOG dialog
TESTACF  REX    TESTACF macro - Test ACF2 rules based on DSN= values in JCL
TRAPCMD  REX    REXX dialog to trap TSO/REXX output and display in ISPF table
TRAPTBL  PAN    ISPF panel used by TRAPCMD table display
TRICMDS  PAN    Tutorial panel for ISPF command help
TRIJOBS  PAN    ISPF panel used to display key jobs with SDSF or IOF
TRIMACS  PAN    Tutorial panel for edit macro help
UNX      CLI    UNX macro - Show the first n line(s) from each X-cluded block
UPLOAD   BAT    DOS batch file #1 to consolidate members for upload to MVS
WEAVE    REX    WEAVE macro - Interlace CUT table into a range of lines
