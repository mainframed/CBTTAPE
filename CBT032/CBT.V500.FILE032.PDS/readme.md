
## $$$$$DOC.txt
```
                             DOCUMENTATION

       Included in this file are three programs I found in an old
library of utilities which came from MEMOREX and which was file 313 on
CBT tapes version 260 and previous.  This file was deleted from
version 261 of the CBT tape.  Version 249, obtainable from SHARE (see
file 1 for how) has this file as file 313.

        That file from MEMOREX is vast (over 100,000 lines) and old.
It is very much worth exploring.  Many of the programs have to be
informed that the more recent types of disk volumes, for example 3380,
and in some cases even 3350, exist.  After that, some of them can be
very useful.

        Programs included here are:

  JCLSCAN   -  A TSO command processor which calls the MVS JCL converter
                  to check a dataset of JCL for errors.  Since the
                  actual converter from IBM is used, you get the same
                  result as if you did TYPRUN=SCAN, but without running
                  a job.  It uses an SVC to do the calling of the
                  converter.  Output is displayed at the tube in a
                  very convenient format.

  COPYPACK  -  A batch utility which copies (and optionally recatalogs)
                  groups of datasets, by partial name, from one disk
                  pack to another.  It can handle DSORG=PO, PS, or DA.
                  All such datasets on the entire pack can be moved.
                  Allocation of the target datasets is done by the
                  program automatically.  Parm input provides much power
                  and flexibility.  This can save you a lot of work.

  DOWNDATE  -  A utility which creates an IEBUPDTE-format difference
                  deck between two versions of a source program.  This
                  not only flags differences, but allows you to convert
                  from one source deck to the other by means of the
                  difference deck.

                       Resubmitted to the CBT tape Oct. 1988 by
                          Sam Golob
          new address     P.O. Box 906
                          Tallman, NY 10982-0906
                                           email: sbgolob@attglobal.net
```

## $$DOCJCL.txt
```
              DOCUMENTATION FOR JCLSCAN TSO COMMAND PROCESSOR


      This highly convenient program calls MVS's JCL converter
 to report JCL errors in a jobstream on your TSO tube.  It is the
 same program which checks the errors when you run a real jobstream
 with TYPRUN=SCAN.  The output has been massaged to make it more
 convenient to display on the terminal.  All syntax errors are found,
 but "DATASET NOT FOUND"-type errors, which are produced by the
 JCL interpreter, are not shown by this processing, which is done
 by the JCL CONVERTER.

      The program consists of two parts:  the TSO command processor
called JCLSCAN, and a user SVC, which does all the dirty work of calling
the MVS JCL CONVERTER.  The SVC is type 4.

      To use the program, just execute the TSO command:

            JCLSCAN 'dataset-name'

      This program was found on a large file of utilities submitted to
the CBT tape from MEMOREX.  It may be found on versions 260 and older.
The file was file 313 on those versions of the CBT tape.  That file
contained over 100,000 lines of code, and contains many old but still
useful utilities.  You may have to tell some of them that 3380 or even
3350 disk drives exist, but once this is done, many of these programs
still work.  The file is much worth exploring.  It was deleted from
version 261 of the CBT tape.


      Version 249 of the CBT tape, which may be obtained from SHARE,
(see file 1 of the current CBT tape for instructions how to order it)
has this material on file 313.
```

## $$DOCOPY.txt
```
                  Documentation for COPYPACK Program


     This program has powerful capabilities to copy groups of datasets
from one disk pack to another.  Basically, PO and PS record-format
are supported.  Allocation of the new copy is done automatically,
and recataloging is optional.  This program can save a lot of work
for you in certain situations.  Documentation for its use is in the
code.  The program came from the MEMOREX file, file 313 of CBT tape
versions 260 and previous.

     Example of use:  copy all SYS1.**  datasets from MVSRES pack
to WORK01 pack for backup copy during a system change.

```

