/*%NOCOMMENT====================* REXX *==============================*/
/*  PURPOSE:  RACFADM - RACF Parameters - Menu option 8 or 9          */
/*--------------------------------------------------------------------*/
/* FLG  YYMMDD  USERID   DESCRIPTION                                  */
/* ---  ------  -------  -------------------------------------------- */
/* @AY  200730  TRIDJK   Added Generic prof chk/Generic cmd proc      */
/* @AX  200629  RACFA    Added FMID                                   */
/* @AW  200629  RACFA    Chged RACF version to V##R##, was V##R##M##  */
/* @AU  200629  RACFA    Fixed displaying RACF version                */
/* @AT  200629  RACFA    If no RACF bkup dsn, then display N/A        */
/* @AS  200618  RACFA    Chged SYSDA to SYSALLDA                      */
/* @AR  200617  RACFA    Added comments to right of variables         */
/* @AQ  200616  RACFA    Added capability to SAve file as TXT/CSV     */
/* @AP  200610  RACFA    Added primary command 'SAVE'                 */
/* @AO  200608  TRIDJK   Add 'Password minimum change interval'       */
/* @AN  200502  RACFA    Del line 170, 'call table_create', not used  */
/* @AM  200501  RACFA    Commented 'JES early verify', obsolete parm  */
/* @AL  200501  LBD      Add primary commands FIND/RFIND              */
/* @AK  200430  RACFA    Chg tbla to TABLEA, moved def. var. up top   */
/* @AJ  200429  TRIDJK   Chg text on 2 parmeters                      */
/* @AI  200429  RACFA    Chg 'Datasets' to 'Dataset'                  */
/* @AH  200428  TRIDJK   Fixed variable names                         */
/* @AG  200427  RACFA    Standardize SORT, LOCATE, ONLY & RESET cmds  */
/* @AF  200427  TRIDJK   Added 'Password phrase'                      */
/* @AE  200427  LBD      Convert to table display                     */
/* @AD  200424  TRIDJK   Swapped rcvtelen & rcvtslen (end/start leng) */
/* @AC  200424  TRIDJK   Add password lowercase/spc char/ext support  */
/* @AB  200423  RACFA    Move PARSE REXXPGM name up above IF SETMTRAC */
/* @AA  200423  RACFA    Ensure REXX program name is 8 chars long     */
/* @A9  200423  RACFA    Chg variable name RCVTGDSN to RCVTPDSN       */
/* @A8  200423  RACFA    Get RACF Bkp database name                   */
/* @A7  200413  RACFA    Chg TRACEing to only display banner (P=Pgms) */
/* @A6  200412  RACFA    Chg TRACE to allow 'L'abels or 'R'esults     */
/* @A5  200224  RACFA    Place panels at top of REXX in variables     */
/* @A4  200221  RACFA    Make 'ADDRESS ISPEXEC' defualt, reduce code  */
/* @A3  200220  RACFA    Added SETMTRAC=YES, then TRACE R             */
/* @A2  200120  TRIDJK   Add multi factor authentication (rcvtsmfa)   */
/* @A1  200119  RACFA    Standardized/reduced lines of code           */
/* @A0  011229  NICORIZ  Created REXX, V2.1, www.rizzuto.it           */
/*====================================================================*/
PANEL19     = "RACFPRMS"   /* RACF parameters, menu opt 7  */ /* @A5 */
PANELS1     = "RACFSAVE"   /* Obtain DSName to SAVE        */ /* @AP */
SKELETON1   = "RACFPRMS"   /* Save tablea to dataset       */ /* @AP */
EDITMACR    = "RACFEMAC"   /* Edit Macro, turn HILITE off  */ /* @AP */
TABLEA      = 'TA'RANDOM(0,99999)  /* Unique table name A  */ /* @AK */
parse source . . REXXPGM .         /* Obtain REXX pgm name */ /* @AB */
REXXPGM     = LEFT(REXXPGM,8)                                 /* @AB */
parse value '' with null                                      /* @AE */

