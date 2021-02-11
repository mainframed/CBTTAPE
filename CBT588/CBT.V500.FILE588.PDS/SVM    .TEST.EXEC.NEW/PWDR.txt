/* REXX --------------  PWDR - DDN-to-PARM reader  ----------------
|                        runs in any environment
|
|  FUNCTION
|                Copy from dd to a string, separating records by
|                '|', then returns the string to caller
|
|  INPUT:
|                Parm containing input ddname
|                   'ddname'
|
|  OUTPUT:
|                If dd exists, copy it to the returned string,
|                If dd does not exist or not supplied, return ''
|
| -------------------------------------------------------------------
|  Hystory of changes (first comes last):
|
|  07-15-2003 SVM Strip only trailing blanks
|  03/20/0302 SVM Changed to return null when error
|  07-08-2002 SVM Created
| -------------------------------------------------------------------
*/
 #prefix = 'PWDR:'
 separator = '|'
 string = ''
 ddname = ''
 Arg ddname
 If ddname = '' Then Do
    Say #prefix 'Error - input ddname was not specified'
    Return(string)
    End
 ddname = "STRIP"(ddname)
 "EXECIO * DISKR" ddname "(STEM inrec. FINIS"
 If RC > 0 Then Do
    Say #prefix 'Input file' ddname '- read error' RC
    Return(string)
    End
 Say #prefix ' -' inrec.0,
    'records copied to parm from' ddname
 If inrec.0 = 0 Then Return(string)
 string = "STRIP"(inrec.1,'t')
 Do i = 2 to inrec.0
    string = string || separator || "STRIP"(inrec.i,'t')
    End
 Return(string)
 EXIT
