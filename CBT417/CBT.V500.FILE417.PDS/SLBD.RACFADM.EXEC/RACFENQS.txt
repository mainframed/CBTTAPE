/*%NOCOMMENT====================* REXX *==============================*/
/*  PURPOSE:  RACFADM - Enqueues - Menu option E                      */
/*--------------------------------------------------------------------*/
/* FLG  YYMMDD  USERID   DESCRIPTION                                  */
/* ---  ------  -------  -------------------------------------------- */
/* @AU  200621  RACFA    Shifted over report by 2 characters          */
/* @AT  200620  RACFA    Reduced lines displayed, less paging down/up */
/* @AS  200616  RACFA    Chg panel name RACFRPTS to RACFDISP          */
/* @AR  200611  RACFA    Moved database enqueues to top of list       */
/* @AQ  200611  RACFA    Added ISPSLIB enqueues                       */
/* @AP  200520  RACFA    If no ALT/LIBDEF dsns, display RACFDB enques */
/* @AO  200506  RACFA    Standardize all headers                      */
/* @AN  200506  RACFA    Display headers in a different color         */
/* @AM  200429  RACFA    Added a astericks to dsn/enqueues headers    */
/* @AL  200423  RACFA    Move PARSE REXXPGM name up above IF SETMTRAC */
/* @AK  200423  RACFA    Place DSN/Enques in flower/comment box       */
/* @AJ  200423  RACFA    Del 'call racfmsgs ERR19' when rows = 0      */
/* @AI  200422  RACFA    Ensure the REXX program name is 8 chars      */
/* @AH  200422  RACFA    Use variable REXXPGM in log msg              */
/* @AG  200422  RACFA    Remove spaces from RACF database names       */
/* @AF  200422  RACFA    Display enqueues on RACF backup database     */
/* @AE  200416  RACFA    Display enqueues on RACF database            */
/* @AD  200413  RACFA    Take into account, PROFILE MSGID(ON)         */
/* @AC  200413  RACFA    Del ver word 2 is CLIST, some may be EXEC    */
/* @AB  200413  RACFA    Added more comments above 'GET_CLIST_DSN'    */
/* @AA  200413  RACFA    If ALTLIB, not have 'Appl Lev', skip code    */
/* @A9  200413  RACFA    Get REXX pgm name and use as DD name         */
/* @A8  200413  RACFA    Chg TRACEing to only display banner (P=Pgms) */
/* @A7  200412  RACFA    Add enqueues for msgs and REXX dsns          */
/* @A6  200412  RACFA    Chg TRACE to allow 'L'abels or 'R'esults     */
/* @A5  200402  RACFA    Chg LRECL=132 to LRECL=80                    */
/* @A4  200402  RACFA    Issue message if no LIBDEF ISPPLIB dataset   */
/* @A3  200401  RACFA    Chged edit macro RACFLOGE to RACFEMAC        */
/* @A2  200401  RACFA    VIEW/EDIT use edit macro, to turn off HILITE */
/* @A1  200402  RACFA    Dropped array, save memory                   */
/* @A0  200401  RACFA    Created REXX                                 */
/*====================================================================*/
PANEL01     = "RACFDISP"   /* Display report with colors   */ /* @AS */
PANELM2     = "RACFMSG2"   /* Display RACF command and RC  */
EDITMACR    = "RACFEMAC"   /* Edit Macro, turn HILITE off  */ /* @A2 */
QNAME       = "SYSDSN"     /* MAJOR resource name for DSNs */
DDNAME      = 'RACFA'RANDOM(0,999) /* Unique ddname        */ /* @A9 */
RECENQ.     = ""                                              /* @AT */
CNT         = 0            /* Record counter               */ /* @AT */
parse source . . REXXPGM .         /* Obtain REXX pgm name */ /* @AL */
REXXPGM     = LEFT(REXXPGM,8)                                 /* @AL */