ADDRESS ISPEXEC                                               /* @A4 */
  "VGET (SETMTRAC SETGDISP) PROFILE"                          /* @AP */
  If (SETMTRAC <> 'NO') then do                               /* @A6 */
     Say "*"COPIES("-",70)"*"                                 /* @A6 */
     Say "*"Center("Begin Program = "REXXPGM,70)"*"           /* @A6 */
     Say "*"COPIES("-",70)"*"                                 /* @A6 */
     if (SETMTRAC <> 'PROGRAMS') THEN                         /* @A7 */
        interpret "Trace "SUBSTR(SETMTRAC,1,1)                /* @A6 */
  end                                                         /* @A6 */

  cvt     = c2x(storage(10,4))              /* cvt address            */
  cvtrac$ = d2x((x2d(cvt))+992)             /* cvt + 3E0 = cvtrac $   */
  cvtrac  = c2x(storage(cvtrac$,4))         /* cvtrac = access cntl   */
  rcvt$   = cvtrac                          /* store for panel output */

  call Get_bkp_database_name                /* Get bkp dsname         */
  call Get_initial_rcvt_values              /* Get initial values     */
  call Racf_audit_options                   /* Get audit options      */
  call Racf_jes2_options
  call Racf_password_options
  call Racf_rvary_passwords
  call Racf_setropt_options
  call Racf_dasd_options
  call Racf_model_options
  call Racf_terminal_options
  call Racf_tape_options
  call Racf_dataset_class                                     /* @AY */
  call Racf_statistics
  call Get_passphrase                       /* Password phrase   @AF */

  SORT = "DESCU,C,A"                                          /* @AG */
  sortdesc = 'D'; sortvalu = 'A'                              /* @AG */
  call CREATE_TABLEA                                          /* @AE */
  /*----------------------------------*/                      /* @AE */
  /* Display the table and process it */                      /* @AE */
  /*----------------------------------*/                      /* @AE */
  Do forever                                                  /* @AE */
     radmrfnd = 'PASSTHRU'                                    /* @AL */
     'vput (radmrfnd)'                                        /* @AL */
     'tbdispl' TABLEA 'panel('panel19')'                      /* @AE */
     lastrc = rc                                              /* @AL */
     radmrfnd = null                                          /* @AL */
     'vput (radmrfnd)'                                        /* @AL */
     if (lastrc > 0) then leave                               /* @AE */
     /*-------------------------*/                            /* @AE */
     /* Reset racfrfnd to blank */                            /* @AE */
     /*-------------------------*/                            /* @AE */
     PARSE VAR ZCMD ZCMD PARM SEQ                             /* @AG */
     if (zcmd = 'RFIND') then do                              /* @AL */
        zcmd = 'FIND'                                         /* @AL */
        parm = findit                                         /* @AL */
        'tbtop' tablea                                        /* @AL */
        'tbskip' tablea 'number('last_find')'                 /* @AL */
     end                                                      /* @AL */
     Select                                                   /* @AG */
        When (abbrev("FIND",zcmd,1) = 1) then                 /* @AL */
             call do_find                                     /* @AL */
        When (abbrev('LOCATE',zcmd,1) = 1) then               /* @AG */
             call do_locate                                   /* @AG */
        When (abbrev('ONLY',zcmd,1) = 1) then                 /* @AG */
             call do_only                                     /* @AG */
        When (abbrev('RESET',zcmd,1) = 1) then do             /* @AG */
             sort     = 'DESCU,C,A'                           /* @AG */
             sortdesc = 'A'; sortvalu = 'A'                   /* @AG */
             "TBEND" TABLEA                                   /* @AG */
             call CREATE_TABLEA                               /* @AG */
        end                                                   /* @AG */
        When (abbrev("SAVE",zcmd,2) = 1) then DO              /* @AP */
             TMPSKELT = SKELETON1                             /* @AP */
             call do_SAVE                                     /* @AP */
        END                                                   /* @AP */
        when (abbrev('SORT',zcmd,1) = 1) then do              /* @AG */
             if (abbrev('DESCRIPTION',PARM,1)) THEN           /* @AG */
                call do_sort 'DESCU'                          /* @AG */
             if (abbrev('VALUE',PARM,1)) THEN                 /* @AG */
                call do_sort 'VALUE'                          /* @AG */
        end                                                   /* @AG */
        otherwise nop                                         /* @AG */
     end                                                      /* @AG */
  end                                                         /* @AE */
  'tbend' TABLEA                                              /* @AE */
                                                              /* @AE */
  If (SETMTRAC <> 'NO') then do                               /* @A6 */
     Say "*"COPIES("-",70)"*"                                 /* @A6 */
     Say "*"Center("End Program = "REXXPGM,70)"*"             /* @A6 */
     Say "*"COPIES("-",70)"*"                                 /* @A6 */
  end                                                         /* @A6 */
                                                              /* @AE */
RETURN 0000                                                   /* @AE */
/*--------------------------------------------------------------------*/
/*  Process primary command FIND                                 @AL  */
/*--------------------------------------------------------------------*/
DO_FIND:                                                      /* @AL */
  if (parm = null) then do                                    /* @AL */
     racfsmsg = 'Error'                                       /* @AL */
     racflmsg = 'Find requires a value to search for.' ,      /* @AL */
                'Try again.'                                  /* @AL */
     'setmsg msg(RACF011)'                                    /* @AL */
     return                                                   /* @AL */
  end                                                         /* @AL */
  findit    = translate(parm)                                 /* @AL */
  last_find = 0                                               /* @AL */
  wrap      = 0                                               /* @AL */
  do forever                                                  /* @AL */
     'tbskip' tablea                                          /* @AL */
     if (rc > 0) then do                                      /* @AL */
        if (wrap = 1) then do                                 /* @AL */
           racfsmsg = 'Not Found'                             /* @AL */
           racflmsg = findit 'not found.'                     /* @AL */
           'setmsg msg(RACF011)'                              /* @AL */
           return                                             /* @AL */
        end                                                   /* @AL */
        if (wrap = 0) then wrap = 1                           /* @AL */
        'tbtop' tablea                                        /* @AL */
     end                                                      /* @AL */
     else do                                                  /* @AL */
        testit = translate(desc value)                        /* @AL */
        if (pos(findit,testit) > 0) then do                   /* @AL */
           'tbquery' tablea 'position(srow)'                  /* @AL */
           'tbtop'   tablea                                   /* @AL */
           'tbskip'  tablea 'number('srow')'                  /* @AL */
           last_find = srow                                   /* @AL */
           xtdtop    = srow                                   /* @AL */
           if (wrap = 0) then                                 /* @AL */
              racfsmsg = 'Found'                              /* @AL */
           else                                               /* @AL */
              racfsmsg = 'Found/Wrapped'                      /* @AL */
           racflmsg = findit 'found in row' srow + 0          /* @AL */
           'setmsg msg(RACF011)'                              /* @AL */
           return                                             /* @AL */
        end                                                   /* @AL */
     end                                                      /* @AL */
  end                                                         /* @AL */
