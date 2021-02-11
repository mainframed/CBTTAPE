/*                         rexx                               *
 * Name:      logarchive.rex                                  *
 *                                                            *
 * Function:  archive log files by archiving themn to         *
 *            z/OS datasets                                   *
 *                                                            *
 * Syntax:    called from crontab pointing to a parm file     *
 *                                                            *
 * Parm file format:                                          *
 *                                                            *
 *   # log rotation parm file                                 *
 *   #                                                        *
 *   # logfile    logfile-name                                *
 *   # lparname   lpar name (e.g. SYL)                        *
 *   # skipnull   (optional and will skip a null file)        *
 *   # archivezos z/os dataset hlq                            *
 *   #                                                        *
 *                                                            *
 * Sample parm in /usr/local/bin/logarchive.parm              *
 *                                                            *
 * Crontab usage:                                             *
 * 0 0 * * * /usr/local/bin/logarchive.rex /location/parm     *
 *                                                            *
 * where /location/parm is the location and name of the parm  *
 * file                                                       *
 *                                                            *
 * Processing:                                                *
 * 1. Process the parm file                                   *
 * 2. Check for skipnull to ignore empty log files            *
 *    - if no skipnull and the file is empty then             *
 *      write a "empty log' message to the log file           *
 * 3. Copy the log file to /tmp/                              *
 * 4. cat /dev/nul > log file to empty it                     *
 * 5. Calc space to the z/OS archive file                     *
 * 6. Use CP to copy to z/OS                                  *
 * 7. Delete the /tmp/ copy                                   *
 *                                                            *
 * Notes:                                                     *
 *                                                            *
 * 1. Be careful which log files are processed as some log    *
 *    files are opened by the application and can only be     *
 *    copied AND NOT emptied.                                 *
 *                                                            *
 * Author:    Lionel B. Dyck                                  *
 *                                                            *
 * History:                                                   *
 *            10/03/16 - Change mv to cp and rm to cat        *
 *            09/27/16 - Add record for empty log if no       *
 *                       skipnull                             *
 *            09/20/16 - Add error check after CP             *
 *                     - Add space for CP                     *
 *            09/16/16 - Update comments to remove va- prefix *
 *                     - report size (may use in future)      *
 *                     - add parm for null file               *
 *            06/29/16 - Creation                             *
 *                                                            *
 * ---------------------------------------------------------- */
 parse arg parmfile

/* ------------------------------------ *
 * Read in the parm file for processing *
 * ------------------------------------ */
 cmd = 'cat' parmfile
 rc = bpxwunix(cmd,,stdout.,stderr.)

/* -------------------- *
 * Process the parmfile *
 * -------------------- */
 say ' '
 say 'Processing parmfile:' parmfile
 say ' '

/* ------------------------------------- *
 * Set Skipnull to 0 which means to      *
 * archive a log file even if it is null *
 * ------------------------------------- */
 skipnull = 0

 do i = 1 to stdout.0
    if left(stdout.i,1) = '#' then iterate   /* ignore comments */
    parse value stdout.i with keyword value
    Select
      When translate(keyword) = 'LOGFILE' then
           logfile = strip(value)
      When translate(keyword) = 'LPARNAME' then
           lparname = translate(strip(value))
      When translate(keyword) = 'ARCHIVEZOS' then
           archivezos = "'"translate(strip(value))"'"
      When translate(keyword) = 'SKIPNULL' then
           skipnull = 1
      Otherwise nop
      end
    end

/* ------------------------ *
 | Log our processing parms |
 * ------------------------ */
 say 'Log rotation parms:'
 say ' '
 say "logfile:   " logfile
 say "lparname:  " lparname
 say "archivezos:" archivezos
 say "skipnull:  " skipnull '(0 = process, 1 = skip)'

 say ' '
 say 'getting list of log files:'
 say ' '
 cmd = 'ls -la' logfile
 rc = bpxwunix(cmd,,stdout.,stderr.)
 do i = 1 to stdout.0
    parse value stdout.i with x1 x2 x3 x4 size x6 x7 x8 log
    if log = '' then iterate
    say log
    end

/* ----------------------------------- *
 | Test for skipnull and if non-0 then |
 | check for size of the log file.     |
 * ----------------------------------- */
 if skipnull = 1 then
    if size = 0 then do
       say 'Log file:' logfile
       say 'Log file is null so it will not be archived.'
       exit 8
       end

/* -------------------------------------------- *
 | if size is 0 and skipnull is not active then |
 | add record to file to indicate it was empty  |
 * -------------------------------------------- */
 if size = 0 then
    Address SH 'echo "Empty file" >' logfile

/* ------------------------------- *
 | Define the archive dataset name |
 * ------------------------------- */
 yymmdd = right(date('s'),6)
 hhmm = left(time(),2)''substr(time(),4,2)
 archive = archivezos'.'lparname'.D'yymmdd'.T'hhmm

/* ---------------------------------------------- *
 | Calculate space using the size and dividing by |
 | 50000 bytes (using 50k per track) to get the   |
 | number of tracks. Then add 5 for fudge :-)     |
 * ---------------------------------------------- */
 size = size % 50000
 size = (size + 5) % 2
 sec_size = size % 2

/* ------------------------- *
 | Now log what we are doing |
 * ------------------------- */
 say 'Beginning archive'
 say ' '
 say 'Archiving file:' logfile
 say 'Archive file:  ' archive
 say 'Archive size:  ' size
 say ' '

/* ------------------------------ *
 | Now Copy (cp) the file to z/OS |
 * ------------------------------ */
 cmd = "cp -P 'SPACE=(TRK,("size","sec_size"))'"  logfile "//\'"archive"\'"
 say cmd
 Address SH cmd
 say 'Copy return code is:' rc

/* -------------------- *
 | Test the return code |
 * -------------------- */
 if rc = 0 then do
    cmd = 'cat /dev/null >' logfile
    say cmd
    Address SH  cmd
    end
 else do
      say 'Error in copying.'
      cmd = 'cp' logfile archive
      say cmd
      Address SH cmd
      end

 Exit 0
