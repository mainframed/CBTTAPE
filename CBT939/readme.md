```
//***FILE 939 is from Ze'ev Atlas and contains a port of the        *   FILE 939
//*           PCRE2 (Perl-Compatible Regular Expressions) product   *   FILE 939
//*           to z/OS, a later release of PCRE.                     *   FILE 939
//*                                                                 *   FILE 939
//*       - - - - - - - - - - - - - - - - - - - - - - - - - - - -   *   FILE 939
//*                                                                 *   FILE 939
//*          (This note pertains to PCRE release 10.35)             *   FILE 939
//*                                                                 *   FILE 939
//*          Please see the documents:                              *   FILE 939
//*          EBCDIC_Horror.txt    member $EBCDIC                    *   FILE 939
//*          REXXAPI.txt          member REXXAPI                    *   FILE 939
//*                                                                 *   FILE 939
//*       - - - - - - - - - - - - - - - - - - - - - - - - - - - -   *   FILE 939
//*                                                                 *   FILE 939
//*        This distribution is an interim release of PCRE 10.35.   *   FILE 939
//*                                                                 *   FILE 939
//*       - - - - - - - - - - - - - - - - - - - - - - - - - - - -   *   FILE 939
//*                                                                 *   FILE 939
//*           If you are using code-page 1047 (common in the        *   FILE 939
//*           U.S.), a quick install is being presented here, in    *   FILE 939
//*           the form of 6 XMIT-format files.  These need to be    *   FILE 939
//*           RECEIVE'd under TSO, and they will be almost ready    *   FILE 939
//*           to go.  You still need to read the documentation      *   FILE 939
//*           on the PC (and the member PCRE2DOC).                  *   FILE 939
//*                                                                 *   FILE 939
//*           It is very important to read member $$NOTE01, which   *   FILE 939
//*           will explain what to do if you need other code pages. *   FILE 939
//*                                                                 *   FILE 939
//*           Port is of PCRE Version 10.35, known as PCRE2.        *   FILE 939
//*                                                                 *   FILE 939
//*           Current release is marked with ISPF statistics        *   FILE 939
//*                as 10.35A.                                       *   FILE 939
//*                                                                 *   FILE 939
//*           Please read all members named $$NOTE**                *   FILE 939
//*                                                                 *   FILE 939
//*           email:  zatlas1@yahoo.com                             *   FILE 939
//*                                                                 *   FILE 939
//*           web site:  http://www.zaconsultants.net               *   FILE 939
//*                                                                 *   FILE 939
//*           PCRE info:  http://www.pcre.org  (please go there)    *   FILE 939
//*                                                                 *   FILE 939
//*     File Member Names:  (correspond to unzipped named files)    *   FILE 939
//*     ---- ------ -----                                           *   FILE 939
//*                                                                 *   FILE 939
//*     @FILE939 -  this file                                       *   FILE 939
//*     $$NOTE00 -  general introduction                            *   FILE 939
//*     $$NOTE01 -  what to do if you need other code pages         *   FILE 939
//*     $$NOTE06 -  note about release 10.34                        *   FILE 939
//*     PCRE2DOC -  text documentation for the package (EBCDIC)     *   FILE 939
//*     ASM      -  pcre2.asmlib.xmi                                *   FILE 939
//*     CNTL     -  pcre2.cntllib.xmi                               *   FILE 939
//*     COB      -  pcre2.cob.xmi                                   *   FILE 939
//*     JCL      -  pcre2.jcllib.xmi                                *   FILE 939
//*     LICENCE  -  licence.txt                                     *   FILE 939
//*     LOADLIB  -  pcre2.loadlib.xmi                               *   FILE 939
//*     SRCE     -  pcre2.srce.xmi                                  *   FILE 939
//*     TESTLIB  -  pcre2.testlib.xmi                               *   FILE 939
//*                                                                 *   FILE 939
//*     Short description:                                          *   FILE 939
//*     ----- -----------                                           *   FILE 939
//*     Regular Expressions is a technology that allows text        *   FILE 939
//*     search and manipulation in ways that go above and           *   FILE 939
//*     beyond what is known even to extreme Rexx programmers.      *   FILE 939
//*     The lack of Regular Expressions in COBOL contrasts with     *   FILE 939
//*     their availability in Perl and Java and is always           *   FILE 939
//*     frustrating to me.  Thus, I decided to port a Regular       *   FILE 939
//*     Expressions library and make it available on native         *   FILE 939
//*     z/OS.  I chose the pcre2 which is considered to be the      *   FILE 939
//*     best publicly available such library in that it is          *   FILE 939
//*     compatible with the standard bearer, Perl.  pcre2 is        *   FILE 939
//*     used in PHP and other projects.                             *   FILE 939
//*                                                                 *   FILE 939
//*     This is the fifteenth version and is compatible with        *   FILE 939
//*     pcre2 10.35. The package is distributed as Open Source,     *   FILE 939
//*     as is with no warranty and under the BSD license that       *   FILE 939
//*     is pretty open and non-limiting.                            *   FILE 939
//*                                                                 *   FILE 939

```
