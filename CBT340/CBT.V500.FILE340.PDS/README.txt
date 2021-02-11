





                DCM - Dirt Cheap Monitor  V0.7


7980-3 and compatible controllers keep a great deal of statistics. Getting them
out is another story. If you have extra $$$, you can use AZTEC; if you are a
masochist, you use IDCAMS. In order to learn how the 7980-3 works, I wrote
DCM. Here is a sample screen:





                    Dirt Cheap Monitor V0.7                     May26  9:11:14
 Devices 0E00-0E3F   Ssid 0010          I/O rates measured from May26  9:10:59
  Volume SYSLBB   DevAddr 0E08          SSCH rate   30.5/s
   Paths 08 13 48 53                    Duplexed: Secondary dev E17
 Cache: Active           DFW: Active

    I/O time(ms)    4.6   Pend    0.5   Disc    1.2   Conn    2.9
      I/O   30.4/s     Reads   29.2/s    Writes    1.2/s   Short term I/O rate
   Normal   30.4/s     Reads   29.2/s    Writes    1.2/s    Long term hit%
     Seql    0.0/s     Reads    0.0/s    Writes    0.0/s         --Switches--
      CFW    0.0/s     Reads    0.0/s    Writes    0.0/s         SD0: AB
      DFW    1.2/s    Normal    1.2/s      Seql    0.0/s         SD1: AB
   Bypass    0.0/s   Inhibit    0.0/s                            SD2: AB
   Stages    2.1/s    Normal    2.1/s  Seql     0.0/s            SD3: AB
 DeStages    0.0/s  PreReads    0.0/s                      CU serial# 011717
Read Hit%   94.9     Normal%   92.6    Seql%   99.9   Cache installed   65536K
 CFW Hit%    0.0       Read%    0.0  Writes%    0.0   Cache available   65136K
 DFW Hit%   99.0     Normal%   99.0    Seql%   78.3     NVS installed    4096K
R/W ratio   33.5  Hits/Stage   14.2   Retry%    0.0       Pinned data       0K

 Enter: SR, LR, SH, LH, All, Onl, Auto, <dev-addr>, <volume> or End


This screen snapshot is from a running system. The statistics are for one
device although DCM can provide statistics for a string of devices or for all
devices attached to a controller.

There are two sources of statistics for DCM: the control unit and the channel
subsystem. The pending, disconnect and connect times are provided by the
channel subsystem and are the same as reported by RMF. These times are in
milliseconds. The other times are calculated using the counts maintained by
the 7980-3. The interval is between the two times in the upper right hand
corner. In general, the very first rate on each line is the sum of the remaining
rates on the line. The I/O rate is the sum of the normal rate, the sequential
rate, the bypass rate and the inhibit rate.

The hit% are calculated from the counters maintained in the 7980-3. The
percentages on the very left of each line are the weighted averages of the
remaining percentages on that line. It is possible to see the long term view of
the hits since the controller was IML'd or a short term view since the last time
that the ENTER key was pressed.

The Stages, Destages and Prereads fields are the number of these operations
per second. The only statistics not maintained in the 7980-3 are the R/W ratio
and the Hits/Stages. R/W is calculated in a straight forward fashion and the
Hits/Stages gives some measure of the caching efficiency.

Here is a list of DCM commands:

     AUTO      Repeat display 20 times with a 4 second interval
     ALL       Summarize all devices on the control unit
     <enter>   Refresh the screen with a new set of statistics
     ONL       Run through all online devices on this control unit
     Rnn       Repeat the display nn times with a 4 second interval
     Wnn       Set wait value to nn seconds
     n         Go to next device
     p         Go to previous device
     LR        Long term I/O rates
     SR        Short term I/O rates
     LH        Provide long term hit% (from the time that advanced
               functions were enabled)
     SH        Provide short term delta hit%
     NOUP      Do not re-write history file
     END       Ends DCM session. Q is an abbreviation.
     QN        End DCM without updating the history file.

A unit address or a volume name can be entered to provide statistics for that
device. A range of 16 devices can be summarized by providing a generic
address. In the sample screen, to get statistics for devices E10 to E1F, E1x
could be entered on the prompt.
Installing DCM is very easy. Two files are provided in IEBUPDTE input format.
Simply allocate a macro and a source PDS and run an IEBUPDTE job to build
the PDS's. If you have forgotten IEBUPDTE, here is a some JCL that can be
used:

     //UPDTE   EXEC PGM=IEBUPDTE,PARM='NEW'
     //SYSIN   DD DISP=SHR,DSN=<uploaded sequential file>
     //SYSUT2  DD DISP=SHR,DSN=<pds macros or source>
     //SYSPRINT DD SYSOUT=*

The members $ASM and $LINK in the source are used to build DCM. Note
that DCM is not authorized nor does it need to be.

In order to run DCM, create a 1 track dataset on any device attached to the
control unit that you want to monitor. This 1 track file is also used to preserv
e
some information after DCM ends. Simply allocate this dataset to the ddname
MONITOR and call DCM from TSO. If a file is allocated to the ddname
CAPTURE, screen images are saved to that file and can be subsequently
printed by REPLAYP.

DCM was developed on a MVS/ESA 3.1.3 system and has run on MVS/XA 2.2
and MVS/ESA 4.3 systems.

This is the first version of DCM and as time permits, I will add more features.
Your suggestions and comments are appreciated. Just call me at 403 424-
2006 or send a Spire message to Alfred Nykolyn. I hope that you find it useful.

Version 0.2 fixes an error in the way that UCBs are scanned and cleans up the
error handling. It provides support for statistics by volume name.

Version 0.3 includes the status display of the enable/disable switches and
provides the serial number of the control unit. If all switches are not displaye
d
on a 7980-3, you need to install ucode 21-A0 or 21-A8.

Version 0.4 adds support for 3990-3 non-synchronous controllers and
hopefully ESCON controllers.

Version 0.5 adds support for screen captures and different update intervals.
This is useful in benchmark situations.

Version 0.6 provides support for dynamic UCB's. It probably will not work with
MVS/XA. Bernd Bauer pointed out an error in DCMMAIN in which all counts
were zero.

Version 0.7 contains bug fixes for ESCON controller support which were
pointed out by Bernd Bauer.

Contact: Alfred Nykolyn
         apn@istar.ca
