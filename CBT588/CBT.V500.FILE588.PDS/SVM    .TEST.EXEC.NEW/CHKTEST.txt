/* REXX System check proc for TEST -------------------------------
|
| NOTE: all names starting with "#" are reserved!
|       #         - White message count.
|       ##        - Red   message count.
|
| 06/03/03 SVM Added check TCPIP
| 02/10/03 SVM Created as SYS1.REXX.CNTL(CHKTEST)
*/
    Call WHITE(#system': ' "DATE"() "TIME"(),
       ||'  System check in progress...')
    #final_wait = '15s'
    last_msg = ##

    If CHECK('CCITCP') Then
       Call GREEN(#p "LEFT"(#task,8) 'TCPIP devices are READY')
    If CHECK('ROS60') Then
       Call GREEN(#p "LEFT"(#task,8) '- OK')
    If CHECK('HTTPD') Then
       Call GREEN(#p "LEFT"(#task,8) '- OK')

 If ## = last_msg Then
    Call WHITE(#p 'All tasks run properly...')
 /* Optionally remove RED messages:
 | Else Do
 |    Call L_FWT(#wait)
 |    Do i = 1 To ##
 |       Call DOMR(i)
 |       End
 |    End
 */
