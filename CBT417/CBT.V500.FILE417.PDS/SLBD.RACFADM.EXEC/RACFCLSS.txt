/*%NOCOMMENT====================* REXX *==============================*/
/*  PURPOSE:  RACFADM - General Resources - Search classes            */
/*--------------------------------------------------------------------*/
/* FLG  YYMMDD  USERID   DESCRIPTION                                  */
/* ---  ------  -------  -------------------------------------------- */
/* @BO  200618  RACFA    Chged SYSDA to SYSALLDA                      */
/* @BN  200617  RACFA    Added comments to right of variables         */
/* @BM  200616  RACFA    Added primary command 'SAVE' when SEarching  */
/* @BL  200616  RACFA    Added capability to SAve file as TXT/CSV     */
/* @BK  200610  RACFA    Added primary command 'SAVE'                 */
/* @BJ  200506  RACFA    Drop array immediately when done using       */
/* @BI  200502  RACFA    Re-worked displaying tables, use DO FOREVER  */
/* @BH  200501  LBD      Add primary commands FIND/RFIND              */
/* @BG  200430  RACFA    Chg tblb to TABLEB, moved def. var. up top   */
/* @BF  200430  RACFA    Chg tbla to TABLEA, moved def. var. up top   */
/* @BE  200429  RACFA    Re-arranged variables (General, Mgmt, TSO)   */
/* @BD  200424  RACFA    Chg msg RACF013 to RACF012                   */
/* @BC  200424  RACFA    Fix msg RACF013, was RACF012                 */
/* @BB  200424  RACFA    Move DDNAME at top, standardize/del dups     */
/* @BA  200423  RACFA    Move PARSE REXXPGM name up above IF SETMTRAC */
/* @B9  200423  RACFA    Deleted the paranthesis, syntax error        */
/* @B8  200423  RACFA    'Status Interval' by percentage (SETGSTAP)   */
/* @B7  200422  RACFA    Ensure the REXX program name is 8 chars      */
/* @B6  200422  RACFA    Use variable REXXPGM in log msg              */
/* @B5  200417  RACFA    Chg REXX pgm name RACFAUTH to RACFCLSA       */
/* @B4  200413  RACFA    Chg TRACEing to only display banner (P=Pgms) */
/* @B3  200412  RACFA    Deleted subroutine 'ERROR', not needed       */
/* @B2  200412  RACFA    Chg TRACE to allow 'L'abels or 'R'esults     */
/* @B1  200402  RACFA    Chg LRECL=132 to LRECL=80                    */
/* @AZ  200402  RACFA    Fixed VIEW/EDIT, was missing edit macro var. */
/* @AY  200401  RACFA    Create subroutine to VIEW/EDIT/BROWSE        */
/* @AX  200401  RACFA    VIEW/EDIT use edit macro, to turn off HILITE */
/* @AW  200330  RACFA    Allow point-n-shoot sort ascending/descending*/
/* @AV  200324  RACFA    Allow both display/logging of RACF commands  */
/* @AU  200324  RACFA    Allow logging RACF commands to ISPF Log file */
/* @AT  200303  RACFA    Chg 'RL class ALL' to 'RL class * ALL'       */
/* @AS  200303  RACFA    Added line cmd 'L-List' to class's profile   */
/* @AR  200303  RACFA    Added line cmd 'L-List' to class             */
/* @AQ  200302  RACFA    Fixed SORT cmd for class profiles            */
/* @AP  200302  RACFA    Chk/honor 'Status Interval' for cls profiles */
/* @AO  200302  RACFA    Add SORT/LOCATE/ONLY/RESET for class profiles*/
/* @AN  200301  RACFA    Chk for 'NO ENTRIES MEET SEARCH CRITERIA'    */
/* @AM  200226  RACFA    Fix @AK chg, chg ret_code to cmd_rc          */
/* @AL  200226  RACFA    Added 'CONTROL ERRORS RETURN'                */
/* @AK  200226  RACFA    Removed double quotes before/after cmd       */
/* @AJ  200225  RACFA    Del address TSO "PROFILE PREF("USERID()")"   */
/* @AI  200224  RACFA    Fixed PANEL08, typo in defining variable     */
/* @AH  200224  RACFA    Standardize quotes, chg single to double     */
/* @AG  200224  RACFA    Place panels at top of REXX in variables     */
/* @AF  200223  RACFA    Del 'address TSO "PROFILE MSGID"', not needed*/
/* @AE  200223  RACFA    Reduced code when LOCATEing, not necessary   */
/* @AD  200223  RACFA    Reduced code when SORTing, not necessary     */
/* @AC  200223  RACFA    Created RACFCLSD (only Class, no profile col)*/
/* @AB  200223  RACFA    Added primary cmds: SORT, LOCATE, ONLY, RESET*/
/* @AA  200222  RACFA    Removed translating OPTA/B, not needed       */
/* @A9  200222  RACFA    Allow placing cursor on row and press ENTER  */
/* @A8  200221  RACFA    Removed "G = '(G)'", not referenced          */
/* @A7  200221  RACFA    Get SETMSHOW, to display RACF cmds           */
/* @A6  200221  RACFA    Make 'ADDRESS ISPEXEC' defualt, reduce code  */
/* @A5  200220  RACFA    Fixed displaying all RACF commands           */
/* @A4  200220  RACFA    Added SETMTRAC=YES, then TRACE R             */
/* @A3  200214  RACFA    Chged panel name RACFSRCH to RACFCLS8        */
/* @A2  200120  RACFA    Standardized/reduced lines of code           */
/* @A1  200120  RACFA    Added comment box above procedures           */
/* @A0  011229  NICORIZ  Created REXX, V2.1, www.rizzuto.it           */
/*====================================================================*/
PANEL08     = "RACFCLS8"   /* List classes and profiles    */ /* @AI */
PANEL13     = "RACFCLSD"   /* Add class                    */ /* @AG */
PANELM2     = "RACFMSG2"   /* Display RACF command and R   */ /* @AG */
PANELS1     = "RACFSAVE"   /* Obtain DSName to SAVE        */ /* @BK */
SKELETON1   = "RACFCLSD"   /* Save tablea to dataset       */ /* @BM */
SKELETON2   = "RACFCLS8"   /* Save tableb to dataset       */ /* @BK */
EDITMACR    = "RACFEMAC"   /* Edit Macro, turn HILITE off  */ /* @AZ */
TABLEA      = 'TA'RANDOM(0,99999)  /* Unique table name A  */ /* @BF */
TABLEB      = 'TB'RANDOM(0,99999)  /* Unique table name B  */ /* @BG */
DDNAME      = 'RACFA'RANDOM(0,999) /* Unique ddname        */ /* @BB */
parse source . . REXXPGM .         /* Obtain REXX pgm name */ /* @BA */
REXXPGM     = LEFT(REXXPGM,8)                                 /* @BA */
NULL        = ''                                              /* @BH */

