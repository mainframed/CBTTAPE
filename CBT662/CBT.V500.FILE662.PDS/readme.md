
## $DOC.txt
```
This file contains code used to provide an automated bridge between the
CA-1 tape management system and the FakeTape(tm) facility of FLEX-ES.
This contribution will require a lot of tailoring to your environment.

It is based upon the TSSO Automated Operator Facility (AOF), for which
see File 404 of the CBT tape. It uses a network connection between the
MVS system and Unixware (or Linux) to issue remote commands which create
the FakeTape(tm) file and MOUNT it on the desired unit address. This may
require a network bridge to route traffic between the networks and may
need TCP/IP routing changes in MVS and in Unixware (or Linux).
The members are;

$DOC     -  You are reading it.
FAKEAOF  -  TSSO AOF TABENTRY statements for CA-1 messages.
            Include these with a COPY FAKEAOF statement in AOF source.
FSF      -  Assembler source for a program which reads the CA-1 TMC to
            find the first available SCRATCH tape. The characteristics
            of the TMC have to be specified as Assembler variables at
            the start of the program. You will need macros from File 172
            of the CBT tape and from CA-1 to be able to assemble this
            program. This program invokes the program "SETVAR" from
            File 270 of the CBT tape to return the volume serial in the
            TSO variable "FAKETAPE".
FTAPE     - A clist which is invoked under TSSO to process requests for
            SCRATCH tapes. It tests whether the tape unit is on a string
            of tapes defined for FakeTape(tm) use and if so it invokes
            FSF to find a SCRATCH tape. Then it issues a REXEC to
            the Unixware (or Linux) Userid "flexes" with the appropriate
            password to create a file with a VOL1 label for that tape.
            That VOL1 is then converted into a FakeTape(tm) file in the
            appropriate directory, which is then MOUNTed by FLEX-ES on
            the right unit address. Note that this file may already
            exist, it overwrites it anyway. Thus you do not have to
            manage expired fake tapes. MVS opens the file, checks the
            volume serial in the label VOL1, CA-1 checks that it is a
            SCRATCH tape, updates the TMC and the tape file is then
            written. Code is included to cater for multiple simultaneous
            SCRATCH mounts with some crude placemat allocation. These
            files should be regularly monitored lest they proliferate.
            Note that Unixware (and Linux) commands are case sensitive.
STAPE     - A clist which is invoked under TSSO to process requests for
            specific tapes. It tests whether the tape unit is one
            defined for FakeTape(tm) use and if so issues a REXEC to
            the Unixware (or Linux) Userid "flexes" with the appropriate
            password to MOUNT the appropriate file by FLEX-ES on the
            right unit address. MVS opens the file, checks the
            volume serial in the label and processes the "tape".
            Note that Unixware (and Linux) commands are case sensitive.
KTAPE     - A clist which is invoked under TSSO to process requests to
            demount tapes. This replaces the FDONE clist in the previous
            release of this code. Now it also ensures that Flex-ES
            unmounts the FakeTape file. It still attempts to delete the
            placemat file for that volume. It does not care whether the
            placemat exists or not - it will cease to do so anyway.

AGCO UK Ltd. replaced an IBM Multiprise 2003 mainframe running OS390
R2.10 in February 2004 with an IBM X-series server running FLEX-ES under
SCO Unixware. The same OS390 R2.10 system was copied across. We run a
mixed workload with a few TSO Users, about 60 IMS Users and overnight
batch. We have a worldwide network which was SNA but is now mostly IP.
We have successfully tested Enterprise Extender over the FLEX-ES
emulated OSA card.  We ordered a three channel adaptor card supplied by
Fundamental Software Inc., the vendors of FLEX-ES to drive a 3745, local
printers and tapes.
We installed four daisy chained SCSI tape decks as well as having eight
IBM 3490-E drives connected via one channel of the PCA.  As may be
expected tape performance is poor, but it has always been our intention
to replace tapes with FakeTape(tm) anyway. To that end we defined in the
IODF a string of 3480 tape drives for use with this facility.  We also
defined an additional EDT with the MIS standard name CART pointing to
these drives. Thus we can switch FakeTape(tm) on and off by activating
the appropriate EDT, either at IPL or by a dynamic software-only change
using HCD. Because they have different device types in their catalog
entries there is no confusion of fake or real tapes. To be sure we use a
separate range of tape numbers in the TMC for FakeTape(tm).

UPDATE July 2004
================
That's what we thought. Turns out MVS is smart enough to know it can
read a 3480 on a 3490 drive. Too smart for its own good - we kept
getting requests for FakeTapes on real drives. The good members of
IBM-MAIN provided the answer; you have to define a Manual Tape Library
and put FakeTapes under SMS. That's what we did and it worked a treat.
We were confused by the CA documentation of their support for Tape
Libraries in CA-1, we thought they only supported real physical robots.
In fact the support is the same and the CA-1 Usermod CL05228 was applied
and works very well. We did have one unscheduled IPL when I tried to use
a command issuing program to add 500 tapes to the SMS tape catalog.
The flood of LIBRARY ADD commands overwhelmed MCS and we lost all
command processing. We now only add ten tapes at a time.
Another problem arose when a tape volume was used on a drive one day and
the drive was not used again until several days later when by chance
the same volume was requested on the same drive. Unfortunately the tape
had been used, so whichever bit of software remembered that tape was
there got it wrong, leading to an S813 abend. We have now modified
dismount processing to break the Flex-ES connection between the tape
drive and the FakeTape file. We hope this will fix that problem, but as
it is such a rare occurrence we can't for the moment guarantee it.
Due to file size limits in UnixWare or Flex-ES we have had to split the
disk space we use for FakeTape files. Odd numbered tapes are stored in
the /scratch5 directory, all others in /scratch6. These are mount points
for partitions on our IBM X300 disk expansion unit.

UPDATE November 2004
====================
This was working so well we decided to do our offsite backups to
FakeTape and then copy the dumps to real 3490's. This scheme did indeed
reduce the backup window considerably, although the elapsed time of the
whole operation was about the same. However, it did throw up one problem
which I have solved with this update.
Previously FTAPE would allocate a PLACEMAT file to ensure that only one
mount request would use any particular scratch tape. If the placemat
file existed then the tape was in the process of being used although the
TMC had not yet been updated, so FTAPE would try for another scratch
volume.  This works fine, but if you are dumping all your disks there is
a good chance that there will be an enqueue on the VTOC of the disk
where you want to allocate the placemat. The whole process will then
hang until the dump ends, which is not good for throughput.  I have
therefore changed FTAPE to use the Catalog as a placeholder, merely
creating a catalog entry for a placemat file, not the actual file
itself.  This entry is deleted by KTAPE.  It happens that I use the
DAYOWEEK program from CBT file 172 in the construction of the volume
serial for the catalog entry, but this is not mandatory. Any system
variable or constant could be used, I just wanted as much granularity
as I could get in six characters.

Comments and ideas for improvement are welcomed, email to;

davecartwright@uk.agcocorp.com

The Corporate information;
AGCO Corporation, headquartered in Duluth, Georgia, is a global designer,
manufacturer and distributor of agricultural equipment and related
replacement parts.  AGCO products are distributed in over 140 countries.
AGCO offers a full product line including tractors, combines, hay tools,
sprayers, forage, tillage equipment and implements through more than 8,600
independent dealers and distributors around the world.
AGCO products are distributed under the brand names;
AGCO, Agco Allis, AgcoStar, Ag-Chem, Challenger, Farmhand, Fendt,
Fieldstar, Gleaner, Glencoe, Hesston, LOR*AL, Massey-Ferguson,
New Idea, Rogator, SISU Diesel Engines, Soilteq, Spra-Coupe,
Sunflower, Terra-Gator, Tye, Valtra, White, and Willmar.
AGCO provides retail financing through AGCO Finance in North America
and through Agricredit in the United Kingdom, France, Germany, Ireland,
Spain and Brazil.
In 2002, AGCO had net sales of USD 2.9 billion.
```

