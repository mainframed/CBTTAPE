```
//***FILE 118 is from Sam Golob.  This file is in IEBUPDTE SYSIN    *   FILE 118
//*           format.  For additional information see the members   *   FILE 118
//*           called $$NEWDOC and $$NEWASM.                         *   FILE 118
//*                                                                 *   FILE 118
//*         This file contains our programs which allow you to      *   FILE 118
//*         identify which FMIDs each PTF belongs to, in any        *   FILE 118
//*         SMPPTFIN input stream (PUT Tape, CBPDO PTF file,        *   FILE 118
//*         and so forth).  These programs AVOID INVOLVING          *   FILE 118
//*         SMP/E RECEIVE - that's the point!                       *   FILE 118
//*                                                                 *   FILE 118
//*     >>>>  THESE PROGRAMS ALLOW YOU TO IDENTIFY EACH PTF's FMID  *   FILE 118
//*     >>>>  WITHOUT DOING A RECEIVE, AND WITHOUT INVOLVING OR     *   FILE 118
//*     >>>>  INVOKING SMP/E AT ALL!                                *   FILE 118
//*                                                                 *   FILE 118
//*     >>>>  (If you're careful, you'll never mount the wrong      *   FILE 118
//*     >>>>  PTF tape again...... in a RECEIVE job !! )            *   FILE 118
//*                                                                 *   FILE 118
//*         Another program which will help you with this, is the   *   FILE 118
//*         program called "PHRANQUE" on CBT File 289.              *   FILE 118
//*                                                                 *   FILE 118
//*   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -   *   FILE 118
//*                                                                 *   FILE 118
//*     Jerry Lawson's email:    jlawson@thehartford.com            *   FILE 118
//*                                                                 *   FILE 118
//*     Sam Golob's email:       sbgolob@cbttape.org     OR         *   FILE 118
//*                              sbgolob@attglobal.net              *   FILE 118
//*                                                                 *   FILE 118
//*   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -   *   FILE 118
//*                                                                 *   FILE 118
//*     The only programs you now need, to do all the processing    *   FILE 118
//*     of SMPPTFIN input that can be done with this file, are:     *   FILE 118
//*                                                                 *   FILE 118
//*       PUTXREF - When used with optional DD cards //SMPCOUT      *   FILE 118
//*                 and //PDSATOUT , will replace the combined      *   FILE 118
//*                 functions of PUTXREF, plus the function of      *   FILE 118
//*                 SMPASUPD or SMPFMUPD.                           *   FILE 118
//*                                                                 *   FILE 118
//*                 The functionality from Gene Cray's file, to     *   FILE 118
//*                 pick out one FMID for the report, has been      *   FILE 118
//*                 moved here too.  See member PUTXREF# for        *   FILE 118
//*                 sample JCL which contains the optional ddname   *   FILE 118
//*                 //SRCHDATA , and instructions for its use.      *   FILE 118
//*                                                                 *   FILE 118
//*       SMPUPD  - Enhanced function with many stats now printed   *   FILE 118
//*                 and the possibility of PARM=READ for "read      *   FILE 118
//*                 only" of the SMPPTFIN input file.               *   FILE 118
//*                                                                 *   FILE 118
//*          All the rest of the programs are just included for     *   FILE 118
//*          either historical value, or as coding examples.        *   FILE 118
//*                                                                 *   FILE 118
//*   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -   *   FILE 118
//*                                                                 *   FILE 118
//*     I would just like to observe that it is possible for one    *   FILE 118
//*     PTF to have more than one FMID.  IBM's SMP/E people do      *   FILE 118
//*     this themselves.  The PTF has the same materials, for the   *   FILE 118
//*     different FMIDs, but it has different requisites.           *   FILE 118
//*                                                                 *   FILE 118
//*     The consequences of this for our processing are:            *   FILE 118
//*                                                                 *   FILE 118
//*     PUTXREF will create multiple records for such a PTF, each   *   FILE 118
//*     record belonging to a different FMID.  SMPUPD will only     *   FILE 118
//*     report one PTF read, because only one PTF was read.         *   FILE 118
//*     Please note this phenomenon carefully, when it comes to     *   FILE 118
//*     comparing counts from the two programs.                     *   FILE 118
//*                                                                 *   FILE 118
//*   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -   *   FILE 118
//*                                                                 *   FILE 118
//*    Newnote: 1- JCL for batch expansion of PTFs using the        *   FILE 118
//*    -------     GIMCPTS program is now included.  See GIM****    *   FILE 118
//*    Jul 2014    members in this pds, and see member $$NOTE01.    *   FILE 118
//*                                                                 *   FILE 118
//*             2- Our own programs, PUTXREF and SMPUPD, are        *   FILE 118
//*                not really affected by the new GIMCPTS           *   FILE 118
//*                and GIMDTS processing, because the comments      *   FILE 118
//*                and "++" statements remain unchanged.            *   FILE 118
//*                                                                 *   FILE 118
//*   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -   *   FILE 118
//*                                                                 *   FILE 118
//*       Note:  COBOL is no longer needed for this processing.     *   FILE 118
//*                                                                 *   FILE 118
//*       Note:  FORFMID processing COBOL programs were             *   FILE 118
//*              replaced with Assembler equivalents.               *   FILE 118
//*              See member JCLFMIDS.  This processing              *   FILE 118
//*              no longer needs COBOL.                             *   FILE 118
//*                                                                 *   FILE 118
//*       Note2: The PUTXREF program now takes an optional ddname   *   FILE 118
//*              //SMPCOUT which is an FB-80 file, to replace the   *   FILE 118
//*              //SYSUT2  file of the SMPASUPD or SMPFMUPD         *   FILE 118
//*                        programs.  SMPASUPD or SMPFMUPD are      *   FILE 118
//*                        no longer needed for FORFMID processing. *   FILE 118
//*                                                                 *   FILE 118
//*       Note3: The PUTXREF program now takes an optional ddname   *   FILE 118
//*              //PDSATOUT which is an FB-80 file, to generate     *   FILE 118
//*              control cards for the PDS 8.6 program from File    *   FILE 118
//*              182 of the CBT Tape.  These cards will generate    *   FILE 118
//*              ISPF stats for the SYSMODs in the SMPPTS dataset,  *   FILE 118
//*              with the ISPF userid being the owning FMID of the  *   FILE 118
//*              SYSMOD, as follows:                                *   FILE 118
//*                                                                 *   FILE 118
//*              ATTRIB UQ54586 ADDSTATS  ID(EDU1G01)               *   FILE 118
//*              ATTRIB UW79679 ADDSTATS  ID(HBB6603)               *   FILE 118
//*              ATTRIB UW79748 ADDSTATS  ID(HBB6603)               *   FILE 118
//*              ATTRIB UQ54576 ADDSTATS  ID(HGD3200)               *   FILE 118
//*              ATTRIB UQ54956 ADDSTATS  ID(HGD3200)               *   FILE 118
//*              ATTRIB UW79333 ADDSTATS  ID(HIF4402)               *   FILE 118
//*              ATTRIB UQ53658 ADDSTATS  ID(HIR2101)               *   FILE 118
//*                                                                 *   FILE 118
//*       Note:  SMPUPD processing is now replaced by an            *   FILE 118
//*              Assembler program too.  No COBOL is                *   FILE 118
//*              needed any more to run this processing.            *   FILE 118
//*                                                                 *   FILE 118
//*              The new Assembler program now has extensive        *   FILE 118
//*              reporting in the SYSPRINT dataset.  Enjoy!         *   FILE 118
//*                                                                 *   FILE 118
//*              SMPUPD can now be run with PARM=READ for read      *   FILE 118
//*              only action, to print stats about the SMPPTFIN     *   FILE 118
//*              input dataset.                                     *   FILE 118
//*                                                                 *   FILE 118
//*   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -   *   FILE 118
//*                                                                 *   FILE 118
//*     Historical Note about COBOL programs:                       *   FILE 118
//*                                                                 *   FILE 118
//*       COBOL programs are being kept here, just in case....      *   FILE 118
//*                                                                 *   FILE 118
//*       NOTE:  COBOL PROGRAMS WERE UPDATED FOR LE/370             *   FILE 118
//*              AND COMPILE-LINK JOBS ARE NOW INCLUDED.            *   FILE 118
//*                                                                 *   FILE 118
//*              This file, which consists of several programs      *   FILE 118
//*              and sample JCL, allows the systems programmer      *   FILE 118
//*              to pre-view and index, and thoroughly keep         *   FILE 118
//*              track of his SMPPTFIN-format tapes before SMP/E    *   FILE 118
//*              has a chance to look at them.  Any tape or disk    *   FILE 118
//*              SMPPTFIN file can get this treatment.  Full        *   FILE 118
//*              FORFMID capability is provided, external to        *   FILE 118
//*              SMP/E.  Since this processing has nothing to do    *   FILE 118
//*              with SMP/E, it is completely release-independent,  *   FILE 118
//*              and can be used with any SMPPTFIN-format file      *   FILE 118
//*              regardless of SMP release (starting with SMP4      *   FILE 118
//*              and through all releases of SMP/E.)                *   FILE 118
//*                                                                 *   FILE 118
//*              The core of this file is the PUTXREF program       *   FILE 118
//*              from Jerry Lawson of the Hartford Insurance        *   FILE 118
//*              Group, which has been modified by me.  This        *   FILE 118
//*              program sorts all SYSMODs in a SMPPTFIN file by    *   FILE 118
//*              owning FMID.  The output of Jerry's PUTXREF        *   FILE 118
//*              program is a report showing the FMID name and      *   FILE 118
//*              the SYSMODS belonging to it listed afterwards.     *   FILE 118
//*              (See File 033 of the CBT tape for another          *   FILE 118
//*              modification of PUTXREF, which allows              *   FILE 118
//*              selectivity by FMID and other criteria.  That      *   FILE 118
//*              one is by Gene Cray of the New Jersey Treasury     *   FILE 118
//*              Department in Trenton (Gene has since moved on).   *   FILE 118
//*                                                                 *   FILE 118
//*       >>     Putting an //SMPCOUT DD card into a PUTXREF run,   *   FILE 118
//*              or running my programs SMPASUPD or SMPFMUPD which  *   FILE 118
//*              take input from the //PRINTER DD name of PUTXREF,  *   FILE 118
//*              will produce an output file that is almost         *   FILE 118
//*              "inputable" into an SMP/E RECEIVE or APPLY job.    *   FILE 118
//*              Output of the //SMPCOUT DD card or the SMPASUPD    *   FILE 118
//*              and SMPFMUPD programs, looks like:                 *   FILE 118
//*                                                                 *   FILE 118
//*   ./  ADD  NAME=EBB1102                                         *   FILE 118
//*   UY04130 /*  FMID - EBB1102 - FROM PUT TAPE - DONE 09/15/87  */*   FILE 118
//*   UY09531 /*  FMID - EBB1102 - FROM PUT TAPE - DONE 09/15/87  */*   FILE 118
//*   UY10163 /*  FMID - EBB1102 - FROM PUT TAPE - DONE 09/15/87  */*   FILE 118
//*   UY10354 /*  FMID - EBB1102 - FROM PUT TAPE - DONE 09/15/87  */*   FILE 118
//*   UY10882 /*  FMID - EBB1102 - FROM PUT TAPE - DONE 09/15/87  */*   FILE 118
//*   ./  ADD  NAME=EDM1102                                         *   FILE 118
//*   UY10582 /*  FMID - EDM1102 - FROM PUT TAPE - DONE 09/15/87  */*   FILE 118
//*                                                                 *   FILE 118
//*              YOU CAN OBVIOUSLY USE THIS AS INPUT TO ANOTHER     *   FILE 118
//*              SMP/E JOB, AND THIS GIVES YOU FULL FORFMID POWER   *   FILE 118
//*              FOR EACH PUT TAPE.                                 *   FILE 118
//*                                                                 *   FILE 118
//*              THE THIRD FEATURE OF THIS PROCESSING IS MY         *   FILE 118
//*              SMPUPD PROGRAM, WHICH ALLOWS THE BREAKING UP OF A  *   FILE 118
//*              SMPPTFIN FILE INTO A PDS, WHOSE MEMBERS ARE THE    *   FILE 118
//*              SEPARATE SYSMODS.  SUPPORT IS PROVIDED FOR APAR,   *   FILE 118
//*              USERMOD, AND FUNCTION SYSMODS AS WELL AS FOR       *   FILE 118
//*              PTFS.  THIS PROGRAM IS A RATHER QUICK-AND-DIRTY    *   FILE 118
//*              WAY OF DOING THINGS, BUT IT GETS ITS JOB DONE      *   FILE 118
//*              SUPERBLY, AND THAT'S WHAT COUNTS.  BASICALLY, IT   *   FILE 118
//*              LOOKS IN A FILE FOR ++ PTF OR ++ APAR OR ++        *   FILE 118
//*              USERMOD ETC.  IT PARSES FOR THE 7-CHARACTER        *   FILE 118
//*              SYSMOD NUMBER.  IN THE PROCESS OF MAKING A         *   FILE 118
//*              TEMPORARY COPY OF THE SMPPTFIN FILE, IT INSERTS A  *   FILE 118
//*              CARD IN FRONT OF EACH SYSMOD, WITH THE FORMAT:     *   FILE 118
//*                                                                 *   FILE 118
//*          ./ ADD NAME=sysmdno                                    *   FILE 118
//*                                                                 *   FILE 118
//*              IN ADDITION, ALL "./" STRINGS IN COLUMNS 1 TO 2    *   FILE 118
//*              OF THE COPIED SYSMOD FILE ARE CHANGED TO "><".     *   FILE 118
//*              THEN THE PDSLOAD PROGRAM (FROM FILE 093 OF THE     *   FILE 118
//*              CBT TAPE) CAN BE USED TO LOAD ALL THE SYSMODS      *   FILE 118
//*              SEPARATELY INTO PDS MEMBERS, AND TO CONVERT THE    *   FILE 118
//*              "><" STRINGS WITHIN THE SYSMODS, BACK TO "./".     *   FILE 118
//*                                                                 *   FILE 118
//*              A SAMPLE JOBSTREAM, CALLED SMPUPDJ IN THIS PDS,    *   FILE 118
//*              WILL SHOW YET ANOTHER STEP AT THE END.  IT MAY     *   FILE 118
//*              NOT BE WIDELY PUBLICIZED YET, BUT THE PDS          *   FILE 118
//*              COMMAND PROCESSOR (FROM FILE 182 OF THE CBT        *   FILE 118
//*              TAPE) AT VERSION 8.5, HAS THE CAPABILITY OF        *   FILE 118
//*              SUPPLYING FULL ISPF STATISTICS TO A SOURCE PDS     *   FILE 118
//*              MEMBER.  THIS CAN ALSO BE DONE IN BATCH MODE.  I   *   FILE 118
//*              ADD A STEP AT THE END OF THE JOBSTREAM SMPUPDJ     *   FILE 118
//*              WHICH RUNS TSO IN BATCH, AND ADDS ISPF             *   FILE 118
//*              STATISTICS TO ALL THE SYSMODS, SO YOU KNOW HOW     *   FILE 118
//*              MANY LINES EACH ONE HAS.  ONCE THE PTFS OR         *   FILE 118
//*              OTHER SYSMODS HAVE BEEN SEPARATED, YOU MAY         *   FILE 118
//*              INQUIRE ABOUT THEM BY BROWSING OR EDITING THEM     *   FILE 118
//*              INDIVIDUALLY.  ALSO, SINCE THIS JOBSTREAM IS A     *   FILE 118
//*              QUICK AND REPRODUCIBLE PROCESS (IT TAKES A FEW     *   FILE 118
//*              MINUTES TO RUN ON MY MACHINE), YOU CAN LEAVE       *   FILE 118
//*              THE OUTPUT DATASET ON A WORK PACK FOR A FEW        *   FILE 118
//*              HOURS IF YOU'RE SHORT OF PERMANENT DISK SPACE.     *   FILE 118
//*              THEN YOU CAN RECREATE IT AGAIN THE NEXT DAY.       *   FILE 118
//*                                                                 *   FILE 118
//*              ONE MORE NOTE.  SOMETIMES IBM WILL SEND OUT        *   FILE 118
//*              DUPLICATE PTFS ON THE SAME PUT OR CBPDO TAPE.      *   FILE 118
//*              THIS WILL OBVIOUSLY CREATE DELETED MEMBERS ON      *   FILE 118
//*              YOUR OUTPUT LIBRARY, SINCE THE SECOND STOW OF A    *   FILE 118
//*              PDS MEMBER WILL DELETE THE FIRST MEMBER THAT       *   FILE 118
//*              HAS THE SAME NAME.  THEREFORE, I USE ANOTHER       *   FILE 118
//*              CAPABILITY OF THE PDS PROGRAM, WHICH IS THE        *   FILE 118
//*              RESTORE FUNCTION TO RESURRECT DELETED MEMBERS.     *   FILE 118
//*              THE DELETED MEMBERS ARE PUT BACK UNDER THE         *   FILE 118
//*              NAMES $PTF0001, $PTF0002, ETC. SO THEY CAN BE      *   FILE 118
//*              BROWSED AND COMPARED TO THE "REAL" ONES WHICH      *   FILE 118
//*              HAD THE SAME NAME.  (ACTUALLY, IN A RECEIVE        *   FILE 118
//*              JOB, THE DELETED VERSION WOULD BE RECEIVED,        *   FILE 118
//*              SINCE IT OCCURS FIRST IN THE FILE.)  THE PDS       *   FILE 118
//*              COMMAND IN PDS VERSION 8.5 WHICH DOES THIS IS:     *   FILE 118
//*                                                                 *   FILE 118
//*                 RESTORE $PTF REPEAT NOPROMPT                    *   FILE 118
//*                                                                 *   FILE 118

```