ADDRESS ISPEXEC                                               /* @A6 */
  Arg user
  selection = 0  /* something selected */

  "CONTROL ERRORS RETURN"                                     /* @AL */
  "VGET (SETGSTA SETGSTAP SETGDISP SETMSHOW",                 /* @BE */
        "SETMTRAC) PROFILE"                                   /* @BE */

  If (SETMTRAC <> 'NO') then do                               /* @B2 */
     Say "*"COPIES("-",70)"*"                                 /* @B2 */
     Say "*"Center("Begin Program = "REXXPGM,70)"*"           /* @B2 */
     Say "*"COPIES("-",70)"*"                                 /* @B2 */
     if (SETMTRAC <> 'PROGRAMS') THEN                         /* @B4 */
        interpret "Trace "SUBSTR(SETMTRAC,1,1)                /* @B2 */
  end                                                         /* @B2 */

  rlv = SYSVAR('SYSLRACF')
  seconds = time('S')
  call Select_class
  if selection then rc = display_table_permit()
  "TBEND" TABLEB

  If (SETMTRAC <> 'NO') then do                               /* @B2 */
     Say "*"COPIES("-",70)"*"                                 /* @B2 */
     Say "*"Center("End Program = "REXXPGM,70)"*"             /* @B2 */
     Say "*"COPIES("-",70)"*"                                 /* @B2 */
  end                                                         /* @B2 */
