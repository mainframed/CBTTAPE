SNTP for OS/390
2001-01-16

***********************************************************************
*                                                                     *
*             SNTP - Simple Network Time Protocol                     *
*                        Server                                       *
*                                                                     *
*   Copyright                                                         *
*   Kenneth W. Clapp                                                  *
*   7 October 1999                                                    *
*                                                                     *
*   Phoenix Home Life Mutual Insurance Company                        *
*   100 Bright Meadow Boulevard                                       *
*   Enfield, CT 06083                                                 *
*   USA                                                               *
*                                                                     *
*   Ken_Clapp@phl.com                                                 *
*                                                                     *
*   KenClapp@aol.com                                                  *
*                                                                     *
*   http://members.aol.com/kenclapp/sntp.htm                          *
*                                                                     *
***********************************************************************

This is the CBT version of the installation instructions


README     - basic instructions, you're looking at it.

SNTP       - THE SNTP SERVER SOURCE
IPCOPY     - COPYBOOK USED BY SERVER
X2CTBL     - COPYBOOK USED BY SERVER

$SNTP      - SAMPLE ASSEMBLY JCL
@SNTP      - PROC USED TO RUN SERVER (RENAME TO SNTP)

The above includes everything you need to build the SNTP server

-----------------------------------------------------------------------

Some Rexx utilities:

#NTP       - Convert NTP  timestamps to date/time
#STCK      - Convert STCK timestamps to date/time
#SNTP      - Exercise SNTP server

-----------------------------------------------------------------------

Some programs (fragments of the SNTP server) I used to test
performance and correctness of the timestamp generation.

SNTPRATE   - Generate 10,000,000 timestamp, check start/done times.
SNTPTEST   - Display STCK and SNTP timestamp for verification

$SNTPRAT   - ASSEMBLE SNTPRATE
$SNTPTST   - ASSEMBLE SNTPTEST

@SNTPRAT   - RUN JCL for SNTPRATE
@SNTPTST   - RUN JCL for SNTPTEST

-----------------------------------------------------------------------

There are some pieces that do not fit well within the CBT
distribution format:

- The complete RFC2030 (SNTP specifications) in Word format.

- The Powerpoint presentation I gave on this a Share in Boston
  in August 2000.

And last but certainly not least....

- An External Time Source emulator.  This can be used to synchronize
  the 9037 to some other NTP/SNTP server.


You can find these at my web site:


         http://members.aol.com/kenclapp/sntp.htm


**********************************************************************

Installation:

1) Copy @SNTP to a proclib, rename it to SNTP.

2) Update the $SNTP member to point to your source and load libraries

3) Submit the $SNTP job,
   - note it needs to assemble to an authorized library
     because it makes itself non-swappable

4) Verify your sysplex timer:
   - it must be set to UCT (GMT) time with your local offset
   - be sure it has the correct time and syncs to a "good"
     time source regularly. There's no point to having the
     wrong time.
   - warning! in case you don't know, NEVER "set" the 9037,
     always "adjust" it. Max adjustment is +/- 5.00 seconds per day.

5) Start the server (S SNTP)
   - be sure both TCPIP and SNTP have a high enough dispatching
     priority to provide a consistent response

***********************************************************************

  Operation:

    1) Start it up, watch it go. Well actually, it just sits there
       waiting for a client request.

    2) I'd suggest making it one of the TCPIP "autostart"ed tasks.

    3) It stops automatically when TCPIP is shutdown.

    4) Simply cancel it if you want to bring it down sooner.

***********************************************************************
*                                                                     *
*   This code has been running since October 1999:                    *
*   - Testing    OS/390 V2.10                                         *
*   - Currently  OS/390 V2.9                                          *
*   - Previously OS/390 V2.8                                          *
*   - Initially  OS/390 V2.5                                          *
*                                                                     *
*   It will not work on any OS/390 prior to the availability of       *
*   the TCP/IP assembler socket interface (OS/390 v2.5).              *
*                                                                     *
***********************************************************************

FAQ

--------------------------------------------------------------------------------

1) Why SNTP and not NTP?

SNTP is quite literally "Simple Network Time Protocol".  NTP servers are
expected to be able to be able to negotiate an average time between
themselves.  OS/390 cannot alter the sysplex timer, so this is not
really an option.

It is stated in the RFC2030 document, that

"to a NTP or SNTP client, NTP and SNTP servers are undistinguishable".

--------------------------------------------------------------------------------

2) How accurate is the server?

At its best, a 9037-1 drifts about .087 seconds per day.  With a daily
call to a time service you can bring that down to within .010 seconds of
the correct time.  Our sysplex timer calls out every 12 hours.
Typically we see it making adjustments of .005 to .007 seconds.

