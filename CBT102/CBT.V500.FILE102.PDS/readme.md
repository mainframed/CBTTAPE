
## @FILE102.txt
```
//***FILE 102 is the TAPESCAN program, from Frank Pajerski of       *   FILE 102
//*           Sacramento, California, and fixed to handle tapes     *   FILE 102
//*           that have up to 64K blocks of data, by Sam Golob.     *   FILE 102
//*                                                                 *   FILE 102
//*            email:  fpajerski@earthlink.net                      *   FILE 102
//*                    "Pajerski, Frank" <fpajerski@calfarm.com>    *   FILE 102
//*                                                                 *   FILE 102
//*            email:  sbgolob@attglobal.net or sbgolob@aol.com     *   FILE 102
//*                                                                 *   FILE 102
//*           ABSTRACT - A PROGRAM TO PROVIDE AN OVERVIEW OF THE    *   FILE 102
//*                      DATA SETS ON A TAPE, COPY FILES AND        *   FILE 102
//*                      RECOVER DATA PAST THE FIRST END OF         *   FILE 102
//*                      VOLUME INDICATOR.  INFORMATION PRESENTED   *   FILE 102
//*                      INCLUDES RECORD AND BYTE COUNT, LENGTH     *   FILE 102
//*                      ESTIMATE, DISPLAY OF THE FIRST 100 BYTES   *   FILE 102
//*                      OF THE FIRST FOUR RECORDS OF EACH DATA     *   FILE 102
//*                      SET, AND THE PHYSICAL TAPE FILE NUMBER.    *   FILE 102
//*                                                                 *   FILE 102
//*           WARNINGS - WHEN DATA IS RECOVERED PAST THE END OF     *   FILE 102
//*                      VOLUME INDICATOR, THE FIRST RECORD MAY     *   FILE 102
//*                      HAVE BEEN TRUNCATED.  IF ACCEPTED, IT      *   FILE 102
//*                      MAY LEAD TO PROBLEMS EVEN AFTER IT IS      *   FILE 102
//*                      COPIED.  WHEN COPYING DATA SETS FROM A     *   FILE 102
//*                      STANDARD LABEL TAPE, THE DATA SET          *   FILE 102
//*                      SEQUENCE NUMBER STORED IN THE HEADER       *   FILE 102
//*                      RECORD ISN'T CHANGED.  THIS HAS CAUSED     *   FILE 102
//*                      NO PROBLEMS SO FAR, BUT IS NOT SUPPORTED   *   FILE 102
//*                      BY IBM.  SOME OPERATIONS OF THIS PROGRAM   *   FILE 102
//*                      ARE BASED ON THE NUMBER OF TAPE MARKS      *   FILE 102
//*                      ENCOUNTERED.                               *   FILE 102
//*                                                                 *   FILE 102
//*           TAPESCAN'S REPORTING HAS NOW (VERSION 5.2) BEEN       *   FILE 102
//*           IMPROVED WHEN READING CARTRIDGES.  I AM ALSO          *   FILE 102
//*           INCLUDING THE OLDER VERSION (4.6A), JUST IN CASE.     *   FILE 102
//*           VERSION 4.6A CAN READ CARTRIDGES, BUT REPORTS         *   FILE 102
//*           THE FOOTAGES AS IF 6250 BPI TAPES.                    *   FILE 102
//*                                                                 *   FILE 102
//*    ABOUT TAPESCAN VERSION 5.2 -                                 *   FILE 102
//*                                                                 *   FILE 102
//*    I've now included my 64K fix to Frank Pajerski's update      *   FILE 102
//*    to Howard Dean's version of TAPESCAN.  This version has      *   FILE 102
//*    better 3480 support, and I also improved the report line     *   FILE 102
//*    if you mounted a tape with a different VOLSER than the JCL   *   FILE 102
//*    said.  The report now shows both VOLSERs, so you can see     *   FILE 102
//*    them.  This version is called TAPESCAN Version 5.2.          *   FILE 102
//*    Old Version 4.6 is being included for reference, and it      *   FILE 102
//*    has also been fixed to show the JCL VOLSER and the internal  *   FILE 102
//*    VOLSER that is on the VOL1 label of the tape, if they are    *   FILE 102
//*    different.     (SG 06/00)                                    *   FILE 102
//*                                                                 *   FILE 102
```

