/*%NOCOMMENT====================* REXX *==============================*/
/*  PURPOSE:  RACFADM - ISPLog/Standards/Updates - Opts L, S, U (I)   */
/*--------------------------------------------------------------------*/
/* FLG  YYMMDD  USERID   DESCRIPTION                                  */
/* ---  ------  -------  -------------------------------------------- */
/* @AL  200616  RACFA    Chg panel name RACFRPTS to RACFDISP          */
/* @AK  200524  TRIDJK   Fixed displaying error message               */
/* @AJ  200519  TRIDJK   Support ISPLOG SYSOUT datasets - SDSF/(E)JES */
/* @AI  200511  RACFA    Place most current records at top of file    */
/* @AH  200506  RACFA    Display headers in a different color         */
/* @AG  200504  RACFA    Make long msg more meaningful                */
/* @AF  200504  RACFA    Added the capability to view ISPLOG file     */
/* @AE  200423  RACFA    Move PARSE REXXPGM name up above IF SETMTRAC */
/* @AD  200423  RACFA    Ensure REXX program name is 8 chars long     */
/* @AC  200422  RACFA    Fixed displaying error message               */
/* @AB  200413  RACFA    Chg TRACEing to only display banner (P=Pgms) */
/* @AA  200412  RACFA    Chg TRACE to allow 'L'abels or 'R'esults     */
/* @A9  200402  RACFA    Issue message if no LIBDEF ISPPLIB dataset   */
/* @A8  200401  RACFA    Chged edit macro RACFLOGE to RACFEMAC        */
/* @A7  200303  RACFA    Def/use variable for edit macro              */
/* @A6  200303  RACFA    Renamed edit macro to RACFDSPE, was RACFCHGE */
/* @A5  200303  RACFA    Receive member as a parmater                 */
/* @A4  200303  RACFA    Renamed mbr to RACFDSP, was RACFCHGS         */
/* @A3  200221  RACFA    Make 'ADDRESS ISPEXEC' defualt, reduce code  */
/* @A2  200220  RACFA    Added SETMTRAC=YES, then TRACE R             */
/* @A1  200220  RACFA    Added capability to browse/edit/view file    */
/* @A0  200218  RACFA    Created REXX                                 */
/*====================================================================*/
PANEL01     = "RACFDISP"   /* Display report with colors   */ /* @AL */
EDITMACR    = "RACFEMAC"   /* Edit Macro, turn HILITE off  */ /* @A8 */
parse source . . REXXPGM .         /* Obtain REXX pgm name */ /* @AE */
REXXPGM     = LEFT(REXXPGM,8)                                 /* @AE */

ADDRESS ISPEXEC                                               /* @A3 */
  PARSE ARG MEMBER                                            /* @A5 */
  "VGET (SETGDISP SETMTRAC) PROFILE"                          /* @A2 */
  If (SETMTRAC <> 'NO') then do                               /* @AA */
     Say "*"COPIES("-",70)"*"                                 /* @AA */
     Say "*"Center("Begin Program = "REXXPGM,70)"*"           /* @AA */
     Say "*"COPIES("-",70)"*"                                 /* @AA */
     if (SETMTRAC <> 'PROGRAMS') THEN                         /* @AB */
        interpret "Trace "SUBSTR(SETMTRAC,1,1)                /* @AA */
  end                                                         /* @AA */
  IF (member = "ISPLOG") THEN                                 /* @AF */
     CALL ISPLOG_FILE                                         /* @AF */
  ELSE                                                        /* @AF */
     CALL LOG_FILE

  If (SETMTRAC <> 'NO') then do                               /* @AA */
     Say "*"COPIES("-",70)"*"                                 /* @AA */
     Say "*"Center("End Program = "REXXPGM,70)"*"             /* @AA */
     Say "*"COPIES("-",70)"*"                                 /* @AA */
  end                                                         /* @AA */
