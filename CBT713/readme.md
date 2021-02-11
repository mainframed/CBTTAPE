```
//***FILE 713 is from Steve Myers and contains a version of the     *   FILE 713
//*           EMPTYPDS program from File 172, with the APF          *   FILE 713
//*           requirement removed, and a few other changes.         *   FILE 713
//*                                                                 *   FILE 713
//*           Fixed by Sam Golob to produce proper return codes     *   FILE 713
//*           and to display a title message, plus a few other      *   FILE 713
//*           fixes.  See member $$NOTE3.  Issue proper messages    *   FILE 713
//*           to the JES log, even if SYSPRINT DD is missing.       *   FILE 713
//*           This will always ensure that the user is properly     *   FILE 713
//*           informed of what the program did, or didn't do.       *   FILE 713
//*                                                                 *   FILE 713
//*           This program runs in batch and empties a pds of       *   FILE 713
//*           its members by writing a first key with X'FF's        *   FILE 713
//*           in the pds directory.                                 *   FILE 713
//*                                                                 *   FILE 713
//*           Tested on z/OS 1.7 and 1.8 by Steve Myers.            *   FILE 713
//*           Tested on z/OS 1.9 and 1.10 by Sam Golob.             *   FILE 713
//*                                                                 *   FILE 713
//*  email:  "Steve Myers" <stephen-myers@comcast.net>              *   FILE 713
//*          "David Cartwright" <davecartwright@uk.agcocorp.com>    *   FILE 713
//*          sbgolob@cbttape.org   or  sbgolob@attglobal.net        *   FILE 713
//*                                                                 *   FILE 713

```