RETURN                                                        /* @AL */
/*--------------------------------------------------------------------*/
/*  Reset the table                                              @AE  */
/*--------------------------------------------------------------------*/
DO_RESET:                                                     /* @AE */
  'tbend' TABLEA                                              /* @AE */
  call CREATE_TABLEA                                          /* @AE */
RETURN                                                        /* @AE */
/*--------------------------------------------------------------------*/
/*  Sort the table - 1st ascending then descending               @AE  */
/*--------------------------------------------------------------------*/
DO_SORT:                                                      /* @AE */
  parse arg sortcol                                           /* @AG */
  INTERPRET "TMPSEQ = SORT"substr(SORTCOL,1,4)                /* @AG */
  select                                                      /* @AG */
     when (seq <> "") then do                                 /* @AG */
          if (seq = 'A') then                                 /* @AG */
             tmpseq = 'D'                                     /* @AG */
          else                                                /* @AG */
             tmpseq = 'A'                                     /* @AG */
          sort = sortcol',C,'seq                              /* @AG */
     end                                                      /* @AG */
     when (seq = ""),                                         /* @AG */
        & (tmpseq = 'A') then do                              /* @AG */
           sort   = sortcol',C,A'                             /* @AG */
           tmpseq = 'D'                                       /* @AG */
     end                                                      /* @AG */
     Otherwise do                                             /* @AG */
        sort   = sortcol',C,D'                                /* @AG */
        tmpseq = 'A'                                          /* @AG */
     end                                                      /* @AG */
  end                                                         /* @AG */
  INTERPRET "SORT"SUBSTR(SORTCOL,1,4)" = TMPSEQ"              /* @AG */
  'TBSort' TABLEA 'Fields('sort')'                            /* @AG */
  'tbtop'  TABLEA                                             /* @AE */
  CLRDESC = "GREEN"; CLRVALU = "GREEN"                        /* @AG */
  INTERPRET "CLR"SUBSTR(SORTCOL,1,4)" = 'TURQ'"               /* @AG */
RETURN                                                        /* @AE */
/*--------------------------------------------------------------------*/
/*  Locate table entry                                           @AE  */
/*--------------------------------------------------------------------*/
DO_LOCATE:                                                    /* @AE */
  ASTERICK = "*"                                              /* @AG */
  PARSE VAR SORT LOCARG "," .                                 /* @AG */
  INTERPRET LOCARG" = parm||ASTERICK"                         /* @AG */
  PARSE VAR SORT . "," . "," SEQ                              /* @AG */
  IF (SEQ = "D") THEN                                         /* @AG */
     CONDLIST = "LE"                                          /* @AG */
  ELSE                                                        /* @AG */
     CONDLIST = "GE"                                          /* @AG */
  "TBSCAN "TABLEA,                                            /* @AG */
          "ARGLIST("LOCARG") CONDLIST("CONDLIST")"            /* @AG */
RETURN                                                        /* @AE */
/*--------------------------------------------------------------------*/
/*  Only display rows with the provided text string              @AE  */
/*--------------------------------------------------------------------*/
DO_ONLY:                                                      /* @AE */
  'tbtop' TABLEA                                              /* @AE */
  hit = 0                                                     /* @AE */
  do forever                                                  /* @AE */
     'tbskip' TABLEA                                          /* @AE */
     if (rc > 0) then leave                                   /* @AE */
     hit = 0                                                  /* @AE */
     if (pos(parm,descu value) > 0) then                      /* @AG */
        iterate                                               /* @AE */
     'tbdelete' TABLEA                                        /* @AE */
  end                                                         /* @AE */
RETURN                                                        /* @AE */
/*--------------------------------------------------------------------*/
/*  Get initial RCVT values                                           */
/*--------------------------------------------------------------------*/
GET_INITIAL_RCVT_VALUES:
  rc        = Setchar(rcvtpdsn,56,44)       /* racf dsn           @A9 */
  rc        = Setchar(rcvtuads,100,44)      /* uads dsn               */
  rc        = Setchar(rcvtuvol,144,6)       /* uads vol               */

  CVT       = C2D(STORAGE(10,4))            /* Get RACF Version  @AU  */
  x         = storage(d2x(cvt - 38),5)                        /* @AU */
  rcvtgrnm  = 'V'substr(x,3,1)'R'substr(x,5,1)                /* @AW */
  rcvtfmid  = "HRF"STORAGE(D2X(CVT - 29),4)                   /* @AX */
  rcvtstat$ =  d2x((x2d(cvtrac))+36)        /*                        */
  rcvtgext  =  c2x(storage(rcvtstat$,4))    /* RACF extension         */
  rcvtstat$ =  d2x((x2d(cvtrac))+36)        /*                        */
  rcvtgucb  =  c2x(storage(rcvtstat$,4))    /* dsn UCB                */
  rcvtstat$ =  d2x((x2d(cvtrac))+4)         /*                        */
  rcvtgdcb  =  c2x(storage(rcvtstat$,4))    /* dsn dcb                */
  rcvtstat$ =  d2x((x2d(cvtrac))+8)         /*                        */
  rcvtgdeb  =  c2x(storage(rcvtstat$,4))    /* dsn DEB                */

  rc= Setbool(rcvtgsta,53,'80','Active','Inactive')  /* RACF active?  */
  rc= Setbool(rcvtgmsg,153,'04','No','Yes')          /* ICH412I issued*/
  rc= Setbool(rcvtgoff,153,'80','No','Yes')          /* RVARY INACTIVE*/
