```
//***FILE 019 is from John Hooper of Salisbury, North Carolina.     *   FILE 019
//*           This file contains a collection of his utilities.     *   FILE 019
//*                                                                 *   FILE 019
//*       It pains me to report that my dear friend John Hooper     *   FILE 019
//*       has passed away.                                          *   FILE 019
//*                                                                 *   FILE 019
//*       FLSMFDSN has been updated by Orazio Scaggion to add       *   FILE 019
//*       support for SMS classes.                                  *   FILE 019
//*                                                                 *   FILE 019
//*       email:   Orazio Scaggion <orazio.scaggion@ite-sas.com>    *   FILE 019
//*                                                                 *   FILE 019
//*       Please write for support to:                              *   FILE 019
//*                                                                 *   FILE 019
//*       email:   sbgolob@cbttape.org                              *   FILE 019
//*                                                                 *   FILE 019
//*                   JOHN HOOPER UTILITIES                         *   FILE 019
//*                   ---- ------ ---------                         *   FILE 019
//*                                                                 *   FILE 019
//*    This dataset contains several utility programs which         *   FILE 019
//*    may be of general interest to other installations.  They     *   FILE 019
//*    are, of course, available on an as-is condition with         *   FILE 019
//*    the usual disclaimer.  They all worked in our former         *   FILE 019
//*    OS/390 1.2 and DFSMS 1.3 environment.  They should all       *   FILE 019
//*    work on any level of ESA system.  Some may not work on       *   FILE 019
//*    XA or earlier systems.  Most have been now been tested       *   FILE 019
//*    to work, at least through z/OS 1.13 and z/OS 2.3.            *   FILE 019
//*                                                                 *   FILE 019
//*    Each utility program has an associated member of a           *   FILE 019
//*    similar name starting with a '$' to provide                  *   FILE 019
//*    documentation for that utility.  There are also members      *   FILE 019
//*    starting with a '@' which are examples of ways to            *   FILE 019
//*    execute those utilities.  Read the documentation             *   FILE 019
//*    carefully to determine the utility's applicability to        *   FILE 019
//*    your environment.                                            *   FILE 019
//*                                                                 *   FILE 019
//*    Good luck!                                                   *   FILE 019
//*                                                                 *   FILE 019
//*    1)  BLKSCAN                                                  *   FILE 019
//*                                                                 *   FILE 019
//*        THIS PROGRAM WILL SEARCH EACH INDIVIDUAL MEMBER OF A     *   FILE 019
//*        PARTITIONED DATA SET CONTAINING JCL FOR SPECIFIED        *   FILE 019
//*        BLOCK SIZES.  IF ONE IS FOUND, THE JOBNAME, STEPNAME,    *   FILE 019
//*        PROGRAM NAME, DDNAME AND BLOCKSIZE WILL BE LISTED.       *   FILE 019
//*        IT DOES NOT HANDLE CATALOGED PROCEDURES OR INCLUDE       *   FILE 019
//*        STATEMENTS.  THE REPORT CAN BE USED TO DETECT            *   FILE 019
//*        IMPROPERLY SPECIFIED BLOCK SIZES.  OUR LOCAL STANDARD    *   FILE 019
//*        IS TO ALLOW THE SYSTEM TO SET THE BLOCKSIZE OF THE       *   FILE 019
//*        OUTPUT DATASET USING THE SYSTEM DETERMINED BLOCKSIZE     *   FILE 019
//*        FACILITY OF DFP VERSION 3.  THIS REPORT ALLOWS US TO     *   FILE 019
//*        SEE BOTH THE POORLY SPECIFIED BLOCKSIZES AS WELL AS      *   FILE 019
//*        THOSE JOBS WHICH NEED CHANGING TO ALLOW THE SYSTEM TO    *   FILE 019
//*        SET THE APPROPRIATE BLOCKSIZE.                           *   FILE 019
//*                                                                 *   FILE 019
//*    2)  CHECKPVT                                                 *   FILE 019
//*                                                                 *   FILE 019
//*        THIS PROGRAM IS DESIGNED TO RUN IMMEDIATELY AFTER AN     *   FILE 019
//*        IPL TO CHECK THE SIZE OF THE PRIVATE AREA BELOW THE      *   FILE 019
//*        16 MEG LINE.  SOFTWARE MAINTENANCE OR IMPLEMENTATION     *   FILE 019
//*        OF NEW PRODUCTS MAY SHIFT THE PRIVATE AREA SIZE DOWN     *   FILE 019
//*        AN EXTRA MEG IN ESA.  THE PARM VALUE ENTERED             *   FILE 019
//*        SPECIFIES THE MINIMUM SIZE OF THE PRIVATE AREA IN 'K'    *   FILE 019
//*        UNITS THAT IS EXPECTED.  IF THE AREA IS SMALLER THAN     *   FILE 019
//*        THIS VALUE, A NON-ROLL DELETABLE MESSAGE WILL BE         *   FILE 019
//*        WRITTEN TO THE SYSTEM CONSOLE.                           *   FILE 019
//*                                                                 *   FILE 019
//*    3)  COMMAND                                                  *   FILE 019
//*                                                                 *   FILE 019
//*        THIS PROGRAM WILL EXECUTE MVS OR JES2 COMMANDS WITHIN    *   FILE 019
//*        A BATCH JOB OR STARTED TASK.  THE COMMAND(S) CAN BE      *   FILE 019
//*        REQUESTED FROM THE PARM PARAMETER ON THE EXECUTE CARD    *   FILE 019
//*        OR FROM AN OPTIONAL PARAMETER FILE DEFINED BY THE        *   FILE 019
//*        DDNAME IEFRDER OR BOTH THE PARM AND THE FILE.  IF        *   FILE 019
//*        COMMANDS ARE ENTERED ON BOTH THE PARM AND THE OPTIONAL   *   FILE 019
//*        IEFRDER FILE, THE COMMANDS IN THE PARM ARE EXECUTED      *   FILE 019
//*        FIRST.  BECAUSE MOST MVS AND JES2 COMMANDS MAY BE        *   FILE 019
//*        EXECUTED BY THIS PROGRAM, IT SHOULD BE PROTECTED BY      *   FILE 019
//*        YOUR SECURITY SYSTEM FROM UNAUTHORIZED USE.              *   FILE 019
//*                                                                 *   FILE 019
//*        MOST INSTALLATIONS HAVE A SIMILAR PROGRAM TO THIS OR     *   FILE 019
//*        HAVE AN AUTOMATED OPERATIONS SOFTWARE PRODUCT TO DO      *   FILE 019
//*        THE SAME THING.  WHAT MAKES THIS BATCH PROGRAM           *   FILE 019
//*        DIFFERENT FROM MOST IN-HOUSE PROGRAMS IS TWO INTERNAL    *   FILE 019
//*        COMMANDS:                                                *   FILE 019
//*                                                                 *   FILE 019
//*        DELAY=NNN   WHERE NNN IS THE NUMBER OF SECONDS TO WAIT   *   FILE 019
//*                                                                 *   FILE 019
//*        THIS WILL CAUSE THE PROGRAM TO WAIT THE SPECIFIED        *   FILE 019
//*        NUMBER OF SECONDS BEFORE ISSUING THE NEXT COMMAND.       *   FILE 019
//*        THIS MAY GIVE TIME FOR THE PREVIOUS COMMAND TO BE        *   FILE 019
//*        COMPLETED.                                               *   FILE 019
//*                                                                 *   FILE 019
//*         REPLY JOBNAME 'MESSAGE TEXT' 'REPLY TEXT'               *   FILE 019
//*                                                                 *   FILE 019
//*        THIS ALLOWS THE PROGRAM TO REPLY TO AN OUTSTANDING       *   FILE 019
//*        MESSAGE FOR A SPECIFIC JOB OR TASK WITHOUT KNOWING       *   FILE 019
//*        THE REPLY NUMBER.                                        *   FILE 019
//*                                                                 *   FILE 019
//*        BY USING A COMBINATION OF WAIT, REPLY, AND NORMAL MVS    *   FILE 019
//*        AND JES2 COMMANDS, WE ARE ABLE TO BRING DOWN OUR         *   FILE 019
//*        SYSTEM FOR IPL INCLUDING STOPPING ALL OF OUR STARTED     *   FILE 019
//*        TASKS (OTHER THAN JES2) AND ONLINE SYSTEMS IN A SMALL    *   FILE 019
//*        FRACTION OF THE TIME THAT IT USED TO TAKE.               *   FILE 019
//*                                                                 *   FILE 019
//*    4)  FLCACHE                                                  *   FILE 019
//*                                                                 *   FILE 019
//*        THIS PROGRAM IS DESIGNED TO ALLOW THE OPERATOR TO        *   FILE 019
//*        DISPLAY OR MODIFY THE 3990-3 CACHE SUBSYSTEM FROM THE    *   FILE 019
//*        MVS OPERATOR'S CONSOLE.  THE ONLY PROVIDED MEANS OF      *   FILE 019
//*        CONTROL FOR THE CACHE SUBSYSTEM IS EXECUTING THE IBM     *   FILE 019
//*        IDCAMS UTILITY AS A BATCH JOB AND THEN LOOKING AT THE    *   FILE 019
//*        OUTPUT TO DETERMINE THE RESULTS OR USING THE ISMF        *   FILE 019
//*        FACILITIES UNDER ISPF TO MAKE CHANGES.  THIS FLCACHE     *   FILE 019
//*        PROGRAM WILL ACCEPT 'SIMPLE' COMMANDS FROM THE           *   FILE 019
//*        CONSOLE AND GENERATE THE APPROPRIATE IDCAMS STATEMENT    *   FILE 019
//*        AND CALL IDCAMS INTERACTIVELY TO ACTUALLY PERFORM THE    *   FILE 019
//*        FUNCTION.  ALL MESSAGES FROM IDCAMS WILL BE DISPLAYED    *   FILE 019
//*        ON THE OPERATOR'S CONSOLE.                               *   FILE 019
//*                                                                 *   FILE 019
//*        WHEN ANY DEVICE ON THE 3990 CACHE SUBSYSTEM MUST BE      *   FILE 019
//*        ALTERED FROM THE CONSOLE, IT IS OFTEN BECAUSE OF A       *   FILE 019
//*        HARDWARE PROBLEM WHEN PROMPT ACTION MUST BE TAKEN.       *   FILE 019
//*        THE IBM PUBLICATION WHICH DESCRIBES THESE SPECIAL        *   FILE 019
//*        COMMANDS IS NOT ALWAYS EASY TO LOCATE OR UNDERSTAND.     *   FILE 019
//*        HOPEFULLY, THIS PROGRAM WILL MAKE THESE FUNCTIONS        *   FILE 019
//*        EASY TO PERFORM WHEN REQUIRED.  AS ALWAYS, TECHNICAL     *   FILE 019
//*        SUPPORT SHOULD BE INVOLVED ANY TIME THIS FACILITY IS     *   FILE 019
//*        USED TO ALTER THE STATUS OF THE SUBSYSTEM.               *   FILE 019
//*                                                                 *   FILE 019
//*    5)  FLSMFCAT                                                 *   FILE 019
//*                                                                 *   FILE 019
//*        THIS UTILITY IS INTENDED TO SHOW ICF CATALOG ACTIVITY    *   FILE 019
//*        AT A DATASET LEVEL.  IT IS DESIGNED PRIMARILY TO         *   FILE 019
//*        TRACK DOWN THE JOB OR USER THAT ALLOCATED, DELETED,      *   FILE 019
//*        OR RENAMED A SPECIFIC DATASET.  SINCE THIS ACTIVITY      *   FILE 019
//*        MAY HAVE BEEN OPENED AT THAT TIME, ONLY THE CATALOG      *   FILE 019
//*        ACTIVITY SMF RECORD HAS THE INFORMATION.                 *   FILE 019
//*                                                                 *   FILE 019
//*    6)  FLSMFDSN                                                 *   FILE 019
//*                                                                 *   FILE 019
//*        THIS UTILITY IS INTENDED TO LIST VSAM AND NONVSAM        *   FILE 019
//*        DATASET ACTIVITY FOR ALL BATCH JOBS, STARTED TASKS,      *   FILE 019
//*        AND TSO USERS ON THE MVS SYSTEM.  THIS PROGRAM CAN       *   FILE 019
//*        DISPLAY DATASETS WITH SMALL BLOCK SIZES OR DATASETS      *   FILE 019
//*        WITH THE HIGH I/O ACTIVITY TO PINPOINT AREAS NEEDING     *   FILE 019
//*        CLOSER EXAMINATION.  IT PROVIDES A FLEXIBLE SELECTION    *   FILE 019
//*        AND SORT MECHANISM TO TAILOR THE REPORT.  PROGRAM        *   FILE 019
//*        PERFORMANCE CAN BE SERIOUSLY HAMPERED BY HAVING TOO      *   FILE 019
//*        SMALL OF A BLOCKSIZE ON INPUT OR OUTPUT FILES.  EVEN     *   FILE 019
//*        USING THE SYSTEM DETERMINED BLOCKSIZE FACILITY OF DFP    *   FILE 019
//*        RELEASE 3 MAY NOT ALWAYS GIVE THE DESIRED RESULTS        *   FILE 019
//*        SINCE SOME PROGRAM PRODUCTS MAY OVERRIDE THAT VALUE.     *   FILE 019
//*        THE REPORTS FROM THIS UTILITY HAVE ALLOWED US TO         *   FILE 019
//*        SIGNIFICANTLY REDUCE THE RUN TIME OF SOME OF OUR         *   FILE 019
//*        CRITICAL BATCH JOBS BY JUST CORRECTING THE BLOCKSIZE     *   FILE 019
//*        SPECIFICATIONS.  ALL OF THE STANDARDS IN THE WORLD       *   FILE 019
//*        ARE NOT WORTH ANYTHING IF YOU DON'T ENFORCE THEIR        *   FILE 019
//*        USE.                                                     *   FILE 019
//*                                                                 *   FILE 019
//*    7)  FLSMFJOB                                                 *   FILE 019
//*                                                                 *   FILE 019
//*        THIS UTILITY IS INTENDED TO LIST JOB ACTIVITY AT THE     *   FILE 019
//*        STEP OR JOB LEVEL FOR ALL BATCH JOBS, STARTED TASKS,     *   FILE 019
//*        AND TSO USERS ON THE MVS SYSTEM.  IT PROVIDES A          *   FILE 019
//*        FLEXIBLE SELECTION AND SORT MECHANISM TO TAILOR THE      *   FILE 019
//*        REPORT.  THE REPORTS FROM THIS PROGRAM ALLOWED US TO     *   FILE 019
//*        DETERMINE OUR BIGGEST USERS OF SYSTEM RESOURCES SO       *   FILE 019
//*        THAT THE PROGRAMS COULD BE EXAMINED FOR WAYS TO          *   FILE 019
//*        OPTIMIZE THEIR CODE.  WE WERE ABLE TO CUT MANY HOURS     *   FILE 019
//*        A WEEK OF CPU TIME BY CLOSELY EXAMINING ONLY A FEW       *   FILE 019
//*        PROGRAMS FOR INEFFICIENT CODING TECHNIQUES.  THIS HAS    *   FILE 019
//*        ALLOWED US TO DELAY A PREVIOUSLY NEEDED PROCESSOR        *   FILE 019
//*        UPGRADE.                                                 *   FILE 019
//*                                                                 *   FILE 019
//*        Enhanced to show ZAAP and ZIIP specialty engine use.     *   FILE 019
//*                                                                 *   FILE 019
//*    8)  FLSMFSRT                                                 *   FILE 019
//*                                                                 *   FILE 019
//*        THIS UTILITY IS INTENDED TO LIST SORT ACTIVITY BASED     *   FILE 019
//*        UPON SMF RECORDS GENERATED BY THE SYNCSORT PRODUCT.      *   FILE 019
//*        IT PROVIDES A FLEXIBLE SELECTION AND SORT MECHANISM      *   FILE 019
//*        TO TAILOR THE REPORT.  THE REPORTS FROM THIS PROGRAM     *   FILE 019
//*        ALLOWS US TO MONITOR OUR LARGER SORTS SINCE DYNAMIC      *   FILE 019
//*        ALLOCATION OF SORTWORK DATASETS MASKS THE LARGER         *   FILE 019
//*        SORTS.                                                   *   FILE 019
//*                                                                 *   FILE 019
//*    9)  FLVOLLST                                                 *   FILE 019
//*                                                                 *   FILE 019
//*        THIS PROGRAM IS DESIGNED TO PRINT A REPORT LISTING ALL   *   FILE 019
//*        OF THE DATASETS ON A VOLUME BASED UPON INFORMATION       *   FILE 019
//*        FROM THE SYSTEM CATALOGS.  THIS LIST COULD BE CRITICAL   *   FILE 019
//*        IN CASE OF A DASD FAILURE WHICH DESTROYS THE VTOC ON     *   FILE 019
//*        THE VOLUME.  WITH VOLUME POOLING NOW AVAILABLE THROUGH   *   FILE 019
//*        THE USE OF DF/SMS AND OTHER PROGRAM PRODUCTS, IT IS      *   FILE 019
//*        NOT ALWAYS EASY TO DETERMINE THE DATASETS WHICH ARE ON   *   FILE 019
//*        A SPECIFIC VOLUME.                                       *   FILE 019
//*                                                                 *   FILE 019
//*        THE INPUT TO THIS PROGRAM MUST BE THE OUTPUT FROM AN     *   FILE 019
//*        IDCAMS LISTCAT COMMAND.  IT IS EXPECTED THAT AN          *   FILE 019
//*        IDCAMS 'LISTCAT VOL CAT(USER.CATALOG.NAME)' COMMAND      *   FILE 019
//*        WILL BE EXECUTED FOR EACH CATALOG IN THE SYSTEM.  THE    *   FILE 019
//*        CONTENTS OF THESE REPORTS CAN THEN BE PASSED TO THIS     *   FILE 019
//*        UTILITY PROGRAM TO PRODUCE THE REPORT BY VOLUME AND      *   FILE 019
//*        DATASET NAME.                                            *   FILE 019
//*                                                                 *   FILE 019
//*    10) MODLOOK                                                  *   FILE 019
//*                                                                 *   FILE 019
//*        THIS PROGRAM IS DESIGNED TO RUN AS A TSO COMMAND,        *   FILE 019
//*        STARTED TASK OR A BATCH JOB TO LOOK UP THE SELECTED      *   FILE 019
//*        MODULE(S) IN THE SYSTEM LINK LIST OR LINK PACK AREA.     *   FILE 019
//*        IF THE MODULE IS IN THE LINK LIST, THE LINK LIST         *   FILE 019
//*        LIBRARY NAME WILL BE DISPLAYED.  IF THE MODULE IS IN     *   FILE 019
//*        THE LINK PACK AREA, ITS ADDRESS WILL BE DISPLAYED        *   FILE 019
//*        ALONG WITH THE NAME OF THE RESIDENT AREA IN WHICH IT     *   FILE 019
//*        IS LOCATED SUCH AS PLPA, FLPA, ECSA, ETC.  THE FIRST     *   FILE 019
//*        PART OF EACH MODULE IS DISPLAYED ALSO SINCE IT CAN       *   FILE 019
//*        CONTAIN DATE, TIME, OR COPYRIGHT INFORMATION WHICH       *   FILE 019
//*        MAY BE OF INTEREST.                                      *   FILE 019
//*                                                                 *   FILE 019
//*        WITH MANY LIBRARIES NOW IN THE SYSTEM LINK LIST, IT      *   FILE 019
//*        MAY NOT ALWAYS BE APPARENT WHICH DATASET CONTAINS        *   FILE 019
//*        WHICH PROGRAM OR EVEN MORE IMPORTANTLY, IT MAY BE        *   FILE 019
//*        DIFFICULT TO DETERMINE WHICH LIBRARY CONTAINS A          *   FILE 019
//*        MODULE IF DUPLICATE MODULE NAMES EXIST.                  *   FILE 019
//*                                                                 *   FILE 019
//*    11) SMAP                                                     *   FILE 019
//*                                                                 *   FILE 019
//*        THIS PROGRAM IS DESIGNED TO PRINT THE STARTING           *   FILE 019
//*        ADDRESS, ENDING ADDRESS, AND SIZE OF EACH OF THE         *   FILE 019
//*        MAIN STORAGE AREAS IN THE MVS SYSTEM.  THIS              *   FILE 019
//*        INFORMATION CAN BE DISPLAYED USING MOST OF THE           *   FILE 019
//*        POPULAR MONITORS CURRENTLY AVAILABLE, BUT NOT            *   FILE 019
//*        EVERYONE HAS ONE, PLUS THIS PROGRAM CAN RUN AS A         *   FILE 019
//*        BATCH JOB PRODUCING A HARDCOPY REPORT.                   *   FILE 019
//*                                                                 *   FILE 019
//*    12) JES$LF                                                   *   FILE 019
//*                                                                 *   FILE 019
//*        THIS JES2 EXIT PROGRAM IS DESIGNED TO PROCESS THE        *   FILE 019
//*        $LF COMMAND WHEN ENTERED.  IT WILL GIVE DETAILED         *   FILE 019
//*        INFORMATION AT THE OUTPUT GROUP LEVEL FOR JOBS           *   FILE 019
//*        AWAITING PRINT.  IT IS, IN EFFECT, A DETAILED            *   FILE 019
//*        VERSION OF THE $DF COMMAND.                              *   FILE 019
//*                                                                 *   FILE 019
//*  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  *   FILE 019
//*                                                                 *   FILE 019
//*     Changes dated 08/12/05 - Peter Hunkeler (@PHUN01)           *   FILE 019
//*                                                                 *   FILE 019
//*     Entries changed:                                            *   FILE 019
//*                                                                 *   FILE 019
//*        FLSMFJOB  A new keyword CPUTIMEFRACTS was added. It      *   FILE 019
//*                  requests that hundredths of a second are       *   FILE 019
//*                  taken into account when selecting records      *   FILE 019
//*                  by CPU time and when printing CPU time values. *   FILE 019
//*                                                                 *   FILE 019
//*                                                                 *   FILE 019
//*     Changes dated 09/01/03                                      *   FILE 019
//*                                                                 *   FILE 019
//*     Entries removed:                                            *   FILE 019
//*                                                                 *   FILE 019
//*        JES$LF    This exit 5 routine was affected by the        *   FILE 019
//*                  changes that were part of z/OS 1.2.            *   FILE 019
//*                  After much discussion at our                   *   FILE 019
//*                  installation is was determined that the        *   FILE 019
//*                  effort and time to update this exit was        *   FILE 019
//*                  not worth its limited use.  We, like           *   FILE 019
//*                  most installation use IOF or SDSF to           *   FILE 019
//*                  access the jobs in the print queue.  The       *   FILE 019
//*                  operator's console is only used by the         *   FILE 019
//*                  "old timers".  We may add this back in         *   FILE 019
//*                  the future as time allows but it is            *   FILE 019
//*                  unlikely that time will ever allow.            *   FILE 019
//*                  Sorry.                                         *   FILE 019
//*                                                                 *   FILE 019
//*     Entries added:                                              *   FILE 019
//*                                                                 *   FILE 019
//*        PAGEFIX   This utility allows an installation to         *   FILE 019
//*                  effectively dynamically remove storage         *   FILE 019
//*                  from the system.  This can be either to        *   FILE 019
//*                  reserve it for some future use or to           *   FILE 019
//*                  determine the effects that a major new         *   FILE 019
//*                  application may have on paging.                *   FILE 019
//*                                                                 *   FILE 019
//*        CONSOLE   This TSO command provide a similar look        *   FILE 019
//*                  and feel as an operators console.              *   FILE 019
//*                  Several levels of security can be set to       *   FILE 019
//*                  grant varying lists of commands to be          *   FILE 019
//*                  issued.  It is typically linked into the       *   FILE 019
//*                  system as CONS so as not to be confused        *   FILE 019
//*                  with the IBM supplied CONSOLE command.         *   FILE 019
//*                                                                 *   FILE 019
//*        LISTF     This TSO command provides ANOTHER way to       *   FILE 019
//*                  list the free space for one or more disk       *   FILE 019
//*                  volumes.  The one feature that I think         *   FILE 019
//*                  sets is apart from the others is the           *   FILE 019
//*                  support for SMS STORAGE GROUP and status       *   FILE 019
//*                  without having to use ISMF.  It uses an        *   FILE 019
//*                  undocumented interface and, as such, is        *   FILE 019
//*                  subject to future failures.  It also           *   FILE 019
//*                  provides flexible selection criteria and       *   FILE 019
//*                  sort criteria.                                 *   FILE 019
//*                                                                 *   FILE 019
//*     Entries updated:                                            *   FILE 019
//*                                                                 *   FILE 019
//*        COMMAND   This utility was greatly extended.  New        *   FILE 019
//*                  commands like IFSTARTED, IFSTOPPED,            *   FILE 019
//*                  IFONLINE, IFOFFLINE, ONLINE, OFFLINE were      *   FILE 019
//*                  added as well as support for 4 digit           *   FILE 019
//*                  reply numbers.  See member $COMMAND for        *   FILE 019
//*                  details.                                       *   FILE 019
//*                                                                 *   FILE 019
//*        FLSMFCAT  Improved Y2K support was added.                *   FILE 019
//*                                                                 *   FILE 019
//*                  Updated date processing to allow               *   FILE 019
//*                  selection using several date formats           *   FILE 019
//*                  including Gregorian.                           *   FILE 019
//*                                                                 *   FILE 019
//*                  Updated date processing to allow display       *   FILE 019
//*                  in either Julian or Gregorian format.          *   FILE 019
//*                  It now defaults to displaying the date         *   FILE 019
//*                  in Gregorian format.                           *   FILE 019
//*                                                                 *   FILE 019
//*                  Time processing was improved to allow          *   FILE 019
//*                  printing across midnight.                      *   FILE 019
//*                                                                 *   FILE 019
//*        FLSMFJOB  Improved Y2K support was added.                *   FILE 019
//*                                                                 *   FILE 019
//*                  Time processing was improved to allow          *   FILE 019
//*                  printing across midnight.                      *   FILE 019
//*                                                                 *   FILE 019
//*        FLSMFDSN  Improved Y2K support was added.                *   FILE 019
//*                                                                 *   FILE 019
//*                  Added support for number of extents.           *   FILE 019
//*                                                                 *   FILE 019
//*                  Added support for VSAM statistics.             *   FILE 019
//*                                                                 *   FILE 019
//*                  Time processing was improved to allow          *   FILE 019
//*                  printing across midnight.                      *   FILE 019
//*                                                                 *   FILE 019
//*        MODLOOK   Support for dynamic linklists was added.       *   FILE 019
//*                                                                 *   FILE 019

```
