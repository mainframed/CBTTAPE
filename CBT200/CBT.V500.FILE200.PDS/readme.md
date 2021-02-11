
## $DOC1.txt
```
Notes:  03/21/00                              Sam Golob

   Ran COBREAD by Roland Schiradin, who is an expert (the author
   of COBANAL on File 321).  Roland noticed that the S0C4 can be
   avoided by linkediting COBREAD and COBFMT with AMODE ANY or
   AMODE 31.  Fixed dates of the format 00.nnn , in COBREAD.

   This program still needs a lot of modernization, and a second
   base register.


Notes:  03/12/00                              Sam Golob

   Fixed WHATSNEW and WHEREUSD for Y2K.  Reformatted yy.ddd date
   in the report headers to have X'F0' for the fill character in
   the edit pattern PAT01, and blanked out the first zero, so the
   year comes out as 00.045, for example.  Second fix was the sort.
   Used the Y2D sort parameter, so the year 00 sorts ahead of 99.

   Tried to run COBREAD program, but it gets an S0C4, running past
   the end of the CESD Table.  For now, I'd suggest using the far
   more modern program:  COBANAL from Roland Schiradin on File 321
   of the CBT MVS Utilities Tape.


Notes:  04/17/95                              Sam Golob

   Tried WHATSNEW program using DFSORT on MVS/ESA 4.3 with DFSORT 12.0.
   It seems that with DFSORT, the "delete record" code from an
   Assembler E35 exit routine should be 4 instead of 12.  I also
   took out the size parameter from the sort parms, and let it
   default.  Seems to work OK on our system.  Increased size of CESD
   table - made it 4x bigger.  Works on SYS1.LINKLIB and SYS1.NUCLEUS.
   Ran pgm with 9000K region.  May not need this much.  But we have
   bigger systems nowadays.

*     MADE 3 CHANGES:                                                 *
*         1.  ELIMINATED SIZE PARAMETER FROM SORT INVOCATION.         *
*         2.  INCREASED SIZE OF CESD TABLE 4X (LABEL "GETLEN").       *
*         3.  DFSORT HAS A DIFFERENT RETURN CODE FROM AN ASSEMBLER    *
*              E35 EXIT, TO DELETE A RECORD.  IT IS 4 INSTEAD OF 12.  *

```

