
## $$DOC.txt
```
**********************************************************************
**********  SMP RELEASE-INDEPENDENT PUT-TAPE TOOLS    ************   *
**********************************************************************
*                                                                    *
*  Documentation  -  S. GOLOB -               - 09/30/87             *
*                                                                    *
*                                                                    *
*                                                                    *
*   This file, which consists of several programs and sample JCL,    *
*     allows the systems programmer to pre-view and index,           *
*     and thoroughly keep track of his PUT tapes BEFORE SMP has      *
*     a chance to look at them.  Full FORFMID capability is          *
*     provided, external to SMP.  Since this processing has          *
*     nothing to do with SMP, it is completely release-independent,  *
*     and can be used with SMP/4 as well as with SMP/E.              *
*                                                                    *
*        *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *        *
*                                                                    *
*   The core of this file is the PUTXREF program from Jerry Lawson   *
*     of the Hartford Insurance Group, which was slightly modified   *
*     by me.  This program sorts all SYSMODS in a SMPPTFIN file      *
*     by owning FMID.  The output of Jerry's PUTXREF program is a    *
*     report showing the FMID name and the sysmods belonging to it   *
*     listed afterwards.  (See FILE 033 of the CBT tape for          *
*     another modification of PUTXREF, which allows selectivity      *
*     by FMID and other criteria.  That one is by Gene Cray of       *
*     the New Jersey Treasury Department in Trenton.)                *
*                                                                    *
*        *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *        *
*                                                                    *
*   My program SMPASUPD takes the output of the PUTXREF program      *
*     and makes it "inputable" to an SMP job.  Output of SMPASUPD    *
*     looks like:                                                    *
*                                                                    *
  ./  ADD  NAME=EBB1102
      UY04130 /*  FMID - EBB1102 - FROM PUT TAPE - DONE 09/15/87  */
      UY09531 /*  FMID - EBB1102 - FROM PUT TAPE - DONE 09/15/87  */
      UY10163 /*  FMID - EBB1102 - FROM PUT TAPE - DONE 09/15/87  */
      UY10354 /*  FMID - EBB1102 - FROM PUT TAPE - DONE 09/15/87  */
      UY10882 /*  FMID - EBB1102 - FROM PUT TAPE - DONE 09/15/87  */
  ./  ADD  NAME=EDM1102
      UY10582 /*  FMID - EDM1102 - FROM PUT TAPE - DONE 09/15/87  */
*                                                                    *
*     You can obviously use this as input to another SMP job, and    *
*     this gives you full FORFMID power for each PUT tape.           *
*                                                                    *
*        *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *        *
*                                                                    *
*   The third feature of this processing is my SMPUPD program,       *
*     which allows the breaking up of a SMPPTFIN file into a PDS,    *
*     whose members are the separate SYSMODS.  Support is provided   *
*     for APAR, USERMOD, and FUNCTION sysmods as well as for PTFs.   *
*     This program is a rather quick-and-dirty way of doing things,  *
*     but it gets its job done superbly, and that's what counts.     *
*     Basically, it looks in a file for ++ PTF or ++ APAR or         *
*     ++ USERMOD etc.  It parses for the 7-character sysmod number.  *
*     In the process of making a temporary copy of the SMPPTFIN      *
*     file, it inserts a card in front of each sysmod, with the      *
*     format:                                                        *
  ./  ADD  NAME=sysmdno
*                                                                    *
*     In addition, all "./" strings in columns 1 to 2 of the copied  *
*     sysmod file are changed to "><".  Then the PDSLOAD program     *
*     (from File 316 of the CBT tape) can be used to load all the    *
*     sysmods separately into PDS members, and to convert the "><"   *
*     strings within the sysmods, back to "./" .                     *
*                                                                    *
*   A sample jobstream, called SMPUPDJ in this pds, will show yet    *
*     another step at the end.  It may not be widely publicized      *
*     yet, but the PDS command processor (from FILE 182 of the       *
*     CBT tape) starting with version 8.0, has the capability of     *
*     supplying full ISPF statistics to a source pds member. This    *
*     can also be done in batch mode.  I add a step at the end       *
*     of the jobstream SMPUPDJ which runs TSO in batch, and          *
*     adds ISPF statistics to all the sysmods, so you know how       *
*     many lines each one has.  Once the PTFS or other sysmods       *
*     have been separated, you may inquire about them by browsing    *
*     or editing them individually.  Also, since this jobstream is   *
*     a quick and reproducible process (it takes 3.5 minutes to run  *
*     on my machine), you can leave the output dataset on a work     *
*     pack for a few hours if you're short of permanent disk space.  *
*     Then you can recreate it again the next day.                   *
*                                                                    *
*   One more note.  Sometimes IBM will send out duplicate PTFs       *
*     on the same PUT tape.  This will obviously create deleted      *
*     members on your output library, since the second load of       *
*     a PDS member will delete the first member that has the         *
*     same name.  Therefore, I use another capability of the PDS     *
*     program, which is the RESTORE function to resurrect deleted    *
*     members.  The deleted members are put back under the names     *
*     $PTF0001, $PTF0002, etc. so they can be browsed and compared   *
*     to the "real" ones which had the same name.  (Actually, in a   *
*     RECEIVE job, the deleted version would be received, since it   *
*     occurs first in the file.)  The PDS command in PDS version     *
*     8.0 which does this is:                                        *
*                                                                    *
*        RESTORE $PTF repeat noprompt                                *
*                                                                    *
*   Please browse the sample jobs for their commentary material.     *
*     I would appreciate getting calls and comment from users or     *
*     prospective users of these tools.  This kind of interaction    *
*     leads to improvement and progress, usually.  Thanks much.      *
*                                                                    *
*   Please don't forget to look at Gene Cray's code in File 033.     *
*                                                                    *
*   If you have an SMP4 environment, look at the additional          *
*     tools in File 428.                                             *
*                                                                    *
```