EXIT
/*--------------------------------------------------------------------*/
/*  Get permits                                                       */
/*--------------------------------------------------------------------*/
GET_PERMITS:
  "TBCREATE" TABLEB" KEYS(CLASS PROFILE) REPLACE NOWRITE"     /* @AO */
  class = arg(1)
  user  = arg(2)
  cmd   = "SEARCH CLASS("class") USER("user")"                /* @A5 */
  x = OUTTRAP('VAR.')
  address TSO cmd                                             /* @A5 */
  cmd_rc = rc                                                 /* @AK */
  x = OUTTRAP('OFF')
  if (SETMSHOW <> 'NO') then                                  /* @AU */
     call SHOWCMD                                             /* @A5 */
  if (SETGSTAP <> "") THEN                                    /* @B8 */
     INTERPRET "RECNUM = var.0*."SETGSTAP"%1"                 /* @B8 */
  Do i = 1 to var.0   /* Scan output */
     profile = subword(var.i,1,1)
     If (profile = "NO") then                                 /* @AN */
        LEAVE         /* NO ENTRIES MEET SEARCH CRITERIA */
     if (profile <> 'ICH31005I') then do
        IF (SETGSTA = "") THEN DO                             /* @B8 */
           IF (RECNUM <> 0) THEN                              /* @B8 */
              IF (I//RECNUM = 0) THEN DO                      /* @B8 */
                 n1 = i; n2 = var.0                           /* @B8 */
                 pct = ((n1/n2)*100)%1'%'                     /* @B8 */
                 "control display lock"                       /* @B8 */
                 "display msg(RACF012)"                       /* @BD */
              END                                             /* @B8 */
        END                                                   /* @B8 */
        ELSE DO                                               /* @B8 */
           IF (SETGSTA <> 0) THEN                             /* @B8 */
              IF (I//SETGSTA = 0) THEN DO                     /* @AP */
                 n1 = i; n2 = var.0
                 pct = ((n1/n2)*100)%1'%'                     /* @B8 */
                 "control display lock"
                 "display msg(RACF012)"                       /* @BD */
              end                                             /* @AP */
        END                                                   /* @B8 */
        "TBMOD" TABLEB
     end
  end /* end_do i=1     */
  sort     = 'PROFILE,C,A'                                    /* @BI */
  sortprof = 'D'                                              /* @BI */
  "TBSORT "TABLEB" FIELDS("SORT")"                            /* @BI */
  "TBTOP  "TABLEB                                             /* @BI */
RETURN 0
/*--------------------------------------------------------------------*/
/*  Display permit table B                                            */
/*--------------------------------------------------------------------*/
DISPLAY_TABLE_PERMIT:
  xtdtop = 0                                                  /* @BI */
  rsels  = 0                                                  /* @BI */
  do forever                                                  /* @BI */
     if (rsels < 2) then do                                   /* @BI */
        opta = ' '                                            /* @BI */
        "TBTOP " TABLEB                                       /* @BI */
        'tbskip' tableb 'number('xtdtop')'                    /* @BI */
        radmrfnd = 'PASSTHRU'                                 /* @BI */
        'vput (radmrfnd)'                                     /* @BI */
        "TBDISPL" TABLEB "PANEL("PANEL08")"                   /* @BI */
     end                                                      /* @BI */
     else 'tbdispl' tableb                                    /* @BI */
     if (rc > 4) then leave                                   /* @BI */
     xtdtop   = ztdtop                                        /* @BI */
     rsels    = ztdsels                                       /* @BI */
     radmrfnd = null                                          /* @BI */
     'vput (radmrfnd)'                                        /* @BI */
     PARSE VAR ZCMD ZCMD PARM SEQ                             /* @BI */
     IF (SROW <> "") & (SROW <> 0) THEN                       /* @A9 */
        IF (SROW > 0) THEN DO                                 /* @A9 */
           "TBTOP " TABLEB                                    /* @A9 */
           "TBSKIP" TABLEB "NUMBER("SROW")"                   /* @A9 */
        END                                                   /* @A9 */
     if (zcmd = 'RFIND') then do                              /* @BH */
        zcmd = 'FIND'                                         /* @BH */
        parm = findit                                         /* @BH */
        'tbtop ' TABLEB                                       /* @BH */
        'tbskip' TABLEB 'number('last_find')'                 /* @BH */
     end                                                      /* @BH */
     Select
        When (abbrev("FIND",zcmd,1) = 1) then                 /* @BH */
             call do_findb                                    /* @BH */
        WHEN (ABBREV("LOCATE",ZCMD,1) = 1) THEN do            /* @BI */
             if (parm <> '') then do                          /* @BI */
                locarg = parm'*'                              /* @BI */
                PARSE VAR SORT . "," . "," SEQ                /* @BI */
                IF (SEQ = "D") THEN                           /* @BI */
                   CONDLIST = "LE"                            /* @BI */
                ELSE                                          /* @BI */
                   CONDLIST = "GE"                            /* @BI */
                parse value sort with scan_field',' .         /* @BI */
                interpret scan_field ' = locarg'              /* @BI */
                'tbtop ' tableb                               /* @BI */
                "TBSCAN "TABLEb" ARGLIST("scan_field")",      /* @BI */
                        "CONDLIST("CONDLIST")",               /* @BI */
                        "position(scanrow)"                   /* @BI */
                xtdtop = scanrow                              /* @BI */
             end                                              /* @BI */
        end                                                   /* @BI */
        WHEN (ABBREV("ONLY",ZCMD,1) = 1) THEN DO              /* @AO */
             find_str = translate(parm)                       /* @AO */
             'tbtop ' TABLEB                                  /* @AO */
             'tbskip' TABLEB                                  /* @AO */
             do forever                                       /* @AO */
                str = translate(profile)                      /* @AO */
                if (pos(find_str,str) > 0) then nop           /* @AO */
                else 'tbdelete' TABLEB                        /* @AO */
                'tbskip' TABLEB                               /* @AO */
                if (rc > 0) then do                           /* @AO */
                   'tbtop' TABLEB                             /* @AO */
                   leave                                      /* @AO */
                end                                           /* @AO */
             end                                              /* @AO */
        END                                                   /* @AO */
        WHEN (ABBREV("RESET",ZCMD,1) = 1) THEN DO             /* @AO */
             sort     = 'PROFILE,C,A'                         /* @AO */
             sortprof = 'D'                                   /* @AW */
             xtdtop   = 1                                     /* @AO */
             rc = get_permits(class,user) /*get permits*/     /* @AO */
        END                                                   /* @AO */
        When (abbrev("SAVE",zcmd,2) = 1) then DO              /* @BK */
             TMPSKELT = SKELETON2                             /* @BK */
             call do_SAVE                                     /* @BK */
        END                                                   /* @BK */
        WHEN (ABBREV("SORT",ZCMD,1) = 1) THEN DO              /* @BI */
             call sortseq 'PROFILE'                           /* @AW */
             "TBSORT "TABLEB" FIELDS("SORT")"                 /* @BI */
             "TBTOP  "TABLEB                                  /* @BI */
        END                                                   /* @BI */
        otherwise locvar=''
     End
     ZCMD = ""; PARM = ""                                     /* @BI */
     'control display save'                                   /* @BI */
     Select
        when (opta = 'L') then call lisd                      /* @AS */
        when (opta = 'S') then
             x = RACFCLSA(class profile user)
        otherwise nop
     End
     'control display restore'                                /* @BI */
  end  /* Do forever) */                                      /* @BI */
RETURN 0
/*--------------------------------------------------------------------*/
/*  Process primary command FIND for tableb                      @BH  */
/*--------------------------------------------------------------------*/
DO_FINDB:                                                     /* @BH */
  if (parm = null) then do                                    /* @BH */
     racfsmsg = 'Error'                                       /* @BH */
     racflmsg = 'Find requires a value to search for.' ,      /* @BH */
                'Try again.'                                  /* @BH */
     'setmsg msg(RACF011)'                                    /* @BH */
     return                                                   /* @BH */
  end                                                         /* @BH */
  findit    = translate(parm)                                 /* @BH */
  last_find = 0                                               /* @BH */
  wrap      = 0                                               /* @BH */
  do forever                                                  /* @BH */
     'tbskip' TABLEB                                          /* @BH */
     if (rc > 0) then do                                      /* @BH */
        if (wrap = 1) then do                                 /* @BH */
           racfsmsg = 'Not Found'                             /* @BH */
           racflmsg = findit 'not found.'                     /* @BH */
           'setmsg msg(RACF011)'                              /* @BH */
           return                                             /* @BH */
        end                                                   /* @BH */
        if (wrap = 0) then wrap = 1                           /* @BH */
        'tbtop' TABLEB                                        /* @BH */
     end                                                      /* @BH */
     else do                                                  /* @BH */
        testit = translate(profile)                           /* @BH */
        if (pos(findit,testit) > 0) then do                   /* @BH */
           'tbquery' TABLEB 'position(srow)'                  /* @BH */
           'tbtop'   TABLEB                                   /* @BH */
           'tbskip'  TABLEB 'number('srow')'                  /* @BH */
           last_find = srow                                   /* @BH */
           xtdtop    = srow                                   /* @BH */
           if (wrap = 0) then                                 /* @BH */
              racfsmsg = 'Found'                              /* @BH */
           else                                               /* @BH */
              racfsmsg = 'Found/Wrapped'                      /* @BH */
           racflmsg = findit 'found in row' srow + 0          /* @BH */
           'setmsg msg(RACF011)'                              /* @BH */
           return                                             /* @BH */
        end                                                   /* @BH */
     end                                                      /* @BH */
  end                                                         /* @BH */
RETURN                                                        /* @BH */
/*--------------------------------------------------------------------*/
/*  Process primary command FIND for tablea                      @BH  */
/*--------------------------------------------------------------------*/
DO_FINDA:                                                     /* @BH */
  if (parm = null) then do                                    /* @BH */
     racfsmsg = 'Error'                                       /* @BH */
     racflmsg = 'Find requires a value to search for.' ,      /* @BH */
                'Try again.'                                  /* @BH */
     'setmsg msg(RACF011)'                                    /* @BH */
     return                                                   /* @BH */
  end                                                         /* @BH */
  findit    = translate(parm)                                 /* @BH */
  last_find = 0                                               /* @BH */
  wrap      = 0                                               /* @BH */
  do forever                                                  /* @BH */
     'tbskip' TABLEA                                          /* @BH */
     if (rc > 0) then do                                      /* @BH */
        if (wrap = 1) then do                                 /* @BH */
           racfsmsg = 'Not Found'                             /* @BH */
           racflmsg = findit 'not found.'                     /* @BH */
           'setmsg msg(RACF011)'                              /* @BH */
           return                                             /* @BH */
        end                                                   /* @BH */
        if (wrap = 0) then wrap = 1                           /* @BH */
        'tbtop' TABLEA                                        /* @BH */
     end                                                      /* @BH */
     else do                                                  /* @BH */
        testit = translate(class)                             /* @BH */
        if (pos(findit,testit) > 0) then do                   /* @BH */
           'tbquery' TABLEA 'position(srow)'                  /* @BH */
           'tbtop'   TABLEA                                   /* @BH */
           'tbskip'  TABLEA 'number('srow')'                  /* @BH */
           last_find = srow                                   /* @BH */
           xtdtop    = srow                                   /* @BH */
           if (wrap = 0) then                                 /* @BH */
              racfsmsg = 'Found'                              /* @BH */
           else                                               /* @BH */
              racfsmsg = 'Found/Wrapped'                      /* @BH */
           racflmsg = findit 'found in row' srow + 0          /* @BH */
           'setmsg msg(RACF011)'                              /* @BH */
           return                                             /* @BH */
        end                                                   /* @BH */
     end                                                      /* @BH */
  end                                                         /* @BH */
RETURN                                                        /* @BH */
/*--------------------------------------------------------------------*/
/*  Define sort sequence, to allow point-n-shoot sorting (A/D)   @AW  */
/*--------------------------------------------------------------------*/
SORTSEQ:                                                      /* @AW */
  parse arg sortcol                                           /* @AW */
  INTERPRET "TMPSEQ = SORT"substr(SORTCOL,1,4)                /* @AW */
  select                                                      /* @AW */
     when (seq <> "") then do                                 /* @AW */
          if (seq = 'A') then                                 /* @AW */
             tmpseq = 'D'                                     /* @AW */
          else                                                /* @AW */
             tmpseq = 'A'                                     /* @AW */
          sort = sortcol',C,'seq                              /* @AW */
     end                                                      /* @AW */
     when (seq = ""),                                         /* @AW */
        & (tmpseq = 'A') then do                              /* @AW */
           sort   = sortcol',C,A'                             /* @AW */
           tmpseq = 'D'                                       /* @AW */
     end                                                      /* @AW */
     Otherwise do                                             /* @AW */
        sort   = sortcol',C,D'                                /* @AW */
        tmpseq = 'A'                                          /* @AW */
     end                                                      /* @AW */
  end                                                         /* @AW */
  INTERPRET "SORT"SUBSTR(SORTCOL,1,4)" = TMPSEQ"              /* @AW */
RETURN                                                        /* @AW */
/*--------------------------------------------------------------------*/
/*  Select class                                                      */
/*--------------------------------------------------------------------*/
SELECT_CLASS:
  call get_act_class
  rc = display_table()
  "TBEND" TABLEA
RETURN
/*--------------------------------------------------------------------*/
/*  Display profile permits                                           */
/*--------------------------------------------------------------------*/
GET_ACT_CLASS:
  seconds = time('S')                                         /* @AB */
  "TBCREATE" TABLEA "KEYS(CLASS)",                            /* @AB */
                  "NAMES(ACTION) REPLACE NOWRITE"             /* @AB */
  Scan = 'OFF'                                                /* @AB */
  cmd  = "SETROPTS LIST"                                      /* @A5 */
  x = OUTTRAP('var.')
  address TSO cmd                                             /* @A5 */
  cmd_rc = rc                                                 /* @AK */
  x = OUTTRAP('OFF')
  if (SETMSHOW <> 'NO') then                                  /* @AU */
     call SHOWCMD                                             /* @A5 */
  Do i = 1 to var.0           /* Scan output */
     temp = var.i
     if (rlv > '1081') then   /* RACF 1.9 add blank */
        temp = ' 'temp
     Select
        when (substr(temp,2,16) = 'ACTIVE CLASSES =') then do
             scan   = 'ON'
             record = substr(temp,18,80)
             nwords = words(record)
             do t = 1 to nwords
                class = subword(record,t,1)
                if (class <> 'USER'),
                 & (class <> 'DATASET'),
                 & (class <> 'GROUP') then
                   "TBMOD" TABLEA
             end
        end
        when (substr(temp,2,25) =,
             'GENERIC PROFILE CLASSES =') then leave
        otherwise
             if (scan = 'ON') then do
                  record = var.i
                  nwords = words(record)
                  do t = 1 to nwords
                     class = subword(record,t,1)
                     if (class <> 'USER'),
                      & (class <> 'DATASET'),
                      & (class <> 'GROUP') then
                        "TBMOD" TABLEA
                  end
             end
     End    /* end_select */
  end  /* end_scan output */
  sort     = 'CLASS,C,A'                                      /* @BI */
  sortclas = 0                                                /* @BI */
  "TBSORT " TABLEA "FIELDS("sort")"                           /* @BI */
  "TBTOP  " TABLEA                                            /* @BI */
RETURN
/*--------------------------------------------------------------------*/
/*  Display table A                                                   */
/*--------------------------------------------------------------------*/
DISPLAY_TABLE:
  opta   = ' '
  xtdtop = 0                                                  /* @BI */
  rsels  = 0                                                  /* @BI */
  do forever                                                  /* @BI */
     if (rsels < 2) then do                                   /* @BI */
        "TBTOP " TABLEA                                       /* @BI */
        'tbskip' tablea 'number('xtdtop')'                    /* @BI */
        radmrfnd = 'PASSTHRU'                                 /* @BI */
        'vput (radmrfnd)'                                     /* @BI */
        "TBDISPL" TABLEA "PANEL("PANEL13")"                   /* @BI */
     end                                                      /* @BI */
     else 'tbdispl' tablea                                    /* @BI */
     if (rc > 4) then leave                                   /* @BI */
     xtdtop   = ztdtop                                        /* @BI */
     rsels    = ztdsels                                       /* @BI */
     radmrfnd = null                                          /* @BI */
     'vput (radmrfnd)'                                        /* @BI */
     PARSE VAR ZCMD ZCMD PARM SEQ                             /* @BI */
     IF (SROW <> "") & (SROW <> 0) THEN                       /* @A9 */
        IF (SROW > 0) THEN DO                                 /* @A9 */
           "TBTOP " TABLEA                                    /* @A9 */
           "TBSKIP" TABLEA "NUMBER("SROW")"                   /* @A9 */
        END                                                   /* @A9 */
     if (zcmd = 'RFIND') then do                              /* @BH */
        zcmd = 'FIND'                                         /* @BH */
        parm = findit                                         /* @BH */
        'tbtop ' TABLEA                                       /* @BH */
        'tbskip' TABLEA 'number('last_find')'                 /* @BH */
     end                                                      /* @BH */
     Select                                                   /* @AB */
        When (abbrev("FIND",zcmd,1) = 1) then                 /* @BH */
             call do_finda                                    /* @BH */
        WHEN (ABBREV("LOCATE",ZCMD,1) = 1) THEN do            /* @BI */
             if (parm <> '') then do                          /* @BI */
                locarg = parm'*'                              /* @BI */
                PARSE VAR SORT . "," . "," SEQ                /* @BI */
                IF (SEQ = "D") THEN                           /* @BI */
                   CONDLIST = "LE"                            /* @BI */
                ELSE                                          /* @BI */
                   CONDLIST = "GE"                            /* @BI */
                parse value sort with scan_field',' .         /* @BI */
                interpret scan_field ' = locarg'              /* @BI */
                'tbtop ' tablea                               /* @BI */
                "TBSCAN "TABLEA" ARGLIST("scan_field")",      /* @BI */
                        "CONDLIST("CONDLIST")",               /* @BI */
                        "position(scanrow)"                   /* @BI */
                xtdtop = scanrow                              /* @BI */
             end                                              /* @BI */
        end                                                   /* @BI */
        WHEN (ABBREV("ONLY",ZCMD,1) = 1) THEN DO              /* @AB */
             find_str = translate(parm)                       /* @AB */
             'tbtop ' TABLEA                                  /* @AB */
             'tbskip' TABLEA                                  /* @AB */
             do forever                                       /* @AB */
                str = translate(class)                        /* @AB */
                if (pos(find_str,str) > 0) then nop           /* @AB */
                else 'tbdelete' TABLEA                        /* @AB */
                'tbskip' TABLEA                               /* @AB */
                if (rc > 0) then do                           /* @AB */
                   'tbtop' TABLEA                             /* @AB */
                   leave                                      /* @AB */
                end                                           /* @AB */
             end                                              /* @AB */
        END                                                   /* @AB */
        WHEN (ABBREV("RESET",ZCMD,1) = 1) THEN DO             /* @AB */
             call get_act_class                               /* @AB */
             sort     = 'CLASS,C,A'                           /* @AD */
             sortclas = 'A'                                   /* @AW */
             xtdtop   = 1                                     /* @AB */
        END                                                   /* @AB */
        When (abbrev("SAVE",zcmd,2) = 1) then DO              /* @BM */
             TMPSKELT = SKELETON1                             /* @BM */
             call do_SAVE                                     /* @BM */
        END                                                   /* @BM */
        WHEN (ABBREV("SORT",ZCMD,1) = 1) THEN DO              /* @BI */
             call sortseq 'CLASS'                             /* @AW */
             "TBSORT" TABLEA "FIELDS("sort")"                 /* @BI */
             "TBTOP " TABLEA                                  /* @BI */
        END                                                   /* @BI */
        otherwise NOP                                         /* @AB */
     END /* Select */                                         /* @AB */
     ZCMD = ""; PARM = ""                                     /* @BI */
     'control display save'                                   /* @BI */
     select
        when (opta = 'L') then call lisp                      /* @AR */
        when (opta = 'S') then do
             DISPCLS = CLASS                                  /* @AC */
             rc = get_permits(class,user) /*get permits*/
             'control display restore'                        /* @BI */
             selection = 1
             leave                                            /* @BI */
        end
        otherwise nop
     End
  end  /* Do forever) */                                      /* @BI */
RETURN 0
/*--------------------------------------------------------------------*/
/*  List class                                                   @AR  */
/*--------------------------------------------------------------------*/
LISP:                                                         /* @AR */
  cmd     = "RL "CLASS" * ALL"                                /* @AT */
  X = OUTTRAP("CMDREC.")                                      /* @AR */
  ADDRESS TSO cmd                                             /* @AR */
  cmd_rc = rc                                                 /* @AR */
  X = OUTTRAP("OFF")                                          /* @AR */
  if (SETMSHOW <> 'NO') then                                  /* @AU */
     call SHOWCMD                                             /* @AR */
  if (cmd_rc > 0) then do   /* Remove parms */                /* @AR */
     cmd     = "RL "CLASS" *"                                 /* @AT */
     X = OUTTRAP("CMDREC.")                                   /* @AR */
     ADDRESS TSO cmd                                          /* @AR */
     cmd_rc = rc                                              /* @AR */
     X = OUTTRAP("OFF")                                       /* @AR */
     if (SETMSHOW <> 'NO') then                               /* @AU */
        call SHOWCMD                                          /* @AR */
  end                                                         /* @AR */
  call display_info                                           /* @A8 */
  if (cmd_rc > 0) then                                        /* @AR */
     CALL racfmsgs "ERR10" /* Generic failure */              /* @AR */
RETURN                                                        /* @AR */
/*--------------------------------------------------------------------*/
/*  Display information from line commands 'L' and 'P'           @AY  */
/*--------------------------------------------------------------------*/
DISPLAY_INFO:                                                 /* @AY */
  ADDRESS TSO "ALLOC F("DDNAME") NEW REUSE",                  /* @AR */
              "LRECL(80) BLKSIZE(0) RECFM(F B)",              /* @B1 */
              "UNIT(VIO) SPACE(1 5) CYLINDERS"                /* @AR */
  ADDRESS TSO "EXECIO * DISKW "DDNAME" (STEM CMDREC. FINIS"   /* @AR */
  DROP CMDREC.                                                /* @BJ */
                                                              /* @BJ */
  "LMINIT DATAID(CMDDATID) DDNAME("DDNAME")"                  /* @AR */
  SELECT                                                      /* @AR */
     WHEN (SETGDISP = "VIEW") THEN                            /* @AR */
          "VIEW DATAID("CMDDATID") MACRO("EDITMACR")"         /* @AX */
     WHEN (SETGDISP = "EDIT") THEN                            /* @AR */
          "EDIT DATAID("CMDDATID") MACRO("EDITMACR")"         /* @AX */
     OTHERWISE                                                /* @AR */
          "BROWSE DATAID("CMDDATID")"                         /* @AR */
  END                                                         /* @AR */
  ADDRESS TSO "FREE FI("DDNAME")"                             /* @AR */
RETURN                                                        /* @AY */
/*--------------------------------------------------------------------*/
/*  List class's profile                                         @AS  */
/*--------------------------------------------------------------------*/
LISD:                                                         /* @AS */
  cmd  = "RLIST "CLASS PROFILE" AUTH"                         /* @AS */
  X    = OUTTRAP("CMDREC.")                                   /* @AS */
  ADDRESS TSO cmd                                             /* @AS */
  cmd_rc = rc                                                 /* @AS */
  X    = OUTTRAP("OFF")                                       /* @AS */
  if (SETMSHOW <> 'NO') then                                  /* @AU */
     call SHOWCMD                                             /* @AS */
  if (cmd_rc > 0) then do    /* Remove parms */               /* @AS */
     cmd = "RLIST "RCLASS PROFILE                             /* @AS */
     X = OUTTRAP("CMDREC.")                                   /* @AS */
     ADDRESS TSO cmd                                          /* @AS */
     cmd_rc = rc                                              /* @AS */
     X = OUTTRAP("OFF")                                       /* @AS */
     if (SETMSHOW <> 'NO') then                               /* @AU */
        call SHOWCMD                                          /* @AS */
  end                                                         /* @AS */
  call display_info                                           /* @A8 */
  if (cmd_rc > 0) then                                        /* @AS */
     CALL racfmsgs "ERR10" /* Generic failure */              /* @AS */
RETURN                                                        /* @AS */
/*--------------------------------------------------------------------*/
/*  Display RACF command and return code                         @AV  */
/*--------------------------------------------------------------------*/
SHOWCMD:                                                      /* @AV */
  IF (SETMSHOW = "BOTH") | (SETMSHOW = "DISPLAY") THEN DO     /* @AV */
     PARSE VAR CMD MSG1 60 MSG2 121 MSG3                      /* @AV */
     MSG4 = "Return code = "cmd_rc                            /* @AK */
     "ADDPOP ROW(6) COLUMN(4)"                                /* @AH */
     "DISPLAY PANEL("PANELM2")"                               /* @AG */
     "REMPOP"                                                 /* @AH */
  END                                                         /* @AU */
  IF (SETMSHOW = "BOTH") | (SETMSHOW = "LOG") THEN DO         /* @AV */
     zerrsm = "RACFADM "REXXPGM" RC="cmd_rc                   /* @B6 */
     zerrlm = cmd                                             /* @AU */
     'log msg(isrz003)'                                       /* @AU */
  END                                                         /* @AU */
RETURN                                                        /* @AV */
/*--------------------------------------------------------------------*/
/*  Save table to dataset                                        @BK  */
/*--------------------------------------------------------------------*/
DO_SAVE:                                                      /* @BK */
  X = MSG("OFF")                                              /* @BK */
  "ADDPOP COLUMN(40)"                                         /* @BK */
  "VGET (RACFSDSN RACFSMBR RACFSFIL RACFSREP) PROFILE"        /* @BL */
  IF (RACFSDSN = "") THEN         /* SAve - Dataset Name  */  /* @BN */
     RACFSDSN = USERID()".RACFADM.REPORTS"                    /* @EK */
  IF (RACFSFIL = "") THEN         /* SAve - As (TXT/CVS)  */  /* @BN */
     RACFSFIL = "T"                                           /* @EL */
  IF (RACFSREP = "") THEN         /* SAve - Replace (Y/N) */  /* @BN */
     RACFSREP = "N"                                           /* @EK */
                                                              /* @BK */
  DO FOREVER                                                  /* @BK */
     "DISPLAY PANEL("PANELS1")"                               /* @BK */
     IF (RC = 08) THEN DO                                     /* @BK */
        "REMPOP"                                              /* @BK */
        RETURN                                                /* @BK */
     END                                                      /* @BK */
     RACFSDSN = STRIP(RACFSDSN,,"'")                          /* @BK */
     RACFSDSN = STRIP(RACFSDSN,,'"')                          /* @BK */
     RACFSDSN = STRIP(RACFSDSN)                               /* @BK */
     SYSDSORG = ""                                            /* @BK */
     X = LISTDSI("'"RACFSDSN"'")                              /* @BK */
     IF (SYSDSORG = "") | (SYSDSORG = "PS"),                  /* @BK */
      | (SYSDSORG = "PO") THEN                                /* @BK */
        NOP                                                   /* @BK */
     ELSE DO                                                  /* @BK */
        RACFSMSG = "Not PDS/Seq File"                         /* @BK */
        RACFLMSG = "The dataset specified is not",            /* @BK */
                  "a partitioned or sequential",              /* @BK */
                  "dataset, please enter a valid",            /* @BK */
                  "dataset name."                             /* @BK */
       "SETMSG MSG(RACF011)"                                  /* @BK */
       ITERATE                                                /* @BK */
     END                                                      /* @BK */
     IF (SYSDSORG = "PS") & (RACFSMBR <> "") THEN DO          /* @BK */
        RACFSMSG = "Seq File - No mbr"                        /* @BK */
        RACFLMSG = "This dataset is a sequential",            /* @BK */
                  "file, please remove the",                  /* @BK */
                  "member name."                              /* @BK */
       "SETMSG MSG(RACF011)"                                  /* @BK */
       ITERATE                                                /* @BK */
     END                                                      /* @BK */
     IF (SYSDSORG = "PO") & (RACFSMBR = "") THEN DO           /* @BK */
        RACFSMSG = "PDS File - Need Mbr"                      /* @BK */
        RACFLMSG = "This dataset is a partitioned",           /* @BK */
                  "dataset, please include a member",         /* @BK */
                  "name."                                     /* @BK */
       "SETMSG MSG(RACF011)"                                  /* @BK */
       ITERATE                                                /* @BK */
     END                                                      /* @BK */
                                                              /* @BK */
     IF (RACFSMBR = "") THEN                                  /* @BK */
        TMPDSN = RACFSDSN                                     /* @BK */
     ELSE                                                     /* @BK */
        TMPDSN = RACFSDSN"("RACFSMBR")"                       /* @BK */
     DSNCHK = SYSDSN("'"TMPDSN"'")                            /* @BK */
     IF (DSNCHK = "OK" & RACFSREP = "N") THEN DO              /* @BK */
        RACFSMSG = "DSN/MBR Exists"                           /* @BK */
        RACFLMSG = "Dataset/member already exists. ",         /* @BK */
                  "Please type in "Y" to replace file."       /* @BK */
        "SETMSG MSG(RACF011)"                                 /* @BK */
        ITERATE                                               /* @BK */
     END                                                      /* @BK */
     LEAVE                                                    /* @BK */
  END                                                         /* @BK */
  "REMPOP"                                                    /* @BK */
  "VPUT (RACFSDSN RACFSMBR RACFSFIL RACFSREP) PROFILE"        /* @BL */
                                                              /* @BK */
ADDRESS TSO                                                   /* @BK */
  IF (RACFSREP = "Y" & RACFSMBR = "") |,                      /* @BK */
     (DSNCHK <> "OK" & DSNCHK <> "MEMBER NOT FOUND"),         /* @BK */
     THEN DO                                                  /* @BK */
     "DELETE '"RACFSDSN"'"                                    /* @BK */
     IF (RACFSMBR = "") THEN                                  /* @BK */
        "ALLOC  FI(ISPFILE) DA('"RACFSDSN"') NEW",            /* @BK */
            "REUSE SP(1 1) CYLINDER UNIT(SYSALLDA)",          /* @BO */
            "LRECL(80) RECFM(F B)"                            /* @BK */
     ELSE                                                     /* @BK */
        "ALLOC  FI(ISPFILE) DA('"RACFSDSN"') NEW",            /* @BK */
            "REUSE SP(1 1) CYLINDER UNIT(SYSALLDA)",          /* @BO */
            "LRECL(80) RECFM(F B)",                           /* @BK */
            "DSORG(PO) DSNTYPE(LIBRARY,2)"                    /* @BK */
  END                                                         /* @BK */
  ELSE                                                        /* @BK */
     "ALLOC  FI(ISPFILE) DA('"RACFSDSN"') SHR REUSE"          /* @BK */
                                                              /* @BK */
ADDRESS ISPEXEC                                               /* @BK */
  "FTOPEN"                                                    /* @BK */
  "FTINCL "TMPSKELT                                           /* @BK */
  IF (RACFSMBR = "") THEN                                     /* @BK */
     "FTCLOSE"                                                /* @BK */
  ELSE                                                        /* @BK */
     "FTCLOSE NAME("RACFSMBR")"                               /* @BK */
  ADDRESS TSO "FREE FI(ISPFILE)"                              /* @BK */
                                                              /* @BK */
  SELECT                                                      /* @BK */
     WHEN (SETGDISP = "VIEW") THEN                            /* @BK */
          "VIEW DATASET('"RACFSDSN"') MACRO("EDITMACR")"      /* @BK */
     WHEN (SETGDISP = "EDIT") THEN                            /* @BK */
          "EDIT DATASET('"RACFSDSN"') MACRO("EDITMACR")"      /* @BK */
     OTHERWISE                                                /* @BK */
          "BROWSE DATASET('"RACFSDSN"')"                      /* @BK */
  END                                                         /* @BK */
  X = MSG("ON")                                               /* @BK */
                                                              /* @BK */
RETURN                                                        /* @BK */