RETURN
/*--------------------------------------------------------------------*/
/*  RACF JES2 parameters                                              */
/*--------------------------------------------------------------------*/
RACF_JES2_OPTIONS:
  rc= Setbool(rcvtjchk,150,'02','NO','YES') /* jes2_early_verify      */
  rc= Setbool(rcvtjall,150,'01','NO','YES') /* jes2_batchgallracf     */
  rc= Setbool(rcvtjxal,150,'04','NO','YES') /* jes2_xbmallracf        */
  rc= Setchar(rcvtjsys,696,8)               /* jes NJE userid         */
  rc= Setchar(rcvtjund,704,8)               /* jes undefined user     */
RETURN
/*--------------------------------------------------------------------*/
/*  RACF RVARY passwords                                              */
/*--------------------------------------------------------------------*/
RACF_RVARY_PASSWORDS:
  rcvtrwpw$ = d2x((x2d(cvtrac))+440)        /* rcvtrwpw     $         */
  rcvtrwpw  = c2x(storage(rcvtrwpw$,8))     /* rcvtrwpw               */
  rcvtrnpw$ = d2x((x2d(cvtrac))+448)        /* rcvtrwpw     $         */
  rcvtrnpw  = c2x(storage(rcvtrnpw$,8))     /* rcvtrnpw               */
  rc        = Setvalue(rcvtslen,244,1)      /* pe length begin   @AD  */
  rc        = Setvalue(rcvtelen,245,1)      /* pe length end     @AD  */
  if (rcvtslen = 0) then rcvtslen = 1                         /* @AD */
  if (rcvtelen = 0) then rcvtelen = 8                         /* @AD */
  rc        = Setchar(rcvtruls,246,8)       /* password syntax        */
RETURN
/*--------------------------------------------------------------------*/
/*  RACF password options                                             */
/*--------------------------------------------------------------------*/
RACF_PASSWORD_OPTIONS:
  rc = Setvalue(rcvtpinv,155,1)             /* password expires       */
  rc = Setvalue(rcvtphis,240,1)             /* password historical    */
  rc = Setvalue(rcvtprvk,241,1)             /* password revoked att.  */
  rc = Setvalue(rcvtpwrn,242,1)             /* password warning       */
  rc = Setvalue(rcvtpina,243,1)             /* password inactive      */
RETURN
/*--------------------------------------------------------------------*/
/*  RACF setropt options                                              */
/*--------------------------------------------------------------------*/
RACF_SETROPT_OPTIONS:
  rc = Setbool(rcvtsegn,53,'01','NO','YES')  /* egn                   */
  rc = Setbool(rcvtplc,633,'40','NO','YES')  /* lower case pswd   @AC */
  rc = Setbool(rcvtpsc,633,'08','NO','YES')  /* special chr pswd  @AC */
  rc = Setbool(rcvtxpwd,633,'04','NO','YES') /* extend pswd spt   @AC */
  rc = Setbool(rcvtmfa,633,'02','NO','YES')  /* mfa               @A2 */
  rc = Setbool(rcvtsads,53,'02','YES','NO')  /* adsp                  */
  rc = Setbool(rcvtscat,628,'40','NO','YES') /* catdsns               */
  rc = Setbool(rcvtseos,393,'20','NO','YES') /* erase on scratch      */
  rc = Setbool(rcvtsapl,764,'08','NO','YES') /* applaudit             */
  rc = Setbool(rcvtsaus,764,'10','YES','NO') /* audit special         */
  rc = Setbool(rcvtsauo,151,'01','NO','YES') /* audit operations      */
  rc = Setbool(rcvtsgrc,329,'80','NO','YES') /* listofgroupschecking  */
  rc = Setbool(rcvtsgno,628,'02','NO','YES') /* generic owner         */
  rc = Setbool(rcvtsmla,628,'04','NO','YES') /* mlactive              */
  rc = Setbool(rcvtsmlq,628,'20','NO','YES') /* mlquiet               */
  rc = Setbool(rcvtsmls,628,'08','NO','YES') /* mls                   */
  rc = Setbool(rcvtsmlt,628,'10','NO','YES') /* mlstable              */
  rc = Setbool(rcvtsslc,628,'80','NO','YES') /* seclabel control      */
  rc = Setbool(rcvtssla,628,'01','NO','YES') /* seclabel audit        */
  rc = Setbool(rcvtswhe,394,'80','NO','YES') /* when program          */
  rc = Setbool(rcvtspra,393,'80','NO','YES') /* protect all           */
  rc = Setvalue(rcvtsrpe,396,2)              /* retention period      */
  rc = Setvalue(rcvtpmin,634,1)              /* pswd min chg intv @AO */

  rcvtsta$ = d2x((x2d(cvtrac))+630)         /* rcvtsta      $         */
  x        = storage(rcvtsta$,2)
  rcvtslui = c2d(x)                         /* lu session interval    */

  rc       = Setchar(rcvtqual,400,9)        /* prefix password+period */
