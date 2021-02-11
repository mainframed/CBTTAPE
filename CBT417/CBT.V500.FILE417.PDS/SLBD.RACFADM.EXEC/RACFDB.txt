/*%NOCOMMENT====================* REXX *==============================*/
/*  PURPOSE:  RACFADM - Database Information - Menu option 7 or 8     */
/*--------------------------------------------------------------------*/
/* FLG  YYMMDD  USERID   DESCRIPTION                                  */
/* ---  ------  -------  -------------------------------------------- */
/* @AJ  200629  RACFA    If no RACF bkup dsn, then display N/A        */
/* @AI  200629  RACFA    Fixed FMID                                   */
/* @AH  200616  RACFA    Chg panel name RACFRPTS to RACFDISP          */
/* @AG  200517  RACFA    Standardize environment (ADDRESS ISPEXEC)    */
/* @AF  200516  RACFA    Fix display error messages                   */
/* @AE  200506  RACFA    Display headers in a different color         */
/* @AD  200501  RACFA    A tweak to the text displayed                */
/* @AC  200424  RACFA    Move DDNAME at top, standardize/del dups     */
/* @AB  200423  RACFA    Move PARSE REXXPGM name up above IF SETMTRAC */
/* @AA  200423  RACFA    Chg dash line to 72, was 62 columns in length*/
/* @A9  200423  RACFA    Ensure REXX program name is 8 chars long     */
/* @A8  200413  RACFA    Chg TRACEing to only display banner (P=Pgms) */
/* @A7  200412  RACFA    Chg SAY to ISPF message                      */
/* @A6  200412  RACFA    Chg TRACE to allow 'L'abels or 'R'esults     */
/* @A5  200402  RACFA    Allow tracing, 'REXX trace = Y' in Settings  */
/* @A4  200401  RACFA    Chged edit macro RACFLOGE to RACFEMAC        */
/* @A3  200401  RACFA    VIEW/EDIT use edit macro, to turn off HILITE */
/* @A2  200326  RACFA    Chg temp file to LRECL=80, was 132           */
/* @A1  200326  RACFA    Chg SAYs to QUEUE, alloc, browse, free file  */
/* @A0  200326  LBD      Obtained REXX                                */
/*====================================================================*/
/*REXX*BUFFERS********************************************************/
/*                                                                   */
/*  DISPLAY RACF DSNAMES AND NUMERIOUS OTHER GOODIES                 */
/*                                                                   */
/*  AUTHORS:                                                         */
/*           THERE IS A VARITY OF AUTHORS INVOLVED WITH THIS CODE    */
/*             AND I LIKE GIVING CREDIT WHERE CREDIT IS DUE. WALT    */
/*             FARRELL STARTED THIS CODE BY DISPLAYING ALL DSNT DSN  */
/*             ENTRIES AND BUFFER SIZES. OTHER AUTHORS ARE G. FOGG   */
/*             (THAT'S ME WRITTING THESE COMMENTS)                   */
/*             AND I TOOK SOME EXISTING REXX CODE I HAD WRITTEN      */
/*             A LONG TIME AGO THEN MODIFIED AND INTEGRATED IT INTO  */
/*             WALT'S STUFF. I BORROWED REXX STATEMENTS FROM ZELDON'S*/
/*             REXX EXEC "IPLINFO" THAT DISPLAYS THE SMF ID, THE     */
/*             OPERATING SYSTEM RELEASE AND RACF'S FMID LEVEL.       */
/*                                                                   */
/*  DISCLAIMERS:                                                     */
/*           (1) USE AT YOUR OWN RISK--EVEN THOUGH THIS CODE DOES    */
/*                 NOT MODIFY STORAGE OR RACF DATABASE INFORMATION.  */
/*                 SO AGAIN, USE AT YOUR OWN RISK.                   */
/*           (2) DON'T EVEN THINK THAT SOMEHOW, THE AUTHORS ARE EVEN */
/*                 LIBEL FOR THIS CODE.                              */
/*           (3) IT'S FREE CODE SO NO WHINING ALLOWED. SUGGESTIONS   */
/*                 FOR IMPROVEMENT OR ANY BUGS FOUND IS ACCEPTABLE   */
/*                 VIA EMAIL TO: GFOGG@NWLINK.COM                    */
/*  GENERAL DESCRIPTION:                                             */
/*             THIS EXEC RETRIEVES DATA FROM THE DSDT INSTORAGE      */
/*               BLOCK, MAPPED BY THE ICHPDSDT MACRO AND "ALL"       */
/*               FIELDS ARE MARKED AS "NOT A PROGRAMMING INTERFACE"  */
/*               WHICH MEANS AT IBM'S DESCRETION, THESE FIELDS MAY   */
/*               CHANGE WITHOUT NOTICE. HOWEVER, I HAVE NEVER SEEN   */
/*               THIS HAPPEN; THEY JUST ADD NEW FIELDS ONCE IN       */
/*               WHILE  OR ADD NEW FIELDS IN THE OCO EXTENSION       */
/*               CONTROL BLOCK THAT IS NOT PUBLISHED.                */
/*             THIS EXEC ALSO READS EACH RACF DATABASE DEFINED       */
/*               IN THE DSDT TO GET BAM ADDRESSES IN THE ICB BLOCK   */
/*               AND READS EACH BAM BLOCK TO CACULATE THE AMOUNT     */
/*               OF SPACE USED. THE MORE BAM BLOCKS THE MORE TIME    */
/*               IT TAKES THIS EXEC TO PROCESS SO YOU MAY SEE        */
/*               SOME TIME DELAY IN DISPLAYING THE INFORMATION.      */
/*               REMEMBER--REXX I/O IS VERY SLOW. ADDITIONALLY I     */
/*               DON'T SERIALIZE THE RACF DB WITH SYSZRACF SO NO     */
/*               I/O DELAYS ARE AFFECTED BY THIS EXEC.               */
/*                                                                   */
/*  USAGE:  SAVE THIS REXX EXEC IN SOME REXX LIBRARY AND GIVE IT A   */
/*            NAME. I USE THE NAME "RACFDB". I ALSO HAVE MY REXX     */
/*            LIBRARY CONCATIONATED TO DD(SYSEXEC) AS PART OF THE    */
/*            LOGON LIBRARIES SO I CAN JUST ENTER THE COMMAND IN     */
/*            ANY PDF PANEL LINE. EXAMPLE:  "COMMAND===>TSO RACFDB"  */
/*                                                                   */
/*  OUTPUT FROM THE COMMAND:                                         */
/*                                                                   */
/* -------------------START OF COMMAND OUTPUT------------------------*/
/* (1) SMF NAME=XOST Z/OS 01.04.00 SECURITY SERVER RACF FMID=HRF7707 */
/*                                                                   */
/* (2) PRIMARY #1: STATUS =ACTIVE                                    */
/*   DSNAME = SYS1.RACF.PRIM                           VOL =XXRACF   */
/*   # BUFFERS = 255                                                 */
/*   PERCENT SPACE USED = %45.82 OF CYLINDER(130)                    */
/*                                                                   */
/* BACKUP  #1: STATUS=ACTIVE                                         */
/*   DSNAME = SYS1.RACF.BKUP                           VOL=ZZRACF    */
/*   # BUFFERS = 51                                                  */
/*   PERCENT SPACE USED = %45.82 OF CYLINDER(130)                    */
/*                                                                   */
/* (3) IRRMIN00 VERSION/RELEASE/MODIFICATION = 7707                  */
/* (4) RACF DATABASE TEMPLATE RMID LEVEL =     HRF7707               */
/* (5) SYSPLEX COMMUNICATIONS ENABLED AND                            */
/* (6) IN DATASHARING MODE                                           */
/* ---------------------END OF COMMAND OUTPUT------------------------*/
/*                                                                   */
/*  NOTES:                                                           */
/*  (1) DISPLAYS THE SMF ID AS DEFINED IN THE PARMLIB MEMBER         */
/*        SMFPRMXX USING THE SID(NAME) STATEMENT.                    */
/*      DISPLAYS THE OS NAME AS EITHER OS/390 OR Z/OS.               */
/*      DISPLAYS THE VERSION/RELEASE/MODIFICATION OF THE OS.         */
/*      DISPLAYS THE SECURITY SERVER RACF FMID. THE RACF FMID        */
/*      MAY OR MAY NOT CHANGE BETWEEN OS RELEASES. FOR EXAMPLE,      */
/*      RACF FMID HRF7703 WAS THE SAME FOR OS/390 V2R10 AND          */
/*      Z/OS V1R1.                                                   */
/*                                                                   */
/*  (2) DISPLAYS THE RACF DATABASE AS THE PRIMARY OR BACKUP AND      */
/*        IF THE DATABASE IS ACTIVE OR INACTIVE. ALSO SHOWN IS THE   */
/*        SEQUENCE NUMBER OF THE DATABASE AS DEFINED IN ICHRDSNT.    */
/*      DISPLAYS THE RACF DATABASE NAME AND VOLSER OF WHERE THE      */
/*        DATABASE IS CATALOGED.                                     */
/*      DISPLAYS THE NUMBER OF RESIDENT DATA BLOCKS DEFINED IN THE   */
/*        ICHRDSNT TABLE FOR THE RACF DATABASE.                      */
/*      DISPLAYS THE PERCENT SPACE USED OF THE SPACE ALLOCATED (BY   */
/*      AS DEFINED BY RACF BAM (BLOCK AVALIBILITY MASK) BLOCKS AND   */
/*        SHOWS HOW THE DATABASE WAS ALLOCATED BY EITHER BLOCKS,     */
/*        TRACKS OR CYLINDERS.                                       */
/*                                                                   */
/*  (3) DISPLAYS THE VERSION OF IRRMIN00 THAT LAST PROCESSED THE     */
/*        RACF DATABASE. FOR EXAMPLE, YOUR SYSTEM IS IPL'ED ON       */
/*        Z/OS V1R2 WITH RACF FMID HRF7705. IF YOU USED A COPY OF    */
/*        Z/OS V1R4 IRRMIN00 TO UPDATE THE TEMPLATES PRIOR TO        */
/*        IPLING ON V1R4 THEN THE IRRMIN00 VERSION DISPLAYED ON      */
/*        THIS LINE SHOULD BE 7707.                                  */
/*                                                                   */
/*  (4) DISPLAYS THE RMID OR TEMPLATE LEVEL. RMID IS ALSO KNOWN      */
/*        AS THE SYSMOD ID (A SMPE TERM). THIS COULD BE THE FMID     */
/*        OF RACF OR AN APAR VALUE. THIS FIELD WILL HAVE RACF'S      */
/*        FMID MOST OF THE TIME BUT IF AN APAR OR A SPE REQUIRES THE */
/*        TEMPLATES UPDATED THEN YOU WILL SEE THE APAR VALUE INSTEAD */
/*        OF RACF'S FMID VALUE.                                      */
/*                                                                   */
/*  (5) TELLS YOU IF SYSPLEX COMMAND COMMUNICATION IS ENABLED OR     */
/*        NOT AS SPECIFIED IN THE ICHRDSNT FLAG BYTE.                */
/*                                                                   */
/*  (6) DISPLAYS DATASHARE MODE AS SPECIFIED IN THE ICHRDSNT TABLE   */
/*        OR MODIFIED BY THE "RVARY DATASHARE/NODATASHARE" COMMAND.  */
/*        POSSIBE MESSAGES DISPLAYED:                                */
/*         IN NON-DATASHARING MODE                                   */
/*         IN DATASHARE MODE                                         */
/*         IN READ-ONLY MODE                                         */
/*         IN TRANSTITION MODE. EITHER BE READ ONLY OR DATASHARE     */
/*                                                                   */
/*      NOTE: THIS EXEC SHOWS XCF, DATASHARING STATUS, AND IF THE    */
/*              THE DATABASE(S) ARE ACTIVE OR NOT BUT I ALSO         */
/*              SUGGEST TO USE THE IBM SUPPORTED METHOD BY USING     */
/*              THE "RVARY LIST" COMMAND TO GET THIS TYPE OF         */
/*              INFORMATION.                                         */
/*                                                                   */
/*  ENVIRONMENT:                                                     */
/*           THIS CODE HAS BEEN TESTED ON OS/390 V2R10 AND           */
/*           Z/OS V1R4 ON SINGLE AND SPLIT DATABASES.                */
/*                                                                   */
/*********************************************************************/
PANEL01     = "RACFDISP"   /* Display report with colors   */ /* @AH */
EDITMACR    = "RACFEMAC"   /* Edit Macro, turn HILITE off  */ /* @A4 */
DDNAME      = 'RACFA'RANDOM(0,999) /* Unique ddname        */ /* @AC */
parse source . . REXXPGM .                                    /* @AB */
REXXPGM     = LEFT(REXXPGM,8)      /* Obtain REXX pgm name */ /* @AB */

