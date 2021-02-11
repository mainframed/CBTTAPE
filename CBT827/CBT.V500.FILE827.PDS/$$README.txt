----------------------- RLP - RACF Lisf Profiles V2.1 ------------------
Thus ISPF dialog can be used to supplement the IBM provided dialogs for
RACF administration.  Let me know if you find this facility useful by
dropping me an email at software@jmit.com.  Thanks - John Miller

----------------------------- Install ----------------------------------
Installation is simple:

1) FTP the XMIT format file from your PC to an MVS or z/OS system.  Be
   sure that the file you FTP into is RECFM=FB, LRECL=80.  The FTP must
   be done in binary mode.

2) From an ISPF command prompt, enter: TSO RECEIVE INDA('xmitfile')
   The resulting file contains everything (almost) needed for RLP.
   Rename this file to whatever meets your system standards.  SYS2.RLP
   might be a reasonable name.

3) Edit the #RLP member, and enter the name of your dataset from step 2.
   (e.g. SYS2.RLP).

4) Copy the modified #RLP member to one of your system clist libraries,
   and name it something convenient, like 'RLP'.

Now you should be able to invoke the dialog from within ISPF by typing
on any Command ===> TSO RLP

----------------------------- Change Log -------------------------------
Version 2.1
- This version mostly has some cleanup done in the execs and panels and
  some bugs fixed.  Other bugs no doubt remain.

- Added an Options panel.  For now this panel lets you turn on/off
  confirmation of delete operations, and lets you turn on/off an option
  that lists the actual RACF command being done under the covers.  This
  feature was requested as an educational aid by a sysprog who was
  learning RACF.

- See the comments in member RLP for more details on some of the things
  changed or fixed.
