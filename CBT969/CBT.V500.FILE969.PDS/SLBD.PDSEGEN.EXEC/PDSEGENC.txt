/* --------------------  rexx procedure  -------------------- */
  pdsegver = pdsegver()
/* Name:      pdsegenc                                        *
 *                                                            *
 * Function:  Copy a PDSE to a new PDSE along with all        *
 *            generations                                     *
 *                                                            *
 * Syntax:    %pdsegenc from to member-pattern  ( options     *
 *                                                            *
 *            Allowed patterns described below                *
 *                                                            *
 *            valid options are:                              *
 *                                                            *
 *            Batch   - used when running under TSO/ISPF to   *
 *                      prevent the popup progress indicator  *
 *                                                            *
 *            New     - will cause the 'to' dataset to be     *
 *                      created using the 'from' for the      *
 *                      allocation info.                      *
 *                                                            *
 *            Replace - will replace members of the same      *
 *                      name during the copy                  *
 *                                                            *
 *            No closing ) for options                        *
 *                                                            *
 *            Defaults: no-batch not-new no-replace           *
 *                                                            *
 * Notes:     All members in the from will be copied into     *
 *            the to dataset, including all generations.      *
 *            Member pattern matching is supported:           *
 *                                                            *
 *    if filter is x: then test for member starting with x    *
 *    if filter is x/ then test for member with x anywhere    *
 *    if filter is /x then test for member with x anywhere    *
 *    if filter is x then test for x                          *
 *    if filter has * or % then test for pattern              *
 *       using pdsegmat (rexx function)                       *
 *    if filter has : within then use from: to                *
 *    if filter is (mem mem mem) with or without masks        *
 *                                                            *
 *    All date filters work as well and may be combined with  *
 *    a pattern.                                              *
 *                                                            *
 *            The ISPF statistics for the base (gen 0)        *
 *            member are retained but for the generations     *
 *            those are effectively created as new by this    *
 *            copy process (since lmcopy doesn't understand   *
 *            generations).                                   *
 *                                                            *
 *            The copy process consists of using ISPF edit    *
 *            macros to copy all the records from the         *
 *            generation (non-0 only) to the clipboard and    *
 *            then paste the records into the member in the   *
 *            target PDSE. The copy is done from the oldest   *
 *            generation to the newest and then lmcopy is     *
 *            used to copy the base. This causes the          *
 *            generation to remain in the same relative       *
 *            order but the absolute generation numbers are   *
 *            lost.                                           *
 *                                                            *
 *            If any dummy members are found then they will   *
 *            be ignored since there is no way to know if     *
 *            they are valid or not and in most cases are not.*
 *                                                            *
 * Author:    Lionel B. Dyck                                  *
 *                                                            *
 * History:                                                   *
 *            09/10/19 - Fix pdsegeni parse for mmod          *
 *            08/19/19 - Fix filter/options bug               *
 *            08/13/19 - Support from:to filter               *
 *                     - Support filter (mem mem mem)         *
 *            10/15/18 - Correct long record for lrecl=80     *
 *            05/10/18 - Update if no date_filter and correct *
 *                       copy message if copy error           *
 *            11/27/17 - If no members copied exit with rc 4  *
 *            11/24/17 - Update to support changed PDSEGENS   *
 *            08/14/17 - Change to use pdsegver for pdsegen   *
 *                       version                              *
 *            06/20/17 - Version change only                  *
 *            06/08/17 - Version change only                  *
 *            05/30/17 - Version change only                  *
 *            05/19/17 - Change to use Edit Macro Parm        *
 *            04/04/17 - Correct batch report                 *
 *                     - Recurse into APPL(PDSE) if not       *
 *            03/10/17 - Correct lrecl for browse of msgs     *
 *            03/03/17 - If (batch is specified then browse   *
 *                       messages instead of directing them   *
 *                       to the terminal                      *
 *            01/19/17 - Version change only                  *
 *            01/05/17 - Version change only                  *
 *            12/13/16 - Fix for null members                 *
 *            10/07/16 - Allow null default unit              *
 *                     - correction for ttr check             *
 *            09/12/16 - Get default unit for alloc from      *
 *                       PDSEGENS                             *
 *                     - additional test for null member name *
 *            09/01/16 - Add Batch and New options and use    *
 *                       enhanced pattern matching            *
 *                     - Support Date filtering               *
 *                     - if ttr is x'000000' then ignore as   *
 *                       it's a dummy member                  *
 *            08/25/16 - If the target PDS has maxgen of 0    *
 *                       then don't copy generations          *
 *            08/15/16 - Correction for copy count (dummy)    *
 *            08/04/16 - Correction for noprefix users        *
 *            07/27/16 - Correction if used to copy non-gen   *
 *                       enabled pds                          *
 *            07/25/16 - Change to dsinfo for topdse          *
 *                     - Change from using ISRZ001 to ISRZ002 *
 *            07/21/16 - Add display progress for base members*
 *                     - Add elapsed time to message          *
 *            07/18/16 - Update to use Replace instead of     *
 *                       cut/paste                            *
 *            07/06/16 - Support filter a for member a        *
 *                       and for /a like a/                   *
 *            07/06/16 - Support filter a: like a*            *
 *                       Thanks to John Kalinich              *
 *            06/28/16 - Add member masking like in pdsegen   *
 *            06/24/16 - Update to run in ISPF Batch          *
 *            06/21/16 - Update to use PDSEGENI function      *
 *            06/10/16 - Creation                             *
 *                                                            *
 * ---------------------------------------------------------- *
 * Copyright (c) 2017-2019 by Lionel B. Dyck                  *
 * ---------------------------------------------------------- *
 * License:   This EXEC and related components are released   *
 *            under terms of the GPLV3 License. Please        *
 *            refer to the LICENSE file for more information. *
 *            Or for the latest license text go to:           *
 *                                                            *
 *              http://www.gnu.org/licenses/                  *
 *                                                            *
 * ---------------------------------------------------------- */
  arg options