## $OLDDOC.txt
```
*********************************************************************** 00002
*                                                                     * 00003
*              PUTXREF - VERSION 3.0                                  * 00004
*                                                                     * 00005
*        JERRY LAWSON  860-547-5000 EXT 2960                          * 00006
*        HARTFORD INSURANCE GROUP,                                    * 00007
*        690 ASYLUM AVE.                                              * 00008
*        HARTFORD, CT.  06115                                         * 00009
*                                                                     * 00010
*        FUNCTION:                                                    * 00011
*        THIS PROGRAM TAKES THE PUT PTF FILE (FILE 1 FROM A           * 00012
*        STANDARD IBM PUT TAPE), AND PRODUCES A CROSS                 * 00013
*        REFERENCE OF THE PTF'S INCLUDED, SORTED BY FMID.             * 00014
*        IT CAN TAKE CONCATENATED INPUT, BUT THE TAPE IDENITY         * 00015
*        ON WHICH THE PTF IS FOUND WILL BE LOST. THE PROGRAM          * 00016
*        SHOULD BE USEFUL TO QUICKLY IDENTIFY WHAT PTF'S              * 00017
*        ARE ON A GIVEN TAPE, WHAT FMID'S HAVE MAINTENANCE ON         * 00018
*        A TAPE, AND TO DOUBLE CHECK THE STERLING FORREST             * 00019
*        CROSS REFERENCE (IT LIES ONCE IN A WHILE.)                   * 00020
*                                                                     * 00021
*        DEPENDANCIES:                                                * 00022
*        1.    THIS PROGRAM HAS AN INVOKED INCORE SORT.               * 00023
*              IT LINKS TO THE ENTRY POINT OF "SORT".                 * 00024
*              CHANGE THE LINK MACRO IF YOU DO NOT SUPPORT            * 00025
*              THAT NAME OR ALIAS. YOU WILL NEED ABOUT                * 00026
*              300K FOR THE WHOLE PROGRAM AND SORT.                   * 00027
*        2.    TITLES.  THIS FILE (FOR FMID TITLES) IS                * 00028
*              OPTIONAL. IF NOT INCLUDED, YOU WILL GET A              * 00029
*              WARNING MESSAGE ON YOUR SYSOUT, AND NO TITLES.         * 00030
*              I HAVE INCLUDED THE FILE IN THE JCL, I                 * 00031
*              CREATED THE FILE BY DOING THE FOLLOWING:               * 00032
*              A. ALLOCATE A DATA SET ON TSO  - NORMAL STUFF -        * 00033
*                  RECFM=FB,LRECL=80                                  * 00034
*              B.  ASSIGN THAT DATA SET TO DD NAME OF OZPRINT         * 00035
*              C.  EXECUTE YOUR INFO - SYS CLIST OR COMMAND           * 00036
*              D.  ISSUE A 'DEF A' COMMAND TO INFO (SEARCH            * 00037
*                  ALL FILES)                                         * 00038
*              E.  DO A KEY WORD SEARCH AS FOLLOWS -                  * 00039
*                  KWS FMID XREF      I GOT ABOUT 22 HITS,            * 00040
*                  BUT THE FIRST ONE HAD A TITLE OF                   * 00041
*                  'THIS IS A CROSS REFERENCE OF MVS FMIDS',          * 00042
*                  OR SOMETHING SIMILAR. BE SURE YOU                  * 00043
*                  HAVE THE LATEST ONE                                * 00044
*              F.  SELECT THE CORRECT ONE, THE ISSUE A                * 00045
*                  'PRINT UP' COMMAND. THE OUTPUT WILL GO             * 00046
*                  TO THE DATA SET ALLOCATED TO THE OZPRINT           * 00047
*                  DDNAME                                             * 00048
*              G.  END YOUR INFO SESSION                              * 00049
*              H.  EDIT YOUR PRINT FROM THE INFO SESSION              * 00050
*                  YOU WANT TO DELETE ALL LINES THAT DO               * 00051
*                  NOT HAVE AN FMID IN COLUMN 3. NOTE THAT DELETED      00052
*                  FMIDS HAVE A * IN COLUMN 3, FOR BETTER             * 00053
*                  DOCUMENTATION I DELETE THE STAR ANDMOVE THE        * 00054
*                  FMID BACK TO 3, BUT THIS IS                        * 00055
*                  OPTIONAL.                                          * 00056
*              I.  AFTER YOU HAVE SAVED THE DATA SET,                 * 00057
*                  SORT IT ON COLUMN 3 FOR A LENGTH OF 7.             * 00058
*              J.  THE TITLE LIST YOU HAVE JUST CREATED               * 00059
*                  CAN BE EITHER INCLUDED IN THE JCL STREAM           * 00060
*                  OR KEPT IN A SEPERATE DATA SET, AND POINTED        * 00061
*                  TO BY THE JCL.                                     * 00062
*        3.    REGS MACRO. THE STANDARD REGISTER EQUATES              * 00063
*              SUCH AS IN R1      EQU    1      ETC.                  * 00064
*              NOTE - REMOVED ON 3/10/82                              * 00065
*                                                                     * 00066
*        CHANGES FOR RELEASE 3.0                                      * 00067
*        1.    CHANGED INPUT LOCATION OF TITLES FROM COLUMN 2 TO      * 00068
*              COLUMN 3. THIS ALLOWS USE OF THE OUTPUT OF THE         * 00069
*              OZPRINT DD STATEMENT WITHOUT HAVING TO DELETE          * 00070
*              THE CARRIAGE CONTROL INFO COMPLETELY. SEE THE INFO IN  * 00071
*              2. ABOVE FOR DETAILS ON HOW TO CREATE THE TITLE        * 00072
*              FILE.                                                  * 00073
*        2.    EXTENDED SIZE OF THE TITLE FIELD TO INCLUDE            * 00074
*              THE COMPONENT ID NOW THAT IBM HAS                      * 00075
*              INCLUDED IT IN THE FMID XREF.                          * 00076
*                                                                     * 00077
*        CHANGES FOR RELEASE 2.0:                                     * 00078
*        1. ADDED BLOCKSIZES TO DCB MACROS TO CORRECT DEPENDENCY      * 00079
*           ON LOCAL MODS                                             * 00080
*        2. CORRECTED SORT FIELDS STATEMENT IN PROGRAM. ONLY USED IF  * 00081
*           IBM SORT IS INVOKED. NOTE THAT PARM ERROR SEEMS TO BE     * 00082
*           A STANDARD FEATURE WITH THIS PROGRAM - I CAN FIND NO ERROR* 00083
*        3. SYSOUT JCL DD STATEMENT ADDED FOR IBM SORTS               * 00084
*                                                                     * 00085
*        MACROS.                                                      * 00086
*        SAVE      OPEN      CLOSE      GET                           * 00087
*        PUT       LINK      WTO        ABEND (U128 - BAD SORT)       * 00088
*        DCB                                                            00089
*                                                                     * 00090
*        REGISTER ASSIGNMENTS - NORMAL LINKAGE CONVENTIONS            * 00091
*              REG 12              BASE REGISTER                      * 00092
*              REG 2               BAL REGISTER                       * 00093
*              REG 3               BCT REGISTER - PHASE 1             * 00094
*              REG 4               POINTER TO PTF INPUT RECORD        * 00095
*              REG 5               OUTPUT POSITION POINTER - PHASE 2  * 00096
*              REG 6               BCT REGISTER - PHASE 2             * 00097
*              REG 7               RETURN ADDRESS FOR EODAD (TITLES)  * 00098
*********************************************************************** 00099
```

