/* REXX -------------  PWD - DD-to-DD writer w/print -----------
|                 runs in both MVS and TSO environments
|
|  FUNCTION:
|                Read an input ddname and put records
|                to the specified output ddname.
|                Designed to be used from PW.
|
|  INPUT:
|                Parm containing input ddname and output ddname.
|                   'inddname outddname'
|                If outddname missing, SYSTSPRNT is a default.
|
|  OUTPUT:
|                Copies records from inddname to outddname.
|
| -------------------------------------------------------------------
|  Hystory of changes (first comes last):
|
|  06-16-2003 SVM Strip trailing blanks when printing to SYSTSPRT
|  03-20-2002 SVM Revised, added read rc check/exit
|  06-24-2002 SVM Created
| -------------------------------------------------------------------
*/

 #prefix = 'PWD: '
 #ouddn = 'SYSTSPRT'
 Parse Arg #inddn #outddn
 If #outddn = '' Then #outddn = #ouddn

 "EXECIO * DISKR "#inddn" (STEM record. FINIS"
 #retc = RC
 If RC <> 0 Then Do
    Say #prefix #inddn '- read error' RC', file skipped'
    Return (#retc)
    End
 Say #prefix'Including' record.0 'records from' #inddn 'to' #outddn
 Do i=1 To record.0
    Say "STRIP"(record.i,'t')
    End
 If #outddn <> #ouddn Then Do
    "EXECIO * DISKW "#outddn" (STEM record. FINIS"
    #retc = "MAX"(RC,#retc)
    End
 Return(#retc)
/*---------------------  End of PWD program  ------------------------*/
