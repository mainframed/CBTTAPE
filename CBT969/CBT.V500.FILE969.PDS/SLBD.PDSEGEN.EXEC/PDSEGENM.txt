/* --------------------  rexx procedure  -------------------- *
 * Name:      pdsegenm                                        *
 *                                                            *
 * Function:  PDSEGEN ISPF Edit Macro to perform various      *
 *            functions for PDSEGEN                           *
 *                                                            *
 * ISPF Edit macro                                            *
 *                                                            *
 * Options (pulled from ispf variable pdsemopt):              *
 *                                                            *
 *           C   = Copy all records and exit                  *
 *           COM = Compare members                            *
 *           EM  = Edit message                               *
 *           EMV = Edit/View message                          *
 *           F   = Find string (passed as variable pdsegfnd)  *
 *           P   = Paste but first Delete all records         *
 *           PE  = Paste but first Delete all records         *
 *           PN  = Paste but first Delete all Records         *
 *           R   = Copy all records to new member/file        *
 *                 using replace (thanks to a suggestion      *
 *                 from John Kalinich)                        *
 *           S   = Add Stats                                  *
 *           T   = Test and return record count               *
 *                                                            *
 * Author:    Lionel B. Dyck                                  *
 *                                                            *
 * History:                                                   *
 *            04/11/20 - Correct Compare Parms                *
 *            01/31/20 - Support new Initial Edit Macro       *
 *            05/19/17 - Change to support edit macro parm    *
 *            03/18/17 - Add eXclude on Compare               *
 *            09/28/16 - Add define for compare command       *
 *            09/08/16 - check for dsn with gens before msgs  *
 *            09/06/16 - Reorder options routines alphabetical*
 *                     - Update compare                       *
 *                     - Add Edit Message                     *
 *            09/01/16 - Minor cleanup for compare msg        *
 *            07/27/16 - Remove trace (sigh)                  *
 *            07/22/16 - Add option F (Find)                  *
 *            07/19/16 - Add option S (Stats)                 *
 *            07/16/16 - Add option R (Replace)               *
 *            06/26/16 - Change special to label for message  *
 *                       generated for the compare            *
 *            06/24/16 - Fix to function T                    *
 *            06/24/16 - Add option T to return record count  *
 *            06/24/16 - No longer save version/level since   *
 *                       we have that info from pdsegeni      *
 *                     - support recover/promote if ghost is  *
 *                       empty (from corruption)              *
 *            06/11/16 - Retain caps/num state                *
 *            06/07/16 - Correct compare message              *
 *            06/03/16 - Clean up Compare messages            *
 *            06/03/16 - Updated for more options             *
 *            06/02/16 - Creation                             *
 *                                                            *
 * ---------------------------------------------------------- *
 * Copyright (c) 2017-2020 by Lionel B. Dyck                  *
 * ---------------------------------------------------------- *
 * License:   This EXEC and related components are released   *
 *            under terms of the GPLV3 License. Please        *
 *            refer to the LICENSE file for more information. *
 *            Or for the latest license text go to:           *
 *                                                            *
 *              http://www.gnu.org/licenses/                  *
 *                                                            *
 * ---------------------------------------------------------- */
 address isredit
 'macro (pdsemopt)'
 address ispexec 'control errors return'

/* ------------------------------------------------------- *
 | Check for an Initial Edit Macro for this dataset suffix |
 * ------------------------------------------------------- */
 address ispexec 'vget (imacvar) profile'
 '(dsn) = dataset'
 dsn    = translate(dsn,' ','.')
 dsnsuf = word(dsn,words(dsn))
 parse value '' with macsuf macro macparm
 if wordpos(dsnsuf,imacvar) > 0 then do
    wp = wordpos(dsnsuf,imacvar)
    wc = wordindex(imacvar,wp)
    imacvar = substr(imacvar,wc)
    parse value imacvar with macsuf macro macparm '%'
    end

/* ------------------------------------------------------ *
 | Initial Edit Macro found for this suffix - invoking it |
 * ------------------------------------------------------ */
 if macsuf /= null then do
    macro macparm
    end

/* ----------------------------- *
 * Now process the macro options *
 * ----------------------------- */
 Select
/* ----------------------------- *
 * C = Copy all records and exit *
 * ----------------------------- */
  When pdsemopt = 'C' then do
     "(last)  = linenum .zlast"
     if last = 0 then do
        'caps off'
        "line_after .zfirst = '"blank ghost member"'"
        end
     'Cut  .zfirst .zlast'
     '(caps) = caps'
     '(number) = number'
     state = caps number
     address ispexec 'vput (state)'
     'Cancel'
     end
/* --------------------------- *
 * COM = Compare to new member *
 * vget values for compare     *
 * --------------------------- */
  When pdsemopt = 'COM' then do
     'Reset'
     Address ISPExec 'Vget (todsn cmem cfrom cto deltemp)'
     'Compare' todsn 'x'
     'L 0'
     if cto /= 0 then do
        call outtrap 'x.'
        Address TSO 'Free DS('todsn') Delete'
        call outtrap 'off'
        end
     msg = left('-',72,'-')
     call do_msg
     msg = 'Use Locate label next  or L label next to see' ,
           'the differences.'
     call do_msg
     msg = 'Compare current member' cmem'('cfrom')',
                       'to' cmem'('cto')'
     call do_msg
     if deltemp = 1 then do
        msg = 'Working in a temporary member. Use Create or Replace' ,
              'to save updates.'
        call do_msg
        end
     call define_compare
     end
