/*%NOCOMMENT====================* REXX *==============================*/
/*  PURPOSE:  RACFADM - User Profile - Opt 1, create TSO alias/dsns   */
/*--------------------------------------------------------------------*/
/* FLG  YYMMDD  USERID   DESCRIPTION                                  */
/* ---  ------  -------  -------------------------------------------- */
/* @B4  200502  RACFA    Added return                                 */
/* @B3  200429  RACFA    Re-arranged variables (General, Mgmt, TSO)   */
/* @B2  200423  RACFA    Move PARSE REXXPGM name up above IF SETMTRAC */
/* @B1  200422  RACFA    Ensure the REXX program name is 8 chars      */
/* @AZ  200422  RACFA    Use variable REXXPGM in log msg              */
/* @AY  200422  TRIDJK   Fixed allocating JOBLIB                      */
/* @AX  200413  RACFA    Fixed returning the return codes             */
/* @AW  200413  RACFA    Get REXX pgm name and use as DD name         */
/* @AV  200413  RACFA    Chg TRACEing to only display banner (P=Pgms) */
/* @AU  200412  RACFA    Fixed returning RC                           */
/* @AT  200412  RACFA    Chg TRACE to allow 'L'abels or 'R'esults     */
/* @AS  200324  RACFA    Allow both display/logging of RACF commands  */
/* @AR  200324  RACFA    Allow logging RACF commands to ISPF Log file */
/* @AQ  200320  RACFA    Del all users dsns, prior was ISPPROF/JOBLIB */
/* @AP  200317  RACFA    Chg JOBLIB=Y, was JOBLIB=YES                 */
/* @AO  200317  RACFA    Add error msg when unable to define alias    */
/* @AN  200316  RACFA    Removed ERAMCAT, ERAUVOL, ERAUNIT, not used  */
/* @AM  200305  RACFA    Del comments and ERROR subroutine            */
/* @AL  200305  RACFA    Del OUTTRAP('TRASH.') and DISPLAY_MSG proc.  */
/* @AK  200305  TRIDJK   Add quotes to userid on DELETE/DEFINE ALIAS  */
/* @AJ  200305  TRIDJK   NOP the ERROR: CHGD: DISPLAY_MSG: sections   */
/* @AI  200305  TRIDJK   Comment out "x = OUTTRAP('trash.')"          */
/* @AH  200228  RACFA    Removed ARG() statements, use PARSE ARG      */
/* @AG  200228  RACFA    Allow turning disp. REXX cmds 'Settings (0)' */
/* @AF  200228  RACFA    Allow turning tracing on from 'Settings (0)' */
/* @AE  200227  RACFA    If EGN=YES, then 2 asterisks, else one       */
/* @AD  200227  RACFA    Set info messages off, del outtrap('trash.') */
/* @AC  200227  TRIDJK   Add single quotes around catalog name        */
/* @AB  200226  RACFA    Removed "PROFILE PREF("USERID()")"           */
/* @AB  200226  RACFA    Removed 'ADDRESS TSO PROF NOPREFIX'          */
/* @AA  200225  LBD      Fixed PREFIX, wrong environment              */
/* @A9  200224  RACFA    Place panels at top of REXX in variables     */
/* @A8  200223  RACFA    Del 'address TSO "PROFILE MSGID"', not needed*/
/* @A7  200221  RACFA    Make 'ADDRESS ISPEXEC' defualt, reduce code  */
/* @A6  200220  RACFA    Added SETMTRAC=YES, then TRACE R             */
/* @A5  200220  RACFA    Renamed RACFTSO to RACFUSRT (Standardization)*/
/* @A4  200218  RACFA    Condense VGETs into one line                 */
/* @A3  200119  RACFA    Standardized/reduced lines of code           */
/* @A2  200119  RACFA    Added comment box above procedures           */
/* @A1  200118  RACFA    Fixed NOPREF issue with users TSO PROFILE    */
/* @A0  011229  NICORIZ  Created REXX, V2.1, www.rizzuto.it           */
/*====================================================================*/
X           = MSG("OFF")   /* No informational messages    */ /* @AD */
PANEL29     = "RACFUSRT"   /* Add, chg and del TSO userid  */ /* @A9 */
PANELM2     = "RACFMSG2"   /* Display RACF command and RC  */ /* @AW */
DDNAME      = 'RACFA'RANDOM(0,999) /* Unique ddname        */ /* @AW */
parse source . . REXXPGM .         /* Obtain REXX pgm name */ /* @B2 */
REXXPGM     = LEFT(REXXPGM,8)                                 /* @B2 */