RETURN
/*--------------------------------------------------------------------*/
/*  Set variable in a Yes/No                                          */
/*--------------------------------------------------------------------*/
SETBOOL:
  variable = arg(1)
  offset   = arg(2)
  value    = arg(3)
  status1  = arg(4)
  status2  = arg(5)
  interpret  "rcvtsta$= d2x((x2d("cvtrac"))+"offset")"
  x        = storage(rcvtsta$,1)
  interpret  variable '= 'status1
  interpret  "x=bitand(x,'"value"'x)"       /* remove unwanted bits   */
  interpret  "if (x= '"value"'x) then "variable"="status2
RETURN 0000
/*--------------------------------------------------------------------*/
/*  Set value                                                         */
/*--------------------------------------------------------------------*/
SETVALUE:
  variable = arg(1)
  offset   = arg(2)
  length   = arg(3)
  interpret  "rcvtsta$= d2x((x2d("cvtrac"))+"offset")"
  cmd      = variable '=c2d(storage('rcvtsta$','length'))'
  interpret  cmd
RETURN 0000
/*--------------------------------------------------------------------*/
/*  Set character                                                     */
/*--------------------------------------------------------------------*/
SETCHAR:
  variable = arg(1)
  offset   = arg(2)
  length   = arg(3)
  interpret  "rcvtsta$= d2x((x2d("cvtrac"))+"offset")"
  cmd      = variable '=storage('rcvtsta$','length')'
  interpret  cmd
RETURN 0000
/*--------------------------------------------------------------------*/
/*  RACF DASD options                                                 */
/*--------------------------------------------------------------------*/
RACF_DASD_OPTIONS:
  rc= Setbool(rcvtdvpr,150,'40','NO','YES') /* dasd vol protection    */
  rc= Setbool(rcvtndup,153,'10','NO','YES') /* no duplicate datasets  */
RETURN
/*--------------------------------------------------------------------*/
/*  RACF model options                                                */
/*--------------------------------------------------------------------*/
RACF_MODEL_OPTIONS:
  rc= Setbool(rcvtmgdg,324,'80','NO','YES') /* model gdg              */
  rc= Setbool(rcvtmusr,324,'40','NO','YES') /* model user             */
  rc= Setbool(rcvtmgrp,324,'20','NO','YES') /* model group            */
RETURN
/*--------------------------------------------------------------------*/
/*  RACF terminal options                                             */
/*--------------------------------------------------------------------*/
RACF_TERMINAL_OPTIONS:
  rc = Setbool(rcvttaut,154,'80','NO','YES') /* terminal auth chking  */
  rc = Setbool(rcvttuac,154,'40','NO','YES') /* terminal uacc         */
RETURN
/*--------------------------------------------------------------------*/
/*  RACF statistics                                                   */
/*--------------------------------------------------------------------*/
RACF_STATISTICS:
  rc = Setbool(rcvtnls ,53,'40','Yes','No')         /* racinit        */
  rc = Setbool(rcvtndss,53,'20','Yes','No')         /* data set       */
  rc = Setbool(rcvtntvs,53,'10','Yes','No')         /* tape           */
  rc = Setbool(rcvtndvs,53,'08','Yes','No')         /* dasd           */
  rc = Setbool(rcvtntms,53,'04','Yes','No')         /* terminal       */
RETURN
/*--------------------------------------------------------------------*/
/*  RACF tape options                                                 */
/*--------------------------------------------------------------------*/
RACF_TAPE_OPTIONS:
  rc = Setbool(rcvttvpr,150,'80','NO','YES')   /* tape vol protection */
  rc = Setbool(rcvttdpr,392,'40','NO','YES')   /* tape dsn protection */
RETURN
/*--------------------------------------------------------------------*/
/*  RACF generic profile checking/cmd processing for dataset class    */
/*--------------------------------------------------------------------*/
RACF_DATASET_CLASS:                                           /* @AY */
  rc = Setbool(rcvtdgen,150,'20','NO','YES')   /* generic profile chk */
  rc = Setbool(rcvtdgcm,150,'10','NO','YES')   /* generic command proc*/