/* ---------------------------------------------------- *
 | Check for Applid of PDSE and recurse into it if not. |
 * ---------------------------------------------------- */
  Address ISPExec
  'Control Errors Return'
  "Vget (Zapplid)"
  if zapplid <> "PDSE" then do
    "Select CMD(%"sysvar('sysicmd') options ") Newappl(PDSE)" ,
      "Passlib"
    exit 0
  end

  parse value options with frompdse topdse options
  /* a %pdsegenc from to *   *
   *   %pdsegenc from to x:d */
  /* b %pdsegenc from to filter ( options */
  /* c %pdsegenc from to (a b)            */
  /* d %pdsegenc from to (a b) ( options  */
  /* e %pdsegenc from to ( options        */
  if pos(')',options) > 0
     then do
     parse value options with '('filter')' '('options
     filter = '('filter')'
     end
     else parse value options with filter '(' options

/* --------------- *
 | Define defaults |
 * --------------- */
  parse value '' with null replace batch new members copy_members ,
    date_filter haltmsg
  count    = 0
  trapc    = 0
  zerrhm   = 'PDSEGH0'
  zerralrm = 'NO'

/* -------------------- *
 | Check passed options |
 * -------------------- */
  if wordpos('REPLACE',options) > 0 then replace = 'Replace'
  if wordpos('BATCH',options) > 0 then batch = 'Batch'
  if wordpos('NEW',options) > 0 then new = 'New'

/* ---------------------------- *
 * Test for foreground or batch *
 * ---------------------------- */
  if sysvar('sysenv') = 'FORE'
  then environment = 1
  else do
    environment = 0
    batch = 'Batch'
  end
  if batch /= null then environment = 0
  if environment = 0 then do
    call say_msg 'PDSEGENC Processing' date() time()
    call say_msg ' '
    call say_msg 'Processing parms:'
    call say_msg 'From PDSE:' frompdse
    call say_msg 'To PDSE  :' topdse
    call say_msg 'Filter:  :' filter
    call say_msg 'Replace  :' replace
    call say_msg 'New      :' new
    call say_msg 'Batch    :' batch
    call say_msg ' '
  end

