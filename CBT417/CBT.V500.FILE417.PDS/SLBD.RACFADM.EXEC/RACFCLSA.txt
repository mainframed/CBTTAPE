/*%NOCOMMENT====================* REXX *==============================*/
/*  PURPOSE:  RACFADM - Authorization - Menu option 99 (Hidden)       */
/*--------------------------------------------------------------------*/
/* FLG  YYMMDD  USERID   DESCRIPTION                                  */
/* ---  ------  -------  -------------------------------------------- */
/* @AP  200430  RACFA    Chg tbla to TABLEA, moved def. var. up top   */
/* @AO  200423  RACFA    Move PARSE REXXPGM name up above IF SETMTRAC */
/* @AN  200422  RACFA    Ensure the REXX program name is 8 chars      */
/* @AM  200422  RACFA    Use variable REXXPGM in log msg              */
/* @AL  200417  RACFA    Chged panel names RACFAUT1/2 to RACFCLSE/F   */
/* @AK  200417  RACFA    Renamed this REXX pgm, was RACFAUTH          */
/* @AJ  200413  RACFA    Chg TRACEing to only display banner (P=Pgms) */
/* @AI  200412  RACFA    Chg TRACE to allow 'L'abels or 'R'esults     */
/* @AH  200324  RACFA    Allow both display/logging of RACF commands  */
/* @AG  200324  RACFA    Allow logging RACF commands to ISPF Log file */
/* @AF  200303  RACFA    Del 'EXCMD' procedure, not referenced        */
/* @AE  200301  RACFA    Deleted EMSG procedure, not referenced       */
/* @AD  200226  RACFA    Fix @AB chg, chg ret_code to cmd_rc          */
/* @AC  200226  RACFA    Added 'CONTROL ERRORS RETURN'                */
/* @AB  200226  RACFA    Added 'Return Code =' when displaying cmd    */
/* @AA  200226  RACFA    Removed double quotes before/after cmd       */
/* @A9  200224  RACFA    Standardize quotes, chg single to double     */
/* @A8  200124  RACFA    Place panels at top of REXX in variables     */
/* @A7  200223  RACFA    Del 'address TSO "PROFILE MSGID"', not needed*/
/* @A6  200221  RACFA    Make 'ADDRESS ISPEXEC' defualt, reduce code  */
/* @A5  200220  RACFA    Fixed displaying all RACF commands           */
/* @A4  200220  RACFA    Added SETMTRAC=YES, then TRACE R             */
/* @A3  200218  RACFA    Condense VGETs into one line                 */
/* @A2  200120  RACFA    Removed 'say msg.msg_var' in EXCMD procedure */
/* @A1  200119  RACFA    Standardized/reduced lines of code           */
/* @A0  011229  NICORIZ  Created REXX, V2.1, www.rizzuto.it           */
/*====================================================================*/
PANEL14     = "RACFCLSE"   /* Enter profile/class/user     */ /* @AL */
PANEL15     = "RACFCLSF"   /* List group/ids and access    */ /* @AL */
PANELM2     = "RACFMSG2"   /* Display RACF command and RC  */ /* @A8 */
TABLEA      = 'TA'RANDOM(0,99999)  /* Unique table name A  */ /* @AP */
parse source . . REXXPGM .         /* Obtain REXX pgm name */ /* @AO */
REXXPGM     = LEFT(REXXPGM,8)                                 /* @AO */

ADDRESS ISPEXEC                                               /* @A6 */
  Arg rclass profile user
  "CONTROL ERRORS RETURN"                                     /* @AC */
  "VGET (SETMSHOW SETMTRAC) PROFILE"                          /* @A3 */

  If (SETMTRAC <> 'NO') then do                               /* @AI */
     Say "*"COPIES("-",70)"*"                                 /* @AI */
     Say "*"Center("Begin Program = "REXXPGM,70)"*"           /* @AI */
     Say "*"COPIES("-",70)"*"                                 /* @AI */
     if (SETMTRAC <> 'PROGRAMS') THEN                         /* @AJ */
        interpret "Trace "SUBSTR(SETMTRAC,1,1)                /* @AI */
  end

  rlv    = SYSVAR('SYSLRACF')
  called = SYSVAR('SYSNEST')
  If (called = 'YES') then "CONTROL NONDISPL ENTER"

  "DISPLAY PANEL("PANEL14")" /* get prof */                   /* @A8 */
  ret_code = rc
  Do while (ret_code = 0) /* While not end on panel   */
     ret_code = 8
     call get_prof_acl    /* get profile access list  */
     call get_user_group  /* get connected groups     */
     call Analyse         /* analyze and show diff.   */
     if (called <> 'YES') then do
        "DISPLAY PANEL("PANEL14")"                            /* @A8 */
        ret_code = rc
     end
  end

  If (SETMTRAC <> 'NO') then do                               /* @AI */
     Say "*"COPIES("-",70)"*"                                 /* @AI */
     Say "*"Center("End Program = "REXXPGM,70)"*"             /* @AI */
     Say "*"COPIES("-",70)"*"                                 /* @AI */
  end                                                         /* @AI */