ADDRESS ISPEXEC                                               /* @AG */
  "VGET (SETGDISP SETMTRAC)"                                  /* @A5 */
  If (SETMTRAC <> 'NO') then do                               /* @A6 */
     Say "*"COPIES("-",70)"*"                                 /* @A6 */
     Say "*"Center("Begin Program = "REXXPGM,70)"*"           /* @A6 */
     Say "*"COPIES("-",70)"*"                                 /* @A6 */
     if (SETMTRAC <> 'PROGRAMS') THEN                         /* @A8 */
        interpret "Trace "SUBSTR(SETMTRAC,1,1)                /* @A6 */
  end                                                         /* @A6 */

  racflmsg = "Retrieving data - Please be patient"            /* @A1 */
  ADDRESS ISPEXEC "control display lock"                      /* @AG */
  ADDRESS ISPEXEC "display msg(RACF011)"                      /* @AG */
  NUMERIC DIGITS 10     /* DEFINE DIGIT SIZE FOR 31 BIT ADDRESSING   */
  RACFVRMN = ''
  LINE     = ''
  CVT      = C2X( STORAGE(10,4) )      /* POINTER TO CVT             */
  RCVT     = D2X(X2D(CVT) +X2D(3E0))   /* POINTER TO RCVT POINTER    */
  RCVT     = C2X(STORAGE(RCVT,4))      /* POINTER TO RCVT            */
  /* SAY "RCVT ACRONYM: "STORAGE(RCVT,4) */
  DSDT     = D2X(X2D(RCVT) + X2D(E0) ) /* POINTER TO DSDT POINTER    */
  DSDT     = C2X(STORAGE(DSDT,4))      /* POINTER TO DSDT            */
  /* SAY "DSDT ACRONYM: "STORAGE(DSDT,4) */
  DSDTNUM  = D2X(X2D(DSDT) + X2D(4))   /* ADDRESS OF DSDTNUM         */
  DSDTNUM  = C2D(STORAGE(DSDTNUM,4))   /* DSDTNUM                    */
  DSDTPRIM = D2X(X2D(DSDT) + X2D(90))  /* ADDRESS OF FIRST PRIM DS   */
  DSDTBACK = D2X(X2D(DSDT) + X2D(140)) /* ADDRESS OF FIRST BKUP DS   */
  DSDTDSRQ = D2X(X2D(DSDT) + X2D(88))  /* DATASHARE FLAG ONE         */
  DSDTDSRQ = STORAGE(DSDTDSRQ,1)       /* GET CMD COMMUNICATIONS FLG */
  IF (BITAND(DSDTDSRQ,'80'X) = '80'X) THEN
     SYSCOM = "Sysplex communications ENABLED and"            /* @A1 */
  ELSE                                                        /* @A1 */
     SYSCOM = "Sysplex communications DISABLED and"           /* @A1 */
  DSDTDSMO = D2X(X2D(DSDT) + X2D(89))  /* DATASHARE FLAG TWO         */
  DSDTDSMO = C2D(STORAGE(DSDTDSMO,1))  /* GET DATASHARE STATUS FLAG  */
  SELECT
     WHEN (DSDTDSMO = 0) THEN
          SYSDS = "in NON-DATA SHARING mode"                  /* @A1 */
     WHEN (DSDTDSMO = 1) THEN
          SYSDS = "in DATASHARE mode"                         /* @A1 */
     WHEN (DSDTDSMO = 2) THEN
          SYSDS = "in READ only mode"                         /* @A1 */
     WHEN (DSDTDSMO = 3) THEN
          SYSDS = "in TRANSITION mode.",                      /* @A1 */
                = "Either be READ ONLY or DATASHARE"          /* @A1 */
     OTHERWISE
          SYSDS = "WARNING: Unknown DSDTDSMO code==>" DSDTDSMO/* @A1 */
  END  /*-- END OF SELECT SEQUENCE --*/

  CALL SSVRM                         /*DISPLAY OS AND RACF FMID DATA */
  DO II = 1 TO DSDTNUM                 /* LOOP THROUGH ENTRIES       */
     PNAME = D2X(X2D(DSDTPRIM) + X2D(21))  /* ADDR OF NAME           */
     PNAME = STORAGE(PNAME,44)             /* NAME                   */
     PNUM  = D2X(X2D(DSDTPRIM) + X2D(20))  /* ADDR OF BUFFER COUNT   */
     PNUM  = C2D(STORAGE(PNUM,1))          /* BUFFER COUNT           */
     PSTAT = D2X(X2D(DSDTPRIM) + X2D(1D))  /* ADDR OF DSDPSTAT       */
     PSTAT = STORAGE(PSTAT,1)              /* PRIMARY STATUS BYTE    */
     IF (BITAND(PSTAT,'80'X) = '80'X) THEN
        PSTAT = "ACTIVE"
     ELSE
        PSTAT = "INACTIVE"
     BNAME = D2X(X2D(DSDTBACK) + X2D(21))  /* ADDR OF NAME           */
     BNAME = STORAGE(BNAME,44)             /* NAME                   */
     if pos(left(bname,1),'ABCDEFGHIJKLMNOPQRSTUVWXYZ@#$') = 0
        then bname = ''                                       /* @AJ */
     if (bname = "") THEN                                     /* @AJ */
         bname = "N/A"                                        /* @AJ */
     BNUM  = D2X(X2D(DSDTBACK) + X2D(20))  /* ADDR OF BUFFER COUNT   */
     BNUM  = C2D(STORAGE(BNUM,1))          /* BUFFER COUNT           */
     BSTAT = D2X(X2D(DSDTBACK) + X2D(1D))  /* ADDR OF DSDTSTAT       */
     BSTAT = STORAGE(BSTAT,1)              /* BACKUP  STATUS BYTE    */
     IF (BITAND(BSTAT,'80'X) = '80'X) THEN
        BSTAT = "ACTIVE"
     ELSE
        BSTAT = "INACTIVE"
     QUEUE COPIES("-",72)                                     /* @AA */
     QSNAME = "'"STRIP(PNAME)"'"         /*PUT QUOTES AROUND RDB NAME*/
     CALL FINDSIZE QSNAME                /* GET THE SPACE USED VALUE */
     QUEUE "PRIMARY #"II                                      /* @AD */
     QUEUE "  Status ......... "PSTAT                         /* @A1 */
     QUEUE "  Dsname ......... "PNAME                         /* @A1 */
     QUEUE "  Volume ......... "VOLSER                        /* @A1 */
     QUEUE "  # Buffers ...... "PNUM                          /* @A1 */
     QUEUE "  % Space used ...",                              /* @A1 */
           "%"TRUNC(((USED_SEGS / SEG_COUNT) * 100),2) "OF",
           SPACEUNIT"("SPACEALLOC")"
     QUEUE " "                                                /* @A1 */
     QSNAME = "'"STRIP(BNAME)"'"         /*PUT QUOTES AROUND RDB NAME*/
     CALL FINDSIZE QSNAME                /* GET THE SPACE USED VALUE */
     QUEUE "BACKUP  #"II                                      /* @AD */
     QUEUE "  Status ......... "BSTAT                         /* @A1 */
     QUEUE "  Dsname ......... "BNAME                         /* @A1 */
     QUEUE "  Volume ......... "VOLSER                        /* @A1 */
     QUEUE "  # Buffers ...... "BNUM                          /* @A1 */
     QUEUE "  % Space used ...",                              /* @A1 */
           "%"TRUNC(((USED_SEGS / SEG_COUNT) * 100),2) "OF",
           SPACEUNIT"("SPACEALLOC")"

     DSDTPRIM = D2X(X2D(DSDTPRIM) + 352) /* BUMP TO NEXT SLOT        */
     DSDTBACK = D2X(X2D(DSDTBACK) + 352) /* BUMP TO NEXT SLOT        */
  END                                    /* END OF II DO LOOP        */

  CVDX  = D2X(X2D(RCVT) + X2D(258) )   /* ADDR OF RCDX POINTER       */
  CVDX  = C2X(STORAGE(CVDX,4))         /* POINTER TO CVDX            */
  PVERA = D2X(X2D(CVDX) + X2D(1DC))    /* ADDRESS OF TMPLATE VERSION */
  DPVER = STORAGE(PVERA,7)             /* DYNAMIC PARSE VERSION      */

  QUEUE COPIES('-',72)                                        /* @AA */
  QUEUE "IRRMIN00 version/release/modification ... "RACFVRMN  /* @A1 */
  QUEUE "RACF database template RMID level ....... "RACFTEMP  /* @A1 */
  QUEUE "Dynamic parse version ................... "DPVER
                                                              /* @A1 */
  /* IF ICBTMPRL /= '0000000000000000'X THEN DO             *//* @A1 */
  /*     QUEUE "Template release/APAR level .............", *//* @A1 */
  /*           ICBTMPRL33"."33ICBTMPAL                      *//* @A1 */
  /* END                                                    *//* @A1 */
  QUEUE SYSCOM SYSDS                                          /* @A1 */
  QUEUE                                                       /* @A1 */
                                                              /* @A1 */
  ADDRESS TSO "ALLOC F("DDNAME") NEW REUSE",                  /* @AG */
              "LRECL(80) BLKSIZE(0) RECFM(F B)",              /* @A2 */
              "UNIT(VIO) SPACE(1 5) CYLINDERS"                /* @A1 */
  ADDRESS TSO "EXECIO * DISKW "DDNAME" (FINIS"                /* @AG */

  "LMINIT DATAID(CMDDATID) DDNAME("DDNAME")"                  /* @AG */
  SELECT                                                      /* @A1 */
     WHEN (SETGDISP = "VIEW") THEN                            /* @A1 */
          "VIEW DATAID("CMDDATID")",                          /* @AG */
                       "MACRO("EDITMACR")",                   /* @AE */
                       "PANEL("PANEL01")"                     /* @AE */
     WHEN (SETGDISP = "EDIT") THEN                            /* @A1 */
          "EDIT DATAID("CMDDATID")",                          /* @AG */
                       "MACRO("EDITMACR")",                   /* @AE */
                       "PANEL("PANEL01")"                     /* @AE */
     OTHERWISE                                                /* @A1 */
          "BROWSE DATAID("CMDDATID")"                         /* @AG */
  END                                                         /* @A1 */

  ADDRESS TSO "FREE FI("DDNAME")"                             /* @AG */

  call Goodbye                                                /* @A6 */
