
## $DOC.txt
```
PARMLIB Check

This application consists of a REXX Exec and an ISPF Panel.  To use this
you need to copy the exec into a library in your SYSPROC or SYSEXEC
concatenation.  You then need to copy the panel into a library in your
ISPPLIB concatenation.

Usage is to Edit the desired member of SYS1.PARMLIB and enter the
command PRMCK.

Syntax: PRMCK cat sysres -debug -notran

valid options are:
      ?   - will prompt for catalog and sysres
      cat - is a name that will be used in the master
            catalog lookup (find *custom* below) and
            if not found will be used as the master
            catalog name (enter without quotes).
      sysres is the volser of the system ipl volume
            to be checked when a volser of ****** is
            coded.
      -debug - will turn on tracing
      -nowarn  - will ignore all warnings
      -noerror - will ignore all errors
      -report  - will create a report and put you into browse
                 ** this data set will *not* be deleted when done

Support for PROGxx member statements
   - LNKLST
   - APF
   - LPA
   - SYSLIB
Support for LNKLSTxx and LPALSTxx members

Verification is not 100% the same as the system will perform when
used but it does a fair amount of verification.  Errors and Warnings
are inserted into the Edit display as non-saveable messages.

NOTE: This package will check for the existence of a RACF Profile for
      every data set.  If you don't have RACF I'm not sure what result
      you will get.
```

