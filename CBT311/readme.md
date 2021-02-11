```
//***FILE 311 IS FROM DAVE ALCOCK AND CONTAINS HIS LARGE            *   FILE 311
//*           COLLECTION OF UTILITIES.                              *   FILE 311
//*                                                                 *   FILE 311
//*           Dave Alcock can be reached at his email               *   FILE 311
//*           addresses:   David Alcock <dave@planetmvs.com>        *   FILE 311
//*                        dalcock@csw.com   (work)                 *   FILE 311
//*                                                                 *   FILE 311
//*     UPDATES OF THE CONTENTS OF THE CBT FILE MAY ALSO            *   FILE 311
//*     BE POSTED TO THIS URL ON THE INTERNET:                      *   FILE 311
//*                                                                 *   FILE 311
//*        http://www.planetmvs.com/                                *   FILE 311
//*                                                                 *   FILE 311
//*                        C o n t e n t s                          *   FILE 311
//*                        ===============                          *   FILE 311
//*                                                                 *   FILE 311
//*      Member    File Type   Description                          *   FILE 311
//*      --------  ----------  -----------                          *   FILE 311
//*      $$README  Text        This file you are reading now.       *   FILE 311
//*                                                                 *   FILE 311
//*      APFADD    Text        Uses the OSCMD exec (also            *   FILE 311
//*                            included) to issue a SETPROG APF     *   FILE 311
//*                            ADD command to add a dataset to      *   FILE 311
//*                            the APF list dynamically;            *   FILE 311
//*                                                                 *   FILE 311
//*      BENCHMRK  Text        Program that shows if there is       *   FILE 311
//*                            any consideration between using      *   FILE 311
//*                            one method of doing the same         *   FILE 311
//*                            thing over another.  For             *   FILE 311
//*                            Example, performance wise does       *   FILE 311
//*                            the GETMAIN use more or less CPU     *   FILE 311
//*                            than the STORAGE macro?              *   FILE 311
//*                                                                 *   FILE 311
//*      BENCHMR1  Text        Sample output of BENCHMRK on a       *   FILE 311
//*                            9672-R56.                            *   FILE 311
//*                                                                 *   FILE 311
//*      BENCHMR2  Text        Sample output of BENCHMRK on a       *   FILE 311
//*                            2064-1C7.                            *   FILE 311
//*                                                                 *   FILE 311
//*      CATME     Text        Rexx exec that invokes DEFINE        *   FILE 311
//*                            NONVSAM for generic and system       *   FILE 311
//*                            system symbolics. Good for ISPF      *   FILE 311
//*                            3.4 vtoc lists.                      *   FILE 311
//*                                                                 *   FILE 311
//*      CA90S     Text        Rexx exec that invokes the           *   FILE 311
//*                            Computer Associates CA90s (TNGFW)    *   FILE 311
//*                            diagnostic display programs.  Not    *   FILE 311
//*                            terribly useful.                     *   FILE 311
//*                                                                 *   FILE 311
//*      CBT$XREF  Text        First attempt at creating a CBT      *   FILE 311
//*                            tape cross reference utility.        *   FILE 311
//*                            This version creates MVS/Quickref    *   FILE 311
//*                            user database entries.  As it is     *   FILE 311
//*                            today, it isn't all that useful      *   FILE 311
//*                            yet.                                 *   FILE 311
//*                                                                 *   FILE 311
//*      COMPPDS   Text        Rexx exec that compares two PDS      *   FILE 311
//*                            at the member level. If a member     *   FILE 311
//*                            exists in both PDSs, then ISPF       *   FILE 311
//*                            compare is invoked to compare at     *   FILE 311
//*                            the record level.                    *   FILE 311
//*                                                                 *   FILE 311
//*      COMPPDSJ  Text        JCL to run COMPPDS in batch          *   FILE 311
//*                                                                 *   FILE 311
//*      COPYANSI  Text        Rexx exec that filters an input      *   FILE 311
//*                            file that has ANSI printer           *   FILE 311
//*                            control charactes and translates     *   FILE 311
//*                            them for PCs (except top of          *   FILE 311
//*                            page).                               *   FILE 311
//*                                                                 *   FILE 311
//*      DASRC     PDS Unload  A collection of mostly batch         *   FILE 311
//*                            utility that I have written over     *   FILE 311
//*                            the years. Recommend putting in a    *   FILE 311
//*                            dataset with name                    *   FILE 311
//*                            "ibmuser.DA.SOURCE".                 *   FILE 311
//*                                                                 *   FILE 311
//*      DASRCV    XMIT        Additions to the DASRC file in       *   FILE 311
//*                            LRECL > 80 RECFM=VB. Recommend       *   FILE 311
//*                            putting in a dataset with name       *   FILE 311
//*                            "ibmuser.DA.SOURCEV".                *   FILE 311
//*                                                                 *   FILE 311
//*      DIVER     PDS Unload  A very useless but fun ISPF          *   FILE 311
//*                            application of an animated stick     *   FILE 311
//*                            figure known as MR. ASCII diving     *   FILE 311
//*                            into a pool.                         *   FILE 311
//*                                                                 *   FILE 311
//*      D2SEQN    Text        Death 2 Sequence Numbers - a         *   FILE 311
//*                            filter that removes sequence         *   FILE 311
//*                            numbers when copying records.        *   FILE 311
//*                            This makes printouts of source       *   FILE 311
//*                            code easier to read. I use this      *   FILE 311
//*                            when I printout JES2 source code     *   FILE 311
//*                            for example.  PTF strings like       *   FILE 311
//*                            "@THX1138" when found as the last    *   FILE 311
//*                            word on a line are also removed.     *   FILE 311
//*                            I find this really enhances my       *   FILE 311
//*                            source code viewing pleasure.        *   FILE 311
//*                                                                 *   FILE 311
//*      FINDMOD   Text        Assembler program that searchs       *   FILE 311
//*                            the normal search order (JPA,        *   FILE 311
//*                            LNKLST, LPALST, etc) for a           *   FILE 311
//*                            module.                              *   FILE 311
//*                                                                 *   FILE 311
//*      HLASMTR   Text        High Level Assembler Listing         *   FILE 311
//*                            trimmer.  Good for when you are      *   FILE 311
//*                            downloading a listing for            *   FILE 311
//*                            printing on a PC printer.  The       *   FILE 311
//*                            title lines and trailing report      *   FILE 311
//*                            stuff (like xref) are trimmed        *   FILE 311
//*                            out.                                 *   FILE 311
//*                                                                 *   FILE 311
//*      IMGCOPY   Text        REXX exec that copies all bytes      *   FILE 311
//*                            from the SYSUT1 file to SYSUT2       *   FILE 311
//*                            when the concept of records is       *   FILE 311
//*                            not relevant.  Good for copying      *   FILE 311
//*                            .GIF and .ZIP files around on a      *   FILE 311
//*                            mainframe.                           *   FILE 311
//*                                                                 *   FILE 311
//*      IMGINFO   Text        REXX exec that shows the size of     *   FILE 311
//*                            GIF and JPG files in a format        *   FILE 311
//*                            suitable for web pages.              *   FILE 311
//*                                                                 *   FILE 311
//*      ISGECMOM  PDS Unload  An (slight) enhancement to IBM's     *   FILE 311
//*                            sample ISGECMON                      *   FILE 311
//*                                                                 *   FILE 311
//*      ISPFVAR   Text        REXX exec that shows all of the      *   FILE 311
//*                            IBM supplied ISPF variables          *   FILE 311
//*                            (all/most vars up to ISPF 3.5)       *   FILE 311
//*                                                                 *   FILE 311
//*      ISPF34L   Text        REXX exec that creates utility       *   FILE 311
//*                            cards, job streams from data set     *   FILE 311
//*                            lists from ISPF 3.4. It does not     *   FILE 311
//*                            handle the whole volume listing      *   FILE 311
//*                            very well (as I just found out       *   FILE 311
//*                            today).  It works best on            *   FILE 311
//*                            listings from a given HLQ.           *   FILE 311
//*                                                                 *   FILE 311
//*      JES2EXIT  PDS Unload  Edited versions of my JES2 exits     *   FILE 311
//*                                                                 *   FILE 311
//*      LASTUSE   Text        Only useful for shops that have      *   FILE 311
//*                            CA-DISK (also called (SAMS:DISK      *   FILE 311
//*                            or DMS).  It shows the last job      *   FILE 311
//*                            that used the dataset and the        *   FILE 311
//*                            date.                                *   FILE 311
//*                                                                 *   FILE 311
//*      MPFEXITS  PDS Unload  The MPF exits I use at my shop       *   FILE 311
//*                                                                 *   FILE 311
//*      MVSVAR    Text        REXX exec that shows all of the      *   FILE 311
//*                            IBM supplied MVSVAR() function       *   FILE 311
//*                            variables (TSO/E 2.5 or higher)      *   FILE 311
//*                                                                 *   FILE 311
//*      NEWISPF   Text        Rexx exec that makes Version 4 of    *   FILE 311
//*                            ISPF look and act more like older    *   FILE 311
//*                            versions.                            *   FILE 311
//*                                                                 *   FILE 311
//*      OSCMD     Text        Rexx exec that uses the CONSOLE      *   FILE 311
//*                            command to issue a MVS command.      *   FILE 311
//*                            You must have proper access to       *   FILE 311
//*                            the TSO CONSOLE command to use       *   FILE 311
//*                            OSCMD.                               *   FILE 311
//*                                                                 *   FILE 311
//*      PROGXX    PDS Unload  ISPF edit macro that verifies the    *   FILE 311
//*                            APF entries in the SYS1.PARMLIB      *   FILE 311
//*                            PROGxx member.                       *   FILE 311
//*                                                                 *   FILE 311
//*      SASGIF1   Text        Sample jobstream that creates a      *   FILE 311
//*                            .GIF file using SAS.                 *   FILE 311
//*                                                                 *   FILE 311
//*      SASGIF2   Text        Sample jobstream that creates a      *   FILE 311
//*                            .GIF file (with a transparent        *   FILE 311
//*                            background) using SAS.               *   FILE 311
//*                                                                 *   FILE 311
//*      SHOWFDR   PDS Unload  Small ISPF "dialog" that invokes     *   FILE 311
//*                            the FDR diagnostic ISPF-based        *   FILE 311
//*                            display functions;                   *   FILE 311
//*                                                                 *   FILE 311
//*      SHOWMRO   Text        Assembler program that shows the     *   FILE 311
//*                            currently active CICS MRO regions    *   FILE 311
//*                            via TSO TPUTs.                       *   FILE 311
//*                                                                 *   FILE 311
//*      SHOWSYM   PDS Unload  ISPF edit macro that shows the       *   FILE 311
//*                            system sumbols on you MVS version    *   FILE 311
//*                            5 or higher                          *   FILE 311
//*                                                                 *   FILE 311
//*      SMFEXIT   PDS Unload  Edited versions of my SMF exits      *   FILE 311
//*                                                                 *   FILE 311
//*      SMPEPP    PDS Unload  REXX exec that processes your        *   FILE 311
//*                            SMP/E APPLY CHECK output for PTFs    *   FILE 311
//*                            bypassed due to ACTION, HOLD,        *   FILE 311
//*                            DOC, etc.  A list is presented       *   FILE 311
//*                            that makes viewing of the HOLD       *   FILE 311
//*                            Text an easy task.                   *   FILE 311
//*                                                                 *   FILE 311
//*      SPELLCHK  PDS Unload  ISPF edit macro that performs a      *   FILE 311
//*                            spell check on selected lines or     *   FILE 311
//*                            the whole edit file.  SAS is         *   FILE 311
//*                            needed.                              *   FILE 311
//*                                                                 *   FILE 311
//*      SUBME     Text        REXX exec that submits the           *   FILE 311
//*                            currently edited data to the Job     *   FILE 311
//*                            Entry Subsystem.  Used when ISPF     *   FILE 311
//*                            submit fails.                        *   FILE 311
//*                                                                 *   FILE 311
//*      SYSVAR    Text        REXX exec that shows all of the      *   FILE 311
//*                            IBM supplied SYSVAR() function       *   FILE 311
//*                            variables                            *   FILE 311
//*                                                                 *   FILE 311
//*      TOD       PDS Unload  This package adds two features to    *   FILE 311
//*                            pre-OS/390 JES2 to simulate the      *   FILE 311
//*                            time of day functions in the JES2    *   FILE 311
//*                            JOB log.                             *   FILE 311
//*                                                                 *   FILE 311
//*      VSMAP     Text        REXX exec that shows the Virtual     *   FILE 311
//*                            Storage map.  The subroutine is      *   FILE 311
//*                            good for inclusion in other          *   FILE 311
//*                            execs.                               *   FILE 311
//*                                                                 *   FILE 311
//*      XMITINFO  Text        REXX exec that shows some internal   *   FILE 311
//*                            information about a TSO XMIT file.   *   FILE 311
//*                            This exec is more useful on a PC     *   FILE 311
//*                            when trying to determine if a file   *   FILE 311
//*                            is actually a TSO XMIT file.  This   *   FILE 311
//*                            is the first phase of a project to   *   FILE 311
//*                            create a PC program to extract       *   FILE 311
//*                            files and PDS members from a TSO     *   FILE 311
//*                            XMIT file.  XMITINFO does work on    *   FILE 311
//*                            TSO.                                 *   FILE 311
//*                                                                 *   FILE 311
//*     ----------------------------------------------------------  *   FILE 311
//*                                                                 *   FILE 311
//*     See the $$README file for information on the file types:    *   FILE 311
//*     Text, PDS Unload and TSO XMIT.                              *   FILE 311
//*                                                                 *   FILE 311

```
