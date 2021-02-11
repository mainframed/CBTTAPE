/*%NOCOMMENT====================* REXX *==============================*/
/*  PURPOSE:  RACFADM - Display 'Confirm Request' pop-up panel        */
/*--------------------------------------------------------------------*/
/*  NOTES:    1) This REXX program is used by all REXX programs       */
/*--------------------------------------------------------------------*/
/* FLG  YYMMDD  USERID   DESCRIPTION                                  */
/* ---  ------  -------  -------------------------------------------- */
/* @AB  200423  RACFA    Move PARSE REXXPGM name up above IF SETMTRAC */
/* @AA  200423  RACFA    Ensure REXX program name is 8 chars long     */
/* @A9  200413  RACFA    Chg TRACEing to only display banner (P=Pgms) */
/* @A8  200412  RACFA    Chg TRACE to allow 'L'abels or 'R'esults     */
/* @A7  200228  RACFA    Removed SETMSHOW from VGET, not used         */
/* @A6  200224  RACFA    Standardize quotes, chg single to double     */
/* @A5  200224  RACFA    Place panels at top of REXX in variables     */
/* @A4  200223  RACFA    Del 'address TSO "PROFILE MSGID"', not needed*/
/* @A3  200220  RACFA    Added SETMTRAC=YES, then TRACE R             */
/* @A2  200218  RACFA    Condense VGETs into one line                 */
/* @A1  200119  RACFA    Standardized/reduced lines of code           */
/* @A0  011229  NICORIZ  Created REXX, V2.1, www.rizzuto.it           */
/*====================================================================*/
PANELM1     = "RACFMSG1"   /* Confirm Request (pop-up)     */ /* @A5 */
parse source . . REXXPGM .         /* Obtain REXX pgm name */ /* @AB */
REXXPGM     = LEFT(REXXPGM,8)                                 /* @AB */

ADDRESS ISPEXEC                                               /* @A3 */
  Arg message
  Signal off error
  "VGET (SETMTRAC) PROFILE"                                   /* @A7 */
  If (SETMTRAC <> 'NO') then do                               /* @A8 */
     Say "*"COPIES("-",70)"*"                                 /* @A8 */
     Say "*"Center("Begin Program = "REXXPGM,70)"*"           /* @A8 */
     Say "*"COPIES("-",70)"*"                                 /* @A8 */
     if (SETMTRAC <> 'PROGRAMS') THEN                         /* @A9 */
        interpret "Trace "SUBSTR(SETMTRAC,1,1)                /* @A8 */
  end                                                         /* @A8 */

  answer  = 'NO'
  zwinttl = 'CONFIRM REQUEST'
  Do until (ckey = 'PF03') | (ckey = 'ENTER')
     'CONTROL NOCMD'
     "ADDPOP"                                                 /* @A6 */
     "DISPLAY PANEL("PANELM1")"                               /* @A5 */
     "REMPOP"                                                 /* @A6 */
  End
  Select
     when (ckey = 'PF03')  then answer = 'NO'
     when (ckey = 'ENTER') then answer = 'YES'
     otherwise nop
  End
  zwinttl = ' '

  If (SETMTRAC <> 'NO') then do                               /* @A8 */
     Say "*"COPIES("-",70)"*"                                 /* @A8 */
     Say "*"Center("End Program = "REXXPGM,70)"*"             /* @A8 */
     Say "*"COPIES("-",70)"*"                                 /* @A8 */
  end                                                         /* @A8 */
RETURN answer
