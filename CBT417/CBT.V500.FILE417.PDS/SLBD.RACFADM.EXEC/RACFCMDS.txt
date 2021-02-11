/*%NOCOMMENT====================* REXX *==============================*/
/*  PURPOSE:  RACFADM - Execute RACF Commands - Menu option C         */
/*--------------------------------------------------------------------*/
/*  NOTES:    1) This REXX program will save the commands entered     */
/*               into the user's dataset allocated to ISPTABLE or     */
/*               ISPPROF in member RACFCMDS                           */
/*--------------------------------------------------------------------*/
/* FLG  YYMMDD  USERID   DESCRIPTION                                  */
/* ---  ------  -------  -------------------------------------------- */
/* @AA  200913  LBD      Display RACF command in flower box at top    */
/* @A9  200628  RACFA    Added parm GEN to LISTDSD command            */
/* @A8  200619  RACFA    Initalize the variable NULL                  */
/* @A7  200519  TRIDJK   Allow logging of RACF commands               */
/* @A6  200430  RACFA    Added skeleton RACF commands to table        */
/* @A5  200430  RACFA    Place table name in variable at top of REXX  */
/* @A4  200429  RACFA    Standardize ddname, etc.                     */
/* @A3  200429  RACFA    Chk Setting's 'REXX trace'                   */
/* @A2  200429  RACFA    Chg HELP PF-Key to invoke 'TSO RACFHELP'     */
/* @A1  200429  RACFA    Get Settings (Opt 0) 'Display files' to view */
/* @A0  200429  LBD      Created REXX                                 */
/*====================================================================*/
PANEL01     = "RACFCMDS"   /* Execute RACF command         */ /* @A1 */
PANELM2     = "RACFMSG2"   /* Display RACF command and RC  */ /* @A7 */
EDITMACR    = "RACFEMAC"   /* Edit Macro, turn HILITE off  */ /* @A1 */
DDNAME      = 'RACFA'RANDOM(0,999) /* Unique ddname        */
TABLE       = "RACFACMD"   /* Permanent table in ISPPROF   */ /* @A5 */
RACFCMDS.   = ""                                              /* @A6 */
RACFCMDS.0  = 7            /* Populate table w/ RACF cmds  */ /* @A6 */
RACFCMDS.1  = "LU ?        CICS CSDATA DCE DFP EIM KERB",     /* @A6 */
              "LANGUAGE LNOTES MFA NDS NETVIEW OMVS",         /* @A6 */
              "OPERPARM OVM PROXY TSO WORKATTR"               /* @A6 */
RACFCMDS.2  = "LG ?        CSDATA DFP OMVS OVM TME"           /* @A6 */
RACFCMDS.3  = "LISTDSD DATASET('"?"                  ')",     /* @A6 */
              "ALL GEN"                                       /* @A9 */
RACFCMDS.4  = "RL ?        * ALL"                             /* @A6 */
RACFCMDS.5  = "RL ?        ?        AUTH"                     /* @A6 */
RACFCMDS.6  = "SEARCH CLASS(?       ) USER(?       )"         /* @A6 */
RACFCMDS.7  = "SETROPTS LIST"                                 /* @A6 */
NULL        = ''                                              /* @A8 */
parse source . . REXXPGM .         /* Obtain REXX pgm name */ /* @A3 */
REXXPGM     = LEFT(REXXPGM,8)                                 /* @A3 */