EXIT                                                          /* @AA */
/*--------------------------------------------------------------------*/
/*  Display the Change or Issues Log file                             */
/*--------------------------------------------------------------------*/
LOG_FILE:
  "QLIBDEF ISPPLIB TYPE(DATASET) ID(DSNAME)"
  if (RC > 0) then do                                         /* @A9 */
     call RACFMSGS ERR19                                      /* @AC */
     return                                                   /* @AA */
  end                                                         /* @A9 */
  DSNAME = "'"STRIP(DSNAME,,"'")"("MEMBER")'"                 /* @A5 */

  SELECT                                                      /* @A1 */
     WHEN (SETGDISP = "VIEW") THEN                            /* @A1 */
          "VIEW DATASET("DSNAME") MACRO("EDITMACR")",         /* @AH */
               "PANEL("PANEL01")"                             /* @AH */
     WHEN (SETGDISP = "EDIT") THEN                            /* @A1 */
          "EDIT DATASET("DSNAME") MACRO("EDITMACR")",         /* @AH */
               "PANEL("PANEL01")"                             /* @AH */
     OTHERWISE                                                /* @A1 */
          "BROWSE DATASET("DSNAME")"                          /* @A1 */
  END                                                         /* @A1 */
RETURN                                                        /* @AA */
/*--------------------------------------------------------------------*/
/*  Display the ISPLog file                                      @AF  */
/*--------------------------------------------------------------------*/
ISPLOG_FILE:                                                  /* @AF */
  RECIN.0 = 0                                                 /* @AK */
  "VGET (ZLOGNAME)"                                           /* @AJ */
  If right(zlogname,2) = '.?' then        /* SYSOUT? */       /* @AJ */
     Call DO_ISFCALLS                                         /* @AJ */
  else                                                        /* @AJ */
     Call ISPLOG_ISPF                                         /* @AJ */
                                                              /* @AI */
  IF (RECIN.0 = 0) THEN DO                                    /* @AK */
     RACFSMSG = ""                                            /* @AF */
     RACFLMSG = "The ISPF Log file is not allocated or",      /* @AF */
                "may not have been written to.  Verify",      /* @AF */
                "ISPF Settings (=0), 'Log/List',",            /* @AG */
                "'1. Log Data set defaults', has primary",    /* @AG */
                "and secondary pages.  If not, suggest",      /* @AG */
                "making 'Primary pages = 10' and",            /* @AG */
                "'Secondary pages = 10', then",               /* @AG */
                "terminate and re-invoke ISPF."               /* @AG */
     'setmsg msg(RACF011)'                                    /* @AF */
     RETURN                                                   /* @AK */
  END                                                         /* @AK */

  K = 0                                                       /* @AI */
  DO J = RECIN.0 To 1 by -1                                   /* @AI */
     K = K + 1                                                /* @AI */
     RECOUT.K = RECIN.J                                       /* @AI */
  END                                                         /* @AI */
  RECOUT.0 = K                                                /* @AI */
  DROP RECIN.

  ADDRESS TSO "ALLOC F("DDNAME") NEW REUSE",                  /* @AI */
              "LRECL(125) BLKSIZE(0) RECFM(V B A)",           /* @AI */
              "UNIT(VIO) SPACE(1 5) CYLINDERS"                /* @AI */
  ADDRESS TSO "EXECIO * DISKW "DDNAME" (STEM RECOUT. FINIS"   /* @AI */
  DROP RECOUT.                                                /* @AI */
                                                              /* @AI */
  "LMINIT DATAID(DATAID) DDNAME("DDNAME")"                    /* @AI */
  SELECT                                                      /* @AI */
     WHEN (SETGDISP = "VIEW") THEN                            /* @AI */
          "VIEW DATAID("DATAID") MACRO("EDITMACR")",          /* @AI */
               "PANEL("PANEL01")"                             /* @AH */
     WHEN (SETGDISP = "EDIT") THEN                            /* @AI */
          "EDIT DATAID("DATAID") MACRO("EDITMACR")",          /* @AI */
               "PANEL("PANEL01")"                             /* @AH */
     OTHERWISE                                                /* @AI */
          "BROWSE DATAID("DATAID")"                           /* @AI */
  END                                                         /* @AI */
  ADDRESS TSO "FREE FI("DDNAME")"                             /* @AI */
                                                              /* @AF */
