Welcome!!

This dataset contains all the files you need to get up and running
with the Hercules cckddump and cckdload utilities.  Installation
consists of 5 step, A, B, C, D and E, and you may start at any step
depending on your environment.  All files included here were created
on an os/390 2.9 system.

The following files make up this dataset:
--------    ---------------------------------------
$$README    This file

A$BZCOMP    Compile bz2
A$ZCOMP     Compile zlib

B$PRLK      Pre-link bz2 and zlib

C$ASM       Assemble CCKDDUMP and CCKDLOAD

D$LKED      Link-edit CCKDDUMP and CCKDLOAD

E$DUMP      Sample CCKDDUMP job stream
E$LOAD      Sample CCKDLOAD job stream

X$BZC       Xmitted bz2 c source
X$BZH       Xmitted bz2 h includes
X$BZO       Xmitted bz2 object files

X$CCKDA     Xmitted cckddump and cckdload assembler source
X$CCKDO     Xmitted object library for cckddump and cckdload and
            compression utilities (bz2 and zlib)
X$CCKDL     Xmitted load library containing cckddump and cckdload

X$ZC        Xmitted zlib c source
X$ZH        Xmitted zlib h includes
X$ZO        Xmitted zlib object files


Any of the xmitted (X$...) files may be received by issuing the
TSO command `receive inda(cckd.jcl(x$...))'.

The following graph indicates which files must be received for the
corresponding begining installation step:

member         A     B     C     D     E
-------- + --------------------------------
x$bzc          x
x$bzh          x
x$zc           x
x$zh           x
x$bzo          x     x
x$zo           x     x
x$cckda        x     x     x
x$cckdo        x     x     x     x
x$cckdl        x     x     x     x     x


If you are not licensed for the os/390 c/c++ compiler then you cannot
begin at step A.  If your release of os/390 is below 2.8, then you
should begin at step A or B or C.  If your release of os/390 is 2.8
or above, then you may proceed step E.  I recommend starting at the
earliest step possible.

Installations steps:

A   Submit job A$BZCOMP and A$ZCOMP to compile the bzip2 and zlib
    compression routines.

B   Submit job B$PRLK to pre-link the bzip2 and zlib compression
    routines

C   Submit job C$ASM to assemble the hi-level assembler programs
    cckddump and cckdload.  Program cckdload requires a HLASM release 3
    feature.  If your HLASM precedes this release level, then change
    the several lines that read
        USING (main+4095,mainend),ra
    to
        USING main+4095,ra
    This, in turn, will cause a return code 4 which can be ignored.
    The return code 4 for cckddump can likewise be ignored.

D   Submit job D$LKED to linkedit the cckddump and cckdload programs
    with the compression routines and c library.

E   Modify job E$DUMP to indicate the volume you wish to dump and
    the cckd file you want to create.
    Modify job E$LOAD to indicate the offline unit address you want
    to restore to and the cckd file you want to restore from.

Good Luck

Greg
gsmith@nc.rr.com

18 May 2001
