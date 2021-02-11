/* --------------------  rexx procedure  -------------------- *
 | Name:      pdsegcpr                                        |
 |                                                            |
 | Function:  ISPF Edit Macro to compare the current member   |
 |            to another mbr and/or generation                |
 |                                                            |
 | Usage Notes:  compare member generation                    |
 |               or                                           |
 |               compare generation                           |
 |                                                            |
 |               To use the native ISPF Compare first         |
 |               issue the COMPARE RESET command.             |
 |                                                            |
 |               No need if non-generation or other dataset   |
 |               as normal compare handles that               |
 |                                                            |
 | Dependencies:  The PDSEGENM edit macro                     |
 |                PDSEGENS settings exec                      |
 |                                                            |
 | Process:   If the compare is for a generation then the     |
 |            generation is copied into a temporary dataset   |
 |            that is allocated using the same DCB as the     |
 |            source dataset. Then the ISPF Edit Compare      |
 |            command is invoked using the BUILTIN command    |
 |            to compare the current member/generation to     |
 |            the temp dataset. After the compare the temp    |
 |            dataset is deleted as it is no longer needed.   |
 |                                                            |
 |            If the compare is to a base member or another   |
 |            dataset then the ISPF Compare command is        |
 |            invoked using the BUILTIN command.              |
 |                                                            |
 | Author:    Lionel B. Dyck                                  |
 |                                                            |
 | History:  (most recent on top)                             |
 |            04/17/20 - Add Compare RESET option             |
 |            04/04/20 - Fix typo in parm for option R        |
 |            11/24/17 - Update to support changed PDSEGENS   |
 |            05/19/17 - Change to use Edit Macro Parm        |
 |            10/07/16 - Additional code to support compares  |
 |                       for non-0 gens                       |
 |            09/30/16 - Correction and add Exclude           |
 |            09/29/16 - Allow only a generation              |
 |            09/28/16 - Creation                             |
 |                                                            |
 * ---------------------------------------------------------- */
 Address ISREdit
 'Macro (options)'
 parse value '' with null odsn deltemp

/* ----------------------- *
 | If no options just exit |
 * ----------------------- */
 if options = null then exit

 if translate(options) = 'RESET' then do
  'define compare reset'
  'define compare reset'
   zedsmsg = ''
   zedlmsg = 'Compare override removed. Compare will now work' ,
             'as natively implemented in ISPF but will no longer' ,
             'support generations.'
    Address ISPExec 'setmsg msg(isrz001)'
    exit
    end

/* ---------------------------------------------------- *
 | Check passed options                                 |
 | if only 1 then use native compare                    |
 |    unless it is a generation number                  |
 | if only 2 options and option 2 not numeric then use  |
 |    native compare                                    |
 | if option 2 is numeric and 0 then use native compare |
 |    as generation 0 is a base member                  |
 | otherwise use compare extension                      |
 * ---------------------------------------------------- */
 do_compare = 0
 if words(options) = 1
    then if datatype(options) /= 'NUM' then
         do_compare = 1
    else do
         '(mbr)  = member'
         options = mbr options
         end
 if words(options) = 2 then do
    if datatype(word(options,2)) /= 'NUM' then do_compare = 1
    if word(options,2) = 0 then do
       options = word(options,1)
       do_compare = 0
       end
    end

/* -------------------------------------- *
 | If do_compare is set to 1 then use the |
 | builtin function to run the native     |
 | ISPF Compare on the member or dataset. |
 * -------------------------------------- */
 if do_compare = 1 then do
    'Builtin Compare' options
    if rc > 0 then
       Address ISPExec ,
       'setmsg msg(isrz002)'
    exit 0
    end

/* --------------------------------------- *
 | Get the current dataset characteristics |
 * --------------------------------------- */
 '(dataset) = dataset'
 '(member)  = member'
 Address ISPExec "dsinfo dataset('"dataset"')"
  recfm = left(zdsrf,1)
  lrecl = zdslrec + 0
  blksize = zdsblk + 0

 Address ISPExec
 'Control Errors Return'

/* ------------------------------------------------- *
 | Parse the passed options and check to verify that |
 | the requested member and generation exist.        |
 * ------------------------------------------------- */
 parse value options with mbr gen
 mbr = translate(mbr)
 pdsemopt = 'T'
 "LMINIT DATAID(zpdsendd) DATASET('"dataset"')"
 "LMOPEN DATAID("zpdsendd") OPTION(INPUT)"
 'view dataid('zpdsendd') member('mbr') gen('gen')' ,
        'macro(pdsegenm) parm(pdsemopt)'
 erc = rc

 if erc > 4 then do
   zedsmsg = 'Invalid Member/Gen'
   zedlmsg = 'The specified member:' mbr 'or Generation:' gen ,
             'is not valid.'
   'Setmsg msg(isrz001)'
   "LMClose Dataid("zpdsendd")"
   "LMFree  Dataid("zpdsendd")"
   exit
   end

