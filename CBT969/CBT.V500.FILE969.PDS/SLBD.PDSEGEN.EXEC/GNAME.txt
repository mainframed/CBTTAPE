/* --------------------  rexx procedure  -------------------- *
 * Name:      GNAME                                           *
 *                                                            *
 * Function:  Identify the Backup Member to the Real Member   *
 *            and Generation                                  *
 *                                                            *
 * ISPF Edit Command:  GNAME                                  *
 *                                                            *
 * Author:    Lionel B. Dyck                                  *
 *                                                            *
 * History:                                                   *
 *            07/31/16 - Creation (inspired by John Kalinich) *
 *                                                            *
 * ---------------------------------------------------------- *
 * Copyright (c) 2017 by Lionel B. Dyck                       *
 * ---------------------------------------------------------- */

/* ------------------------------- *
 * Get the Dataset and Member info *
 * ------------------------------- */
Address isredit
'macro'
'(member)  = member'
'(dataset) = dataset'

/* ----------------------------- *
 * Now read in the $INDEX member *
 * ----------------------------- */
address tso
gdd = 'gdd'random(99)
if sysdsn("'"dataset"($index)'") /= 'OK' then do
   zerrsm = 'Error'
   zerrlm = 'The current dataset is not a PDSEGEN Backup' ,
            'dataset so this macro can do nothing.'
   zerrhm   = 'PDSEGH0'
   zerralrm = 'NO'
   Address ISPExec 'Setmsg msg(isrz002)'
   exit
   end
"alloc f("gdd") shr reuse ds('"dataset"($index)')"
'execio * diskr 'gdd' (finis stem in.'
'Free f('gdd')'

/* ----------------------------------------------------- *
 * Find the current member name (backup format) and then *
 * insert a message with the real member name and        *
 * absolute (relative) generation.                       *
 * ----------------------------------------------------- */
Address isredit
do i = 1 to in.0
   if word(in.i,1) > member then do
      zerrsm = 'Error'
      zerrlm = 'The current member is not a PDSEGEN Backup member.'
      zerrhm   = 'PDSEGH0'
      zerralrm = 'NO'
      Address ISPExec 'Setmsg msg(isrz002)'
      end
   if word(in.i,1) /= member then iterate
   parse value in.i with member real agen rgen .
   text = 'Member name:' left(real,10) 'Generation:' agen'('rgen')'
   "line_before .zfirst = msgline '"text"'"
   exit
   end