EXIT
/*--------------------------------------------------------------------*/
/*  If tracing is on, display flower box                         @A6  */
/*--------------------------------------------------------------------*/
GOODBYE:                                                      /* @A6 */
  If (SETMTRAC <> 'NO') then do                               /* @A6 */
     Say "*"COPIES("-",70)"*"                                 /* @A6 */
     Say "*"Center("End Program = "REXXPGM,70)"*"             /* @A6 */
     Say "*"COPIES("-",70)"*"                                 /* @A6 */
  end                                                         /* @A6 */
EXIT                                                          /* @A6 */
/*--------------------------------+----------------------------------*/
/*                           SUBROUTE AREA                           */
/*--------------------------------+----------------------------------*/
FINDSIZE:
  ARG RDSN                      /* GET RACF DATASET NAME             */
  FREE_SEGS = 0                 /* TOTAL NUMBER FREE SEGMENTS        */
  USED_SEGS = 0                 /* TOTAL NUMBER ALLOCATED SEGMENTS   */
  CALL $RDSN_SETUP              /* OPEN RACF DSN AND READ ICB BLOCK  */
  BAM_COUNTER = 0               /* COUNT NUMBER OF BAMS PROCESSED    */

  DO FOREVER
     BAM_COUNTER = BAM_COUNTER + 1
     /*SAY "PROCESSING BAM BLOCK " BAM_COUNTER "OF" C2D(BAM_BCNT)*/

     X = $GBLK(BAM_ADDR,BSIZE)   /* READ IN A BAM BLOCK              */
     PARSE VAR BLK.1   ,         /* PARSE BAM HEADER AND MASK BITS   */
           PREV_BAM_BLOCK +6,    /* PREVIOUS OR IF ZERO THE 1st BAM  */
           NEXT_BAM_BLOCK +6,    /* NEXT BAM BLOCK ADDRESS           */
           RBA1_BAM_BLOCK +6,    /* RBA OF 1ST. BLOCK BAM DEFINES    */
           BLK_CNT +2,           /* NO. OF BLOCKS THIS BAM DEFINES   */
           BAM_DATA              /* BAM MASK BIT (1 BIT = 1 SEGMENT) */

     BLKC = C2D(BLK_CNT)                   /* EACH SEGMENT=256 BYTES */
     X = $GET_BAM_COUNT(BAM_DATA,BLKC)     /* GET ALLOC. DATA IN BAM */
     IF (C2D(NEXT_BAM_BLOCK) = 0) THEN     /* NO MORE BAMS?          */
        LEAVE
     ELSE
        BAM_ADDR = NEXT_BAM_BLOCK          /* Yes CONTINUE           */
  END                                      /*     END OF DO FOREVER  */

  /* SAY "FREE SEGMENTS =>    " FREE_SEGS */
  /* SAY "USED SEGMENTS =>    " USED_SEGS */
  /* SAY "TOTAL SEGMENTS=>    " SEG_COUNT */
  ADDRESS TSO "EXECIO 1 DISKR SYSRACF 1 (STEM ICB. FINIS"     /* @AG */
  ADDRESS TSO "FREE F(SYSRACF)"                               /* @AG */
