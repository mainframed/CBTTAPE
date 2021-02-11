```
//***FILE 446 is from John McKown and contains a COBOL program      *   FILE 446
//*           which uses OS/390 UNIX services.  It's good to have   *   FILE 446
//*           a program like this, for a coding example.            *   FILE 446
//*                                                                 *   FILE 446
//*     email:   "McKown, John" <john.archie.mckown@GMAIL.com>      *   FILE 446
//*                                                                 *   FILE 446
//*     This program is a small example (341 lines of code) of      *   FILE 446
//*     how to use COBOL to write an OS/390 UNIX System Services    *   FILE 446
//*     program. The program uses the BPX1WRT subroutine to         *   FILE 446
//*     write to STDOUT. It uses this interface to write the        *   FILE 446
//*     UNIX parameters (like C's argc and argv).  It also uses     *   FILE 446
//*     that interface to write out the currently set               *   FILE 446
//*     environment variables.  For example:                        *   FILE 446
//*                                                                 *   FILE 446
//*     ./UNIX0002 arg1 arg2 arg3                                   *   FILE 446
//*                                                                 *   FILE 446
//*     would result in output such as:                             *   FILE 446
//*                                                                 *   FILE 446
//*     NUMBER OF ARGUMENT IS: 4                                    *   FILE 446
//*     ARGCÝ 000¨=./UNIX0002                                       *   FILE 446
//*     ARGCÝ 001¨=arg1                                             *   FILE 446
//*     ARGCÝ 002¨=arg2                                             *   FILE 446
//*     ARGCÝ 003¨=arg3                                             *   FILE 446
//*                                                                 *   FILE 446
//*     NUMBER OF ENVIRONMENT VARIABLES IS: 3                       *   FILE 446
//*     ENVÝ 000¨=VAR1=VALUE1                                       *   FILE 446
//*     ENVÝ 001¨=VAR2=VALUE2                                       *   FILE 446
//*     ENVÝ 002¨=VAR3=VALUE3                                       *   FILE 446
//*                                                                 *   FILE 446
//*     This is a single, COBOL source program.                     *   FILE 446
//*                                                                 *   FILE 446

```
