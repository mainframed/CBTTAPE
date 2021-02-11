/* REXX
| ......................  PW - Parm Writer  .........................
|  Hystory of changes (first comes last):
|
|  03-18-2003 SVM Fixed bug if parm from Arg is empty
|  02-24-2003 SVM Added DSN4DDN call to check if Write ddname
|                     and TEMPL ddname are available.
|  09-23-2002 SVM Added DSN4DDN call to check if PARM ddname avail.
|  06-26-2002 SVM Added parm concatenation from PARM ddname.
|  06-04-2002 SVM Changed comments, added Signal ON Novalue.
|                     Included output to file into procpack.
|  05-17-2002 SVM added p10-p99, added continuation records.
|                     renamed vars to #vars to avoid intererence
|                     with interpreted variables
|  04-25-2002 SVM Changed writing files sequence
|  04-09-2002 SVM Created
| -------------------------------------------------------------------
|                runs in both MVS and TSO environment
|
|  PURPOSE:
|                Create temporary files for further use in
|                the next steps of the JOB.
|                Execute in-line REXX
|
|  FUNCTION:
|                1) Read and validate parameters from Arg and
|                   optionally from PARM ddname (as Arg extension)
|                   Parameters in list must be separated by '|'
|                2) Read template file, parse 1st col to x
|                   and cols 2 to 72 to record (ignore cols 73-80)
|                Process each record:
|                   a) Substitute parameters in place of names &n
|                   where n is a parameter number, n=1,2,...,99
|                   (use &1.1 to distinguish &1 from &11)
|                   If at least one parameter present and all the
|                   parameters present are empty, set flag empty.
|                   Continuation records share the same flag empty.
|                   b) Replace (%) if present by a generic (name)
|                   c) process the resulting record:
|                   - when x = alphanumeric,
|                     write record to SYSUTx file
|                     ignore all records with flag empty
|                   - when x = blank, interpret record as REXX
|                     program line, example:
|                      "CALL *(SEND) '&5' ASIS"
|                     - calls program SEND with user-supplied parm.
|                     Every next record starting also with a blank
|                     is processed with the previous as a
|                     continuation. No flag empty is applicable.
|                   - when x = + process this record as
|                     a continuation.
|                Advanced users: You can set values for parameters
|                in REXX code: for param &n use variable name p.n
|                Do not use name p in your code for anything else.
|                See PWX, - write variable to a ddname,
|                    PWI, - copy datadst(member) to an output ddname,
|                    PWD, - copy input ddname to an output ddname,
|                    LISTPDS - get list of PDS members (TSO env only)
|
|  INPUT:
|                1) Parm containing: '&1|&2|...  '
|                   parameter number defined by position.
|                2) PARM ddname file might contain continuation of
|                   parameter received from PARM.EXEC.
|                2) Template file containing &n as a reference to
|                   the specific parm. &n is replaced param value
|                   (e.g. &11 is replaced by p.11 value)
|                   Example: if &11 = A and &1 = B    then
|                   &11 is replaced by 'A'
|                   &1.1 is replaced by 'B1'
|  OUTPUT:
|                1) Creates files SYSUTx, x = any alphanumeric char
|
|  EXTERNALS:
|                DSN4DDN - load module (REXX function)
| -------------------------------------------------------------------
*/

 Signal On Novalue                     /* Stop if unassigned var     */
 #prefix = 'PW:'                       /* Message prefix             */
 #cont_char = '+'                      /* placed in 1st column       */
 #separator = '|'                      /* Card separator for Parm    */
 #templ = 'TEMPL'                      /* Template file DDname       */
 #ddparm = 'PARM'                      /* parameter file ddname      */

 Parse Arg #parm

 /* Add optional continuation to #parm:                              */
 If DSN4DDN(#ddparm) <> '' Then Do
    "EXECIO * DISKR" #ddparm "(STEM #prm. FINIS"
    If #prm.0 > 0 Then Do
       Say #prefix #ddparm 'file records read:'#prm.0
       #i = 1
       If #parm = '' Then Do
          #parm = #separator || "STRIP"(#prm.1)
          #i = 2
          End
       Do #i = #i to #prm.0
          #parm = #parm || #separator || "STRIP"(#prm.#i)
          End
       Drop #prm.
       End
    Else
       Say #prefix 'Optional PARM DD is empty'
    End
 Else
    Say #prefix 'Optional PARM DD is not specified'
 Say #prefix' Parm="'||#parm||'"'

/* Get positional parameters:                                        */
 #i = 0
 Do While(#parm <> '')
    #i = #i + 1
    #col = 'POS'(#separator,#parm)
    If #col > 0 Then
       Parse Var #parm p.#i (#separator) #parm
    Else Do
       p.#i = #parm
       #parm = ''
       End
    End
 p.0 = #i

 Do #i = 1 to p.0
    Say #prefix' p.'||#i||'="'||p.#i||'"'
    End

 Do #i = p.0 + 1 to 99
    p.#i = ''
    End

/*-------------------------------------------------------------------
|| Read template file to template array and process templates:
*/

 #total_records = 0
 #retc = 0
 If DSN4DDN(#templ) <> '' Then
    "EXECIO * DISKR" #templ "(STEM #template. FINIS"
 Else Do
    #template.0 = 0
    Say #prefix 'Optional' #templ 'DD is not specified'
    End

 Say #prefix' - File read from ddn('||#templ,
    ||') total records: ' || #template.0

 #xx = ' '
 #buffer = ''
 Do #I = 1 To #template.0
    Parse Value #template.#I With #x 2 #record 72
    Parse Upper Var #x #x

    /* Process record: */
    If (#x = #cont_char),
       | (#x = ' ' & #xx = ' ') Then Do
       /* process continuation record: */
       Parse Value #procrec() With #parms_empty 2 #parms_found
       Select
       When #xx = ' ' Then Do
          /* add record to command buffer: */
          #record = 'STRIP'(#record)
          #buflen = 'LENGTH'(#buffer)
          Select
          When #buflen=0 Then Nop
          When 'SUBSTR'(#buffer,#buflen,1) = ',' Then
             #buffer = 'SUBSTR'(#buffer,1,#buflen-1) || ' '
          Otherwise
             #buffer = #buffer || ';'
          End
          #buffer = #buffer || #record
          End
       When 'DATATYPE'(#xx,'A') Then Do
          /* Array record to SYSUTx */
          If 'LENGTH'(#record) > 0 Then Do
             #total_records = #total_records + 1
             #fid.#total_records = #xx
             #frec.#total_records = #record
             End
          Else Say #prefix' * Empty record skipped'
          #all_parms_found = #all_parms_found | #parms_found
          #all_parms_empty = #all_parms_found,
             & #all_parms_empty,
             & #parms_empty
          End
       Otherwise Do
          Say #prefix' * Continuation data invalid,',
              'record skipped'
          #retc = 'MAX'(4,#retc)
          End
       End
       End
    Else Do
       /* process old package: */
       Call #procpack
       /* Start new   package: */
       Parse Value #procrec() With #parms_empty 2 #parms_found
       #xx = #x
       #all_parms_found = 0
       #all_parms_empty = 1
       Select
          When #xx = ' ' Then Do
             /* add record to command buffer: */
             #record = 'STRIP'(#record)
             #buffer = #record
             End
          When 'DATATYPE'(#xx,'A') Then Do
             /* Array record to SYSUTx */
             If 'LENGTH'(#record) > 0 Then Do
                #total_records = #total_records + 1
                #fid.#total_records = #xx
                #frec.#total_records = #record
                End
             Else Say #prefix' * empty record skipped'
             #all_parms_found = #all_parms_found | #parms_found
             #all_parms_empty = #all_parms_found,
                & #all_parms_empty,
                & #parms_empty
             End
          Otherwise Do
             Say #prefix' * First   character invalid,',
                 'record skipped'
             #retc = 'MAX'(4,#retc)
             End
          End
       End
    Say #template.#i
    End /* Do */
 Call #procpack

/*-------------------------------------------------------------------
|| E X I T
*/

 Say #prefix' - Processing complete, max RC=' #retc
 Exit #retc

/*-------------------------------------------------------------------
|| S U B R O U T I N E S
*/

/*-------------------------------------------------------------------
|| Write records to the SYSUTx files:
*/

 #Write: PROCEDURE EXPOSE #total_records #fid. #frec. #prefix #retc
 Do #i = 1 To #total_records
    #x = #fid.#i
    If #x <> '' Then Do
       /* collect all records with fid = x into stack and write      */
       "NEWSTACK"
       #n = 0
       Do #j = #i To #total_records
          If #fid.#j = #x then do
             #n = #n + 1
             #fid.#j = ''
             QUEUE #frec.#j
             End
          End
       #ddname = 'SYSUT'||#x
       Say #prefix' - writing' #n 'records to file' #ddname '...'
       If DSN4DDN(#ddname) <> '' Then Do
       "EXECIO * DISKW" #ddname "(FINIS"
          If RC = 20 Then Do
             Say #prefix' * Error processing file' #ddname
             #retc = 'MAX'(#retc,4)
             End
          End
       Else
          Say #prefix 'Requested' #ddname 'DD is not specified'
       "DELSTACK"
       End
    End
 Return

/*-------------------------------------------------------------------
|| Procpack: Intrpret command buffer (if any):
*/

 #procpack:
 If #buffer <> '' Then Do
    /* interpret and clear command buffer: */

    Signal Off Novalue                 /* ignore user code errors   */
    INTERPRET (#buffer)
    Signal On  Novalue

    Say #prefix' - interpreted, RC='||RC
    RC="ABS"(RC)
    #retc = 'MAX'(RC,#retc)
    #buffer = ''
    End
 If #xx <> ' ' Then Do
    Do #j = #total_records By -1 To 1,
       While(#fid.#j = #cont_char)
       #fid.#j = #xx
       End
    If #all_parms_empty Then #total_records = 'MAX'(0,#j- 1)
    If #total_records > 0 Then
       Call #write
    End
 Return

/*------------------------------------------------------------------
** Process parm substitutes in record, return all_pars_empty
**   returns:  ab
**   a: parms_empty (1/0), if no parms found in this rec, 1
**   b: parms_found (1/0), parms found in this record
*/

 #procrec: PROCEDURE EXPOSE p. #record #x #xx #cont_char
 #col = 1
 #parms_empty = 1
 #parms_found = 0
 #j = 'POS'('&',#record)

 Do While(#j > 0)
    /* substitute parameter */
    #col1 = #col + #j - 2
    #col2 = #col + #j
    #n1 = 'SUBSTR'(#record,#col2,1)
    #n2 = 'SUBSTR'(#record,#col2+1,1)
    #nn = 'SUBSTR'(#record,#col2,2)
    #dot = 'SUBSTR'(#record,#col2+1,1)
    Select
       When 'DATATYPE'(#n1) = 'NUM',
          & 'DATATYPE'(#n2) = 'NUM' Then Do
          #param = p.#nn
          #parms_empty = #parms_empty & (#param = '')
          #parms_found = 1
          #col2 = #col2 + 2
          End
       When 'DATATYPE'(#n1) = 'NUM' Then Do
          #param = p.#n1
          #parms_empty = #parms_empty & (#param = '')
          #parms_found = 1
          If #dot = '.' Then #col2 = #col2 + 2
          Else               #col2 = #col2 + 1
          End
       Otherwise Do
          /* this is not a parm: */
          #param = ''
          #col1 = #col2 - 1
          End
       End
    #record = 'SUBSTR'(#record,1,#col1) || #param,
       || 'SUBSTR'(#record,#col2)
    #col = #col1 + 'LENGTH'(#param) + 1
    #j = 'POS'('&','SUBSTR'(#record,#col))
    End

/* process generic name only for output records: */
 #output = ('DATATYPE'(#x,'A'),
    | ((#x = #cont_char) & 'DATATYPE'(#xx,'A')))
 If #record <> '' & #output Then Do
    #j = 'POS'('(%)',#record)
    If #j > 0 Then Do
       /* insert generic name */
       #j = #j + 1
       #record = 'SUBSTR'(#record,1,#j-1)||#generic_name(),
          ||'SUBSTR'(#record,#j+1)
       End
    End
 Return(#parms_empty || #parms_found)

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
/*----------------------  End of PW program  ------------------------*/
