```
//***FILE 160 IS FROM MR CHUCK HOFFMAN OF GTE LABS AND THE          *   FILE 160
//*           COMMONWEALTH OF MASSACHUSETTS AND CONTAINS SEVERAL    *   FILE 160
//*           TSO COMMAND PROCESSORS AND MACROS.  THE FOLLOWING     *   FILE 160
//*           ARE CONTAINED IN THIS DATASET :                       *   FILE 160
//*                                                                 *   FILE 160
//*           email:  sbgolob@cbttape.org                           *   FILE 160
//*                                                                 *   FILE 160
//*          BULLETIN - A COMMAND FOR PUTTING UP NICELY FORMATTED   *   FILE 160
//*                     BULLETIN MESSAGES INTO THE SYSTEM           *   FILE 160
//*                     BROADCAST DATASET.  THE COMMAND HAS THE     *   FILE 160
//*                     ABILITY TO ADD AND DROP BULLETIN MESSAGES   *   FILE 160
//*                     ON SELECTED DATES.                          *   FILE 160
//*                                                                 *   FILE 160
//*          DSNCHECK - A COMMAND TO CHECK FOR THE EXISTENCE OF A   *   FILE 160
//*                     CATALOGED DATASET NAME, AND, OPTIONALLY,    *   FILE 160
//*                     TO CHECK FOR THE EXISTENCE OF A MEMBER      *   FILE 160
//*                     WITHIN A PDS.  SETS &LASTCC FOR CLIST       *   FILE 160
//*                     WRITERS.                                    *   FILE 160
//*                                                                 *   FILE 160
//*          FREEALL  - A COMPLETELY NEW FREEALL, WITH LOTS OF      *   FILE 160
//*                     NICE OPTIONS, LIKE THE EXCEPT OPERAND.      *   FILE 160
//*                     USES SVC-99, AND CAN BE MAINTAINED BY       *   FILE 160
//*                     MORE JUNIOR SYSTEMS PROGRAMMERS.            *   FILE 160
//*                     COMPATIBLE WITH J/TIP.  (MODIFIED BY        *   FILE 160
//*                     JEFFREY R. BROIDO TO ADD SEVERAL OPTIONS)   *   FILE 160
//*                     (OLDER VERSION IS MEMBER FREEALL0)          *   FILE 160
//*                                                                 *   FILE 160
//*          INSTREAM - THE INSTREAM COMMAND IS USED TO CREATE      *   FILE 160
//*                     80-BYTE CONTROL CARD IMAGES IN A            *   FILE 160
//*                     TEMPORARY FILE.  THIS COMMAND CAN BE RUN    *   FILE 160
//*                     UNDER CLIST CONTROL, WITH SYMBOLIC          *   FILE 160
//*                     SUBSTITUTION OF VARIABLES ALLOWED.          *   FILE 160
//*                     INSTREAM USES VIO INSTEAD OF DATASETS,      *   FILE 160
//*                     AND USES SYSTEM GENERATED NAMES INSTEAD     *   FILE 160
//*                     OF CATALOGING.                              *   FILE 160
//*                                                                 *   FILE 160
//*          ISPFPROF - THIS IS AN ALIAS OF THE PDF COMMAND         *   FILE 160
//*                     PROCESSOR (SEE DESCRIPTION, BELOW).  WHEN   *   FILE 160
//*                     USING THIS ALIAS, THE PROFILE DATASET       *   FILE 160
//*                     WILL BE ALLOCATED, BUT THE PROGRAM WILL     *   FILE 160
//*                     NOT ENTER ISPF/PDF.                         *   FILE 160
//*                                                                 *   FILE 160
//*          LIBCALL  - LIBCALL TRANSFERS CONTROL TO MODULES WITH   *   FILE 160
//*                     A 'CALL' TYPE OF PARAMETER LIST, WITH A     *   FILE 160
//*                     'STEPLIB' OPTION.  LIBCALL ALSO CAN         *   FILE 160
//*                     ACCEPT PROGRAM PARAMETERS IN LOWER CASE.    *   FILE 160
//*                                                                 *   FILE 160
//*          NEWSPACE - A COMMAND FOR EASILY CREATING NEW,          *   FILE 160
//*                     MODERATELY SIZED, DATASETS AND LIBRARIES.   *   FILE 160
//*                     IT WAS WRITTEN WITH BEGINNERS IN MIND.      *   FILE 160
//*                     CAN BE EXECUTED FROM THE ISPF/PDF COMMAND   *   FILE 160
//*                     LINE (FOR ALLOCATING THAT DATASET YOU       *   FILE 160
//*                     SUDDENLY NEED).                             *   FILE 160
//*                                                                 *   FILE 160
//*          PDF      - THE PDF COMMAND IS USED TO PREALLOCATE      *   FILE 160
//*                     THE ISPF PROFILE DATASET, THEN BRING THE    *   FILE 160
//*                     USER INTO ISPF/PDF.  PDF IS A FRONT END     *   FILE 160
//*                     WHICH USES THE ISRPCP ENTRY POINT OF        *   FILE 160
//*                     ISPF/PDF, ENABLING THE USER TO SELECT       *   FILE 160
//*                     OPTIONAL PANEL NUMBERS WHEN INVOKING THE    *   FILE 160
//*                     PRODUCT.                                    *   FILE 160
//*                                                                 *   FILE 160
//*                    THE PDF COMMAND IS USED TO ENTER THE         *   FILE 160
//*                    ISPF PROGRAM DEVELOPMENT FACILITY            *   FILE 160
//*                    (PDF).  IT IS A FRONT END FOR ISPF/PDF.      *   FILE 160
//*                                                                 *   FILE 160
//*                     SYNTAX -                                    *   FILE 160
//*                          PDF                                    *   FILE 160
//*                              OPTION TEST/TESTX/TRACE/TRACEX     *   FILE 160
//*                     OPERANDS:                                   *   FILE 160
//*                       REQUIRED - NONE                           *   FILE 160
//*                       DEFAULTS - NONE                           *   FILE 160
//*                       OPTIONAL - OPTION, TEST, TESTX, TRACE,    *   FILE 160
//*                                  TRACEX                         *   FILE 160
//*                                                                 *   FILE 160
//*                    OPTION   - AN INITIAL OPTION THAT MAY BE     *   FILE 160
//*                               ENTERED TO BYPASS THE FIRST       *   FILE 160
//*                               DISPLAY OF THE PRIMARY OPTION     *   FILE 160
//*                               MENU AND GO DIRECTLY TO THE       *   FILE 160
//*                               OPTION YOU SELECT.  (THIS IS      *   FILE 160
//*                               NOT A KEYWORD PARAMETER.          *   FILE 160
//*                               SIMPLY ENTER THE OPTION           *   FILE 160
//*                               NUMBER, OR OMIT TO DISPLAY THE    *   FILE 160
//*                               PRIMARY OPTION MENU.)  FOR        *   FILE 160
//*                               EXAMPLE, TYPING "PDF 3.2" IN      *   FILE 160
//*                               TSO WILL TAKE YOU DIRECTLY TO     *   FILE 160
//*                               THE ISPF/PDF DATASET UTILITY      *   FILE 160
//*                               OPTION.                           *   FILE 160
//*                                                                 *   FILE 160
//*                    TEST     - PDF IS TO BE RUN IN TEST MODE.    *   FILE 160
//*                               TEST MODE INCLUDES:               *   FILE 160
//*                                                                 *   FILE 160
//*                                1. RE-READING FROM DISK          *   FILE 160
//*                                   ALL PANELS AND                *   FILE 160
//*                                   MESSAGES.  THIS               *   FILE 160
//*                                   ENHANCES THE ABILITY TO       *   FILE 160
//*                                   TEST PANELS AND               *   FILE 160
//*                                   MESSAGES IN THE SAME          *   FILE 160
//*                                   PDF SESSION THAT THEY         *   FILE 160
//*                                   ARE MODIFIED.                 *   FILE 160
//*                                                                 *   FILE 160
//*                                2. DISABLING ABEND               *   FILE 160
//*                                   RECOVERY.  THIS ALLOWS        *   FILE 160
//*                                   ABENDS TO BE TRACKED          *   FILE 160
//*                                   DOWN USING TSO TEST.          *   FILE 160
//*                                                                 *   FILE 160
//*                                3. DISABLING ATTENTION KEY       *   FILE 160
//*                                   HANDLING.  THIS ALLOWS        *   FILE 160
//*                                   THE ATTENTION KEY TO BE       *   FILE 160
//*                                   USED TO ENTER TSO TEST.       *   FILE 160
//*                                                                 *   FILE 160
//*                    TESTX    - PDF IS TO BE RUN IN TEST          *   FILE 160
//*                               MODE EXTENDED.  IN ADDITION       *   FILE 160
//*                               TO TEST MODE, ANY LINES           *   FILE 160
//*                               THAT ARE WRITTEN TO THE LOG       *   FILE 160
//*                               FILE ARE ALSO DISPLAYED ON        *   FILE 160
//*                               THE DISPLAY SCREEN.               *   FILE 160
//*                                                                 *   FILE 160
//*                    TRACE    - PDF IS TO BE RUN IN TRACE         *   FILE 160
//*                               MODE.  TRACE MODE INCLUDES        *   FILE 160
//*                               ALL OF THE FUNCTIONS OF           *   FILE 160
//*                               TEST MODE.  IN ADDITION,          *   FILE 160
//*                               ALL ISPEXEC SERVICE               *   FILE 160
//*                               INVOCATIONS FROM A DIALOG         *   FILE 160
//*                               WILL BE LOGGED.                   *   FILE 160
//*                                                                 *   FILE 160
//*                    TRACEX   - PDF IS TO BE RUN IN TRACE         *   FILE 160
//*                               MODE EXTENDED.  IN ADDITION       *   FILE 160
//*                               TO TRACE MODE, ANY LINES          *   FILE 160
//*                               THAT ARE WRITTEN TO THE LOG       *   FILE 160
//*                               FILE ARE ALSO DISPLAYED ON        *   FILE 160
//*                               THE DISPLAY SCREEN.               *   FILE 160
//*                                                                 *   FILE 160
//*                    DETAILED INFORMATION:                        *   FILE 160
//*                                                                 *   FILE 160
//*                          PDF FIRST FREES DD(ISPPROF),           *   FILE 160
//*                          THEN TRIES TO ALLOCATE                 *   FILE 160
//*                          DD(ISPPROF) TO                         *   FILE 160
//*                          DSN('&SYSPREF..ISPF.PROFILE')          *   FILE 160
//*                          WITH DISP=(OLD,KEEP,KEEP).  IF         *   FILE 160
//*                          IT CANNOT ALLOCATE BECAUSE OF          *   FILE 160
//*                          LOCATE ERROR 1708 (NOT FOUND IN        *   FILE 160
//*                          CATALOG), IT ALLOCATES THE             *   FILE 160
//*                          DATASET WITH                           *   FILE 160
//*                          DISP=(NEW,CATLG,CATLG),                *   FILE 160
//*                          UNIT=SYSTSO,                           *   FILE 160
//*                          DCB=(RECFM=FB,LRECL=80,BLKSIZE=3120,   *   FILE 160
//*                          DSORG=PO), SPACE=(TRK,(1,2,10)).       *   FILE 160
//*                          FOR ANY OTHER ALLOCATION ERROR         *   FILE 160
//*                          CODE, THE PROGRAM TERMINATES AND       *   FILE 160
//*                          GIVES THE NORMAL IKJEFF18 ERROR        *   FILE 160
//*                          MESSAGES.                              *   FILE 160
//*                                                                 *   FILE 160
//*                          PDF MAKES A NEW COPY OF THE            *   FILE 160
//*                          COMMAND BUFFER (CBUF) AND THE          *   FILE 160
//*                          COMMAND PROCESSOR PARAMETER LIST       *   FILE 160
//*                          (CPPL), POINTING THE NEW CPPL TO       *   FILE 160
//*                          THE NEW CBUF.  IF THE USER USED        *   FILE 160
//*                          'SPF' RATHER THAN 'PDF,' PDF           *   FILE 160
//*                          WILL PUT OUT AN INFO MESSAGE           *   FILE 160
//*                          SAYING THAT 'SPF' HAS BEEN             *   FILE 160
//*                          REPLACED BY 'PDF.'  PDF THEN           *   FILE 160
//*                          PLACES THE LITERAL 'ISP' INTO          *   FILE 160
//*                          THE NEW CBUF BEGINNING AT THE          *   FILE 160
//*                          LOCATION OF THE FIRST NONBLANK         *   FILE 160
//*                          CHARACTER OF THE COMMAND TEXT.         *   FILE 160
//*                          IF DATASET                             *   FILE 160
//*                          '&SYSPREF..ISPF.PROFILE' WAS           *   FILE 160
//*                          ALLOCATED NEW, MESSAGES                *   FILE 160
//*                          CONCERNING THE NEW DATASET ARE         *   FILE 160
//*                          WRITTEN TO THE TERMINAL.               *   FILE 160
//*                                                                 *   FILE 160
//*                          PDF THEN POINTS R1 TO THE NEW          *   FILE 160
//*                          CPPL, AND ATTACHES ISRPCP.  IT         *   FILE 160
//*                          THEN WAITS FOR ISRPCP TO               *   FILE 160
//*                          COMPLETE, DETACHES ISRPCP, FREES       *   FILE 160
//*                          STORAGE AND TERMINATES.                *   FILE 160
//*                                                                 *   FILE 160
//*                        RETURN CODES:                            *   FILE 160
//*                          IF ISP EXECUTES, THE CODE              *   FILE 160
//*                          RETURNED IS THE CODE FROM ISP.         *   FILE 160
//*                          OTHERWISE THE RETURN CODE IS 12.       *   FILE 160
//*                                                                 *   FILE 160
//*          SAFECOPY - THIS PROGRAM IS A TSO COMMAND PROCESSOR     *   FILE 160
//*                     WHICH ENABLES MANY USERS TO COPY DATA INTO  *   FILE 160
//*                     THE SAME DATASET SIMULTANEOUSLY WITHOUT     *   FILE 160
//*                     CONFLICTING WITH EACH OTHER.  INPUT DATA    *   FILE 160
//*                     MAY COME FROM A DATASET, FROM THE           *   FILE 160
//*                     TERMINAL, OR FROM DATA STACKED INSTREAM IN  *   FILE 160
//*                     A CLIST.                                    *   FILE 160
//*                                                                 *   FILE 160
//*                     SAFECOPY IS ESPECIALLY USEFUL IN CLISTS     *   FILE 160
//*                     WHICH WRITE TO A COMMON DATASET.            *   FILE 160
//*                                                                 *   FILE 160
//*                     SAFECOPY ACCOMPLISHES THIS BY PERFORMING A  *   FILE 160
//*                     SYSTEM ENQUEUE BEFORE WRITING TO THE        *   FILE 160
//*                     DATASET.  MAJOR NAME IS USERDSN, MINOR      *   FILE 160
//*                     NAME IS THE NAME OF THE DATASET INTO WHICH  *   FILE 160
//*                     SAFECOPY IS WRITING.                        *   FILE 160
//*                                                                 *   FILE 160
//*                     INPUT AND OUTPUT CAN BE DESIGNATED BY       *   FILE 160
//*                     DATASET NAME, OR BY FILE/DD NAME.  IF THE   *   FILE 160
//*                     OUTPUT DATASET IS NOT PARTITIONED, THE MOD  *   FILE 160
//*                     OPERAND WILL CAUSE THE USE OF THE EXTEND    *   FILE 160
//*                     OPERAND OF OPEN, ALLOWING DATA TO BE ADDED  *   FILE 160
//*                     ON TO THE END OF A SEQUENTIAL DATASET.      *   FILE 160
//*                                                                 *   FILE 160
//*                     THE DEFAULT IS NONUM.  THE USE OF THE NUM   *   FILE 160
//*                     OPERAND WILL CAUSE THE PHYSICAL RELOCATION  *   FILE 160
//*                     OF LINE NUMBERS WHEN SAFECOPYING BETWEEN    *   FILE 160
//*                     VARIABLE AND FIXED RECORD LENGTH DATASETS,  *   FILE 160
//*                     OR BETWEEN FIXED RECORD LENGTH DATASETS OF  *   FILE 160
//*                     DIFFERENT LOGICAL RECORD LENGTHS.           *   FILE 160
//*                                                                 *   FILE 160
//*          SYSDSN   - A COMMAND TO LIST THE NAMES OF EVERYONE     *   FILE 160
//*                     WHO HAS A DATASET ALLOCATED, OR IS          *   FILE 160
//*                     WAITING FOR ALLOCATION.  VERY USEFUL        *   FILE 160
//*                     AFTER 'DATASET IN USE' AND 'WAITING FOR     *   FILE 160
//*                     DATASETS' MESSAGES.                         *   FILE 160
//*                                                                 *   FILE 160
//*          XPRINT   - A FRONT-END COMMAND PROCESSOR FOR A         *   FILE 160
//*                     USER-WRITTEN HEXADECIMAL LISTING UTILITY    *   FILE 160
//*                     PROGRAM.  ALLOCATES THE INPUT AND OUTPUT    *   FILE 160
//*                     FILES, THEN EXECUTES THE UTILITY.  LOADS    *   FILE 160
//*                     THE UTILITY IF IT IS NOT ALREADY LINKED     *   FILE 160
//*                     IN.                                         *   FILE 160
//*                                                                 *   FILE 160
//*       ADDITIONALLY, THIS PDS CONTAINS THE FOLLOWING             *   FILE 160
//*       MACROS USED BY SEVERAL OF THE COMMAND PROCESSORS:         *   FILE 160
//*                                                                 *   FILE 160
//*          EQ$R     - REGISTER EQUATES.                           *   FILE 160
//*          GTEDAALC - EXECUTES DYNAMIC ALLOCATION AND DAIRFAIL.   *   FILE 160
//*          GTEDADAT - CREATES SVC99/IKJEFF18 CONTROL BLOCKS.      *   FILE 160
//*          GTEDADOC - DOCUMENTATION FOR GTEDAXXX MACROS.          *   FILE 160
//*          GTEDASET - LINKS SVC99/IKJEFF18 CONTROL BLOCKS         *   FILE 160
//*                     TOGETHER.                                   *   FILE 160
//*          LINKSAVE - LINKAGE CONVENTIONS UPON ENTRY TO A         *   FILE 160
//*                     MODULE.                                     *   FILE 160
//*          LINKBACK - LINKAGE CONVENTIONS UPON EXIT FROM A        *   FILE 160
//*                     MODULE.                                     *   FILE 160
//*                                                                 *   FILE 160

```
