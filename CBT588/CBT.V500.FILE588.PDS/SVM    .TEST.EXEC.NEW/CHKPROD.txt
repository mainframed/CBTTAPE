/* REXX System check proc for PROD ----------------------------------
|
| NOTE: all names starting with "#" are reserved!
|       #         - White message count.
|       ##        - Red   message count.
|
| 06/04/03 SVM Added check for TCPIP, and -OK messages
| 02/10/03 SVM Created as SYS1.REXX.CNTL(CHKPROD)
*/
    Call WHITE(#system': ' "DATE"() "TIME"(),
       ||'  System check in progress...')
    #final_wait = '15s'
    last_msg = ##

    If CHECK('CCITCP')   Then
       Call GREEN(#p "LEFT"(#task,8) 'TCPIP devices are READY')
    If CHECK('ROS60')    Then
       Call GREEN(#p "LEFT"(#task,8) '- OK')
    If CHECK('ROS60DIS') Then
       Call GREEN(#p "LEFT"(#task,8) '- OK')
    If CHECK('CICSP390') Then
       Call GREEN(#p "LEFT"(#task,8) '- OK')
    If CHECK('CICSQ390') Then
       Call GREEN(#p "LEFT"(#task,8) '- OK')
    If CHECK('CICSD390') Then
       Call GREEN(#p "LEFT"(#task,8) '- OK')
    If CHECK('CICST390') Then
       Call GREEN(#p "LEFT"(#task,8) '- OK')
    If CHECK('DATAP390') Then
       Call GREEN(#p "LEFT"(#task,8) '- OK')
    If CHECK('DATAQ390') Then
       Call GREEN(#p "LEFT"(#task,8) '- OK')
    If CHECK('DATAD390') Then
       Call GREEN(#p "LEFT"(#task,8) '- OK')
    If CHECK('DATAT390') Then
       Call GREEN(#p "LEFT"(#task,8) '- OK')
    If CHECK('DBSRVD')   Then
       Call GREEN(#p "LEFT"(#task,8) '- OK')
    If CHECK('DBSRVP1')  Then
       Call GREEN(#p "LEFT"(#task,8) '- OK')
    If CHECK('DBSRVP2')  Then
       Call GREEN(#p "LEFT"(#task,8) '- OK')
    If CHECK('DBSRVQ')   Then
       Call GREEN(#p "LEFT"(#task,8) '- OK')
    If CHECK('DBSRVT1')  Then
       Call GREEN(#p "LEFT"(#task,8) '- OK')
    If CHECK('DBSRVT2')  Then
       Call GREEN(#p "LEFT"(#task,8) '- OK')

 If ## = last_msg Then
    Call WHITE(#p 'All tasks run properly...')
