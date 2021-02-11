  /* --------------------  rexx procedure  -------------------- *
  | Name:      EDITMAC                                         |
  |                                                            |
  | Function:  ISPF Edit Macro to Execute an inline Edit       |
  |            macro within the active Edit Data               |
  |                                                            |
  | Usage Notes: Insert an edit macro inline in the edit data  |
  |              for processing by the EDITMAC command.        |
  |                                                            |
  |              <EM> starts the inline macro                  |
  |              . . . any rexx edit macro code here           |
  |              </EM> ends the inline macro                   |
  |                                                            |
  |              Placement should probably be as close to      |
  |              the top of the data as possible.              |
  |                                                            |
  |              Suggest making the inline edit macro a        |
  |              comment for the data it resides in and        |
  |              use the offset parm if the comment is in      |
  |              column 1.                                     |
  |                                                            |
  | Syntax: EDITMAC <offset>                                   |
  |                                                            |
  |         offset is the number of columns to skip to         |
  |         extract the edit macro code thus ignoring any      |
  |         comment characters.                                |
  |                                                            |
  | Dependencies: none                                         |
  |                                                            |
  | Author:    Lionel B. Dyck                                  |
  |                                                            |
  | History:  (most recent on top)                             |
  |            07/29/20 LBD - delete temp d/s in case          |
  |            07/28/20 LBD - creation                         |
  |                                                            |
  * ---------------------------------------------------------- *
  | Find at https://www.lbdsoftware.com                        |
  |      or https://github.com/lbdyck                          |
  * ---------------------------------------------------------- *
  | NOTE: This function is also available in RUNC that         |
  |       supports many more capabilities.                     |
  * ---------------------------------------------------------- */
  Address ISREdit
  /* --------------------------------- *
  | Define ourselves as an Edit Macro |
  * --------------------------------- */
  'Macro (offset)'

  /* ------------------------ *
  | Define default variables |
  * ------------------------ */
  null = ''
  r = 0
  hit = 0

  /* ------------------------ *
  | Validate the offset parm |
  * ------------------------ */
  if datatype(offset) /= 'NUM'
  then offset = 1
  if offset = 0 then offset = 1

  /* ------------------------------------------------- *
  | Get the last line of the active Edit session data |
  * ------------------------------------------------- */
  '(last) = linenum .zlast'

  /* -------------------------------------------------------- *
  | Process the data records to find the inline edit macro   |
  | and place the edit macro records into a stem variable.   |
  |                                                          |
  | The edit macro starts with <EM> and ends with </EM>      |
  |                                                          |
  | The offset is used to skip over text in the records that |
  | may be comments.                                         |
  * -------------------------------------------------------- */
  do i = 1 to last
    '(data) = line' i
    /* --------------------------------- *
    | Extract the record from the data, |
    | skipping over the offset.         |
    * --------------------------------- */
    data = strip(substr(data,offset))
    /* ------------------------------------------ *
    | Test for <EM> to start the data collection |
    | and for </EM> to stop the data collection  |
    * ------------------------------------------ */
    if translate(left(data,4)) = '<EM>' then do
      hit = 1
      iterate
    end
    if translate(left(data,5)) = '</EM>' then do
      hit = 0
      leave
    end
    /* -------------------------------------------- *
    | If hit is 0 then we are not collecting data. |
    | If it is 1 then save the current record for  |
    | processing.                                  |
    * -------------------------------------------- */
    if hit = 0 then iterate
    r = r + 1
    rec.r = data
  end
  /* ----------------------------------- *
  | Save the number of records in rec.0 |
  * ----------------------------------- */
  rec.0 = r

  /* ------------------------------- *
  | Was an inline edit macro found? |
  * ------------------------------- */
  if r = 0 then do
    zedsmsg = null
    zedlmsg = 'EDITMAC did not find any edit macro to execute.' ,
      'Check to see if an offset should be used.'
    Address ISPExec 'setmsg msg(isrz001)'
    exit
  end

  /* ----------------------------------------------- *
  | Define a temporary DDname and Dataset name.     |
  | Allocate the temporary PDS and write the inline |
  | edit macro's records to it.                     |
  | Then Altlib the temporary PDS.                  |
  * ----------------------------------------------- */
  emdd = 'EMDD'random(4)
  if sysvar('syspref') /= null
  then emds = "'"sysvar("syspref")".temp."emdd
  else emds = "'"sysvar("sysuid")".temp."emdd
  emdslib = emds"'"
  call outtrap 'x.'
  address tso 'delete' emdslib
  call outtrap 'off'
  emds = emds"(edmac)'"
  Address TSO
  'alloc f('emdd') new space(1,1) tr recfm(v b) lrecl(255) blksize(0)' ,
    'da('emds') dsorg(po) dir(1)'
  'execio * diskw' emdd '(finis stem rec.'
  'altlib act app(exec) da('emdslib')'

  /* -------------------------------- *
  | Setup error environment          |
  | Now invoke the inline edit macro |
  * -------------------------------- */
  Address ISPExec 'control errors return'
  Address isredit
  '%edmac'

  /* -------------------------------------------------- *
  | All done so free up the ALTLIB and Free and Delete |
  | the temporary PDS.                                 |
  * -------------------------------------------------- */
  Address TSO
  'altlib deact app(exec)'
  'free f('emdd') delete'
  Exit
