```
//***FILE 313 is from Lionel Dyck in Austin, Texas and contains     *   FILE 313
//*           quite a few ISPF interface packages, and other        *   FILE 313
//*           stuff.                                                *   FILE 313
//*                                                                 *   FILE 313
//*           The member list probably more accurately reflects     *   FILE 313
//*           the contents of this file, than does the description  *   FILE 313
//*           of some details, below.  This file is constantly      *   FILE 313
//*           being revised.  For reference, please see Lionel's    *   FILE 313
//*           web site at:   http://www.lbdsoftware.com             *   FILE 313
//*                                                                 *   FILE 313
//*           email:  lbdyck@gmail.com                              *   FILE 313
//*                                                                 *   FILE 313
//*    Lionel Dyck's large collection of utilities has now been     *   FILE 313
//*    divided between Files 312, 313, 314, and 969.  All member    *   FILE 313
//*    names beginning with A-R are on File 312.  Names beginning   *   FILE 313
//*    with S-TS are on File 313.  Names from TX-Z are on File      *   FILE 313
//*    314.  File 969 contains the PDSEGEN ISPF application to      *   FILE 313
//*    exploit the capabilities of using PDSE Version 2 member      *   FILE 313
//*    generations.                                                 *   FILE 313
//*                                                                 *   FILE 313
//*    These four files contain quite a few separate utility        *   FILE 313
//*    packages which are unrelated to each other.  You can tell    *   FILE 313
//*    which members of these files belong to the same utility      *   FILE 313
//*    package, by the similarities in their member names.          *   FILE 313
//*                                                                 *   FILE 313
//*    Some utility packages will have several member names         *   FILE 313
//*    associated with them.  But these should all be similar       *   FILE 313
//*    to each other, letting you know that they belong to the      *   FILE 313
//*    same utility package.  You can see this, by looking at       *   FILE 313
//*    the member list shown below, so you can get the idea         *   FILE 313
//*    about how this packaging arrangement works.                  *   FILE 313
//*                                                                 *   FILE 313
//*    Documentation files which are in WORD format, or PDF         *   FILE 313
//*    format, have been included to make the use of the package    *   FILE 313
//*    associated with the doc, easier.  Usually a doc file in      *   FILE 313
//*    FB-80 EBCDIC text, has been included too.  To use the        *   FILE 313
//*    WORD or PDF format documentation, you have to download the   *   FILE 313
//*    member in BINARY to a PC, and look at the resulting file     *   FILE 313
//*    on the PC, using Microsoft WORD, or Adobe ACROBAT reader,    *   FILE 313
//*    respectively.                                                *   FILE 313
//*                                                                 *   FILE 313
//*    DSN=CBT500.FILE313   (fairly up to date for Version 500)     *   FILE 313
//*                                                                 *   FILE 313
//*       NAME       VER.MOD   LAST MODIFIED     SIZE   ID          *   FILE 313
//*       $DOC        01.05   2014/03/23 09:11     14 SBGOLOB       *   FILE 313
//*       $SOFTPUB    01.01   2014/03/23 09:04     24 SBGOLOB       *   FILE 313
//*       SAVELAB     02.01   2020/02/08 17:28   1690 SAVELAB       *   FILE 313
//*       SDSFEXT     01.21   2018/05/18 10:19    751 SDSFEXT       *   FILE 313
//*       SDSFEXT#    01.20   2015/12/04 17:55   2069 PDF           *   FILE 313
//*       SDSFEXT@    01.20   2015/12/04 17:55    640 MSWORD        *   FILE 313
//*       SDSFEXTC    01.11   2015/12/04 13:01     51 SYSLBD        *   FILE 313
//*       SDSFPA$$    01.28   2003/04/28 08:57     19 SYSLBD        *   FILE 313
//*       SDSFPAG$    01.19   2001/02/20 10:52      9 SYSLBD        *   FILE 313
//*       SDSFPAG#    01.28   2003/04/28 08:57   4894 PDF           *   FILE 313
//*       SDSFPAG@    01.28   2003/04/28 08:57   5888 MSWORD        *   FILE 313
//*       SDSFPAGE    01.28   2003/04/28 08:57   1106 SYSLBD        *   FILE 313
//*       SDSFP119    01.19   2001/09/28 12:46    899 SYSLBD        *   FILE 313
//*       SDSFP19#    01.19   2001/09/06 23:44   1905 PDF           *   FILE 313
//*       SETCLIP     01.03   2019/02/07 06:44   1707 SETCLIP       *   FILE 313
//*       SETCLIP#    01.00   2016/11/06 21:28   5471 PDF           *   FILE 313
//*       SETCLIP@    01.00   2016/11/06 21:28    922 MSWORD        *   FILE 313
//*       SETCLIPP    01.00   2016/11/06 21:46   3204 POWERPT       *   FILE 313
//*       SHAREVAR    01.01   2020/07/04 15:18    673 SHAREV        *   FILE 313
//*       SLM         01.06   2006/11/10 08:00   5195 SYSLBD        *   FILE 313
//*       SLM$        01.06   2002/12/14 23:10     23 SYSLBD        *   FILE 313
//*       SLM#        01.06   2006/11/10 08:01   6872 PDF           *   FILE 313
//*       SLM@        01.06   2006/11/10 08:02   2586 MSWORD        *   FILE 313
//*       SLMCHANG    01.06   2006/11/10 07:57     82 SYSLBD        *   FILE 313
//*       SOFTPUB     01.00   2000/12/26 17:30  43974 SYSLBD        *   FILE 313
//*       SOFTPUB$    01.01   2014/03/23 09:04     24 SBGOLOB       *   FILE 313
//*       SPELLC      01.02   2020/01/26 08:53   7102 SPELLC        *   FILE 313
//*       SPELLC$     01.01   2004/11/04 23:44    199 SPELLC        *   FILE 313
//*       SPELLC$#    01.01   2004/11/04 23:44     37 SPELLC        *   FILE 313
//*       SPELLCHG    01.01   2020/01/26 08:31    266 SPELLC        *   FILE 313
//*       TERSE       01.00   2002/04/25 01:56    715 SYSLBD        *   FILE 313
//*       TMAILQRY    01.00   2000/04/05 16:34    399 SYSLBD        *   FILE 313
//*       TRYIT       03.02   2020/07/13 09:11   1452 TRYIT         *   FILE 313
//*       TRYIT$      02.02   2005/03/07 19:08    118 SYSLBD        *   FILE 313
//*       TSOEMAIL    01.00   2000/04/13 22:28   8120 SYSLBD        *   FILE 313
//*       TSOPROF     01.02   2018/02/09 10:31    541 LBD           *   FILE 313
//*       TSOTRAP     01.22   2016/07/14 09:05    135 SYSLBD        *   FILE 313
//*       TSOTRAP1    01.00   2000/02/16 16:55     30 OLD           *   FILE 313
//*       TSO8CHAR    01.03   2020/02/03 08:07     31 SLBD          *   FILE 313
//*       TUTORPRT    01.02   2020/03/14 11:10    226 TUTOR         *   FILE 313
//*       TXT2CSV     01.02   2017/06/29 13:03   1254 LBD           *   FILE 313
//*                                                                 *   FILE 313
//*                                                                 *   FILE 313
//*     Member SAVELAB                                              *   FILE 313
//*            *** Updated 02/08/2020 ***                           *   FILE 313
//*                                                                 *   FILE 313
//*     SAVELAB is an ispf edit macro that will save the labels     *   FILE 313
//*     used in the current edit member. This allows you to set     *   FILE 313
//*     labels and then restore them when you return to work on     *   FILE 313
//*     the member again later.                                     *   FILE 313
//*                                                                 *   FILE 313
//*     SAVELAB has the following parameter options:                *   FILE 313
//*                                                                 *   FILE 313
//*        No option - restore all saved labels                     *   FILE 313
//*        ERASE - Comletely erase the ALL saved labels for ALL     *   FILE 313
//*                members                                          *   FILE 313
//*        EXPORT - Save the saved labels in a PDS member           *   FILE 313
//*        FREE - Free saved labels for this member                 *   FILE 313
//*        HELP - Show this help info - alias is ?                  *   FILE 313
//*        IMPORT - Import the saved labels from a PDS member       *   FILE 313
//*        LIST - List all active labels in the data                *   FILE 313
//*        LISTS- Selection list of all active labels               *   FILE 313
//*        SAVE - Save all labels                                   *   FILE 313
//*        SHOW - Show the ISPF variable info on the saved labels   *   FILE 313
//*        SHOW ALL - Show all members with saved labels            *   FILE 313
//*        WHY  - Display reasons to use Edit Labels                *   FILE 313
//*                                                                 *   FILE 313
//*        Abbreviations are:  ERA, F, H, S, SH, EX, IM, W          *   FILE 313
//*                                                                 *   FILE 313
//*     SAVELAB saves the current dataset(member) as the            *   FILE 313
//*     key and then every label and associated record              *   FILE 313
//*     number in an ISPF variable. This variable is used           *   FILE 313
//*     for all saved labels and may not exceed 32K bytes           *   FILE 313
//*     (a warning message at 32,000 is issued).                    *   FILE 313
//*                                                                 *   FILE 313
//*     To use:                                                     *   FILE 313
//*     1. While in ISPF Edit, after having created labels,         *   FILE 313
//*     issue SAVELAB SAVE                                          *   FILE 313
//*     2. When returning to ISPF Edit, issue SAVELAB to            *   FILE 313
//*     restore all labels                                          *   FILE 313
//*     3. If SAVELAB used to restore labels or SAVELAB SAVE        *   FILE 313
//*     is issued then using PF3 (END) to end Edit will also        *   FILE 313
//*     issue the SAVELAB SAVE command before ending.               *   FILE 313
//*                                                                 *   FILE 313
//*     Note: If ISPF Edit is entered under a different ISPF        *   FILE 313
//*     Profile then the saved labels may not be the same,          *   FILE 313
//*     or even exist, as when using a different ISPF               *   FILE 313
//*     Profile.                                                    *   FILE 313
//*                                                                 *   FILE 313
//*     Member SDSFEXT                                              *   FILE 313
//*            - Updated 5/18/2018                                  *   FILE 313
//*                                                                 *   FILE 313
//*     SDSFEXT is a utility using the older, non-SDSF REXX,        *   FILE 313
//*     interface to SDSF.  It is designed to use SDSF to extract   *   FILE 313
//*     a specific DDname for every JOB in the spool that matches   *   FILE 313
//*     the specified jobname.  The extracted data is then placed   *   FILE 313
//*     into a pre-allocated dataset referenced by a DDname in      *   FILE 313
//*     the command.                                                *   FILE 313
//*                                                                 *   FILE 313
//*     EDITPAGE is a frontend to SDSFPAGE that is a more logical   *   FILE 313
//*     name than SDSFPAGE when used as a pure ISPF Edit command.   *   FILE 313
//*                                                                 *   FILE 313
//*     SDSFPAGE is a tool designed to be used with SDSF to browse, *   FILE 313
//*     print to sysout, print to a data set, or e-mail (using      *   FILE 313
//*     XMITIP) a page or range of pages from a job in the spool.   *   FILE 313
//*                                                                 *   FILE 313
//*     Member SETCLIP                                              *   FILE 313
//*            - Updated 2/7/19                                     *   FILE 313
//*                                                                 *   FILE 313
//*     SETCLIP is an ISPF Clipboard Manager                        *   FILE 313
//*                                                                 *   FILE 313
//*     SetClip will perform two functions depending on how it is   *   FILE 313
//*     invoked.                                                    *   FILE 313
//*                                                                 *   FILE 313
//*     Syntax:  %setclip option                                    *   FILE 313
//*                                                                 *   FILE 313
//*     Where option is:   blank     invokes the ISPF Dialog to     *   FILE 313
//*                                  define and setup the user      *   FILE 313
//*                                  clipboards                     *   FILE 313
//*                        non-blank to just setup the clipboards   *   FILE 313
//*                                                                 *   FILE 313
//*     When the option is blank an ISPF panel (setclipp) is        *   FILE 313
//*     displayed that allows the user to define up to 10 (the IBM  *   FILE 313
//*     default limit) Edit clipboards.                             *   FILE 313
//*                                                                 *   FILE 313
//*     Change the default # of clipboards in the ISPF Config       *   FILE 313
//*     option MAXIMUM_NUMBER_OF_EDIT_CLIPBOARDS.                   *   FILE 313
//*                                                                 *   FILE 313
//*     The panel requests both a clipboard name and the dataset, or*   FILE 313
//*     dataset(member), that contains the text that will be copied *   FILE 313
//*     into the clipboard. If the start and/or ending row numbers  *   FILE 313
//*     are not specified then all records will be copied into the  *   FILE 313
//*     clipboard.                                                  *   FILE 313
//*                                                                 *   FILE 313
//*     Member SHAREVAR                                             *   FILE 313
//*                                                                 *   FILE 313
//*        Updated 7/4/2020                                         *   FILE 313
//*                                                                 *   FILE 313
//*     A REXX Exec to pass REXX variables, including stems, to     *   FILE 313
//*     another REXX Exec which uses this routine to recreate       *   FILE 313
//*     all the passed variables.                                   *   FILE 313
//*                                                                 *   FILE 313
//*     Member SLM                                                  *   FILE 313
//*                                                                 *   FILE 313
//*     SLM or System Library Manager to provide the user with a    *   FILE 313
//*     list of the active system PARMLIB datasets and mebers to    *   FILE 313
//*     choose from.  Edit and Browse are supported with Save-to    *   FILE 313
//*     enabled to edit a member from one library and save it into  *   FILE 313
//*     another specific library (e.g. the first or second in the   *   FILE 313
//*     list).                                                      *   FILE 313
//*                                                                 *   FILE 313
//*     Member SPELLC                                               *   FILE 313
//*                                                                 *   FILE 313
//*     SPELLC is Spell Checker written as an ISPF Edit macro that  *   FILE 313
//*     is invoked on the ISPF Edit command line with or without    *   FILE 313
//*     any other parameters. It will immediately ask the user if   *   FILE 313
//*     they have their own dictionary.                             *   FILE 313
//*                                                                 *   FILE 313
//*     Member TERSE                                                *   FILE 313
//*                                                                 *   FILE 313
//*     TERSE is a package of 2 exec's. PACKDS and UNPACKDS that    *   FILE 313
//*     simplify using the IBM TERSE utility.                       *   FILE 313
//*                                                                 *   FILE 313
//*     Member TRYIT - Updated 07/13/2020 to V3.7                   *   FILE 313
//*                                                                 *   FILE 313
//*     TRYIT is an ISPF Edit command that is designed to be used   *   FILE 313
//*     to test an Assembler program, CLIST, REXX Exec, JCL, ISPF   *   FILE 313
//*     Panel or ISPF Skeleton while it is being edited. The way    *   FILE 313
//*     this works is such that the JCL, CLIST, REXX Exec, ISPF     *   FILE 313
//*     Panel, or ISPF Skeleton does *not* have to be in a library  *   FILE 313
//*     in the existing SYSPROC, SYSEXEC, ISPPLIB, or ISPSLIB       *   FILE 313
//*     allocations thus allowing the development and testing in    *   FILE 313
//*     other, less critical, data sets.                            *   FILE 313
//*                                                                 *   FILE 313
//*     If a JCL Syntax checking product is available then TRYIT    *   FILE 313
//*     can be used to invoke it - this is assuming the product     *   FILE 313
//*     can be invoked as an ISPF Edit Macro (e.g. CA-JCLCheck      *   FILE 313
//*     and JCLPrep).                                               *   FILE 313
//*                                                                 *   FILE 313
//*     For Assembler programs the active member will be assembled  *   FILE 313
//*     and optionally linkedited into a specified target library.  *   FILE 313
//*     After entering TRYIT the user will be prompted to enter     *   FILE 313
//*     the assembly and linkedit information if the member is      *   FILE 313
//*     determined to be an assembler program.                      *   FILE 313
//*                                                                 *   FILE 313
//*     For CLIST and REXX Exec members the active data set in      *   FILE 313
//*     which the member resides will be allocated using the TSO    *   FILE 313
//*     ALTLIB facility and then the member executed, along with    *   FILE 313
//*     any passed optional parameters.                             *   FILE 313
//*                                                                 *   FILE 313
//*     For ISPF Panels and ISPF Skeletons the active data set in   *   FILE 313
//*     which the member resides will be allocated using the ISPF   *   FILE 313
//*     LIBDEF facility then then the panel Displayed or Selected   *   FILE 313
//*     based upon the parameters provided to TRYIT. If there are   *   FILE 313
//*     any errors in the panel or skeleton an ISPF message will    *   FILE 313
//*     be displayed and the error may then be corrected using      *   FILE 313
//*     ISPF Edit and TRYIT used once again to verify the panel or  *   FILE 313
//*     skeleton - all without the need to split the screen and     *   FILE 313
//*     invoke ISPF Test.                                           *   FILE 313
//*                                                                 *   FILE 313
//*     Note there are limitations to the Skeleton testing as       *   FILE 313
//*     variables and imbed tables may not be available.            *   FILE 313
//*                                                                 *   FILE 313
//*     Because of the use of ALTLIB or LIBDEF the member being     *   FILE 313
//*     tested will be able to find subroutines or other ISPF       *   FILE 313
//*     Panels providing they reside within the data set being      *   FILE 313
//*     edited thus allowing an entire package to be developed,     *   FILE 313
//*     updated, and/or tested, in less critical libraries.         *   FILE 313
//*                                                                 *   FILE 313
//*     The type of member being edited is dynamically determined   *   FILE 313
//*     with a default of REXX Exec assumed if all the tests fail.  *   FILE 313
//*     The tests include:                                          *   FILE 313
//*                                                                 *   FILE 313
//*       1) The data set suffix                                    *   FILE 313
//*            clist = "CLIST SYSPROC CMDPROC"                      *   FILE 313
//*            rexx  = "REXX  SYSEXEC  EXEC"                        *   FILE 313
//*            asm   = "ASM   ASSEM"                                *   FILE 313
//*            jcl   = "JCL   CNTL"                                 *   FILE 313
//*            panel = "PANEL PANELS  ISPPLIB *PLIB *PENU *PDEU"    *   FILE 313
//*            skl   = "SKL  SKEL SKELS  ISPSLIB *SLIB *SENU *SDEU" *   FILE 313
//*       2) CLIST: Look for PROC followed by a number on record 1  *   FILE 313
//*       3) REXX: Look for the word REXX in record 1               *   FILE 313
//*       4) Panel: Look for any of these in record 1               *   FILE 313
//*          )ATTR )PANEL )CCSID )PROC )BODY )INIT )REINIT ..PREP:  *   FILE 313
//*       5) JCL: First record starts with //                       *   FILE 313
//*       6) SKEL: First record )CM, )SEL, or )SET                  *   FILE 313
//*                                                                 *   FILE 313
//*     This provides a very easy method for iterative testing and  *   FILE 313
//*     updating of the member until the member works as desired.   *   FILE 313
//*                                                                 *   FILE 313
//*     Member TSOPROF  (created 1991 - added 2/9/2018)             *   FILE 313
//*                                                                 *   FILE 313
//*     TSOPROF makes it easy to review and the key TSO PROFILE     *   FILE 313
//*     settings.                                                   *   FILE 313
//*                                                                 *   FILE 313
//*     Member TSOTRAP                                              *   FILE 313
//*                                                                 *   FILE 313
//*     TSOTRAP is a handy ISPF command that will issue whatever    *   FILE 313
//*     TSO command you give it, outtrap the results, and allow the *   FILE 313
//*     user to then Browse or Edit the results.                    *   FILE 313
//*                                                                 *   FILE 313
//*     Member TUTORPRT- Updated 3/14/20                            *   FILE 313
//*                                                                 *   FILE 313
//*     TUTORPRT is a REXX exec that will 'print' ISPF tutorial     *   FILE 313
//*     panels. Provide the dataset name where the panels are       *   FILE 313
//*     and the name of a starting tutorial panel. Optionally       *   FILE 313
//*     specify if the output should be text, or in RTF or PDF      *   FILE 313
//*     formats (if RTF or PDF then the txt2rtf or txt2pdf tools    *   FILE 313
//*     will be needed (see file 314 for both).                     *   FILE 313
//*                                                                 *   FILE 313
//*     Member TXT2CSV - Updated 06/29/17                           *   FILE 313
//*                                                                 *   FILE 313
//*     Convert a text file into a CSV.                             *   FILE 313
//*                                                                 *   FILE 313
//*     Member TSO8CHAR - Added 02/03/20                            *   FILE 313
//*                                                                 *   FILE 313
//*     Detect if TSO 8 Character Userids are enabled and           *   FILE 313
//*     return that info to the caller.                             *   FILE 313
//*                                                                 *   FILE 313

```
