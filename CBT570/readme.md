```
//***FILE 570 is dedicated to MVS TIPS and TRICKS which people      *   FILE 570
//*           have sent in.  We need a place to hold miscellaneous  *   FILE 570
//*           MVS advice, and here it is....                        *   FILE 570
//*                                                                 *   FILE 570
//*           This is meant to be an ongoing, expanding file,       *   FILE 570
//*           with contributions coming in from a lot of people     *   FILE 570
//*           (hopefully).                                          *   FILE 570
//*                                                                 *   FILE 570
//*           PLEASE SEND YOUR OWN CONTRIBUTIONS TO THIS FILE,      *   FILE 570
//*                                                                 *   FILE 570
//*              to email:   sbgolob@attglobal.net                  *   FILE 570
//*                                                                 *   FILE 570
//*           Queries about this file should be sent to Sam Golob,  *   FILE 570
//*           at this email address.                                *   FILE 570
//*                                                                 *   FILE 570
//*  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  *   FILE 570
//*                                                                 *   FILE 570
//*               M V S   T I P S   A N D   T R I C K S             *   FILE 570
//*                                                                 *   FILE 570
//*    List of tips and tricks available so far (by member name):   *   FILE 570
//*                                                                 *   FILE 570
//*    BATISPF  - from Roy Gardiner - hints as to how to run ISPF   *   FILE 570
//*               in batch.                                         *   FILE 570
//*                                                                 *   FILE 570
//*    CLEARSPL - from Dan Schwarz - sometimes "dead jobs" can      *   FILE 570
//*               accumulate and fill up JES2 spool space.  Here's  *   FILE 570
//*               how to look for these jobs, and get rid of them.  *   FILE 570
//*                                                                 *   FILE 570
//*               If your JES2 spool is short on track groups,      *   FILE 570
//*               you should definitely look at this suggestion.    *   FILE 570
//*                                                                 *   FILE 570
//*    DUMPCONC - Here's a way to get concurrent dumps from all     *   FILE 570
//*               or several LPARs in a SYSPLEX.                    *   FILE 570
//*                                                                 *   FILE 570
//*    HOWTO    - A very comprehensive collection of jobs which     *   FILE 570
//*               create most of a z/OS 1.4 system.  Use as a       *   FILE 570
//*               reference to look at, when you need to do         *   FILE 570
//*               something (like, for example, enlarging a RACF    *   FILE 570
//*               database, or allocating a new version of one      *   FILE 570
//*               of the system datasets) which you want to do      *   FILE 570
//*               properly.                                         *   FILE 570
//*                                                                 *   FILE 570
//*    JESJOBNO - Code to get the JES job number.                   *   FILE 570
//*                                                                 *   FILE 570
//*    LOGONREX - How to use a REXX exec (instead of a CLIST) for   *   FILE 570
//*               a 'Logon CLIST".                                  *   FILE 570
//*                                                                 *   FILE 570
//*    PERSAUTH - How to authorize certain TSO commands, only for   *   FILE 570
//*               your own TSO sessions, and not for the other      *   FILE 570
//*               folks at your installation.  It is built on a     *   FILE 570
//*               secret, undocumented TSO principle, which is      *   FILE 570
//*               described here.                                   *   FILE 570
//*                                                                 *   FILE 570
//*    SHOWMACS - Get this from File 492.  There are lots of        *   FILE 570
//*               undocumented control block mappings here.         *   FILE 570
//*                                                                 *   FILE 570
//*    SSH      - Some hints as to how to get sshd to work under    *   FILE 570
//*               UNIX services.                                    *   FILE 570
//*                                                                 *   FILE 570
//*    SYSDOCB  - Miscellaneous facts about MVS, received from      *   FILE 570
//*               Bruce Bordonaro, representing things he had to    *   FILE 570
//*               do in the past, and he has written down how to    *   FILE 570
//*               do them.  There are some undocumented ways of     *   FILE 570
//*               finding MVS control block information here and    *   FILE 570
//*               there are many other useful tidbits.              *   FILE 570
//*                  ** --  Interesting Reading  -- **              *   FILE 570
//*                                                                 *   FILE 570
//*    THORNTON - A very large collection of "how to do stuff"      *   FILE 570
//*               from Dick Thornton.  This is basically his        *   FILE 570
//*               MEMORY member from CBT Tape File 564.  It has     *   FILE 570
//*               been included here, because that's what this      *   FILE 570
//*               file is basically about:  a collection of         *   FILE 570
//*               miscellaneous "how to do stuff" things.           *   FILE 570
//*               Some of this material refers to Dick's other      *   FILE 570
//*               files:  CBT Tape Files 558 thru 565.              *   FILE 570
//*                                                                 *   FILE 570
//*    UPARMLIB - How to set up an MVS operating system that        *   FILE 570
//*               uses your own "user PARMLIB".  From Dave          *   FILE 570
//*               Kulas.                                            *   FILE 570
//*                                                                 *   FILE 570

```