/* ----------------------------- *
 * Validate the input parameters *
 * ----------------------------- */
  if frompdse = null then call bad_syntax
  if topdse   = null then call bad_syntax
  if filter   = null then filter = '*'

  if 'OK' /= sysdsn(frompdse) then call bad_from
  if new = null
  then do
    if 'OK' /= sysdsn(topdse)
    then call bad_to1
  end
  else do
    if 'OK' = sysdsn(topdse)
    then call bad_to2
  end

/* ---------------------------------------------- *
 * Get the defaults from PDSEGENS                 *
 *                                                *
 * (we only are about the default unit (def_unit) *
 * ---------------------------------------------- */
  x = pdsegens()
  parse value x with  mail '/' etime '/' higen ,
    '/' base_color '/' sort_color '/' clean ,
    '/' prune_prompt '/' tempmem '/' def_unit ,
    '/' x
  base_color   = strip(base_color)
  sort_color   = strip(sort_color)
  clean        = strip(clean)
  prune_prompt = strip(prune_prompt)
  tempmem      = strip(tempmem)
  def_unit     = strip(def_unit)
  if def_unit /= null then
  def_unit = 'unit('def_unit')'

/* ------------------------------ *
 * Allocate the target (new) PDSE *
 * ------------------------------ */
  if new /= null then do
    'dsinfo dataset('frompdse')'
    select
      when left(zdsspc,1) = 'C' then spaceu = 'Cyl'
      when left(zdsspc,1) = 'T' then spaceu = 'Trk'
      when left(zdsspc,1) = 'B' then spaceu = 'Blk'
      otherwise spaceu = 'B'
    end

    newgen = zdsngen + 0
    Address TSO
    "Alloc ds("topdse") like("frompdse")" ,
      "dsntype(library,2) maxgens("newgen")" ,
      def_unit ,
      "space("zdstota','zds2ex')'
    "Free ds("topdse")"
    Address ISPExec
  end

/* --------------------------------- *
 * Fix up frompdse for testing later *
 * --------------------------------- */
  if replace = null then do
    if left(frompdse,1) = "'" then do
      fdsn = substr(frompdse,2,length(frompdse)-2)
    end
    else do
      if sysvar('syspref') = null then hlq = null
      else hlq = sysvar('sysuid')'.'
      fdsn = hlq''frompdse
    end
  end

/* ------------------------------- *
 * Fix up topdse for testing later *
 * ------------------------------- */
  if left(topdse,1) = "'" then do
    wdsn = substr(topdse,2,length(topdse)-2)
  end
  else do
    if sysvar('syspref') = null then hlq = null
    else hlq = sysvar('sysuid')'.'
    wdsn = hlq''topdse
  end

/* ------------------------- *
 * Get topdse info (zdsngen) *
 * ------------------------- */
  'dsinfo dataset('topdse')'

/* ----------------------------------------- *
 * Establish the ISPF setup for the datasets *
 * ----------------------------------------- */
  "lminit dataid(fromid) dataset("frompdse")"
  "lminit dataid(toid)     dataset("topdse")"

/* -------------------------------------------------------- *
 * Copy those members generations that match the            *
 * member pattern.                                          *
 *                                                          *
 * First get a list of all members                          *
 * Then test for generations                                *
 * If generations then test to match pattern and then       *
 * Copy using the pdsegenm macro with options C and PE      *
 * -------------------------------------------------------- */

  x = time('r')

/* ------------------------- *
 * Get a list of all members *
 * ------------------------- */
  pdd = '$PDSE'random(99)
  pdg = '$PDSG'random(99)
  Address TSO
  "Alloc f("pdd") shr reuse ds("frompdse")"
  x=pdsegeni(pdd)
  "Free f("pdd")"
  Address ISPExec

/* -------------------------- *
 * Check for a member pattern *
 * -------------------------- */
  if filter /= '*' then
  call setup_filter

