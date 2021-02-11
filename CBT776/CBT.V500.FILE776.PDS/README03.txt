OVERVIEW
========

This is an updated version of my package, dealing with XMIT-Files on
different platforms.

With XMCLIST and XMCUTIL, all RECV390 functions can be replaced.

- XMCLIST and XMCUTIL work as a TSO Command Processsor or as a x86 cmdline
          Program.  Ports working:  - MVS38, OS390, z/OS
                                    - Linux (x86,...)
                                    - WIN32/64 with MINGW

- XMCLIST handles PO and POE unloaded datasets
- XMCLIST handles all source devicetypes 3390, 3380, ...
- XMCLIST avoids Errors of RECV390, XMITMANAGER and others, dealing with short
          blocks: IEBCOPY UNLOAD of variable blocked shorter than Netdata
                  Block Length.

- XMCUTIL decodes Fixed and Variable Formats.


CONTENTS
========

    @DCUSER      common header
    EPUTL        c wrapper EPUTL (object code)
    JCC037       compile jclproc
    README03     this one
    SAMPINFO     Sample Output for XMCLIST of a XMIT-File
    X86ZIP       binaries WIN32 for XMCLIST and XMCUTIL
    XMCLIST      source
    XMCLIST$     compile jcl
    XMCLOAD      load modules XMCLIST XMCUTIL (xmitted)
    XMCUTIL      source
    XMCUTIL$     compile jcl

    RECV390      old code, but still works. with some errors in RECFM=V or U

MORE DETAILS
============

XMCLIST
-------

XMCLIST provides infos from a XMIT-Datasets. No need to use TSO TRANSMIT
        Command to extract the whole XMIT-Dataset. Infos like Creation Date etc.
        of the XMIT-Dataset, DCB-Infos of the covered IEBCOPY UNLOADed Dataset,
        Directory ...

          - Lists contents about INMR* Records
          - Lists contents of the IEBCOPY UNLOAD
            -- COPYR1 Info. DCB
            -- COPYR2 Info. Extents
            -- Directory Contents
            -- Base Member Alias Resolution

XMCLIST optional extracts a single member of the XMIT-contents. The format is
        raw. No conversion is done. For RECFM=V contents Block-Descriptors and
        Reord-Descriptors are kept. Optional the IEBCOPY Unload infos
        (Parameter CCHHR) are preserved too. This maybe helpful to reconstruct
        Load-Module contents.

Example Invocation:

 TSO:
         XMCLIST MY.RECV390.XMI NODIR MEM(MYMEM) ODS(MY.MYMEM.BIN)

        shows no directory list, and extracts MYMEM
                to a sequential file MY.MYMEM.BIN

        - DDNAMES are allowed and prefixed with DD: . E.g. DD:MYDD
        - Quotes are tolerated, but not honored. So a dsn needs to be
          fully qualified in all cases.

        - ODS(MY.*.BIN)
          would substitute / expand to ODS(MY.MYMEM.BIN)

 X86:
         $ xmclist my.recv390.bin --nodir --mem(mymem) --ods(my.mymem.bin)

        - omitting --ods would write to stdout

XMCUTIL
-------

XMCUTIL is a simple c module to convert raw input from XMCLIST to some desired,
        readable outputs.

 TSO:
         XMCUTIL MY.MYMEM.BIN RECFM=F LRECL=80 ASCII UNBLOCK +
                          ODS(MY.RECV390.SOURCE(MYMEM))

 X86:
         $ xmcutil my.meymem.bin --recfm=F --lrecl=80 \
                                      --ascii --unblock --ods=mymem.txt


FAQs
====

1. Show Info from a XMIT-Dataset
--------------------------------

         $ xmclist my.recv390.bin

         for Output see SAMPINFO

2a. How to extract a complete XMIT-Dataset (X86) ?
--------------------------------------------------

         This is a Linux shell-script for extracting all members of a unloaded
         PO-Dataset and to convert it to ASCII and LF (trailing spaces per line
         truncated).

<code>
  #!/bin/sh
  xmclist $1 2>&1 | grep '^ ' |
    awk '{print "xmclist '$1' --noinfo --nomsg --mem=\x27"$1"\x27 | \
    xmcutil - recfm=F --lrecl=80 --ascii --unblock --replace --ods="$1".asc"}' |
  sh
</code>

  - be aware, the first $1 is the first pos parm for the shell script the name
    of the XMIT-Dataset. The second (and third) $1 is the first field
    for awk print, this is a MEMBERNAME

  - grep gets all lines of output (stderr and stdout) with ONE LEADING SPACE.
    This is the Membername


  - the sample is also provided in X86ZIP

2b. How to extract a complete XMIT-Dataset (MVS) ?
--------------------------------------------------

         just use TSO RECEIVE ...

3a.  How to extract a single member from a XMIT-Dataset (MVS)
-------------------------------------------------------------

<jcl>
  //S1      EXEC PGM=IKJEFT01
  //STEPLIB   DD DISP=SHR,DSN=SDBDC.MVS38J.LOAD
  //SYSPRINT DD SYSOUT=*
  //SYSTSPRT DD SYSOUT=*
  //DD1      DD SYSOUT=*,DCB=(LRECL=80,RECFM=FB,BLKSIZE=3200)
  //SYSTSIN  DD *
    XMCLIST SDBDC.GCC32380.XMI mem(GCCJCL) ODS(DD:DD1) replace
