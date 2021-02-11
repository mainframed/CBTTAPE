            INTRODUCTION TO THE AUDITMVS STARTER KIT
            ----------------------------------------


This file contains the AUDITMVS starter kit software.  The kit
consists of utility software to collect and analyze data from an
operational MVS system.  It will greatly assist in documenting the
Authorized Program Facility (APF) environment, including all APF
libraries, Supervisor Call (SVC) routines, Extended SVC Router (ESR)
routines, Program Call (PC) routines, and Link Pack Area (LPA)
programs (i.e., Pageable, Modified, Fixed LPA; and other items along
the LPA Queue).

The software consists mostly of REXX and SAS programs.  In addition,
there are several assembly language programs to disassemble MVS
software from object code back to assembly language.  There is also
an assembly language program that uses the SNAP macro to retrieve the
Program Call table from the PCAUTH address space.

The contents of this diskette should be uploaded to the MVS system
that is to be audited.  All of the files, except the REXX programs,
may be placed into individual members of a standard FB 80 partitioned
data set (PDS).  The REXX programs sometimes exceed line lengths
beyond 72 characters--therefore, a VB 255 PDS is recommended.  Both
FB 80 and VB 255 formats are supported by the ISPF/PDF editor.  To
summarize, the following diskette-directory-to-MVS-PDS upload
structure is suggested:

     File Member                      MVS PDS and DCB Info
     ------------------        ----------------------------------

     ADVCAATS                  userid.DISASM.CNTL         FB   80
     MISC                      userid.CNTL                FB   80
     REXX                      userid.EXEC                VB  255
     SAS                       userid.SAS.CNTL            FB   80

Some of the starter kit programs also require a number of MVS support
files.  For example, the IO* REXX programs are data collectors which
write to various VB 255 physical sequential data sets.  These data
sets are then read by the SAS programs for analysis and reporting.
You will have to allocate and name these to your own preference, and
edit the REXX and SAS programs accordingly.  There is one support
data set that must be formatted specifically to support the output of
the SNAP macro.  See the assembly language program (SNAPPC.ASM in the
MISC directory) for these specific DCB parameters.


ADVCAATS
--------

This library contains source code for a old, old (but very useful)
public domain disassembler.  The disassembler has been extended to
perform in-storage disassembly if the code resides below the 16 MB
line.  See the file $$README for more information.


MISC
----

This library contains several *.JCL files.  ALLOCGDG.JCL shows how
to define a generation data group (GDG) should you want to build a
system of audit jobs that maintain snapshot cycles of data sets for
your MVS system.  IKJEFT01.JCL shows how to run your REXX programs in
"batch mode" TSO.  Other JCL files provide examples of lengthy job
streams for multiple audit steps.  This library also contains the
SNAPPC.ASM file for obtaining your MVS systems PC table.


REXX
----

This library contains a wide variety of REXX programs that collect
data from an operational MVS system.  All are stand alone programs
except for #NUCLKUP, which is an external REXX CALLable procedure
that seaches the nucleus map for an entry name and returns its entry
point address.  #NUCLKUP is currently CALLed by IOSVCT, IOESRT,
LISTSVCT, and LISTESRT.  SDUMP is a general purpose formatted display
storage dump program.  The VSDATA1 program is a modified version of
SDUMP which displays several in-storage control blocks.

The IO* series of programs collect data and write to "WORK.DATA" data
sets.  The LIST* series of programs can all be executed interactively
to display MVS internals data to your terminal screen.  Acronyms used
within the naming scheme for these programs are:

   ADSP     ADdress SPace
   APFP     APF libraries Programs
   APFT     APF Table
   CATS     CATalogS
   CONS     CONsoleS
   DASD     Direct Access Storage Devices list
   DCQ      Device Class Queue
   ENV      ENVironmental information
   ESRT     ESR Table
   LLT      Linklist Libraries Table
   LLTP     LLT libraries Programs
   LPAQ     LPA Queue
   LPAT     LPA libraries Table
   NUCM     NUCleus Map
   PART     Paging Activity Reference Table
   PDSD     PDS Directory
   PDSM     PDS Members
   PCAUTH   Program Call AUTHorization table
   PLPA     Pageable LPA programs
   SART     Swapping Activity Reference Table
   SFT      System Function Table
   SMAP     Storage MAP information
   SMF      System Management Facility information
   SSN      SubSystem Name table
   SVCJ     SVC Journal table
   SVCT     SVC Table
   TAPE     TAPE devices list
   VMAP     Virtual storage MAP

The NOT@OR file is a ready reference of the EBCDIC hex codes for the
"and" and "or" characters.  These two characters are hard to remember
when one uses several different microcomputer keyboard maps
associated with various 3270 emulation software packages.


SAS
---

This library contains SAS programs which report from the various
files created by the IO* series of REXX programs.  The APFPDUP,
LLTPDUP, LPAPDUP, ESRMATCH, PCMATCH, and SVCMATCH programs
demonstrate the power of the SAS MERGE function.


      Lee Conyers
      U.S. Department of Transportation
      700 4th Street SW
      Room 7404, M-35
      Washington, DC  20590
      (202) 366-1126

                                          -- vlc (3/27/94)
