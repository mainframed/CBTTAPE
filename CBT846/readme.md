```
//***FILE 846 is from somitcw and contains programs to do EXCP for  *   FILE 846
//*           DASD.  Programs beginning with TRK0*** deal with      *   FILE 846
//*           saving and restoring IPL text on a disk volume.       *   FILE 846
//*                                                                 *   FILE 846
//*           So you can move IPL text from one volume              *   FILE 846
//*           to another.  (Nice technique to have.)                *   FILE 846
//*                                                                 *   FILE 846
//*           Program EOFDISK will clear disk tracks in the         *   FILE 846
//*           extents of a sequential dataset.                      *   FILE 846
//*                                                                 *   FILE 846
//*       Addition of program ONLCLIP "Online CLIP" to change       *   FILE 846
//*           the volser of a disk pack while it is online.         *   FILE 846
//*           Needs READ access to RACF FACILITY class profile      *   FILE 846
//*           TBCXTUL (CBT backwards, X, TUL for tools).            *   FILE 846
//*       New program ONLCLEAR which blanks out the user area       *   FILE 846
//*           which is the last 64 bytes (the identification        *   FILE 846
//*           part) of Track 0, Record 3.                           *   FILE 846
//*           Needs READ access to RACF FACILITY class profile      *   FILE 846
//*           TBCXTUL (CBT backwards, X, TUL for tools).            *   FILE 846
//*                                                                 *   FILE 846
//*       Description of TRK0SAVE, TRK0UPD.                         *   FILE 846
//*                                                                 *   FILE 846
//*           TRK0SAVE will copy Records 1, 2, 4, and the           *   FILE 846
//*           rest of the records on Track 0 (Record 3 is the       *   FILE 846
//*           volume id, so it isn't copied) to an external data    *   FILE 846
//*           set.  TRK0UPD will take this output and reload Track  *   FILE 846
//*           0 of a target volume with this unloaded IPL text.     *   FILE 846
//*                                                                 *   FILE 846
//*           For completeness, Sam Golob followed somitcw's lead   *   FILE 846
//*           and wrote a program to REMOVE IPL text, called        *   FILE 846
//*           TRK0INIT.  This program will erase the IPL text       *   FILE 846
//*           from a disk pack.  IT MUST BE USED WITH EXTREME       *   FILE 846
//*           CAUTION !!!  See warning below, how to avoid          *   FILE 846
//*           problems.                                             *   FILE 846
//*                                                                 *   FILE 846
//*       below    - - - - - W A R N I N G - - - - -                *   FILE 846
//*                                                                 *   FILE 846
//*     >>>>  If you are erasing the IPL text off a disk pack,      *   FILE 846
//*     >>>>  you should please make sure that you back it up       *   FILE 846
//*     >>>>  first, using TRK0SAVE.  Then you can restore it       *   FILE 846
//*     >>>>  later with TRK0UPD.                                   *   FILE 846
//*                                                                 *   FILE 846
//*       above    - - - - - W A R N I N G - - - - -                *   FILE 846
//*                                                                 *   FILE 846
//*           Sam Golob has added a program to this collection      *   FILE 846
//*           called TR02ABS, along with JCL to run it.  This       *   FILE 846
//*           program CONVERTS IPLTEXT that is in TRK0SAVE          *   FILE 846
//*           format to IPLTEXT in ICKDSF ABSFORMAT, so that it     *   FILE 846
//*           can be loaded using ICKDSF, without needing to        *   FILE 846
//*           use the TRK0UPD program from this file.               *   FILE 846
//*                                                                 *   FILE 846
//*           Added source code for the AWSTAPIN program, which     *   FILE 846
//*           I plagiarized to create the TR02ABS program. Since    *   FILE 846
//*           AWSTAPIN is nowhere on the CBT Tape, I put it here    *   FILE 846
//*           for safekeeping.  I think it was once on the          *   FILE 846
//*           Hercules-390 Yahoogroups files, but those get         *   FILE 846
//*           purged quite often, when the capacity is exceeded.    *   FILE 846
//*           The author of AWSTAPIN turned out to be David         *   FILE 846
//*           Cartwright.  And I rang him up, to thank him.         *   FILE 846
//*                                                                 *   FILE 846
//*           email:  somitcw@yahoo.com                             *   FILE 846
//*                                                                 *   FILE 846
//*           email:  sbgolob@cbttape.org                           *   FILE 846
//*                                                                 *   FILE 846

```
