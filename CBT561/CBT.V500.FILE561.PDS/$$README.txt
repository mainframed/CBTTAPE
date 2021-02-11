************************************************************************
* File 561 is primarily CLISTs used in TSO ISPF sessions.              *
************************************************************************
ASMC     .Edit macro used to save current source program and submit an
          assembly and linkedit. Uses the ASMXP66 member in File 560 and
          also the ASMEDITC edit macro in this library. This CLIST
          differs from ASMN in that the linkedit is with "CALL".
ASMEDITC .Edit macro used by the ASMC edit macro in this library.
ASMEDITN .Edit macro used by the ASMN edit macro in this library.
ASMN     .Edit macro used to save current source program and submit an
          assembly and linkedit. Uses the ASMXP66 member in File 560 and
          also the ASMEDITN edit macro in this library. This CLIST
          differs from ASMC in that the linkedit is with "NCAL".
BATCHEDT .A sample edit macro that can be used as-is, or as a model. As
          written, it does a "change all 'mvc' '@@@';save;end" in the
          dataset currently being edited.
BATCHED1 .A sample CLIST that initiates an edit session on a dataset
          named BC0THOR.TEST.DATA and executes the BATCHEDT macro in
          this library. The dataset will be changed such that all
          occurrences of the string 'mvc' will have been changed to
          '@@@'.
BKT      .In the C language source program being edited, this edit
          macro replaces all square brackets found with the values
          needed so that they display as brackets in the edit session.
          This is necessary since the edit session may not recognize
          the same value for square brackets as does the C language
          compiler.
BOOKD    .Used to initiate a BookManager session.
BOOKSHRT .Another BookManager CLIST
BPROC    .A TSO initialization CLIST
CBC3GIS1 .Starts the C language ISPF example using the panels CBC3GIS2,
          CBC3GIS4, and CBC3GIS5 in File 562 (PLIB) and the C program
          CBC3GIS3 in File 559.
CBC3GIS6 .Starts the C language ISPF example using the panels CBC3GIS7
          and CBC3GIS4 in File 562 (PLIB) and the C program CBC3GIS8 in
          File 559.
CCMP     .Saves the current C language source program being edited and
          submits a compile-and-bind job for the program. It uses the
          edit macro CEDIT in this library, and the EDCCB JCL in File
          560.
CEDIT    .An edit macro used with the CCMP macro in this library.
CHRDUMP  .Allocates the files and executes the CHRDUMP program from a
          TSO session.
COBV     .Saves the VS COBOL program currently being edited and submits
          a compile-and-linkedit job for it. Uses the COBVEDIT macro in
          this library and the JCL member COBVXP66 in File 560
COBVEDIT .An edit macro used by the COBV member of this library.
COB2     .Saves the COBOL II program currently being edited and submits
          a compile-and-linkedit job for it. Uses the COB2EDIT macro in
          this library and the JCL member COB2XP66 in File 560.
COB2EDIT .An edit macro used with the COB2 macro in this library.
COB3     .Saves the COBOL/390 program currently being edited and submits
          a compile-and-linkedit job for it. Uses the COB3EDIT macro in
          this library and the JCL member COB3XP66 in File 560.
COB3EDIT .An edit macro used with the COB3 macro in this library.
COMPARE  .Sample CLIST to allocate the files and invoke the COMPASM
          program in file 558 to compare two assembler language
          programs.
COMPPDS  .Compresses a PDS by allocating a new dataset, copying the
          named dataset into it, deleting the original, and renaming
          the new one to the old name.
DATES    .Accepts a date (Julian or Gregorian) from the user, calls the
          DATES program in File 563 for conversion, and returns the
          opposite date of that provided.
DEBUG    .Sample start code for a CLIST with the DEBUG option.
FELE     .A REXX EXEC we use to query Endevor about elements.
HCD      .Initiates an HCD session.
IPCSINIT .Initiates an IPCS session under ISPF.
IPLINFO  .Displays information about the most recent IPL. A REXX EXEC
          written by Mark Zelden is called.
ISPALOC  .Allocates files for a TSO ISPF session.
RENMSAVE .Reduces keystrokes in renaming a PDS member. Syntax is
          "RENM pdsname curmemname newmemname" where pdsname is the
          dsname of the PDS containing the member, curmemname is the
          current member name, and newmemname is the desired new name
          for the member.
STARTREK .Initiates an old STARTREK game from the 60's. Uses the
          STASRTREK load module in File 568.
T        .Sample edit macro that searches for a string beginning in
          column 1. When/if found, deletes the line found and inserts
          two lines in its place, then SAVEs and ENDs.
TEST2    .Sample edit macro that searches for a string beginning in
          column 1. When/if found, deletes the line found and inserts
          two lines in its place. same as the T CLIST except it does
          not SAVE nor END.
VSYSTEM  .A system utility CLIST for Endevor received from CA support.
XCOL     .Excludes a column from a dataset in edit or view. This can
          be useful when elements in a dataset are so far apart
          that the display must be shifted left and right to see both
          elements. Syntax is "XCOL sss lll" where sss is the beginning
          column, and lll is the ending column. Data is actually
          shifted by this edit macro, so be sure to end without saving
          to prevent data corruption in edit.
XXCOL    .A REXX EXEC that duplicates the action of CLIST XCOL.