RETURN
/*--------------------------------------------------------------------*/
/*  RACF audit options                                                */
/*--------------------------------------------------------------------*/
RACF_AUDIT_OPTIONS:
  rcvtauop$ = d2x((x2d(cvtrac))+151)        /* rcvtauop     $         */

  x         = storage(rcvtauop$,1)          /* rcvtauop               */
  rcvtagro  = 'No'                          /* default                */
  x         = bitand(x,'40'x)               /* remove unwanted bits   */
  if (x = '40'x) then                       /* audit group class?     */
     rcvtagro = 'Yes'                       /* yes                    */

  x         = storage(rcvtauop$,1)          /* rcvtauop               */
  rcvtause='No'                             /* default                */
  x         = bitand(x,'20'x)               /* remove unwanted bits   */
  if (x = '20'x) then                       /* audit user class ?     */
     rcvtause = 'Yes'                       /* yes                    */

  x         = storage(rcvtauop$,1)          /* rcvtauop               */
  rcvtadat='No'                             /* default                */
  x         = bitand(x,'10'x)               /* remove unwanted bits   */
  if (x = '10'x) then                       /* audit dataset class?   */
     rcvtadat ='Yes'                        /* yes                    */

  x         = storage(rcvtauop$,1)          /* rcvtauop               */
  rcvtadas='No'                             /* default                */
  x         = bitand(x,'08'x)               /* remove unwanted bits   */
  if (x = '08'x) then                       /* audit DASDVOL class?   */
     rcvtadas ='Yes'                        /* yes                    */
RETURN
/*--------------------------------------------------------------------*/
/*  Get RACF backup database name                                @A9  */
/*--------------------------------------------------------------------*/
GET_BKP_DATABASE_NAME:                                        /* @A9 */
  DSDT     = D2X(X2D(CVTRAC) + X2D(E0))   /* Pointer to DSDT pointer */
  DSDT     = C2X(STORAGE(DSDT,4))         /* Pointer to DSDT         */
  DSDTNUM  = D2X(X2D(DSDT) + X2D(4))      /* Address of DSDTNUM      */
  DSDTNUM  = C2D(STORAGE(DSDTNUM,4))      /* DSDTNUM                 */
  DSDTBACK = D2X(X2D(DSDT) + X2D(140))    /* Address of 1st Bkup DSN */
  BNAME    = D2X(X2D(DSDTBACK) + X2D(21)) /* Addr of backup name     */
  RCVTBDSN = STRIP(STORAGE(BNAME,44))     /* Backup name             */
  if pos(left(rcvtbdsn,1),'ABCDEFGHIJKLMNOPQRSTUVWXYZ@#$') = 0
     then rcvtbdsn = ''                                       /* @AT */
  if (rcvtbdsn = "") THEN                                     /* @AT */
     rcvtbdsn = "N/A"                                         /* @AT */
RETURN                                                        /* @A9 */
/*--------------------------------------------------------------------*/
/*  Get PASSPHRASE setting                                       @AF  */
/*--------------------------------------------------------------------*/
GET_PASSPHRASE:                                               /* @AF */
  cmd    = "PARMLIB LIST(LOGON)"                              /* @AF */
  x = outtrap('var.')                                         /* @AF */
  Address TSO cmd                                             /* @AF */
  cmd_rc = rc                                                 /* @AF */
  x = outtrap('off')                                          /* @AF */
  if (cmd_rc > 0) then return                                 /* @AF */
  Do i = 1 to var.0                                           /* @AF */
     parse var var.i 'PASSPHRASE(' pphrase ')'                /* @AF */
     if (pphrase = 'ON') | (pphrase = 'OFF') then leave       /* @AF */
  end                                                         /* @AF */
RETURN                                                        /* @AF */
/*--------------------------------------------------------------------*/
/*  Add the data to the table                                    @AE  */
/*--------------------------------------------------------------------*/
ADD_T:                                                        /* @AE */
  parse arg desc 34 value .                                   /* @AE */
  desc  = strip(desc)                                         /* @AE */
  descu = translate(desc)                                     /* @AG */
  value = strip(value)                                        /* @AE */
  'tbadd' TABLEA                                              /* @AE */
RETURN                                                        /* @AE */
/*--------------------------------------------------------------------*/
/*  Build the Table with the RACF Information                    @AE  */
/*--------------------------------------------------------------------*/
CREATE_TABLEA:                                                /* @AE */
  'tbcreate' TABLEA 'names(desc,descu,value) nowrite'         /* @AE */
  call add_t  'Audit operations                 'RCVTSAUO     /* @AE */
  call add_t  'Audit special                    'RCVTSAUS     /* @AE */
  call add_t  'Audit APPC transactions          'RCVTSAPL     /* @AJ */
  call add_t  'Catalogued datasets only         'RCVTSCAT     /* @AE */
  call add_t  'Data Base Backup                 'RCVTBDSN     /* @AE */
  call add_t  'Data Base Primary                'RCVTPDSN     /* @AE */
  call add_t  'Dataset protection               'RCVTSADS     /* @AE */
  call add_t  'Duplicate datasets               'RCVTNDUP     /* @AE */
  call add_t  'DASD volume protection           'RCVTDVPR     /* @AE */
  call add_t  'Enhanced generic naming          'RCVTSEGN     /* @AE */
  call add_t  'Erase on scratch                 'RCVTSEOS     /* @AE */
  call add_t  'FMID                             'RCVTFMID     /* @AX */
  call add_t  'Generic owner                    'RCVTSGNO     /* @AE */
  call add_t  'Generic prof chk (DATASET class) 'RCVTDGEN     /* @AY */
  call add_t  'Generic cmd proc (DATASET class) 'RCVTDGCM     /* @AY */
  call add_t  'Initialize statistics            'RCVTNLS      /* @AH */
  call add_t  'JES batch all                    'RCVTJALL     /* @AE */