/* -------------------------------------------- *
 * Process the members from pdsegeni (member.i) *
 * -------------------------------------------- */
  omem  = null
  do ifm = 1 to member.0
    parse value member.ifm with 5 cmem 13 agen 21 . 22 vrm 27 . ,
      35 cdate 42 . 46 mttr ,
      49 mdate 56 mtime 63 muser 70 mmod 73 . 75 mcur 79 minit ,
      83 dmy .
    cmem = strip(cmem)
    agen = strip(agen)
   /* --------------------------------- *
    * Test for dummy members and ignore *
    * --------------------------------- */
    if left(cmem,1) = '00'x then iterate
    if c2x(ttr) == '000000' then iterate
    if omem /= cmem then do
      omem = cmem
      if agen > 0 then do
        omem = null
        iterate
      end
    end

   /* ------------------------- *
    * test for member filtering *
    * ------------------------- */
    if filter /= '*' then do
      ftest =proc_filter(cmem)
      if ftest = 0 then iterate
    end

    if length(strip(mcur)) = 0 then mcur = 0
    else mcur = x2d(c2x(mcur))
    if length(strip(minit)) = 0 then minit = 0
    else minit = x2d(c2x(minit))
    mtime = Substr(mtime,2,2)||':'||Substr(mtime,4,2)
    mmod = c2x(mmod)
    mmod = x2d(mmod)
    if mdate /= '' then do
      smdate = substr(mdate,1,7)
      mdate = substr(mdate,3,5)
      mdate = date('o',mdate,'j')
    end

   /* ----------------------- *
    * Test for Date Filtering *
    * ----------------------- */
    if date_filter /= null then do
      if mdate = null then iterate
      test_date = date('b',mdate,'o')
      if date_filter > test_date then iterate
    end

   /* ------------------------------------------ *
    * Passed all filters so register this member *
    * ------------------------------------------ */
    if wordpos(cmem,members) = 0 then do
      members = members cmem
      mem.cmem.A = ''
    end
    if agen = null then agen = 0
    mem.cmem.A = mem.cmem.A agen

    if cdate /= '' then do
      scdate = substr(cdate,1,7)
      cdate = substr(cdate,3,5)
      cdate = date('o',cdate,'j')
    end
  /* ------------------------------- *
   * Add the member info to our stem *
   * ------------------------------- */
    parse value vrm with iver'.'imod
    if strip(iver)  = null then iver  = 0
    if strip(imod)  = null then imod  = 0
    if strip(cdate) = null then cdate = 0
    if strip(mdate) = null then mdate = 0
    if strip(mtime) = null then mtime = '0:0'
    if strip(muser) = null then muser = '??'
    mem.cmem.agen = cmem agen'\'iver'\'imod'\'cdate,
      '\'mdate'\' mtime'\'mcur'\'minit'\'mmod'\'muser
  end

/* ------------------------------- *
 * Now process the members to copy *
 * ------------------------------- */
  halt = 0
  do im = 1 to words(members)
    if halt /= 0 then leave
    cmem = word(members,im)
    if replace = null
    then if 'OK' = sysdsn("'"wdsn"("cmem")'") then iterate
    if replace /= null then do
      "LMInit Dataid(delete) dataset("topdse") enq(shrw)"
      "LMOpen Dataid("delete") Option(Output)"
      "LMMDel  Dataid("delete") Member("cmem") NoEnq"
      "LMClose Dataid("delete")"
      "LMFree Dataid("delete")"
    end
    do ix = words(mem.cmem.A) to 1 by -1
      igen = word(mem.cmem.A,ix)
      parse value mem.cmem.igen with x y'\'iver'\'imod'\'cdate,
        '\'mdate'\' mtime'\'mcur'\'minit,
        '\'mmod'\'muser
      if igen = 0 then do
        if environment = 1
        then call disp_progress
        else call say_msg 'Copying member' left(cmem,8) 'base generation'
        "lmcopy fromid("fromid") todataid("toid")" ,
          "frommem("cmem") replace"
        if rc = 0 then
        count = count + 1
        if rc = 20 then do  /* no space in directory */
          'setmsg msg(isrz002)'
          haltmsg = zerrsm
          halt = 1
          leave
        end
      end

      /* Test zdsngen from topdse and if >0 then copy gens */
      if zdsngen > 0 then
      if igen /= 0 then do
           /* ---------------------------------- *
            * Copy all records from 'old' member *
            * ---------------------------------- */
        pdsemopt = 'R'
        pdsecpds = "'"wdsn"("cmem")'"
        'vput (pdsecpds)'
        'view dataid('fromid') member('cmem') gen('igen')' ,
          'macro(pdsegenm) parm(pdsemopt)'
           /* ----------------- *
            * Document the copy *
            * ----------------- */
        if rc < 10 then do
          count = count + 1
          if environment = 1
          then call disp_progress
          else call say_msg 'Copied member' left(cmem,8) ,
            'generation' igen
        end
           /* ------------------------------------------------ *
            * Update the target member with the old ISPF stats *
            * ------------------------------------------------ */
        if iver > 0  then
        'LMMStats Dataid('toid')' ,
          'Member('cmem') version('iver') modlevel('imod')' ,
          'Created('cdate') Moddate('mdate')' ,
          'Modtime('mtime') Cursize('mcur')' ,
          'Initsize('minit') Modrecs('mmod')' ,
          'User('muser')'
        else
        'LMMStats Dataid('toid') member('cmem')  Delete'
      end
    end
  end

