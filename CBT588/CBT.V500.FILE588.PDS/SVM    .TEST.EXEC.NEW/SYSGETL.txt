/* REXX --------- Read task response from SYSLOG -------------
|
| 06/24/03 SVM Added SDSF check for running under sub=MSTR
| 06/05/03 SVM Added search SDSF output by taskname
| 05/05/03 SVM Added check if SDSF is active (good for shutdown)
| 02/25/03 SVM Created
|
| Called by SYSCNTL exec to read the response for console command
|        issued by SYSCNTL in case when GETMSG does not work.
|        Uses SDSF batch call. See security settings below.
|
| Input parm:
|        command issued to console
|        Example: 'F ROSCOE,STATUSX'
|
| Output:
|        string = 'rc |line1|line2|...|linen'
|        rc = 0 if at least 1 line was found
|        otherwise rc = 4
|        each line or command response is separated by '|'.
|
| SDSF security setting example:
|                To set a proper authorisation you might need a
|                ISFPRM00 member in system PARMLIB.
|                It must define a user group that has authority
|                to use SDSF in batch, for example:
|                   GROUP NAME(ISFBATC2),    /* define group       */
|                   ILPROC(BATCH),           /* NTBL name          */
|                   IUID(SYSPRGS),           /* NTBL name          */
|                   AUTH(I,O,H,DA,ST,SE,PREF,LOG), /* funct allowed*/
|                   CMDLEV(2),               /* command level      */
|                   OWNER(USERID)            /* deafult owner      */
|
|                and definition for included logon procedures:
|                   NTBL NAME(SYSPRGS)
|                     NTBLENT STRING(CHKTASK),OFFSET(1)
|                     ... other sysprogs ...
|                   NTBL NAME(BATCH)         /* referred by GROUP  */
|                     NTBLENT STRING(AFD)    /* for PGM=ISFAFD     */
|                     NTBLENT STRING(BATCH)  /* for PGM=SDSF       */
|        Having modified ISFPRM00 issue F SDSF,REFRESH
|
|        References:
|                OS/390 V2R10.0 SDSF Customization and Security
| Externals:
|        EXECs: PWX, SYSACTV; LINKs: SDSF
*/
 Arg sample                            /* Sample command to search   */
 #p = 'SYSGETL:'                       /* message prefix             */
 sdsf = 'SDSF'                         /* name of SDSF started task  */
 sep = '|'                             /* separator (see SYSCNTL     */
 logfile = 'LOGFILE'                   /* ddname for SDSF work file  */
 isfin = 'ISFIN'                       /* ddname for SDSF input file */
 errc = 4                              /* RC if nothing found        */
 par = 'WHO|OWNER|LOG S|PRT FILE '||logfile||'|PRT * 999|PRT CLOSE'
                                       /* SDSF read SYSLOG commands  */
 sdsfid = SYSACTV(sdsf)
 /* Say #p 'SYSACTV(SDSF)='par */
 If sdsfid = '0' Then Do
    /* SDSF is not active */
    Say #p 'SDSF task is not active - cannot read SYSLOG'
    RETURN(errc)
    End
 If sdsfid = '1' Then Do
    /* SDSF jes jobid not available - jes functions not available */
    Say #p 'SDSF not available - cannot read SYSLOG'
    RETURN(errc)
    End

 Call PWX(isfin par)
 Address LINK "SDSF"
 "EXECIO * DISKR" logfile "(STEM #log. FINIS"
 Say #p #log.0 'records read from' logfile
 lsample = "LENGTH"(sample)
 par = ''
 i0 = 0

 /* first try to find by task's jobid: */
 taskname = "WORD"("TRANSLATE"(sample,' ',','),2)
 jobidx = SYSACTV(taskname)
 If jobidx <> '0' & jobidx <> '1' Then Do
    Say #p 'search' jobidx
    Do i = 1 To #log.0
       Parse Value #log.i With 38 jobid 46 junk 57 #log1.i
       If jobid = jobidx Then Do
          par = par||sep||#log1.i
          i0 = i0 + 1
          End
       End
    End
 If i0 > 0 Then Signal END

 /* else try to find what immediately follows the command: */
 found = 0
 jobid0 = ''
 Do i = #log.0 By -1 To 1
    found = (sample = "LEFT"(#log.i,lsample))
    If found Then Leave /* last occurence found in line i */
    End
 If found Then Do
    Do i = i + 1 To #log.0
       Parse Value #log.i With 38 jobid 46 junk 57 #log.i
       If jobid0 = '' Then Do
          jobid0 = jobid
          Say #p 'found' jobid0
          End
       If jobid = jobid0 Then Do
          par = par||sep||#log.i
          i0 = i0 + 1
          End
       End
    End

 END:
 If par <> '' Then par = '0' par
 Else par = errc
 Say #p i0 'lines returned from SYSLOG'
 Return(par)