## $PUTXDOC.txt
```
**********************************************************************
**********       PUTXREF - SMP FORFMID TOOL           ************   *
**********************************************************************
*  PUTXREF PROGRAM - PRODUCE A REPORT SORTING ANY SYSMODS ON         *
*    A PUT TAPE OR APAR TAPE OR ANY SMPPTFIN FILE BY FMID.           *
**********************************************************************
*                                                                    *
*  MODIFICATION RECORD - S. GOLOB -               - 04/26/88        SBG
*                                                                    *
*                              SAM GOLOB                             *
*                                                                    *
*                                                                   SBG
*  MODIFIED APRIL 26, '88 BY SHMUEL GOLOB             TO ONLY       SBG
*    LOOK FOR FMID KEYWORD IF YOU'RE LEGITIMATELY WITHIN A ++VER    SBG
*    STATEMENT.  LEFT ALL THE OTHER STUFF IN AS SAFETY CHECKS.      SBG
*    PLEASE INFORM ME             (212) 206-5847 IF THIS VERSION    SBG
*    OF THE PROGRAM FAILS TO WORK.  (CODE CAN USE CLEANING UP.)     SBG
*                                                                   SBG
*  MODIFIED APRIL 25, '88 BY SHMUEL GOLOB             TO FIX A FEW  SBG
*    BUGS.  THE PROGRAM CAN NOW DETECT IF THE FMID KEYWORD IS IN    SBG
*    A COMMENT AREA.  IT ALSO KNOWS THAT IN THE INSIDE OF JCLIN YOU SBG
*    CAN'T TEST FOR A COMMENT AREA, AND IT WON'T TEST FOR AN FMID   SBG
*    KEYWORD THERE EITHER.  ALSO FIXED BUG THAT 1ST CHARACTER       SBG
*    OF THE FMID WAS CHOPPED OFF IF THERE WERE AN ODD NUMBER OF     SBG
*    SPACES BETWEEN THE OPEN PAREN AFTER THE FMID KEYWORD, AND      SBG
*    THE FIRST NON-BLANK.  ANOTHER BUG WAS THAT THE FMID KEYWORD    SBG
*    IN A ++IF STATEMENT WAS IGNORED ONLY ON THE SAME LINE AS THE   SBG
*    ++IF, BUT NOT ON THE FOLLOWING LINES UNDER THE ++IF'S CONTROL. SBG
*                                                                    *
*  MODIFIED JUNE 26, 1986 BY SHMUEL GOLOB             TO LOOK AT     *
*    ++APAR, ++USERMOD, AND ++FUNCTION IN ADDITION TO ++PTF.         *
*    ( I WANT TO KNOW WHAT FMIDS MY APARS AND USERMODS BELONG TO! )  *
*                                                                    *
*  THIS CODE WAS OBTAINED FROM FILE 118 OF THE CBT MVS MODS TAPE,    *
*    VERSION 260.  THE CODE THERE ONLY EXTRACTS PTFS.  I HAVE        *
*    MODIFIED IT IN THIS VERSION TO RECOGNIZE APARS, USERMODS, AND   *
*    FUNCTION SYSMODS ALSO.                                          *
*                                                                    *
*  THE OLD VERSION OF THIS PROGRAM REMAINS ON THIS FILE UNDER THE    *
*    MEMBER NAME PTFSXREF.  THE MEMBER OFILE118 HAS THE EXACT        *
*    CONTENTS OF FILE 118 FROM PREVIOUS VERSIONS OF THE CBT TAPE.    *
*                                                                    *
*  MY PROGRAM, SMPFMUPV, FROM FILE 428 OF THE CBT TAPE               *
*    CONVERTS THE OUTPUT OF THIS PROGRAM TO THE FORMAT:              *
*    ./  ADD  NAME=FMIDNAM                                           *
*          UZ11111  /*  FMID - FMIDNAM - FROM PUT TAPE - DATE  */    *
*                                                                    *
*    THIS IS SUITABLE FOR INPUT TO AN SMP APPLY OR LIST              *
*    JOB.  WE GET A "FORFMID" EFFECT, GOOD ON ANY VERSION            *
*    OF SMP, BECAUSE IT'S ONLY DEPENDENT ON THE SMPPTFIN FILE,       *
*    AND NOT ON THE VERSION OF SMP WHICH WILL PROCESS THAT FILE.     *
*                                                                    *
*    PLEASE LOOK ON FILE 428 TO GET THE MOST MILEAGE FROM THIS       *
*    PROGRAM, AND FOR OTHER USEFUL SMP TOOLS.                        *
******************************************************************   *
**********************************************************************  00002
*                                                                    *  00003
*              PUTXREF - VERSION 3.0                                 *  00004
*                                                                    *  00005
*        JERRY LAWSON  860-547-5000 EXT 2960                         *  00006
*        HARTFORD INSURANCE GROUP,                                   *  00007
*        690 ASYLUM AVE.                                             *  00008
*        HARTFORD, CT.  06115                                        *  00009
*                                                                    *  00010
*        FUNCTION:                                                   *  00011
*        THIS PROGRAM TAKES THE PUT PTF FILE (FILE 1 FROM A          *  00012
*        STANDARD IBM PUT TAPE), AND PRODUCES A CROSS                *  00013
*        REFERENCE OF THE PTF'S INCLUDED, SORTED BY FMID.            *  00014
*        IT CAN TAKE CONCATENATED INPUT, BUT THE TAPE IDENITY        *  00015
*        ON WHICH THE PTF IS FOUND WILL BE LOST. THE PROGRAM         *  00016
*        SHOULD BE USEFUL TO QUICKLY IDENTIFY WHAT PTF'S             *  00017
*        ARE ON A GIVEN TAPE, WHAT FMID'S HAVE MAINTENANCE ON        *  00018
*        A TAPE, AND TO DOUBLE CHECK THE STERLING FORREST            *  00019
*        CROSS REFERENCE (IT LIES ONCE IN A WHILE.)                  *  00020
*                                                                    *  00021
*        DEPENDANCIES:                                               *  00022
*        1.    THIS PROGRAM HAS AN INVOKED INCORE SORT.              *  00023
*              IT LINKS TO THE ENTRY POINT OF "SORT".                *  00024
*              CHANGE THE LINK MACRO IF YOU DO NOT SUPPORT           *  00025
*              THAT NAME OR ALIAS. YOU WILL NEED ABOUT               *  00026
*              300K FOR THE WHOLE PROGRAM AND SORT.                  *  00027
*        2.    TITLES.  THIS FILE (FOR FMID TITLES) IS               *  00028
*              OPTIONAL. IF NOT INCLUDED, YOU WILL GET A             *  00029
*              WARNING MESSAGE ON YOUR SYSOUT, AND NO TITLES.        *  00030
*              I HAVE INCLUDED THE FILE IN THE JCL, I                *  00031
*              CREATED THE FILE BY DOING THE FOLLOWING:              *  00032
*              A. ALLOCATE A DATA SET ON TSO  - NORMAL STUFF -       *  00033
*                  RECFM=FB,LRECL=80                                 *  00034
*              B.  ASSIGN THAT DATA SET TO DD NAME OF OZPRINT        *  00035
*              C.  EXECUTE YOUR INFO - SYS CLIST OR COMMAND          *  00036
*              D.  ISSUE A 'DEF A' COMMAND TO INFO (SEARCH           *  00037
*                  ALL FILES)                                        *  00038
*              E.  DO A KEY WORD SEARCH AS FOLLOWS -                 *  00039
*                  KWS FMID XREF      I GOT ABOUT 22 HITS,           *  00040
*                  BUT THE FIRST ONE HAD A TITLE OF                  *  00041
*                  'THIS IS A CROSS REFERENCE OF MVS FMIDS',         *  00042
*                  OR SOMETHING SIMILAR. BE SURE YOU                 *  00043
*                  HAVE THE LATEST ONE                               *  00044
*              F.  SELECT THE CORRECT ONE, THE ISSUE A               *  00045
*                  'PRINT UP' COMMAND. THE OUTPUT WILL GO            *  00046
*                  TO THE DATA SET ALLOCATED TO THE OZPRINT          *  00047
*                  DDNAME                                            *  00048
*              G.  END YOUR INFO SESSION                             *  00049
*              H.  EDIT YOUR PRINT FROM THE INFO SESSION             *  00050
*                  YOU WANT TO DELETE ALL LINES THAT DO              *  00051
*                  NOT HAVE AN FMID IN COLUMN 3. NOTE THAT DELETED   *  00052
*                  FMIDS HAVE A * IN COLUMN 3, FOR BETTER            *  00053
*                  DOCUMENTATION I DELETE THE STAR ANDMOVE THE       *  00054
*                  FMID BACK TO 3, BUT THIS IS                       *  00055
*                  OPTIONAL.                                         *  00056
*              I.  AFTER YOU HAVE SAVED THE DATA SET,                *  00057
*                  SORT IT ON COLUMN 3 FOR A LENGTH OF 7.            *  00058
*              J.  THE TITLE LIST YOU HAVE JUST CREATED              *  00059
*                  CAN BE EITHER INCLUDED IN THE JCL STREAM          *  00060
*                  OR KEPT IN A SEPERATE DATA SET, AND POINTED       *  00061
*                  TO BY THE JCL.                                    *  00062
*        3.    REGS MACRO. THE STANDARD REGISTER EQUATES             *  00063
*              SUCH AS IN R1      EQU    1      ETC.                 *  00064
*              NOTE - REMOVED ON 3/10/82                             *  00065
*                                                                    *  00066
*        CHANGES FOR RELEASE 3.0                                     *  00067
*        1.    CHANGED INPUT LOCATION OF TITLES FROM COLUMN 2 TO     *  00068
*              COLUMN 3. THIS ALLOWS USE OF THE OUTPUT OF THE        *  00069
*              OZPRINT DD STATEMENT WITHOUT HAVING TO DELETE         *  00070
*              THE CARRIAGE CONTROL INFO COMPLETELY. SEE THE INFO IN *  00071
*              2. ABOVE FOR DETAILS ON HOW TO CREATE THE TITLE       *  00072
*              FILE.                                                 *  00073
*        2.    EXTENDED SIZE OF THE TITLE FIELD TO INCLUDE           *  00074
*              THE COMPONENT ID NOW THAT IBM HAS                     *  00075
*              INCLUDED IT IN THE FMID XREF.                         *  00076
*                                                                    *  00077
*        CHANGES FOR RELEASE 2.0:                                    *  00078
*        1. ADDED BLOCKSIZES TO DCB MACROS TO CORRECT DEPENDENCY     *  00079
*           ON LOCAL MODS                                            *  00080
*        2. CORRECTED SORT FIELDS STATEMENT IN PROGRAM. ONLY USED IF *  00081
*           IBM SORT IS INVOKED. NOTE THAT PARM ERROR SEEMS TO BE    *  00082
*           A STANDARD FEATURE WITH THIS PROGRAM - I CAN FIND NO ERROR  00083
*        3. SYSOUT JCL DD STATEMENT ADDED FOR IBM SORTS              *  00084
*                                                                    *  00085
*        MACROS.                                                     *  00086
*        SAVE      OPEN      CLOSE      GET                          *  00087
*        PUT       LINK      WTO        ABEND (U128 - BAD SORT)      *  00088
*        DCB                                                         *  00089
*                                                                    *  00090
*        REGISTER ASSIGNMENTS - NORMAL LINKAGE CONVENTIONS           *  00091
*              REG 12              BASE REGISTER                     *  00092
*              REG 2               BAL REGISTER                      *  00093
*              REG 3               BCT REGISTER - PHASE 1            *  00094
*              REG 4               POINTER TO PTF INPUT RECORD       *  00095
*              REG 5               OUTPUT POSITION POINTER - PHASE 2 *  00096
*              REG 6               BCT REGISTER - PHASE 2            *  00097
*              REG 7               RETURN ADDRESS FOR EODAD (TITLES) *  00098
**********************************************************************  00099
```