ADDRESS ISPEXEC
  "VGET (SETGDISP SETMSHOW SETMTRAC) PROFILE"                 /* @A7 */
  If (SETMTRAC <> 'NO') then do                               /* @A3 */
     Say "*"COPIES("-",70)"*"                                 /* @A3 */
     Say "*"Center("Begin Program = "REXXPGM,70)"*"           /* @A3 */
     Say "*"COPIES("-",70)"*"                                 /* @A3 */
     if (SETMTRAC <> 'PROGRAMS') THEN                         /* @A3 */
        interpret "Trace "SUBSTR(SETMTRAC,1,1)                /* @A3 */
  end                                                         /* @A3 */
  "VGET (ZPF01 ZPF02 ZPF03 ZPF04 ZPF05 ZPF06 ZPF07 ZPF08",    /* @A2 */
         ZPF09 ZPF10 ZPF11 ZPF12 ZPF13 ZPF14 ZPF15 ZPF16",    /* @A2 */
         ZPF17 ZPF18 ZPF19 ZPF20 ZPF21 ZPF22 ZPF23 ZPF24)"    /* @A2 */
  DO J = 1 TO 24                                              /* @A2 */
     K = RIGHT(J,2,0)                                         /* @A2 */
     INTERPRET "PFKEY = ZPF"K                                 /* @A2 */
     UPPER PFKEY                                              /* @A2 */
     IF (PFKEY = "HELP") THEN DO                              /* @A2 */
        INTERPRET "ZPF"K" = 'TSO RACFHELP'"                   /* @A2 */
        "VPUT (ZPF"K")"                                       /* @A2 */
     END                                                      /* @A2 */
  END                                                         /* @A2 */

  parse arg cmd

  parse value '' with null rcsel
  /* ---------------------------------------------------- *
  | Set ISPExec                                          |
  | Get the ISPF vars from ZIGI for localrep and zigirep |
  | Define localdir as a composite variable              |
  * ---------------------------------------------------- */
  'Control Errors Return'

  /* -------------------------------------------------- *
  | Check to see if the user has ISPTABL allocated and |
  | if not then use ISPPROF as our table DD            |
  * -------------------------------------------------- */
  isptabl = 'ISPTABL'
  x = listdsi(isptabl 'FILE')
  if (x > 0) then isptabl = 'ISPPROF'

  /* ----------------------------------------------------- *
  | Open the table but if it doesn't exist then create it |
  * ----------------------------------------------------- */
  'TBOpen 'table' Library('isptabl') Write Share'             /* @A5 */
  if (rc > 0) then do
     'tbcreate 'table' keys(racfcmde)',                       /* @A5 */
              'library('isptabl') write share'
      call populate
  end

  /* -------------------- *
  | Setup table defaults |
  * -------------------- */
  ztdtop = 0
  ztdsels = 0

  /* ---------------------------------------------------------------- *
  | Process the table.                                               |
  |                                                                  |
  | Row selections:  S to copy the command to the git command  entry |
  |                  D to delete the command (supports multipe row   |
  |                    selections)                                   |
  |                  X to execute the command now and update the     |
  |                    git command entry field                       |
  * ---------------------------------------------------------------- */
  do forever
     if (ztdsels = 0) then do
        'tbtop   'table                                       /* @A5 */
        'tbskip  'table' number('ztdtop')'                    /* @A5 */
        'tbdispl 'table' panel('panel01') cursor(racfcmd)'    /* @A5 */
     end
     else
        'tbdispl racfacmd'
     if (rc > 4) then leave
     if (row = 0) then rcsel = null
     if (row <> null) then
        if (row > 0) then do
          'TBTop  'table                                      /* @A5 */
          'TBSkip 'table' Number('row')'                      /* @A5 */
        end
     Select
        When (zcmd = 'CLEAR') then do
             'tbclose  'table' replcopy library('isptabl')'   /* @A5 */
             'tberase  'table' library('isptabl')'            /* @A5 */
             'tbcreate 'table' keys(racfcmde)',               /* @A5 */
                      'library('isptabl') write share'
             racfcmd = null
        end
        When (rcsel = 'D') then 'tbdelete 'table              /* @A5 */
        When (rcsel = 'S') then do
             racfcmd = racfcmde
             ztdsels = 0
        end
        When (rcsel = 'X') then do
             racfcmd = racfcmde
             ztdsels = 0
             call do_racfcmd
        end
        When (racfcmd /= null) then call do_racfcmd
        Otherwise nop
     end
     rcsel = null
  end

  /* -------------- *
  | Close and exit |
  * -------------- */
  'tbclose 'table' replcopy library('isptabl')'               /* @A5 */

  DO J = 1 TO 24                                              /* @A2 */
     K = RIGHT(J,2,0)                                         /* @A2 */
     INTERPRET "PFKEY = ZPF"K                                 /* @A2 */
     IF (PFKEY = "TSO RACFHELP") THEN DO                      /* @A2 */
        INTERPRET "ZPF"K" = 'HELP'"                           /* @A2 */
        "VPUT (ZPF"K")"                                       /* @A2 */
     END                                                      /* @A2 */
  END                                                         /* @A2 */

  If (SETMTRAC <> 'NO') then do                               /* @A3 */
     Say "*"COPIES("-",70)"*"                                 /* @A3 */
     Say "*"Center("End Program = "REXXPGM,70)"*"             /* @A3 */
     Say "*"COPIES("-",70)"*"                                 /* @A3 */
  end                                                         /* @A3 */
