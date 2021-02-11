
                          CBT Tape File xxx

                 (userid).CBTnnn.FILExxx.PDS($$README)

------------------------------------------------------------------------

The contents of this CBT tape submission are various Connect:Direct mods
that I have written and used over many years. Some of these go back to
the 'System Center" days. I have "refreshed" these for our recent
upgrade to IBM Connect:Direct Version 5.1 (HDGA510). The collection is
categorized as follows:

 1) Assembler Exits
 2) ARS members
 3) Automation stuff
 4) OPLIST members
 5) Perl members
 6) Stats members

------------------------------------------------------------------------

Assembler Exits
---------------
All four of the exits are written in assembler. There are eight members
that are prefixed with "TST". They are the four source code members and
four corresponding JCL members to assemble and link the load modules.


       Exits
       -----

       TSTA3390 - A sample Allocation exit that is designed to check
                  processes for destination datasets with 1) DISP=NEW
                  or DISP= not specpfied, 2) UNIT=3390 or UNIT=SYSALLDA
                  and 3) NO VOL=SER specified. If all (3) checks are
                  met, then change the destination D/S unit to be
                  UNIT=DISK80. If we change a process, then we
                  issue a WTO message to the NDM log. The message is:

               CDPAL01X UNIT= changed for PROCESS procname( nn,nnn) SUB
               MITTED BY Snode=NNNNNNNNNNNNNNNN


       TSTSMF2  - A modified version of the IBM provided exit, DGAXSMF
                  (DMGSMF). This sample statistics exit 1) customizes
                  the SMF record number, 2) enables the CPUTIME
                  processing and 3) issues a WTO message to the NDM log
                  for XO statistics records that represent any MODIFY
                  SESSIONS commands (QUIesce or RESume). The format of
                  the WTO messages is:

               CDXOR01X Modify Session = XXX issued by CCCCCCCC MSG=xxx
               xxxxx Node=NNNNNNNNNNNNNNNN

                  Where 'XXX' is either QUI or RES, 'CCCCCCCC' is the user
                  that initiated the command, 'NNNNNNNNNNNNNNNN' is the node
                  name that was either quiesced or resumred and 'xxxxxxxx'
                  is the MSGID of the response to the command. It can be one
                  of the following:

                       STRA009I  -  RESume for the LOCAL nodes
                       STRA010I  -  QUIesce for the LOCAL nodes
                       STRA035I  -  RESume for a remote node
                       STRA036I  -  QUIesce for a remote node


       TSTSUBMY - A sample SUBMIT exit that is designed to DISABLE
                  compression if the remote node name matches one of
                  several prefixes or if the explicit node name is in
                  the internal table. If the node name is found in the
                  table or there is a match on one of the prefixes, then
                  the exit loops through the process, locates any COPY
                  steps and disables ALL compression (Ext or Standard).
                  The exit has one additional caveat. If the submitted
                  process is coded with CLASS=1, then the requested
                  compression value will be honored!!


       TSTZSIZP - Another sample SUBMIT, that is designed to DISPLAY
                  process step information, including the process
                  control block sizes. This exit was intended as a tool
                  to aid in the tuning of the TCQ file CISIZE value.
                  The goal, if possible, is to try to "fit" the average
                  process into a single VSAM CI.
                  The first step is to determine the average process
                  size. This sample exit will DISPLAY size information
                  for each process step to the USRINFO DDNAME. It will
                  keep a running total and DISPLAY the Total size at the
                  process end. Step size values are derived from the
                  Connect:Direct Configuration Guide (Chapter 1) except
                  for SUBMIT steps. The base control block size for the
                  SUBMIT step is 176 bytes.(i.e. SUBMIT PROC=xxxxxxxx).
                  Any other parameters must be added to this initial
                  value. In my testing all of the SUBMITs were from PDS
                  members, so the dataset and member name lengths are
                  added. This length is found in the TQSUBLNG field!

Additional information on installing these exits can be found in member
$INSTALL in this PDS.

------------------------------------------------------------------------

ARS (SAS) members
-----------------

The ARS members in this PDS are:

 o) ACTIVTY1
 o) ACTIVTY2
 o) ACTVSECP
 o) CDJARS2$
 o) CDJEXTR$
 o) EXCEPT1
 o) NPDSCPY1
 o) PDSCOPY1
 o) RUNJOB1
 o) RUNTASK1
 o) SUBMIT1
 o) SUMMACTC
 o) SUMMARY1

Additional information on installing the ARS (SAS) samples can be found
in member $NDMARS in this PDS.

------------------------------------------------------------------------

Automation Stuff
----------------

The Automation sample members in this PDS are:

 o) CDXOR01X
 o) MPFLSTXX
 o) SNDMAIL6
 o) SVTMXXX
 o) SVTM083I
 o) SVTM105I

Additional information on installing the automation samples can be found
in member $NVAUTO in this PDS.

------------------------------------------------------------------------

Oplist members
--------------

The Connect:Direct Oplist members in this PDS are:

 o) IDBG
 o) QUI
 o) QUIESCE
 o) RES
 o) RESUME
 o) XO

Additional information on installing the Oplist samples can be found
in member $OPLIST in this PDS.

------------------------------------------------------------------------

Perl stuff
----------

The Connect:Direct Perl members in this PDS are all contained in member
PERL and are in TSO transmit format. To unload these members, you must
"receive" member PERL in this PDS with the TSO RECEIVE command. The
dataset produced by the RECEIVE command should contain the following
members:

 o) JNDMEXPT
 o) JNDMSECT
 o) JNDMTIME
 o) JNPDSCPY

Each of these scripts was designed to produce a report similar to
the SAS reports produced by the ARS members. The Perl scripts expect
a Connect:Direct UNIX statistics file as input. We conCATenated the
stats files on either a weekly or daily basis depending upon the
volume on the particular server. A sample CAT command might look like:

cat /../cdstats/S20*.00* > /../cdstats/S`date +%Y%m%d`.weekly

A sample invocation of the Perl script might look like:

/../jndmtime.pl /../S`date +%Y%m%d`.weekly > /../jndmtime.`date +%Y%m%d`

We used cron jobs to CAT the stats files and run the Perl scripts. The
resulting reports were archived in a variety of methods!

Additional information on installing the Perl samples can be found
in member $PERL in this PDS.

------------------------------------------------------------------------

Stats stuff
-----------

The Connect:Direct stat switch member in this PDS are:

 o) STATJOB4
 o) STATPRC4

Additional information on installing the stats switch samples can be
found in member $STATSW in this PDS.

------------------------------------------------------------------------

Boring Stuff
------------
Use of this material is subject to the standard CBT Tape
disclaimer viewable at http://www.cbttape.org/disclaimer.htm

This material may be copied, distributed, modified and executed freely.
However in doing so, headers and comments indicating the source
of the material should not be removed. In addition, this material
must not be sold on for profit, either in part or as a whole, without
the consent of the author.

The author appreciates feedback as to good uses to which this material
is serving, and would give due consideration to any suggestions for
corrections, clarifications or enhancements. The author can be contacted
as follows. (Email is my preferred means of communication!!!)

Name:         Anthony J. Cieri
Address:
              1 Freedom Valley Drive
              Oaks,PA 19456
              U.S.A.
Telephone:    610  676  4088  (Work - direct line)
Fax:          484  676  4088  (Work)

Email:        Anthony.Cieri4@gmail.com