</jcl>

   - if no ODS() is specified, the output is routed to STDOUT DD
   - specifiy prefix dd: if you route to a Statement.
     For DD:  a REPLACE option is mandatory !!
   - you need to specify a complete DCB for the Output to achieve
     expected results.

   Remark: No Error is reported, if the DD not exist. Coding
           a DSN will report open errors.

3b.  How to extract a single mem from a XMIT-Dataset (MVS) with orig RECFM(VB)
------------------------------------------------------------------------------

    This needs a little bit more effort, because we need to interpret
    BDWs and RDWs.

<jcl>
  //S1      EXEC PGM=IKJEFT01
  //STEPLIB   DD DISP=SHR,DSN=SDBDC.MVS38J.LOAD
  //SYSPRINT DD SYSOUT=*
  //DD1      DD  DISP=(,PASS),DSN=&TEMP,
  //         UNIT=VIO,
  //         DCB=(LRECL=80,RECFM=FB,BLKSIZE=6400)
  //DD2      DD SYSOUT=*,
  //         DCB=(LRECL=80,RECFM=FB,BLKSIZE=6400)
  //STDOUT   DD SYSOUT=*
  //SYSTSPRT DD SYSOUT=*
  //SYSTSIN  DD *
    XMCLIST SDBDC.JCC.INCLUDE.XMI MEM($$$DOC) ODS(DD:DD1) REPLACE
    XMCUTIL DD:DD1 RECFM(V) LRECL(80) PAD ODS(DD:DD2) REPLACE
</jcl>

   - extract member raw to a &TEMP dataset. The DCB-Attributes DD1 do not
     matter, because we read binary.
   - use XMCUTIL to read RECFM(V) and resolve the BDSs and RDWs. Use PAD to
     write the desired fixed length Record.  Add a complete DCB for the Output
     to achieve expected results.
   - DD2 may be the final permanent Dataset.

   Remark: This is the only usecase, where XMCUTIL makes sense in MVS. All
           other conversions can be done with wellknown DCB-keywords in MVS.

4, The stuff with pipes and standard streams
---------------------------------------------

    in MVS TSO pipes are not implemented in the way we know from X86. So the
    stdout, stderr have limited use. Following Rules apply for MVS:

    - standard streams are in MVS-source not completely disabled,
      but I didn't a comprehensive testing with this streams.

      If you need them in a special use case, alloc them:

      -- alloc STDIN  DD
      -- alloc STDOUT DD
      -- alloc STDERR DD

     Messages for XMCUTIL & XMCLIST always go to SYSTSPRT
     (purpose of EPUTL, PUTLINE see CBT-Tape).

    - X86 allows for both XMCLIST & XMCUTIL stdout (--ods parm omitted).
    - X86 uses stderr for Messages and Infos
    - X86 allows stdin for XMCUTIL (hyphen - as first (positional) parm).
     This allows concatentions of XMCLIST and XMCUTIL
     (see sample shell script above).

1. Where to find parameter descriptions for XMCLIST and XMCUTIL
---------------------------------------------------------------

TSO:
    XMCLIST HELP
    ...
    XMCUTIL HELP

X85:
    $ xmclist --help
    ...
    $ xmcutil --help

RECOMPILE NOTES
===============

As mentioned before, the source of the programs is highly portable between
the different platforms.

MVS
---

#define MVS
#define MVS43

The provided load modules are compiled with Jason Winters C Compiler
under MVS 3.8. This means AMODE 24, RMODE 24. Compiling on newer MVS, OS390
or z/OS enables other AMODE and RMODEs.

Compiling with other compilers like GCCMVS or vendor compilers should not be
an effort, as the programs don't deal with system specifics.

Linux
-----

#define LINUX
#define X86

No binaries provided. As I assume, that on Linux platforms in most cases
GCC is installed and working. Compile yourself.

No MAKEFILEs necessary (@dcuser.h needs to be in the current directory):

$ gcc xmclist.c -o xmclist
$ gcc xmcutil.c -o xmcutil

Windows
-------

#define LINUX
#define X86

I've provided compiled binaries with MINGW under WIN32. Although not
comprehensive tested, they seem to work. This is my only support for
Windows, because I have no access to other Win C Compilers and WIN OS.

CREDITS & HISTORY
=================

Most used for dealing with XMIT-Datasets is XMITMANAGER. It is a WIN32 Binary
(I've found no source) and very reliable for RECFM=F. But it is interactive,
no cmdline is possible. Other RECFM are dumped only raw and possible incomplete
(See discussion RECV390 and above). No native port for LINUX and MVS exist.

Years ago I've started to use Jim Morrisons X86 port. I published a modified
version of RECV390 in 2007, corrected some logic errors. But I stopped
maintaining this code and started with a new code base, when I identified
new requirements, like having a MVS port, which would be hard to implement
in the existing code.

Special thanks to the guys and their findings, which helped me to understand
the logics and caveats around the IEBCOPY UNLOAD and NETDATA (XMIT) format.
To mention here among others, David Alcocks "UnXMIT information exchange",
Ken Tomiaks works, Greg Price REVIEW package, which gives a lot of deep
knowledge dealing with PDS.

COPYRIGHT
=========

The current GNU Public Licence applies to this work. If there any license
questions about this work, please contact the author.
                 -- ** --