EXIT
/*--------------------------------------------------------------------*/
/*  Execute the racf command                                          */
/*--------------------------------------------------------------------*/
DO_RACFCMD:
  cmd_rc = 0                                                  /* @AA */
  racfcmde = racfcmd
  'tbadd 'table                                               /* @A5 */
  call outtrap 'so.'
  do until racfcmd = null                                     /* @AA */
     parse value racfcmd with racfcmde';'racfcmd              /* @AA */
     call racfputl '*'copies('-',70)'*'                       /* @AA */
     call racfputl '* Command:' racfcmde                      /* @AA */
     call racfputl '*'copies('-',70)'*'                       /* @AA */
     Address TSO racfcmde                                     /* @AA */
     if rc > cmd_rc then cmd_rc = rc                          /* @AA */
     end                                                      /* @AA */
  call outtrap 'off'
  cmd = racfcmde                                              /* @A7 */
  if (SETMSHOW <> 'NO') then                                  /* @A7 */
     call SHOWCMD                                             /* @A7 */
  call view_std
RETURN
/*--------------------------------------------------------------------*/
/*  Display RACF command and return code                         @A7  */
/*--------------------------------------------------------------------*/
SHOWCMD:                                                      /* @A7 */
  IF (SETMSHOW = "BOTH") | (SETMSHOW = "DISPLAY") THEN DO     /* @A7 */
     PARSE VAR CMD MSG1 60 MSG2 121 MSG3                      /* @A7 */
     MSG4 = "Return code = "cmd_rc                            /* @A7 */
     "ADDPOP ROW(6) COLUMN(4)"                                /* @A7 */
     "DISPLAY PANEL("PANELM2")"                               /* @A7 */
     "REMPOP"                                                 /* @A7 */
  END                                                         /* @A7 */
  IF (SETMSHOW = "BOTH") | (SETMSHOW = "LOG") THEN DO         /* @A7 */
     zerrsm = "RACFADM "REXXPGM" RC="cmd_rc                   /* @A7 */
     zerrlm = cmd                                             /* @A7 */
     'log msg(isrz003)'                                       /* @A7 */
  END                                                         /* @A7 */
RETURN                                                        /* @A7 */
/*--------------------------------------------------------------------*/
/*  Generalized routine to browse or view the results of the command  */
/*--------------------------------------------------------------------*/
VIEW_STD:
  stdopt = 'B'
  'Control Display Save'
  /* --------------------------------------- *
  | Get lrecl to determine dcb for temp d/s |
  * --------------------------------------- */
  vlrecl = 80
  do li  = 1 to so.0
     so.li = strip(so.li)
     if (length(so.li) > vlrecl) then vlrecl = length(so.li)
     if (so.li = null) then so.li = ' '
  end
  sec = so.0
  if (vlrecl < 81) then vlrecl = 80
  else vlrecl = vlrecl + 4
  if (vlrecl = 80) then vrecfm = 'f b'
  else vrecfm = 'v b'

  /* ------------------------------------------ *
  | Allocate a temporary data set for our data |
  * ------------------------------------------ */
Address TSO
  'Alloc f('ddname') new reuse spa(5,5) tr' ,                 /* @A4 */
        'recfm('vrecfm') lrecl('vlrecl') blksize(0)'
  stdopt = null
  /* ----------------------- *
  | Write out the stem data |
  * ----------------------- */
  if (stdopt = null) then do
     'Execio * diskw' ddname '(finis stem so.'                /* @A4 */
     drop so.
  end

  /* -------------------------------------------------- *
  | Access the Temporary Data Set using ISPF           |
  | Library Services.                                  |
  | Then using ISPF Browse service to browse the data. |
  | And use Library Services to Free the Data Set.     |
  * -------------------------------------------------- */
Address ISPExec
  if (sec > 0) then do
     'lminit dataid(ddb) ddname('ddname')'                    /* @A4 */
     SELECT                                                   /* @A1 */
        WHEN (SETGDISP = "VIEW") THEN                         /* @A1 */
             "VIEW DATAID("DDB") MACRO("EDITMACR")"           /* @A1 */
        WHEN (SETGDISP = "EDIT") THEN                         /* @A1 */
             "EDIT DATAID("DDB") MACRO("EDITMACR")"           /* @A1 */
        OTHERWISE                                             /* @A1 */
             "BROWSE DATAID("DDB")"                           /* @A1 */
     END                                                      /* @A1 */
     'lmfree dataid('ddb')'
  end

  /* ----------------------------- *
  | Last Free the z/OS Allocation |
  * ----------------------------- */
  Address TSO 'Free f('ddname')'                              /* @A4 */
  'Control Display Restore'
RETURN
/*--------------------------------------------------------------------*/
/*  Pre-Populate the command table for new user                       */
/*--------------------------------------------------------------------*/
POPULATE:
  DO J = 1 TO RACFCMDS.0
     racfcmde = RACFCMDS.J
     'tbadd 'table                                            /* @A5 */
  END
RETURN
