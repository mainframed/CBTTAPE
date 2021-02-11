
## @FILE763.txt
```
//***FILE 763 is collection of utilities from various authors to    *   FILE 763
//*           convert 80-byte card-image hex data, such as a PTF    *   FILE 763
//*           or an object deck, to two lines of printable code,    *   FILE 763
//*           per line of data.  And of course, there's another     *   FILE 763
//*           conversion program, to convert all the printable      *   FILE 763
//*           data back to hex.  This file has been moved.  It      *   FILE 763
//*           was originally File 760.                              *   FILE 763
//*                                                                 *   FILE 763
//*     OBJ2HEX    -   ORIGINAL REXX CODE BY KENNETH TOMIAK         *   FILE 763
//*                                                                 *   FILE 763
//*       email:   cbt_ken@KTomiak.biz                              *   FILE 763
//*                                                                 *   FILE 763
//*           OBJ2HEX is a REXX program that creates a self         *   FILE 763
//*           extracting rexx program with the input file           *   FILE 763
//*           embedded in comments. Each record of the input file   *   FILE 763
//*           is converted into two lines of printable data, in a   *   FILE 763
//*           format similar to ISPF HEX ON. This data is read by   *   FILE 763
//*           the self extracting program and converted back to     *   FILE 763
//*           the original values.                                  *   FILE 763
//*                                                                 *   FILE 763
//*           The self extracting program is comprised of standard  *   FILE 763
//*           characters, easily translated between EBCDIC and      *   FILE 763
//*           ASCII characters and back again.                      *   FILE 763
//*                                                                 *   FILE 763
//*           This method might be used to accurately transport     *   FILE 763
//*           PTFs or object decks thru an ASCII system and back.   *   FILE 763
//*           It is not limited to binary data, you can use it on   *   FILE 763
//*           any type of data that might contain characters that   *   FILE 763
//*           require special conversion during file transfer.      *   FILE 763
//*                                                                 *   FILE 763
//*       SAMPJCL - Sample JCL that shows multiple ways to run      *   FILE 763
//*                 OBJ2HEX to read a PDS member, in this example   *   FILE 763
//*                 an object deck for PDSLOAD. Then two ways to    *   FILE 763
//*                 run the self extracting REXX program.           *   FILE 763
//*                                                                 *   FILE 763
//*     ---------------------------------------------------------   *   FILE 763
//*                                                                 *   FILE 763
//*     Another system to do the conversion of the 80-byte card     *   FILE 763
//*     images to (the same) two lines of printable data.  This     *   FILE 763
//*     consists of 2 Assembler programs.                           *   FILE 763
//*                                                                 *   FILE 763
//*     HX2PR      -   From Sam Golob (by way of CKIEBGEN program)  *   FILE 763
//*     PR2HX      -   From Sam Golob (by way of CKIEBGEN program)  *   FILE 763
//*                                                                 *   FILE 763
//*   Option:                                                       *   FILE 763
//*                                                                 *   FILE 763
//*     If you want clearer displayable output, you can have it     *   FILE 763
//*     in 4 lines instead of 2.  The following 2 programs add      *   FILE 763
//*     a line of purely printable data, plus a "ruler line" just   *   FILE 763
//*     the way the ISPF HEX display does it.  To reconstitute      *   FILE 763
//*     the original binary card-image, the PR42HX will do that,    *   FILE 763
//*     by ignoring the first two of the four lines in the display. *   FILE 763
//*                                                                 *   FILE 763
//*     HX2PR4     -   From Sam Golob (by way of CKIEBGEN program)  *   FILE 763
//*     PR42HX     -   From Sam Golob (by way of CKIEBGEN program)  *   FILE 763
//*                                                                 *   FILE 763
//*  Example:  4-line output (should be continued to 80 bytes)      *   FILE 763
//*                                                                 *   FILE 763
//*   ESD            PDSLOAD                                        *   FILE 763
//*  ----+----1----+----2----+----3----+----4----+----5----+----6-- *   FILE 763
//*  0CEC444444014400DCEDDCC40000001A444444444444444444444444444444 *   FILE 763
//*  25240000000000017423614000000090000000000000000000000000000000 *   FILE 763
//*   TXT             00  PDSLOAD 20070529  ANY LRECL OUT:  1:F,V-> *   FILE 763
//*  ----+----1----+----2----+----3----+----4----+----5----+----6-- *   FILE 763
//*  0EEE4000440344004FF51DCEDDCC4FFFFFFFF44CDE4DDCCD4DEE744F7C6E66 *   FILE 763
//*  2373000000080001700417423614020070529001580395330643A001A6B50E *   FILE 763
//*                                                                 *   FILE 763
//*  Example:  2-line output (should be continued to 80 bytes)      *   FILE 763
//*                                                                 *   FILE 763
//*  0CEC444444014400DCEDDCC40000001A444444444444444444444444444444 *   FILE 763
//*  25240000000000017423614000000090000000000000000000000000000000 *   FILE 763
//*  0EEE4000440344004FF51DCEDDCC4FFFFFFFF44CDE4DDCCD4DEE744F7C6E66 *   FILE 763
//*  2373000000080001700417423614020070529001580395330643A001A6B50E *   FILE 763
//*                                                                 *   FILE 763
//*       email:  sbgolob@attglobal.net or sbgolob@cbttape.org      *   FILE 763
//*                                                                 *   FILE 763
//*       HX2PR  -  Makes FB-80 Hex data printable in two lines     *   FILE 763
//*       PR2HX  -  Makes FB-80 Two Line printable data, into       *   FILE 763
//*                 one line Hex output                             *   FILE 763
//*                                                                 *   FILE 763
//*       HX2PR4 -  Makes FB-80 Hex data printable in four lines    *   FILE 763
//*       PR42HX -  Makes FB-80 Four Line printable data, into      *   FILE 763
//*                 one line Hex output                             *   FILE 763
//*                                                                 *   FILE 763
//*       HX2PR$1  - Sample JCL to run the Assembler program and    *   FILE 763
//*                  create the 2-line hex printable output.        *   FILE 763
//*       PR2HX$1  - Sample JCL to run the Assembler program and    *   FILE 763
//*                  create the 1 line character data output.       *   FILE 763
//*                                                                 *   FILE 763
//*       HX2PR4$1 - Sample JCL to run the Assembler program and    *   FILE 763
//*                  create the 4-line hex printable output.        *   FILE 763
//*       PR42HX$1 - Sample JCL to run the Assembler program and    *   FILE 763
//*                  create the 1 line character data output.       *   FILE 763
//*                                                                 *   FILE 763
//*     ---------------------------------------------------------   *   FILE 763
//*                                                                 *   FILE 763
//*     PDSLOAD    -   ORIGINAL PROGRAM FROM FILE 093               *   FILE 763
//*                                                                 *   FILE 763
//*       A sample object deck, (for the very useful IEBUPDTE-like  *   FILE 763
//*       program called PDSLOAD - CBT Tape File 093), has been     *   FILE 763
//*       included here to test the system.  Sample output from     *   FILE 763
//*       the SAMPJCL job is also included here.  These are members *   FILE 763
//*       PDSLOAD@, PDSLOAD#, and PDSLOAD$.                         *   FILE 763
//*                                                                 *   FILE 763
//*       More about the PDSLOAD program itself ---                 *   FILE 763
//*                                                                 *   FILE 763
//*       PDSLOAD will load a pds with members, starting from an    *   FILE 763
//*       IEBUPDTE-like sequential dataset, but it is possible to   *   FILE 763
//*       preserve ISPF statistics too.  See the layout below.      *   FILE 763
//*                                                                 *   FILE 763
//*       If you want to linkedit the PDSLOAD object deck to use    *   FILE 763
//*       the program for yourself, the LINK job is also included.  *   FILE 763
//*                                                                 *   FILE 763
//*       If you want to run the PDSLOAD program, the PDSLOJCL      *   FILE 763
//*       sample JCL, which makes a pds out of an IEBUPDTE-like     *   FILE 763
//*       ./ ADD NAME=memname                                       *   FILE 763
//*       input deck, provides a sample job.  Input to the PDSLOAD  *   FILE 763
//*       sample job is the SHOWMACS member.                        *   FILE 763
//*                                                                 *   FILE 763
//*     ---------------------------------------------------------   *   FILE 763
//*                                                                 *   FILE 763
//*   Illustration of the layout of an ./ ADD NAME= card, input     *   FILE 763
//*    to PDSLOAD, which preserves the stated ISPF statistics:      *   FILE 763
//*    (This layout is produced by the OFFLOAD program in CBT       *   FILE 763
//*    Tape File 093.)                                              *   FILE 763
//*                                                                 *   FILE 763
//*  1       10        20        30        40        50        60   *   FILE 763
//*  +---+----+----+----+----+----+----+----+----+----+----+----+   *   FILE 763
//*  ./ ADD NAME=$$$#DATE 0474-07151-07151-0941-00012-00012-00000   *   FILE 763
//*              membname vvmm crdat moddt time size  init  modif   *   FILE 763
//*                                                                 *   FILE 763
//*      50        60                                               *   FILE 763
//*      -+----+----+----+---    (ISPF stats are optional)          *   FILE 763
//*      -00012-00000-CBT-474                                       *   FILE 763
//*                   userid                                        *   FILE 763
//*                                                                 *   FILE 763
//*     ---------------------------------------------------------   *   FILE 763
//*                                                                 *   FILE 763
//*     SHOWMACS - Included to make this file self-contained.       *   FILE 763
//*                                                                 *   FILE 763
//*       This is a macro library that documents the layout of      *   FILE 763
//*       many undocumented IBM control blocks.  Many of these      *   FILE 763
//*       layouts were figured out by guesswork.  This version      *   FILE 763
//*       of SHOWMACS comes from CBT Tape File 492, and it          *   FILE 763
//*       corresponds to Version 7.15 of the SHOWzOS program.       *   FILE 763
//*       (Thanks to Gilbert Saint-flour, Roland Schiradin,         *   FILE 763
//*       and many others, for doing the research necessary.)       *   FILE 763
//*                                                                 *   FILE 763
```