RETURN
/*---------------------------RDSN_SETUP-------------------------------*/
/* THIS FUNCTION WILL QUERRY THE USER FOR A RACF DATABASE NAME AND    */
/* ISSUE THE "ALLOC" COMMAND. THE FIRST RECORD (ICB) IS READ FROM THE */
/* RACF DATABASE TO OBTAIN BAM POINTER DATA.                          */
/* THIS FUNCTION WILL ONLY DO ELEMENTRY CHECKING TO SEE IF THE RACF   */
/* DATABASE NAME IS LEGIT. IT ONLY CHECKS IF THE DATA SET NAME ENTERED*/
/* IS CATALOGED AND IF THE BLOCK SIZE IS 4096. ANY OTHER ISSUES LIKE  */
/* THE WRONG DSORG OR RECFM ARE NOT CHECKED AND EXPECT ERRORS TO      */
/* HAPPEN DURING EXECIO PROCESSING.                                   */
/*--------------------------------------------------------------------*/
$RDSN_SETUP:
  /*--------------------------------------------------------*/
  /* CALL LISTDSI TO TEST IF THE RACF DATASET IS CATALOGED. */
  /*--------------------------------------------------------*/
  FRC = LISTDSI(RDSN)
  IF (FRC /= 0) THEN DO
     racfsmsg = ''                                            /* @A7 */
     racflmsg = 'Invalid or unknown RACF',                    /* @A7 */
                'database name: 'RDSN'. ',                    /* @A7 */
                'Dataset must be cataloged,',                 /* @A7 */
                'restructured RACF database.'                 /* @A7 */
     "SETMSG MSG(RACF011)"                                    /* @AG */
     call Goodbye                                             /* @A6 */
  END
  BSIZE      = SYSBLKSIZE
  VOLSER     = SYSVOLUME
  SPACEUNIT  = SYSUNITS
  SPACEALLOC = SYSALLOC
  /*----------------------------------------*/
  /* TEST TO SEE IF THE BLOCK SIZE IS 4096. */
  /*----------------------------------------*/
  IF (BSIZE /= 4096) THEN DO
     racfsmsg = ''                                            /* @A7 */
     racflmsg = "RACF database entered does not have a",      /* @A7 */
                "restructured 4096 block size."               /* @A7 */
     "SETMSG MSG(RACF011)"                                    /* @AG */
     call Goodbye                                             /* @A6 */
  END
  /*---------------------------------------------------*/
  /* ALLOCATE AND READ IN THE ICB TO GET BAM POINTERS. */
  /*---------------------------------------------------*/
  ADDRESS TSO "ALLOC F(SYSRACF) REUSE DA("RDSN")",            /* @AG */
              "SHR LRECL("BSIZE")"                            /* @AG */
  ADDRESS TSO "EXECIO 1 DISKR SYSRACF 1 (STEM ICB. "          /* @AG */

  BAM_BCNT = SUBSTR(ICB.1,05,4)       /* NUMBER OF BAM BLKS DEFINED  */
  BAM_ADDR = SUBSTR(ICB.1,21,6)       /* RBA OF 1st BAM BLK IN CHAIN */
  IF (RACFVRMN = '') THEN DO
     RACFVRMN = SUBSTR(ICB.1,1019,6)  /* TEMPLATE VERSION/RELEASE/MOD*/
     RACFTEMP = SUBSTR(ICB.1,1057,7)  /* TEMPLATE LEVEL VALUE        */
     ICBTMPRL = SUBSTR(ICB.1,519,8)   /* TEMPLATE RELEASE LEVEL      */
     ICBTMPAL = SUBSTR(ICB.1,527,8)   /* TEMPLATE APAR    LEVEL      */
  END
