************************************************************************
* File 562 contains three libraries (REXX execs, messages, and panels) *
* that together make up an ISPF dialog that can be used by a programmer*
* to aid in reading an Abend-Aid dump.                                 *
*                                                                      *
* In addition there are a few other things in these libraries as noted *
* in the member documentation below. Documentation is provided here for*
* all 3 libraries; there is no separate $$README file within the MSGS  *
* and PLIB libraries.                                                  *
*                                                                      *
* Before use, the three libraries must be allocated to the ISPF SYSPROC*
* (or SYSEXEC), ISPMLIB, and ISPPLIB files, respectively. Also, the    *
* programmer should have the listing from the COBOL compile and        *
* linkedit listings as well as the Abend-Aid dump.                     *
*                                                                      *
* In use, data gathering panels ask for information the programmer must*
* supply from the compile, linkedit, and dump listings. The dialog then*
* guides the programmer to the statement in the COBOL program where the*
* abend occurred.                                                      *
*                                                                      *
* The dialog can also be used by a programmer to locate data fields in *
* the Abend-Aid dump. Fields may be located in WORKING-STORAGE, in data*
* files, or in the LINKAGE SECTION. by entering the BL-CELL, offset,   *
* data type, field length, number of occurrences, subscript or index   *
* information, and so forth, the programmer is led to the data field   *
* in the dump.                                                         *
*                                                                      *
* The dialog aids the programmer by doing the hex-decimal conversions, *
* validating data entered, and specifying where the data is to be      *
* found. It also determines correct offsets based on zero-relative or  *
* on one-relative offsets. This can be tricky, as IBM and Abend-Aid    *
* differ in some instances, and neither of them is consistent.         *
*                                                                      *
* Dialog is started by use of the AATX000 command, then reading the    *
* panels presented and following instructions.                         *
*                                                                      *
************************************************************************

***********************************************************************
* EXECS:   REXX EXECS (ALLOCATE TO SYSPROC OR TO SYSEXEC)             *
***********************************************************************
AATX000  .Part of the AATX000 dialog.
AATX010  .Part of the AATX000 dialog.
AATX020  .Part of the AATX000 dialog.
AATX030  .Part of the AATX000 dialog.
AATX034  .Part of the AATX000 dialog.
AATX060  .Part of the AATX000 dialog.
AATX064  .Part of the AATX000 dialog.
AATX070  .Part of the AATX000 dialog.
AATX074  .Part of the AATX000 dialog.
AATX080  .Part of the AATX000 dialog.
AATX090  .Part of the AATX000 dialog.
ARGPASS  .Example of passing arguments to a REXX EXEC.
DATE     .This is a REXX EXEC that requests a Julian or Gregorian date
          and displays the other format on the TSO screen. It uses
          the DATES COBOL program in FILE563.
MODEL    .This is a sample for developing a REXX routine from scratch.
MULTPULL .Simple REXX EXEC asks for three numbers, displays their sum.
PARSPULL .Simple REXX EXEC to show how parsing can retain data case
          or change to all upper-case.
REXXADDR .Shows some REXX ADDRESS commands. Has an error in the comments
          at the beginning of the exec (needs /*...*/).
SAY      .Simple REXX EXEC to show uses of the "SAY" command.
TEST     .Sample REXX exec to show several REXX constructs.
TEST1    .REXX EXEC called by the "TEST" REXX EXEC above.
TIMEGAME .REXX EXEC to display time of day using the TIME command.

***********************************************************************
* MSGS:    DIALOG MESSAGES (ALLOCATE TO ISPMLIB)                      *
***********************************************************************
AATM00    .Part of the AATX000 dialog..
AATM01    .Part of the AATX000 dialog..
AATM03    .Part of the AATX000 dialog..
AATM06    .Part of the AATX000 dialog..
AATM07    .Part of the AATX000 dialog..
AATM08    .Part of the AATX000 dialog..
AATM91    .Part of the AATX000 dialog..

***********************************************************************
* PLIB:    dialog.. PANELS (ALLOCATE TO ISPPLIB)                      *
***********************************************************************
AATH000   .Part of the AATX000 dialog..
AATH010   .Part of the AATX000 dialog..
AATH011   .Part of the AATX000 dialog..
AATH030   .Part of the AATX000 dialog..
AATH031   .Part of the AATX000 dialog..
AATH060   .Part of the AATX000 dialog..
AATH061   .Part of the AATX000 dialog..
AATH070   .Part of the AATX000 dialog..
AATH071   .Part of the AATX000 dialog..
AATH080   .Part of the AATX000 dialog..
AATH090   .Part of the AATX000 dialog..
AATH911   .Part of the AATX000 dialog..
AATH911A  .Part of the AATX000 dialog..
AATH912   .Part of the AATX000 dialog..
AATH912A  .Part of the AATX000 dialog..
AATH913   .Part of the AATX000 dialog..
AATP000   .Part of the AATX000 dialog..
AATP010   .Part of the AATX000 dialog..
AATP014   .Part of the AATX000 dialog..
AATP020   .Part of the AATX000 dialog..
AATP030   .Part of the AATX000 dialog..
AATP034   .Part of the AATX000 dialog..
AATP060   .Part of the AATX000 dialog..
AATP064   .Part of the AATX000 dialog..
AATP070   .Part of the AATX000 dialog..
AATP071   .Part of the AATX000 dialog..
AATP074   .Part of the AATX000 dialog..
AATP080   .Part of the AATX000 dialog..
AATP081   .Part of the AATX000 dialog..
AATP090   .Part of the AATX000 dialog..
AATP911   .Part of the AATX000 dialog..
AATP912   .Part of the AATX000 dialog..
AATP913   .Part of the AATX000 dialog..
CBC3GIS2  .Used by the C sample program CBC3GIS3 in FILE559
CBC3GIS4  .Used by the C sample programs CBC3GIS4 and CBC3GIS8 in
           FILE559.
CBC3GIS5  .Used by the C sample program CBC3GIS3 in FILE559
CBC3GIS7  .Used by the C sample program CBC3GIS8 in FILE559