/* ------------------------------------- *
 * Free up the ISPF allocations and exit *
 * ------------------------------------- */
  call proc_etime
  if environment = 0 then call say_msg ' '
  zerrsm  = 'Copied' count
  if haltmsg /= null then zerrsm = zerrsm 'Error'
  zerrlm  = 'Copied' count 'members from' frompdse 'to' topdse ,
    'in' etime haltmsg
  call set_msg
  "lmfree dataid("fromid")"
  "lmfree dataid("toid")"
  if sysvar('sysenv') = 'BACK'
  then do i = 1 to trapc
    say trap.i
  end
  else if environment = 0 then
  if sysvar('sysispf') = 'ACTIVE' then do
    trap.0 = trapc
    if length(zerrlm) < 90 then lrecl = 94
    else lrecl = length(zerrlm) + 4
    Address TSO
    'Alloc f('pdd') ds('pdd'.log) new spa(1,1) unit(3390)' ,
      'Recfm(v b) lrecl('lrecl') blksize(0)'
    'Execio * diskw' pdd '(finis stem trap.'
    Address ISPExec 'Browse dataset('pdd'.log)'
    'free f('pdd') delete'
  end
  if count = 0 then Exit 4
  Exit 0

/* ----------------------------------------------------- *
 * Process ongoing process message                       *
 * ----------------------------------------------------- */
disp_progress:
  "Control Display Lock"
  "Addpop column(11) row(2)"
  "Display Panel(pdsegcps)"
  "Rempop"
  return

/* ------------------------------------------------------- *
 * Setup Filter procedure                                  *
 *                                                         *
 *    if filter is x: then test for member starting with x *
 *       type is 1                                         *
 *    if filter is x/ then test for member with x anywhere *
 *       type is 2                                         *
 *    if filter is /x then test for member with x anywhere *
 *       type is 2                                         *
 *    if filter is x then test for member x                *
 *       type is 3                                         *
 *    if filter has * or %                                 *
 *       type is 4  (uses pdsegmat rexx function)          *
 *    if filter has : within                               *
 *       type is 6  from:to                                *
 *                                                         *
 *    * and OFF turn off Filtering                         *
 *                                                         *
 * variables:                                              *
 *    tfilter = the test filter member                     *
 *    tfilterl = length of tfilter                         *
 *    tfiltert = filter type                               *
 * ------------------------------------------------------- */
