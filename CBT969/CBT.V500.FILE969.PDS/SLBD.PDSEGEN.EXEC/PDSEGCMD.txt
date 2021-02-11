  /* --------------------  rexx procedure  -------------------- *
  | Name:      pdsegcmd                                        |
  |                                                            |
  | Function:  User Command History and Execution              |
  |                                                            |
  | Syntax:    %pdsegcmd option dataset                        |
  |                                                            |
  | Usage Notes: display a prompt panel with table of recent   |
  |              user commands                                 |
  |                                                            |
  | Author:    Lionel B. Dyck                                  |
  |                                                            |
  | History:  (most recent on top)                             |
  |            10/20/20 LBD - Creation                         |
  |                                                            |
  | ---------------------------------------------------------- |
  | Copyright (c) 2017-2020 by Lionel B. Dyck                  |
  | ---------------------------------------------------------- |
  | Support is on a best effort and time available basis which |
  | is why the complete source is provided for this application|
  | so you can find and fix any issues you find. Please let    |
  | me know if you do make changes/enhancements/fixes.         |
  | ---------------------------------------------------------- |
  | License:   This EXEC and related components are released   |
  |            under terms of the GPLV3 License. Please        |
  |            refer to the LICENSE file for more information. |
  |            Or for the latest license text go to:           |
  |                                                            |
  |              http://www.gnu.org/licenses/                  |
  | ---------------------------------------------------------- |
  |                                                            |
  * ---------------------------------------------------------- */
  parse arg pdsedsn

  /* ---------------------------------------------------- *
  | Set ISPExec                                          |
  * ---------------------------------------------------- */
  Address ISPExec
  'Control Errors Return'

  /* -------------------------------------------------- *
  | Check to see if the user has ISPTABL allocated and |
  | if not then use ISPPROF as our table DD            |
  * -------------------------------------------------- */
  isptabl = 'ISPTABL'
  x = listdsi(isptabl 'FILE')
  if x > 0 then isptabl = 'ISPPROF'

  /* ----------------------------------------------------- *
  | Open the table but if it doesn't exist then create it |
  * ----------------------------------------------------- */
  'TBOpen pdsegcmd Library('isptabl') Write Share'
  if rc > 0 then do
  'tbcreate pdsegcmd keys(pdsecmd) library('isptabl') write share'
  end

  /* -------------------- *
  | Setup table defaults |
  * -------------------- */
  ztdtop = 0
  ztdsels = 0

  /* ---------------------------------------------------------------- *
  | Process the table.                                               |
  |                                                                  |
  | All row selections will be processed and if none then the git    |
  | command will be executed.                                        |
  |                                                                  |
  | Row selections:  S to copy the command to the git command  entry |
  |                  D to delete the command (supports multipe row   |
  |                    selections)                                   |
  |                  X to execute the command now and update the     |
  |                    git command entry field                       |
  * ---------------------------------------------------------------- */
  do forever
     if ztdsels = 0 then do
        'tbtop pdsegcmd'
        'tbskip pdsegcmd number('ztdtop')'
        'tbdispl pdsegcmd panel(pdsegcmd) cursor(pdsecmd)'
     end
     else
     'tbdispl pdsegcmd'
     if rc > 4 then leave
     'vput (gopt) profile'
     if row = 0 then usel = null
     if row <> null then
     if row > 0 then do
       'TBTop pdsegcmd'
       'TBSkip pdsegcmd Number('row')'
     end
     Select
        When zcmd = 'CLEAR' then do
             'tbclose pdsegcmd replcopy library('isptabl')'
             'tberase pdsegcmd library('isptabl')'
             'tbcreate pdsegcmd keys(pdsecmde) library('isptabl') write share'
             pdsecmd = null
             end
        When usel = 'D' then 'tbdelete pdsegcmd'
        When usel = 'S' then do
           pdsecmd = pdsecmde
           ztdsels = 0
        end
        When usel = 'X' then do
           pdsecmd = pdsecmde
           ztdsels = 0
           call do_pdsecmd
        end
        When pdsecmd /= null then call do_pdsecmd
        Otherwise nop
     end
     usel = null
  end

  /* -------------- *
  | Close and exit |
  * -------------- */
  'tbclose pdsegcmd replcopy library('isptabl')'
  exit

  /* ------------------------------------------------------------- *
  | Execute the user command                                       |
  * -------------------------------------------------------------- */
do_pdsecmd:
  pdsecmde = pdsecmd
  'tbadd pdsegcmd'
  'Select cmd('pdsecmde')'
  src = rc
  zerrsm = 'Completed.'
  zerrlm = 'The command completed processing with return code:' src
  'Setmsg msg(isrz003)'
  'vput (pdsecmde) shared'
  'verase (pdsecmde)'
  return