/*call add_t  'JES early verify                 'RCVTJCHK  */ /* @AM */
  call add_t  'JES undefined userid             'RCVTJUND     /* @AE */
  call add_t  'JES NJE userid                   'RCVTJSYS     /* @AE */
  call add_t  'JES XBM all                      'RCVTJXAL     /* @AE */
  call add_t  'List groups access checking      'RCVTSGRC     /* @AE */
  call add_t  'LU session interval              'RCVTSLUI     /* @AE */
  call add_t  'Model groups                     'RCVTMGRP     /* @AE */
  call add_t  'Model users                      'RCVTMUSR     /* @AE */
  call add_t  'Model GDG                        'RCVTMGDG     /* @AE */
  call add_t  'Multi factor authentication      'RCVTMFA      /* @AH */
  call add_t  'Multi-level active               'RCVTSMLA     /* @AJ */
  call add_t  'Multi-level quiet                'RCVTSMLQ     /* @AE */
  call add_t  'Multi-level secure               'RCVTSMLT     /* @AE */
  call add_t  'Multi-level stable               'RCVTSMLS     /* @AE */
  call add_t  'Password attempts                'RCVTPRVK     /* @AE */
  call add_t  'Password extended support        'RCVTXPWD     /* @AE */
  call add_t  'Password history                 'RCVTPHIS     /* @AE */
  call add_t  'Password interval                'RCVTPINV     /* @AE */
  call add_t  'Password lower case allowed      'RCVTPLC      /* @AH */
  call add_t  'Password maximum length          'RCVTELEN     /* @AE */
  call add_t  'Password minimum change interval 'RCVTPMIN     /* @AO */
  call add_t  'Password minimum length          'RCVTSLEN     /* @AE */
  call add_t  'Password phrase                  'PPHRASE      /* @AF */
  call add_t  'Password rules                   'RCVTRULS     /* @AE */
  call add_t  'Password special chars allowed   'RCVTPSC      /* @AH */
  call add_t  'Password warning                 'RCVTPWRN     /* @AE */
  call add_t  'Protect all                      'RCVTSPRA     /* @AE */
  call add_t  'Retention period                 'RCVTSRPE     /* @AE */
  call add_t  'Security label audit             'RCVTSSLA     /* @AE */
  call add_t  'Security level control           'RCVTSSLC     /* @AE */
  call add_t  'Single level prefix              'RCVTQUAL     /* @AE */
  call add_t  'Tape dataset protection          'RCVTTDPR     /* @AE */
  call add_t  'Tape volume protection           'RCVTTVPR     /* @AE */
  call add_t  'Terminal authority               'RCVTTAUT     /* @AE */
  call add_t  'Terminal UACC                    'RCVTTUAC     /* @AE */
  call add_t  'Userid inactive                  'RCVTPINA     /* @AE */
  call add_t  'UADS dataset                     'RCVTUADS     /* @AI */
  call add_t  'UADS volume                      'RCVTUVOL     /* @AE */
  call add_t  'Version                          'RCVTGRNM     /* @AE */
  call add_t  'When program                     'RCVTSWHE     /* @AE */
  CLRDESC = "TURQ" ; CLRVALU = "GREEN"  /* COL COLORS */      /* @AG */
  'TBSort' TABLEA 'Fields('sort')'                            /* @AG */