ADDRESS ISPEXEC
  "VGET (SETGDISP SETMSHOW SETMTRAC) PROFILE"
  If (SETMTRAC <> 'NO') then do                               /* @A6 */
     Say "*"COPIES("-",70)"*"                                 /* @A6 */
     Say "*"Center("Begin Program = "REXXPGM,70)"*"           /* @A6 */
     Say "*"COPIES("-",70)"*"                                 /* @A6 */
     if (SETMTRAC <> 'PROGRAMS') THEN                         /* @A8 */
        interpret "Trace "SUBSTR(SETMTRAC,1,1)                /* @A6 */
  end                                                         /* @A6 */

  call GET_RACF_DBNAMES                                       /* @AR */
  call Get_enqs "RACFPRM"                                     /* @AR */
  call Get_enqs "RACFBKP"                                     /* @AR */
  call Get_enqs "CLIST"                                       /* @A7 */
  call Get_enqs "ISPPLIB"                                     /* @A7 */
  call Get_enqs "ISPSLIB"                                     /* @AQ */
  call Get_enqs "ISPMLIB"                                     /* @A7 */

  QUEUE "*"COPIES("-",70)"*"                                  /* @AT */
  QUEUE "*"Center("RACFADM - Enqueues",70)"*"                 /* @AT */
  QUEUE "*"COPIES("-",70)"*"                                  /* @AT */
  QUEUE " "                                                   /* @AT */
  QUEUE "   Enqs   "CENTER("Dataset",44)                      /* @AU */
  QUEUE "   ----   "COPIES("-",44)                            /* @AU */
  DO J = 1 TO RECENQ.0                                        /* @AT */
     PARSE VAR RECENQ.J KEY DSN ENQ .                         /* @AT */
     IF (KEY = "D") THEN                                      /* @AT */
        QUEUE "   "RIGHT(ENQ,4)"   "LEFT(DSN,44)              /* @AU */
     IF (KEY = "E") THEN DO                                   /* @AT */
        PARSE VAR RECENQ.J KEY LPAR ENQ USERID NAME           /* @AT */
        SELECT                                                /* @AT */
           WHEN (ENQ = "SHARE") THEN ENQ = "SHR"              /* @AT */
           WHEN (ENQ = "EXCLU") THEN ENQ = "EXC"              /* @AT */
           OTHEWISE NOP                                       /* @AT */
        END                                                   /* @AT */
        QUEUE COPIES(" ",12)LEFT(LPAR,8)" ",                  /* @AU */
              ENQ"  "LEFT(USERID,8)" ",                       /* @AT */
              LEFT(NAME,21)                                   /* @AT */
     END                                                      /* @AT */
  END                                                         /* @AT */
  DROP RECENQ.                                                /* @AT */
  QUEUE                                                       /* @AT */

  ADDRESS TSO "ALLOC F("DDNAME") NEW REUSE",
              "LRECL(80) BLKSIZE(0) RECFM(F B)",              /* @A5 */
              "UNIT(VIO) SPACE(1 5) CYLINDERS"
  ADDRESS TSO "EXECIO * DISKW "DDNAME" (FINIS"
  "LMINIT DATAID(CMDDATID) DDNAME("DDNAME")"
  SELECT
     WHEN (SETGDISP = "VIEW") THEN
          "VIEW DATAID("CMDDATID") MACRO("EDITMACR")",        /* @AN */
               "PANEL("PANEL01")"                             /* @AN */
     WHEN (SETGDISP = "EDIT") THEN
          "EDIT DATAID("CMDDATID") MACRO("EDITMACR")",        /* @AN */
               "PANEL("PANEL01")"                             /* @AN */
     OTHERWISE
          "BROWSE DATAID("CMDDATID")"
  END
  ADDRESS TSO "FREE FI("DDNAME")"
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
/*--------------------------------------------------------------------*/
/*  Obtain enqueues on datasets                                  @A7  */
/*--------------------------------------------------------------------*/
GET_ENQS:                                                     /* @A7 */
  PARSE ARG DDQLIB                                            /* @A7 */
  SELECT                                                      /* @AE */
     WHEN (DDQLIB = "CLIST") THEN                             /* @AE */
          CALL GET_CLIST_DSN                                  /* @A7 */
     WHEN (DDQLIB = "RACFPRM") THEN DO                        /* @AF */
          DSNAME = PRMDBASE                                   /* @AF */
          RC = 0                                              /* @AF */
          if (dsname = "") THEN                               /* @AF */
             RC = 8                                           /* @AF */
     END                                                      /* @AF */
     WHEN (DDQLIB = "RACFBKP") THEN DO                        /* @AF */
          DSNAME = BKPDBASE                                   /* @AF */
          RC = 0                                              /* @AF */
          if (dsname = "") THEN                               /* @AF */
             RC = 8                                           /* @AF */
     END                                                      /* @AF */
     OTHERWISE                                                /* @AE */
          "QLIBDEF "DDQLIB" TYPE(DATASET) ID(DSNAME)"         /* @A7 */
  END                                                         /* @AE */
  if (RC > 0) then do                                         /* @A4 */
     call racfmsgs ERR19                                      /* @A4 */
     return                                                   /* @A7 */
  end                                                         /* @A6 */

  ROWS  = 0
  RNAME = STRIP(DSNAME,,"'")
  "QUERYENQ TABLE(ENQTBL) QNAME(QNAME) RNAME(RNAME) XSYS"
  QUERYRC = RC
  IF (QUERYRC <> 8) THEN DO                                   /* @AE */
     "TBTOP   "ENQTBL
     "TBQUERY "ENQTBL" ROWNUM(ROWS)"
  END                                                         /* @AE */

  IF (ROWS = 0) THEN DO                                       /* @A7 */
     IF (QUERYRC <> 8) THEN                                   /* @AE */
        "TBCLOSE "ENQTBL                                      /* @A7 */
     CNT = CNT + 1                                            /* @AT */
     RECENQ.CNT = "D "RNAME" 0"                               /* @AT */
     RECENQ.0 = CNT                                           /* @AT */
     RETURN                                                   /* @A7 */
  END                                                         /* @A7 */
  ELSE DO                                                     /* @A7 */
     CNT         = CNT + 1                                    /* @AT */
     RECENQ.CNT = "D "RNAME" "strip(rows,'L',0)               /* @AT */

     DO J = 1 TO ROWS
        "TBSKIP "ENQTBL
        "TBGET  "ENQTBL
        cmd = "LU "ZENJOB
        X = OUTTRAP("CMDREC.")
        ADDRESS TSO cmd
        cmd_rc = rc
        if (SETMSHOW <> 'NO') then
           call SHOWCMD
        if (cmd_rc > 0) then
           Luname = ""
        else
           parse var cmdrec.1 . "NAME="luname "OWNER=" .
        X = OUTTRAP("OFF")
        CNT = CNT + 1                                         /* @AT */
        RECENQ.CNT = "E "ZENSYST" "ZENDISP,                   /* @AT */
                     ZENJOB" "LUNAME                          /* @AT */
     END
  END
  RECENQ.0 = CNT                                              /* @AT */
  "TBCLOSE "ENQTBL
  DROP CMDREC.                                                /* @A1 */
