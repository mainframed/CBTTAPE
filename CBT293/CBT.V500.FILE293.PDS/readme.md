
## @FILE293.txt
```
//***FILE 293 is from Warren Whitford and Sam Golob in partnership, *   FILE 293
//*           and contains various iterations of a sequential copy  *   FILE 293
//*           program for datasets, called CKIEBGEN.  The original  *   FILE 293
//*           version of CKIEBGEN was by Baldomero Castilla, and it *   FILE 293
//*           is on File 480.  The idea is to make a very simple    *   FILE 293
//*           copy program, using QSAM (GET, PUT, GET, PUT, etc.    *   FILE 293
//*           in a loop), that opens SYSUT1 for input, and SYSUT2   *   FILE 293
//*           for output.  A copy loop GETs a record from SYSUT1,   *   FILE 293
//*           PUTs it to SYSUT2, and loops until the SYSUT1 file    *   FILE 293
//*           is exhausted.  Then it closes both files and exits.   *   FILE 293
//*           No report is produced--it's just a simple QSAM copy.  *   FILE 293
//*           The equivalent of Baldomero's version of the program, *   FILE 293
//*           in this dataset, is member CKIEBG01.  (Baldomero      *   FILE 293
//*           commented his program in Spanish, and used his own    *   FILE 293
//*           entry and exit macros, which are really not           *   FILE 293
//*           necessary for the program to work.)                   *   FILE 293
//*                                                                 *   FILE 293
//*           This program has several advantages over IEBGENER     *   FILE 293
//*           and many of its substitutes, because of its           *   FILE 293
//*           generality and simplicity.  It also will copy         *   FILE 293
//*           files that IEBGENER might not copy, because it does   *   FILE 293
//*           not look at the data.  It just does GET and PUT,      *   FILE 293
//*           quite mindlessly.  But the DCB information has to     *   FILE 293
//*           be coded in the execution JCL, otherwise QSAM won't   *   FILE 293
//*           "know" how to construct the proper channel programs   *   FILE 293
//*           to do the GET and PUT for the particular input and    *   FILE 293
//*           output files.  This is a "record by record" copy,     *   FILE 293
//*           and NOT "block by block".                             *   FILE 293
//*                                                                 *   FILE 293
//*           Program MANYRCDS has been added to this file, as      *   FILE 293
//*           an aid in testing the SKIP and COPY functions of      *   FILE 293
//*           CKIEBGEN.  See notes in the MANYRCDS program for      *   FILE 293
//*           further details.                                      *   FILE 293
//*                                                                 *   FILE 293
//*           Many improvements have been made at Level 008.        *   FILE 293
//*           (See below.)                                          *   FILE 293
//*                                                                 *   FILE 293
//*           Most improvements for CKIEBGEN have been in the way   *   FILE 293
//*           of messaging.  You want to know, first of all, how    *   FILE 293
//*           many records have been copied.  So the next iteration *   FILE 293
//*           called CKIEBG02, adds a SYSPRINT ddname, and counts   *   FILE 293
//*           how many GETs and PUTs were done.  That is a sizable  *   FILE 293
//*           improvement.                                          *   FILE 293
//*                                                                 *   FILE 293
//*           The next iteration, CKIEBG03, adds DCB information    *   FILE 293
//*           for the input and output datasets, so you know the    *   FILE 293
//*           characteristics of these datasets, in addition to the *   FILE 293
//*           number of records copied.  This is done, using an     *   FILE 293
//*           execution of the RDJFCB macro for both input and      *   FILE 293
//*           output datasets after the copy was done.  RDJFCB      *   FILE 293
//*           can be done before or after OPEN, but after OPEN      *   FILE 293
//*           it can access more DCB information than before,       *   FILE 293
//*           because OPEN processing merges the extra information  *   FILE 293
//*           it obtained, back into the JFCB, where RDJFCB picks   *   FILE 293
//*           it up.                                                *   FILE 293
//*                                                                 *   FILE 293
//*           That approach works much of the time, but it's better *   FILE 293
//*           to try the RDJFCB before the copy is done, so that    *   FILE 293
//*           if there is an error (and not enough DCB information  *   FILE 293
//*           is present in the JCL, or from the catalog, you don't *   FILE 293
//*           attempt the copy.  The CKIEBG04 member incorporates   *   FILE 293
//*           that "improvement", as well as making the JFCB print  *   FILE 293
//*           routine into a subroutine, which is executed several  *   FILE 293
//*           times.                                                *   FILE 293
//*                                                                 *   FILE 293
//*           The CKIEBGEN iteration adds a VOLSER display for      *   FILE 293
//*           both the input and the output dataset.                *   FILE 293
//*                                                                 *   FILE 293
//*           This file was put on the CBT Tape, for the purpose    *   FILE 293
//*           of showing new Assembler language programmers some    *   FILE 293
//*           of the principles of coding, and also to illustrate   *   FILE 293
//*           how QSAM gets DCB information from the JCL, and from  *   FILE 293
//*           the catalogs.  It's also a good copy utility to have  *   FILE 293
//*           in your pocket, sometimes.                            *   FILE 293
//*                                                                 *   FILE 293
//*           See the important note at the bottom about fixing     *   FILE 293
//*           broken XMIT files, if you have the entire original    *   FILE 293
//*           (XMIT file) somewhere.                                *   FILE 293
//*                                                                 *   FILE 293
//*           Questions, please write:                              *   FILE 293
//*                                                                 *   FILE 293
//*            Warren Whitford:  (retired) write to Sam Golob       *   FILE 293
//*                                                                 *   FILE 293
//*            Sam Golob      :  sbgolob@cbttape.org                *   FILE 293
//*                                                                 *   FILE 293
//*     Next versions:  (You may expect some from time to time):    *   FILE 293
//*                                                                 *   FILE 293
//*            Level 006 - Put date and time into the report.       *   FILE 293
//*                                                                 *   FILE 293
//*            Level 007 - Copy any segment of the input file.      *   FILE 293
//*                        Optional SYSIN DD card with the          *   FILE 293
//*                          following controls:                    *   FILE 293
//*                                                                 *   FILE 293
//*             SKIP=mmmmmmm   (Skip first mmmmmmm records)         *   FILE 293
//*             COPY=nnnnnnn   (Copy the next nnnnnnn records)      *   FILE 293
//*                                                                 *   FILE 293
//*            For example, you can use this program to fix         *   FILE 293
//*            partial XMIT files, if you have the original         *   FILE 293
//*            somewhere.  Just copy the missing records at         *   FILE 293
//*            the end, and concatenate them to the partial         *   FILE 293
//*            beginning.  That puts the whole file together        *   FILE 293
//*            on the other side (in the target system).            *   FILE 293
//*                                                                 *   FILE 293
//*            Level 008 - Fixed the lack of reporting for          *   FILE 293
//*                          RECFM errors in the JFCB.              *   FILE 293
//*                        Re-commented much of the code.           *   FILE 293
//*                        Rewrote the Abnormal End processing      *   FILE 293
//*                          to give a return code of 12, so        *   FILE 293
//*                          you know that something went wrong,    *   FILE 293
//*                          and the copy wasn't done.              *   FILE 293
//*                        Fix errors in SKIP=, COPY= processing.   *   FILE 293
//*                        Later SKIP=, COPY= overrides earlier.    *   FILE 293
//*                        Allow 12 packed digits for SKIP=,        *   FILE 293
//*                         COPY=, so the largest numbers allowed   *   FILE 293
//*                         are 999999999999 (12 digits).  Ignore   *   FILE 293
//*                         binary numbers greater than             *   FILE 293
//*                         2,147,483,647, because the CVB          *   FILE 293
//*                         instruction can't handle them, but      *   FILE 293
//*                         the packed numbers are the ones used    *   FILE 293
//*                         here for comparison, not the binary.    *   FILE 293
//*                        If a SKIP= or COPY= card has a numeric   *   FILE 293
//*                         error, then stop the processing with    *   FILE 293
//*                         RC=12, and abort the copy.              *   FILE 293
//*                        Increased report number size for         *   FILE 293
//*                         skipped or copied records, in or        *   FILE 293
//*                         out records.                            *   FILE 293
//*                        Fixed possible catastrophic error when   *   FILE 293
//*                         you try and code numbers much greater   *   FILE 293
//*                         than 12 digits in SKIP and COPY SYSIN   *   FILE 293
//*                         statements.  (Limit number scan to      *   FILE 293
//*                         12 digits only--10 digits for Version   *   FILE 293
//*                         007, which was just fixed similarly.)   *   FILE 293
//*                                                                 *   FILE 293
```

