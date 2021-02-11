TESTVTM2 -- A Sample Complex Exit Driven VTAM Application
=========================================================

This is a special version of TESTVTM2 adapted to the non ACF
VTAM Level 2 that's available with MVS 3.8j. It supports most
terminal types that can occur on MVS 3.8j when running under
Hercules:

 - local non SNA 3270
 - local SNA 3270 attached through 3791L
 - remote SNA 3270 attached through 3705 NCP
 - local SNA TTY emulated as 3767 attached through 3791L
 - remote SNA TTY emulated as 3767 attached through 3705 NCP

This version is a rework of the original TESTVTM2 port to MVS 3.8J
done by Greg Price in 2003. Device support relies on the specific
behavior of VTAM level 2 and may be incompatible with later ACF/VTAM
versions. It should be noted that 3270 terminals get queried
unconditionally. So please use tn3270 emulations supporting
WSF QUERY only (don't know if others do exist at all) and also
use real 3270 tubes supporting WSF QUERY only.

Juergen Winkelmann (JW), ETH Zuerich, June 2012
winkelmann@id.ethz.ch

Credits: Binyamin Dissen - original version
         Greg Price      - first non ACF (MVS 3.8j) port (GP@P6)
         Greg Price      - I've stolen all of the 3270 query
                           structured field analysis and
                           3270 buffer address conversion
                           logic from the brilliant 3270
                           datastream article and sample
                           program on his website

Installation
============

1. Upload and receive TESTVTM2.XMI to a PDS of your choice (LRECL 80).

2. If necessary change dataset names (marked with <--) in job TESTVTM$.

3. Submit job TESTVTM$. RC=0 is expected for both steps.

4. If you placed the TESTVTM2 module in linklist and are using DYNABLDL,
   refresh it (run DBSTOP, then DBSTART).

5. Create an application major node member X in your VTAMLST library
   containing one line:

   Y        APPL AUTH=NVPACE,BUFFACT=10

   (replace X with a valid member name and Y with the desired VTAM
   application name).

6. Create member TESTVTM2 in a system proclib as follows:

   //TESTVTM2 PROC
   //STEP1   EXEC PGM=TESTVTM2,REGION=4096K,TIME=1440,PARM='Y       '
   //SNAPFILE DD  SYSOUT=X,HOLD=YES
   //SYSUDUMP DD  SYSOUT=X,HOLD=YES

   (replace Y with the application name chosen in step 5).

7. Enter

   V NET,ACT,ID=X

   at the MVS console (replace X with the membername chosen in step 5).
   This command must be issued after each startup of VTAM unless the
   membername X is added to the ATCCONxx list.

8. Enter

   S TESTVTM2

   at the MVS console. Message

   +TESTVTM2 - APPLICATION TESTVTM2 IS UP

   will be issued to indicate successful startup.

Usage
=====

TESTVTM2 is a program to demonstrate asynchronous terminal handling
using VTAM exits. It implements a terminal dialog providing a few sample
commands. These can easily be changed to create real applications.
As is, a maximum number of 3 terminals can connect to TESTVTM2 at the
same time. This number can be changed by setting the NUMCIDS EQUate in
line 2325 to the desired value and rerunning job TESTVTM$.

There are several ways to connect a terminal to TESTVTM2:

a) Enter V NET,INACT,ID=luname at the MVS console (luname is the LU name
   of the terminal). Once the terminal is inactive, enter

   V NET,ACT,ID=LUNAME,LOGON=Y

   (replace Y with the application name chosen in step 5).

b) Depending on the setup of your logon interpret table (LOGTAB), USS
   table, network solicitor and the terminal type it may be possible to
   self initiate the connection from the terminal by entering a BAL or
   or PL/1 type logon message at the terminal, like for example:

   LOGON APPLID=Y or
   LOGON APPLID(Y)

   On SNA connections (3705, 3791L) "Stickman" mode must be supported by
   the terminal emulation and the message must be sent on the SSCP-LU
   session using the SYSRQ key. Sadly, most tn3270 applications don't
   support this. If your tn3270 application doesn't support this, you
   can use option a) only, except you use a network solicitor to pass
   the terminal to the application.

Once the connection is established the terminal will display

- a logo and a one line input field into which a command can be entered,
  if it is a 3270 device.

- a command prompt if it is a linemode (tty) type device.

The "command interpreter" is very basic: Just CLC instructions ;-)
So, commands need to be entered _EXACTLY_ as described here (case isn't
relevant, i.e. any combination of upper/lower case characters is
recognized). The following commands are implemented:

------------------------------------------------------------------------

LOGOFF

disconnect the terminal from the TESTVTM2 application.

------------------------------------------------------------------------

SHUTDOWN

terminate the TESTVTM2 application.

------------------------------------------------------------------------

SHOWTERM or SHOW TERM

display your terminals LU name and screen size (note: linemode terminals
will always display as a 000 x 080 "screen").

------------------------------------------------------------------------

SHOWALL or SHOW ALL

display the LU names of all terminals logged on currently.

------------------------------------------------------------------------

SHOW APP

display the TESTVTM2 application name (i.e. the value Y in the above
APPL statement).

------------------------------------------------------------------------

STATS

display RPL usage statistics.

------------------------------------------------------------------------

STATUS applname

display the status of VTAM application applname (enter for example
STATUS TSO).

------------------------------------------------------------------------

SEND luname text

send text to terminal luname

------------------------------------------------------------------------

PROMPT2

just shows a prompt message

------------------------------------------------------------------------

SENDF2

request a snap dump of the terminal buffer (works with
local non SNA 3270 terminals only)

------------------------------------------------------------------------

On 3270 terminals CLEAR and PA1 can be pressed to produce messages
indicating that these keys were pressed.

------------------------------------------------------------------------
