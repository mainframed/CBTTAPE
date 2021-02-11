/* REXX --------------  SCPY - DD to DSN writer  ------------------
|                       runs in TSO environment
|
|  FUNCTION (used as dummy converter/copy creator for splits):
|                Copy from dd to a dsn, both passed as ARG.
|                If copy successful, write message to a file.
|
|  INPUT:
|                Parm containing input ddname and output dsname.
|                  call SCPY(ifile dsn)
|                defaults are: SENDFILE FTPUSER.TEMP.LOG
|                dsn can contain PDS member name or GDG relative #:
|                'ABC.MYPDS(MYMEMB)',  'ABC.MYGDG(+1)'.
|                No HLQ will be added to the dsn given.
|
|  OUTPUT:
|                If dsn exists, copy and reset LRECL and BLKSIZE.
|                If dsn does not exist, create and copy there.
|
|  EXTERNALS:
|                REXX functions:
|                L_DDN - replacement for ListDSI that fails with VIO
|                L_DSN - Replacement for ListDSI for dsn/GDG
|                DSN4DDN -check if DD allocated
| -------------------------------------------------------------------
|  Hystory of changes (first comes last):
|
|  07-21-2003 SVM Stripped input parameters
|  05-27-2003 SVM Updated for big files, VIO files and GDG
|  07-02-2002 SVM Created
| -------------------------------------------------------------------
*/
 #prefix = 'SCPY:'
 #odsn = 'FTPUSER.TEMP.LOG'
 #ifile = 'SENDFILE'
 #ofile = 'FILESEND'
 #mfile = 'SCPYMSGF'

 dsn = ''
 ifile = ''
 Arg ifile parmdsn
 parmdsn="STRIP"(parmdsn)
 ifile = "STRIP"(ifile)
 If parmdsn = '' Then parmdsn = #odsn
 dsn = "'"||parmdsn||"'"
 If ifile = '' Then ifile = #ifile

/*-------------------------------------------------------------------
|  Check input file (L_DDN works even it is VIO):
*/
 If L_DDN(ifile) = 0 Then Do
    Say #prefix 'Input file' ifile 'not found'
    EXIT 8
    End
 primary = SYSPRIMARY
 seconds = SYSSECONDS
 inrecfm = SYSRECFM
 inunits = SYSUNITS
 If inunits = 'BLOCK' Then
    inunits = 'TRACK'
 inrecl  = SYSLRECL
 If primary = '' |,
    seconds = '' |,
    inrecfm = '' |,
    inunits = '' |,
    inrecl =  '' Then Do
    /**** This should not ever happen, but... ****/
 /* Call L_WTO(#prefix 'Empty parm returned by L_DDN') */
    Say #prefix 'Empty parm returned by L_DDN:'
    Say '   SYSPRIMARY =' SYSPRIMARY
    Say '   SYSSECONDS =' SYSSECONDS
    Say '   SYSRECFM   =' SYSRECFM
    Say '   SYSUNITS   =' SYSUNITS
    say '   SYSLRECL   =' SYSLRECL
    End

/*-------------------------------------------------------------------
|  Check output file: allocate if exists, create if not:
|  (can use either DSN4DDN or L_DDN, L_DDN will update SYS* variables)
*/
 If DSN4DDN(#ofile) <> '' Then Do
    "FREE DDNAME("#ofile")"
    Say #prefix "Freeing ddname "#ofile" ... RC="rc
    End

 Parse Var parmdsn dsn1 '(' member ')'
 gdg = ("DATATYPE"(member) = 'NUM')
 If gdg Then old = L_DSN(parmdsn)
 Else        old = L_DSN(dsn1)
 If old Then Do
    /*** Allocate existing ***/
    If gdg Then dsn="'"SYSDSNAME"'"
    orecl = SYSLRECL
    If orecl < inrecl Then Do
       Say #prefix 'Changing LRECL='orecl 'to' inrecl 'for:' dsn"..."
       End
    "ALLOC DD(" || #ofile || ")",
       "LRECL(" || inrecl || ")",
       "BLKSIZE(0)",
       "DA(" || dsn || ")",
       "SHR"
    If RC <> 0 Then Do
       Say #prefix 'Allocation for existing dsn' dsn 'failed'
       EXIT 8
       End
    End
 Else Do
    /*** Create new: ***/
    recfm = "SUBSTR"(inrecfm,1,1)
    Do i = 2 To "LENGTH"(inrecfm)
       recfm = recfm "SUBSTR"(inrecfm,i,1)
       End

    If gdg Then dsn = "'"SYSDSNAME"'"
    "ALLOC DD(" || #ofile || ")",
          "DA(" || dsn || ")",
          "LRECL(" || inrecl || ")",
          "SPACE(" || primary || "," || seconds || ")",
          "RECFM(" || recfm || ")",
          "BLKSIZE(0)",
          "NEW",
          inunits,
          "CATALOG",
          "RELEASE"
    Say #prefix "Allocating new "dsn" ... RC="rc

    If RC <> 0 Then Do
       Say #prefix 'Allocation failed' RC
       EXIT 8
       End
    End

/*-------------------------------------------------------------------
|  Update dsn for GDG and copy data:
*/
 If L_DDN(#ofile) Then
    dsn = SYSDSNAME
 If member <> '' Then
    If "DATATYPE"(member) <> 'NUM' Then
       dsn = dsn || '('member')'
 msg.1 = 'Report saved to DSN =' dsn
 Say #prefix 'Copying file' ifile 'to' dsn '...'
 irec# = 0
 orec# = 0
 "EXECIO 0 DISKW" #ofile "(OPEN"
 If RC > 0 Then Do
    Say #prefix 'Open error' RC 'file' #ofile
    EXIT 8
    End
 Do Forever /* Exit to EOF done by GETREC */
    Call GETREC
    "EXECIO 1 DISKW" #ofile
    If RC > 0 Then Do
       Say #prefix 'Write error' RC 'record' irec#
       "EXECIO 0 DISKW" #ofile "(FINIS"
       EXIT 8
       End
    Else orec# = orec# + 1
    End

 EOF:
 "EXECIO 0 DISKW" #ofile "(FINIS"
 Say #prefix 'Copy complete,' orec#,
    'records copied'

/*-------------------------------------------------------------------
|  Write optional message(s) to a temp file:
*/
 If DSN4DDN(#mfile) <> '' Then Do
    "EXECIO * DISKW" #mfile "(STEM msg. FINIS"
    End
 EXIT

/*-------------------------------------------------------------------
|  Read a record from ifile:
*/
GETREC:
 "EXECIO 1 DISKR" ifile
 /* record in stack */
 If RC <> 0 Then Do
    "EXECIO 0 DISKR" ifile "(FINIS"
    Signal EOF
    End
 irec# = irec# + 1
 Return
