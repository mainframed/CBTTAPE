```
//***FILE 316 CONTAINS MANY BATCH UTILITIES AND OTHER GOOD THINGS.  *   FILE 316
//*          CODE FROM JIM MARSHALL (AIR FORCE RETIREE).            *   FILE 316
//*                                                                 *   FILE 316
//*          Jim's current address is:                              *   FILE 316
//*                                                                 *   FILE 316
//*                Jim Marshall, Retired                            *   FILE 316
//*                                                                 *   FILE 316
//*          Please address inquiries to Sam Golob.                 *   FILE 316
//*                                                                 *   FILE 316
//*                email:  sbgolob@cbttape.org                      *   FILE 316
//*                                                                 *   FILE 316
//*       Note:  As of 10-24-02, all occurrences of the MSG macro   *   FILE 316
//*              have been changed to MSGZ, because MSG is now an   *   FILE 316
//*              assembler opcode (as of HLASM Release 4, or        *   FILE 316
//*              OS/390 Release 2.10).                              *   FILE 316
//*                                                                 *   FILE 316
//*   Member $$ZDOC now replaced by member @FILE316.  (SBG - 08/03) *   FILE 316
//*                                                                 *   FILE 316
//*       RELEASE     -  08 OCTOBER 2018                            *   FILE 316
//*                                                                 *   FILE 316
//*       SUMMARY OF THE MODULES CONTAINED.                         *   FILE 316
//*                                                                 *   FILE 316
//*       UTIL     REL          DESCRIPTION                         *   FILE 316
//*                                                                 *   FILE 316
//*       $$MACROX  4   INCORPORATED BILL GODFREY'S MODS TO         *   FILE 316
//*                     'IFOX00' TO PRODUCE MACRO CROSS REFERENCE.  *   FILE 316
//*                     PDS WAS MADE INTO A MEMBER PRECEDED WITH    *   FILE 316
//*                     '>< ADD NAME=   ' CARDS AND SPF STATS.      *   FILE 316
//*                     THIS WAS IN A SEPARATE FILE ON THE MODS     *   FILE 316
//*                     TAPES.                                      *   FILE 316
//*                                                                 *   FILE 316
//*       ASKOPER   1   PASS OPERATOR A QUESTION IN A PARM AND TWO  *   FILE 316
//*                     REPLIES; ONE GIVES RC=0 AND SECOND  RC=4    *   FILE 316
//*                                                                 *   FILE 316
//*       ASMBOX1   1   PUT A NICE LOOKING BOX AROUND YOUR ASSEMBLY *   FILE 316
//*                     LISTING OUTPUT.  LINECT FOR ASSEMBLY        *   FILE 316
//*                     LISTING IS 53.  CODE IS 3800 DEPENDENT.     *   FILE 316
//*                                                                 *   FILE 316
//*       ASMHNOX   1   A PTF FOR AN ASSEMBLER H BUG.               *   FILE 316
//*                     AS YOU KNOW ASM H IS CLASS C NOW.           *   FILE 316
//*                                                                 *   FILE 316
//*       ASMR90    1   ROTATE 90 DEGREES ASSEMBLY LISTINGS         *   FILE 316
//*                     ON THE 3800 TYPE PRINTERS.                  *   FILE 316
//*                                                                 *   FILE 316
//*       BLOKHD    1X  GODDARD SPACE FLT CENTER UTILITY TO         *   FILE 316
//*                     PRODUCE 12X12 BLOCK LETTERS UP TO 8 ACROSS  *   FILE 316
//*                     THE PAGE AND FOUR BLOCK LINES PER PAGE.     *   FILE 316
//*                                                                 *   FILE 316
//*       BLOKHF    1X  FORTRAN INTERFACE MODULE SO YOU CAN CALL    *   FILE 316
//*                     'BLOKHD' FROM FORTRAN CODE.                 *   FILE 316
//*                                                                 *   FILE 316
//*       BLOKLTR   1X  FORTRAN PGM THAT PRODUCES BLOCK LETTERS ONE *   FILE 316
//*                     PER PAGE (SIDEWAYS).                        *   FILE 316
//*                                                                 *   FILE 316
//*       BLOKPDS   1X  TAKES A SEQUENTIAL SOURCE FILE CREATED BY   *   FILE 316
//*                     UTIL 'LISTPDS' AND CREATES A PRINT FILE     *   FILE 316
//*                     WITH 12X12 BLOCK LETTERS BEFORE EACH MEMBER *   FILE 316
//*                     IN THE LISTING.  GREAT FOR PUTTING SOURCE   *   FILE 316
//*                     ON MICROFICHE.  SEE DOC IN CODE.            *   FILE 316
//*                                                                 *   FILE 316
//*       CATLIST   1   THIS PROGRAM IS FROM MIKE LOOS, FAIR, ISAAC *   FILE 316
//*                     AND CO.  THIS WILL DO A VERY FAST LIST OF   *   FILE 316
//*                     AN ICF CATALOG FOR GDG'S AND NONVSAM DSNS.  *   FILE 316
//*                     LISTING IS IN THE SAME FORMAT AS IDCAMS     *   FILE 316
//*                     (WE USED IT TO BUILD A TMC) BUT THE OUTPUT  *   FILE 316
//*                     FORMAT WOULD BE VERY EASY TO CHANGE.  SEE   *   FILE 316
//*                     COMMEMTS IN THE CODE FOR AN EXPLANATION     *   FILE 316
//*                     OF ITS SPEED AND RELATION TO RACF.          *   FILE 316
//*                                                                 *   FILE 316
//*       COPYFILE  4X  POWERFUL COPY TAPE TYPE PROGRAM.  IF YOU    *   FILE 316
//*                     HAVE MULTIFILE SL TAPES WILL COPY SELECTED  *   FILE 316
//*                     FILES VIA A CONTROL CARD.  (LOAD MODULE IS  *   FILE 316
//*                     ON FILE 035.)  Now copies blocks up to      *   FILE 316
//*                     64K in size.  New version by Sam Golob,     *   FILE 316
//*                     which improves the control card scanning.   *   FILE 316
//*                                                                 *   FILE 316
//*       COPYFI##      Newer version of COPYFILE, 3 members in     *   FILE 316
//*                     IEBUPDTE or PDSLOAD (File 093) format.      *   FILE 316
//*                                                                 *   FILE 316
//*       COPYSLNL  4X  POWERFUL COPY TAPE PGM TO STRIP TAPE        *   FILE 316
//*                     LABELS FROM SL TAPE TO CREATE AN NL TAPE.   *   FILE 316
//*                     IF YOU HAVE MULTIFILE SL TAPES WILL COPY    *   FILE 316
//*                     SELECTED FILES TO AN NL OUTPUT TAPE,        *   FILE 316
//*                     UNDER THE SAME CONTROL CARD SYNTAX AS       *   FILE 316
//*                     COPYFILE HAS.  (MODIFIED FROM COPYFILE      *   FILE 316
//*                     BY SAM GOLOB).  STILL HAS TLPRINT SUPPORT   *   FILE 316
//*                     BUT IT PRINTS THE CONTENTS OF THE LABELS    *   FILE 316
//*                     FROM THE INPUT SIDE, SINCE THE OUTPUT SIDE  *   FILE 316
//*                     DOESN'T HAVE LABELS ANY MORE.  Now copies   *   FILE 316
//*                     blocks up to 64K in size.  New version.     *   FILE 316
//*                     Same control card scanning as COPYFILE.     *   FILE 316
//*                                                                 *   FILE 316
//*       COPYSL##      Newer version of COPYSLNL, 3 members in     *   FILE 316
//*                     IEBUPDTE or PDSLOAD (File 093) format.      *   FILE 316
//*                                                                 *   FILE 316
//*       COPYNLNL      Brand new.  Powerful tape copy program      *   FILE 316
//*                     that works exactly like COPYFILE with       *   FILE 316
//*                     the same control cards, but copies NL to    *   FILE 316
//*                     NL tapes.  Copies blocks up to 64K.         *   FILE 316
//*                     New version.  Same control card scanning    *   FILE 316
//*                     as COPYFILE.                                *   FILE 316
//*                                                                 *   FILE 316
//*       COPYNL##      Newer version of COPYNLNL, 3 members in     *   FILE 316
//*                     IEBUPDTE or PDSLOAD (File 093) format.      *   FILE 316
//*                                                                 *   FILE 316
//*       COPYREC   5X  PROVIDE FOR A SELECTIVE COPY OF RECORDS     *   FILE 316
//*                     VIA A CONTROL CARD FOR ANY LRECL FILE;      *   FILE 316
//*                     LIKE 1-100, 450-800, 900-950.               *   FILE 316
//*                                                                 *   FILE 316
//*       CT        3X  AIR FORCE DEVELOPED HIGH SPEED TAPECOPY     *   FILE 316
//*                     PROGRAM.  RUNS AT EXCP SPEED.  COPIES       *   FILE 316
//*                     LABELED OR UNLABELED, SINGLE OR MULTIFILE,  *   FILE 316
//*                     AND IF ONE REEL ONLY, AN OPTION TO VERIFY   *   FILE 316
//*                     BYTE FOR BYTE.  COPIES MULTIVOLUME OR       *   FILE 316
//*                     MULTIFILE AND MULTIVOLUME WITH NO VERIFY    *   FILE 316
//*                     FUNCTION.                                   *   FILE 316
//*                                                                 *   FILE 316
//*       C3PO      1Y  BRIAN SCOTT NOW OF TEXACO, WROTE C3PO TO    *   FILE 316
//*                     BE THE SRB RECEIVER FOR R2D2.  R2D2 NEEDS   *   FILE 316
//*                     A TASK OF SOME KIND GOING TO BUMP THE SRB   *   FILE 316
//*                     OFF OF.  MOST PEOPLE HAVE BEEN USING #CMD   *   FILE 316
//*                     SUBSYSTEM AND SOME OTHER BRAVE SOULS,       *   FILE 316
//*                     JES2.  PLUS NOW C3PO WILL TALK TO YOU IF    *   FILE 316
//*                     YOU WANT.  WANT TO INCREASE ITS             *   FILE 316
//*                     VOCABULARY?  YOU ARE WELCOME.  HAVE NOT     *   FILE 316
//*                     INSTALLED IT THIS WAY BUT WILL WHEN I GO    *   FILE 316
//*                     TO MVS/SP1.3.                               *   FILE 316
//*                                                                 *   FILE 316
//*       C3PO2     1Y  SAME AS ABOVE, BUT WITH A STIMER IN IT FOR  *   FILE 316
//*                     PEOPLE WHO DO NOT WANT TO RUN C3PO WITH     *   FILE 316
//*                     TIME=1440.                                  *   FILE 316
//*                                                                 *   FILE 316
//*       DELINK0   2   SOURCE CARDS FOR IBM FE PROGRAM TO          *   FILE 316
//*                     'DELINK'.  WE RECONSTRUCTED THE SOURCE      *   FILE 316
//*                     IMAGES WITH A DISASSEMBLER AND A LOT OF     *   FILE 316
//*                     PATIENCE.  FUN !!!                          *   FILE 316
//*                                                                 *   FILE 316
//*       DISKMAP   3Y  DISKMAP PROGRAM HAS 3330 SUPPORT, 3350, AND *   FILE 316
//*                     3850 SUPPORT INCLUDED.  GIVES SIMILIAR INFO *   FILE 316
//*                     TO A COMPAKTOR MAP.  THIS DOES NOT UPDATE   *   FILE 316
//*                     LASTUSE DATE FOR EVERY FILE ON THE PACK;    *   FILE 316
//*                     NOT REALLY TRUE FOR PDS'S, SO STILL BEWARE. *   FILE 316
//*                                                                 *   FILE 316
//*       DOWEGO    2X  PGM TO PUT OUT QUESTION TO OPERATOR OF 'GO' *   FILE 316
//*                     OR 'NOGO'. 'NOGO' IMPLIES ABEND, 'GO' = RC0 *   FILE 316
//*                                                                 *   FILE 316
//*       EALSD095  1X  EASTERN AIRLINES UPDATE OF THE STANDARD IBM *   FILE 316
//*                     BLOCK LETTER ROUTINE IEFSD095; WAS USED     *   FILE 316
//*                     FOR BANNER PAGES.  THE UPDATED VERSION HAS  *   FILE 316
//*                     ALL THE SPECIAL CHARACTERS INCLUDED IN IT.  *   FILE 316
//*                                                                 *   FILE 316
//*       EXCPMOD   1Y  MOD (ZAP) SHOWS EXCP COUNTS ON JCL LISTING. *   FILE 316
//*                     MVS/SP1.1                                   *   FILE 316
//*                                                                 *   FILE 316
//*       EXIMPORT  1   THIS PROGRAM IS FROM MIKE LOOS, FAIR, ISAAC *   FILE 316
//*                     AND COMPANY.  WILL CREATE 2 JCL FILES, A    *   FILE 316
//*                     CLIST, AND A SYSPRINT LISTING.  THE JCL     *   FILE 316
//*                     FILES HAVE A SET OF EXPORT AND IMPORT JCL   *   FILE 316
//*                     DESIGNED TO EXPORT (VSAM) AND IEBGENER      *   FILE 316
//*                     (DSORG=PS) ALL DATASETS ON A VOLUME TO      *   FILE 316
//*                     TAPE AND RESTORE WITH IMPORT (VSAM) AND     *   FILE 316
//*                     IEBGENER (DSORG=PS) FROM TAPE TO DISK.      *   FILE 316
//*                     THE VSAM PORTION WORKS ONLY FOR UNIQUE      *   FILE 316
//*                     DATASETS (DFEF) AND BASE CLUSTERS ONLY.     *   FILE 316
//*                     SEE THE CODE FOR FURTHER EXPLANATIONS AND   *   FILE 316
//*                     RESTRICTIONS.                               *   FILE 316
//*                                                                 *   FILE 316
//*       EXIT002   1Y  JES2/SP1.3 EXIT 2.  TAKES TIME OFF THE      *   FILE 316
//*                     JOBCARD TO ENFORCE INTERNAL STANDARD FOR    *   FILE 316
//*                     JOB CLASS FROM AFDSC.                       *   FILE 316
//*                                                                 *   FILE 316
//*       EXIT006   1Y  JES2/SP1.3 EXIT 6.  PUT TIME BACK ON        *   FILE 316
//*                     JOBCARD FOR THE APPROPRIATE JOB CLASS.      *   FILE 316
//*                     ALSO SEE NOTE OF HOW TO DISPLAY INTERNAL    *   FILE 316
//*                     TEXT FOR ANY FIELD YOU WANT TO DISPLAY.     *   FILE 316
//*                     FROM AFDSC.                                 *   FILE 316
//*                                                                 *   FILE 316
//*       FCBLIST   2   WILL PRINT OUT HOW YOUR FCB'S ARE BUILT.    *   FILE 316
//*                     HANDY FOR FIGURING OUT HOW CRITTERS ARE     *   FILE 316
//*                     MADE.                                       *   FILE 316
//*                                                                 *   FILE 316
//*       FFYCOPY   2X  SUBSTITUTE FOR IEBGENER, HIGH SPEED COPY    *   FILE 316
//*                     USING BSAM VERSUS QSAM.                     *   FILE 316
//*                     (Fixed to make sure output DCB attributes   *   FILE 316
//*                     are the same as input. Or you can overlay,  *   FILE 316
//*                     using PARM=O  (letter O)                    *   FILE 316
//*                                                                 *   FILE 316
//*       FINDAZAP  1X  BILL GODFREY:  FIND A STRING IN A LOAD      *   FILE 316
//*                     MODULE & MAKE A ZAP FROM IT.  PGM DOES NOT  *   FILE 316
//*                     CHANGE LOAD MODULE BUT GENERATES 'AMASPZAP' *   FILE 316
//*                     CONTROL CARDS.                              *   FILE 316
//*                                                                 *   FILE 316
//*       GETDATE   1X  ANOTHER PGM TO DO DATE CONVERSION.  ALSO    *   FILE 316
//*                     RETURNS THE DAY OF THE WEEK AND ALSO A      *   FILE 316
//*                     FLAG IF IT IS A USER DEFINED HOLIDAY.       *   FILE 316
//*                     USEFUL IN PGMS FOR SMF.                     *   FILE 316
//*                                                                 *   FILE 316
//*       IDATE     1   SEE PGM DOCUMENTATION TO SEE ALL THE WAYS   *   FILE 316
//*                     IT CAN CONVERT A DATE, MANY, MANY,......    *   FILE 316
//*                                                                 *   FILE 316
//*       IEECVXIT  1   COMBINED VERSION OF 'IEECVXIT &             *   FILE 316
//*                     'IEECR2D2'.  CODED THE WAY IT SHOULD BE IF  *   FILE 316
//*                     YOU ARE A GENIUS.  SCHEDULES AN SRB TO GET  *   FILE 316
//*                     AROUND THE FACT THEY MOVED THE WQE CHAIN    *   FILE 316
//*                     IN SP1.3.  NEEDS A TASK RUNNING ALL THE     *   FILE 316
//*                     TIME TO BUMP THE SRB OFF OF WHEN IEECR2D2   *   FILE 316
//*                     IS RUN.  CODER USED THE #CMD SUBSYSTEM,     *   FILE 316
//*                     YOU COULD HAVE USED JES2 HE SAYS.  TIME     *   FILE 316
//*                     DEPENDENT CODE HAS BEEN REMOVED AND IT      *   FILE 316
//*                     WORKS IN ALL VERSIONS OF MVS/SP (AS OF A    *   FILE 316
//*                     WHILE AGO).  WE ARE SAVED !!                *   FILE 316
//*                                                                 *   FILE 316
//*                     AFDSC DEVELOPED 'MCS EXIT'.  CAPABILITY     *   FILE 316
//*                     TO SUPPRESS OR CHANGE ROUTE CODES, DESC,    *   FILE 316
//*                     CODES, ETC. BUT THIS ONE WILL UTILIIZE      *   FILE 316
//*                     'R2D2' TO DO AUTOMATIC OPERATOR REPLIES     *   FILE 316
//*                     AND STC'S BASED UPON WHAT COMES ACROSS THE  *   FILE 316
//*                     CONSOLE.  NOT DEPENDENT UPON THE OPERATOR   *   FILE 316
//*                     BEING AWAKE.  AFDSC DEVELOPED VERSION OF    *   FILE 316
//*                     FAMOUS 'R2D2'.  LITTLE CREATURE DOES        *   FILE 316
//*                     AUTOMATIC START CMDS FOR THINGS THAT NEED   *   FILE 316
//*                     STARTING, BASED UPON WHAT COMES ACROSS THE  *   FILE 316
//*                     SCREEN AND IS DETECTED BY IEECVXIT.  R2D2   *   FILE 316
//*                     DOES THE AUTOMATIC REPLIES, RMF (R XX,GO),  *   FILE 316
//*                     ALLOCATION (R XX,NOHOLD).  EVER HAD THE     *   FILE 316
//*                     OPERATOR TURN YOUR MVS SYSTEM INTO OS/MVT   *   FILE 316
//*                     SYSTEM BY LOCKING Q4 (R XX,HOLD)?  LITTLE   *   FILE 316
//*                     CRITTER HAS A LOT OF POSSIBILITIES.         *   FILE 316
//*                                                                 *   FILE 316
//*       IEFUJI    1   IBM STANDARD SMF EXIT, IEFUJI.  HAS CODE TO *   FILE 316
//*                     PASS USER FIELDS TO UCC-1 (NOW CA-1).       *   FILE 316
//*                                                                 *   FILE 316
//*       IEFUTL    2   IBM STANDARD SMF EXIT, IEFUTL.  WAIT TIME & *   FILE 316
//*                     CPU TIME EXCESSION FOR BATCH & TSO.  LITTLE *   FILE 316
//*                     CODE BUT ONE THING IT CAN DO IS TO STOP     *   FILE 316
//*                     S522 ABENDS CAUSED BY OPERATORS.            *   FILE 316
//*                                                                 *   FILE 316
//*       IEFU29    1   DETECT SMF SWITCH & SCHEDULE JOB THAT DUMPS *   FILE 316
//*                     SMF DATASETS.  MOVED FUNCTION FROM THE MCS  *   FILE 316
//*                     EXIT TO THIS EXIT (WHERE IT SHOULD BE).     *   FILE 316
//*                                                                 *   FILE 316
//*       IEFU83    3   AFDSC DEVELOPED SMF EXIT, 'IEFU83'.  HAS    *   FILE 316
//*                     ALL STANDARD SUGGESTIONS, TYPE 40 RECS, 0   *   FILE 316
//*                     EXCP COUNTS, ETC.  THIS IS BRANCH TABLE     *   FILE 316
//*                     DRIVEN, GOOD PLACE TO BEGIN FOR THOSE WHO   *   FILE 316
//*                     WANT TO EXPAND ITS CODE.  ALSO LOOKS AT     *   FILE 316
//*                     14&15'S ETC.  ADDED TYPE 21 SUPPORT TO      *   FILE 316
//*                     TELL OPERATORS TO CLEAN TAPE DRIVES         *   FILE 316
//*                     ENCOUNTERING PERM CHECK OR TOO MANY TEMP    *   FILE 316
//*                     ERRORS.  LOOKS AT TOTAL CPU TIME AND        *   FILE 316
//*                     JOBCLASS TELLING USER WHAT CLASS SHOULD     *   FILE 316
//*                     HAVE BEEN USED.                             *   FILE 316
//*                                                                 *   FILE 316
//*       INCORZAP  2   SOURCE FOR FAMOUS 'INCORZAP' THAT IS KNOWN  *   FILE 316
//*                     ONLY IN OBJECT FORM.  THANKS BILL GODFREY   *   FILE 316
//*                     FOR DISASSEMBLY AND PATIENCE.  THIS PGM     *   FILE 316
//*                     SOURCE WAS A SPRINGBOARD FOR THE ORIGINAL   *   FILE 316
//*                     AUTHOR OF THE PROGRAM TO UPGRADE IT TO XA   *   FILE 316
//*                     (AND BEYOND).  SEE FILE 421.                *   FILE 316
//*                                                                 *   FILE 316
//*       IGG019WD  1X  APPENDAGE FOR RECOVERY FROM WRONG DENSITY   *   FILE 316
//*                     TAPE VOLUMES, USED BY TAPE UTLITIES.        *   FILE 316
//*                                                                 *   FILE 316
//*       IGG019WE  1X  APPENDAGE TO PREVENT ERROR AT EOF, USED BY  *   FILE 316
//*                     TAPE UTILITIES.                             *   FILE 316
//*                                                                 *   FILE 316
//*       INCORZZP  1   ZAP TO THE 'INCORZAP' PROGRAM SO IT WILL    *   FILE 316
//*                     RUN UNDER ANY NAME.                         *   FILE 316
//*                                                                 *   FILE 316
//*       J13X1     3   SP1.3 EXIT.  SEPARATOR (PRINT & PUNCH) FOR  *   FILE 316
//*                     JES2.  HAS EXIT255 INVOKED TO PRINT OFF A   *   FILE 316
//*                     RECEIPT ON SEPARATE IBM3287 MCS PRINTER.    *   FILE 316
//*                     ADDED SOME CODE FOR PRINTING OFF NJE PRT    *   FILE 316
//*                     FROM VM/RSCS.  ALSO ADDED SOME CODE FOR     *   FILE 316
//*                     X8700 PRT.                                  *   FILE 316
//*                     CONVERTED TO JES2/SP1.3.4                   *   FILE 316
//*                                                                 *   FILE 316
//*       J13X1ACT  2   SP1.3 EXIT.  ACCOUNT USED TO BILL X8700     *   FILE 316
//*                     PRINTER TO VM/RSCS/NJI PRINT.  RSCS OUTPUT  *   FILE 316
//*                     DOESN'T COME ACROSS WITH JES2 ACCT INFO     *   FILE 316
//*                     IN THE JOBCARD.                             *   FILE 316
//*                                                                 *   FILE 316
//*       J13X1XF   2   SP1.3 EXIT.  X8700 VALID FORMS USED TO      *   FILE 316
//*                     BUILD 'DJDE' RECORD TO BE PUMPED TO X8700   *   FILE 316
//*                     PRINTER.                                    *   FILE 316
//*                                                                 *   FILE 316
//*       J13X3     1   JES2/SP1.3 EXIT3.  JOB CARD SCAN EXIT,      *   FILE 316
//*                     ALSO HAS OTHER FEATURES.  WE DO VALIDATION  *   FILE 316
//*                     OF ACCT CODES ON JOB CARD.                  *   FILE 316
//*                     CONVERTED TO JES2/SP1.3.4                   *   FILE 316
//*                                                                 *   FILE 316
//*       J13X4     1   JES2/SP1.3 EXIT4.  JECL SCAN EXIT.          *   FILE 316
//*                     CONVERTED TO JES2/SP1.3.4                   *   FILE 316
//*                                                                 *   FILE 316
//*       J13X10    1   JES2/SP1.3 EXIT10.  SUPPRESS JES2 WTO       *   FILE 316
//*                     MESSAGES.  JOB RECEIPT GENERATED FOR ALL    *   FILE 316
//*                     PARTS OF JOB THAT ARE PRINTED LOCALLY.      *   FILE 316
//*                     IS BECAUSE JES EXIT 1 PRODUCES RECEIPTS     *   FILE 316
//*                     TO A 3287 TYPE PRINTER ALL PARTS OF A JOB   *   FILE 316
//*                     PRINTED LOCALLY.  THANKS CAPT JIM CARTER    *   FILE 316
//*                     AND LT PAUL FINDLEY.                        *   FILE 316
//*                     CONVERTED TO JES2/SP1.3.4                   *   FILE 316
//*                                                                 *   FILE 316
//*       J13X13    1   JES2/SP1.3 EXIT13. TSO/E EXIT.              *   FILE 316
//*                                                                 *   FILE 316
//*       J13X255   2   JES2/SP1.3 EXIT255.  THIS IS MY EXIT THAT   *   FILE 316
//*                     IS INVOKED BY USER EXIT001 TO PRINT A       *   FILE 316
//*                     RECEIPT ON IBM3287 MCS PRINTER SET TO       *   FILE 316
//*                     ROUTCDE=(14).  OPERATORS NOW KNOW HOW       *   FILE 316
//*                     MANY LISTINGS THEY WILL FIND ON THE         *   FILE 316
//*                     PRINTERS.  CONVERTED TO JES2/SP1.3.4        *   FILE 316
//*                                                                 *   FILE 316
//*       JESXRDR   1Y  HURRAY BILL GODFREY, MY GENIUS.  YOU CAN    *   FILE 316
//*                     SUBMIT TO A SECONDARY JES2 LIKE JESX FROM   *   FILE 316
//*                     THIS PGM.  LOOK IN TSOSRC FILE YOU WILL     *   FILE 316
//*                     FIND, SUBMITX' ALLOWS YOU TO SUBMIT FROM    *   FILE 316
//*                     TSO TO A SECONDARY JES2.  (ALSO YOU GET     *   FILE 316
//*                     OUTPUTX, CANCELX, AND STATUSX WITH          *   FILE 316
//*                     SUBMITX).  MAY NOT WORK BEYOND JES2/SP1.1.  *   FILE 316
//*                                                                 *   FILE 316
//*       JES0001   1Y  SMP USERMOD TO ALLOW YOU TO DO TSO IN       *   FILE 316
//*                     SECONDARY JES, ALSO STC'S ETC ETC.          *   FILE 316
//*                     MAY NOT WORK BEYOND JES2/SP1.1              *   FILE 316
//*                                                                 *   FILE 316
//*       LISTCTLG  1Y  LISTS OS CATALOGS EFFICIENTLY.  UPDATED FOR *   FILE 316
//*                     3400 SERIES TAPE DRIVES, 3330 TYPE DISKS,   *   FILE 316
//*                     3350'S AND, 3850 MSS.  SEE COMMENTS IN THE  *   FILE 316
//*                     CODE FOR ADDITIONAL CAPABILITIES OF THE PGM *   FILE 316
//*                                                                 *   FILE 316
//*       LISTIDR   1   IMPROVED GODDARD SPACE CENTER PROGRAM FOR   *   FILE 316
//*                     LISTING 'IDR' RECORDS.                      *   FILE 316
//*                                                                 *   FILE 316
//*       LISPDS    8.4 Same as LISTPDS, except that the date-time  *   FILE 316
//*                     stamp is removed from ./ ADD NAME=member    *   FILE 316
//*                     cards, if no ISPF statistics are present.   *   FILE 316
//*                     Version number updated to 8.1 to tell it    *   FILE 316
//*                     apart from LISTPDS.  (Now identical to      *   FILE 316
//*                     LISTPDS.  Fixed to handle extended ISPF     *   FILE 316
//*                     statistics like OFFLOAD and PDSLOAD,        *   FILE 316
//*                     which are on CBT File 093, and were copied  *   FILE 316
//*                     to this file.)                              *   FILE 316
//*                                                                 *   FILE 316
//*       LISTPDS   8.4 GODDARD SPACE FLIGHT CNTR, FAMOUS 'LISTPDS' *   FILE 316
//*                     PGM.  UPDATED SO WHEN YOU DO THE FUNCTION   *   FILE 316
//*                     SIMILIAR TO IEHLIST, LISTPDS, IT GIVES      *   FILE 316
//*                     YOU THE SPF STATS, LIKE SPF 3.1 DOES.  SEE  *   FILE 316
//*                     THE LISTPDS# FOR ALL OF ITS CAPABILITIES.   *   FILE 316
//*                     (Fixed to handle extended ISPF statistics   *   FILE 316
//*                     like OFFLOAD and PDSLOAD, which are on      *   FILE 316
//*                     CBT File 093, and were copied to this       *   FILE 316
//*                     file.)  Fixed to handle 8-character ids,    *   FILE 316
//*                     and fixed to punch ./ ALIAS cards with a    *   FILE 316
//*                     PARM of 'ALIAS'.                            *   FILE 316
//*                                                                 *   FILE 316
//*       LKEBOX1   1   PLACE NICE LOOKING BOX AROUND YOUR LKED     *   FILE 316
//*                     LISTING FOR USE IN CONJUNCTION WITH ASMBOX1 *   FILE 316
//*                                                                 *   FILE 316
//*       LKEDMOD   1   LKED EDITOR ZAP, PUT TIME & DATE INTO LOAD  *   FILE 316
//*                     MODULES MVS/3.8.                            *   FILE 316
//*                                                                 *   FILE 316
//*       LKEDMOD1  1Y  LKED EDITOR ZAP PUTS TIME & DATE INTO LOAD  *   FILE 316
//*                     MODULES MVS/SP1.1                           *   FILE 316
//*                                                                 *   FILE 316
//*       LKED90    1   ROTATE LKED OUTPUT ON IBM 3800 90 DEGREES   *   FILE 316
//*                     AND GET 2 PAGES ONTO 1.                     *   FILE 316
//*                                                                 *   FILE 316
//*       MACROS    1   PACKAGED MOST MACROS IN THIS MEMBER. LOOK   *   FILE 316
//*                     AT THE INSTALL JOBSTREAM TO SEE IF YOU WILL *   FILE 316
//*                     NEED THEM.  HAVE '><' IN PLACE OF './' IN   *   FILE 316
//*                     IEBUPDTE FORMAT SO USE 'PDSLOAD' PGM.       *   FILE 316
//*                                                                 *   FILE 316
//*                     MACROS FOR THIS FILE ARE NOW INCLUDED       *   FILE 316
//*                                                                 *   FILE 316
//*                      $-E        F-M             N-T       U-Z   *   FILE 316
//*                     $#SVCKP    FLOAT         OPENIF             *   FILE 316
//*                     $#SVCKS    IFIX          OPENIN             *   FILE 316
//*                     $REGS      LOADIT        SEARCHDD           *   FILE 316
//*                     @          LOADS         SNAPREGS           *   FILE 316
//*                     CAPS       MOVE          STAE$              *   FILE 316
//*                     CLOSEIF    MSG           TESTOPEN           *   FILE 316
//*                     COMMENT                     TRC             *   FILE 316
//*                     DFLOAT                                      *   FILE 316
//*                     EDIT                                        *   FILE 316
//*                                                                 *   FILE 316
//*       MIRROR    1X  REVERSE THE DATA ON INPUT CARD IMAGE. I.E.  *   FILE 316
//*                     1-80 IS NOW IN 80-1.                        *   FILE 316
//*                                                                 *   FILE 316
//*       MIM#3     1X  OS/MVT PGM.  USED TO BE ON OS/MVT MODS      *   FILE 316
//*                     TAPE LONG AGO.  GOOD EXAMPLE OF DOING       *   FILE 316
//*                     COMPRESSION AND DECOMPRESSION.  LOOK AT     *   FILE 316
//*                     EXTENSIVE DOC IN CODE AND YOU'LL FIND A     *   FILE 316
//*                     USE FOR IT.                                 *   FILE 316
//*                                                                 *   FILE 316
//*       MODREP    2   LPA MODULE REPLACEMENT PGM OBTAINED FROM    *   FILE 316
//*                     CBT TAPE.  MODIFIED AT AFDSC SO IT WILL NOT *   FILE 316
//*                     ABEND WITH A S522. SEVERAL OTHER BUGS FIXED *   FILE 316
//*                                                                 *   FILE 316
//*       MSGWRITE  2X  SUBROUTINE USED BY SOME OF THE UTILITIES.   *   FILE 316
//*                                                                 *   FILE 316
//*       MSSMOUNT  1   ZAP TO LET TSO USERS MOUNT MSS VOLUMES      *   FILE 316
//*                     WITHOUT HAVING MOUNT ATTRIBUTE IN 'UADS'.   *   FILE 316
//*                                                                 *   FILE 316
//*       OFFLOAD   1   UNLOAD A PDS TO A SEQUENTIAL IEBUPDTE DSN   *   FILE 316
//*                     FIXED BUG ABEND 103-4C, UNBLOCKED PDS'ES.   *   FILE 316
//*                     (UPDATED BY JOHN KALINICH, US ARMY IN ST    *   FILE 316
//*                     LOUIS, MO - TO ADD ISPF STATS IN LISTPDS    *   FILE 316
//*                     FORMAT INTO THE "./ ADD NAME=" CARDS.)      *   FILE 316
//*                     (Best version copied to here from CBT File  *   FILE 316
//*                     093.  Handles extended ISPF statistics.)    *   FILE 316
//*                                                                 *   FILE 316
//*       PACKED    1   LOOK AT ALL MEMBERS OF A PDS TO SEE IF      *   FILE 316
//*                     THEY ARE IN ISPF PACKED FORMAT OR NOT.      *   FILE 316
//*                     NEEDS 2 DD NAMES:  SYSLIB IS THE INPUT      *   FILE 316
//*                     PDS, AND SYSPRINT IS THE REPORT.            *   FILE 316
//*                                                                 *   FILE 316
//*       PARMBLOC  2   TAKE THE PARM FROM EXEC CARD AND CREATE A   *   FILE 316
//*                     BLOCK LETTER BANNER.  HAS OPTIONS TO SLANT  *   FILE 316
//*                     ETC.  NICE FOR REPORTS.                     *   FILE 316
//*                                                                 *   FILE 316
//*       PDSGAS    2X  ALLOW YOU FIND A 'GAS' MEMBER IN A PDS      *   FILE 316
//*                     PGM PROVIDED YOU HAVE NOT COMPRESSED THE    *   FILE 316
//*                     PDS.  ASSIGNS MEMBER NAME OF $GASXXXX.      *   FILE 316
//*                     XXXX GOES FROM 0001 TO 9999.  THEN IT IS    *   FILE 316
//*                     CALLED BRUTE FORCE TO GO IN WITH SPF 3.1    *   FILE 316
//*                     TO FIND IT.  BUT !!  WORKS NOW ON 3380S     *   FILE 316
//*                     AND MVS/XA 2.2.0.                           *   FILE 316
//*                                                                 *   FILE 316
//*       PDSLOAD   1   FILE WITH IEBUPDTE CONTROL CARDS IN THEM,   *   FILE 316
//*                     RELOAD TO A PDS.  WILL PUT IN SPF STATS AND *   FILE 316
//*                     USEFUL FOR FILES UNLOADED BY OFFLOAD PGM    *   FILE 316
//*                     TO FROM CBT TAPE. CHANGES THE IMBEDDED '><' *   FILE 316
//*                     TO './' AS YOU RELOAD.  BETTER VERSION OF   *   FILE 316
//*                     PDSLOAD AND OFFLOAD ARE ON FILE 093.        *   FILE 316
//*                     (Best version copied to here from CBT File  *   FILE 316
//*                     093.  Handles extended ISPF statistics,     *   FILE 316
//*                     and SYSUPLOG DD to avoid changing '><'      *   FILE 316
//*                     to './' when it shouldn't do so.)           *   FILE 316
//*                                                                 *   FILE 316
//*       PDSMATCH  1   COMPARE THE DIRECTORY OF 2 PDS'S.  HAS      *   FILE 316
//*                     MANY OPTIONS.  REFER TO COMMENTS IN THE     *   FILE 316
//*                     CODE FOR HOW TO RUN THIS UTILITY.           *   FILE 316
//*                     (Fixed by "UPDATER" to work with the PDS    *   FILE 316
//*                     utility program, and fixed some bugs.)      *   FILE 316
//*                                                                 *   FILE 316
//*       PDSPROGM  1   USED FOR DELETING & RENAMING MEMBERS OF     *   FILE 316
//*                     PDS FROM A BATCH JOB.  MUCH EASIER TO USE   *   FILE 316
//*                     THAN IEHPROGM.                              *   FILE 316
//*                                                                 *   FILE 316
//*       PDSPRINT  2X  ANOTHER PDS LIST OR PUNCH PGM.  CAN FEED    *   FILE 316
//*                     IT CONTROL CARDS FOR A MEMBER LIST OR       *   FILE 316
//*                     GIVE IT CHARACTER STRING TO SCAN FOR.       *   FILE 316
//*                     NICE.                                       *   FILE 316
//*                                                                 *   FILE 316
//*       PDSTEST   3X  VERIFIES INTEGRITY OF A LOAD MODULE PDS BY  *   FILE 316
//*                     ISSUING 'LOAD' FOR EVERY MODULE IN LOADLIB. *   FILE 316
//*                     IF PROBLEMS OCCUR, YOU ARE TOLD OF THEM.    *   FILE 316
//*                                                                 *   FILE 316
//*       PDSUTIL   1   ANOTHER PDS LIST TYPE PROGRAM.  THINGS IT   *   FILE 316
//*                     DOES, GIVES YOU A TABLE OF CONTENTS AS TO   *   FILE 316
//*                     WHAT PAGE EACH IS ON.  HANDY.               *   FILE 316
//*                                                                 *   FILE 316
//*       P38BOX1   1   SUBROUTINE FOR ASMBOX1.                     *   FILE 316
//*                                                                 *   FILE 316
//*       P38TURN   1   CHARACTER SET USED FOR 90 DEGREE ROTATE.    *   FILE 316
//*                                                                 *   FILE 316
//*       RACHECK   1Y  EL-CHEAPO RACF SECURITY SVC.  YALE UNIV.    *   FILE 316
//*                     SVC 130 MADE TO GIVE DIRT-CHEAP SECURITY.   *   FILE 316
//*                     WE USE WHITE HAT-BLACK HAT THEORY.  EITHER  *   FILE 316
//*                     YOU CAN GET TO IT OR NOT.  DOES NOT AFFECT  *   FILE 316
//*                     STC OR SYSTEM CODE.  LOOK AT SVC TO SEE HOW *   FILE 316
//*                     WE GIVE ALL POWERFUL SYSTEM PROGRAMMERS     *   FILE 316
//*                     (WHO WEAR WHITE HATS) THE PRIVILEGES.       *   FILE 316
//*                                                                 *   FILE 316
//*       READF     1   SUBRNTES-READF,WRITEF,RESETF, INTENDED FOR  *   FILE 316
//*                     USE IN PLACE OF FORTRAN UNFORMATTED I/O     *   FILE 316
//*                     (REAL DOG).  THIS USES FIXED BLOCKED QSAM.  *   FILE 316
//*                     SAVES A LOT OF CPU CYCLES.                  *   FILE 316
//*                                                                 *   FILE 316
//*       RENDS     1   ASSEMBLER BATCH PROGRAM TO RENAME A DATASET *   FILE 316
//*                     TO THE SAME NAME, BUT WITH .NEW APPENDED    *   FILE 316
//*                     TO THE NAME.  TRUE THAT TSO "RENAME" CAN    *   FILE 316
//*                     ALSO DO IT, BUT THIS IS FOR LEARNING TO     *   FILE 316
//*                     CODE IT IN AN ASSEMBLER PROGRAM, AND TO     *   FILE 316
//*                     SEE HOW TO FLAG ALL (OR MOST) POSSIBLE      *   FILE 316
//*                     ERRORS.                                     *   FILE 316
//*                                                                 *   FILE 316
//*       RESETU    1   A PROGRAM THAT CAN RESET THE USERID OF A    *   FILE 316
//*                     PDS MEMBER WITH ISPF STATS.  WHILE NOT A    *   FILE 316
//*                     TSO COMMAND, IT CAN BE RUN UNDER TSO IN THE *   FILE 316
//*                     FOREGROUND, ACCORDING TO INSTRUCTIONS THAT  *   FILE 316
//*                     ARE INCLUDED IN THE PROGRAM.                *   FILE 316
//*                                                                 *   FILE 316
//*       ROTATER   1   SUBROUTINE USED IN ROTATE PGMS.             *   FILE 316
//*                     REPLACED P38R90 AND P38R90B.                *   FILE 316
//*                                                                 *   FILE 316
//*       SEEKMON   1Y  MVS VERSION OF OS/MVT SEEKMON.              *   FILE 316
//*                                                                 *   FILE 316
//*       SETINIT   1X  SETS INITIATORS BASED ON TIME.  HAVE INITS  *   FILE 316
//*                     SET, PRIME, EVENINGS, MIDS, HOLIDAYS, ETC.  *   FILE 316
//*                                                                 *   FILE 316
//*       SPANCOPY  2X  CLEANS FILES WITH SPANNED RECS.  WILL       *   FILE 316
//*                     DROP BAD SPANNED RECS.  IF FILE CONTAINS    *   FILE 316
//*                     SMF RECS THEN WILL ATTEMPT TO GIVE YOU      *   FILE 316
//*                     AS MUCH INFO AS IT CAN.  S002 ABENDS ARE    *   FILE 316
//*                     NO LONGER KILLERS.                          *   FILE 316
//*                                                                 *   FILE 316
//*       SMFDATE   1X  REPORTS ON TOTAL SMF RECORDS BY DAY PLUS    *   FILE 316
//*                     NUMBER OF BATCH JOBS RUN AND TSO SESSIONS.  *   FILE 316
//*                                                                 *   FILE 316
//*       SMFXTRCT  8X  RENAMED TO SMFXTRK, 15 MARCH 1991.          *   FILE 316
//*                                                                 *   FILE 316
//*       SMFXTRK   9X  GENERALIZED SMF RECORD EXTRACTION UTILITY.  *   FILE 316
//*                     SELECT BY RECORD TYPE, DATE INTERVAL, TIME  *   FILE 316
//*                     INTERVAL, ETC.  REBLOCKS FROM VBS TO VB !   *   FILE 316
//*                     REPORTS ON NUMBER OF RECS AND MAX + MIN.    *   FILE 316
//*                     SEE CODE FOR ALL CAPABILITIES.              *   FILE 316
//*                                                                 *   FILE 316
//*       SMF21RP   1X  REPORT SMF 21 RECORDS ON TAPE ERRORS,       *   FILE 316
//*                     ALTERNATIVE TO IBM UTILITY 'IFHSTATR'.      *   FILE 316
//*                                                                 *   FILE 316
//*       SMF48RP   1X  REPORT FROM SMF 48 RECORDS ON BSC RJE       *   FILE 316
//*                     STATS.  MOST IMPORTANTLY, LINE ERRORS.      *   FILE 316
//*                                                                 *   FILE 316
//*       SMF50RP   1X  REPORT FROM SMF 50 RECS, VTAM TUNING STATS. *   FILE 316
//*                                                                 *   FILE 316
//*       SMF53RP   1X  REPORT FROM SMF 53 RECS, SNA RJE STATS AND  *   FILE 316
//*                     MOST IMPORTANTLY, LINE ERRORS.              *   FILE 316
//*                                                                 *   FILE 316
//*       SMF71FP   1X  REPORT FROM RMF 71 RECORDS ON FRAMES FOR    *   FILE 316
//*                     PRIVATE ADDRESS SPACES.                     *   FILE 316
//*                                                                 *   FILE 316
//*       SMF71FR   1X  RMF 71 FRAMES REPORT ON CSA FRAMES.         *   FILE 316
//*                                                                 *   FILE 316
//*       SMF71LF   1X  RMF 71 FRAMES REPORT ON LPA FRAMES.         *   FILE 316
//*                                                                 *   FILE 316
//*       SMF71LP   1X  RMF 71 NVIO PAGING REPORT.                  *   FILE 316
//*                                                                 *   FILE 316
//*       SMF71PN   1X  RMF 71 RATE OF NON-VIO RECLAIMS,            *   FILE 316
//*                     PAGE-IN-OUTS.                               *   FILE 316
//*                                                                 *   FILE 316
//*       SMF71UP   1X  RMF 71 UIC COUNTS VS NVIO & NSWAP PAGING.   *   FILE 316
//*                                                                 *   FILE 316
//*       SMF71VP   1X  RMF 71 RATE OF PAGING OF VIO.               *   FILE 316
//*                                                                 *   FILE 316
//*       SMF71XF   1X  RMF 71 FRAMES REPORTS FIXED FRAMES ABOVE    *   FILE 316
//*                     AND BELOW 16M LINE.                         *   FILE 316
//*                                                                 *   FILE 316
//*       SMF72RP   2X  CONVERTED WORKLOAD ACTIVITY RPT FROM MF/1   *   FILE 316
//*                     TO USE RMF 72 RECORDS.  MAY BE OF INTEREST. *   FILE 316
//*                                                                 *   FILE 316
//*       SMPERS4   1X  SAS VERSION OF THE BELOW FOR SMP R4.        *   FILE 316
//*                                                                 *   FILE 316
//*       SMPERS5   1X  SAS VERSION OF THE BELOW FOR SMP R5.        *   FILE 316
//*                                                                 *   FILE 316
//*       SMPER5A   1X  ASM LANG VERSION OF SMP HOLDERROR REPORT    *   FILE 316
//*                     FOR SMP5.  SAYS IF PTFS APPLIED ARE IN      *   FILE 316
//*                     HOLD STATUS.                                *   FILE 316
//*                                                                 *   FILE 316
//*       STAE$     1   GENERALIZED ESTAE EXIT FOR MVS.  SEE        *   FILE 316
//*                     COMMENTS FOR ITS CAPABILITIES.              *   FILE 316
//*                                                                 *   FILE 316
//*       STRMACS   1X  STRUCTURED PROGRAMMING MACROS FOR ASSEMBLY  *   FILE 316
//*                     LANG CODING.  WAS CALLED 'CONCEPT 14' LONG  *   FILE 316
//*                     AGO AND NEVER REALLY CAUGHT ON.  WILL SEE   *   FILE 316
//*                     CODE WRITTEN IN IT AND THESE SHOULD WORK.   *   FILE 316
//*                     MACROS INCLUDED ARE AS FOLLOWS:             *   FILE 316
//*                                                                 *   FILE 316
//*                                                                 *   FILE 316
//*                     CASE      ELSE        EXITIF     POPNEST    *   FILE 316
//*                     CASENTRY  ENDCASE     GBLVARS    PUSHINS    *   FILE 316
//*                     CHKSTACK  ENDDO       GETCC      PUSHLAB    *   FILE 316
//*                     DO        ENDLOOP     IF         PUSHNEST   *   FILE 316
//*                     DOEXIT    ENDSRCH     IFPROC     STKINS     *   FILE 316
//*                     DOPROC    EXIT        POPINS     STRTDO     *   FILE 316
//*                                                      STRTSRCH   *   FILE 316
//*                                                                 *   FILE 316
//*       SYSLOG    1X  WRITE YOUR OPERATOR LOGS SAFELY AND ALWAYS  *   FILE 316
//*                     IN ORDER.  SEE CODE FOR DETAILS.            *   FILE 316
//*                                                                 *   FILE 316
//*       SYSREPRO  1X  SEQUENTIAL COPY UTILITY.  IT IS LIKE        *   FILE 316
//*                     IEBGENER BUT MUCH FASTER.  PRINTS OUT       *   FILE 316
//*                     DSNAMES, VOLSERS, DCB, ATTRIBUTES,          *   FILE 316
//*                     FILE SEQ NUMBER FOR EACH DATASET.           *   FILE 316
//*                                                                 *   FILE 316
//*       TANAL     3X  DO QUICK SCAN OF UNLABELED OR LABELED       *   FILE 316
//*                     TAPE TO GIVE YOU THE MAX AND MIN BLKSIZES   *   FILE 316
//*                     IN ALL FILES AND THE NUMBER OF BLOCKS       *   FILE 316
//*                     IN THE FILE.                                *   FILE 316
//*                                                                 *   FILE 316
//*       TAPEL     3X  GIVES YOU A QUICK SCAN OF A TAPE AND        *   FILE 316
//*                     GIVES INFO ON EACH FILE IN EASY TO READ     *   FILE 316
//*                     FORM.  IS FOR THE NOT TOO BRIGHT USER YOU   *   FILE 316
//*                     MAY HAVE.                                   *   FILE 316
//*                                                                 *   FILE 316
//*       TAPELZAP  1Y  ZAP TO FORCE OPER REPLY WITH 6 CHAR VOLSER  *   FILE 316
//*                     ON TAPE.  DECREASE TAPES WITH VOL=SER=U     *   FILE 316
//*                     MVS/SP1.1                                   *   FILE 316
//*                                                                 *   FILE 316
//*       TAPEMAP   1X  FAMOUS 'TAPEMAP' PGM IN SOURCE CARD FORM.   *   FILE 316
//*                     SURPRISING WHAT YOU CAN DO WITH A DISASS-   *   FILE 316
//*                     EMBLER AND A LOT OF TIME AND PATIENCE.      *   FILE 316
//*                                                                 *   FILE 316
//*       TAPESCAN  1   MVS UPDATED VERSION FAMOUS 'TAPESCAN'.      *   FILE 316
//*                                                                 *   FILE 316
//*       TAPESC44  1   MVS UPDATED VERSION FAMOUS 'TAPESCAN'. UPD  *   FILE 316
//*                     TO R4.4 FOR 3480 SUPPORT BY FRANK PAJERSKI. *   FILE 316
//*                     THE MAN IS NOTHING SHORT OF "GREAT".        *   FILE 316
//*                                                                 *   FILE 316
//*       TIDY      1   CLEANS UP FORTRAN CODE.  LOOK AT COMMENTS   *   FILE 316
//*                     IN CODE TO SEE HOW TO RUN THE BEAST.        *   FILE 316
//*                                                                 *   FILE 316
//*       TIDYASM   1   CLEANS UP ALC CODE.  SEE COMMENTS IN CODE   *   FILE 316
//*                     TO SEE HOW TO RUN THE BEAST.                *   FILE 316
//*                                                                 *   FILE 316
//*       TLABEL    2   REPLACES IBM UTILITY 'IEHINITT'.  OPERATOR  *   FILE 316
//*                     STARTABLE AND WILL ALLOW YOU TO PUT A       *   FILE 316
//*                     LABEL TO A TAPE OR JUST PUT A TAPEMARK      *   FILE 316
//*                     ONTO THE TAPE.  (RUNS AUTHORIZED)           *   FILE 316
//*                                                                 *   FILE 316
//*       TLPRINT   3X  SUBROUTINE USED BY SOME TAPE UTILITIES TO   *   FILE 316
//*                     FORMAT A LABEL OF A TAPE.                   *   FILE 316
//*                                                                 *   FILE 316
//*       TMSLABL   1   FRONT-END TO UCC1 TMSTPNIT TO LABEL TAPES.  *   FILE 316
//*                     GETS AROUND SC03 ABEND PROBLEM WITH         *   FILE 316
//*                     MULTI-LINKS.  WE ATTACH INSTEAD.            *   FILE 316
//*                                                                 *   FILE 316
//*       TOD       1   PGM WHICH GETS THE TIME FROM THE SYSTEM BY  *   FILE 316
//*                     'STORE CLOCK' INSTRUCTION AND PASSES IT TO  *   FILE 316
//*                     SUBPROGRAM CALLED "TODCNVRT".               *   FILE 316
//*                 4   (Fixed Mar 23,2014 to prettify the output   *   FILE 316
//*                     and make it displayable via PUTLINE. Also   *   FILE 316
//*                     assemble and link together with TODCNVRT,   *   FILE 316
//*                     so TODCNVRT doesn't have to be LOADed       *   FILE 316
//*                     and DELETEd.)                               *   FILE 316
//*                                                                 *   FILE 316
//*       TODCNVRT  1   SUBPGM CONVERTS THE RESULTS OF THE 'STCK'   *   FILE 316
//*                     INSTRUCTION TO EBCDIC.  LOGIC FROM MODULE   *   FILE 316
//*                     AMDPRSEG IN AMDPRDMP (WITH A FEW MODS)      *   FILE 316
//*                     MAKES PARAMETER PASSING EASIER.             *   FILE 316
//*                                                                 *   FILE 316
//*       UADLIST       PRODUCE OUTPUT FROM READING SYS1.UADS.      *   FILE 316
//*                     (Fixed by BG.)                              *   FILE 316
//*                     (CLIST UADL to see results at the terminal) *   FILE 316
//*                                                                 *   FILE 316
//*       UADSORT   2   READ AND PRINT CONTENTS OF 'SYS1.UADS' BY   *   FILE 316
//*                     TRAVELING THROUGH THE RECORDS.              *   FILE 316
//*                     (Fixed by BG.)                              *   FILE 316
//*                                                                 *   FILE 316
//*       UNIVERT   1   PGM TO CONVERT CARD DECK DATA BACK & FORTH  *   FILE 316
//*                     TO UNIVAC(FIELDATA).  USES UNIVAC TRANSLATE *   FILE 316
//*                     TABLES IN 2ND CSECT.                        *   FILE 316
//*                                                                 *   FILE 316
//*       USRGUIDE  1   THIS IS THE 2ISG USER'S GUIDE.  HOPEFULLY   *   FILE 316
//*                     IT WILL GIVE YOU AN IDEA OF HOW ONE PLACE   *   FILE 316
//*                     WROTE ONE.                                  *   FILE 316
//*                                                                 *   FILE 316
//*       VIOEXIT   1X  ACF2 VIOLATION EXIT TO ALLOW USE OF BLP IN  *   FILE 316
//*                     CASES WHERE TMS FOREIGN TAPES NEED TO BE    *   FILE 316
//*                     READ.  SEE CODE FOR EXPLANATION.            *   FILE 316
//*                                                                 *   FILE 316
//*       VKILLER   1   SUBTASK FOR TAPEL.  LETS YOU DO MULTI       *   FILE 316
//*                     TAPEL'S ON A NO. OF TAPES, THEN MAKE IT     *   FILE 316
//*                     QUIT.  YOU TELL "KILL", TO KILL TAPEL !!!!  *   FILE 316
//*                                                                 *   FILE 316
//*       ZEBCOMPR  1   A ZAP TO THE IBM UTILITY 'IEBCOMPR' TO      *   FILE 316
//*                     DISPLAY UNMATCHED RECORDS IN EBCDIC         *   FILE 316
//*                     INSTEAD OF HEX.  WE MADE A COPY OF          *   FILE 316
//*                     IEBCOMPR, CALLED IT ZEBCOMPR AND ZAPPED     *   FILE 316
//*                     IT.                                         *   FILE 316
//*                 2   Fitted to all OS/390 and z/OS releases      *   FILE 316
//*                     because IBM moved code to BLPRT module.     *   FILE 316
//*                                                                 *   FILE 316
//*       ZMSG      1X  PGM TAKES MESSAGE OUT OF PARM FIELD AND     *   FILE 316
//*                     DISPLAYS ON CONSOLE.  NICE TO PUT IN JCL    *   FILE 316
//*                     PROCS TO NOTIFY OPERATORS OF PROBLEMS.      *   FILE 316
//*                                                                 *   FILE 316
//*       ZTDUMPTP  1X  GENERALIZED TAPE DUMPING FACILITY.  PUT IT  *   FILE 316
//*                     IN AN AUTHORIZED LIBRARY.  POWERFUL.  SEE   *   FILE 316
//*                     COMMENTS IN CODE FOR FULL DETAILS.          *   FILE 316
//*                                                                 *   FILE 316
//*       ZTSECURE  2X  MAKES SURE NO DATA IS BEYOND THE 2 DOUBLE   *   FILE 316
//*                     EOF MARKS ON TAPE.  DUMPS FIRST 3 BLOCKS    *   FILE 316
//*                     AND LAST BLK OF EVERY FILE.  LEAPS OVER     *   FILE 316
//*                     DOUBLE END-OF-FILE MARKS & WRITES BINARY    *   FILE 316
//*                     PATTERN UNTIL HITS REFLECTIVE STRIP.        *   FILE 316
//*                                                                 *   FILE 316

```
