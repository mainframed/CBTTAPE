/* REXX  --------  #CONS: Get reply from console cmd  ---------------
|                      works in TSO environment
| FUNCTION:
|                   Issue a console command and
|                   return the system's reply messages
|
| INPUT:            Arg command
|                   - console command requested to issue
|
| OUTPUT:
|                   Returns RC |string  string present only if RC=0
|                   returned reply records are separated by '|'
|
| History of changes (last comes first):
|
| 03/13/2003 SVM Updated to use SYSGETL when GETMSG doesn't work
| 11/25/2002 SVM Updated for CHKTASK
| 07/26/2002 SVM Created
*/
 #prefix = 'CONS:'                     /* message prefix            */
 #sep = '|'                            /* Array separator in return */
 cart="TIME"('S')                      /* Cmd cart code             */
 rc_ok = 0                             /* No error rc               */
 rc_nocons = 20                        /* Activation error          */
 rc_nodata = 4                         /* Empty/No reply            */
 rc_nocmd  = 8                         /* Empty/No command          */
 wait = 1                              /* seconds, GETMSG wait int  */

 Arg command
 Address TSO
 sep = #sep                            /* take default              */
 If "LENGTH"(command) = 0 Then Do
    Say #prefix 'No/empty command requested'
    Return(rc_nocmd)
    End
 Else
    Say #prefix "Requested command:" command

 /* Activate console: */
 mdisp = SYSVAR("SOLDISP")             /* save SOLDISP              */
 "CONSPROF SOLDISPLAY(NO)"             /* reset to get solicited    */
 mdis1 = SYSVAR("UNSDISP")             /* save UNSDISP              */
 "CONSPROF UNSOLDISPLAY(NO)"           /* reset to get unsolicited  */
 "CONSOLE ACTIVATE"

 /* Issue command: */
 If RC <> 0 Then Do
    Say #prefix 'Console activation RC =' RC
    ret = RC
    End
 Else Do
    "CONSOLE SYSCMD("command") CART("cart")"
    If RC <> 0 Then
       Say #prefix 'Console Syscmd RC =' RC
    ret = rc_ok' '
    n = 0
    Do attempt = 1 to 20
       getcode = GETMSG('CONMSG.','EITHER',,,wait)
       /*Say #prefix 'Attempt='attempt 'Getcode='getcode*/
       If getcode = 0 Then Do
          getcode1 = getcode
          Do i = 1 To conmsg.0
             conmsg.i = "STRIP"(conmsg.i)
             ret = ret||sep||conmsg.i
             n = n + 1
             End
          End
       Else Do
          If attempt = 1 Then Do
             getcode1 = getcode
             ret = rc_nodata
             End
          Else LEAVE
          End
       End
    Say #prefix 'Getcode =' getcode1,
       ||',' n 'lines returned from console request in' attempt,
       'attempts'

    If n = 0 Then
       ret = SYSGETL(command)

    End

 "CONSPROF SOLDISPLAY("mdisp")"        /* restore from mdisp */
 "CONSPROF UNSOLDISPLAY("mdis1")"      /* restore from mdis1*/
 "CONSOLE DEACTIVATE"
 If RC <> 0 Then
    Say #prefix 'Console deactivation RC =' RC
 Return(ret)
 EXIT