RETURN                                                        /* @A7 */
/*--------------------------------------------------------------------*/
/*  Get CLIST dataset name                                       @A7  */
/*--------------------------------------------------------------------*/
/*  1) The 'ALTLIB DISPLAY' statement, will look for                  */
/*     'Application-level' in the display in order to obtain          */
/*     the DDname of the ALTLIBed dataset                             */
/*       Current search order (by DDNAME) is:                         */
/*       Application-level CLIST DDNAME=SYS00529                      */
/*       System-level EXEC       DDNAME=SYSEXEC                       */
/*       System-level CLIST      DDNAME=SYSPROC                       */
/*  2) The 'LISTA STATUS' will display all the DDnames and datasets   */
/*     allocated, allowing the capability to obtain the dataset name  */
/*     allocated to the 'Application-level CLIST' ddname (SYS#####)   */
/*--------------------------------------------------------------------*/
GET_CLIST_DSN:                                                /* @A7 */
ADDRESS TSO                                                   /* @A7 */
  X = OUTTRAP("RECALT.")                                      /* @A7 */
  "ALTLIB DISPLAY"                                            /* @A7 */
  X = OUTTRAP("OFF")                                          /* @A7 */
                                                              /* @A7 */
  IF (SUBSTR(RECALT.2,1,3) = "IKJ") THEN                      /* @AD */
     PARSE VAR RECALT.2 . W1 W2 "DDNAME="DDALTLIB             /* @AD */
  ELSE                                                        /* @AD */
     PARSE VAR RECALT.2 W1 W2 "DDNAME="DDALTLIB               /* @A7 */
  DROP RECALT.                                                /* @A7 */
  RC = 0                                                      /* @AA */
  IF (W1 <> "Application-level") THEN DO                      /* @AC */
     RC = 8                                                   /* @AA */
     return                                                   /* @A7 */
  END                                                         /* @AA */
                                                              /* @A7 */
  X = OUTTRAP("RECLA.")                                       /* @A7 */
  "LISTA STATUS"                                              /* @A7 */
  X = OUTTRAP("OFF")                                          /* @A7 */
  do J = 1 TO RECLA.0                                         /* @A7 */
     PARSE VAR RECLA.J W1 .                                   /* @A7 */
     IF (W1 = DDALTLIB) THEN DO                               /* @A7 */
        K = J - 1                                             /* @A7 */
        DSNAME = RECLA.K                                      /* @A7 */
        LEAVE                                                 /* @A7 */
     END                                                      /* @A7 */
  end                                                         /* @A7 */
  DROP RECLA. W1 DDALTLIB                                     /* @A7 */
