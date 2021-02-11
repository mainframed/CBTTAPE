```
//***FILE 555 is from Solomon Santos and contains a very            *   FILE 555
//*           interesting set of his utilities and subroutines.     *   FILE 555
//*                                                                 *   FILE 555
//*           email:  "Mon R. Santos" <bugsie@tig.com.au>           *   FILE 555
//*                   bugsie88@yahoo.com                            *   FILE 555
//*                                                                 *   FILE 555
//*      - - - - - - - - - - - - - - - - - - - - - - - - - - -      *   FILE 555
//*                                                                 *   FILE 555
//*      A new utility, an ISPF-ized front end to the TSO XMIT      *   FILE 555
//*      commmand, is called ISPFXMI, and it consists of one        *   FILE 555
//*      REXX exec and two panels.  It's an easy way to prepare     *   FILE 555
//*      XMIT-format datasets, to send anywhere.  Try it!           *   FILE 555
//*                                                                 *   FILE 555
//*      - - - - - - - - - - - - - - - - - - - - - - - - - - -      *   FILE 555
//*                                                                 *   FILE 555
//*      The rest of the members of this dataset are all written    *   FILE 555
//*      in BAL.  Originally, they were intended for use as         *   FILE 555
//*      utilities for COBOL programs.  They all use the attached   *   FILE 555
//*      MACLIB, here included as member MACLIB.  Since most of     *   FILE 555
//*      the programs here are subroutines, they are used by main   *   FILE 555
//*      programs such as "LIST".                                   *   FILE 555
//*                                                                 *   FILE 555
//*      Almost all of the programs here have some documentation    *   FILE 555
//*      before the start of the code that describes the            *   FILE 555
//*      parameter list, but all of them are described by the       *   FILE 555
//*      'EPA' (entry point address) macro.                         *   FILE 555
//*                                                                 *   FILE 555
//*      For the routines (like SCAN (in GUS015) and PARSE (in      *   FILE 555
//*      GUS014)) that don't have a documentation header, you       *   FILE 555
//*      could easily figure out how to use it because the          *   FILE 555
//*      linkage section is descriptive enough, I would think.      *   FILE 555
//*                                                                 *   FILE 555
//*      The calendar program has a bug for the month of February.  *   FILE 555
//*      I think it displays 28 days even if it's a leap year.      *   FILE 555
//*      But the month of March is OK.  I guess I'm just too lazy   *   FILE 555
//*      to fix it.  If you invoke calendar w/o parms, it will      *   FILE 555
//*      display the current date.  If you want a specific date,    *   FILE 555
//*      invoke it like "CALENDAR yyyymmdd"                         *   FILE 555
//*                                                                 *   FILE 555
//*      Most of the subroutines here are Y2K compliant, I          *   FILE 555
//*      believe.  But some, like GUS002 (convert yymmdd to         *   FILE 555
//*      yyddd) may not need to be...  I haven't checked.           *   FILE 555
//*                                                                 *   FILE 555
//*      The program FLPRT just prints the dataset defined in       *   FILE 555
//*      SYSUT1.  Only FLPRT and CALENDAR are non-reentrant; all    *   FILE 555
//*      the rest are re-entrant programs.                          *   FILE 555
//*                                                                 *   FILE 555
//*      "LIST" just displays the contents of the data passed on    *   FILE 555
//*      the command line.  It is included here as an example of    *   FILE 555
//*      a program that uses the PARSE, PUTLINE and DYNALLOC        *   FILE 555
//*      subroutines (GUS014,GUS016 and GUS012).  TST9 is           *   FILE 555
//*      another test program that demonstrates how the SCAN,       *   FILE 555
//*      GETLINE and PUTLINE routines help make writing command     *   FILE 555
//*      processors easy.                                           *   FILE 555
//*                                                                 *   FILE 555
//*      BTW, GUS stands for General Utility Subroutines.           *   FILE 555
//*                                                                 *   FILE 555
//*      The MACLIB member SF is to create 3270 attributes; but     *   FILE 555
//*      I haven't gotten around to support the X'29' order for     *   FILE 555
//*      extended attributes.  It does support Fujitsu's X'1B'      *   FILE 555
//*      order for F9526 extended attributes.                       *   FILE 555
//*                                                                 *   FILE 555
//*      I hope you find these useful.    Mon                       *   FILE 555
//*                                                                 *   FILE 555

```
