/* REXX System shutdown sequence for PROD -------------
|       Executed by the REXX program SYSCNTL as interpreted REXX code
|       Program SYSCNTL is executed by CHKTASK started task.
|
| 08/01/03 SVM Added smart waiting for VTAM termination
|          before stopping LLA, VLF and JES2.
| 06/30/03 SVM Added STOP_REMAINING, chg to 'D R,R...'
| 06/20/03 SVM CAdded optional shutdown for CICS* and DBSRV*, LLA, VLF
| 05/21/03 SVM CReplaced FWAIT to L_FWT
| 05/05/03 SVM CCorrected CA07ONL to CA7ONL
| 04/23/03 DEB Added RIO and new printers
| 02/26/03 SVM Created as a SYS1.REXX.CNTL(SHUTPROD)
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
|       #wait     - wait interval between issuing STOP task commands
|       #final_wait - wait interval before termination CHKTASK
|       #FIN      - to terminate processing before end: Signal #FIN
|       See SYSCNTL for details.
*/
/*-------------------------------------------------------------------
|  Check simulation mode, confirm function and set waiting times:
|       Use name "#simulate" for simulation flag.
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
          || '  Shutdown simulation in progress...')
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
|  Ask operator,  if CICS*, DATA* of DBSRV* still active:
*/
    If  ("POS"(' CICS',#tasklist) > 0,
       |"POS"(' DATA',#tasklist) > 0,
       |"POS"(' DBSRV',#tasklist) > 0) & (#simulate = '0') Then Do
       Call WHITE(#p 'Some CICS, DATA, or DBSRV regions',
          'are active')
       rep = WTOR('Reply "U" to continue shutdown,',
          '"N" to terminate')
       If rep <> 'U' & rep <> 'u' Then Do
          Call GREEN(#p 'Shutdown terminated by operator')
          Signal #FIN
          End
       Call DOM(#)
       Call STOP('CICSP390')
       Call STOP('CICSQ390')
       Call STOP('CICSD390')
       Call STOP('CICST390')
       Call STOP('DBSRVD')
       Call STOP('DBSRVP1')
       Call STOP('DBSRVP2')
       Call STOP('DBSRVQ')
       Call STOP('DBSRVT1')
       Call STOP('DBSRVT2')
       End

/*-------------------------------------------------------------------
|  Show active TSO users, if any:
|
|   tso_msg1 = # + 1
|   If #tsolist <> '' Then Do
|      Call WHITE('TSO users still active:')
|      Call DSP_ACTIVE(#tsolist)
|      End
|   tso_msg2 = #
*/
/*-------------------------------------------------------------------
|  Stopping tasks:
*/
    Call STOP('ROS60')
    Call STOP('ROS60DIS')
    Call STOP('IF40')
    Call STOP('RADAR')
    Call STOP('DFS')
    Call STOP('GRTASK')
    Call STOP('XGSTART')
    Call STOP('TDCAS')
    CALL STOP('RIO')
    Call STOP('TMONCICS')
    Call STOP('TMVSMSTR')     /* stops TMONMVS and TMVSLFS  as well */
    Call STOP('PRT')          /* stop remote printers */
    Call STOP('AOP')
    Call STOP('LOGON1')
    Call STOP('LINE1')
    Call STOP('CA7ONL')
    Call STOP('CAD4PROC')
    Call STOP('CA7ICOM')
    Call STOP('CA11')
    Call STOP('CA7XTRK')
    Call STOP('CA7ONLT')
    Call STOP('SVTS')
    Call STOP('CTS')
    Call STOP('CCITCP')
    Call STOP('CCITCPGW')
    Call STOP('ENF')
    Call STOP('LSSHUBR')
    Call STOP('LSSHUBM')
    Call STOP('TCELFS')
    Call STOP('RMF')
    Call STOP('TSO')
    Call STOP('LOGROUTE')
    Call STOP('SYNCDSM')
    Call STOP('SDSF')
    Call STOP('ASCH')
    Call STOP('APPC')
    Call STOP('FFST')
    Call STOP('DLF')
    Call STOP('GPMSERVE')
    Call STOP('FWKERN')
    Call STOP('CRON6')
    Call STOP('SYSLOGD5')

/*-------------------------------------------------------------------
|  Reply outstanding messages from stopping tasks. After Parse #CONS
|  the #request value contains console requests and is used by REPLYIT
*/
    Call L_FWT(#wait)
    Parse Value #CONS('D R,R,CN=MASTER') With rc #request
    Call DISP_REPLY(#request)

    Call REPLYIT('CATK0246' 'DDSSHUT')            /* CAD4PROC    */
    Call REPLYIT('EPW0309I' 'YES')                /* FFST        */
    Call REPLYIT('CAS9227A' 'Y')                  /* ENF         */
    Call REPLYIT('IKT010D' 'FSTOP')               /* TSO         */

/* Now remove messages about active TSO users:
|   Do i = tso_msg1 By 1 To tso_msg2
|      Call DOM(i)
|      End
*/
/*-------------------------------------------------------------------
|  Continue stopping tasks:
*/

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
    Call L_FWT(#final_wait)
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
       Call GREEN(' - if you are going to FORMAT or COLD START,')
       Call GREEN('   enter "W A" to create final SYSLOG')
       Call GREEN(' - when all reports are finished printing, enter:')
       Call GREEN('   $P PRT3160')
       Call GREEN('   $P PRT31602')
       CALL GREEN('   $P PRT1145')
       CALL GREEN('   $P PRT11452')
       Call GREEN(' - after printers have drained, enter:')
       Call GREEN('   C FSS3160')
       Call GREEN('   C FSS31602')
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
