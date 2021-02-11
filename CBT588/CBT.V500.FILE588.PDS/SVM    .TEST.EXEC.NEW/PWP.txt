/* REXX --------------  PWP - DD-to-DD writer ---------------
|                 runs in both MVS and TSO environments
|
|  FUNCTION:
|                Read an input ddname and put records
|                to the output ddname (default SYSTSPRT)
|                Designed to be used from PW for debug
|
|  INPUT:
|                Parm containing input and, optionally, output ddname
|                   'inddname outddname'
|
|  OUTPUT:
|                Copies records from inddname to SYSTSPRT.
|
| -------------------------------------------------------------------
|  Hystory of changes (first comes last):
|
|  03-20-2003 SVM Revised, added read rc check/exit
|  07-19-2002 SVM Removed prefix, added outddname
|  07-08-2002 SVM Created
| -------------------------------------------------------------------
*/

 #prefix = 'PWP: '
 #ouddn = 'SYSTSPRT'
 Parse Arg #inddn #outddn
 If #outddn = '' Then #outddn = #ouddn

 Say #prefix'Including' #inddn 'to' #outddn
 "EXECIO * DISKR "#inddn" (STEM record. FINIS"
 #retc = RC
 If RC <> 0 Then Do
    Say #prefix #inddn '- read error' RC', file skipped'
    Return (#retc)
    End
 If #outddn = 'SYSTSPRT' Then
    Do i = 1 To record.0
       Say "STRIP"(record.i,'t')
       End
 Else Do
    "EXECIO * DISKW "#outddn" (STEM record. FINIS"
    #retc = "MAX"(RC,#retc)
    End
 Return(#retc)
 Exit
/*---------------------  End of PWP program  ------------------------*/
