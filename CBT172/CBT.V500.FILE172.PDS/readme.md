
## $DOC.txt
```
//*******************************************************************   FILE 172
//*                                                                 *   FILE 172
//*                                                                 *   FILE 172
//* NEITHER DAVID CARTWRIGHT NOR ANY COMPANY ASSOCIATED WITH HIM    *   FILE 172
//* EXPRESS OR IMPLY ANY WARRANTY AS                                *   FILE 172
//* TO THE FITNESS OF THESE COMPUTER PROGRAMS FOR ANY FUNCTION.     *   FILE 172
//* THE USE OF THESE PROGRAMS OR THE RESULTS THEREOF IS ENTIRELY    *   FILE 172
//* AT THE RISK OF THE USER.                                        *   FILE 172
//*                                                                 *   FILE 172
//* THESE PROGRAMS ARE DONATED TO THE PUBLIC DOMAIN AND MAY BE      *   FILE 172
//* FREELY COPIED. THEY MAY BE FREELY DISTRIBUTED TO ANY OTHER      *   FILE 172
//* PARTY ON CONDITION THAT NO INDUCEMENT BEYOND REASONABLE         *   FILE 172
//* HANDLING COSTS BE OFFERED OR ACCEPTED FOR SUCH DISTRIBUTION.    *   FILE 172
//*                                                                 *   FILE 172
//* THESE PROGRAMS MAY BE MODIFIED IN ANY WAY THE USER THINKS FIT   *   FILE 172
//* BECAUSE USE OF THESE PROGRAMS IS ENTIRELY AT THE RISK OF THE    *   FILE 172
//* USER ANYWAY. I WOULD BE INTERESTED TO HEAR OF SIGNIFICANT       *   FILE 172
//* ENHANCEMENTS OR INSTANCES WHERE THESE PROGRAMS HAVE BEEN OF     *   FILE 172
//* MAJOR BENEFIT (OR OTHERWISE), BUT THAT DEPENDS PURELY ON THE    *   FILE 172
//* POLITENESS OF THE USER.  CONTACT;                               *   FILE 172
//*                                                                 *   FILE 172
//*          DAVID CARTWRIGHT                                       *   FILE 172
//*          LYNN FARMHOUSE,                                        *   FILE 172
//*          LYNN LANE,                                             *   FILE 172
//*          LYNN,                                                  *   FILE 172
//*          SHENSTONE, STAFFS.                                     *   FILE 172
//*          UK - WS14 0EP                                          *   FILE 172
//*          TEL.  ++44 (0)1543 481918                              *   FILE 172
//*                                                                 *   FILE 172
//* THESE GOODIES FALL INTO DIFFERENT CATEGORIES, AS DESCRIBED      *   FILE 172
//* BELOW.  ASSEMBLY OF MANY THESE PROGRAMS REQUIRES SYS1.AMODGEN.  *   FILE 172
//* THEY HAVE BEEN TESTED ON MVS/XA 2.2, AND SOME ARE KNOWN TO      *   FILE 172
//* WORK ON OTHER VERSIONS OF MVS.  THE PROGRAMS WRITTEN BY ME ARE  *   FILE 172
//* REASONABLY WELL DOCUMENTED, BUT CHECK THAT THE CODE IS DOING    *   FILE 172
//* WHAT IT SAYS IT IS.  PROGRAMS LIKE 'MAPDISK' WHICH HAVE BEEN    *   FILE 172
//* BUILT UP OVER THE YEARS SHOULD BE VIEWED WITH SUSPICION,        *   FILE 172
//* ESPECIALLY THE PREAMBLE. ALL JCL SHOULD BE VIEWED AS BEING      *   FILE 172
//* ILLUSTRATIVE ONLY, AS A LOT OF JUNK TENDS TO GET LEFT IN AS     *   FILE 172
//* COMMENTS OR UNUSED DDNAMES. ALWAYS USE THE LATEST MACROS AND    *   FILE 172
//* COPY CODE.                                                      *   FILE 172
//*                                                                 *   FILE 172
//* I USE ONE OF THE STANDARD SYSTEMS FOR OBTAINING AUTHORIZATION   *   FILE 172
//* BUT FOR SECURITY I WILL NOT DIVULGE WHAT IT IS. TO GIVE YOU     *   FILE 172
//* SOME HELP I HAVE BEGUN TO USE A PRIVATE MACRO 'GETAUTH' TO      *   FILE 172
//* INVOKE THESE FUNCTIONS. THE VERSION IN THIS FILE WILL ONLY      *   FILE 172
//* GENERATE AN MNOTE TO WARN YOU THAT AUTHORIZATION IS REQUIRED,   *   FILE 172
//* HOW YOU PROVIDE IT IS UP TO YOU.                                *   FILE 172
//*                                                                 *   FILE 172
//*              CACHE MANAGEMENT PROGRAMS                          *   FILE 172
//*                                                                 *   FILE 172
//* THESE PROGRAMS ARE FOR MVS INSTALLATIONS USING THE IBM 3990-3   *   FILE 172
//* DISK CONTROLLER WITH CACHE. I INCLUDE A SIMPLE CACHE            *   FILE 172
//* PERFORMANCE MONITOR PROGRAM. THE OTHER PROGRAMS ARE INTENDED    *   FILE 172
//* TO MODIFY VARIOUS MODULES IN STORAGE TO ALLOW THE PAGING        *   FILE 172
//* AND/OR SWAPPING SUB-SYSTEM TO USE THE 3990-3 EXTENDED           *   FILE 172
//* FUNCTIONS CACHE FAST WRITE (CFW) OR DASD FAST WRITE (DFW).      *   FILE 172
//* THE MEMBER '$PAPER' WILL GIVE THE USER SOME IDEA OF THE         *   FILE 172
//* PURPOSE, BENEFITS AND PROBLEMS OF THE PROGRAMS SUPPLIED.        *   FILE 172
//* UPDATED OCTOBER 1992                                            *   FILE 172
//*                                                                 *   FILE 172
//*      $PAPER    TEXT GIVING HISTORY OF CACHE DEVELOPMENTS (ASA)  *   FILE 172
//*      SECR01    CACHE REPORTING PROGRAM                          *   FILE 172
//*      SECOMMON  AUXILIARY STORAGE MANAGER ZAP COMMON CODE        *   FILE 172
//*      SECFWON   ALLOW PAGING TO USE CACHE FAST WRITE             *   FILE 172
//*      SECFWOFF  ZAP STORAGE BACK TO IBM VALUES                   *   FILE 172
//*      SECFWMPF  MPF EXIT TO DISABLE CACHE FAST WRITE             *   FILE 172
//*      SEDFWON   ALLOW PAGING TO USE DASD FAST WRITE              *   FILE 172
//*      SEDFWOFF  TURN OFF DASD FAST WRITE FOR PAGING              *   FILE 172
//*      SEREC     IBM 3990-3 SUBSYSTEM STATISTICS RECORD           *   FILE 172
//*      SESMF     CACHE MONITOR SMF RECORD                         *   FILE 172
//*                                                                 *   FILE 172
//*                 DISK MAPPING UTILITIES                          *   FILE 172
//*                                                                 *   FILE 172
//* INCLUDES YET ANOTHER VERSION OF THE UBIQUITOUS 'MAPDISK' THAT   *   FILE 172
//* IS INDISPENSABLE FOR STORAGE MANAGEMENT. THIS VERSION SHOULD    *   FILE 172
//* BE DEVICE INDEPENDENT AND HAS SOME GOOD FEATURES, SUCH AS       *   FILE 172
//* DYNAMICALLY ALLOCATING THE VVDS ON THE VOLUME AND EXTRACTING    *   FILE 172
//* INFORMATION ABOUT VSAM FILES, E.G. TRACKS USED. AT LAST YOU     *   FILE 172
//* CAN EASILY SPOT THOSE HUGELY OVER-ALLOCATED VSAM HOGS. ALSO     *   FILE 172
//* SHOWS TRUE LAST REF. DATE FOR VSAM WITHOUT IDATMSTP (FROM       *   FILE 172
//* VVDS) AND WILL OPTIONALLY WRITE SUMMARY RECORDS FOR POST        *   FILE 172
//* PROCESSING. A CUT-DOWN VERSION CALLED 'MAPDLIST' WILL READ      *   FILE 172
//* THESE SUMMARY RECORDS AND CREATE A MAPDISK STYLE REPORT.        *   FILE 172
//* INCLUDED IS A SAMPLE JOB USING THIS COMBINATION TO REPORT       *   FILE 172
//* VASTLY OVER-ALLOCATED FILES AND BADLY FRAGMENTED VSAM FILES     *   FILE 172
//* (EXCESSIVE SPLITS). NOW WITH SMS SUPPORT.                       *   FILE 172
//* MAPDISK PROGRAMS HAVE BEEN UPDATED AUGUST 2001                  *   FILE 172
//*                                                                 *   FILE 172
//*      MAPDISK   MAP DISK CONTENTS WITH ICF/VSAM DETAILS          *   FILE 172
//*      MAPDISKF  MAPDISK SUMMARY RECORD FORMAT                    *   FILE 172
//*      MAPDLIST  PRINT MAPDISK SUMMARY RECORDS IN MAPDISK FORMAT  *   FILE 172
//*      MAPDJCL   SAMPLE JCL FOR MAPDISK PROGRAMS                  *   FILE 172
//*      IXVTOCF5  PSEUDO FORMAT 5 DSCB'S FOR INDEXED VTOCS         *   FILE 172
//*      VSMERROR  VSAM ERROR ROUTINE FROM GERMAN G.U.I.D.E TAPE    *   FILE 172
//*      VVRDSECT  VVR RECORD FORMATS                               *   FILE 172
//*                                                                 *   FILE 172
//* I DEVELOPED A PROGRAM TO GIVE AN OVERVIEW OF 3380 STATUS,       *   FILE 172
//* WHICH GOT DEVELOPED FOR 3390'S (NOT MOD. 6).                    *   FILE 172
//* AS A CONTRACTOR I FOUND THE UCB SCAN ROUTINE CHANGED            *   FILE 172
//* WITH DIFFERENT RELEASES OF MVS, SO I NEEDED DIFFERENT           *   FILE 172
//* VERSIONS OF THESE PROGRAMS.                                     *   FILE 172
//*                                                                 *   FILE 172
//*      MAP3380   OVERVIEW OF 3380'S, BY TYPE (D,E,K). ESA V4      *   FILE 172
//*      MAP3390   OVERVIEW OF 3390'S, BY TYPE (1,2,3). ESA V4      *   FILE 172
//*      M80ESA3   OVERVIEW OF 3380'S, BY TYPE (D,E,K). ESA V3      *   FILE 172
//*      M90ESA3   OVERVIEW OF 3390'S, BY TYPE (1,2,3). ESA V3      *   FILE 172
//*      M80XA2    OVERVIEW OF 3380'S, BY TYPE (D,E,K). MVS/XA V2   *   FILE 172
//*                                                                 *   FILE 172
//*                                                                 *   FILE 172
//*                                                                 *   FILE 172
//*                 VSAM HANDLING UTILITIES                         *   FILE 172
//*                                                                 *   FILE 172
//* IF YOU COMBINE THE VVDS PROCESSING I OBTAINED FROM THE GERMAN   *   FILE 172
//* G.U.I.D.E. GOODIES TAPE FOR 'MAPDISK' WITH THE SVC26            *   FILE 172
//* FUNCTIONS I GOT FROM THE CBT TAPE (DSAT), YOU HAVE SOME         *   FILE 172
//* PRETTY POWERFUL TECHNOLOGY.  GIVE 'CAVEAT' A FREE-FORM LIST OF  *   FILE 172
//* VSAM ITEMS AND IT WILL GENERATE IDCAMS ALTER CARDS TO OPTIMISE  *   FILE 172
//* BUFFER ALLOCATIONS.  UNFORTUNATELY DFSMS NO LOGER ALLOWS YOU    *   FILE 172
//* TO ALTER THE BUFNI VALUE, BUT 'CAVEAT' CAN STILL BE USED TO     *   FILE 172
//* SET THE TOTAL BUFFERSPACE.                                      *   FILE 172
//*                                                                 *   FILE 172
//*      AMDSB     MAP AMDSBCAT AREA FROM SVC26                     *   FILE 172
//*      CATREAD   USE SVC26 TO ACCESS ICF CATALOGS                 *   FILE 172
//*      CAVEAT    CARTWRIGHT'S AMAZING VSAM ENTITY AUTOMATIC TUNING*   FILE 172
//*      EMPTOR    DISAPPOINTING, A SORT OF DIS-IDCAMS, DOES AIX'S  *   FILE 172
//*      GETVVR    SUB-PROGRAM TO RETURN VVR DATA FOR AN ENTITY     *   FILE 172
//*      ICFDSECT  ICF CATALOG BCS DATA FORMATS                     *   FILE 172
//*      JOBBUFNI  SAMPLE DAILY UPDATE FROM SMF DATA                *   FILE 172
//*      RESULT    DATA AREA RETURNED FROM SVC26 PROGRAM            *   FILE 172
//*                                                                 *   FILE 172
//*                                                                 *   FILE 172
//*                                                                 *   FILE 172
//*              OUTPUT MANAGEMENT SYSTEM                           *   FILE 172
//*                                                                 *   FILE 172
//* ONCE UPON A TIME (1982) I WROTE A PROGRAM WHICH WOULD ACT       *   FILE 172
//* LIKE AN EXTERNAL WRITER AND WOULD STORE ON TAPE THE SYSOUT      *   FILE 172
//* WHICH YOU DID NOT WANT TO PRINT. I SUBSEQUENTLY USED            *   FILE 172
//* COMMERCIAL SYSOUT MANAGERS INCLUDING INFOPAC AND SAR.           *   FILE 172
//* WITH THE ADVENT OF SYSTEM MANAGED STORAGE I THOUGHT MY          *   FILE 172
//* LITTLE EXTERNAL WRITER COULD BE MADE JUST AS GOOD OR            *   FILE 172
//* BETTER THAN THOSE, SO I DID. THIS CODE WILL ARCHIVE YOUR        *   FILE 172
//* SYSOUT ON DISK WHERE HSM CAN MANAGE IT. IT IS CARTWRIGHT'S      *   FILE 172
//* HOUSEKEEPING EXTERNAL WRITER (CHEW). NO BELLS, SOME             *   FILE 172
//* WHISTLES, BUT AWFULLY COST EFFECTIVE.                           *   FILE 172
//* Y2K COMPLIANT 1998                                              *   FILE 172
//*                                                                 *   FILE 172
//*      CHEW$DOC  DOCUMENTATION                                    *   FILE 172
//*      CHEW$INST ASSEMBLE AND LINK                                *   FILE 172
//*      CHEW$JCL  RUN AS A BATCH JOB                               *   FILE 172
//*      CHEWMAIN,CHEWDYNA,CHEWPARS,CHEWREPT,CHEWSKIP  SOURCE CODE  *   FILE 172
//*      CHEWBACA,CHEWCOMM                             DATA AREAS   *   FILE 172
//*      CHEWOUT   IS A SEPARATE PROGRAM TO PRINT THE LAST VERSION  *   FILE 172
//*                OF AN ARCHIVED REPORT.                           *   FILE 172
//*                                                                 *   FILE 172
//*                                                                 *   FILE 172
//*              DATA COMPRESSION UTILITIES                         *   FILE 172
//*                                                                 *   FILE 172
//* A SET OF PROGRAMS TO COMPRESS SEQUENTIAL FILES. I GOT FED UP    *   FILE 172
//* WITH WAITING FOR OPERATORS TO MOUNT SMF TAPES, SO FOUND A WAY   *   FILE 172
//* TO BE ABLE TO KEEP SMF DATA ONLINE WITHOUT CONSUMING VAST       *   FILE 172
//* AMOUNTS OF DISK SPACE.  'SSDC02' ACHIEVES ABOUT 40 PERCENT      *   FILE 172
//* SPACE REDUCTION BY DUPLICATE BYTE COMPRESSION. IN ORDER TO BE   *   FILE 172
//* ABLE TO MANIPULATE COMPRESSED FILES DIRECTLY I USE THE          *   FILE 172
//* FACILITIES OF DF/SORT VIA E15 EXITS. IN RESPONSE TO THE POOR    *   FILE 172
//* RESULTS ACHIEVED BY 'SSDC02' WHEN SHRINKING USER FILES THAT     *   FILE 172
//* HAD FEW REPEATING CHARACTERS, I WROTE A PROGRAM CALLING THE     *   FILE 172
//* HUFFMAN TREE COMPACTION ROUTINE FROM 'ARCHIVER', BY RICHARD     *   FILE 172
//* A. FOCHTMAN (CBT FILE 147). ON SMF DATA THIS PROGRAM GIVES      *   FILE 172
//* OUTPUT ABOUT 10 PERCENT SMALLER THAN 'SSDC02'. HOWEVER, TO      *   FILE 172
//* EXPAND THE DATA TAKES THREE TIMES AS MUCH CPU TIME AS USING     *   FILE 172
//* 'SSDCE15'.  I LATER WROTE DCPCOMP1 TO IMPROVE ON SSDC02         *   FILE 172
//* AND THEN DCPCOMP2 FOR SMF DATA - THE RESULTS OF THIS ARE        *   FILE 172
//* SPECTACULAR IF YOU SORT ON THE SMF HEADER FIRST. DCS....        *   FILE 172
//* MEMBERS ARE SORT EXIT VERSIONS OF THESE PROGRAMS.               *   FILE 172
//*                                                                 *   FILE 172
//*      ACTOR     ARCHIVER COMPACTION TECHNIQUE OUTPUT REDUCTION   *   FILE 172
//*      ACTRESS   ARCHIVER COMPACTION TECHNIQUE REBUILD EXIT (SORT)*   FILE 172
//*      COMPACT   OBJECT DECK FOR ARCHIVER COMPACTION CODE (RENT)  *   FILE 172
//*      EXPAND    OBJECT DECK FOR ARCHIVER EXPANSION CODE (RENT)   *   FILE 172
//*      SSDC02    DATA UTILITY 1 - COMPRESS DATA                   *   FILE 172
//*      SSDC03    DATA UTILITY 2 - EXPAND DATA                     *   FILE 172
//*      DCPCOMP1  COMPRESSION PROGRAM WITH IMPROVED ALGORITHM      *   FILE 172
//*      DCPCOMP2  COMPRESSION PROGRAM FOR SMF DATA                 *   FILE 172
//*      DCPEXPD1  EXPAND PROGRAM FOR IMPROVED ALGORITHM            *   FILE 172
//*      DCPEXPD2  EXPAND PROGRAM FOR SMF DATA                      *   FILE 172
//*      SSDCE15   DATA UTILITY 2 - EXPAND DATA SORT EXIT E15       *   FILE 172
//*                                                                 *   FILE 172
//*                                                                 *   FILE 172
//*              SMF/RMF DATA MANIPULATION UTILITIES                *   FILE 172
//*                                                                 *   FILE 172
//* VARIOUS PROGRAMS TO MAKE IT EASIER TO HANDLE SMF RECORDS FOR    *   FILE 172
//* PERFORMANCE REPORTING, PARTICULARLY USING SIMPLE REPORT         *   FILE 172
//* WRITERS SUCH AS CA/EARL. SEE ALSO THE PROGRAMS ADAPTED FROM     *   FILE 172
//* OTHER CBT OFFERINGS.                                            *   FILE 172
//*                                                                 *   FILE 172
//*      CRAP      CARTWRIGHT'S RACF ACCOUNTING PROGRAM             *   FILE 172
//*      CUSS23    USER2 EXIT FOR IFASMFDP TO DELETE SMF2 AND 3     *   FILE 172
//*      DAVE73    RMF CHANNEL RECORDS                              *   FILE 172
//*      DAVE73PR  REPORT ON CHANNEL UTILISATION                    *   FILE 172
//*      DAVE74    RMF DEVICE RECORDS                               *   FILE 172
//*      HPR       HSM PROBLEM REPORTER                             *   FILE 172
//*      SEAFOOD   RE-FORMAT SMF DATE TO INCLUDE MONTH              *   FILE 172
//*      SENDOFF   USER EXIT FOR IFASMFDP TO ONLY SELECT WORKDAYS   *   FILE 172
//*      SERVED70  CREATE SUMMARY RECORDS FROM SMF70 DATA           *   FILE 172
//*      SERVED71  CREATE SUMMARY RECORDS FROM SMF71 DATA           *   FILE 172
//*      SERVED72  CREATE SUMMARY RECORDS FROM SMF72 DATA           *   FILE 172
//*      SE70REC   RMF 70 SUMMARY RECORD FORMAT FROM 'SERVED70'     *   FILE 172
//*      SE71REC   RMF 71 SUMMARY RECORD FORMAT FROM 'SERVED71'     *   FILE 172
//*      SE72REC   RMF 72 SUMMARY RECORD FORMAT FROM 'SERVED72'     *   FILE 172
//*      SE80REC   SMF 80 SUMMARY RECORD FORMAT FROM 'CRAP'         *   FILE 172
//*      STROBE    VISUAL DISPLAY OF MULTIPROGRAMMING (PL/1)        *   FILE 172
//*                                                                 *   FILE 172
//*              OTHER DATA MANIPULATION UTILITIES                  *   FILE 172
//*                                                                 *   FILE 172
//* VARIOUS PROGRAMS TO DO ODD THINGS.                              *   FILE 172
//*                                                                 *   FILE 172
//*      CPUID     DISASTER RECOVERY TOOL TO SET CPU ID.            *   FILE 172
//*      DCFON     EDIT MACRO TO CONVERT FROM UOW SCRIPT TO DCF/GML *   FILE 172
//*      DAYOWEEK  SET RETURN CODE BY DAY OF WEEK                   *   FILE 172
//*      DAYOMNTH  SET RETURN CODE BY DAY OF MONTH                  *   FILE 172
//*      DEVOFF    VARY DEVICE OFFLINE UNDER CONTROL OF OPC/A       *   FILE 172
//*      EMPTYPDS  RESET PDS DIRECTORY AND HIGH WATER MARK          *   FILE 172
//*      ICF3490   CATALOG CONVERSION PROGRAM FOR 3480 TO 3490      *   FILE 172
//*      LOGAN     IBM SYSLOG ANALYSIS PROGRAM FROM GG24-3142-01    *   FILE 172
//*      RLSEJCL   JCL FOR USING 'VTOC' IN BATCH TO RELEASE SPACE   *   FILE 172
//*      SETOFF    CALLS OPC/A EVENT WRITER INTERFACE               *   FILE 172
//*      SSWAIT    PROGRAM TO WAIT, MAY BE STOPPED BY 'P' COMMAND   *   FILE 172
//*      S36PRTU4  PRINT SYSTEM/36 OUTPUT UNDER MVS                 *   FILE 172
//*                                                                 *   FILE 172
//*               MVS MESSAGE PROCESSING MODS                       *   FILE 172
//*                                                                 *   FILE 172
//* ALTHOUGH I USE 'TSSO' FOR MOST CONSOLE AUTOMATION, THERE ARE    *   FILE 172
//* OCCASIONS WHEN A STRAIGHT MPF EXIT IS THE BEST WAY TO DO IT.    *   FILE 172
//* HERE ARE SOME EXAMPLES.                                         *   FILE 172
//*                                                                 *   FILE 172
//*      IEAVMXIT  DEFAULT MPF EXIT - LABEL AND SUPPRESS WTO        *   FILE 172
//*      MPFTAPEM  MPF EXIT TO SMF RECORD TAPE MOUNT, FIND VOLUME   *   FILE 172
//*      MPFTAPEK  MAINTAIN TAPE TABLES IN CSA                      *   FILE 172
//*      MPFTAPET  COPY BLOCK TO INITIALISE UNIT VOLUME TABLES      *   FILE 172
//*      MPFTAPEQ  PROGRAM TO ENQUIRE ON TAPE MOUNT TABLES (TSSO)   *   FILE 172
//*      GETUCVTR  RE-ENTRANT ROUTINE TO FIND OR BUILD THE USER CVT *   FILE 172
//*      USERCVT   FORMAT OF USER CVT HUNG OUT OF 'CVTUSER' FIELD   *   FILE 172
//*      CSATABLE  FORMAT OF IN STORAGE TAPE VOLSER TABLE           *   FILE 172
//*      SMF234    FORMAT OF SMF RECORD FOR TAPE UNIT ACTIVITY      *   FILE 172
//*                                                                 *   FILE 172
//*               MISCELLANEOUS MVS MODIFICATIONS                   *   FILE 172
//*                                                                 *   FILE 172
//* HERE ARE SOME ASSORTED MODS FOR IBM PROGRAM PRODUCTS. SOME OF   *   FILE 172
//* THEM ARE AVAILABLE FROM VARIOUS SAMPLIBS, BUT THEY ARE          *   FILE 172
//* OFFERED HERE TO ACT AS TEMPLATES FOR YOUR OWN TAILORING. THE    *   FILE 172
//* SORT MODS ARE DESIGNED TO STOP DF/SORT FIXING PAGES DURING      *   FILE 172
//* PRIME SHIFT. THE SORT DEFAULTS ARE ALTERED TO CALL THE INPUT    *   FILE 172
//* EXIT WHICH DETERMINES WHETHER TO USE EXCPVR.                    *   FILE 172
//*                                                                 *   FILE 172
//*      DRKUX006  ASSEMBLY OF OPC/A INCIDENT RECORD CREATE EXIT    *   FILE 172
//*      SMIXRECE  INSTALL DF/SORT INPUT EXIT ICEIEXIT              *   FILE 172
//*      SMIXAPPE  APPLY DF/SORT INPUT EXIT USERMOD (DO NOT ACCEPT) *   FILE 172
//*      SMOPRECE  RECEIVE USERMOD TO ALTER DF/SORT DEFAULTS        *   FILE 172
//*      SMOPAPPE  APPLY USERMOD TO ALTER DF/SORT DEFAULTS          *   FILE 172
//*      LASSOO    SET AN ADDRESS SPACE SWAPPABLE/NONSWAPPABLE      *   FILE 172
//*      DEMAND    DELETE MEMBERS OF PDS 'A' FROM PDS 'B'           *   FILE 172
//*                                                                 *   FILE 172
//*               SIEMENS/STC LASER PRINTER GOODIES                 *   FILE 172
//*                                                                 *   FILE 172
//* VARIOUS FONTS ETC. FOR A 3800-3 TYPE PRINTER RUNNING IN         *   FILE 172
//* 3800-1 COMPATABILITY MODE. FOR THE REAL IBM BOX YOU WILL HAVE   *   FILE 172
//* TO CHANGE THE DEVICE SPECIFIED AND USE 'IEBIMAGE' INSTEAD OF    *   FILE 172
//* THE SIEMENS VERSION. A LOT OF THIS STUFF IS ABOUT SWISS         *   FILE 172
//* NATIONAL LANGUAGE SUPPORT WHICH IS BASED ON CODE PAGE 500, SO   *   FILE 172
//* MAY BE OF INTEREST TO INTERNATIONAL COMPANIES. IF YOU USE       *   FILE 172
//* EXCLUSIVELY U.S. ENGLISH (NOW THERE'S AN OXYMORON) YOU MAY      *   FILE 172
//* SKIM THROUGH FOR EXAMPLES OF IEBIMAGE OR SOMETHING LIKE IT,     *   FILE 172
//* AND OF COURSE THE FONTS ARE STILL VALID.                        *   FILE 172
//*                                                                 *   FILE 172
//*      CHARS19V  SWISS NLS VERSION OF FONT 019V, 15 PITCH GOTHIC. *   FILE 172
//*      S9A1      GOTHIC ROTATED SWISS (GROSS) VERSION OF FONT 017V*   FILE 172
//*      LN12      12 LPI FCB FOR ROTATED LISTINGS                  *   FILE 172
//*      SE526     TRANSLATE IN-PLACE UPPER/LOWER CASE AND ASCII    *   FILE 172
//*      WCGMLST1  DOCUMENTATION ON STANDARD WCGM ASSIGNMENTS       *   FILE 172
//*      WCGMLST2  DOCUMENTATION ON OUR (NLS) WCGM ASSIGNMENTS      *   FILE 172
//*                                                                 *   FILE 172
//*              MODIFIED PUBLIC DOMAIN PROGRAMS                    *   FILE 172
//*                                                                 *   FILE 172
//* HERE ARE SOME PROGRAMS WHICH HAVE BEEN SLIGHTLY MODIFIED FOR    *   FILE 172
//* LOCAL CONDITIONS. MOST OF THEM CAME FROM THE CBT TAPE AT        *   FILE 172
//* VARIOUS TIMES.  MY THANKS TO THE ORIGINAL AUTHORS.              *   FILE 172
//*                                                                 *   FILE 172
//*      EDX       JIM LANE'S CLIST EX FILE047 WITH MULTIPLE LISTS  *   FILE 172
//*      FILE171   FIXES TO FILE171 FOR AN ACF2 SHOP - DITTO        *   FILE 172
//*      GETDATE   USAF DATE CONVERSION + HOLIDAY PGM - Y2K VERSION *   FILE 172
//*      LISTPDS   UNNUMBERS MEMBERS WHEN UNLOADING                 *   FILE 172
//*      LISTICF   LINE PER ENTRY CATALOG LISTER                    *   FILE 172
//*      ROTATES   MY VERSION OF U.S.A.F. PAGE ROTATE PROGRAM.      *   FILE 172
//*      RTPDIRD   DIRECTORY READ PROGRAM                           *   FILE 172
//*      SE30EXT   A SPECIAL VERSION OF SUM30EXT WITH RACF FIELDS   *   FILE 172
//*      SE30RPT   SEAG VERSION OF SMF30 SUMMARY                    *   FILE 172
//*      SE30REC   SEAG VERSION OF SMF30 SUMMARY RECORDS            *   FILE 172
//*      SMF1415   REPORT ON NON-VSAM FILE ACTIVITY                 *   FILE 172
//*      SPMGCLD   FRONT END FOR IDCAMS USES ESOTERIC NAMES         *   FILE 172
//*      STRING    MACRO FOR MPFTAPE. EXITS - BUILD UNIT TABLES     *   FILE 172
//*      STRNGEND  MACRO FOR MPFTAPE. EXITS - BUILD UNIT TABLES     *   FILE 172
//*      SYSEVENT  SYSEVENT ANALYSIS SYSTEM FROM STANDARD OIL       *   FILE 172
//*      SYSIEH    IEHPROGM WITHOUT ENQUEUES                        *   FILE 172
//*      TRUISMS   A FEW THOUGHTS FOR 'MURPHY'                      *   FILE 172
//*                                                                 *   FILE 172
//* IN THIS CATEGORY I INCLUDE MY ENHANCEMENTS FOR VERSION 5        *   FILE 172
//* OF 'THE ARCHIVER' FROM CBT FILE 147. THESE ARE DESIGNED         *   FILE 172
//* TO PERFORM AN AUTOMATIC ALIAS AND DELETE FUNCTION AFTER         *   FILE 172
//* RUNNING A COMPARE.                                              *   FILE 172
//*                                                                 *   FILE 172
//*      ARCHCOMP  ARCHIVER COMPARE PROGRAM INCLUDING MY INSERTS    *   FILE 172
//*      ARCHPARS  ARCHIVER PARSING PROGRAM INCLUDING MY INSERTS    *   FILE 172
//*      CRAMP     GENERATE DELETE AND ALIAS CARDS                  *   FILE 172
//*      CRAMPON   INVOKE MY AUTOARCHIVE PROGRAM                    *   FILE 172
//*      CRAMPOFF  DELETE MY AUTOARCHIVE PROGRAM                    *   FILE 172
//*                                                                 *   FILE 172
//*                                                                 *   FILE 172
//*                   MACROS AND COMMON CODE                        *   FILE 172
//*                                                                 *   FILE 172
//* AS WELL AS TEXT AND PROGRAM SOURCE THERE ARE SOME MEMBERS       *   FILE 172
//* WHICH ARE COPIED INTO THE PROGRAMS AND SOME MACROS. MOST OF     *   FILE 172
//* THOSE ARE FROM THE PUBLIC DOMAIN I.E. I GAVE THEM AWAY          *   FILE 172
//* BEFORE I QUIT.                                                  *   FILE 172
//*                                                                 *   FILE 172
//* AROUND THE END OF 1991 I STARTED TO WRITE A LOT MORE            *   FILE 172
//* RE-USABLE CODE BY SPLITTING SMALL FUNCTIONAL SUB-ROUTINES OUT   *   FILE 172
//* INTO COPY BLOCKS. THESE ARE ALSO INCLUDED IN THIS FILE.         *   FILE 172
//*                                                                 *   FILE 172
//*                                                                 *   FILE 172
//*                            *** END ***                          *   FILE 172
//*******************************************************************   FILE 172
```