ADDRESS ISPEXEC                                               /* @AF */
  "VGET (SETMSHOW SETMTRAC SETTCTLG",                         /* @B3 */
        "SETTPROF SETTUDSN) PROFILE"                          /* @B3 */
  If (SETMTRAC <> 'NO') then do                               /* @AT */
     Say "*"COPIES("-",70)"*"                                 /* @AT */
     Say "*"Center("Begin Program = "REXXPGM,70)"*"           /* @AT */
     Say "*"COPIES("-",70)"*"                                 /* @AT */
     if (SETMTRAC <> 'PROGRAMS') THEN                         /* @AV */
        interpret "Trace "SUBSTR(SETMTRAC,1,1)                /* @AT */
  end                                                         /* @AT */

  rc      = GETEGN(ERAEGN,53,'01','NO','YES')  /* egn=Y/N */  /* @AE */
  ASTERIC = "*"                                               /* @AE */
  IF (ERAEGN = "YES") THEN                                    /* @AE */
     ASTERIC = "**"                                           /* @AE */

  parse arg era_cmd user tsoproc tsoacct defgrp owner joblib  /* @AH */
  interpret 'signal ' era_cmd
/*--------------------------------------------------------------------*/
/*  Change userid                                                     */
/*--------------------------------------------------------------------*/
CHGD:
  cmd_rc = 0
  call goodbye                                                /* @AT */
RETURN cmd_rc                                                 /* @AW */
/*--------------------------------------------------------------------*/
/*  Add userid                                                        */
/*--------------------------------------------------------------------*/
ADDD:                                                         /* @AJ */
  cmd = "ADDSD  ('"user"."ASTERIC"') UACC(READ)",             /* @AG */
        "OWNER("owner")"                                      /* @AG */
  call exccmd                                                 /* @AG */
  IF (cmd_rc > 0) then                                        /* @AM */
     call Goodbye                                             /* @AT */

  /*- Authorize Library allocation                -*/
  cmd = "PERMIT '"user"."ASTERIC"' GEN ACC(ALTER)",           /* @AG */
                 "ID("USERID()")"                             /* @AG */
  call exccmd                                                 /* @AG */
  IF (cmd_rc > 0) then                                        /* @AM */
     call Goodbye                                             /* @AT */

  cmd = "SETROPTS REFRESH GENERIC(DATASET)"                   /* @AG */
  call exccmd                                                 /* @AG */
  IF (cmd_rc > 0) then                                        /* @AM */
     call Goodbye                                             /* @AT */

  /*- Delete user alias for datasets -*/
  cmd = "DEL '"user"' ALIAS PURGE"                            /* @AG */
  call exccmd                                                 /* @AG */

  SETTCTLG = Strip(SETTCTLG,,"'")                             /* @AC */
  cmd = "DEF ALIAS (NAME('"user"') RELATE('"SETTCTLG"'))"     /* @AK */
  call exccmd                                                 /* @AG */
  IF (cmd_rc > 0) then do                                     /* @AO */
     call racfmsgs ERR018  /* Invalid user catalog */         /* @AO */
     call Goodbye                                             /* @AT */
  end                                                         /* @AO */

  /*- Allocate ISPF profile          -*/
  cmd = "ALLOC FILE("DDNAME") DATASET('"user"."SETTPROF"')",  /* @AW */
              "NEW SPACE(5,5) CYLINDERS",                     /* @AG */
              "BLKSIZE(0) LRECL(80) RECFM(F B)",              /* @AG */
              "CATALOG DIR(250)"                              /* @AG */
  call exccmd                                                 /* @AG */
  cmd = "FREE FILE("DDNAME")"                                 /* @AW */
  call exccmd                                                 /* @AG */

  /*- Allocate joblib library        -*/
  if (SETTUDSN <> '') then do                                 /* @AY */
     cmd = "ALLOC FILE("DDNAME")",                            /* @AW */
                  "DATASET('"user"."SETTUDSN"')",             /* @AG */
                  "NEW SPACE(5,5) CYLINDERS",                 /* @AG */
                  "BLKSIZE(0) LRECL(80) RECFM(F B)",          /* @AG */
                  "CATALOG DIR(250)"                          /* @AG */
     call exccmd                                              /* @AG */
     cmd = "FREE FILE("DDNAME")"                              /* @AW */
     call exccmd                                              /* @AG */
  end

  /*- Authorize logon and account to default group  -*/
  cmd = "PE "tsoacct" CLASS(ACCTNUM) ACC(READ) ID("defgrp")"  /* @AG */
  call exccmd                                                 /* @AG */
  IF (cmd_rc > 0) then                                        /* @AM */
     call Goodbye                                             /* @AT */
  cmd = "PE "tsoproc" CLASS(TSOPROC) ACC(READ) ID("defgrp")"  /* @AG */
  call exccmd                                                 /* @AG */
  IF (cmd_rc > 0) then                                        /* @AM */
     call Goodbye                                             /* @AT */

  cmd = "SETROPTS RACLIST(ACCTNUM) REFRESH"                   /* @AG */
  call exccmd                                                 /* @AG */
  IF (cmd_rc > 0) then                                        /* @AM */
     call Goodbye                                             /* @AT */
  cmd = "SETROPTS RACLIST(TSOPROC) REFRESH"                   /* @AG */
  call exccmd                                                 /* @AG */
  IF (cmd_rc > 0) then                                        /* @AM */
     call Goodbye                                             /* @AT */

  call Delete_Admin_permits
