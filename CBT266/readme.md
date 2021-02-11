```
//***FILE 266 is from Sam Golob, who updated the tape mapping       *   FILE 266
//*           program called SS0104 from Florida Power Corporation. *   FILE 266
//*           This code is used to measure the footages of files    *   FILE 266
//*           on the CBT Tape, as though they were on a 6250 bpi    *   FILE 266
//*           tape reel.  As is, that is what this code is used     *   FILE 266
//*           for, but it can be used for other purposes.  The      *   FILE 266
//*           report is quite excellent for showing, in general,    *   FILE 266
//*           what is on a tape.                                    *   FILE 266
//*                                                                 *   FILE 266
//*           If you fix this code, for use with any density        *   FILE 266
//*           tape, and with cartridge, please send it to me to     *   FILE 266
//*           test, so I can update this file in your name.         *   FILE 266
//*           Thanks.  (S.Golob - 08/96).                           *   FILE 266
//*                                                                 *   FILE 266
//*           Note:  Fixed to avoid the CNTRL FSM invocation that   *   FILE 266
//*                  was causing I/O errors on some MVS systems.    *   FILE 266
//*                  (05/28/04 - SBG)                               *   FILE 266
//*           Note:  Fixed to record over 10000 total feet.         *   FILE 266
//*                  (12/16/12 - SBG)                               *   FILE 266
//*           Note:  Fixed to replace WKDATE routine with TODAY     *   FILE 266
//*                  routine. (12/18/12 - SBG)                      *   FILE 266
//*                                                                 *   FILE 266
//*           I want to acknowledge the big help of one of the      *   FILE 266
//*           original authors, Gordon P. West.  Thanks, Gordon.    *   FILE 266
//*                                                                 *   FILE 266
//*           email:  sbgolob@attglobal.net                         *   FILE 266
//*                   sbgolob@cbttape.org                           *   FILE 266
//*                                                                 *   FILE 266
//*           email:  gordon@westgp.us                              *   FILE 266
//*                                                                 *   FILE 266

```