RETURN
/*---------------------------$GBLK------------------------------------*/
/* THIS FUNCTION WILL READ ONE RACF DATABASE RECORD. INPUT TO THIS    */
/* ROUTINE IS THE RBA ADDRESS OF THE BLOCK TO BE READ AND THE BLKSIZE */
/* WHICH IS USED TO CACULATE THE RECORD NUMBER NEEDED IN THE EXECIO.  */
/* RECORD NUMBER =  (RBA / BLKSIZE) + 1                               */
/* FUNCTION:  $GBLK    -GET A RACF BLOCK FROM THE DATABASE            */
/* ARGUMENT 1 = RBA ADDRESS IN CHARACTER FORMAT                       */
/* ARGUMENT 2 = BLOCK SIZE OF THE RACF DATABASE BLOCKS IN DECIMAL     */
/*--------------------------------------------------------------------*/
$GBLK:
  PARSE ARG AD1, AD2
  IF (AD1 = 0) THEN
     REC_ADDR = 1
  ELSE
     REC_ADDR = TRUNC(((C2D(AD1) / AD2) + 1))
  ADDRESS TSO "EXECIO 1 DISKR SYSRACF "REC_ADDR" (STEM BLK. " /* @AG */
  RRC = RC
RETURN RRC
/*------------------------$GET_BAM_COUNT------------------------------*/
/* THIS FUNCTION WILL COUNT THE NUMBER OF BAM BITS SET ON OR OFF      */
/* IN A GIVEN BAM BLOCK.                                              */
/* FUNCTION:  $GET_BAM_COUNT ARG1 ARG2                                */
/* ARGUMENT 1 = BAM MASK BITS (EACH BIT = 1 SEGMENT)                  */
/* ARGUMENT 2 = NUMBER OF BLOCKS THIS BAM BLOCK DEFINES               */
/* RESULTS FROM ROUTINE:                                              */
/* FREE_SEGS = TOTAL NUMBER OF FREE SEGMENTS DEFINED IN THIS BAM BLK  */
/* USED_SEGS = TOTAL NUMBER OF USED SEGMENTS DEFINED IN THIS BAM BLK  */
/* SEG_COUNT = SUM OF BOTH ABOVE VALUES (SAME AS NUMBER OF SEGMENTS)  */
/* NOTE: A FREE SEGMENT = BIT MASK BIT = 1                            */
/*       A USED SEGMENT = BIT MASK BIT = 0                            */
/*--------------------------------------------------------------------*/
$GET_BAM_COUNT:
  PARSE ARG AD1, AD2
  AD2 = (2 * AD2)
  DO I = 1 TO AD2
    BYTE = SUBSTR(AD1,I,1)
    IF (BITAND(BYTE,'80'X) = '80'X) THEN
        FREE_SEGS = 1 + FREE_SEGS
    ELSE
        USED_SEGS = 1 + USED_SEGS
    IF (BITAND(BYTE,'40'X) = '40'X) THEN
        FREE_SEGS = 1 + FREE_SEGS
    ELSE
        USED_SEGS = 1 + USED_SEGS
    IF (BITAND(BYTE,'20'X) = '20'X) THEN
        FREE_SEGS = 1 + FREE_SEGS
    ELSE
        USED_SEGS = 1 + USED_SEGS
    IF (BITAND(BYTE,'10'X) = '10'X) THEN
        FREE_SEGS = 1 + FREE_SEGS
    ELSE
        USED_SEGS = 1 + USED_SEGS
    IF (BITAND(BYTE,'08'X) = '08'X) THEN
        FREE_SEGS = 1 + FREE_SEGS
    ELSE
        USED_SEGS = 1 + USED_SEGS
    IF (BITAND(BYTE,'04'X) = '04'X) THEN
        FREE_SEGS = 1 + FREE_SEGS
    ELSE
        USED_SEGS = 1 + USED_SEGS
    IF (BITAND(BYTE,'02'X) = '02'X) THEN
        FREE_SEGS = 1 + FREE_SEGS
    ELSE
        USED_SEGS = 1 + USED_SEGS
    IF (BITAND(BYTE,'01'X) = '01'X) THEN
        FREE_SEGS = 1 + FREE_SEGS
    ELSE
        USED_SEGS = 1 + USED_SEGS
  END
  SEG_COUNT = USED_SEGS + FREE_SEGS