RETURN cmd_rc                                                 /* @AW */
/*--------------------------------------------------------------------*/
/*  Delete userid                                                     */
/*--------------------------------------------------------------------*/
DELD:
  cmd = "DELDSD  ('"user"."ASTERIC"')"                        /* @AG */
  call exccmd                                                 /* @AG */
  IF (cmd_rc > 0) then                                        /* @AM */
     call Goodbye                                             /* @AT */

  X = OUTTRAP("REC.")                                         /* @AQ */
  ADDRESS TSO "LISTCAT LEV('"user"')"                         /* @AQ */
  X = OUTTRAP("OFF")                                          /* @AQ */
  DO J = 1 TO REC.0                                           /* @AQ */
     PARSE VAR REC.J W1 W2 W3 .                               /* @AQ */
     IF (W2 = "-------") THEN DO                              /* @AQ */
        CMD = "DELETE '"W3"'"                                 /* @AQ */
        call exccmd                                           /* @AQ */
     END                                                      /* @AQ */
  END                                                         /* @AQ */
  DROP REC.

  cmd = "DELETE ('"user"') ALIAS"                             /* @AK */
  call exccmd                                                 /* @AG */
  call Goodbye                                                /* @AT */
RETURN cmd_rc                                                 /* @B4 */
/*--------------------------------------------------------------------*/
/*  Delete temporary authorizations for RACF administrator            */
/*--------------------------------------------------------------------*/
DELETE_ADMIN_PERMITS:
  cmd = "PERMIT '"user"."ASTERIC"' GEN DELETE",               /* @AG */
                 "ID("USERID()")"                             /* @AG */
  call exccmd                                                 /* @AG */
  IF (cmd_rc > 0) then                                        /* @AM */
     call Goodbye                                             /* @AT */

  cmd = "SETROPTS REFRESH GENERIC(DATASET)"                   /* @AG */
  call exccmd                                                 /* @AG */
  call Goodbye                                                /* @AT */
RETURN cmd_rc                                                 /* @AW */
/*--------------------------------------------------------------------*/
/*  Enhanced Generic Name (EGN) = Yes or No                           */
/*--------------------------------------------------------------------*/
GETEGN:
  variable = arg(1)
  offset   = arg(2)
  value    = arg(3)
  status1  = arg(4)
  status2  = arg(5)
  cvt      = c2x(storage(10,4))      /* cvt address        */
  cvtrac$  = d2x((x2d(cvt))+992)     /* cvt+3E0 = cvtrac $ */
  cvtrac   = c2x(storage(cvtrac$,4)) /* cvtrac=access cntl */
  rcvtsta$ = d2x((x2d(cvtrac))+53)
  interpret "rcvtsta$= d2x((x2d("cvtrac"))+"offset")"
  x        = storage(rcvtsta$,1)
  interpret variable '= 'status1
  interpret "x=bitand(x,'"value"'x)" /* del unwanted bits*/
  interpret "if (x= '"value"'x) then "variable"="status2
RETURN 0000
/*--------------------------------------------------------------------*/
/*  Execute RACF command                                         @BB  */
/*--------------------------------------------------------------------*/
EXCCMD:                                                       /* @AG */
ADDRESS TSO                                                   /* @AG */
  cmd                                                         /* @AG */
  cmd_rc = rc                                                 /* @AG */
  if (SETMSHOW <> 'NO') then                                  /* @AG */
     call SHOWCMD                                             /* @AG */
RETURN                                                        /* @AG */
/*--------------------------------------------------------------------*/
/*  Display RACF command and return code                         @BB  */
/*--------------------------------------------------------------------*/
SHOWCMD:                                                      /* @BB */
ADDRESS ISPEXEC                                               /* @AG */
  IF (SETMSHOW = "BOTH") | (SETMSHOW = "DISPLAY") THEN DO     /* @AS */
     PARSE VAR CMD MSG1 60 MSG2 121 MSG3                      /* @BB */
     MSG4 = "Return code = "cmd_rc                            /* @BS */
     "ADDPOP ROW(6) COLUMN(4)"                                /* @BB */
     "DISPLAY PANEL("PANELM2")"                               /* @BL */
     "REMPOP"                                                 /* @BB */
  END                                                         /* @AR */
  IF (SETMSHOW = "BOTH") | (SETMSHOW = "LOG") THEN DO         /* @AS */
     zerrsm = "RACFADM "REXXPGM" RC="cmd_rc                   /* @AZ */
     zerrlm = cmd                                             /* @AR */
     'log msg(isrz003)'                                       /* @AR */
  END                                                         /* @AR */
RETURN                                                        /* @BB */
/*--------------------------------------------------------------------*/
/*  If tracing is on, display flower box                         @AT  */
/*--------------------------------------------------------------------*/
GOODBYE:                                                      /* @AT */
  If (SETMTRAC <> 'NO') then do                               /* @AT */
     Say "*"COPIES("-",70)"*"                                 /* @AT */
     Say "*"Center("End Program = "REXXPGM,70)"*"             /* @AT */
     Say "*"COPIES("-",70)"*"                                 /* @AT */
  end                                                         /* @AT */
RETURN CMD_RC                                                 /* @AU */