/* -------------------------------------------------- *
 * EM - Edit Message                                  *
 *                                                    *
 * Replace the default IBM Edit/View message with one *
 * that reflects the relative generation numbers.     *
 * -------------------------------------------------- */
 When pdsemopt = 'EM' then do
    Address ISPexec 'vget (mgen agen higen zdsngen)'
    if zdsngen > 0 then do
       'Reset'
       msg = '          Relative gen:' mgen 'Absolute gen:' agen ,
                       'High gen:' higen
       call do_msg
       msg = '-CAUTION- Edit session has been invoked.'
       call do_msg
       call define_compare
       end
    end
/* -------------------------------------------------- *
 * EMV - Edit changed to View Message                 *
 *                                                    *
 * Replace the default IBM Edit/View message with one *
 * that reflects the relative generation numbers.     *
 * -------------------------------------------------- */
 When pdsemopt = 'EMV' then do
    Address ISPexec 'vget (mgen agen higen zdsngen)'
       if zdsngen > 0 then do
       'Reset'
       msg = '       Relative gen:' mgen 'Absolute gen:' agen ,
                    'High gen:' higen
       call do_msg
       msg = '-Note- View session has been invoked -' ,
             'Changes cannot be saved.'
       call do_msg
       call define_compare
       end
    end
/* --------------------------------------------------- *
 * F - Find the string passed in pdsegfnd and return   *
 *     1 if found and 0 if not found in pdsegrc        *
 * --------------------------------------------------- */
  When pdsemopt = 'F' then do
       Address ispexec 'vget pdsegfnd'
       "Find" pdsegfnd
       pdsegrc = rc
       Address ispexec 'vput pdsegrc'
       'Cancel'
       end
/* -------------------------------------- *
 * P = Paste but first Delete all records *
 * -------------------------------------- */
  When pdsemopt = 'P' then do
     'Reset'
     Address ispexec 'vget (state)'
     Parse value state with caps number
     'Caps'    caps
     'Number'  number
     'Delete .zfirst .zlast'
     'Paste after .zfirst'
     end
/* --------------------------------------- *
 * PE = Paste but first Delete all records *
 *      then end.                          *
 * --------------------------------------- */
  When pdsemopt = 'PE' then do
     'Reset'
     Address ispexec 'vget (state)'
     Parse value state with caps number
     'Caps'    caps
     'Number'  number
     'Delete .zfirst .zlast'
     'Paste after .zfirst'
     'Save'
     'End'
     end
/* --------------------------------------- *
 * PN = Paste but first Delete all Records *
 *      and set a message for gen 0 replace*
 * --------------------------------------- */
  When pdsemopt = 'PN' then do
     'Reset'
     'Delete .zfirst .zlast'
     Address ispexec 'vget (state)'
     Parse value state with caps number
     'Caps'    caps
     'Number'  number
     'Paste after .zfirst'
     msg = 'Generation 0 has been replaced by a previous' ,
           'generation.'
     call do_msg
     end
/* --------------------------------------------------- *
 * R - Copy all records in the current member to       *
 *     the target dataset (found in variable pdsecpds) *
 *     using Replace.                                  *
 * --------------------------------------------------- */
  When pdsemopt = 'R' then do
       Address ispexec 'vget pdsecpds'
       "Replace .zfirst .zlast" pdsecpds
       'Cancel'
       end
/* --------------------------------------------------- *
 * S - Add Stats to the member                         *
 * --------------------------------------------------- */
  When pdsemopt = 'S' then do
       "Stats On"
       'Save'
       'End'
       end
/* ----------------------------- *
 * T = Test for record counts    *
 * ----------------------------- */
  When pdsemopt = 'T' then do
     "(last)  = linenum .zlast"
     state = last
     address ispexec 'vput (state)'
     'Cancel'
     end
/* ----------------------------- *
 * Otherwise issue error message *
 * ----------------------------- */
  Otherwise do
     zerrsm  = 'Error'
     zerrlm  = 'Invalid pdsegenm macro option' pdsemopt
     zerrhm   = 'PDSEGH0'
     zerralrm = 'NO'
     Address ispexec 'setmsg msg(isrz002)'
     end
  end
exit 0

/* -------------------------------------------------- *
 | Do_Msg routine to insert message into edit session |
 * -------------------------------------------------- */
Do_Msg:
   "line_after " 0 "= msgline '"msg"'"
   return

/* --------------------------------------------------- *
 | Define Compare to invoke the Command pdsegcpr       |
 |                                                     |
 | When the Edit session ends the define will be lost. |
 * --------------------------------------------------- */
 Define_Compare:
 'Define pdsegcpr Macro'
 'Define Compare alias pdsegcpr'
 return