RETURN                                                        /* @AE */
/*--------------------------------------------------------------------*/
/*  Save table to dataset                                        @AP  */
/*--------------------------------------------------------------------*/
DO_SAVE:                                                      /* @AP */
  X = MSG("OFF")                                              /* @AP */
  "ADDPOP COLUMN(40)"                                         /* @AP */
  "VGET (RACFSDSN RACFSMBR RACFSFIL RACFSREP) PROFILE"        /* @AQ */
  IF (RACFSDSN = "") THEN         /* SAve - Dataset Name  */  /* @AR */
     RACFSDSN = USERID()".RACFADM.REPORTS"                    /* @EK */
  IF (RACFSFIL = "") THEN         /* SAve - As (TXT/CVS)  */  /* @AR */
     RACFSFIL = "T"                                           /* @EL */
  IF (RACFSREP = "") THEN         /* SAve - Replace (Y/N) */  /* @AR */
     RACFSREP = "N"                                           /* @EK */
                                                              /* @AP */
  DO FOREVER                                                  /* @AP */
     "DISPLAY PANEL("PANELS1")"                               /* @AP */
     IF (RC = 08) THEN DO                                     /* @AP */
        "REMPOP"                                              /* @AP */
        RETURN                                                /* @AP */
     END                                                      /* @AP */
     RACFSDSN = STRIP(RACFSDSN,,"'")                          /* @AP */
     RACFSDSN = STRIP(RACFSDSN,,'"')                          /* @AP */
     RACFSDSN = STRIP(RACFSDSN)                               /* @AP */
     SYSDSORG = ""                                            /* @AP */
     X = LISTDSI("'"RACFSDSN"'")                              /* @AP */
     IF (SYSDSORG = "") | (SYSDSORG = "PS"),                  /* @AP */
      | (SYSDSORG = "PO") THEN                                /* @AP */
        NOP                                                   /* @AP */
     ELSE DO                                                  /* @AP */
        RACFSMSG = "Not PDS/Seq File"                         /* @AP */
        RACFLMSG = "The dataset specified is not",            /* @AP */
                  "a partitioned or sequential",              /* @AP */
                  "dataset, please enter a valid",            /* @AP */
                  "dataset name."                             /* @AP */
       "SETMSG MSG(RACF011)"                                  /* @AP */
       ITERATE                                                /* @AP */
     END                                                      /* @AP */
     IF (SYSDSORG = "PS") & (RACFSMBR <> "") THEN DO          /* @AP */
        RACFSMSG = "Seq File - No mbr"                        /* @AP */
        RACFLMSG = "This dataset is a sequential",            /* @AP */
                  "file, please remove the",                  /* @AP */
                  "member name."                              /* @AP */
       "SETMSG MSG(RACF011)"                                  /* @AP */
       ITERATE                                                /* @AP */
     END                                                      /* @AP */
     IF (SYSDSORG = "PO") & (RACFSMBR = "") THEN DO           /* @AP */
        RACFSMSG = "PDS File - Need Mbr"                      /* @AP */
        RACFLMSG = "This dataset is a partitioned",           /* @AP */
                  "dataset, please include a member",         /* @AP */
                  "name."                                     /* @AP */
       "SETMSG MSG(RACF011)"                                  /* @AP */
       ITERATE                                                /* @AP */
     END                                                      /* @AP */
                                                              /* @AP */
     IF (RACFSMBR = "") THEN                                  /* @AP */
        TMPDSN = RACFSDSN                                     /* @AP */
     ELSE                                                     /* @AP */
        TMPDSN = RACFSDSN"("RACFSMBR")"                       /* @AP */
     DSNCHK = SYSDSN("'"TMPDSN"'")                            /* @AP */
     IF (DSNCHK = "OK" & RACFSREP = "N") THEN DO              /* @AP */
        RACFSMSG = "DSN/MBR Exists"                           /* @AP */
        RACFLMSG = "Dataset/member already exists. ",         /* @AP */
                  "Please type in "Y" to replace file."       /* @AP */
        "SETMSG MSG(RACF011)"                                 /* @AP */
        ITERATE                                               /* @AP */
     END                                                      /* @AP */
     LEAVE                                                    /* @AP */
  END                                                         /* @AP */
  "REMPOP"                                                    /* @AP */
  "VPUT (RACFSDSN RACFSMBR RACFSFIL RACFSREP) PROFILE"        /* @AQ */
                                                              /* @AP */
ADDRESS TSO                                                   /* @AP */
  IF (RACFSREP = "Y" & RACFSMBR = "") |,                      /* @AP */
     (DSNCHK <> "OK" & DSNCHK <> "MEMBER NOT FOUND"),         /* @AP */
     THEN DO                                                  /* @AP */
     "DELETE '"RACFSDSN"'"                                    /* @AP */
     IF (RACFSMBR = "") THEN                                  /* @AP */
        "ALLOC  FI(ISPFILE) DA('"RACFSDSN"') NEW",            /* @AP */
            "REUSE SP(1 1) CYLINDER UNIT(SYSALLDA)",          /* @AS */
            "LRECL(80) RECFM(F B)"                            /* @AP */
     ELSE                                                     /* @AP */
        "ALLOC  FI(ISPFILE) DA('"RACFSDSN"') NEW",            /* @AP */
            "REUSE SP(1 1) CYLINDER UNIT(SYSALLDA)",          /* @AS */
            "LRECL(80) RECFM(F B)",                           /* @AP */
            "DSORG(PO) DSNTYPE(LIBRARY,2)"                    /* @AP */
  END                                                         /* @AP */
  ELSE                                                        /* @AP */
     "ALLOC  FI(ISPFILE) DA('"RACFSDSN"') SHR REUSE"          /* @AP */
                                                              /* @AP */
ADDRESS ISPEXEC                                               /* @AP */
  "FTOPEN"                                                    /* @AP */
  "FTINCL "TMPSKELT                                           /* @AP */
  IF (RACFSMBR = "") THEN                                     /* @AP */
     "FTCLOSE"                                                /* @AP */
  ELSE                                                        /* @AP */
     "FTCLOSE NAME("RACFSMBR")"                               /* @AP */
  ADDRESS TSO "FREE FI(ISPFILE)"                              /* @AP */
                                                              /* @AP */
  SELECT                                                      /* @AP */
     WHEN (SETGDISP = "VIEW") THEN                            /* @AP */
          "VIEW DATASET('"RACFSDSN"') MACRO("EDITMACR")"      /* @AP */
     WHEN (SETGDISP = "EDIT") THEN                            /* @AP */
          "EDIT DATASET('"RACFSDSN"') MACRO("EDITMACR")"      /* @AP */
     OTHERWISE                                                /* @AP */
          "BROWSE DATASET('"RACFSDSN"')"                      /* @AP */
  END                                                         /* @AP */
  X = MSG("ON")                                               /* @AP */
                                                              /* @AP */
RETURN                                                        /* @AP */
