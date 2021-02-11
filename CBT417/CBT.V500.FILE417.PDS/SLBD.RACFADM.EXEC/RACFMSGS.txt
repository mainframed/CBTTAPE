/*%NOCOMMENT====================* REXX *==============================*/
/*  PURPOSE:  RACFADM - Display error message                         */
/*--------------------------------------------------------------------*/
/*  NOTES:    1) This REXX program is used by all REXX programs       */
/*--------------------------------------------------------------------*/
/* FLG  YYMMDD  USERID   DESCRIPTION                                  */
/* ---  ------  -------  -------------------------------------------- */
/* @AG  200913  LBD      Accept message from command (msg.1)          */
/* @AF  200423  RACFA    Move PARSE REXXPGM name up above IF SETMTRAC */
/* @AE  200423  RACFA    Ensure REXX program name is 8 chars long     */
/* @AD  200413  RACFA    Chg ERR07                                    */
/* @AC  200413  RACFA    Chg TRACEing to only display banner (P=Pgms) */
/* @AB  200412  RACFA    Chged ERR19 msg, inlude ALTLIB in msg        */
/* @AA  200412  RACFA    Chg TRACE to allow 'L'abels or 'R'esults     */
/* @A9  200410  RACFA    Added ERR21 msg, 'Invalid entry - NONE'      */
/* @A8  200402  RACFA    Added ERR20 msg, 'Invalid security access'   */
/* @A7  200402  RACFA    Added ERR19 msg, 'No LIBDEF ISPPLIB DSN'     */
/* @A6  200301  RACFA    Standardize/use this module for all msgs     */
/* @A5  200223  RACFA    Del 'address TSO "PROFILE MSGID"', not needed*/
/* @A4  200221  RACFA    Make 'ADDRESS ISPEXEC' defualt, reduce code  */
/* @A3  200220  RACFA    Added SETMTRAC=YES, then TRACE R             */
/* @A2  200218  RACFA    Condense VGETs into one line                 */
/* @A1  200119  RACFA    Standardized/reduced lines of code           */
/* @A0  011229  NICORIZ  Created REXX, V2.1, www.rizzuto.it           */
/*====================================================================*/
parse source . . REXXPGM .         /* Obtain REXX pgm name */ /* @AF */
REXXPGM     = LEFT(REXXPGM,8)                                 /* @AF */

ADDRESS ISPEXEC                                               /* @A4 */
  parse arg code message                                      /* @AG */
  "VGET (SETMTRAC) PROFILE"                                   /* @A2 */
  If (SETMTRAC <> 'NO') then do                               /* @AA */
     Say "*"COPIES("-",70)"*"                                 /* @AA */
     Say "*"Center("Begin Program = "REXXPGM,70)"*"           /* @AA */
     Say "*"COPIES("-",70)"*"                                 /* @AA */
     if (SETMTRAC <> 'PROGRAMS') THEN                         /* @AC */
        interpret "Trace "SUBSTR(SETMTRAC,1,1)                /* @AA */
  end                                                         /* @AA */

  racfsmsg = ''; racflsmsg = ''
  Select
     when (code = 'ERR01') then do
          racfsmsg = 'Add profile failed'
          racflmsg = 'Unable to add the profile'
     end
     when (code = 'ERR02') then do
          racfsmsg = 'Delete profile failed'
          racflmsg = 'Unable to delete the profile'
     end
     when (code = 'ERR03') then do
          racfsmsg = 'Permit profile failed'
          racflmsg = 'Unable to permit the profile'
     end
     when (code = 'ERR04') then do
          racfsmsg = 'Check permit results'
          racflmsg = 'Please verify the permit settings'
     end
     when (code = 'ERR05') then do
          racfsmsg = 'Permit add failed'
          racflmsg = 'Unable to add the permit'
     end
     when (code = 'ERR06') then do
          racfsmsg = 'Permit delete failed'
          racflmsg = 'Unable to delete the permit'
     end
     when (code = 'ERR07') then do
          racfsmsg = 'Alter profile failed'
          racflmsg = 'Unable to alter the profile'            /* @AD */
     end
     when (code = 'ERR08') then do
          racfsmsg = 'Filter is invalid'
          racflmsg = 'The filter criteria is invalid'
     end
     when (code = 'ERR09') then do
          racfsmsg = 'Error in search'
          racflmsg = 'Encountered an error in seaching'
     end
     when (code = 'ERR10') then do
          racfsmsg = 'Command failed'
          racflmsg = 'Unable to execute the command'
     end
     when (code = 'ERR11') then do
          racfsmsg = 'Define alias error'
          racflmsg = 'Unable to deine the alias'
     end
     when (code = 'ERR12') then do
          racfsmsg = 'User revoked'
          racflmsg = 'Userid is revoked'
     end
     when (code = 'ERR13') then do
          RACFSMSG = 'Add member failed'
          racflmsg = 'Unable to add member'
     end
     when (code = 'ERR14') then do
          RACFSMSG = 'Remove member failed'
          racflmsg = 'Unable to remove member'
     end
     when (code = 'ERR15') then do
          RACFSMSG = 'LG/LU failed'
          racflmsg = 'LG/LU failed, please investigate'
     end
     WHEN (code = 'ERR16') then do
          racfsmsg = 'No entries'
          racflmsg = 'No entries meet search criteria'
     end
     WHEN (code = 'ERR17') then do
          racfsmsg = 'Invalid - Wild card'
          racflmsg = 'The astrisk (*) is a wild card,',
                     'signifies default access'
     end
     WHEN (code = 'ERR18') then do
          racfsmsg = 'Invalid - User Catalog'
          racflmsg = 'The TSO User Catalog defined in',
                     'Settings is invalid or null'
     end
     WHEN (code = 'ERR19') then do                            /* @A7 */
          racfsmsg = 'Error ALTLIB/LIBDEF DSN'                /* @AB */
          racflmsg = 'Unable to determine the ALTLIBed',      /* @AB */
                     'or LIBDEFed datasets used to',          /* @AB */
                     'invoke RACFADM.'                        /* @AB */
     end                                                      /* @A7 */
     WHEN (code = 'ERR20') then do                            /* @A8 */
          racfsmsg = 'Invalid security access'                /* @A8 */
          racflmsg = 'Userid does not have',                  /* @A8 */
                     'security access to execute',            /* @A8 */
                     'IRRXUTIL, please see Notes in',         /* @A8 */
                     'tutorial'                               /* @A8 */
     end                                                      /* @A8 */
     WHEN (code = 'ERR21') then do                            /* @A9 */
          racfsmsg = 'Invalid entry'                          /* @A9 */
          racflmsg = 'NO and NONE are not valid entries.'     /* @A9 */
     end                                                      /* @A9 */
     otherwise nop
  End
  if message /= '' then                                       /* @AG */
     if length(racflmsg) > 70                                 /* @AG */
        then racflmsg = racflmsg message                      /* @AG */
        else racflmsg = left(racflmsg,70) message             /* @AG */
  "SETMSG MSG(RACF011)"

  If (SETMTRAC <> 'NO') then do                               /* @AA */
     Say "*"COPIES("-",70)"*"                                 /* @AA */
     Say "*"Center("End Program = "REXXPGM,70)"*"             /* @AA */
     Say "*"COPIES("-",70)"*"                                 /* @AA */
  end                                                         /* @AA */
RETURN
