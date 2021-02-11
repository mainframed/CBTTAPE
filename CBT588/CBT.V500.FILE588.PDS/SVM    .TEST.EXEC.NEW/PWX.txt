/* REXX -------------  PWX - Parm-to-DD writer  ------------------
|                 runs in both MVS and TSO environments
|
|  PURPOSE:
|                Use parm containing a sequence of template records
|                separated by a selected character,
|                to write the records to a specified ddname.
|                Designed to be used from PW TEMPL REXX segments
|                for JCL generation.
|
|  FUNCTION:
|                Read template records from Arg,
|                process each record:
|                   a) Replace (%) (if present) by a generic
|                      member name (8 char)
|                   b) skip empty (blank) records
|                   c) write records to the file
|
|  INPUT:
|                Parm containing templates. Format of the parm:
|                   'file template|template|...'
|
|  OUTPUT:
|                Creates file. If multiple calls to PWX are used
|                   set DISP=MOD in your JCL DD for the file.
|
|  EXTERNALS:    REXX functions:
|                DSN4DDN - get DSN for DDN (check if DDN present)
| -------------------------------------------------------------------
|  Hystory of changes (first comes last):
|
|  07-15-2003 SVM Made output records 80 char long
|  05-20-2003 SVM Added DDNAME check before writing
|  03-04-2003 SVM Revised
|  05-30-2002 SVM Created
| -------------------------------------------------------------------
*/

 SIGNAL ON NOVALUE
 #separator = '|'                      /* separator for templates  */
 #prefix = 'PWX: '
 #gmember = '%'
 #retc = 0
 Parse Arg #file #parm
 #file = Translate(#file)

/*--------------------------------------------------------------------
|| Get templates to a stem:
*/

 #i = 0
 Do While(#parm <> '')
    #i = #i + 1
    #col = 'POS'(#separator,#parm)
    If #col > 0 Then
       Parse Var #parm #template.#i (#separator) #parm
    Else Do
       #template.#i = #parm
       #parm = ''
       End
    End
 #template.0 = #i

/*--------------------------------------------------------------------
|| Process templates:
*/

 #total_records = 0

 Do #I = 1 To #template.0
    #record = #template.#I
    If 'LENGTH'(#record) > 0 Then Do
       call #procrec
       #total_records = #total_records + 1
       #frec.#total_records = #record
       End
    Else Say #prefix' - Empty record skipped'
    End

/*-------------------------------------------------------------------
|| Write records to the file:
*/

 If #file <> '' Then Do
    Say #prefix 'Including' #total_records 'records from PARM to',
       #file
    #n = #total_records
    Do #i = 1 to #n
       Say #frec.#i
       #frec.#i = "LEFT"(#frec.#i,80)
       End
    If DSN4DDN(#file) = '' Then Do
       Say #prefix' - File DD name' #file 'not found'
       #retc = 4
       End
    Else If #file <> 'SYSTSPRT' Then Do
       "EXECIO" #n "DISKW" #file "(STEM #frec. FINIS)"
       If RC = 20 Then Do
          Say #prefix' - Error processing file' #file
          #retc = 'MAX'(#retc,4)
          #n = 0
          End
       End
    End
 Else Do
    Say #prefix' - File DD name missing or invalid'
    #retc = 12
    End

/*-------------------------------------------------------------------
|| E X I T
*/

 RETURN #retc
 EXIT #retc

/*===================================================================
|| S U B R O U T I N E S
*/

/*------------------------------------------------------------------
|| Process parm substitutes in record, return all_pars_empty
||   returns:  ab
||   a: parms_empty (1/0), if no parms found in this rec, 1
||   b: parms_found (1/0), parms found in this record
*/

 #procrec: PROCEDURE EXPOSE #record #gmember

/* process generic name: */
 If #record <> '' Then Do
    #s = '('||#gmember||')'
    #j = 'POS'(#s,#record)
    #l = "LENGTH"(#gmember)
    If #j > 0 Then Do
       /* insert generic name */
       #j = #j + 1
       #record = 'SUBSTR'(#record,1,#j-1)||#generic_name(),
          ||'SUBSTR'(#record,#j+#l)
       End
    End
 Return('')

/*-------------------------------------------------------------------
|| Generate a generic name fo member
*/
 #generic_name: PROCEDURE

    parse value 'DATE'('u') with #mm '/' #dd '/' #yy
    parse value 'TIME'('l') with #hh ':' #ii ':' #ss
    parse var #ii 2 #min
    return ('D' || #mm || #dd || #hh || #min)

/*-------------------------------------------------------------------
|| Terminate application when Unitialized variable encountered
*/

  NOVALUE:
    SIGNAL OFF NOVALUE
    SAY #prefix" - Uninitialized variable used:"
    SAY "   "sigl":" Sourceline( sigl )
  EXIT 20
/*-------------------  End of PWX program  ------------------------*/