Setup_Filter:
  filter = strip(filter)
  if words(filter) > 1 then
  if left(filter,1) /= '(' then
  if wordpos(word(filter,1),'SINCE TODAY WEEK MONTH YEAR') = 0 then do
    dfilter = subword(filter,2)
    filter = word(filter,1)
  end
  else dfilter = null
  Select
    When wordpos(word(filter,1),'SINCE TODAY WEEK MONTH YEAR') > 0 then do
      zcmd = filter
      call setup_date_filter
      filter = null
      zcmd   = null
    end
    When translate(filter) = 'OFF' then do
      filter = null
      filter_title = null
      parse value '' with tfilter tfilterl tfiltert ,
        date_filter date_filter_title
    end
    When left(filter,1) = '(' then do
      tfilter  = filter
      parse value filter with '('tfilter_list')'
      tfiltert = 7
    end
    When strip(filter) = '*' then do
      filter = null
      filter_title = null
      parse value '' with tfilter tfilterl tfiltert
    end
    When right(filter,1) = ':' then do
      tfilterl = length(filter) -1
      tfilter  = left(filter,tfilterl)
      tfiltert = 1
    end
    When pos(":",filter) > 1 then do
      tfilter  = filter
      parse value filter with tfilter_from":"tfilter_to .
      tfiltert = 6
    end
    When pos('*',filter) > 0 then do
      if length(filter) > 1 then
      tfiltert = 4
    end
    When pos('%',filter) > 0 then do
      if length(filter) > 1 then
      tfiltert = 4
    end
    When pos('/',filter) > 0 then do
      if pos('/',filter) > 1 then do
        tfilterl = length(filter) -1
        tfilter  = left(filter,tfilterl)
        tfiltert = 2
      end
      else do
        tfilterl = length(filter) -1
        tfilter  = substr(filter,2)
        tfiltert = 2
      end
    end
    Otherwise do
      tfilterl = length(filter)
      tfilter  = filter
      tfiltert = 3
    end
  end
  if filter /= null then do
    filter_title = filter
    if dfilter /= null then do
      zcmd = dfilter
      call setup_date_filter
      zcmd = null
    end
  end
  return

/* ------------------------------------------------------- *
 * Filter testing using filter type                        *
 *                                                         *
 * return code 0 to bypass                                 *
 *             1 to accept                                 *
 *                                                         *
 * ------------------------------------------------------- */
Proc_Filter:
  arg filter_member
  rtn = 1
  Select
   /* filter = x: */
    When tfiltert = 1 then do
      if left(filter_member,tfilterl) /= tfilter then rtn = 0
    end
   /* filter = x/ or /x */
    When tfiltert = 2 then do
      if pos(tfilter,filter_member) = 0 then rtn = 0
    end
   /* filter = x */
    When tfiltert = 3 then do
      if tfilter /= filter_member then rtn = 0
    end
   /* filter has * or % */
    When tfiltert = 4 then do
      rtn = pdsegmat(filter_member,filter)
    end
   /* filter = x:y */
    When tfiltert = 6 then do
      rtn = 0
      if left(filter_member,length(tfilter_from)) >= ,
        tfilter_from then
      if left(filter_member,length(tfilter_to)) <= ,
        tfilter_to then rtn = 1
    end
    When tfiltert = 7 then do
      rtn = 0
      do mc = 1 to words(tfilter_list)
        mw = word(tfilter_list,mc)
        select
          when filter_member = mw then rtn = 1
          when pos('/',mw) > 0 then do
            mw = strip(translate(mw,' ','/'))
            if pos(mw,filter_member) > 0 then rtn = 1
          end
          when pos('*',mw) > 0 then do
            rc = pdsegmat(filter_member,mw)
            if rc = 1 then rtn = 1
          end
          when pos('%',mw) > 0 then do
            rc = pdsegmat(filter_member,mw)
            if rc = 1 then rtn = 1
          end
          otherwise nop
        end
      end
    end
    Otherwise nop
  end
  return rtn

/* -------------------------------- *
 | Issue message or save it to stem |
 * -------------------------------- */
Say_Msg:
  parse arg pdsegmsg
  if sysvar('sysispf') = 'ACTIVE'
  then do
    trapc = trapc + 1
    trap.trapc = pdsegmsg
  end
  else call say_msg pdsegmsg
  return

/* -------------------------------------- *
 * Invalid Syntax - tell someone and exit *
 * -------------------------------------- */
Bad_Syntax:
  zerrsm  = 'Invalid Syntax'
  zerrlm  = 'Valid syntax requires a from-dsn, a to-dsn,' ,
    'and an optional member pattern.'
  call set_msg
  exit 8

/* -------------------------------------- *
 * Invalid Frompdse                       *
 * -------------------------------------- */
Bad_From:
  zerrsm  = 'Invalid FromPDSE'
  zerrlm  = frompdse sysdsn(frompdse)
  call set_msg
  exit 8

/* -------------------------------------- *
 * Invalid Topdse                         *
 * -------------------------------------- */
