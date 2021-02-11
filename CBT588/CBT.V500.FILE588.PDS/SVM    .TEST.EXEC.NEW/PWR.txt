/* REXX --------------  PWR - DSN-to-PARM reader  ----------------
|                 runs in both MVS and TSO environment
|
|  FUNCTION      Used in PW templates:
|                Copy from dsn to a string, separating records by
|                '|', then returns the string to caller
|
|  INPUT:
|                Required parm containing input dsname
|                   'dsname'
|                   'dsname(member)'
|                   'dsname(member),volser' or
|                   'dsname,volser'
|
|  OUTPUT:
|                If dsn exists, copy it to the returned string,
|                If dsn does not exist or not supplied, return null
|
| -------------------------------------------------------------------
|  Hystory of changes (first comes last):
|
|  07-15-2003 SVM Strip only trailing blanks
|  07-08-2002 SVM Replaced TSO ALLOC/FREE by L_ALC and L_FRE
|             to serve GDG(0) and better messaging.
|  07-08-2002 SVM Created
| -------------------------------------------------------------------
*/
 #prefix = 'PWR:'
 ifile = 'PWRPWRPW'
 separator = '|'
 dsn0 = ''
 string = ''
 Arg dsn0
 If dsn0 = '' Then Do
    Say #prefix 'Error - input dsname was not specified'
    Return(string)
    End

 dsn0 = "STRIP"(dsn0)
 Parse Value dsn0 With dsn ',' volume
 If "SUBSTR"(dsn,1,1) = "'" Then
    Parse Value dsn With "'" dsn "'"

 If \L_ALC(ifile,dsn,volume) Then Do
    Say #prefix ifile 'cannot be allocated for' dsn0
    Return(string)
    End

 "EXECIO * DISKR" ifile "(STEM inrec. FINIS"
 Call L_FRE(ifile)
 If RC > 0 Then Do
    Say #prefix 'Input dsn' dsn0 '- read error' RC
    Return(string)
    End
 Say #prefix ' -' inrec.0,
    'records copied to parm from' dsn0
 If inrec.0 = 0 Then Return(string)
 string = "STRIP"(inrec.1,'t')
 /* Say inrec.1 */
 Do i = 2 to inrec.0
    string = string || separator || "STRIP"(inrec.i,'t')
    /* Say inrec.i */
    End
 Return(string)
 EXIT
