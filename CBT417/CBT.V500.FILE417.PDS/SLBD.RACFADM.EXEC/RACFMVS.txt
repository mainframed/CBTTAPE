/*%NOCOMMENT====================* REXX *==============================*/
/*  PURPOSE:  RACFADM - RACF Data (Showmvs) - Menu opt 7 and O (SLIST)*/
/*--------------------------------------------------------------------*/
/* FLG  YYMMDD  USERID   DESCRIPTION                                  */
/* ---  ------  -------  -------------------------------------------- */
/* @A4  200702  RACFA    Allow for symbolic in dsname                 */
/* @A3  200611  RACFA    Add capability to display USS info   (Opt O) */
/* @A2  200525  RACFA    Allow defining pgm name in Settings  (Opt 0) */
/* @A1  200519  RACFA    Obtain DSN from $DEVSETG or Settings (Opt 0) */
/* @A0  200516  RACFA    Developed REXX                               */
/*====================================================================*/
X           = MSG("OFF")
EDITMACR    = "RACFEMAC"   /* Edit Macro, turn HILITE off  */
DDNAME      = 'RACFA'RANDOM(0,999) /* Unique ddname        */
parse source . . REXXPGM .         /* Obtain REXX pgm name */
REXXPGM     = LEFT(REXXPGM,8)

ADDRESS ISPEXEC
  PARSE ARG PARM                                              /* @A3 */
  "VGET (SETGDISP SETMSHOW SETMTRAC",                         /* @A2 */
        "SETPMVS SETDMVSL) PROFILE"                           /* @A2 */
  If (SETMTRAC <> 'NO') then do
     Say "*"COPIES("-",70)"*"
     Say "*"Center("Begin Program = "REXXPGM,70)"*"
     Say "*"COPIES("-",70)"*"
     if (SETMTRAC <> 'PROGRAMS') THEN
        interpret "Trace "SUBSTR(SETMTRAC,1,1)
  end
  IF (SETPMVS = "") THEN                                      /* @A2 */
     SETPMVS = "SHOWZOS"                                      /* @A2 */

  racflmsg = "Retrieving data - Please be patient"
  "control display lock"
  "display msg(RACF011)"

  IF (SETDMVSL <> "") THEN DO                                 /* @A1 */
     SETDMVSL = STRIP(SETDMVSL,,"'")                          /* @A4 */
     PARSE VAR SETDMVSL DSN1 "&" SYMBOL "." DSN2              /* @A4 */
     SYMBVAL  = MVSVAR("SYMDEF",SYMBOL)                       /* @A4 */
     SETDMVSL = DSN1""SYMBVAL""DSN2                           /* @A4 */
     IF (SYSDSN("'"SETDMVSL"'") <> "OK") THEN DO              /* @A4 */
        RACFSMSG = "Invalid - Loadlib DSN"                    /* @A4 */
        RACFLMSG = "The loadlib dataset does not exist,",     /* @A4 */
                   "DSN='SETDMVSL'.  Invoke Settings",        /* @A4 */
                   "(Option 0) and verify the SHOWMVS",       /* @A4 */
                   "dataset defined is valid."                /* @A4 */
        "SETMSG MSG(RACF011)"                                 /* @A1 */
        EXIT                                                  /* @A1 */
     END                                                      /* @A1 */
     "LIBDEF ISPLLIB DATASET ID('"SETDMVSL"') STACK"          /* @A1 */
  END                                                         /* @A1 */

  ADDRESS TSO "ALLOC DD(SHOWMVS) UNIT(VIO) NEW",
              "SPACE(10 10) CYLINDERS"
  ADDRESS LINKMVS SETPMVS                                     /* @A2 */
  LASTRC = RC
  IF (SETDMVSL <> "") THEN                                    /* @A1 */
     "LIBDEF ISPLLIB"                                         /* @A1 */
  if (LASTRC <> 0) THEN DO
     racfsmsg = 'Error - SHOWMVS'
     racflmsg = 'Unable to execute SHOWMVS (RC='RC'). ',
                'Verify SHOWMVS is in the linklist,'
                'ISPLLIB or STEPLIB.'
     'setmsg msg(RACF011)'
     return
  END
  ADDRESS TSO "EXECIO * DISKR SHOWMVS (STEM ZOSREC. FINIS"
  ADDRESS TSO "FREE  DD(SHOWMVS)"

  K = 0
  FOUND = "N"
  DO J = 1 TO ZOSREC.0
     PARSE VAR ZOSREC.J V1 2 V2 3 V3 V4 .
     IF (V2 = ">") THEN DO                                    /* @A3 */
        IF (PARM = "") & (V3 = "RACF") THEN                   /* @A3 */
           FOUND = "Y"                                        /* @A3 */
        IF (PARM = "UNIX") & (V3 = "UNIX") THEN               /* @A3 */
           FOUND = "Y"                                        /* @A3 */
        IF (PARM = "USS") & (V3 = "USS") THEN                 /* @A3 */
           FOUND = "Y"                                        /* @A3 */
     END                                                      /* @A3 */
     IF (FOUND = "Y") THEN DO
        IF (K > 0) & (V2 = ">") THEN
           LEAVE
        K = K + 1
        RACFREC.K = SUBSTR(ZOSREC.J,2)
     END
  END
  RACFREC.0 = K

  ADDRESS TSO "ALLOC F("DDNAME") NEW REUSE",
              "LRECL(133) BLKSIZE(0) RECFM(F B)",
              "UNIT(VIO) SPACE(1 5) CYLINDERS"
  ADDRESS TSO "EXECIO * DISKW "DDNAME" (STEM RACFREC. FINIS"
  DROP RACFREC.

  "LMINIT DATAID(CMDDATID) DDNAME("DDNAME")"
  SELECT
     WHEN (SETGDISP = "VIEW") THEN
          "VIEW DATAID("CMDDATID") MACRO("EDITMACR")"
     WHEN (SETGDISP = "EDIT") THEN
          "EDIT DATAID("CMDDATID") MACRO("EDITMACR")"
     OTHERWISE
          "BROWSE DATAID("CMDDATID")"
  END
  ADDRESS TSO "FREE FI("DDNAME")"

  If (SETMTRAC <> 'NO') then do
     Say "*"COPIES("-",70)"*"
     Say "*"Center("End Program = "REXXPGM,70)"*"
     Say "*"COPIES("-",70)"*"
  end
RETURN
