
## @FILE733.txt
```
//***FILE 733 is the full ALGOL68C tape distribution of the ALGOL   *   FILE 733
//*           68C language, from Cambridge University, dated the    *   FILE 733
//*           Spring of 1976.  It may not be what you expect, but   *   FILE 733
//*           it is the full distribution tape, consisting of 25    *   FILE 733
//*           tape files.  The members in this pds are numbered     *   FILE 733
//*           in order, according to the tape file numbers:         *   FILE 733
//*                                                                 *   FILE 733
//*           I believe this is called a "prerelease version".      *   FILE 733
//*                                                                 *   FILE 733
//*           Member A68C01 corresponds to tape file 1, and so      *   FILE 733
//*           forth, so you can navigate through this pds, just     *   FILE 733
//*           like you would navigate through the tape documenta-   *   FILE 733
//*           tion on file 4, which is reproduced here as member    *   FILE 733
//*           $INSTALL.                                             *   FILE 733
//*                                                                 *   FILE 733
//*           There are many interesting things to look at here,    *   FILE 733
//*           even if you don't want to implement the language,     *   FILE 733
//*           such as the character set description in member       *   FILE 733
//*           A68C01 (file 1), and the pack/unpack program that     *   FILE 733
//*           is included in the package.                           *   FILE 733
//*                                                                 *   FILE 733
//*           Object deck disassemblies of the PACK and PACKCEBC    *   FILE 733
//*           programs on file 8 have been provided.                *   FILE 733
//*                                                                 *   FILE 733
//*           Do with it as you like, and as you can.  At least it  *   FILE 733
//*           is all here.  What you see is what you get, and what  *   FILE 733
//*           you get is what you can make of it.                   *   FILE 733
//*                                                                 *   FILE 733
//*   Questions:  sbgolob@cbttape.org  or sbgolob@attglobal.net     *   FILE 733
//*                                                                 *   FILE 733
//*       Differences between ALGOL68C and ALGOL 68                 *   FILE 733
//*       ----------- ------- -------- --- ----- --                 *   FILE 733
//*                                                                 *   FILE 733
//*     Restrictions                                                *   FILE 733
//*                                                                 *   FILE 733
//*     .   No parallel clauses.                                    *   FILE 733
//*                                                                 *   FILE 733
//*     .   No flexible names.                                      *   FILE 733
//*                                                                 *   FILE 733
//*     .   No formatted transput.                                  *   FILE 733
//*                                                                 *   FILE 733
//*     .   No vacuums.                                             *   FILE 733
//*                                                                 *   FILE 733
//*     .   An indicant may not be used as both an operator and     *   FILE 733
//*         a mode-indication.                                      *   FILE 733
//*                                                                 *   FILE 733
//*     .   Round brackets are not available in row-declarers.      *   FILE 733
//*         (But see 'row-symbol' below.)                           *   FILE 733
//*                                                                 *   FILE 733
//*     .   Colon-symbol must not be present in virtual rowers.     *   FILE 733
//*                                                                 *   FILE 733
//*     .   Both bounds must be specified in an actual rower.       *   FILE 733
//*                                                                 *   FILE 733
//*     .   := and =: are not available in operators.               *   FILE 733
//*         (But see 'assign-formulas' below.)                      *   FILE 733
//*                                                                 *   FILE 733
//*     .   Widening of BITS and BYTES is not provided.             *   FILE 733
//*                                                                 *   FILE 733
//*     Extensions                                                  *   FILE 733
//*                                                                 *   FILE 733
//*     .   Labels in enquiry-clauses.                              *   FILE 733
//*                                                                 *   FILE 733
//*     .   UPTO and DOWNTO in loop-clauses.                        *   FILE 733
//*                                                                 *   FILE 733
//*     .   Until-part in loop-clauses.                             *   FILE 733
//*                                                                 *   FILE 733
//*     .   Operator priorities.                                    *   FILE 733
//*                                                                 *   FILE 733
//*     .   Row-symbol in row-declarers.                            *   FILE 733
//*         (e.g. ROW()AMODE as an alternative to âäAMODE.)         *   FILE 733
//*                                                                 *   FILE 733
//*     .   Monadic-formula is a secondary.                         *   FILE 733
//*                                                                 *   FILE 733
//*     .   Displacements (yielding the previous value).            *   FILE 733
//*                                                                 *   FILE 733
//*     .   Assign-formulas (op:= and op:=:= are automatically      *   FILE 733
//*         available for all op).                                  *   FILE 733
//*                                                                 *   FILE 733
//*     .   Predicates (ANDF and ORF have defined sequence of       *   FILE 733
//*         elaboration).                                           *   FILE 733
//*                                                                 *   FILE 733
//*     .   Handles.                                                *   FILE 733
//*                                                                 *   FILE 733
//*     .   Escaped-characters in string-denotations (e.g. *"       *   FILE 733
//*         yields ").                                              *   FILE 733
//*                                                                 *   FILE 733
//*     .   Use of square brackets in calls.                        *   FILE 733
//*                                                                 *   FILE 733
//*     .   Thef-symbol in conditional-clauses.                     *   FILE 733
//*         (e.g. IF a THEF b THEN c ELSE d FI)                     *   FILE 733
//*                                                                 *   FILE 733
//*     .   :¬=: as a representation of the is-not-symbol.          *   FILE 733
//*                                                                 *   FILE 733
```