/* ----------------------------------------------- *
 | Call PDSEGENS for tempmem and default unit into |
 * ----------------------------------------------- */
 x = pdsegens()
 parse value x with  mail '/' etime '/' higen ,
              '/' base_color '/' sort_color '/' clean ,
              '/' prune_prompt '/' tempmem '/' def_unit ,
              '/' x
 tempmem  = strip(tempmem)
 def_unit = strip(def_unit)
 if def_unit /= null then
    def_unit = 'unit('def_unit')'

/* ------------------------------------------------------- *
 | Check for current member being generation 0 and copy to |
 | a temp member for the compare                           |
 * ------------------------------------------------------- */
 Address ISPExec 'vget (agen mgen)'
 if agen /= 0 then do
    hgen = gen
    gen = agen
    call create_temp 'xx'
    gen  = hgen
    odsn = tdsn
    deltemp = 1
    end

/* -------------------------------------------------- *
 | Call the routine to create a temporary dataset for |
 | the requested member generation so the compare     |
 | can access it.                                     |
 * -------------------------------------------------- */
 call create_temp

 if odsn = null then do
   /* ------------------------------------------------------- *
    | Invoke the native ISPF Compare command to compare       |
    | the current member with the requested member generation |
    * ------------------------------------------------------- */
    Address ISREdit

    'Builtin Compare' tdsn 'exclude'

    parse value '0 0 0' with line sline lline

    'Locate first label'
    if rc = 0 then do
       '(lline) = cursor'
       end

    'Locate first special'
    if rc = 0 then do
       '(sline) = cursor'
       end

    if sline = 0 then sline = lline
    if lline = 0 then lline = sline

    if sline > lline then line = lline
                     else line = sline

    if line > 0 then
       'Locate' line -1

    if line = 0 then line = 1

    msg = '===> Comparing current member' member 'to' mbr'('gen')'

    if line > 1
     then "line_before" line "= MSGLine '"msg"'"
     else "line_after 0 = MSGLine '"msg"'"
    end
 else do
     /* ------------------------------------------- *
      | Compare the temp member to the temp dataset |
      * ------------------------------------------- */
      Address ISPExec
      cmem     = mbr
      cto      = gen
      cfrom    = mgen
      todsn    = tdsn
      pdsemopt = 'COM'
      'vput (todsn deltemp cmem cfrom cto)'
      'view dataset('odsn') confirm(no) chgwarn(no) macro(pdsegenm)' ,
            'parm(pdsemopt)'
      if deltemp = 1 then do
         pdsedd = 'PCPR'random(999)
         pdsedsn = "'"dataset"'"
         Address TSO
         'Alloc f('pdsedd') shr reuse ds('pdsedsn')'
         x = pdsegdel(tempmem,0,pdsedd)
         'Free f('pdsedd')'
         end
      end

/* ---------------------------------------------- *
 | Now free the allocations and exit back to Edit |
 * ---------------------------------------------- */
 if odsn = null then
    Address TSO ,
        'Free f('tpdsendd') Delete'
 Address ISPExec
"LMClose Dataid("zpdsendd")"
"LMFree  Dataid("zpdsendd")"
 Exit

/* --------------------------------------------------- *
 | Create_temp routine will copy the requested         |
 | member generation to a temporary dataset so         |
 | that the native ISPF Compare command can access it. |
 * --------------------------------------------------- */
 Create_Temp:
    arg t_opt
    if t_opt = null then do
    tpdsendd = 'PDSET'random(999)
    if sysvar('syspref') = null then hlq = sysvar('sysuid')
                                else hlq = sysvar('syspref')
    tdsn = "'"hlq'.PDSEGEN.TEMP.'tpdsendd'.'mbr"'"
    Address TSO ,
     'Alloc f('tpdsendd') ds('tdsn') new spa(15,50) tr' ,
        'Recfm('recfm' B) lrecl('lrecl') blksize('blksize')' ,
        def_unit
    end
    else tdsn = "'"dataset"("tempmem")'"
 /* ---------------------------------- *
  | Copy all records from 'old' mbr    |
  | using the Replace Edit command     |
  * ---------------------------------- */
   pdsemopt = 'R'
   pdsecpds = tdsn
   'vput (pdsecpds)'
   'view dataid('zpdsendd') member('mbr') gen('gen')' ,
        'macro(pdsegenm) parm(pdsemopt)'
 return