Clients should be able to maintain their clocks to
within .005-.010 seconds of the OS/390 server.

--------------------------------------------------------------------------------

3) What if I need to be more accurate?

With an external time source you can reach the following levels of accuracy:

9037-1 - .005
9037-2 - .001

--------------------------------------------------------------------------------

4) What if...
      we're too cheap to buy an external time source
   or we need to synchronize OS/390 to some other NTP/SNTP server ?

You should try ets1.exe, it requires a PC (166+) running win/nt and
a NTP/SNTP client. It will use the time on the PC and emulates your
choice of time source protocols. The PC this runs on must be
dedicated to this purpose though.

I personally favor the Netclock/2 protocol.

I hope I am NOT going to be sued by Austron, Netclock or Truetime.  My
emulator cannot come close to the accuracy their hardware clocks
provide, so it's no real threat.  My overall accuracy is around
.007 seconds which is quite reasonable for our purposes.

--------------------------------------------------------------------------------

5) My brand x client cannot synchronize to the OS/390 server!

Check the SNTP log on sysprint.  You should be able to find a line that
says "received nnn.nnn.nnn.nnn "followed by lots of hex stuff.
The nnn.nnn.nnn.nnn is the IP address of the client.  If you can't find
yours, the client isn't configured properly.

If it is there, but still does sync, send my a copy of the log (just the couple
of lines in question) showing the received and sendto packets for the client.

--------------------------------------------------------------------------------

6) So what's the rest of the stuff in the directories?

\sntp

ets1.exe - used to emulate an external time source. Facilitates synchronizing
           a sysplex timer to a NTP/SNTP server.  Requires a dedicated PC
           running win/nt on a pentium 166 or better with a NT NTP/SNTP time cli
           Note that the SNTP server could be on some other OS/390 system.
           This would allow for sychronizing multible sysplexes to a common cloc

\sntp\rexx

SNTP.rex - uses the tcp/ip rexx socket interface and can be used to
           test the OS/390 SNTP server

usage: sntp server.wherever.com

check the log produced by SNTP you should see some activity.  I put this in
a batch tso job and run it occasionally.


NTP.rex - if you actually want to know what time an NTP time
          stamp really is, use this.

syntax:

NTP bd7468b2 6b7e90fc

results:

TIME=11:00:02.419900 DATE=2000.265
DATE=2000/09/21


STCK.rex - use to convert IBM timestamps to standard date time

syntax:

stck b36d3370 7be8cf00

results:

TIME=15:05:33.070988 DATE=2000.010
DATE=2000/01/10


\sntp\test

SNTPRATE.bal - used to determine how fast timestamps can be created
$SNTPRAT.jcl - assembly jcl
SNTPRATE.jcl - execution jcl

SNTPTEST.bal - used to compare STCK and SNTP timestamps
$SNTPTST.jcl - assembly jcl
SNTPTEST.jcl - execution jcl

--------------------------------------------------------------------------------

7) Wouldn't it be better if... Why didn't you... How about...
    - you had an operator interface
    - you used CVD instead of those "large" tables
    - used instruction xxx instead of yyy


My design criteria were:
- keep it simple
- keep it fast
- get it running while OS/390 was still a candidate for corporate time server

I think I successfully met all those goals.

I couldn't think of anything an operator would need to do.

The tables allow me to do very quick indexed lookups.

The server is single threaded so it was important to handle each request
as quickly as possible so its ready to receive the next one.  I spent
a lot of time testing with SNTPRATE and am able to built timestamps at a rate
of about 2,000,000 per second on a 9672/R35.  Given that it takes two stamps
per request and there is other overhead, we're probably able to service
thousands, if not hundred of thousands of client request per second.  I
keep meaning to write something to test actual throughput.

If you've got a better idea send me a copy and I'll see how it works.

Note:

I am working on version 2. It will have an operator interface, be
multithreaded and may even have some NTP features.

I am also looking into supporting leap seconds.

--------------------------------------------------------------------------------

8) We like the OS/390 SNTP server so much, we are going to make OS/390 time
   available to everyone over the internet!

Uh... please don't do that.

The OS/390 SNTP server does not provide time accurate enough to be considered
a "real" timer server.  This is because of the following two limitations:

 - the accuracy of the sysplex timer itself.  Its pretty good, but it just
   doesn't compare to an atomic clock.

 - OS/390 has more to do then just provide the time. Consequently
   there is some variability to its response. (Better SNTP clients
   can actually smooth this out though.)

While this is bad if you are trying to navigate the ocean or study astronomy,
its insignificant from a corporate perspective.

You should easily be able to maintain all of your clients to within .008 seconds
of OS/390 time. The clocks on PCs can't be kept much closer.


********************************************************************************

