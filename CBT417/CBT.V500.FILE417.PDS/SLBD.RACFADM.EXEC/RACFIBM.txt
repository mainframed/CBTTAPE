/*%NOCOMMENT====================* REXX *==============================*/
/*  PURPOSE:  RACFADM - Menu options:                                 */
/*               9  IBMSys    RACF system options                     */
/*              10  IBMRRSF   RACF remote services                    */
/*              11  IBMCert   RACF certificates                       */
/*--------------------------------------------------------------------*/
/* FLG  YYMMDD  USERID   DESCRIPTION                                  */
/* ---  ------  -------  -------------------------------------------- */
/* @A4  200702  RACFA    Allow symbolics in dsname                    */
/* @A3  200525  RACFA    Allow defining pgm name in Settings (Opt 0)  */
/* @A2  200519  RACFA    Remove single quotes from datasets           */
/* @A1  200511  RACFA    Chk ISPF variables for dataset names         */
/* @A0  200510  LBD      Created REXX                                 */
/*====================================================================*/
ADDRESS ISPEXEC
  arg racfopt
  if racfopt = '' then return 8
  'VGet (SETDIBMM SETDIBMP SETDIBMS SETDIBMC',                /* @A3 */
        'SETPIBM) Profile'                                    /* @A3 */
  IF (SETPIBM = "") THEN    /* IBM Main Menu Panel */         /* @A3 */
     SETPIBM = "ICHP00"                                       /* @A3 */

  IF (SETDIBMM = "") | (SETDIBMP = ""),                       /* @A1 */
   | (CETDIBMS = "") | (SETDIBMC = "") THEN                   /* @A1 */
     CALL PROCESS_MENU_OPT                                    /* @A1 */
  ELSE DO                                                     /* @A1 */
     SETDIBMM = STRIP(SETDIBMM,,"'")                          /* @A2 */
     PARSE VAR SETDIBMM DSN1 "&" SYMBOL "." DSN2              /* @A4 */
     SYMBVAL  = MVSVAR("SYMDEF",SYMBOL)                       /* @A4 */
     SETDIBMM = DSN1""SYMBVAL""DSN2                           /* @A4 */
     IF (SYSDSN("'"SETDIBMM"'") <> "OK") THEN DO              /* @A1 */
        RACFSMSG = "Invalid - Message DSN"                    /* @A1 */
        RACFLMSG = "The message dataset does not exist,",     /* @A1 */
                   "DSN='SETDIBMM'.  Invoke Settings",        /* @A1 */
                   "(Option 0) and verify the IBM RACF",      /* @A1 */
                   "datasets defined are valid."              /* @A1 */
        "SETMSG MSG(RACF011)"                                 /* @A1 */
        EXIT                                                  /* @A1 */
     END                                                      /* @A1 */
     SETDIBMP = STRIP(SETDIBMP,,"'")                          /* @A2 */
     PARSE VAR SETDIBMP DSN1 "&" SYMBOL "." DSN2              /* @A4 */
     SYMBVAL  = MVSVAR("SYMDEF",SYMBOL)                       /* @A4 */
     SETDIBMP = DSN1""SYMBVAL""DSN2                           /* @A4 */
     IF (SYSDSN("'"SETDIBMP"'") <> "OK") THEN DO              /* @A1 */
        RACFSMSG = "Invalid - Panel DSN"                      /* @A1 */
        RACFLMSG = "The panel dataset does not exist,",       /* @A1 */
                   "DSN='SETDIBMP'.  Invoke Settings",        /* @A1 */
                   "(Option 0) and verify the IBM RACF",      /* @A1 */
                   "datasets defined are valid."              /* @A1 */
        "SETMSG MSG(RACF011)"                                 /* @A1 */
        EXIT                                                  /* @A1 */
     END                                                      /* @A1 */
     SETDIBMS = STRIP(SETDIBMS,,"'")                          /* @A2 */
     PARSE VAR SETDIBMS DSN1 "&" SYMBOL "." DSN2              /* @A4 */
     SYMBVAL  = MVSVAR("SYMDEF",SYMBOL)                       /* @A4 */
     SETDIBMS = DSN1""SYMBVAL""DSN2                           /* @A4 */
     IF (SYSDSN("'"SETDIBMS"'") <> "OK") THEN DO              /* @A1 */
        RACFSMSG = "Invalid - Skeleton DSN"                   /* @A1 */
        RACFLMSG = "The skeleton dataset does not exist,",    /* @A1 */
                   "DSN='SETDIBMS'.  Invoke Settings",        /* @A1 */
                   "(Option 0) and verify the IBM RACF",      /* @A1 */
                   "datasets defined are valid."              /* @A1 */
        "SETMSG MSG(RACF011)"                                 /* @A1 */
        EXIT                                                  /* @A1 */
     END                                                      /* @A1 */
     SETDIBMC = STRIP(SETDIBMC,,"'")                          /* @A2 */
     PARSE VAR SETDIBMC DSN1 "&" SYMBOL "." DSN2              /* @A4 */
     SYMBVAL  = MVSVAR("SYMDEF",SYMBOL)                       /* @A4 */
     SETDIBMC = DSN1""SYMBVAL""DSN2                           /* @A4 */
     IF (SYSDSN("'"SETDIBMC"'") <> "OK") THEN DO              /* @A1 */
        RACFSMSG = "Invalid - Clist DSN"                      /* @A1 */
        RACFLMSG = "The clist dataset does not exist,",       /* @A1 */
                   "DSN='SETDIBMC'.  Invoke Settings",        /* @A1 */
                   "(Option 0) and verify the IBM RACF",      /* @A1 */
                   "datasets defined are valid."              /* @A1 */
        "SETMSG MSG(RACF011)"                                 /* @A1 */
        EXIT                                                  /* @A1 */
     END                                                      /* @A1 */
     Address TSO,
     "Altlib Act App(Clist) Dataset('"SETDIBMC"')"

     "Libdef ISPMLIB Dataset ID('"SETDIBMM"') stack"
     "Libdef ISPPLIB Dataset ID('"SETDIBMP"') stack"
     "Libdef ISPSLIB Dataset ID('"SETDIBMS"') stack"

     CALL PROCESS_MENU_OPT

     "Libdef ISPMLIB"
     "Libdef ISPPLIB"
     "Libdef ISPSLIB"

     Address TSO
     "Altlib Deact app(clist)"
  END
EXIT
/*--------------------------------------------------------------------*/
/*  Display RACF Menu option                                          */
/*--------------------------------------------------------------------*/
PROCESS_MENU_OPT:
  Select
    When racfopt = 5 then 'Select Panel('SETPIBM') Opt(5)'    /* @A3 */
    When racfopt = 6 then 'Select Panel('SETPIBM') Opt(6)'    /* @A3 */
    When racfopt = 7 then 'Select Panel('SETPIBM') Opt(7)'    /* @A3 */
    Otherwise nop
  end
RETURN
