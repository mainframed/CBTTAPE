/* REXX System shutdown sequence for TEST -------------
|       Executed by the REXX program SYSCNTL as interpreted REXX code
|       Program SYSCNTL is executed by CHKTASK started task.
|
| 08/01/03 SVM Added smart waiting for VTAM termination
|          before stopping LLA, VLF and JES2.
| 06/30/03 SVM Added STOP_REMAINING, chg to 'D R,R...'
| 05/21/03 SVM Replaced FWAIT by L_FWT
| 04/24/03 DEB Added RIO and new printers
| 02/26/03 SVM Created as SYS1.REXX.CNTL(SHUTTEST)
|
| NOTE: all names starting with "#" are reserved!
|       #         - White message count.
|       ##        - Red   message count.
|       #parm     - parm coming from EXEC CHKTASK,
|                   in this exec used as simulation flag
|       #simulate - simulate flag, used to control SYSCNTL console
|                   functions
|       #tasklist - original list of active tasks,
|       #tsolist  - original list of active TSO users
|          both #tasklist and #tsolist can be set at any time using
|          #tasklist = ACTIVE()
|          #tsolist  = TACTIVE()
|       #FIN      - to terminate processing before end: Signal #FIN
|
*/
/*-------------------------------------------------------------------
|  Check simulation mode, confirm function and set waiting times:
*/
    #simulate = #parm
    If #simulate <> '0' Then #simulate = 1

    If #simulate Then
       msg = "Please reply 'U' to confirm SHUTDOWN",
          "simulation, 'N' to cancel"
    Else
       msg = "Please reply 'U' to confirm SHUTDOWN, 'N' to cancel"
    rep=WTOR(msg)
    If rep <> 'U' & rep <> 'u' Then Do
       Call GREEN('Processing cancelled due to operator request')
       Signal #FIN
       End

    If #simulate Then Do
       Call WHITE(#p "DATE"() "TIME"(),
          ||'  Shutdown simulation in progress...')
       #wait = '1s'                       /* wait between commands  */
       #final_wait = '5s'                 /* wait before cleanup    */
       End
    Else Do
       Call WHITE(#p "DATE"() "TIME"(),
          ||'  Shutdown in progress...')
       #wait = '4s'                       /* wait between commands  */
       #final_wait = '20s'                /* wait before cleanup    */
       End

/*-------------------------------------------------------------------
|  Show active TSO users:
|
|   tso_msg1 = # + 1
|   If #tsolist <> '' Then Do
|      tso_msg1 = WHITE(#p 'TSO users still active:')
|      Call DSP_ACTIVE(#tsolist)
|      End
|   tso_msg2 = #
*/
/*-------------------------------------------------------------------
|  Stopping tasks:
*/
    Call STOP('ROS60')
    Call STOP('GRTASK')
    Call STOP('XGSTART')
    Call STOP('RIO')
    Call STOP('TMVSMSTR')     /* stops TMONMVS and TMVSLFS  as well */
    Call STOP('PRT')          /* stops remote printers */
    Call STOP('AOP')
    Call STOP('LOGON1')
    Call STOP('LINE1')
    Call STOP('CTS')
    Call STOP('CCITCP')
    Call STOP('ENF')
    Call STOP('RMF')
    Call STOP('TSO')
    Call STOP('LOGROUTE')
    Call STOP('SYNCDSM')
    Call STOP('LSSHUBM')
    Call STOP('SDSF')
    Call STOP('ASCH')
    Call STOP('APPC')
    Call STOP('FFST')
    Call STOP('DLF')

/*-------------------------------------------------------------------
|  Reply outstanding messages from FFST and  ENF: After Parse #CONS
|  the #request value contains console requests and is used by REPLYIT
*/
    Call L_FWT(#wait)
    Parse Value #CONS('D R,R,CN=MASTER') With rc #request
    Call DISP_REPLY(#request)

    Call REPLYIT('EPW0309I' 'YES')      /* FFST        */
    Call REPLYIT('CAS9227A' 'Y')        /* ENF         */
    Call REPLYIT('IKT010D' 'FSTOP')     /* TSO         */

/* Remove old messages about Active TSO users:
|   Do i = tso_msg1 By 1 To tso_msg2
|      Call DOM(i)
|      End
*/
/*-------------------------------------------------------------------
|  Continue stopping tasks:
*/
    Call STOP('FWKERN')
    Call STOP('CRON6')
    Call STOP('SYSLOGD5')
    Call STOP('RACF')
    Call STOP('WEBSRV')
    Call STOP('TCPIPE')

    Call STOP_REMAINING('LLA VLF JES2 DFSMSHSM BPXOINIT VTAM')

    Call STOP('DFSMSHSM')
    Call STOP('BPXOINIT')
    Call STOP('VTAM')
    /* Wait until remain CHKTASK,LLA,VLF and JES only 4 tasks */
    Do 10
       Call ACTIVE
       If "WORDS"(#tasklist) > 4 Then
          Call L_FWT(#wait)
       Else LEAVE
       End
    Call STOP('LLA')
    Call STOP('VLF')
    Call STOP('JES2')
/*-------------------------------------------------------------------
|  Final messages:
*/
    Call L_FWT(#final_wait)             /* wait until stop ends */
    tasklist = ACTIVE()
    tsolist = TACTIVE()
    Call WHITE(#p 'Automatic Shutdown complete')
    If "WORDS"(tasklist) > 1 Then Do
       Call WHITE(#p 'Remaining active tasks:')
       Call DSP_ACTIVE(tasklist)
       End
    If tsolist <> '' Then Do
       Call WHITE(#p 'TSO users acive:')
       Call DSP_ACTIVE(tsolist)
       End

    If "POS"('JES2',tasklist) > 0 Then Do
       Call GREEN('Instructions to complete Shutdown manually:')
       Call GREEN(' - when all reports are finished printing, enter:')
       CALL GREEN('   $P PRT1145')
       CALL GREEN('   $P PRT11452')
       Call GREEN(' - after printers have drained, enter:')
       CALL GREEN('   C FSS1145')
       CALL GREEN('   C FSS11452')
       Call GREEN(' - when JES2 "All available functions complete":')
       Call GREEN('   $P JES2')
       Call GREEN('   Z EOD')
       End
    Else Do
       Call GREEN('-  Shutdown complete, ready for')
       Call GREEN('   Z EOD')
       End
