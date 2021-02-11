
## $$$$READ.txt
```
            ASSEMBLING LOOK WHEN IBM MACROS CHANGE
             (It is very important to read this.)

If you have upgraded a few new operating system levels, then it is
advisable to reassemble LODK with CBMACS, because IBM may have added
more new fields to their old macros, and you might want to be able to
format the new fields in the control block which this macro describes.

LOOK has the very important capability of formatting control blocks
by reading the macros which describe their contents.  The format of
the field in the macro, "C" or "X" or "B" determines how LOOK, and
specifically its subprogram CBMACS, will format the control block.

Also, LOOK will not format a field in the form of 0CLx or 0XLx.
LOOK will only format fields of "real length", as shown in the macro.

Of course, when IBM developers code a macro, they do not have the
user-written program LOOK, and specifially CBMACS, in mind.  The IBM
developers have coded "C" where there should have been an "X", so
CBMACS, instead of formatting the field as a hex number, the way it
should, it formats the value as a "character", which is probably
unprintable, and the value shows up as a period, which doesn't help
us to see what the value really is (unless you say ONULL, to see the
raw data).

Sometimes, as in the case of IHACDE and IHALPDE, under z/OS 2.3 and
higher, IBM will cause one macro to generate two same-named DSECTs,
and that causes an assembly error in CBMACS.  So to solve these two
cases, there is an option in these macros, to create only one DSECT,
and CBMACS must assemble IHACDE with the proper option,:

Example:   IHACDE   EDCDSECT=YES ,
           IHALPDE  EDCDSECT=YES ,

Next fact:  I can't publish IBM macros on the CBT Tape, because they
are copyrighted by IBM and their use is restricted to licensees.  So
therefore, in order to assemble CBMACS so it will show all the fields
that WE WANT TO SHOW, we have to make copies of the IBM macros, and
use the copies, when we assemble CBMACS.

SEE THE MEMBERS $$NOTExx for hints about which IBM macros need to be
copied and altered.  You can do the same kind of thing with the
macros for control blocks that YOU ARE INTERESTED IN STUDYING.

```

## $$READ$$.txt
```
** -------------------------------------------------------------------
**   The new 64-bit version of LOOK is called LOOKN.
**   The revised 31-bit version of LOOK is called LOOKJ.
**   Both of these versions were developed by Joe Reichman.
** -------------------------------------------------------------------
**   The LOOK version called LOOKJ has been revised by Joe Reichman to
**   allow operation when VSM ALLOWUSERKEY(NO) is set, in the PARMLIB
**   member DIAGxx.  For cross-memory storage browsing, the SCHEDULE
**   macro has been replaced by IEAMSCHD, so this version of the
**   program may not work on old MVS systems (below OS/390 1.3).
**
**   THIS VERSION OF LOOK REQUIRES APF-AUTHORIZATON, ALWAYS.
** -------------------------------------------------------------------
**   LOOK requires assembly together with the CBMACS module, so that
**   it can format many system control blocks.  The LOOK module is the
**   "driving code", which can be assembled together with different
**   versions of CBMACS depending on any specialized needs that you
**   have, to format specific control blocks.  The CBMACS we have
**   packaged with CBT File 264, will already format many standard
**   z/OS (OS390, MVS) control blocks, but you may want to create
**   your own versions of CBMACS.
**
**   Please note:  CBMACS will only format "real data" in macros,
**   so when an IBM macro contains:   label   DS  0CLx   or similarly,
**   label  DS  0XLx  then CBMACS will not display that field.  You
**   may want to create your own altered versions of IBM macros, but
**   we can't publish them for licensing reasons.  Formatting in
**   CBMACS also depends on the data type (such as C, X, A, F, etc.)
**   You may want to alter an IBM macro from  DS CL5 to DS XL5, so
**   that the data will display in hex, instead of showing a dot,
**   when that data is not a displayable value.
**
**   Formatting is turned off, using the ONULL command in LOOK.
**   -----------------------------------------------------------------
```