## CHEW$DOC.txt
```
          CHEW - Cartwright's Housekeeping External Writer.
          =================================================
This program was written by D.H.Cartwright in January 1995.  The program
was written in Assembler language. It does not have any alias.  It is a
major rewrite of the old MONEXWTR program I wrote at Monsanto Europe SA
with a new internal structure and the additional capability of copying
SYSOUT to disk datasets where it may be managed by your normal Storage
Management systems.  MONEXWTR was designed to archive SYSOUT datasets to
tape. It was intended to be used to handle Production JCL listings,
housekeeping reports, TSO session output and all the other print-out
that is created in a computer installation but which is rarely required
to be read. The program uses standard sub-system interfaces to allocate
print datasets, copies them to tape and then deletes them. However, if
the Job has failed for some reason - a JCL error or ABEND - the output
is not deleted, but is released for hardcopy output.  Over the years I
have found that most installations tend to put all this sort of output
in a dummy SYSOUT class so that it never even gets created. Conventional
reports etc. are managed by Output Management systems such as RMDS, SAR
or INFOPAC.  I have found this very frustrating, I cannot debug problems
with Started Tasks as the output is not there and output I do want
preserved is lost in some horrendously complex archive system which uses
its own file management system I cannot easily get at.  Output
Management Systems generally use their own archive structure in order to
achieve high utilisation of disk space.  Nowadays HSM Users are not
concerned to get the most data onto a track as the file will not occupy
disk space for very long anyway, and then it will be compressed and
packed away by HSM.  There is no need for an Output Management System to
duplicate this effort.  I therefore sat down and revived MONEXWTR as a
simple Output Management System. It will now archive your SYSOUT to
plain flat files on disk which you can browse, print, summarise etc.
with normal, simple tools and which you can manage with HSM or some
other Storage Management system.  Your normal security system can
control access to these files.  I recommend putting them in their own
User Catalog.

Limitations
~~~~~~~~~~~
Although it describes itself as an External Writer it does not in fact
adhere to the standards for that class of program.  This program uses
standard, documented IBM interfaces to Dynamic Allocation and Sub System
Services. Therefore its limitations are mostly those imposed by IBM on
these interfaces.
It has only been tested under JES2. It should work under JES3, but this
is not guaranteed.
It must run as an Authorised program from an Authorised library.
If run for extended periods you may run up against limitations on the
number of DDnames you can allocate dynamically.
It will only handle Line Mode output with LRECL 133 or less.
Output which is released for reprinting will be in the original class.
Under JES2 these datasets may not be printed together, a separator could
be created between each one.
It will only process one SYSOUT class at a time and it will only handle
'HELD' output, one is a function of the other.  It should be possible to
alter the program to process 1 to 8 non-held classes, but in that case
output from failed jobs will not be requeued, it will be purged.
This is the first pass at re-writing MONEXWTR and many things have not
been exhaustively tested.  In addition much error handling is very
crude, e.g. dynamic allocation errors result in a deliberate S0C1 abend.
The author would be grateful if corrections, improvements or suggestions
are sent to him at the address shown in the CBT tape documentation.

Input Data
~~~~~~~~~~
1) PARM field
This program uses the same logic to process the PARM field, Start
parameters and Modify parameters, in that order. Therefore any keywords
supported by the program may be entered as a PARM. The User should refer
to the section on 'KEYWORDS' for further information.

2) JES2 data
Obviously the primary input to this program is supplied by JES2 through
a Sub System Services interface. The program uses Sub System Services to
request a dataset identification from JES2, then uses Dynamic Allocation
to assign that dataset to a system generated DDname.  Everything about
the allocation and use of JES2 datasets is handled by the program, the
User does not need to supply any JCL for this function.
As JES2 grows it takes longer and longer to solicit files.  The User may
see this program swapped out for a Detected Wait during this process.
When this program is Waiting for Work it does not issue the famous
message, but enters a Long Wait.

Output data
~~~~~~~~~~~
1)SYSUT2 DD statement
One of the major outputs from this program is an archive copy of JES2
print datasets to the dataset defined by SYSUT2.  This file combines the
output of all jobs processed by CHEW in one place, and is created in
addition to the individual disk datasets.  It was the primary output of
the old MONEXWTR program and has been retained in the re-write.
However, this dataset is optional and may be omitted if the User
desires.  If present it is a sequential dataset, normally on tape. The
records are fixed length, and because they contain far more information
than just the print line, the LRECL is quite big.

2)SYSUT3 DD statement
This is an output summary sequential file. It contains one record for
every print dataset archived. Although its presence is optional, no
reports will be produced if it is missing.  Because it is subject to
multiple OPENs and CLOSEs you should not specify RLSE or FREE=CLOSE.

3) Report File
This file is dynamically allocated by the program to a system assigned
DDname.  It is allocated as:

      //SYS.....  DD  SYSOUT=A,FREE=CLOSE

and is used to write out activity reports either on request or at the
end of the run.  The format of the report is a hangover from MONEXWTR
and could well be tidied up.

4) Archive file
This file is dynamically allocated by the program to a system assigned
DDname.  It creates a disk dataset with a name which includes a Prefix,
the jobname and number, the SYSOUT class and the date and time it was
archived.  The actual format of the DSNAME is easy to change, so I have
not documented here what it is at the time of writing.  However, the
User should select a name format that makes it easy to manage the print
files and allows the User to easily find any required listing using
normal utilities e.g. SPF 3.4
The dataset is created with variable length records and ANSI control
characters. The program translates Machine control to ANSI standard, so
the number of records output may be different from the number input, but
the report should look the same whether it is printed from JES2 Spool or
reprinted from a CHEW archive.
Note that in the Mk1 version of CHEW this dataset is NOT optional.  It
would be easy to code up a processing option to turn off the creation of
these files, but since they are the raison d'etre of the rewrite I
thought it was silly to suppress them. If you just want to archive to
tape apply to Monsanto Europe SA for a copy of MONEXWTR.  Alternatively
chop CHEWDYNA out of this program.

5) Highlighting
CHEW will by default search the JES2 Job Log, the JCL and the Message
dataset for a number of messages.  If found they will optionally trigger
a message to the Operator and/or cause the output to be requeued in the
same class but not held.  They will also be highlighted with an
arrowhead <------------ in the archived copies of the output on the
SYSUT2 file and on the archive disk dataset. (This is as near as I could
get to the mod to OS/360 HASP which highlighted the message on Spool).
The message was the first way Monsanto Europe had to recognise failures
in Production jobs - nowadays this is done by scheduling systems (see my
version of DRKUX006) or by SMF exits or MPF exits.  If you don't want
the bother of those things this is a cheap way to do it.

Operation
~~~~~~~~~
Keywords
~~~~~~~~
The following keywords control the operation of the program. They may be
entered as PARM information, as START command parameters or as options
of a MODIFY command. Processing in each case is the same.  The program
will only recognise text in upper case.  Many keywords are synonymous,
the author has tried to anticipate standard variations of the same
function. Where one keyword is a synonym of another both versions invoke
the same processing routine.

1) CLASS= or QUEUE= or Q=
These three synonyms are keywords controlling the class of SYSOUT which
the program will select for archiving. Only one class may be specified
at a time. The program will only select output of the requested class
which is HELD, either by being so defined in JES2 initialisation
parameters or explicitly by the user specifying;

   //ddname   DD  SYSOUT=x,HOLD=YES

where the ddname is as required by the user program and x is the SYSOUT
class the user wishes to create.
If no operand is supplied, the program will try to nullify the selection
of output by CLASS. However, if CLASS is the only qualification for job
selection (the default), the request will be denied.  The program will
attempt to respond to each new CLASS specification with a message to the
operator showing the new selection class, or an error message.

2) NOGO
Whenever this keyword is entered, the program terminates immediately.
This may be used as a PARM to prevent any processing.

3) REPORT
This keyword indicates that the user requests a report of activity. Such
a report will be written when the program comes to the end of output for
a JOB, not at the exact instant the report was requested or even at the
end of the curent print dataset being processed. The report is created
to the dynamically allocated SYSOUT dataset by reading in the SYSUT3
summary file. Thus every report produced shows all activity to date for
the run. As many reports as required may be requested during any one run
of the program.  Reports are always created to SYSOUT class A, with
route code, forms, number of copies etc. being left to the installation
defaults defined at JES2 initialisation.
Because these reports are spun-off to dynamically allocated print files
whilst the program is running, the operator cannot display report
datasets awaiting hardcopy output.

4) STATUS
The program will display the current Job selection criteria - class,
route code etc..

5) STOPEOF
If this option is specified the program will continue to process output
until there are no more Jobs eligible for selection. At that point the
program will terminate. By default - i.e.  if this parameter is omitted
- the program will wait one minute, then request more output from JES2.
If none is available it will wait for a further minute and so on. In
that case the program may be terminated by specifying the 'STOPEOF'
command or by a normal MVS Operator stoP command (P CHEW). Note that
using a MVS stoP command takes effect at the end of the current dataset,
whereas the STOPEOF option will leave the program running for as long as
there is work for it to do. The is no command to remove the effect of a
STOPEOF command once it has been entered, although a standard MVS stoP
command may be used to stop at the end of the current dataset.

6) PRINT and NOPRINT
If the PRINT option is in effect, ALL ouput will be queued for harcopy
output after being copied to tape.  The default is NOPRINT - jobs will
normally be purged after archiving, except for failed jobs.

7) MSG and NOMSG
These options may be used to turn off and on the generation of messages
to the Operator. MSG is the default, i.e. messages to the operator will
be generated.
The most important message to the operator occurs when a failed JOB is
archived. The program will then issue a message with reply stating that
the JOB has been queued for reprinting. The Operator should reply as
appropriate to this message - up to about 50 characters will be printed
on the report. The output will be archived and then queued for printing
instead of being purged.
The operator can inhibit the re-print operation by starting his reply
with the word 'PURGE'.

8) TSUMSG and NOTSUMSG
These options may be used to turn off and on the generation of requests
to the operator to confirm failure of Time Sharing Users (TSU's).
TSUMSG is the default, i.e. messages to the operator will be generated.
This option is included because it is not unusual for a TSO session to
Abend - a S522 Abend is quite normal where users leave their screen
unattended for some time. However, if TSU output is being archived, the
Operator does not need to note every one of these failures

Program Structure
~~~~~~~~~~~~~~~~~
MONEXWTR was spaghetti code, some of which has slid through the seive
into CHEW.  However, I have tried to modularise it and have put all the
shared data and sub-routines into one CSECT called CHEWBACA which is
addressable from every module.  This grew in size so I allowed two base
registers for it  - I could have split it into data and code, but
sharing the bases seemed a more flexible approach. The CHEWBACA module,
assembled in CHEWCOMM, contains most of the data you may want to modify
- such things as High Level Qualifier for the disk datasets or default
SYSOUT class.  You should consider changing the blocksizes specified in
the dcb declarations for your own particular device types.  Ensure that
if you change the layout of this storage area you re-assemble all the
CHEW modules.  I have chosen to link-edit the modules together.  I use
my standard dynamic linkage code, so most modules could be separate load
modules if required. I just chose to make it into one because I kept
having to re-assemble everything anyway.  Member CHEW$INS is a guideline
job to install CHEW in an APF authorised library.  I have also included
CHEW$JCL as a sample test job to run CHEW - in practice you may want to
omit SYSUT2 and make SYSUT3 into a GDG.  You would almost certainly run
CHEW as a Started Task, which means updating whatever tables your access
control system uses for STCs.  I wrote CHEW at an ACF2 site during a
short contract, so I did not bother to go through the contortions
required by ACF2.  This means that a lot of the Stop/Modify code has not
been tested, but then it used to work in MONEXWTR.

RETRIEVING OUTPUT
~~~~~~~~~~~~~~~~~
A design criterion was that output could be handled with standard tools,
in particular ISPF option 3.4 - DS List.  From here the output may be
browsed or printed with DSPRINT or equivalent.  Simple batch jobs using
IEBGENER may be used to print the disk archives.  Well I did it a
couple of times during testing and yes, sure, it works fine, but those
DSNames are a real drag to type in.  A real Output Manager will have
some way to allow your scheduling system to print reports as required
once they have been created.  I therefore cobbled together, I mean
carefully crafted an automatic output finding program, CHEWOUT.  This
will pass the last report in a specified hierarchy to SORT.  I tend to
use DF/SORT for most of my data manipulation as it is so easy and
efficient.  Using it in this application allows you to do a straight
copy or record selection or some simple data manipulation.  Be aware
that SYNCSORT may not be totally compatible for this type of application
- it does not take an E15 exit on SORT FIELDS=COPY, for example.
```

