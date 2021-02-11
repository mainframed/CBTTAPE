/*%NOCOMMENT====================* REXX *==============================*/
/*  PURPOSE:  RACFADM - Password Reset - Menu opt 5, line command PW  */
/*--------------------------------------------------------------------*/
/* FLG  YYMMDD  USERID   DESCRIPTION                                  */
/* ---  ------  -------  -------------------------------------------- */
/* @AG  200908  TRIDJK   Minor update/fix to 'Passphrase'             */
/* @AF  200821  TRIDJK   Password phrase support                      */
/* @AE  200504  JRT      SET vars are stored in PROFILE, line was ASIS*/
/* @AD  200504  JRT      Use RACFPSWE panel if admin mode set         */
/* @AC  200429  RACFA    Re-arranged variables (General, Mgmt, TSO)   */
/* @AB  200426  RACFA    Chged var. ERAIPSWD to SETTPSWD (user pswd)  */
/* @AA  200425  RACFA    Chk Settings (Opt 0) 'Initial Password' field*/
/* @A9  200424  RACFA    Added lower case to random password          */
/* @A8  200423  RACFA    Move PARSE REXXPGM name up above IF SETMTRAC */
/* @A7  200422  RACFA    Ensure the REXX program name is 8 chars      */
/* @A6  200422  TRIDJK   Use variable REXXPGM in log msg              */
/* @A5  200413  RACFA    Chg TRACEing to only display banner (P=Pgms) */
/* @A4  200412  RACFA    Chg TRACE to allow 'L'abels or 'R'esults     */
/* @A3  200407  RACFA    Ensure REMPOP is accomplished when F3 (END)  */
/* @A2  200407  RACFA    Made panel a variable                        */
/* @A1  200407  RACFA    Removed unnecessary ISPF variables           */
/* @A0  200407  TRIDJK   Created                                      */
/*====================================================================*/
PANELPW     = "RACFPSWD"   /* Password reset               */
PANELPE     = "RACFPSWE"   /* Password reset and revoke    */ /* @AD */
PANELM2     = "RACFMSG2"   /* Display RACF command and RC  */
parse source . . REXXPGM .         /* Obtain REXX pgm name */ /* @A8 */
REXXPGM     = LEFT(REXXPGM,8)                                 /* @A8 */

parse arg userid
Address ISPExec
  "VGET (SETMADMN SETMSHOW SETMTRAC SETTPSWD) PROFILE"        /* @AE */
  "VGET (SETMPHRA) PROFILE"                                   /* @AF */
  If (SETMTRAC <> 'NO') then do                               /* @A4 */
     Say "*"COPIES("-",70)"*"                                 /* @A4 */
     Say "*"Center("Begin Program = "REXXPGM,70)"*"           /* @A4 */
     Say "*"COPIES("-",70)"*"                                 /* @A4 */
     if (SETMTRAC <> 'PROGRAMS') THEN                         /* @A5 */
        interpret "Trace "SUBSTR(SETMTRAC,1,1)                /* @A4 */
  end                                                         /* @A4 */
  If (SETMADMN = 'YES') then                                  /* @AD */
     panelpw = PANELPE                                        /* @AD */
  If (SETTPSWD = "") THEN                                     /* @AB */
     pswd = newpswd()                                         /* @AA */
  else                                                        /* @AA */
     pswd = SETTPSWD                                          /* @AB */
  'ADDPOP'
  'DISPLAY PANEL('panelpw')'                                  /* @A2 */
  disprc = RC                                                 /* @A3 */
  'REMPOP'
  if (disprc = 8) then do                                     /* @A3 */
     cmd_rc = 8                                               /* @A4 */
     call Goodbye                                             /* @A4 */
  end                                                         /* @A4 */
  added = ''
  if (resume = 'Y') then
     added = 'RESUME'
  if (expired = 'N') then                                     /* @AD */
     added = added||' NOEXPIRED'                              /* @AD */
  if SETMPHRA = 'YES' then                                    /* @AF */
    call EXCMD "ALTUSER "userid" PHRASE('"pswd"')" added      /* @AF */
  else                                                        /* @AF */
    call EXCMD 'ALTUSER 'userid' PASSWORD('pswd')' added      /* @AF */
  if (cmd_rc > 0) then do
     racfsmsg = 'ALTUSER failed'
     racflmsg = msg.1
     "SETMSG MSG(RACF011)"
  end
  else do
     If (SETMPHRA = 'YES') then                               /* @AG */
        pwtype = 'Phrase'                                     /* @AG */
     else                                                     /* @AG */
        pwtype = 'Password'                                   /* @AG */
     racfsmsg = 'Password reset'
     racflmsg = userid 'password reset to 'pswd
     "SETMSG MSG(RACF011)"
  end
  call Goodbye                                                /* @A4 */
EXIT cmd_rc                                                   /* @A3 */
/*--------------------------------------------------------------------*/
/*  If tracing is on, display flower box                         @A4  */
/*--------------------------------------------------------------------*/
GOODBYE:                                                      /* @A4 */
  If (SETMTRAC <> 'NO') then do                               /* @A4 */
     Say "*"COPIES("-",70)"*"                                 /* @A4 */
     Say "*"Center("End Program = "REXXPGM,70)"*"             /* @A4 */
     Say "*"COPIES("-",70)"*"                                 /* @A4 */
  end                                                         /* @A4 */
EXIT cmd_rc                                                   /* @A4 */
/*--------------------------------------------------------------------*/
/*  Generate password                                                 */
/*--------------------------------------------------------------------*/
NEWPSWD:
  /* No vowels, or "V" or "Z" */
  choices  = 'BCDFGHJKLMNPQRSTWXYbcdfghjklmnpqrstwxy'         /* @A9 */
  chars.   = ''
  password = ''
  /* Initialize stem variables */
  do n = 1 to length(choices)
     chars.n = substr(choices,n,1)
  end
  /* n character password */                                  /* @AF */
  psize = 6                                                   /* @AF */
  do forever
     pick = random(1,length(choices))
     /* No repeating characters */
     if (pos(chars.pick,password) > 0) then
        nop
     else
        password = password||chars.pick
     if (length(password) > (psize-1)) then                   /* @AF */
        leave
  end
  /* Plug in 1 numeric character */
  number   = random(1,9)
  place    = random(2,psize)                                  /* @AF */
  password = overlay(number,password,place,1)
RETURN password
/*--------------------------------------------------------------------*/
/*  Exec command                                                      */
/*--------------------------------------------------------------------*/
EXCMD:
  signal off error
  parse arg cmd
  x = OUTTRAP('msg.')
  address TSO cmd
  cmd_rc = rc
  x = OUTTRAP('OFF')
  if (SETMSHOW <> 'NO') then
     call SHOWCMD
  if (subword(msg.1,1,1)= 'ICH11009I') |,
     (subword(msg.1,1,1)= 'ICH10006I') |,
     (subword(msg.1,1,1)= 'ICH06011I') then raclist = 'YES'
RETURN
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
     zerrsm = "RACFADM "REXXPGM" RC="WORD(cmd_rc,1)           /* @A6 */
     zerrlm = cmd
     parse value "" with zerralrm zerrhm zerrtp zerrwn        /* @AF */
     'log msg(isrz003)'
  END
RETURN
