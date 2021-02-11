
## $$$DOC.txt
```
NAME     - SNTPD

TITLE    - SIMPLE NETWORK TIME DAEMON (SNTPD)

VERSION  - 1.2

FUNCTION - This is a Simple Network Time Protocol (SNTPv3)
           server as defined by RFC2030 (which defines SNTPv4,
           but this server does not implement any of the SNTPv4
           optional extensions).

           This SNTP server listens for UDP packets on port 123
           and responds the current TOD clock time to any NTP v1,
           v2, v3, or v4 client to a precision of 2 microseconds.

NOTES    - 1. This server cannot alter the Time Of Day (TOD)
              clock. If you specify the TOD +hhmm adjustment command
              then that adjustment is applied each time a
              TOD clock value is to be translated to an RFC2030
              clock value for transmission to an NTP client.
              Altering the actual hardware TOD clock requires
              operator intervention and cannot be done by a
              program alone.


MEMBERS  - The list of members in the distribution PDS are:

           $$$DOC   - This file.
           ASM      - JCL to assemble/link the SNTP server.
           C2X      - Macro to convert binary to displayable hex.
           DEBUG    - Macro to assemble debug code.
           EYECATCH - Macro to assemble an eye-catcher.
           GETCMD   - Source code to obtain the next operator command.
           GPL      - The GNU General Public License.
           LOG      - Macro to conditionally print a log message.
           RFC2030  - The SNTPv4 Request For Comments.
           RUNJOB   - JCL to run the SNTP server as a job.
           RUNPROC  - JCL to run the SNTP server as a proc (TCPSNTP).
           SAY      - Macro to print a formatted log message.
           SNTPD    - Source code for the SNTP server.
           TCPSNTP  - JCL for the SNTP server proc.

INSTALL  - To install and run:

           1. Edit the ASM member and set the following JCL variables:

              SET SRC=your.source.pds     (this PDS)
              SET LIB=your.load.library   (where you want the loadmod)
              SET SEZATCP=TCPIP.SEZATCP   (your SEZATCP target library)

           2. Submit the ASM member to assemble/link the server.

           3. Edit and submit the RUNJOB to run the server as a job.
              You can cancel it to shut it down.

           4. Edit the TCPSNTP member, customize it and put it in your
              proclib concatenation. You may have to set up RACF to
              allow TCPSNTP to be run as a started task.

           5. Update your TCPIP.PROFILE to allow the TCPSNTP started
              task to listen on port 123.  Add:

              PORT
                123 UDP TCPSNTP ; Simple Network Time Protocol server

           6. Start the SNTP server started task by issuing:

              S TCPSNTP

              You can disable logging at start up by issuing:

              S TCPSNTP,,,LOG 0

           7. You can modify the logging level after start up by:

              F TCPSNTP,,,LOG nn

           8. You can stop the server by:

              P TCPSNTP
              or...
              F TCPSNTP,STOP


STARTUP  - Sample command to start the server:

           S TCPSNTP,,,LOGGING LEVEL IS 60

           Multiple comma-separated commands may be entered on the
           start command. For example:

           S TCPSNTP,,,LOG 0,TOD +1000,NOSWAP

           See below for the full list of commands.


SHUTDOWN - Sample command to stop the server:

           P TCPSNTP
           ...or...
           F TCPSNTP,STOP


COMMANDS - Operator commands supported are:

           F TCPSNTP,cmd

           Where, cmd is:

           LOG nn
              Set the logging level to nn, where nn is any  numb-
              er between 0 and 255 and has the following (cumul-
              ative) meanings:

               0-9    NONE      No logging
              10-19   ERROR     Error messages
              20-24   WARNING   Warning messages
              25-29   SUMMARY   Summary statistics
              30-39   INFO      Information, short data contents
              40-49   BANNER    Routine labels
              50-59   DEBUG     Debugging messages
              60-255  DATA      Full data message contents

              For the LOG command, only the first three letters are
              checked, so the following commands have the same effect:
              LOG30
              LOG 30
              LOGGING 30
              LOGGING LEVEL 30 PLEASE

            TOD +hhmm
            TOD -hhmm
               Set the amount of time to be added to the current
               Time Of Day (TOD) clock value to make it equal to
               UCT (GMT) time. This is to accommodate those sites
               that have their TOD clock set to local time rather
               than UCT (GMT) time.

               The hour (hh) must be between 00 and 23.
               The minute (mm) must be between 00 and 59.

               If not all digits are specified then the adjustment
               is treated as follows:

               +m          = +000m
               +mm         = +00mm
               +hmm        = +0hmm
               +hhmm       = +hhmm

            NOSWAP
               Attempts to set the address space to run non-
               swappable. The program needs to be APF-authorized if
               this to occur (i.e. linkedit with AC=1 and run from
               a load library in the APFLIST).

            STRATUM n
               Set the stratum level to n, where n is from 0 to 255
               as follows (from RFC 2030):

               Stratum  Meaning
               -------- -------------------------------------
               0        unspecified or unavailable
               1        primary reference (e.g., radio clock)
               2-15     secondary reference (via NTP or SNTP)
               16-255   reserved

               The default stratum is 2.

            SHOW
               Shows the current server settings.

AUTHOR   - Andrew Armstrong (a.armstrong@optusnet.com.au)
           Edigar Sobreira (edigar.sobreira@eds.com)


HISTORY  - Date     By       Reason (most recent at the top pls)
           -------- -------- ------------------------------------
           20031205 AJA      Added SHOW command.
           20031205 AJA      Added STRATUM command.
           20031107 Edigar   Changed the STRATUM value to 2.
           20031107 Edigar   Added F xxx,STOP possibility.
           20031107 Edigar   Added NOSWAP command.
           20031107 Edigar   Allowed multiples parm values.
           20031106 AJA      Added TOD command.
           20031025 AJA      Added OFFSET 0 to CBTTAPE.ORG.
           20030516 AJA      Submitted V1.0 to CBTTAPE.ORG.
           20011227 AJA      Added version to start up message.
           20011128 AJA      Allowed NTP V4 clients to connect.
           20011121 AJA      Added MODIFY command interface.
           20010822 AJA      Initial version.

----------------------------END OF $$$DOC-------------------------------
```

