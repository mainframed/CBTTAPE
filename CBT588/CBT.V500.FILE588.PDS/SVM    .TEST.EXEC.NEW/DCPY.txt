/* REXX --------------  DCPY - DSN to DD writer  ------------------
|                       runs in any environment
|
|  FUNCTION (used by FTPGET to copy from generic DSN to a ddname):
|                Copy from dsn to a ddn, both passed as ARG.
|
|  INPUT:        Call DCPY(dsn ddn)
|                Parm contains input dsname and output ddname
|                separated by a blank. Both parameters required.
|                No default for ddn. Dsname options:
|                   dsn = 'dsname'
|                   dsn = 'dsname(member)'
|                   dsn = 'dsname(member),volser' or
|                   dsn = 'dsname,volser'
|                   dsn = 'dsname(member),volser' or
|  OUTPUT:
|                If ddn exists, copy there,
|                If dsn or ddn do not exist, issue a message.
|
| -------------------------------------------------------------------
|  Hystory of changes (first comes last):
|
|  03/10/2003 SVM updated to use L_ALC and L_FRE
|  08/27/2002 SVM put idsn parm in front of ofile
|  07/15/2002 SVM Created using SCPY
| -------------------------------------------------------------------
*/
 #prefix = 'DCPY:'
 dsn0 = ''
 ofile = ''
 ifile = 'DCPYDCPY'
 rc_error = 4
 rc_zero = 0

 Arg dsn0 ofile
 If dsn0 = '' Then Do
    Say #prefix 'Input dsname missing'
    RETURN rc_error
    End
 Parse Value dsn0 With dsn ',' volume
 If "SUBSTR"(dsn,1,1) = "'" Then
    Parse Value dsn With "'" dsn "'"

 If ofile = '' Then Do
    Say #prefix 'Output ddname missing'
    RETURN rc_error
    End

 Say #prefix "Allocating input file" dsn0 "as" ifile
 If \L_ALC(ifile,dsn,volume) Then Do
    Say #prefix ifile 'cannot be allocated for' dsn0
    RETURN rc_error
    End

 "EXECIO * DISKR" ifile "(STEM inrec. FINIS"
 Call L_FRE(ifile)
 If RC > 0 Then Do
    Say #prefix 'Input file' ifile '- read error' RC
    RETURN rc_error
    End

 Say #prefix 'Copying file' ifile 'to' ofile '...'
 If ofile <> 'SYSTSPRT' Then Do
    "EXECIO * DISKW" ofile "(STEM inrec. FINIS"
    If RC > 0 Then Do
       Say #prefix 'Output to' ofile '- write error' RC
       RETURN rc_error
       End
    End
 Else Do i = 1 To record.0
    Say record.i
    End
 Say #prefix 'Copy complete,' inrec.0 'records copied'
 RETURN rc_zero
 /*-----------------  End of DCPY program ---------------------------*/