RETURN                                                        /* @AF */
/*--------------------------------------------------------------------*/
/*  Obtain the ISPF log file using ISPF                          @AJ  */
/*--------------------------------------------------------------------*/
ISPLOG_ISPF:                                                  /* @AJ */
  "VGET (ZLOGNAME)"                                           /* @AF */
  IF (ZLOGNAME = "") THEN DO                                  /* @AF */
     return                                                   /* @AF */
  END                                                         /* @AF */
                                                              /* @AF */
  "SELECT PGM(ISPLLP) PARM(LOG KEEP) SUSPEND"                 /* @AF */
                                                              /* @AF */
  ADDRESS TSO "ALLOC FI("DDNAME") DA('"ZLOGNAME"') SHR REUS"  /* @AF */
  IF (RC > 0) THEN DO                                         /* @AF */
     RACFSMSG = ""                                            /* @AF */
     RACFLMSG = "Unable to allocate the ISPF log file:",      /* @AF */
                 ZLOGNAME".  Please investigate."             /* @AF */
     'setmsg msg(RACF011)'                                    /* @AF */
     return                                                   /* @AF */
  END                                                         /* @AF */
                                                              /* @AI */
  ADDRESS TSO "EXECIO * DISKR "DDNAME" (STEM RECIN. FINIS"    /* @AI */
  ADDRESS TSO "FREE FI("DDNAME")"                             /* @AI */
                                                              /* @AI */
RETURN
/*--------------------------------------------------------------------*/
/*  Check for ISPLOG SYSOUT                                      @AJ  */
/*--------------------------------------------------------------------*/
DO_ISFCALLS:                                                  /* @AJ */
  rc=isfcalls('ON')                                           /* @AJ */
  /*-----------------------------*/                           /* @AJ */
  /*  Access the STATUS display  */                           /* @AJ */
  /*-----------------------------*/                           /* @AJ */
  Address SDSF "ISFEXEC ST "userid()                          /* @AJ */
  /*-------------------*/                                     /* @AJ */
  /*  Find TSO Userid  */                                     /* @AJ */
  /*-------------------*/                                     /* @AJ */
  do ix=1 to JNAME.0                                          /* @AJ */
     if JNAME.ix = userid() & ,                               /* @AJ */
        QUEUE.ix = "EXECUTION" & ,                            /* @AJ */
        ACTSYS.ix <> "" then do                               /* @AJ */
        /*-----------------------------------------*/         /* @AJ */
        /*  Issue the ? (JDS) action against the   */         /* @AJ */
        /*  row to list the data sets in the job.  */         /* @AJ */
        /*-----------------------------------------*/         /* @AJ */
        Address SDSF "ISFACT ST TOKEN('"TOKEN.ix"')",         /* @AJ */
                     "PARM(NP ?) ( prefix jds_"               /* @AJ */
        /*---------------------------------------------*/     /* @AJ */
        /*  Find the ISPLOG data sets and read them    */     /* @AJ */
        /*  using ISFBROWSE.  Use isflinelim to limit  */     /* @AJ */
        /*  the number of REXX variables returned.     */     /* @AJ */
        /*---------------------------------------------*/     /* @AJ */
        isflinelim=5000                                       /* @AJ */
        ky = 1                                                /* @AJ */
        racfadm. = ''                                         /* @AJ */
        do jx=1 to jds_DDNAME.0                               /* @AJ */
           if left(jds_DDNAME.jx,6) = "ISPLOG" then do        /* @AJ */
              /*---------------------------------------*/     /* @AJ */
              /*  Read the records from the data set.  */     /* @AJ */
              /*---------------------------------------*/     /* @AJ */
              do until isfnextlinetoken=''                    /* @AJ */
                 Address SDSF "ISFBROWSE ST",                 /* @AJ */
                              "TOKEN('"jds_TOKEN.jx"')"       /* @AJ */
                 do kx=1 to isfline.0                         /* @AJ */
                    recin.ky = isfline.kx                     /* @AJ */
                    ky = ky + 1                               /* @AJ */
                 end                                          /* @AJ */
                 recin.0 = ky - 1                             /* @AJ */
                 /*-----------------------------*/            /* @AJ */
                 /*  Set start for next browse  */            /* @AJ */
                 /*-----------------------------*/            /* @AJ */
                 isfstartlinetoken = isfnextlinetoken         /* @AJ */
              end                                             /* @AJ */
           end                                                /* @AJ */
        end                                                   /* @AJ */
     end                                                      /* @AJ */
  end                                                         /* @AJ */
  rc=isfcalls('OFF')                                          /* @AJ */
RETURN                                                        /* @AJ */
