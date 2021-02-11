/* REXX System Operator functions ---- run in TSO environment -------
|
| 07/31/03 SVM Added TIME to Console command message
| 06/30/03 SVM Added STOP_REMAINING, STOP for HTTPD, OPS
|          Changed $PJES2 to authorized request.
| 06/10/03 SVM Added STOP segments for JES2 (S CHKTASK,..,SUB=MSTR ?)
| 06/03/03 SVM Added STOP segments for CICS* and DBSRV*
|          Added CHECK segment for TCPIP
| 05/23/03 SVM Added date & time to "Execution started"
| 05/05/03 SVM Replaced FWAIT by L_FWT
| 05/05/03 SVM Check if active by calling SYSACTV. WTO message
|          if task is not active
| 04/24/03 DEBS397 Added RIO
| 02/25/03 SVM Added SYSGETL call to get command response
|          from SYSLOG if #CONS cannot get it.
|          Renamed all variables to #... not to mix with user's vars.
| 02/14/03 SVM Used just writtem IRX@MGCR in REPLYIT
| 02/10/03 SVM Re-created for Operator automation
|          Proc=chktask, pgm=syscntl
| 11/20/02 SVM Created
|
| Runned by CHKTASK started task (SYS1.COMMON.PROCLIB)
|        Components involved:
|        1) CHKTASK - JCL proc for authorised started task
|        2) SYSCNTL - REXX program you are looking at
|        3) Function REXX code that is defined as REXXPARM DD
|           and executed as a part of SYSCNTL.
|        4) IRXFLOC - REXX function package that includes:
|           L_WTO, L_DOM, L_FWT
|        5) Authorised load module IRX@MGCR.
|        6) External execs: AAPWX, AAINSD, SYSGETL.
|
| Directions:
|        1) This program must be called by an authorised
|           JCL proc. The proc must be authorized in RACF to issue
|           all console commands (Modify, Stop, Cancel, Reply)
|           and CICS console conmmands.
|        2) Usually you do not modify this program. System specific
|           function code must be written in REXX and placed into a
|           PDS member defined as a REXXPARM DD statement.
|           Currently see members in SYS1.REXX.CNTL.
|           Member name is &OPTION.&SYSNAME
|           &OPTION = function name, &SYSNAME = partition name.
|           Example: SHUTPROD, CHKPROD, SHUTTEST.
|           This code will be included and executed as a part of
|           this program. Must be written in REXX,
|           some restrictions apply.
|        3) The function code can use subroutines included below
|           and/or available REXX builtin functions.
|           This program uses functions included to IRXFLOC pack
|           originally coming from CBT file 386.
|           Some functions were modified and others added to the pack.
|           IRXFLOC load module must be placed in a load library and
|           that must be defined as a STEPLIB or JOBLIB.
|           See existing code as an examples for PROD and TEST.
|        4) Stop sequences for known tasks are defined in STOP
|           subroutine below.
|           To add a new stop task code, if it is not just
|           "P taskname", that is a default,
|           someone must add a "WHEN task=" segment to STOP subroutine
|           below that defines console command(s) to stop the task.
|        5) Check sequence for known tasks are defined in CHECK
|           subroutine below.
|           To add a check for a new task, if it is not just search
|           the task in the active task list (that is default),
|           one must add a "WHEN task =" segment to CHECK subroutine.
|        6) To reply outstanding console requests use REPLYIT.
|           REPLYIT uses the value of "#request" variable
|           that must be set by the following REXX command:
|              Parse #CONS('D R,L,CN=MASTER') With #rc #request
|           before calling REPLYIT.
|           REPLYIT can work in two alternative ways:
|           1) Use IRX@MGCR external program that must run authorised.
|           This means it must be palced to
|           a LINKLIST library and included to the authpgm list
|           in IKJTSO00 member in SYS1.**.PARMLIB.
|           2) If first method is not available, uncomment job
|           submit statements in REPLYIT to start a batch job
|           that would execute REPLY commands.
|
| PARM = 'system,parm' will be parsed and available for your code
|        as variables "#system" and "#parm". Parm is optional.
|
| Externals:
|        Load: L_WTO, L_DOM, L_FWT, IRX@MGCR
|        Exec: INSD, PWX, SYSGETL, SYSACTV
|
*/
/*--------------------------------------------------------------------
| Set constants and init variables:
*/
 SIGNAL ON NOVALUE
 Arg #system ',' #parm           /* optional #parm passed to REXXPARM */
 #simulate = 0                              /* 1=simulate, 0=real     */
                                         /* can be reset by REXXPARM  */
 #wait = '3s'                               /* wait between commands  */
 #final_wait = '3s'                         /* wait before cleanup    */
 #sep = '|'                                 /* Line separator         */
 #p = #system':'                            /* optional message prefix*/
 #err.0  = '- Normal end'                   /* TSO CONSOLE codes      */
 #err.4  = '- No data returned'             /* TSO CONSOLE codes      */
 #err.8  = '- Empty command'                /* TSO CONSOLE codes      */
 #err.20 = '- Console deactivation error'   /* TSO CONSOLE codes      */
 #err.36 = '- Console authority invalid'    /* TSO CONSOLE codes      */
 #err.40 = '- Console activation error'     /* TSO CONSOLE codes      */
 #start = 1                                 /* flag 1st call to #CONS */
 # = 0                                      /* num of WHT msg on cons */
 ## = 0                                     /* num of RED msg on cons */

 Say #p 'Execution started:',
    "DATE"('W')',' "DATE"() "TIME"()
 Say #p 'Parameters passed:'
 Say '  #system ='#system
 Say '  #parm   ='#parm

 /*--------------------------------------------------------------------
 |  Check system name and set active task list
 */

 If "MVSVAR"('SYSNAME') <> #system Then Do
    Call WHITE('System is not' #system', processing terminated')
    Signal #FIN
    End

 #tasklist = ACTIVE()
 #tsolist  = TACTIVE()

 /*===================================================================
 |  User's code starts here: (define rexx code as ddname REXXPARM)
 | ===================================================================
 */

 INTERPRET(INSD('REXXPARM'))

 /*===================================================================
 |  User's code ends here. No unauthorised changes below this line!
 | ===================================================================
 |  Wait before final processing:
 */
 #FIN:
 #string = ''
 Do #i = 1 to #
    #string = #string||#x.#i
    End
 If #final_wait <> '' & #string <> '' Then
    Say #p 'Final wait' #final_wait
    #reply = L_FWT(#final_wait)

 /*-------------------------------------------------------------------
 |  Optional: remove WHITE messages from console, if any:
 */
 Do #i = 1 to #
    Call DOM(#i)
    End
 If #string <> '' Then
    Say #p 'Message(s) removed'

 Say #p 'Execution Complete' "TIME"()
 EXIT

 /*===================================================================
 |  S U B R O U T I N E S
 |====================================================================
 */

 /*-------------------------------------------------------------------
 |  Check task status: Arg = task name  returns 1 if OK, else 0
 */
 CHECK:
 Arg #task
 #task = "STRIP"(#task)
 /* #taskname = ' '||#task||' '                 */
 #notact = #p #task 'is not running!'
 /* If ("POS"(#taskname,#tasklist) = 0) Then Do */
 If SYSACTV(#task) = '0' Then Do
    Call RED(#notact)
    Return(0)
    End
 /* Additional processing for specific tasks: */
 Select
    When #task = 'CCITCP' Then Do
       /* display all devices that are not READY */
       #cmd = 'D TCPIP,,N,DEV'
       #txt  = 'DEVSTATUS: '
       #txt1 = 'DEVSTATUS: READY'
       Parse Value #CONS(#cmd) With #rc #reply
       Call DISP_REPLY(#reply)
       #i  = "POS"(#txt,#reply)
       #i1 = "POS"(#txt1,#reply)
       #notready = 0
       Do While(#i > 0)
          If #i <> #i1 Then Do
             Parse Var #reply 'DEVNAME: ' #dev ' ' .
             Parse Var #reply 'DEVNUM: '  #devnum (#sep) .
             Parse Var #reply (#txt)   #devsts (#sep) .
             #msg = #p 'TCPIP: DEVNAME:' #dev,
                ||', DEVNUM:' #devnum,
                ||', DEVSTATUS:' #devsts
             Call RED(#msg)
             #notready = 1
             End
          Parse Var #reply (#txt1) #reply
          #i  = "POS"(#txt,#reply)
          #i1 = "POS"(#txt1,#reply)
          End
       If #notready Then Return(0)
       End
    When #task = 'DBSRVD' ,
       | #task = 'DBSRVP1',
       | #task = 'DBSRVP2',
       | #task = 'DBSRVQ' ,
       | #task = 'DBSRVT1',
       | #task = 'DBSRVT2' Then Do
       /* Step must have pre-allocated ddname (same as task name) */
       /* See CHKTASK jcl proc as an example                      */
       #msg = #p #task 'is running but not operational!'
       #txt = 'Errortext'
       #reply = READDDN(#task)
       Call DISP_REPLY(#reply)
       If #reply = '' | "POS"(#txt,#reply) > 0 Then Do
          Call RED(#msg)
          Return(0)
          End
       End
    When #task = 'ROS60',
       | #task = 'ROS60DIS' Then Do
       /* Check if Roscoe responds */
       #cmd = 'F' #task||',STATUS'
       Parse Value #CONS(#cmd) With #rc #reply
       Call DISP_REPLY(#reply)
       #msg = #p #task 'is not responding'
       #txt = 'ROS131I'
       If ("POS"(#txt,#reply) = 0 & #rc = 0) Then Do
          Call RED(#msg)
          Return(0)
          End
       End
    When #task = 'DATAP390',
       | #task = 'DATAQ390',
       | #task = 'DATAD390',
       | #task = 'DATAT390' Then Do
       /* Check if database responds and in Multi-user mode */
       #cmd = 'f' #task',comm status dest=console'
       #msg = #p #task 'is not running in multi-user mode!'
       #txt = 'MULTI-USER'
       Parse Value #CONS(#cmd) With #rc #reply
       Call DISP_REPLY(#reply)
       If ("POS"(#txt,#reply) = 0 & #rc = 0) Then Do
          Call RED(#msg)
          Return(0)
          End
       End
    When #task = 'CICSP390',
       | #task = 'CICSQ390',
       | #task = 'CICSD390',
       | #task = 'CICST390' Then Do
       /* Check if CICS responds */
       #cmd = 'f' #task',CEMT I TAS'
       #msg = #p #task 'is not responding'
       #txt = 'CHKTASK'
       Parse Value #CONS(#cmd) With #rc #reply
       Call DISP_REPLY(#reply)
       If ("POS"(#txt,#reply) = 0 & #rc = 0) Then Do
          Call RED(#msg)
          Return(0)
          End
       End
    Otherwise Nop
    End
 Return(1)

/*--------------------------------------------------------------------
| Stop remaining active tasks
| Optional parm - list of tasks you do not want to be stopped yet.
| Will attempt to stop whatever is in #tasklist active and not
| in skip_list parsed from parm. Works in an arbitrary order.
*/
 STOP_REMAINING:
 If #simulate Then Return(0)
 Call Active /* get fresh #tasklist */
 Arg #skip_list
 #skip_list = ' '||"TRANSLATE"(#skip_list,' ',',')||' ',
    ||"SYSVAR"('SYSPROC')||' '
 Say #p 'Stopping remaining tasks...'
 Say #p 'Skip_list:' #skip_list
 #n = "WORDS"(#tasklist)
 Do #i = 1 To #n
    #task_to_stop = ' '||"WORD"(#tasklist,#i)||' '
    If "POS"(#task_to_stop,#skip_list) = 0 Then
       Call STOP(#task_to_stop)
    End
 Return(1)

 /*-------------------------------------------------------------------
 |  Issue STOP command for task specified: Arg = task name
 |  (here you can instruct the program how to stop specific tasks)
 */
 STOP:
 Arg #task
 #task = "STRIP"(#task)
 #chkactive = 1
 ##wait = #wait                         /* std wait by default */
 Select

    When #task = 'CICSP390',
       | #task = 'CICSQ390',
       | #task = 'CICSD390',
       | #task = 'CICST390' Then Do
       #cmd = 'F' #task',CEMT SET TERM ALL OUTSERVICE',
          || #sep'F' #task',DBOC SHUTDOWN',
          || #sep'F' #task',CEMT P SHUT'
       ##wait = '12s'                   /* special wait         */
       End

    When #task = 'DBSRVD' Then
       #cmd = 'S JOB,N=DBSRVEJD'
    When #task = 'DBSRVP1' Then
       #cmd = 'S JOB,N=DBSRVEP1'
    When #task = 'DBSRVP2' Then
       #cmd = 'S JOB,N=DBSRVEP2'
    When #task = 'DBSRVQ'  Then
       #cmd = 'S JOB,N=DBSRVEJQ'
    When #task = 'DBSRVT1' Then
       #cmd = 'S JOB,N=DBSRVET1'
    When #task = 'DBSRVT2' Then
       #cmd = 'S JOB,N=DBSRVET2'

    When #task = 'HTTPD'    Then #cmd = 'C HTTPD'
    When #task = 'OPS'      Then #cmd = 'P OPSS'
    When #task = 'ROS60'    Then #cmd = 'F ROS60,SHUTDOWN,NOW'
    When #task = 'ROS60DIS' Then #cmd = 'F ROS60DIS,SHUTDOWN,NOW'
    When #task = 'RIO'      then #cmd = 'F RIO,SHUTDOWN'
    When #task = 'TMVSMSTR' Then #cmd = 'F TMVSMSTR,QU'
 /* When #task = 'TMVSLFS'  Then #cmd = 'F TMVSLFS,QU' */
 /* When #task = 'TMONMVS'  Then #cmd = 'F TMONMVS,QU' */
    When #task = 'PRT'      Then Do
       #cmd = 'S STOPPRT'
       #chkactive = 0
       End
    When #task = 'AOP'      Then Do
       #cmd = 'S AOPSTOP'
       #chkactive = 0
       End
    When #task = 'LOGON1'   Then Do
       #cmd = '$P LOGON1'
       #chkactive = 0
       End
    When #task = 'LINE1'    Then Do
       #cmd = '$P LINE1'
       #chkactive = 0
       End
    When #task = 'CA7ONL'   Then DO
       #cmd = 'F CA7ONL,/LOGON MASTER',
          || #sep'F CA7ONL,/SHUTDOWN,Z3',
          || #sep'F CA7ONL,/SHUTDOWN,Z3'
       End
    When #task = 'CAD4PROC' Then #cmd = 'F CAD4PROC,SHUTDOWN'
    When #task = 'CA7ICOM'  Then #cmd = 'F CA7ICOM,STOP'
    When #task = 'CA7ICOMT' Then #cmd = 'F CA7ICOMT,STOP'
    When #task = 'CA11'     Then #cmd = '++SHUTDOWN ALL'
    When #task = 'CA7ONLT'  Then Do
       #cmd = 'F CA7ONLT,/LOGON MASTER',
          || #sep'F CA7ONLT,/SHUTDOWN,Z3',
          || #sep'F CA7ONLT,/SHUTDOWN,Z3'
       End
    When #task = 'CA7ONL'   Then Do
       #cmd = 'F CA7ONL,/LOGON MASTER',
          || #sep'F CA7ONL,/SHUTDOWN,Z3',
          || #sep'F CA7ONL,/SHUTDOWN,Z3'
       End
    When #task = 'SVTS'     Then Do
       #cmd = 'S SVTSVOFF',
          || #sep'P SVTS'
       End
    When #task = 'CTS'      Then Do
       #cmd = 'F CTS,STOP TLMS',
          || #sep'P CTS'
       End
    When #task = 'CCITCP'   Then #cmd = 'C CCITCP'
    When #task = 'CCITCPGW' Then #cmd = 'C CCITCPGW'
    When #task = 'LOGROUTE' Then #cmd = 'P LOGROUTE.L'
    When #task = 'ASCH'     Then #cmd = 'C ASCH'
    When #task = 'APPC'     Then #cmd = 'C APPC'
    When #task = 'RACF'     Then Do
       #cmd = '#STOP'
       #chkactive = 0
       End
    When #task = 'DLF'      Then Do
       #cmd = 'F DLF,MODE=Q',
          || #sep'P DLF'
       End
    When #task = 'CRON6'    Then #cmd = 'C CRON6'
    When #task = 'SYSLOGD5' Then #cmd = 'C SYSLOGD5'
    When #task = 'BPXOINIT' Then Do
       #cmd = 'F BPXOINIT,SHUTDOWN=FORKINIT'
       #chkactive = 0
       End
    When #task = 'VTAM'     Then #cmd = 'Z NET,QUICK'
    When #task = 'FFST'     Then Do
       #cmd = 'P FFST'
       #task = 'EPWFFST'
       End
    When #task = 'JES2' Then Do
       /* special processing for JES2 stop command: */
       #cmd = '$PJES2'
       Say
       If #simulate Then Do
          Call L_WTO(#cmd)
          Say #p 'Simulate:' #cmd
          End
       Else Do
          Call L_FWT(#wait)
          /* try to wait until tasks end: */
          Call ACTIVE
          If "WORDS"(#tasklist) > 2 Then Do
             Call DSP_ACTIVE(#tasklist)
             #emsg = #p 'Tasks active - $PJES2 command skipped'
             Call GREEN(#emsg)
             End
          Else Do
             #cmd = '$PJES2'
             Say #p 'System command issued:' #cmd
             ADDRESS TSO "CALL *(IRX@MGCR) '"#cmd"'"
             End
          End
       #cmd = ''
       #chkactive = 0
       End
    Otherwise                   #cmd = 'P' #task
    End

 If #chkactive Then Do
    /* #taskname = ' '||#task||' '               */
    /* If "POS"(#taskname,#tasklist) = 0 Then Do */
    Say
    If SYSACTV(#task) = '0' Then Do
       #emsg = #p #task 'is not running - command(s) skipped'
    /* Say #emsg */
       Call GREEN(#emsg)
       Return
       End
    End
 Do While(#cmd <> '')
    Parse Value #cmd With #command (#sep) #cmd
    Parse Value #CONS(#command) With #rc #reply
    Call DISP_REPLY(#reply)
    Call L_FWT(##wait)
    End
 Return

 /*-------------------------------------------------------------------
 |  Display parm=#tasklist or #tsolist on console.
 |  Parm must be a list of words separated by blanks.
 |  Show words 6 in a row
 */
 DSP_ACTIVE: PROCEDURE EXPOSE WHITE #p # #x.
 Arg #parm
 #row = 6                              /* how many tasks in a row   */
 #n = "WORDS"(#parm)
 #line = ''
 #j=0
 Do #i = 1 to #n
    #task = "WORD"(#parm,#i)
    #line = #line || "LEFT"(#task,9)
    #j = #j + 1
    If #j = #row Then Do
       Call WHITE(#line)
       #j = 0
       #line = ''
       End
    End
 If #line <> '' Then
    Call WHITE(#line)
 Return

 /*-------------------------------------------------------------------
 |  Display console message and get response.
 |  Arg = message, returns response
 */
 WTOR: PROCEDURE EXPOSE #p
 Parse Arg #msg
 Say #p 'Request: ' #msg
 #response = L_WTO(#msg,'R')
 Say #p 'Response:' #response
 Return(#response)

 /*-------------------------------------------------------------------
 |  Display console message in green
 |  Arg = message, returns msgid (not used)
 */
 GREEN: PROCEDURE EXPOSE #p
 Parse Arg #msg
 Say #p 'Grn msg: ' #msg
 Call L_WTO(#msg)
 Return

 /*-------------------------------------------------------------------
 |  Display console message in red:
 |  Arg = message, returns msgid (used by L_DOM)
 */
 WHITE: PROCEDURE EXPOSE # #x. #p
 Parse Arg #msg
 Say #p 'Wht msg: ' #msg
 # = # + 1
 #x.# = L_WTO(#msg,'b')
 Return(#)

 /*-------------------------------------------------------------------
 |  Display console message in red:
 |  Arg = message, returns msgid (used by L_DOM)
 */
 RED: PROCEDURE EXPOSE ## ##x. #p
 Parse Arg #msg
 Say #p 'Red msg: ' #msg
 ## = ## + 1
 ##x.## = L_WTO(#msg,'a')
 Return(##)

 /*-------------------------------------------------------------------
 |  Set active task list using reply from 'D J,L'
 |  Issue D,j,L and store active task list in a returned string
 */
 ACTIVE:
 #tasklist = ' '
 #cmd_a = 'D J,L'
 #oldsim = #simulate
 #simulate = 0
 Parse Value #CONS(#cmd_a) With #rc #rep
 #simulate = #oldsim
 Parse Value #rep with (#sep) #string
 #i=0
 Do While(#string <> '')
    Parse Var #string #line (#sep) #string
    #i = #i + 1
    If #i > 3 Then Do
       Parse Value #line With 1 #t1 9 . 36 #t2 44 .
       #tasklist = #tasklist "STRIP"(#t1) "STRIP"(#t2)
       End
    Say #line
    End
 #tasklist = #tasklist || ' '
 Return(#tasklist)

 /*-------------------------------------------------------------------
 |  Set active TSO users list using reply from 'D TS,L'
 |  Issue D,TS,L and store active task list in a returned string
 */
 TACTIVE:
 #tsolist = ' '
 #cmd_a = 'D TS,L'
 #oldsim = #simulate
 #simulate = 0
 Parse Value #CONS(#cmd_a) With #rc #rep
 #simulate = #oldsim
 Parse Value #rep with (#sep) #string
 #i=0
 Do While(#string <> '')
    Parse Var #string #line (#sep) #string
    #i = #i + 1
    If #i > 3 Then Do
       Do #j = 1 By 2 To 7
          #tsou = "WORD"(#line,#j)
          If #tsou <> '' Then
             #tsolist = #tsolist #tsou
          End
       End
    Say #line
    End
 #tsolist = #tsolist || ' '
 Return(#tsolist)

 /*-------------------------------------------------------------------
 |  Display reply splitted to separate lines:
 |  General pupose: display any reply returned by #CONS
 |  Arg = reply #string
 */
 DISP_REPLY: PROCEDURE EXPOSE #sep
 /* Display response line by line: */
 Parse Arg (#sep) #string
 Do While(#string <> '')
    Parse Var #string #line (#sep) #string
    Say #line
    End
 Return

 /*-------------------------------------------------------------------
 |  Remove RED message from console:
 |  Arg = ## of msgid, msgid = ##x.##
 */
 DOMR: PROCEDURE EXPOSE ##x.
 Parse Arg ##
 if ##x.## <> '' Then Do
    Call L_DOM(##x.##)
    ##x.## = ''
    End
 Return

 /*-------------------------------------------------------------------
 |  Remove WHITE message from console:
 |  Arg = # of msgid, msgid = #x.#
 */
 DOM: PROCEDURE EXPOSE #x.
 Parse Arg #
 if #x.# <> '' Then Do
    Call L_DOM(#x.#)
    #x.# = ''
    End
 Return

 /*-------------------------------------------------------------------
 |  Issue console command and return reply from system:
 |  as 'rc |line 1|line 2|...|last line'
 |  Arg = connamd
 |  Returns string containing reply lines separated by #sep character
 |  When #simulate = 1 display the command, not issue.
 */
 #CONS:

 #prefix = #p 'CONS:'                  /* message prefix            */
 #cart="TIME"('S')                     /* Cmd cart code             */
 #rc_ok = 0                            /* No error rc               */
 #rc_nocons = 20                       /* Activation error          */
 #rc_nodata = 4                        /* Empty/No reply            */
 #rc_nocmd  = 8                        /* Empty/No command          */
 #wait1 = 1                            /* seconds, GETMSG wait int  */
 /* each GETMSG takes at least twice as much time as wait (seconds) */

 Arg #command

 Say
 If #simulate Then Do
    /* simulate console commands: */
    call L_WTO(#command)
    Say #p 'Simulate:' #command
    Return(0)
    End

 /* Execute comand for real: */
 Address TSO
 If "LENGTH"(#command) = 0 Then Do
    If #start Then Do
       /* indicate error call */
       Say #prefix 'No/empty command requested'
       Return(#rc_nocmd)
       End
    Else Do
       /* close console and reset #start */
       "CONSPROF SOLDISPLAY("#mdisp")"    /* restore from mdisp     */
       "CONSPROF UNSOLDISPLAY("#mdis1")"  /* restore from mdis1     */
       "CONSOLE DEACTIVATE"
       If RC <> 0 Then
          Say #prefix 'Console deactivation RC =' RC
       Else
          #start = 0                      /* drop "1st call" flag   */
       Return(RC)
       End
    End
 Else
    Say #prefix "TIME"() "Requested command:" #command

 If #start Then Do
    /* activate console: */
    #mdisp = SYSVAR("SOLDISP")         /* save SOLDISP              */
    "CONSPROF SOLDISPLAY(NO)"          /* reset to get solicited    */
    #mdis1 = SYSVAR("UNSDISP")         /* save UNSDISP              */
    "CONSPROF UNSOLDISPLAY(NO)"        /* reset to get unsolicited  */
    "CONSOLE ACTIVATE"
    If RC <> 0 Then Do
       /*---> Check if console is not available - only at 1st call */
       #msg = #p #err.RC 'for' #command
       Call L_WTO(#msg)
       Say #msg
       Signal #FIN
       End
    /*<--- End of console availability check */
    #start = 0
    Say #prefix 'Console activated'
    #ret = RC
    End

 "CONSOLE SYSCMD("#command") CART("#cart")"
 If RC <> 0 Then
    Say #prefix 'Console Syscmd RC =' RC
 #ret = #rc_ok' '
 #n = 0
 Do #attempt = 1 to 20
    #getcode = GETMSG('#conmsg.','EITHER',,,#wait1)
    /*Say #prefix 'Attempt='#attempt 'Getcode='#getcode*/
    If #getcode = 0 Then Do
       #getcode1 = #getcode
       Do #i = 1 To #conmsg.0
          #conmsg.#i = "STRIP"(#conmsg.#i)
          #ret = #ret||#sep||#conmsg.#i
          #n = #n + 1
          End
       End
    Else Do
       If #attempt = 1 Then Do
          #getcode1 = #getcode
          #ret = #rc_nodata
          End
       Else LEAVE
       End
    End
 Say #prefix 'Getcode =' #getcode1,
     ||',' #n 'lines returned from console in' #attempt,
     'attempts'
 If #n = 0 Then
    #ret = SYSGETL(#command)

 Return(#ret)

 /*-------------------------------------------------------------------
 |  Read from ddn to string:
 |  Arg: ddname to read from
 |  returns a string containing stripped records
 |  separated by #sep character
 */
 READDDN: PROCEDURE Expose #sep #p
 Parse Arg #ifile
 Say
 "EXECIO * DISKR" #ifile "(STEM #inrec. FINIS"
 If RC > 0 Then Do
    Say #p 'Error - ddname' #ifile 'read error'
    Return('')
    End
 #string = "STRIP"(#inrec.1)
 Do i = 2 to #inrec.0
    #string = #string||#sep||"STRIP"(#inrec.i)
    End
 Say #p ' -' #inrec.0 'records read from' #ifile
 Return(#string)

 /*-------------------------------------------------------------------
 |  Reply to outstanding request:
 |  Arg = #msgid #reply
 |  msgid = system request message identitier, like IEC0128A,
 |  #reply = what to reply to this request if outstanding
 |  Before calling REPLYIT, create string REQUEST containing
 |  reply to D R,R,CN=MASTER. Use #CONS to create REQUEST:
 |     #cmd = 'D R,R,CN=MASTER'
 |     Parse Value #CONS(#cmd) With #rc #request
 */
 REPLYIT:
 Arg #msgid #msgrep
 #msgpos = "POS"(#msgid,#request)
 If #msgpos > 0 Then Do
    #msgpos = #msgpos - 5
    #msgnum = "SUBSTR"(#request,#msgpos,4)
    #cmd = 'R' #msgnum||","||#msgrep

    If #simulate Then
       Call GREEN(#cmd)
    Else Do
/*=== primary method of replying the request: =====================*/
/*     Call authorised program SYS3.LINKLIB(IRX@MGCR):             */
/*     (this is an example of how to use authorised prog in REXX   */
/*     Cannot use #CONS because it has not AUTH=MASTER.            */
/*     MGCR macro can send reply by name of master console         */
/*     but needs to run under key=zero and mode=sup                */
/*=================================================================*/
       ADDRESS TSO "CALL *(IRX@MGCR) '"#cmd"'"
/* === alternative simple method: submit a job: ===================*/
/*     #par = '//CHKTASK1 JOB (3,290,0744,0),CPRS399,CLASS=S,',    */
/*        ||'MSGCLASS=Y',                                          */
/*        ||'|// EXEC PGM=IEFBR14',                                */
/*        ||"|// COMMAND '"#cmd"'",                                */
/*        ||'|//'                                                  */
/*     If #simulate Then #outfile = 'SYSTSPRT'                     */
/*     Else              #outfile = 'SUBMIT'                       */
/*     Call PWX(#outfile #par)                                   */
/*=================================================================*/
       Say #p "Reply command issued:" #cmd
       End
    End
 Else
    Say #p #msgid 'is not outstanding. Reply ignored'
 Return

/*-------------------------------------------------------------------
|| Terminate application when Unitialized variable encountered
*/
  NOVALUE:
    SIGNAL OFF NOVALUE
    SAY #p" - Uninitialized variable used:"
    SAY "   "sigl":" "SOURCELINE"(sigl)
  SIGNAL #FIN
/*----------------------  End of program  --------------------------*/