RETURN 0
/*--------------------------------------------------------------------*/
/*  Display profile permits                                           */
/*--------------------------------------------------------------------*/
ANALYSE:
  seconds = time('S')
  "TBCREATE" TABLEA "KEYS(ID) NAMES(ACC) REPLACE NOWRITE"
  do a = 1 to acl_ix
     id  = subword(acl.a,1,1)
     acc = subword(acl.a,2,1)
     do g = 1 to grp_ix
        if (id = subword(grp.g,1,1)) | (id = user) then
           "TBMOD" TABLEA
     end
  end
  /* Permit table display section */
  "TBSORT " TABLEA "FIELDS(ID)"
  "TBTOP  " TABLEA
  "TBDISPL" TABLEA "PANEL("PANEL15")"                         /* @A8 */
  "TBEND  " TABLEA
RETURN
/*--------------------------------------------------------------------*/
/*  Get profile permits                                               */
/*--------------------------------------------------------------------*/
GET_PROF_ACL:
  flags   = 'OFF'
  audit   = ' '
  owner   = ' '
  uacc    = ' '
  data    = ' '
  warn    = ' '
  acl_ix  = 0
  if (type = 'DISCRETE') then
     type = ' '
  cmd = "RLIST "RCLASS PROFILE" AUTH"                         /* @A5 */
  x = OUTTRAP('VAR.')
  address TSO cmd                                             /* @A5 */
  cmd_rc = rc                                                 /* @AB */
  x = OUTTRAP('OFF')
  if (SETMSHOW <> 'NO') then                                  /* @AG */
     call SHOWCMD                                             /* @A5 */
  if (type = ' ') then
     type = 'DISCRETE'
  Do i = 1 to var.0          /* Scan output */
     temp = var.i
     if (rlv > '1081') then   /* RACF 1.9 ADD BLANK */
        temp = ' 'temp
     l = LENGTH(temp)
     if (uacc = ' ') then
        if (substr(temp,2,12) = 'LEVEL  OWNER') then do
           i     = i + 2
           temp  = var.i
           owner = subword(temp,2,1)
           uacc  = subword(temp,3,1)
           warn  = subword(temp,5,1)
        end
     if (audit = ' ') then
        if (substr(temp,2,8) = 'AUDITING') then do
           i     = i + 2
           temp  = var.i
           audit = subword(temp,1,1)
        end
     if (data = ' ') then
        if (substr(temp,2,17) = 'INSTALLATION DATA') then do
           i    = i + 2
           temp = var.i
           data = temp
           i    = i + 1
           temp = var.i
           data = data || substr(temp,2)
        end
     if (flags = 'ON') then do
        if (l = 1) | (l= 2) then
           flags = 'OUT'     /* end of access list */
        if (l > 8) then
           if (substr(temp,1,9) = ' ') then
              flags = 'OUT'  /* end of access list */
     end
     if (flags = 'ON') then do
        if (substr(temp,2,10) = 'NO ENTRIES') then do
          id  = 'NONE'        /* empty access list */
          acc = 'DEFINED'
        end
        else do
           id  = subword(temp,1,1)
           acc = subword(temp,2,1)
        end
        acl_ix     = acl_ix+1  /* increase counter  */
        acl.acl_ix = id acc    /* store acl         */
     end
     if (substr(temp,1,17) = 'USER      ACCESS') then do
        flags = 'ON'      /* start of access list */
        i     = i + 1     /* skip */
     end
  end  /* Loop scan output */
RETURN
/*--------------------------------------------------------------------*/
/*  Get user group                                                    */
/*--------------------------------------------------------------------*/
GET_USER_GROUP:
  If (USER = 'NONE') then
     return
  flags  = 'OFF'
  grp_ix = 0
  cmd    = "LU "USER                                          /* @A5 */
  x = OUTTRAP('VAR.')
  address TSO cmd                                             /* @A5 */
  x = OUTTRAP('OFF')
  cmd_rc = rc                                                 /* @AB */
  if (SETMSHOW <> 'NO') then                                  /* @AG */
     call SHOWCMD                                             /* @A5 */
  Do i = 1 to var.0               /* Scan output */
     temp = var.i
     if (substr(temp,3,5) = 'GROUP') then do
        id         = substr(temp,9,8)
        acc        = substr(temp,24,8)
        grp_ix     = grp_ix+1    /* increase counter */
        grp.grp_ix = id acc      /* store acl        */
     End
  End
RETURN
/*--------------------------------------------------------------------*/
/*  Display RACF command and return code                         @A5  */
/*--------------------------------------------------------------------*/
SHOWCMD:                                                      /* @A5 */
  IF (SETMSHOW = "BOTH") | (SETMSHOW = "DISPLAY") THEN DO     /* @AH */
     PARSE VAR CMD MSG1 60 MSG2 121 MSG3                      /* @A5 */
     MSG4 = "Return code = "cmd_rc                            /* @AB */
     "ADDPOP ROW(6) COLUMN(4)"                                /* @A9 */
     "DISPLAY PANEL("PANELM2")"                               /* @A8 */
     "REMPOP"                                                 /* @A9 */
  END                                                         /* @AG */
  IF (SETMSHOW = "BOTH") | (SETMSHOW = "LOG") THEN DO         /* @AH */
     zerrsm = "RACFADM "REXXPGM" RC="cmd_rc                   /* @AM */
     zerrlm = cmd                                             /* @AG */
     'log msg(isrz003)'                                       /* @AG */
  END                                                         /* @AG */
RETURN                                                        /* @A5 */