RETURN SEG_COUNT
/*--------------------------------------------------------------------*/
/*  SSVRM                                                             */
/*--------------------------------------------------------------------*/
SSVRM:
  CVT      = C2D(STORAGE(10,4))               /* POINT TO CVT         */
  SMCA     = STORAGE(D2X(CVT + 196),4)        /* POINT TO  SMCA       */
  SMCA     = BITAND(SMCA,'7FFFFFFF'X)         /* ZERO HIGH ORDER BIT  */
  SMCA     = C2D(SMCA)                        /* CONVERT TO DECIMAL   */
  SMFNAME  = STORAGE(D2X(SMCA + 16),4)        /* POINT TO SMF NAME    */
  SMFNAME  = STRIP(SMFNAME,T)                 /* DEL TRAILING BLANKS  */
  ECVT     = C2D(STORAGE(D2X(CVT + 140),4))   /* POINT TO CVTECVT     */
  CVTRAC   = C2D(STORAGE(D2X(CVT + 992),4))   /* POINT TO RACF CVT    */
  RACFMID  = "HRF"STORAGE(D2X(CVT - 29),4)    /* RACF FMID        @AI */
  RCVTALIS = STORAGE(D2X(CVTRAC+330),1)       /* GET RCVTALIS BYTE    */
  PRODNAM  = STORAGE(D2X(ECVT+496),16)        /* POINT TO PRODUCT NAME*/
  SSNAME   = STRIP(PRODNAM,T)                 /* DEL TRAILING BLANKS  */
  VER      = STORAGE(D2X(ECVT+512),2)         /* POINT TO VERSION     */
  REL      = STORAGE(D2X(ECVT+514),2)         /* POINT TO RELEASE     */
  MOD      = STORAGE(D2X(ECVT+516),2)         /* POINT TO MOD LEVEL   */
  VRM      = VER'.'REL'.'MOD                  /* VRM OF OS            */
  QUEUE "RACF database statistics as of "DATE() TIME()        /* @AD */
  QUEUE "SMF name =",
        SMFNAME"  "SSNAME VRM"  RACF FMID = "RACFMID
  QUEUE "The application identity mapping stage is set at",   /* @AD */
        STRIP(C2D(RCVTALIS))                                  /* @AD */
RETURN
