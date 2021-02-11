
## @FILE760.txt
```
//***FILE 760 is from Ken Tomiak and is collection of PC and z/OS   *   FILE 760
//*           based tools geared for both novices and gurus         *   FILE 760
//*           alike. A good portion of the collection is geared     *   FILE 760
//*           towards transporting data from one platform to the    *   FILE 760
//*           other using FTP at some point.  The bulk of this      *   FILE 760
//*           work was compiled or written by:                      *   FILE 760
//*                                                                 *   FILE 760
//*     email:  "Kenneth E Tomiak"<CBT_Ken@KTomiak.biz>             *   FILE 760
//*     AOL IM: KenTomiak                                           *   FILE 760
//*                                                                 *   FILE 760
//*     Never, never, never run anything you have not examined!     *   FILE 760
//*     -------------------------------------------------------     *   FILE 760
//*                                                                 *   FILE 760
//*     Note from Sam Golob:  Since it is very soon before SHARE,   *   FILE 760
//*        and since some of these items are PC-based, whereas      *   FILE 760
//*        others are z/OS based, I have packaged this file,        *   FILE 760
//*        temporarily, as a zip file.  In order to use this        *   FILE 760
//*        package, the best way is probably to FTP the member      *   FILE 760
//*        $$$ZIP back to a PC, unzip it there, and follow Ken's    *   FILE 760
//*        directions on the PC.                                    *   FILE 760
//*                                                                 *   FILE 760
//*        Without promising, I'll try to repackage this file       *   FILE 760
//*        later, so that at least the z/OS parts will not have     *   FILE 760
//*        to be reloaded to a PC.                                  *   FILE 760
//*                                                                 *   FILE 760
//*        ----------------------------------------------------     *   FILE 760
//*        THE AUTHORITATIVE VERSION OF THIS FILE IS ALWAYS THE     *   FILE 760
//*        $$$ZIP MEMBER!!!!!                                       *   FILE 760
//*        ----------------------------------------------------     *   FILE 760
//*                                                                 *   FILE 760
//*     STANDARD GLOBAL DISCLAIMER                                  *   FILE 760
//*     ==========================                                  *   FILE 760
//*     The author explicitly disavows any claim whatsoever about   *   FILE 760
//*     the correctness or functionality of these files, and        *   FILE 760
//*     disclaims liability for anything and everything bad that    *   FILE 760
//*     might happen in connection with, before, during, or after   *   FILE 760
//*     using it. I have tried to make it work right, and I am      *   FILE 760
//*     personally pretty confident that it does, but everybody     *   FILE 760
//*     makes mistakes, so if you use it, you do so at your own     *   FILE 760
//*     risk.                                                       *   FILE 760
//*                                                                 *   FILE 760
//*     Note: Member/file lists are not in ascending sequence. I    *   FILE 760
//*           tried to list objects in the sequence you ought to    *   FILE 760
//*           review them and then near related entities. So, if    *   FILE 760
//*           B calls A, then B is listed first and then A. And     *   FILE 760
//*           then in ascending EBCDIC sequence. My sympathy if     *   FILE 760
//*           that is too hard for you to follow.                   *   FILE 760
//*                                                                 *   FILE 760
//* =============================================================== *   FILE 760
//* =============================================================== *   FILE 760
//*                                                                 *   FILE 760
//* PC-based                                                        *   FILE 760
//*                                                                 *   FILE 760
//*     ..\     - The directory you unzipped this to.               *   FILE 760
//*     =============================================               *   FILE 760
//*                                                                 *   FILE 760
//*     Never, never, never run anything you have not examined!     *   FILE 760
//*     -------------------------------------------------------     *   FILE 760
//*                                                                 *   FILE 760
//*       add2path - Add %USERPROFILE%\DOSBAT to the front of       *   FILE 760
//*                  PATH.  That is where I expect you will         *   FILE 760
//*                  place the bat files, but you can add them      *   FILE 760
//*                  anywhere your PATH will find them.             *   FILE 760
//*                                                                 *   FILE 760
//*       Each z/OS oriented collection is both a sub-directory     *   FILE 760
//*       and:                                                      *   FILE 760
//*                                                                 *   FILE 760
//*       *.BAT - A DOS bat file to upload an IEBUPDTE stream.      *   FILE 760
//*       *.JCL - JCL to process an IEBUPDTE stream.                *   FILE 760
//*       *.SEQ - The IEBUPDTE stream.                              *   FILE 760
//*                                                                 *   FILE 760
//*     BACKUPS - A sub-directory for FTP to download to.           *   FILE 760
//*     =================================================           *   FILE 760
//*                                                                 *   FILE 760
//*       $$$INDEX - One liner about the files in the               *   FILE 760
//*       sub-directory.                                            *   FILE 760
//*                                                                 *   FILE 760
//*     DOSBAT  - A collection of BAT files for using FTP.          *   FILE 760
//*     ==================================================          *   FILE 760
//*                                                                 *   FILE 760
//*     Never, never, never run anything you have not examined!     *   FILE 760
//*     -------------------------------------------------------     *   FILE 760
//*                                                                 *   FILE 760
//*       $$README - Explains more about the contents in this       *   FILE 760
//*                  sub-dir.                                       *   FILE 760
//*                                                                 *   FILE 760
//*       $$$INDEX - One liner about the files in the               *   FILE 760
//*                  sub-directory.                                 *   FILE 760
//*                                                                 *   FILE 760
//*       BAT - To help search fro BAT files, pass it a             *   FILE 760
//*             drive:\path argument and it will dir *.BAT files    *   FILE 760
//*             for you.  Handy when you know where your BAT        *   FILE 760
//*             files are but can not remember the exact name of    *   FILE 760
//*             one to use.                                         *   FILE 760
//*                                                                 *   FILE 760
//*       DIR2UPDT - DOS bat file to call MBR2UPDT to build and     *   FILE 760
//*                  IEBUPDTE stream, sans ISPF like statistics.    *   FILE 760
//*                                                                 *   FILE 760
//*       MBR2UPDT - DOS bat file to append a single file into      *   FILE 760
//*                  the IEBUPDTE stream, sans ISPF like            *   FILE 760
//*                  statistics.                                    *   FILE 760
//*                                                                 *   FILE 760
//*       OOREXX - My BAT file (JCL like) method to let the bat     *   FILE 760
//*                file take care of knowing where Open Object      *   FILE 760
//*                REXX is located and where my REXX source is.     *   FILE 760
//*                                                                 *   FILE 760
//*       PARMS* - Some BAT files that convert arguments to         *   FILE 760
//*                upper and lowercase. Plus an IVP to see if it    *   FILE 760
//*                works. Non-MVS systems may be case sensitive.    *   FILE 760
//*                I forced my sub-directories on one to be         *   FILE 760
//*                upper case and called PARMSUP to make sure my    *   FILE 760
//*                CD command was upper case.                       *   FILE 760
//*                                                                 *   FILE 760
//*       HOSTDEFAULT - Copy this starter to as many                *   FILE 760
//*                     HOSThostname.bat files as you have hosts    *   FILE 760
//*                     to connect to. Each one will contain the    *   FILE 760
//*                     userid and password for that host. Other    *   FILE 760
//*                     FTP settings can be configured as well.     *   FILE 760
//*                                                                 *   FILE 760
//*       HOSTIBM - Update with your email address and II13288      *   FILE 760
//*                 will be ready to download some tools from       *   FILE 760
//*                 IBM. Have your HOST* file set and it will       *   FILE 760
//*                 also upload them.                               *   FILE 760
//*                                                                 *   FILE 760
//*       FTPSETCONFIG - Sets which HOST* bat file will be          *   FILE 760
//*                      called by other FTP*.bat files. You can    *   FILE 760
//*                      switch HOST information, USERID and        *   FILE 760
//*                      PASSWORD, in this manner.                  *   FILE 760
//*                                                                 *   FILE 760
//*       FTPSETATTRIBUTES - Called by the FTP* bat files to add    *   FILE 760
//*                          quote site sub-commands that           *   FILE 760
//*                          influence new dataset allocations      *   FILE 760
//*                          and some translation specific          *   FILE 760
//*                          features. All of the options are set   *   FILE 760
//*                          in your HOST* file and activated       *   FILE 760
//*                          using the FTPSETCONFIG file.           *   FILE 760
//*                                                                 *   FILE 760
//*       FTPIVP - Tests if you set everything up. It will create   *   FILE 760
//*                a PDSE, load some members, submit a JOB to       *   FILE 760
//*                IEBCOPY backup the PDS to a sequential           *   FILE 760
//*                dataset, download the backup, upload it as a     *   FILE 760
//*                new name, then submit a job to restore into a    *   FILE 760
//*                new PDS.                                         *   FILE 760
//*                                                                 *   FILE 760
//*       II13288 - Logs on to ftp.software.ibm.com and downloads   *   FILE 760
//*                 some tools using both the HOSTIBM file and      *   FILE 760
//*                 one that you configured for your host and set   *   FILE 760
//*                 using FTPSETCONFIG.                             *   FILE 760
//*                                                                 *   FILE 760
//*       FTP*GET* - Assorted flavors for getting one or more       *   FILE 760
//*                  files.                                         *   FILE 760
//*                                                                 *   FILE 760
//*       FTP*PUT* - Assorted flavors for putting one or more       *   FILE 760
//*                  files.                                         *   FILE 760
//*                                                                 *   FILE 760
//*       FTPLOGIN - Login to an FTO server and turn the reigns     *   FILE 760
//*                  over.                                          *   FILE 760
//*                                                                 *   FILE 760
//*       FTPCD*   - Login, change to the sub-directory.            *   FILE 760
//*                                                                 *   FILE 760
//*       FTPBACKUP - Submit a special backup job that creates      *   FILE 760
//*                   IEBUPDTE streams and/or TRANSMIT files, try   *   FILE 760
//*                   to wait for the job to complete, and then     *   FILE 760
//*                   downlaod the files.                           *   FILE 760
//*                                                                 *   FILE 760
//*       FTPBKUP  - Sample job to create IEBUPDTE streams or XMIT  *   FILE 760
//*                  files.                                         *   FILE 760
//*                                                                 *   FILE 760
//*       IEBBKUP  - Sample job to backup a PDS if you run FTPIVP.  *   FILE 760
//*                                                                 *   FILE 760
//*       IEBREST  - Sample job to restore a PDS if you run FTPIVP. *   FILE 760
//*                                                                 *   FILE 760
//*       FTPDOWNLOAD - Picks up when FTPBACKUP can not wait.       *   FILE 760
//*                                                                 *   FILE 760
//*       FTPCANCEL - Various ways to submit a cancel tso user if   *   FILE 760
//*                   your tn3270 session failed and RECONNECT      *   FILE 760
//*                   fails.                                        *   FILE 760
//*                                                                 *   FILE 760
//*       FTPMKDIR - Create a new dataset using attributes from     *   FILE 760
//*                  your HOSTÝhostname) bat file.                  *   FILE 760
//*                                                                 *   FILE 760
//*       FTPSCRIPT - Blindly execute your prepared script of FTP   *   FILE 760
//*                   sub-commands. And a sample script. II13288    *   FILE 760
//*                   may also give you ideas.                      *   FILE 760
//*                                                                 *   FILE 760
//*       FTPSUBMIT - Submits a job from your PDS and waits for     *   FILE 760
//*                   it to complete. Downloads a copy of the       *   FILE 760
//*                   output to your PC.                            *   FILE 760
//*                                                                 *   FILE 760
//*     DOSDATA - A sub-directory used for data.                    *   FILE 760
//*     ========================================                    *   FILE 760
//*                                                                 *   FILE 760
//*       $$$INDEX - One liner about the files in the               *   FILE 760
//*                  sub-directory.                                 *   FILE 760
//*                                                                 *   FILE 760
//*       FTPCHRBN - 256 Character set in PC binary format.         *   FILE 760
//*                                                                 *   FILE 760
//*       FTPCHRMF - 256 Character set in z/OS EBCDIC format.       *   FILE 760
//*                                                                 *   FILE 760
//*       FTPCHRPC - 256 Character set in PC 8 bit ASCII format.    *   FILE 760
//*                                                                 *   FILE 760
//*       URLCHECK - List of urls checked for changed by REXX       *   FILE 760
//*                  program by the same name.                      *   FILE 760
//*                                                                 *   FILE 760
//*     DOSPERL - Activestate perl programs.                        *   FILE 760
//*     ====================================                        *   FILE 760
//*                                                                 *   FILE 760
//*       $$$INDEX - One liner about the files in the               *   FILE 760
//*                  sub-directory.                                 *   FILE 760
//*                                                                 *   FILE 760
//*       UPDT2HTML - Convert an IEBUPDTE stream into web pages.    *   FILE 760
//*                                                                 *   FILE 760
//*     DOSREXX - Open Object REXX programs.                        *   FILE 760
//*     ====================================                        *   FILE 760
//*                                                                 *   FILE 760
//*       $$$INDEX - One liner about the files in the               *   FILE 760
//*                  sub-directory.                                 *   FILE 760
//*                                                                 *   FILE 760
//*       ASC2EBC  - Convert an 8-bit ASCII file to EBCDIC.         *   FILE 760
//*                                                                 *   FILE 760
//*       EBC2ASC  - Convert an EBCDIC file to 8-bit ASCII.         *   FILE 760
//*                                                                 *   FILE 760
//*       CHARGRID - Create a 16x16 grid of 256 characters.         *   FILE 760
//*                                                                 *   FILE 760
//*       DIR2UPDT - Convert a directory into an IEBUPDTE stream    *   FILE 760
//*                  with ISPF like statistics.                     *   FILE 760
//*                                                                 *   FILE 760
//*       IVS2DIR  - Read an IEBCOPY unload dataset and extract     *   FILE 760
//*                  members int individual files.                  *   FILE 760
//*                                                                 *   FILE 760
//*       KETRECV  - RECEIVE like process to read the output of a   *   FILE 760
//*                  TRANSMIT command. PDS members are extracted in *   FILE 760
//*                  8-bit ASCII and EBCDIC format. Just in case    *   FILE 760
//*                  somebody embdedded a TRANSMIT file as a        *   FILE 760
//*                  member.                                        *   FILE 760
//*                                                                 *   FILE 760
//*       KETUPDTE - Ken's REXX way to read an IEBUPDTE stream and  *   FILE 760
//*                  populate a sub-directory. ISPF statistics are  *   FILE 760
//*                  written to a report file.                      *   FILE 760
//*                                                                 *   FILE 760
//*       XMI2INM  - The first half of KETRECV, read the transmit   *   FILE 760
//*                  file and store the internal format as a PC     *   FILE 760
//*                  file. The second half might be IVS2DIR.        *   FILE 760
//*                                                                 *   FILE 760
//*       XMITINFO - David Alcock code to show TRANSMIT file        *   FILE 760
//*                  headers.                                       *   FILE 760
//*                                                                 *   FILE 760
//*     HTML    - IEBUPDTE stream converted to web pages.           *   FILE 760
//*     =================================================           *   FILE 760
//*                                                                 *   FILE 760
//*       ZOSJCL.SEQ.html - Main page of JCL snippets.              *   FILE 760
//*                                                                 *   FILE 760
//*       ZOSUTIL.SEQ.html - Main page of Utility samples.          *   FILE 760
//*                                                                 *   FILE 760
//*     IEBUPDTE - Each directory bundled and ready for IEBUPDTE.   *   FILE 760
//*     =========================================================   *   FILE 760
//*                                                                 *   FILE 760
//*     Batch Oriented                                              *   FILE 760
//*     --------------                                              *   FILE 760
//*                                                                 *   FILE 760
//*       CNTL.*     - JCL to prepare and run programs.             *   FILE 760
//*                                                                 *   FILE 760
//*       PROCLIB.*  - Sample PROCedures for preparing and          *   FILE 760
//*                    running code.                                *   FILE 760
//*                                                                 *   FILE 760
//*       SRCLIB.*   - Sample programs that need to be prepared.    *   FILE 760
//*                                                                 *   FILE 760
//*       OBJLIB.*   - Sample programs in object format.            *   FILE 760
//*                                                                 *   FILE 760
//*       EXELIB.*   - Sample programs in executable load module    *   FILE 760
//*                    format.                                      *   FILE 760
//*                                                                 *   FILE 760
//*       PARMLIB.*  - Examples of extending the use of PARMLIB.    *   FILE 760
//*                                                                 *   FILE 760
//*       DATA.*     - Data used or produced by programs.           *   FILE 760
//*                                                                 *   FILE 760
//*       ZOSJCL.*   - Snippets of JCL.                             *   FILE 760
//*                                                                 *   FILE 760
//*       ZOSUTIL.*  - Examples of many Utilities to get started    *   FILE 760
//*                    with.                                        *   FILE 760
//*                                                                 *   FILE 760
//*     TSO/ISPF Oriented                                           *   FILE 760
//*     -----------------                                           *   FILE 760
//*                                                                 *   FILE 760
//*       CONFIG.*   - The output from ISRCONFG.                    *   FILE 760
//*                                                                 *   FILE 760
//*       CLIST.*    - TSO Command Procedures.                      *   FILE 760
//*                                                                 *   FILE 760
//*       MSGS.*     - ISPF messages.                               *   FILE 760
//*                                                                 *   FILE 760
//*       PANELS.*   - ISPF panels.                                 *   FILE 760
//*                                                                 *   FILE 760
//*       SKELS.*    - ISPF skeletons.                              *   FILE 760
//*                                                                 *   FILE 760
//*       REXX.*     - Sample REXX code.                            *   FILE 760
//*                                                                 *   FILE 760
//*       SHELL.*    - Sample z/OS UNIX shell scripts.              *   FILE 760
//*                                                                 *   FILE 760
//* =============================================================== *   FILE 760
//* =============================================================== *   FILE 760
//*                                                                 *   FILE 760
//* z/OS-based                                                      *   FILE 760
//* ==========                                                      *   FILE 760
//*                                                                 *   FILE 760
//*     CLIST   - Just a place holder for now.                      *   FILE 760
//*     ======================================                      *   FILE 760
//*                                                                 *   FILE 760
//*     CNTL    - JCL to run the code in this collection.           *   FILE 760
//*     =================================================           *   FILE 760
//*                                                                 *   FILE 760
//*       CONDCODE - IVP to check %CONDCODE which shows each        *   FILE 760
//*                  steps maximum condition code. Follows          *   FILE 760
//*                  control blocks.                                *   FILE 760
//*                                                                 *   FILE 760
//*       II13288  - Blind FTP script to download some IBM tools.   *   FILE 760
//*                                                                 *   FILE 760
//*       IPCSIVP  - Run IPCS in batch and demonstrate how to use   *   FILE 760
//*                  certain features.                              *   FILE 760
//*                                                                 *   FILE 760
//*       HX2PR    Convert input to two hexadecimal print lines.    *   FILE 760
//*       HX2PR$A  Assemble and link source.                        *   FILE 760
//*       HX2PR4   Convert input to four hexadecimal print lines.   *   FILE 760
//*       HX2PR4$A Assemble and link source.                        *   FILE 760
//*       PR2HX    Convert two print lines back to EBCDIC format.   *   FILE 760
//*       PR2HX$A  Assemble and link source.                        *   FILE 760
//*       PR42HX   Convert four print lines back to EBCDIC format.  *   FILE 760
//*       PR42HX$A Assemble and link source.                        *   FILE 760
//*                                                                 *   FILE 760
//*       PDSLOAD  IEBUPDTE alternative, preserves ISPF statistics. *   FILE 760
//*       PDSLOAD$ Link object deck.                                *   FILE 760
//*                                                                 *   FILE 760
//*       OBJ2HEX  - Sample JCL that shows multiple ways to run     *   FILE 760
//*                  OBJ2HEX to read a PDS member, in this example  *   FILE 760
//*                  an object deck for PDSLOAD. Then two ways to   *   FILE 760
//*                  run the self extracting REXX program.          *   FILE 760
//*                                                                 *   FILE 760
//*       URLCHECK - Run REXX program %URLCHECK to check if url     *   FILE 760
//*                  has been updated since last run. Build a web   *   FILE 760
//*                  page of those that have and update last        *   FILE 760
//*                  modified date.                                 *   FILE 760
//*                                                                 *   FILE 760
//*     CONFIG  - Sample ISRCONFG output.                           *   FILE 760
//*     =================================                           *   FILE 760
//*               Ought to be LRECL=80 but IBM blew it.             *   FILE 760
//*               Forced to be 255 for 80 byte data!                *   FILE 760
//*                                                                 *   FILE 760
//*               Just a place holder for now.                      *   FILE 760
//*                                                                 *   FILE 760
//*     DATA    - Data files used by the code in this collection.   *   FILE 760
//*     =========================================================   *   FILE 760
//*                                                                 *   FILE 760
//*       URLCHECK - List of urls program %URLCHECK will check if   *   FILE 760
//*                  they have been updated since the last run.     *   FILE 760
//*                                                                 *   FILE 760
//*     EXELIB  - Executable load modules.                          *   FILE 760
//*     ==================================                          *   FILE 760
//*                                                                 *   FILE 760
//*     MSGS    - Just a place holder for now.                      *   FILE 760
//*     ======================================                      *   FILE 760
//*                                                                 *   FILE 760
//*     OBJLIB  - Object decks.                                     *   FILE 760
//*     =======================                                     *   FILE 760
//*                                                                 *   FILE 760
//*       PDSLOAD  -   ORIGINAL PROGRAM FROM FILE 093               *   FILE 760
//*                                                                 *   FILE 760
//*         A sample object deck, (for the very useful              *   FILE 760
//*         IEBUPDTE-like program called PDSLOAD - CBT Tape File    *   FILE 760
//*         093), has been included here to test the system.        *   FILE 760
//*         Sample output from the SAMPJCL job is also included     *   FILE 760
//*         here. These are members PDSLOAD@, PDSLOAD#, and         *   FILE 760
//*         PDSLOAD$.                                               *   FILE 760
//*                                                                 *   FILE 760
//*         More about the PDSLOAD program itself ---               *   FILE 760
//*                                                                 *   FILE 760
//*         PDSLOAD will load a pds with members, starting from an  *   FILE 760
//*         IEBUPDTE-like sequential dataset, but it is possible to *   FILE 760
//*         preserve ISPF statistics too. See the layout below.     *   FILE 760
//*                                                                 *   FILE 760
//*         If you want to linkedit the PDSLOAD object deck to use  *   FILE 760
//*         the program for yourself, the LINK job is also          *   FILE 760
//*         included.                                               *   FILE 760
//*                                                                 *   FILE 760
//*         If you want to run the PDSLOAD program, the PDSLOJCL    *   FILE 760
//*         sample JCL, which makes a pds out of an IEBUPDTE-like   *   FILE 760
//*         ./ ADD NAME=memname                                     *   FILE 760
//*         input deck, provides a sample job. Input to the PDSLOAD *   FILE 760
//*         sample job is the SHOWMACS member.                      *   FILE 760
//*                                                                 *   FILE 760
//*       --------------------------------------------------------- *   FILE 760
//*                                                                 *   FILE 760
//*         Illustration of the layout of an ./ ADD NAME= card,     *   FILE 760
//*         input to PDSLOAD, which preserves the stated ISPF       *   FILE 760
//*         statistics:  This layout is produced by the OFFLOAD     *   FILE 760
//*         program in CBT Tape File 093 and PDS2UPDTE in this      *   FILE 760
//*         file.                                                   *   FILE 760
//*                                                                 *   FILE 760
//*    1       10        20        30        40        50        60 *   FILE 760
//*    +---+----+----+----+----+----+----+----+----+----+----+----+ *   FILE 760
//*    ./ ADD NAME=$$$#DATE 0474-07151-07151-0941-00012-00012-00000 *   FILE 760
//*                mbrname  vvmm crtdt moddt time currl initl modln *   FILE 760
//*                                                                 *   FILE 760
//*        50        60                                             *   FILE 760
//*        -+----+----+----+---    (ISPF stats are optional)        *   FILE 760
//*        -00012-00000-CBT-474                                     *   FILE 760
//*         initl modln userid                                      *   FILE 760
//*                                                                 *   FILE 760
//*     ---------------------------------------------------------   *   FILE 760
//*                                                                 *   FILE 760
//*     PANELS  - Just a place holder for now.                      *   FILE 760
//*     ======================================                      *   FILE 760
//*                                                                 *   FILE 760
//*     PARMLIB - A few sample PARMLIB members beyond the basics.   *   FILE 760
//*     =========================================================   *   FILE 760
//*                                                                 *   FILE 760
//*       CUNUNI00 - Shortest UNICODE on DEMAND entry I found       *   FILE 760
//*                  would prevent DB2 from loading much more and   *   FILE 760
//*                  still let z/OS load what is actually used.     *   FILE 760
//*                                                                 *   FILE 760
//*     PROCLIB - Procedures to eliminate duplicate JCL.            *   FILE 760
//*     ================================================            *   FILE 760
//*                                                                 *   FILE 760
//*       ASM2OBJ  - PROC to assemble and save OBJECT deck.         *   FILE 760
//*                                                                 *   FILE 760
//*       ASM2LMOD - PROC to assemble and link source to an LMOD.   *   FILE 760
//*                                                                 *   FILE 760
//*       OBJ2LMOD - PROC to link an OBJECT deck to an LMOD.        *   FILE 760
//*                                                                 *   FILE 760
//*       IEASYM00 - Set statements to simulate SYSTEM Symbolics.   *   FILE 760
//*                  Works best if you have this in a system unique *   FILE 760
//*                  JES accessible PROCLIB. One per system.        *   FILE 760
//*                  NOT SHARED.                                    *   FILE 760
//*                                                                 *   FILE 760
//*       TSOISPF  - PROC to allocate standard TSO and ISPF         *   FILE 760
//*                  datasets.                                      *   FILE 760
//*                                                                 *   FILE 760
//*     REXX    - REXX programs, EDIT macros.                       *   FILE 760
//*     =====================================                       *   FILE 760
//*                                                                 *   FILE 760
//*     Never, never, never run anything you have not examined!     *   FILE 760
//*     -------------------------------------------------------     *   FILE 760
//*                                                                 *   FILE 760
//*       ACEETRID - Follow control blocks to get your VTAM termid. *   FILE 760
//*                                                                 *   FILE 760
//*       AGE      - EDIT macro uses LMMCOPY to save the as-yet     *   FILE 760
//*                  unsaved member as a new name and keep ISPF     *   FILE 760
//*                  stats!                                         *   FILE 760
//*                                                                 *   FILE 760
//*       BATCHISP - Invoke ISPF and your application.              *   FILE 760
//*                                                                 *   FILE 760
//*       BUBLSORT - How to Bubble sort and entry in stem.          *   FILE 760
//*                                                                 *   FILE 760
//*       DDBYCBLK - Access allocated DDNAMEs by following control  *   FILE 760
//*                  blocks.                                        *   FILE 760
//*                                                                 *   FILE 760
//*       DDBYLSTA - Access allocated DDNAMEs by trapping LISTALC.  *   FILE 760
//*                                                                 *   FILE 760
//*       DDBYQLIB - Query if a DDNAME is allocated using ISPF      *   FILE 760
//*                  QBASELIB.                                      *   FILE 760
//*                                                                 *   FILE 760
//*       DDBYTSTR - REXX IVP code to test DDBYCBLK, DDBYLSTA, and  *   FILE 760
//*                  the poorly designed DDTRAP.                    *   FILE 760
//*                                                                 *   FILE 760
//*       DDTRAP   - Access DDNAMEs with a dataset by trapping      *   FILE 760
//*                  LISTALC.                                       *   FILE 760
//*                                                                 *   FILE 760
//*       HEX2OBJ  - Sample output from running OBJ2HEX against     *   FILE 760
//*                  an object deck. PDSLOAD in this instance.      *   FILE 760
//*                  The output from running this is a real         *   FILE 760
//*                  OBJECT deck suitable as input to IEWBLINK      *   FILE 760
//*                  (the linkage editor).                          *   FILE 760
//*                                                                 *   FILE 760
//*       HLQSPACE - Example of using ISPF LMDLIST to retrieve a    *   FILE 760
//*                  list of matching dataset names and summing     *   FILE 760
//*                  their space usage.                             *   FILE 760
//*                                                                 *   FILE 760
//*       IPCSIVP  - Invoke IPCS and demonstrate how to use         *   FILE 760
//*                  features of IPCS to do common activities.      *   FILE 760
//*                                                                 *   FILE 760
//*       JCLDSCB  - Retrieve data set control block information    *   FILE 760
//*                  and insert as comment lines.                   *   FILE 760
//*                                                                 *   FILE 760
//*       JOBCARD  - Insert a JOBCARD using an instream template.   *   FILE 760
//*                                                                 *   FILE 760
//*       OBJ2HEX  - Convert the input file into hexadecimal        *   FILE 760
//*                  format wrapped inside REXX code to be run on   *   FILE 760
//*                  the receiving end.                             *   FILE 760
//*                                                                 *   FILE 760
//*           OBJ2HEX is a REXX program that creates a self         *   FILE 760
//*           extracting REXX program with the input file           *   FILE 760
//*           embedded in comments. Each record of the input file   *   FILE 760
//*           is converted into two lines of printable data, in a   *   FILE 760
//*           format similar to ISPF HEX ON. This data is read by   *   FILE 760
//*           the self extracting program and converted back to     *   FILE 760
//*           the original values.                                  *   FILE 760
//*                                                                 *   FILE 760
//*           The self extracting program is comprised of           *   FILE 760
//*           standard characters, easily translated between        *   FILE 760
//*           EBCDIC and ASCII characters and back again.           *   FILE 760
//*                                                                 *   FILE 760
//*           This method might be used to accurately transport     *   FILE 760
//*           PTFs or object decks thru an ASCII system and back.   *   FILE 760
//*           It is not limited to binary data, you can use it on   *   FILE 760
//*           any type of data that might contain characters that   *   FILE 760
//*           require special conversion during file transfer.      *   FILE 760
//*                                                                 *   FILE 760
//*       PDS2UPDT - ISPF based command to append all members of    *   FILE 760
//*                  a PDS into a sequential IEBUPDTE stream with   *   FILE 760
//*                  ISPF stats on the control card, suitable for   *   FILE 760
//*                  PDSLOAD or REXUPDTE.                           *   FILE 760
//*                                                                 *   FILE 760
//*       PDS2XMIT - ISPF based front-end to the TRANSMIT           *   FILE 760
//*                  command. If run in the foreground it will      *   FILE 760
//*                  pop up a dynamically built panel allowing      *   FILE 760
//*                  overrides to the MESSAGES included in the      *   FILE 760
//*                  TRANSMIT file.                                 *   FILE 760
//*                                                                 *   FILE 760
//*       RACFINFO - Modified version of some Xephon published      *   FILE 760
//*                  code.  The enhancement (my opinion) removes    *   FILE 760
//*                  the GRINDD input file specifying CLASSES to    *   FILE 760
//*                  check. The output of a SETR LIST is trapped    *   FILE 760
//*                  and all ACTIVE classes are checked.            *   FILE 760
//*                                                                 *   FILE 760
//*       REXUPDTE - Read an IEBUPDTE stream and populate a PDS     *   FILE 760
//*                  preserving the ISPF statistics if present on   *   FILE 760
//*                  the control card.                              *   FILE 760
//*                                                                 *   FILE 760
//*       REXXUSS  - A sample IVP program to use several z/OS UNIX  *   FILE 760
//*                  features.                                      *   FILE 760
//*                                                                 *   FILE 760
//*       SDSFDISK - How to call SDSF from REXX to transfer JES2    *   FILE 760
//*                  output to a sequential disk file or pds        *   FILE 760
//*                  member.                                        *   FILE 760
//*                                                                 *   FILE 760
//*       TXT2STEM - Routine to parse a text string into stem       *   FILE 760
//*                  variables.  Real parsing, quoted text is a     *   FILE 760
//*                  single stem value.                             *   FILE 760
//*                                                                 *   FILE 760
//*       UPDREFDT - Use ISPF to touch datasets which causes the    *   FILE 760
//*                  last-reference date to be updated. Helps       *   FILE 760
//*                  prevent migrating datasets you want on DASD.   *   FILE 760
//*                                                                 *   FILE 760
//*       URLCHECK - Use TCP/IP Sockets to check if a url has       *   FILE 760
//*                  been updated since the last run. If so, add    *   FILE 760
//*                  it to a web page. This would be useful if      *   FILE 760
//*                  that web page was accessible to a web          *   FILE 760
//*                  server. This is a port of the PC based IBM     *   FILE 760
//*                  Object REXX code.                              *   FILE 760
//*                                                                 *   FILE 760
//*       VIEWHELP - Trap the output of a HELP command, write it    *   FILE 760
//*                  to disk, and then invoke VIEW so you can       *   FILE 760
//*                  scroll.                                        *   FILE 760
//*                                                                 *   FILE 760
//*       XMIT2PDS - Front end to RECEIVE, supplying an optional    *   FILE 760
//*                  output dataset name at the same time.          *   FILE 760
//*                                                                 *   FILE 760
//*       XYGRID   - Sample of using postive and negative           *   FILE 760
//*                  indexing to create a grid. Yes, you can use    *   FILE 760
//*                  negatives!                                     *   FILE 760
//*                                                                 *   FILE 760
//*     SHELL   - z/OS UNIX scripts.                                *   FILE 760
//*     ============================                                *   FILE 760
//*                                                                 *   FILE 760
//*     Never, never, never run anything you have not examined!     *   FILE 760
//*     -------------------------------------------------------     *   FILE 760
//*                                                                 *   FILE 760
//*       java5    - Sample of pre-pending the java5 sub-directory  *   FILE 760
//*                  names to the z/OS UNIX path.                   *   FILE 760
//*                                                                 *   FILE 760
//*     SKELS   - Just a place holder for now.                      *   FILE 760
//*     ======================================                      *   FILE 760
//*                                                                 *   FILE 760
//*     SRCLIB  - Assembler, COBOL, and other language source code. *   FILE 760
//*     =========================================================== *   FILE 760
//*                                                                 *   FILE 760
//*         HX2PR - Makes FB-80 Hex data printable in two lines     *   FILE 760
//*         PR2HX - Makes FB-80 Two Line printable data, into       *   FILE 760
//*                   one line Hex output                           *   FILE 760
//*                                                                 *   FILE 760
//*         HX2PR4 - Makes FB-80 Hex data printable in four lines   *   FILE 760
//*         PR42HX - Makes FB-80 Four Line printable data, into     *   FILE 760
//*                   one line Hex output                           *   FILE 760
//*                                                                 *   FILE 760
//*       --------------------------------------------------------  *   FILE 760
//*       Another system to do the conversion of the 80-byte card   *   FILE 760
//*       images to (the same) two lines of printable data. This    *   FILE 760
//*       consists of 2 Assembler programs.                         *   FILE 760
//*                                                                 *   FILE 760
//*       email: "Sam Golob"<sbgolob@attglobal.net>                 *   FILE 760
//*       or:  "Sam Golob"<sbgolob@cbttape.org>                     *   FILE 760
//*       --------------------------------------------------------  *   FILE 760
//*                                                                 *   FILE 760
//*     Option:                                                     *   FILE 760
//*                                                                 *   FILE 760
//*       If you want clearer displayable output, you can have it   *   FILE 760
//*       in 4 lines instead of 2. The following 2 programs add     *   FILE 760
//*       a line of purely printable data, plus a "ruler line" just *   FILE 760
//*       the way the ISPF HEX display does it. To reconstitute     *   FILE 760
//*       the original binary card-image, the PR42HX will do that,  *   FILE 760
//*       by ignoring the first two of the four lines in the        *   FILE 760
//*       display.                                                  *   FILE 760
//*                                                                 *   FILE 760
//*  Example:  4-line output (should be continued to 80 bytes)      *   FILE 760
//*                                                                 *   FILE 760
//*   ESD            PDSLOAD                                        *   FILE 760
//*  ----+----1----+----2----+----3----+----4----+----5----+----6-- *   FILE 760
//*  0CEC444444014400DCEDDCC40000001A444444444444444444444444444444 *   FILE 760
//*  25240000000000017423614000000090000000000000000000000000000000 *   FILE 760
//*   TXT             00  PDSLOAD 20070529  ANY LRECL OUT:  1:F,V-> *   FILE 760
//*  ----+----1----+----2----+----3----+----4----+----5----+----6-- *   FILE 760
//*  0EEE4000440344004FF51DCEDDCC4FFFFFFFF44CDE4DDCCD4DEE744F7C6E66 *   FILE 760
//*  2373000000080001700417423614020070529001580395330643A001A6B50E *   FILE 760
//*                                                                 *   FILE 760
//*  Example:  2-line output (should be continued to 80 bytes)      *   FILE 760
//*                                                                 *   FILE 760
//*  0CEC444444014400DCEDDCC40000001A444444444444444444444444444444 *   FILE 760
//*  25240000000000017423614000000090000000000000000000000000000000 *   FILE 760
//*  0EEE4000440344004FF51DCEDDCC4FFFFFFFF44CDE4DDCCD4DEE744F7C6E66 *   FILE 760
//*  2373000000080001700417423614020070529001580395330643A001A6B50E *   FILE 760
//*                                                                 *   FILE 760
//*                                                                 *   FILE 760
//*     ZOSJCL  - Basic JCL examples.                               *   FILE 760
//*     =============================                               *   FILE 760
//*                                                                 *   FILE 760
//*       $$$INDEX - List of JCL templates included.                *   FILE 760
//*                                                                 *   FILE 760
//*     ZOSUTIL - An ever expanding collection of UTILITY jobs.     *   FILE 760
//*     =======================================================     *   FILE 760
//*                                                                 *   FILE 760
//*     Never, never, never run anything you have not examined!     *   FILE 760
//*                                                                 *   FILE 760
//*       $$$INDEX - List of UTILITY samples included.              *   FILE 760
//*                                                                 *   FILE 760
//*     -------------------------------------------------------     *   FILE 760
//*                                                                 *   FILE 760
//* =============================================================== *   FILE 760
//* =============================================================== *   FILE 760
//*                                                                 *   FILE 760
```