Bad_To1:
  zerrsm  = 'Invalid ToPDSE'
  zerrlm  = topdse sysdsn(topdse)
  call set_msg
  exit 8
Bad_To2:
  zerrsm  = 'Invalid ToPDSE'
  zerrlm  = topdse 'is already allocated so cannot create new.'
  call set_msg
  exit 8

/* ----------------------------------------- *
 * Set message either to ISPF or to terminal *
 * ----------------------------------------- */
Set_MSG:
  if environment = 1
  then 'Setmsg msg(isrz002)'
  else do
    call say_msg 'Short message: 'zerrsm
    call say_msg 'Long message: ' zerrlm
  end
  return

   /* ------------------- *
    * Set the Date Filter *
    * ------------------- */
setup_date_filter:
  Select
    When word(zcmd,1) = 'SINCE' then do
      if last_date_filter = zcmd then do
        date_filter = null
        date_filter_title = null
        last_date_filter = null
      end
      else do
        stdate = word(zcmd,2)
        if left(stdate,1) = '-' then do
          parse value stdate with '-' sinced
          date_filter = date('b') - sinced
          date_filter_title = 'Date: Since' stdate
          last_date_filter = zcmd
        end
        else do
          x = date_val(stdate)
          if x > 0 then do
            zerrsm = 'Invalid Date'
            zerrlm = stdate 'is an invalid date format.' ,
              'The date must be in the format of yy/mm/dd.'
            'Setmsg msg(isrz002)'
          end
          else do
            zerrsm = null
            parse value stdate with yy'/'mm'/'dd
            if mm > 12 then do
              zerrsm = 'Invalid Date'
              zerrlm = mm 'is an invalid month -' stdate
              'setmsg msg(isrz002)'
            end
            if yy//4 = 0 then mfb = 29
            else mfb = 28
            mlimit = '31' mfb '31 30 31 30 31 31 30 31 30 31'
            if zerrsm = null then
            if dd > word(mlimit,mm) then do
              zerrsm = 'Invalid Date'
              zerrlm = dd 'is an invalid number of days for the' ,
                'month of' mm '-' stdate
              'setmsg msg(isrz002)'
            end
            if zerrsm = null then do
              date_filter = date('b',stdate,'o')
              date_filter_title = 'Date: Since' stdate
              last_date_filter = zcmd
            end
          end
        end
      end
    end
    When zcmd = 'TODAY' then do
      if last_date_filter = zcmd then do
        date_filter = null
        last_date_filter = null
      end
      else do
        date_filter = date('b')
        last_date_filter = zcmd
      end
    end
    When zcmd = 'WEEK' then do
      if last_date_filter = zcmd then do
        date_filter = null
        last_date_filter = null
      end
      else do
        date_filter = date('b')-7
        last_date_filter = zcmd
      end
    end
    When zcmd = 'MONTH' then do
      if last_date_filter = zcmd then do
        date_filter = null
        last_date_filter = null
      end
      else do
        date_filter = date('b')-30
        last_date_filter = zcmd
      end
    end
    When zcmd = 'YEAR' then do
      if last_date_filter = zcmd then do
        date_filter = null
        last_date_filter = null
      end
      else do
        yy          = left(date('o'),2)
        date_filter = date('b',yy'/01/01',o)
        last_date_filter = zcmd
      end
    end
    Otherwise nop
    zcmd = null
  end
  return

/* ----------------------- *
 * Date Validation Routine *
 * ----------------------- */
Date_Val: Procedure
  arg tdate
  parse value tdate with y'/'m'/'d .
  if datatype(d) /= 'NUM' then return 1
  if datatype(m) /= 'NUM' then return 1
  if datatype(y) /= 'NUM' then return 1
  return 0

/* ------------------------------------ *
 * Process the elapsed time for display *
 * ------------------------------------ */
Proc_eTime:
  e_time = time("E")
  parse value e_time with ss "." uu
  numeric digits 6
  mm = ss % 60 /* get minutes integer */
  ss = ss // 60 /* get seconds integer */
  uu = uu // 100 /* get micro seconds integer */
  etime =  right(mm+100,2)':'right(ss+100,2)'.'right(uu+100,2) '(mm:ss:th)'
  return