ADDRESS ISPEXEC                                               /* @A7 */
RETURN                                                        /* @A7 */
/*--------------------------------------------------------------------*/
/*  Display RACF command and return code                              */
/*--------------------------------------------------------------------*/
SHOWCMD:
  IF (SETMSHOW = "BOTH") | (SETMSHOW = "DISPLAY") THEN DO
     PARSE VAR CMD MSG1 60 MSG2 121 MSG3
     MSG4 = "Return code = "cmd_rc
     "ADDPOP ROW(6) COLUMN(4)"
     "DISPLAY PANEL("PANELM2")"
     "REMPOP"
  END
  IF (SETMSHOW = "BOTH") | (SETMSHOW = "LOG") THEN DO
     zerrsm = "RACFADM "REXXPGM" RC="cmd_rc                   /* @AH */
     zerrlm = cmd
     'log msg(isrz003)'
  END
RETURN
/*--------------------------------------------------------------------*/
/*  Get RACF primary and backup database names                   @AF  */
/*--------------------------------------------------------------------*/
GET_RACF_DBNAMES:                                             /* @AE */
  CVT      = C2X(STORAGE(10,4))           /* Pointer to CVT          */
  RCVT     = D2X(X2D(CVT) +X2D(3E0))      /* Pointer to RCVT pointer */
  RCVT     = C2X(STORAGE(RCVT,4))         /* Pointer to RCVT         */
  DSDT     = D2X(X2D(RCVT) + X2D(E0))     /* Pointer to DSDT pointer */
  DSDT     = C2X(STORAGE(DSDT,4))         /* Pointer to DSDT         */
  DSDTNUM  = D2X(X2D(DSDT) + X2D(4))      /* Address of DSDTNUM      */
  DSDTNUM  = C2D(STORAGE(DSDTNUM,4))      /* DSDTNUM                 */
  DSDTPRIM = D2X(X2D(DSDT) + X2D(90))     /* Address of 1st Prim DSN */
  DSDTBACK = D2X(X2D(DSDT) + X2D(140))    /* Address of 1st Bkup DSN */
  PNAME    = D2X(X2D(DSDTPRIM) + X2D(21)) /* Addr of primary name    */
  PRMDBASE = STRIP(STORAGE(PNAME,44))     /* Primary name        @AG */
  BNAME    = D2X(X2D(DSDTBACK) + X2D(21)) /* Addr of backup name     */
  BKPDBASE = STRIP(STORAGE(BNAME,44))     /* Backup name         @AG */
RETURN                                                        /* @AE */
