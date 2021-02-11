
## @FILE557.txt
```
//***FILE 557 is from Jim Moore of Concentrated Logic Corp. and     *   FILE 557
//*           contains some interesting code to calculate the       *   FILE 557
//*           Soundex Code using a COBOL program (for the guts)     *   FILE 557
//*           an Assembler program, a REXX, and an ISPF panel.      *   FILE 557
//*                                                                 *   FILE 557
//*           email:  "JB Moore" <conlogco@IX.NETCOM.COM>           *   FILE 557
//*                                                                 *   FILE 557
//*      Here's something you can do to illustrate the use of       *   FILE 557
//*      this program.  Try it out and notice the code that it      *   FILE 557
//*      returns for your last name.  Most U.S. states use the      *   FILE 557
//*      ANNN Soundex code to begin their driver's license          *   FILE 557
//*      number.                                                    *   FILE 557
//*                                                                 *   FILE 557
//*      A brief description of the package follows:                *   FILE 557
//*                                                                 *   FILE 557
//*      This program will create a Soundex code from a name.       *   FILE 557
//*      The "Knuth Rules" Soundex algorithm is used.  Refer to     *   FILE 557
//*      pages 394 - 395 of Volume 3 - "The Art of Computer         *   FILE 557
//*      Programming" By Don Knuth.  This is the "Sorting and       *   FILE 557
//*      Searching" volume, 2nd edition.                            *   FILE 557
//*                                                                 *   FILE 557
//*      I have added some feature to the algorithm which, IMHO,    *   FILE 557
//*      make it more useful across a wider variety of names.       *   FILE 557
//*      These features are:                                        *   FILE 557
//*                                                                 *   FILE 557
//*      1) The capability of having a longer code generated.       *   FILE 557
//*         The standard code is in the format ANNN (alpha, nbr,    *   FILE 557
//*         nbr, nbr).  By using a passed parameter, a code as      *   FILE 557
//*         long as 10 can be created.                              *   FILE 557
//*                                                                 *   FILE 557
//*      2) The capability of having an "all alpha" code            *   FILE 557
//*         created.  The standard code is in the format ANNN       *   FILE 557
//*         (alpha, nbr, nbr, nbr).  By using a passed              *   FILE 557
//*         parameter, a code can be generated that is all          *   FILE 557
//*         alphabetic.                                             *   FILE 557
//*                                                                 *   FILE 557
//*      3) The capability of varying the pad character.  The       *   FILE 557
//*         normal pad character is a zero ("0").                   *   FILE 557
//*                                                                 *   FILE 557
```

