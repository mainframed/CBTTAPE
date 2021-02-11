
## $DOCNEWS.txt
```


 1.  Contact person for this command processor is:

                Chuck Hoffman
                Systems Programming
                GTE Laboratories - Computer Center
                40 Sylvan Road
                Waltham, Massachusetts  02254

                            Phone: (617)466-2131.

 2.  Source for command processor NEWSPACE is in member NEW.
     General documentation concerning NEWSPACE is in the help
     document in member HELP.

 3.  NEWSPACE should be assembled with the RENT option.

 4.  NEWSPACE should be link-edited with RENT, REUS, and ALIAS NEW.

 5.  The program uses GTE Laboratories macros for standard linkage
     conventions and register equates.  They are:

            LINKSAVE
            LINKBACK
            EQ$R

 6.  The program uses GTE Laboratories macros for dynamic
     allocation.  Documentation is in macro GTEDADOC.  All
     features used by NEWSPACE have been tested and found okay.
     However, GTE Laboratories has not completed testing other
     features which are not used by NEWSPACE. Not all features
     have been included yet, and not all of those which have been
     included have been tested.  If you use these macros for
     other applications, please let GTE Laboratories know of any
     bugs...  especially the ones you have corrected!
```

## $DOCSAL.txt
```

   The "SAL" program is a friendlier replacement for the TSO
   "LISTALC" command.  "SAL" stands for "Show ALlocations."

   SAL shows DDNAME, DATASET NAME, STATUS, NORMAL DISPOSITION and
   DATASET TYPE for each allocation.  It was designed to produce
   more readable output than "LISTALC."  It's primary use is in
   developing CLISTs and ISPF/PDF dialogs.

   SAL uses dynamic allocation information retrieval to get
   information about all current allocations.  See the MVS Job
   Management manual for more info on this use of dynamic
   allocation.

   SAL writes to file SYSPRINT, which would normally be allocated to
   the user's TSO terminal.  It works with Session Manager or
   without it, and is written to be reentrant.

   This package includes well-commented assembler code (member
   "SAL"), macros ("XSAVE1," "XRETURN," "REGISTER," "DYNABLD," and
   "DYNATXTU"), and a TSO HELP member ("SALHELP").


   Ric Ford
   GTE Laboratories, Incorporated
   40 Sylvan Road
   Waltham, Massachusetts 02254
   (617) 466-2133

```

