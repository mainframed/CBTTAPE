/* REXX ------------  PWI - DSN-to-DD writer w/print  --------------
|                runs in any environment
|
|  FUNCTION:
|                Read a text dataset or PDS member and put records
|                to the specified output ddname using PWX subroutine.
|                Print a copy to SYSTSPRT.
|                Designed to be used from PW.
|
|  INPUT:        Call PWI(dsn ddn)
|                Parm contains input dsname and output ddname
|                separated by a blank. Second parameter is optional.
|                Default ddn='SYSTSPRT'. Dsname options:
|                   dsn = 'dsname'
|                   dsn = 'dsname(member)'
|                   dsn = 'dsname(member),volser' or
|                   dsn = 'dsname,volser'
|                   dsn = 'dsname(member),volser' or
|
|  OUTPUT:
|                Copies records from dsn(member) to ddname.
|
| -------------------------------------------------------------------
|  Hystory of changes (first comes last):
|
|  07-15-2003 SVM Strip trailing blanks when printing to SYSTSPRT
|  03-04-2003 SVM Replaced ALLOC/FREE to L_ALC and L_FRE
|  08-23-2002 SVM Changed ALLOC/FREE to work in MVS environment
|  06-24-2002 SVM Created
| -------------------------------------------------------------------
*/

 #prefix = 'PWI: '
 dsn0 = ''
 ofile = ''
 ifile = 'PWIPWIPW'
 #ofile = 'SYSTSPRT'
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

 If ofile = '' Then ofile = #ofile

 If \L_ALC(ifile,dsn,volume) Then Do
    Say #prefix ifile 'cannot be allocated for' dsn0
    RETURN rc_error
    End

 "EXECIO * DISKR" ifile "(STEM record. FINIS"
 Call L_FRE(ifile)
 If RC > 0 Then Do
    Say #prefix 'Input file' ifile '- read error' RC
    RETURN rc_error
    End

 Say #prefix'Including' record.0 'records from' dsn 'to' ofile
 If ofile <> 'SYSTSPRT' Then Do
    "EXECIO * DISKW" ofile "(STEM record. FINIS"
    If RC > 0 Then Do
       Say #prefix 'Output to' ofile '- write error' RC
       RETURN rc_error
       End
    End
 Do i = 1 To record.0
    Say "STRIP"(record.i,'t')
    End
 RETURN rc_zero
/*---------------------  End of PWI program  ------------------------*/