## $ZDOC.txt
```
#
#        PDSDOC *Documentation on archive experiments.................*
#
When AGCO bought the TServer they specified an additional IBM EXP300
disk array. This provided an extra 640GB of space in a SCSI RAID
configuration specifically to accommodate FakeTape(tm) files.

I soon found that SCO Unixware 7 does not support disk partitions over
512GB in size, leaving me with one large and one small partition.  In
order to make the most use possible of this disk space I decided to
write the FakeTape file to the small partition (/scratch6) and then use
the GZIP program provided with UnixWare to archive the 'tape' to the
larger disk partition (/scratch5) which would become our back-end tape
vault. In order to be able to dump a 3390-3 to one tape I specified a
Flex-ES paramameter "maxwritesize=2500" on the MOUNT command sent to
flexes in the FTAPE clist.  I found that although SCO UnixWare itself
supported files larger than 2 Gb, not all the supplied utilities did.
GZIP level 1.2.4 supplied with SCO Unixware 7 was one program that did
not, so I had to install the Beta GZIP release 1.3.3 which included
large file support. This installed easily after I downloaded it from
                http://www.gzip.org/
I wrote a Unix shell script to perform the archiving and invoked that as
a background task at the end of the FDONE clist called at dismount time.
Another shell script invoked GZIP to decompress the zipped FakeTape file
back to /scratch6 when a particular volume serial was mounted using the
STAPE clist.  Obviously this had to run in real time before the MOUNT
for the 'tape'could be issued.

From a tape management viewpoint this scheme worked very well. It
provided an order of magnitude increase in the size of the tape library
and separated active tapes from archived ones. Unfortunately the CPU
cost of running GZIP was quite large, and MVS would more or less stop
whilst GZIP was running. To reduce the impact I used minimal levels of
compression and reduced the file size to 1Gb, giving me many more
multi-volume files. I attempted to lower the priority of the archiving
script which was running asynchronously anyway by calling GZIP with
"nice -19" and similarly invoked the shell script with "nice -19", but
to no avail. Even though Unix showed GZIP running with priority zero the
Users on IMS terminals experienced response times of several minutes
rather than sub-second.  This scheme had to be abandoned until the march
of Moore's Law provides me with enough horsepower to do it.

In order to maximise the space available for FakeTape files I re-sliced
the EXP300 into two equal partitions each of 320GB.  The TSSO clists
have been updated to put odd numbered tapes on /scratch5, everything
else on /scratch6.  That includes not only even numbered tapes, but also
tapes  with alphabetic serials or serials less than six characters long.
I have reverted to a tape size of 2GB which gives adequate capacity with
hopefully few problems. The members used in these experiments are;

VTAPE1  - Unix shell script to compress a FakeTape file.
VTAPE2  - Unix shell script to uncompress a FakeTape file.
ZTAPE   - A version of FTAPE
ZDONE   - A version of FDONE
ZSTAPE  - A version of STAPE

Note that the commands in the Unix shell scripts have been folded to fit
within this card-image PDS. In practice the commands must all be in one
(long) line. This is noted within the member.  The REXEC calls to invoke
these scripts have been left in the TSSO clists, but have been commented
out and the partiton balancing code added.
I welcome comments and suggestions.
```