## $DOC.txt
```
         TWA TOOLBOX PACKAGE DOCUMENTATION

         A COPY OF THIS DOCUMENT IS CONTAINED IN THE DISTRIBUTION PDS
         AS MEMBER $DOC.


         REX WIDMER / RON STUBBLEFIELD

         TRANS WORLD AIRLINES INC.
         KANSAS CITY ADMINISTRATIVE CENTER
         11500 AMBASADOR DRIVE
         KANSAS CITY, MO 64195

         816-464-6671
         816-464-6512

         THIS PACKAGE IS DISTRIBUTED WITHOUT CHARGE TO MEMBERS
         OF SHARE AND GUIDE. IT IS DISTRIBUTED ON AN AS IS,
         WHERE IS BASIS, WITHOUT EXPRESSED OR IMPLIED WARRANTY
         OF ANY KIND.  IT IS DISTRIBUTED IN HOPE THAT IT MAY SAVE
         OTHER MEMBERS OF THE PROJECT SOME WHEEL RE-INVENTING...

         THE PACKAGE CONSISTS OF THE FOLLOWING PROGRAMS....

           WHATSNEW  THIS PROGRAM ANALYZES A PDS AND LISTS
                     THE MEMBERS IN MOST RECENTLY CHANGED ORDER
                     A CHANGE IS CONSTITUTED TO MEAN A RE-LINKEDIT,
                     OR A CHANGE BY SUPERZAP.  IT IS DRIVEN BY THE
                     IDR DATA RECORDS WITHIN THE PDS.

                       LANGUAGE  OS BAL

           WHEREUSD  THIS PROGRAM ANALYZES A PDS AND LISTS ALL MEMBERS
                     WHICH CONTAIN A REFERENCE TO A GIVEN EXTERNAL
                     SYMBOL.

                       LANGUAGE  OS BAL

           COMPARE   THIS PROGRAM ANALYZES GIVEN MEMBERS WHICH EXIST IN
                     A PAIR OF PDS'S.  THE MEMBERS ARE CHECKED FOR
                     DIFFERENCES AND FOR ADHERANCE TO INSTALLATION
                     STANDARDS AS A PRE-IMPLEMENTATION Q/C MEASURE.

                       LANGUAGE  OS BAL
                       MEMBERS / CSECTS
                          COMPARE  -- MAINLINE
                          COBFMT   -- SUBROUTINE
                          COMPDS   -- SUBROUTINE
                          COMPTBL  -- SUBROUTINE
                          PRTTBL   -- SUBROUTINE

           COBREAD   THIS PROGRAM ANALYZES A PDS AND LISTS ALL MEMBERS
                     ALONG WITH THE COBOL ATTRIBUTES ASSOCIATED WITH
                     THE MAIN CSECT WITHIN THE MODULE.  SUCH ITEMS AS
                     COBOL /STATE/, /FLOW/, /OPTIMIZATION/, /TEST/,
                     /ENDJOB/, AND /DYNAM/ ARE LISTED.
                     THE ABILITY TO SELECTIVELY ANALYZE A SINGLE
                     MEMBER IS ALSO SUPPORTED.

                       LANGUAGE  OS BAL
                       MEMBERS / CSECTS
                          COBREAD  -- MAINLINE
                          COBFMT   -- SUBROUTINE TO COBREAD

                       NOTES...  REPLACES EARLIER PROGRAM /COBAUDIT/
                          THIS IS AN ENHANCED VERSION WITH CSECT BY
                          CSECT SCANNING ABILITY

           XREF1     THIS PROGRAM SCANS A PDS AND PRODUCES INTERMEDIATE
                     RECORDS TO ALLOW XREF2 TO CREATE A GLOBAL CROSS-
                     REFERENCE OF EXTERNAL SYMBOLS IN THE PDS.  THIS
                     REPORT PROVIDES INFORMATION OF THE FORM  CSECT IS
                     CONTAINED IN THE FOLLOWING LOAD MODULES...

                       LANGUAGE  OS BAL

           XREF2     THIS IS THE REPORT PROGRAM TO PROCESS THE OUTPUT
                     OF XREF1.  IT MAY HAVE MULTIPLE XREF1 FILES AS
                     INPUT, ALL INPUTS WILL BE MERGED WITHIN THE REPORT
                     GENERATION PROCESS.

                       LANGUAGE  PL/I OPTIMIZER / CHECKOUT COMPILER

           INSTALLATION INSTRUCTIONS....

                     THE PACKAGE IS IN THE FORM OF IEBUPDTE SYSIN.
                     IT REQUIRES ABOUT 2.5 MEGABYTE OF DISK STORAGE
                     TO HOLD THE PDS (1 3350 CYLINDER AT 80 X 19040).

                     ONCE THE PDS HAS BEEN CREATED ON YOUR SYSTEM THE 5
                     PROGRAMS MAY BE RECOMPILED.  ALL OF THE PROGRAMS
                     EXCEPT XREF2 ARE WRITTEN IN OS/VS ASSEMBLER
                     LANGUAGE.  THE PRIVATE MACROS UTILIZED WITHIN THE
                     PROGRAM ARE INCLUDED IN THE PDS.  THE DISTRIBUTION
                     PDS SHOULD BE INCLUDED WITHIN THE SYSLIB DD-CARD
                     SPECIFICATION FOR THE ASSEMBLIES.  PROGRAM XREF2
                     IS WRITTEN IN PL/I UTILIZING THE OPTIMIZING
                     COMPILER.  IF THE OPTIMIZER IS NOT AVAILABLE, THE
                     F LEVEL PL/I (FREEBEE) MAY BE USED WITH MINOR
                     CHANGES TO THE BUILTIN FUNCTION NAMES.  IF PL/I IS
                     NOT AVAILABLE IN ANY FORM THE PROGRAM MAY EASILY BE
                     RECODED IN COBOL, OR IN BAL.
                     EXECUTION JCL AND INSTRUCTIONS ARE INCLUDED IN THE
                     COMMENT BLOCK AT THE START OF EACH PROGRAM.

                     IF WE MAY PROVIDE ADDITIONAL INFORMATION OR
                     ASSISTANCE, DON'T HESITATE TO CALL OR WRITE.


                                                 REX WIDMER
                                                 RON STUBBLEFIELD
```

