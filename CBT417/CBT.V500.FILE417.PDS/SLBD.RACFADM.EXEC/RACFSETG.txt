/*%NOCOMMENT====================* REXX *==============================*/
/*  PURPOSE:  RACFADM - User Settings - Menu option 0                 */
/*--------------------------------------------------------------------*/
/* FLG  YYMMDD  USERID   DESCRIPTION                                  */
/* ---  ------  -------  -------------------------------------------- */
/* @AA  200519  RACFA    Chk F3 (END) and leave settings              */
/* @A9  200519  RACFA    Added displaying Showmvs dataset             */
/* @A8  200511  RACFA    Added displaying IBM RACF datasets           */
/* @A7  200423  RACFA    Move PARSE REXXPGM name up above IF SETMTRAC */
/* @A6  200423  RACFA    Ensure REXX program name is 8 chars long     */
/* @A5  200413  RACFA    Chg TRACEing to only display banner (P=Pgms) */
/* @A4  200412  RACFA    Chg TRACE to allow 'L'abels or 'R'esults     */
/* @A3  200224  RACFA    Place panels at top of REXX in variables     */
/* @A2  200221  RACFA    Make 'ADDRESS ISPEXEC' defualt, reduce code  */
/* @A1  200220  RACFA    Added SETMTRAC=YES, then TRACE R             */
/* @A0  200123  RACFA    Created REXX                                 */
/*====================================================================*/
PANEL16     = "RACFSETG"   /* Settings, menu option 0      */ /* @A3 */
PANEL17     = "RACFSETH"   /* Showmvs  dataset             */ /* @A9 */
PANEL18     = "RACFSETI"   /* IBM RACF datasets            */ /* @A8 */
parse source . . REXXPGM .         /* Obtain REXX pgm name */ /* @A7 */
REXXPGM     = LEFT(REXXPGM,8)                                 /* @A7 */

ADDRESS ISPEXEC                                               /* @A2 */
  "VGET (SETMTRAC) PROFILE"                                   /* @A1 */
  If (SETMTRAC <> 'NO') then do                               /* @A4 */
     Say "*"COPIES("-",70)"*"                                 /* @A4 */
     Say "*"Center("Begin Program = "REXXPGM,70)"*"           /* @A4 */
     Say "*"COPIES("-",70)"*"                                 /* @A4 */
     if (SETMTRAC <> 'PROGRAMS') THEN                         /* @A5 */
        interpret "Trace "SUBSTR(SETMTRAC,1,1)                /* @A4 */
  end                                                         /* @A4 */

  DO FOREVER
     "Display Panel("PANEL16")"
     IF (RC = 8) THEN LEAVE                                   /* @AA */

     "VGET (SETGMVSD) PROFILE"       /* Showmvs pgm/dsn  */   /* @A9 */
     IF (SETGMVSD = "YES") THEN DO                            /* @A9 */
        "Display Panel("PANEL17")"                            /* @A9 */
        SETGMVSD  = "NO"                                      /* @A9 */
        "VPUT (SETGMVSD)"                                     /* @A9 */
     END                                                      /* @A9 */

     "VGET (SETMIBMD) PROFILE"      /* IBM RACF datasets */   /* @A8 */
     IF (SETMIBMD = "YES") THEN DO                            /* @A8 */
        "Display Panel("PANEL18")"                            /* @A8 */
        SETMIBMD  = "NO"                                      /* @A8 */
        "VPUT (SETMIBMD)"                                     /* @A8 */
     END                                                      /* @A8 */
  END /* Do Forever */

  If (SETMTRAC <> 'NO') then do                               /* @A4 */
     Say "*"COPIES("-",70)"*"                                 /* @A4 */
     Say "*"Center("End Program = "REXXPGM,70)"*"             /* @A4 */
     Say "*"COPIES("-",70)"*"                                 /* @A4 */
  end                                                         /* @A4 */
EXIT                                                          /* @A4 */
