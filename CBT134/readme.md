```
//***FILE 134 is from Mr Greg Price of Prycroft Six                 *   FILE 134
//*           in Melbourne,  Victoria,  Australia.                  *   FILE 134
//*                                                                 *   FILE 134
//*              email:  greg.price@optusnet.com.au                 *   FILE 134
//*                                                                 *   FILE 134
//*       >>  A load library for REVIEW load modules, was taken     *   FILE 134
//*       >>  from Greg's load library and put into TSO XMIT format *   FILE 134
//*       >>  as member REVZLOAD in this pds.  That is to make the  *   FILE 134
//*       >>  REVIEW command easier to install quickly, if you      *   FILE 134
//*       >>  don't want to assemble it.                            *   FILE 134
//*                                                                 *   FILE 134
//*       >>  Please try to use RFE (the REVIEW Front End) program. *   FILE 134
//*       >>  We suspect that you'll like it.  It was developed     *   FILE 134
//*       >>  for MVS 3.8, but it is just as useful on z/OS.        *   FILE 134
//*                                                                 *   FILE 134
//*           This file is in IEBUPDTE SYSIN format and contains    *   FILE 134
//*           the following :                                       *   FILE 134
//*                                                                 *   FILE 134
//*           $$IEFU83 - IEFU83 exit package with MPF exits.        *   FILE 134
//*                      Shows I/O counts etc. in job messages.     *   FILE 134
//*                                                                 *   FILE 134
//*           $$TSDDOC - Documentation for the $SPACE and $LISTC    *   FILE 134
//*                      TSO commands from the SECV.                *   FILE 134
//*                                                                 *   FILE 134
//*           $$CRYPT  - Lex Eremin's ENCRYPT/DECRYPT TSO commands. *   FILE 134
//*                                                                 *   FILE 134
//*           $FREEAL# - TSO help for $FREEALL.                     *   FILE 134
//*                                                                 *   FILE 134
//*           $FREEALL - One of the many 'FREE ALL'-like commands.  *   FILE 134
//*                      This one has terminal and non-terminal     *   FILE 134
//*                      ddname exemption lists.  Read the TSO      *   FILE 134
//*                      help member to get the feel of it.         *   FILE 134
//*                                                                 *   FILE 134
//*           $HBLIST  - List HSM backup details for data sets by   *   FILE 134
//*                      leading character string.  It even works   *   FILE 134
//*                      when HSM is down, unlike HLIST.  Requires  *   FILE 134
//*                      RACF READ access to the HSM BCDS.          *   FILE 134
//*                                                                 *   FILE 134
//*           $HBLIST# - TSO help for $HBLIST.                      *   FILE 134
//*                                                                 *   FILE 134
//*           $HMLIST  - Similar to $HBLIST except for HSM migrated *   FILE 134
//*                      data sets.  Also works when HSM is down.   *   FILE 134
//*                      Requires RACF READ access to the HSM MCDS. *   FILE 134
//*                                                                 *   FILE 134
//*           $HMLIST# - TSO help for $HMLIST.                      *   FILE 134
//*                                                                 *   FILE 134
//*           $HMLISTW - Same as $HMLIST except that detail format  *   FILE 134
//*                      has more items to be 120 bytes wide.       *   FILE 134
//*                                                                 *   FILE 134
//*           $INSTALL - JCL for assembling $LISTC/$SPACE - see     *   FILE 134
//*                      $$TSDDOC.                                  *   FILE 134
//*                                                                 *   FILE 134
//*           $LISTC   - TSO help for $LISTC.                       *   FILE 134
//*                                                                 *   FILE 134
//*           $LISTM   - Clist for invoking $LISTX in an SPF        *   FILE 134
//*                      environment or from TSO READY.             *   FILE 134
//*                                                                 *   FILE 134
//*           $LISTX   - Lex Eremin's fullscreen version of         *   FILE 134
//*                      LISTMEM.  Valid member selection codes are *   FILE 134
//*                      'D' to delete, 'R' to rename (any          *   FILE 134
//*                      character on the keyboard other than space *   FILE 134
//*                      may be used in the new member name), 'E'   *   FILE 134
//*                      to edit, 'B' to browse.  'L' for locate,   *   FILE 134
//*                      'N' for directory refresh, and member      *   FILE 134
//*                      commands are valid from primary input      *   FILE 134
//*                      area.  PF7/19/8/20 for scrolling.  PF3/15  *   FILE 134
//*                      to exit and to cancel a rename before the  *   FILE 134
//*                      new name is entered.  'MAX' up and down    *   FILE 134
//*                      are also allowed.                          *   FILE 134
//*                                                                 *   FILE 134
//*           $SPACE   - TSO help for $SPACE.                       *   FILE 134
//*                                                                 *   FILE 134
//*           $SP3MODS - Member containing MVS and related product  *   FILE 134
//*                      usermods in IEBUPDTE/PDSLOAD input format. *   FILE 134
//*                      These are at the SP3 level.  Included are  *   FILE 134
//*                      JES2 exits for max COND CODE reporting in  *   FILE 134
//*                      the NOTIFY message, SDSF mod to show NJE   *   FILE 134
//*                      and "awaiting output" queues in 'SDSF I'   *   FILE 134
//*                      by default, mod to stop TSO TEST 'LIST I'  *   FILE 134
//*                      stopping at bad opcode, MPF exit to tell   *   FILE 134
//*                      TSO user of allocated data set that batch  *   FILE 134
//*                      job is waiting for, mod to get SYSIN and   *   FILE 134
//*                      SYSOUT DD I/O count in TCT and SMF DD      *   FILE 134
//*                      level statistics, and related sample       *   FILE 134
//*                      PARMLIB members.                           *   FILE 134
//*                                                                 *   FILE 134
//*           $SP4MODS - Member containing MVS and related product  *   FILE 134
//*                      usermods in IEBUPDTE/PDSLOAD input format. *   FILE 134
//*                      The mods are the same as in $SP3MODS, but  *   FILE 134
//*                      have been updated to the SP4 level.  This  *   FILE 134
//*                      copy of 'MSG2USER' is good for all levels. *   FILE 134
//*                                                                 *   FILE 134
//*           $43MODS  - Some bits of $SP4MODS updated for SP4.3.   *   FILE 134
//*                                                                 *   FILE 134
//*           #PDSTBL  - Member for PDS 8.3 and PDS 8.4 copied from *   FILE 134
//*                      CBT file 182 and updated so 'REVIEW :'     *   FILE 134
//*                      and 'PRINTOFF :' process the whole data    *   FILE 134
//*                      set once, rather than each member          *   FILE 134
//*                      individually.  Goes with member @PRINTO.   *   FILE 134
//*                                                                 *   FILE 134
//*           @PRINTO  - Member for PDS 8.3 and PDS 8.4 copied from *   FILE 134
//*                      CBT file 182 and updated so 'REVIEW :'     *   FILE 134
//*                      and 'PRINTOFF :' process the whole data    *   FILE 134
//*                      set once, rather than each member          *   FILE 134
//*                      individually.  Goes with member #PDSTBL.   *   FILE 134
//*                                                                 *   FILE 134
//*           ABEND    - Famous TSO help.  Lifted from CBT mods     *   FILE 134
//*                      file of SHARE tape but has had several     *   FILE 134
//*                      hundred lines added to it.                 *   FILE 134
//*                                                                 *   FILE 134
//*           ANIM1-7  - Sample animation by Craig Halliday.        *   FILE 134
//*                      Included here in the hope that it will     *   FILE 134
//*                      inspire someone to produce a full-length   *   FILE 134
//*                      animation feature for 3270 with vector     *   FILE 134
//*                      graphics.                                  *   FILE 134
//*                                                                 *   FILE 134
//*           CLRSCRN  - Object deck of assembler subroutine of     *   FILE 134
//*                      Adventure included for completeness.       *   FILE 134
//*                                                                 *   FILE 134
//*           CONCAT$  - JCL to assemble CONCATEM.                  *   FILE 134
//*                                                                 *   FILE 134
//*           CONCAT#  - TSO help for CONCAT.                       *   FILE 134
//*                                                                 *   FILE 134
//*           CONCATEM - Functioning reentrant version of the       *   FILE 134
//*                      CONCAT TSO command from file 270.          *   FILE 134
//*                                                                 *   FILE 134
//*           CUBE     - Static vector graphics sample by C.H.      *   FILE 134
//*                                                                 *   FILE 134
//*           DATABASE - Input file to PROGRAM - PL/I Adventure.    *   FILE 134
//*                                                                 *   FILE 134
//*           DCPU     - Program to display CPU utilization at OS   *   FILE 134
//*                      console or TSO terminal.  Program          *   FILE 134
//*                      parameter can be used to control duration  *   FILE 134
//*                      of sample.  Can be handy to install as a   *   FILE 134
//*                      started task on a system without much      *   FILE 134
//*                      third party stuff so operator/sysprog can  *   FILE 134
//*                      see who is hogging the CPU when TSO        *   FILE 134
//*                      response dies.  Make make sure you give    *   FILE 134
//*                      the started task high priority in your     *   FILE 134
//*                      ICS.  I/O code pinched from                *   FILE 134
//*                      DJOBS/DTSO/DDASD/DTAPES or some such.      *   FILE 134
//*                      Supports MVS/XA and MVS/ESA.               *   FILE 134
//*                                                                 *   FILE 134
//*           DCS      - The Define Constants for Screen macro used *   FILE 134
//*                      by REVIEW and enhanced a bit to support    *   FILE 134
//*                      extended colours and highlighting.  Handy  *   FILE 134
//*                      for any 3270 fullscreen programming.       *   FILE 134
//*                                                                 *   FILE 134
//*           DDASD    - XA-only version of the DDASD command       *   FILE 134
//*                      lifted from some share tape in 1981.       *   FILE 134
//*                      Updated to work on both release 1 and 2 of *   FILE 134
//*                      MVS/XA (2.1.x and 2.2.0).  Works okay on   *   FILE 134
//*                      MVS/ESA.  Now updated for SP4.             *   FILE 134
//*                      (Fixed by UPDATER for z/OS, at least 2.2)  *   FILE 134
//*                                                                 *   FILE 134
//*           DECDATE  - Assembler subroutines of PL/I Adventure.   *   FILE 134
//*                                                                 *   FILE 134
//*           DECIDER  - Clist for vocational guidance.             *   FILE 134
//*                                                                 *   FILE 134
//*           DIVER    - TSO TPUT program written by Steve Beer.    *   FILE 134
//*                      Uses extended colour and graphics escape.  *   FILE 134
//*                                                                 *   FILE 134
//*           DIVEROBJ - Object deck of DIVER previously shipped    *   FILE 134
//*                      as member 'DIVER'.  X'0A23' at offset      *   FILE 134
//*                      x'38' has been zapped to x'0A32'.          *   FILE 134
//*                                                                 *   FILE 134
//*           DUPTIME  - TSO command or background program to       *   FILE 134
//*                      display up-time (time since last IPL).     *   FILE 134
//*                      if a job name is supplied as an operand    *   FILE 134
//*                      or program parameter then the address      *   FILE 134
//*                      space transaction resident time is shown.  *   FILE 134
//*                      For non-swappable tasks or jobs this is    *   FILE 134
//*                      the up-time so you can tell how long DB2   *   FILE 134
//*                      or IMS has been up.  Use an asterisk to    *   FILE 134
//*                      process all active address spaces.         *   FILE 134
//*                                                                 *   FILE 134
//*           DYNALC   - Handy dynamic allocation macro from Bruce  *   FILE 134
//*                      Bordonaro.  Used by ZAP.                   *   FILE 134
//*                                                                 *   FILE 134
//*           EDBOX    - David Price edit macro for 3278T support.  *   FILE 134
//*                                                                 *   FILE 134
//*           EDICAT   - ISPF edit macro for LISTICAT output -      *   FILE 134
//*                      part of the package in LISTICAT.           *   FILE 134
//*                                                                 *   FILE 134
//*           EDPRT    - David Price edit macro for 3278T support.  *   FILE 134
//*                                                                 *   FILE 134
//*           EDUNBOX  - David Price edit macro for 3278T support.  *   FILE 134
//*                                                                 *   FILE 134
//*           EDUNPRT  - David Price edit macro for 3278T support.  *   FILE 134
//*                                                                 *   FILE 134
//*           EDVIO    - Clist to SPF edit the temporary ISPCTL     *   FILE 134
//*                      file.  Many dialogs like SMP/E give the    *   FILE 134
//*                      opportunity to EDIT/BROWSE/SUBMIT the      *   FILE 134
//*                      generated JCL.  SUBMIT (being *real* TSO)  *   FILE 134
//*                      has no problem but EDIT/BROWSE does not    *   FILE 134
//*                      support VIO.  BROWSE is easily replaced by *   FILE 134
//*                      REVIEWing the ddname.  This clist (to be   *   FILE 134
//*                      invoked from the primary command area of   *   FILE 134
//*                      the appropriate split screen) allows final *   FILE 134
//*                      editing before job submission.  Written    *   FILE 134
//*                      by Tony Watson.                            *   FILE 134
//*                                                                 *   FILE 134
//*           FLAG     - Static vector graphics sample by C.H.      *   FILE 134
//*                                                                 *   FILE 134
//*           FSHELP   - Fullscreen TSO help command - an alias     *   FILE 134
//*                      of 'REVIEW'.  See member 'REVINST' for     *   FILE 134
//*                      installation details.  Preferred name of   *   FILE 134
//*                      'HEL' by some.  'FSH' for short.           *   FILE 134
//*                                                                 *   FILE 134
//*           FSHELP#  - TSO help for FSHELP.  See member REVINST.  *   FILE 134
//*                                                                 *   FILE 134
//*           GE2      - TPUT program (card game prototype).        *   FILE 134
//*                                                                 *   FILE 134
//*           GRPSTR   - TSO command for within clists only.        *   FILE 134
//*                      Returns the RACF group name into a clist   *   FILE 134
//*                      variable called &GRPSTR.                   *   FILE 134
//*                                                                 *   FILE 134
//*           HEL      - Fullscreen TSO help command - an alias     *   FILE 134
//*                      of 'REVIEW'.  See member 'REVINST' for     *   FILE 134
//*                      installation details.                      *   FILE 134
//*                                                                 *   FILE 134
//*           IEFUJI   - SMF exit for job accounting.  Handles      *   FILE 134
//*                      started tasks so step accounting is        *   FILE 134
//*                      not needed.  (ACF2 in this example.)       *   FILE 134
//*                                                                 *   FILE 134
//*           IEFUJV   - SMF exit for job accounting.  Handles      *   FILE 134
//*                      started tasks so step accounting is        *   FILE 134
//*                      not needed.  Goes with IEFUJI above.       *   FILE 134
//*                                                                 *   FILE 134
//*           IKJEFF10 - TSO submit exit from CBT file 369.         *   FILE 134
//*                      See member $$INDEX9 for discussion.        *   FILE 134
//*                                                                 *   FILE 134
//*           IKJEFF53 - TSO FIB exit from IBM IPO.                 *   FILE 134
//*                      See member $$INDEX9 for discussion.        *   FILE 134
//*                                                                 *   FILE 134
//*           IKJEFLD3 - TSO Logon Post-Prompt exit to copy RACF    *   FILE 134
//*                      user's name into TSO session JOB card,     *   FILE 134
//*                      and allow multiple TSO sessions per id.    *   FILE 134
//*                                                                 *   FILE 134
//*           IMAGE1-2 - Static vector graphics sample by Craig     *   FILE 134
//*                      Halliday producing non-standard colours.   *   FILE 134
//*                                                                 *   FILE 134
//*           IMSSIGN  - Usermod for IMS V3R1.  Can easily be       *   FILE 134
//*                      reworked for IMS V4.  IMS types should     *   FILE 134
//*                      definitely check this out.                 *   FILE 134
//*                                                                 *   FILE 134
//*           ISR@PRIM - Sample for installing options "U" and "W". *   FILE 134
//*                      See $$TSDDOC regarding option "U".         *   FILE 134
//*                      See $$INDEX9 regarding option "W".         *   FILE 134
//*                      See $$INDX11 regarding XSPLIT and "XO".    *   FILE 134
//*                                                                 *   FILE 134
//*           JOBCLASS - Example of a suggested method for keeping  *   FILE 134
//*                      users informed of the ever-changing        *   FILE 134
//*                      criteria for job class selection.          *   FILE 134
//*                                                                 *   FILE 134
//*           JOTTO    - Lex Eremin clist for wordy types.          *   FILE 134
//*                                                                 *   FILE 134
//*           LASTCC   - Help member updated for TSO/E V2R3.        *   FILE 134
//*                                                                 *   FILE 134
//*           LDEF.... - Examples of invoking some ISPF             *   FILE 134
//*                      applications using LIBDEF services.        *   FILE 134
//*                      See member $$INDEX9 for discussion.        *   FILE 134
//*                                                                 *   FILE 134
//*           LIFE     - Lex Eremin implementation of the famous    *   FILE 134
//*                      process.  Supports PDSs containing your    *   FILE 134
//*                      favourite scenarios.                       *   FILE 134
//*                                                                 *   FILE 134
//*           LISTBCDS - Clist to use $HBLIST to put a list of all  *   FILE 134
//*                      HSM data set backups into a data set.      *   FILE 134
//*                                                                 *   FILE 134
//*           LISTICAT - Copied from file 047 with catalog          *   FILE 134
//*                      recoverabilty enhancements added.          *   FILE 134
//*                      See member $$INDX14 for description.       *   FILE 134
//*                                                                 *   FILE 134
//*           LISTMCDS - Clist to use $HMLIST to put a list of all  *   FILE 134
//*                      HSM migrated data sets into a data set.    *   FILE 134
//*                                                                 *   FILE 134
//*           LSTWMCDS - Clist to use $HMLISTW to put a list of all *   FILE 134
//*                      HSM migrated data sets into a data set.    *   FILE 134
//*                                                                 *   FILE 134
//*           LISTVOL  - An old favourite adjusted to run on all    *   FILE 134
//*                      known MVSs.  Lists DASD free space.        *   FILE 134
//*                                                                 *   FILE 134
//*           MSGASIDX - MPF exit to add ' - ASID xxxx' to a WTO    *   FILE 134
//*                      where xxxx is the hex ASID.  Useful for    *   FILE 134
//*                      IEF403I to see which batch job(s) caused   *   FILE 134
//*                      storage fragmentation in initiators.       *   FILE 134
//*                                                                 *   FILE 134
//*           MINIZIP# - Documentation on the stand-alone usage of  *   FILE 134
//*                      the MINIZIP and MINIUNZ programs/commands  *   FILE 134
//*                      now included in file 135.  The MINIUNZ     *   FILE 134
//*                      program is called by REVIEW to allow the   *   FILE 134
//*                      browsing (and copying) of data stored in   *   FILE 134
//*                      a ZIP archive file.                        *   FILE 134
//*                                                                 *   FILE 134
//*           MULTITSO - Documentation on using SVC56FE and exit    *   FILE 134
//*                      IKJEFLD3 to allow multiple concurrent      *   FILE 134
//*                      TSO sessions per TSO userid.               *   FILE 134
//*                                                                 *   FILE 134
//*           OFFLMOD  - C program/command by Jason Winter to       *   FILE 134
//*                      perform load module offload into REVLMOD   *   FILE 134
//*                      format without having to use REVIEW        *   FILE 134
//*                      interactively.  For MVS 3.8 to z/OS.       *   FILE 134
//*                                                                 *   FILE 134
//*           OFFLSAMP - Sample JCL to use OFFLMOD.                 *   FILE 134
//*                                                                 *   FILE 134
//*           OAC..... - Macros used by ZAP.                        *   FILE 134
//*                                                                 *   FILE 134
//*           PDSETEST - Show PDSE dir QSAM bug.  Fixed in OS/390.  *   FILE 134
//*                      See member $$INDEX6 for details.           *   FILE 134
//*                                                                 *   FILE 134
//*           PGMCOMP  - Job stream to compile and link Adventure.  *   FILE 134
//*                                                                 *   FILE 134
//*           PGMINIT  - A clist to decode the source of PROGRAM.   *   FILE 134
//*                                                                 *   FILE 134
//*           PGMINST  - Some installation instructions for         *   FILE 134
//*                      PROGRAM (Adventure).                       *   FILE 134
//*                                                                 *   FILE 134
//*           PROGRAM  - PL/I source of Adventure taken from a      *   FILE 134
//*                      SHARE tape and modified.                   *   FILE 134
//*                                                                 *   FILE 134
//*           PS-PS7   - Vector graphics TPUT pgms by Chris Slarke. *   FILE 134
//*                                                                 *   FILE 134
//*           RANDU    - FORTRAN subroutine of PROGRAM (Adventure). *   FILE 134
//*                      Generates no FORTLIB calls.                *   FILE 134
//*                                                                 *   FILE 134
//*           REV$MVS  - JCL to assemble REVIEW under MVS 3.8J      *   FILE 134
//*                      using the Tachyon Legacy Assembler.        *   FILE 134
//*                                                                 *   FILE 134
//*           REV$ZOS  - JCL to assemble REVIEW under z/OS.         *   FILE 134
//*                                                                 *   FILE 134
//*           REVCAT   - SYSCTLG browser adapted from REVIEW just   *   FILE 134
//*                      because CVOLs are organized like PDS       *   FILE 134
//*                      directory blocks.  Shouldn't need it now.  *   FILE 134
//*                                                                 *   FILE 134
//*           REVCMPBF - 3270 buffer compression routine used by    *   FILE 134
//*                      REVIEW and REVCAT.                         *   FILE 134
//*                                                                 *   FILE 134
//*           REVED    - Alias of 'REVIEW' to facilitate editing.   *   FILE 134
//*                                                                 *   FILE 134
//*           REVEDIT  - Source of the REVIEW Editor subroutine.    *   FILE 134
//*                                                                 *   FILE 134
//*           REVEDIT# - TSO help for REVEDIT.                      *   FILE 134
//*                                                                 *   FILE 134
//*           REVGEN   - REVIEW source option settings.             *   FILE 134
//*                                                                 *   FILE 134
//*           REVIEW   - The original reason for this whole file.   *   FILE 134
//*                      "Release 49.7"                             *   FILE 134
//*                      Non-ISPF full-colour fullscreen tape/disk  *   FILE 134
//*                      VSAM/non-VSAM data set and DB2 tablespace  *   FILE 134
//*                      parallel browser, PDS searcher, editor,    *   FILE 134
//*                      SMF/LOGREC/VTOC and general DSECT record   *   FILE 134
//*                      formatter, PDS offloader, data filter,     *   FILE 134
//*                      reclaimer and translator, front-end for    *   FILE 134
//*                      PDS reloader, load module delinker, and    *   FILE 134
//*                      unzipper.  Now with logical PARMLIB        *   FILE 134
//*                      support, ZIP file directory formatting,    *   FILE 134
//*                      PCX (Paintbrush) and BMP (Windows and OS/2 *   FILE 134
//*                      bitmap) file picture image rendering,      *   FILE 134
//*                      program object history and mapping, and    *   FILE 134
//*                      point-and-shoot entry.  "USS Explorer".    *   FILE 134
//*                      Navigate around HFS directories.  REVIEW,  *   FILE 134
//*                      browse, edit and search UNIX files.        *   FILE 134
//*                      Display program object long alias names.   *   FILE 134
//*                      Display job status and held SYSOUT data.   *   FILE 134
//*                      Lifted from CBT mods tape version 230      *   FILE 134
//*                      circa 1984 and has been a "terminal" case  *   FILE 134
//*                      of creeping featurism ever since.  Read    *   FILE 134
//*                      leading comments for changes.  A piece of  *   FILE 134
//*                      resistance.  Should work without error on  *   FILE 134
//*                      all known MVS levels up to z/OS.           *   FILE 134
//*                                                                 *   FILE 134
//*           REV$$$$$ - An explanation of REVIEW packaging. The    *   FILE 134
//*                      entire package can now be installed using  *   FILE 134
//*                      XMIT-format files, marked with an ISPF     *   FILE 134
//*                      userid of REVXMIT.  (Release 48.6)         *   FILE 134
//*                                                                 *   FILE 134
//*           REVIEW#  - TSO help for REVIEW.                       *   FILE 134
//*                                                                 *   FILE 134
//*           REVIEW@  - A discussion of advanced (undocumented)    *   FILE 134
//*                      'REVIEW' features/behaviour/logic/illogic. *   FILE 134
//*                      (For release 16, so it is a bit old now.)  *   FILE 134
//*                                                                 *   FILE 134
//*           REVINST  - Installation steps for 'REVIEW' and 'HEL'. *   FILE 134
//*                                                                 *   FILE 134
//*           REVLMOD  - Load module reconstruction program used    *   FILE 134
//*                      by REVIEW or run as a batch utility.       *   FILE 134
//*                                                                 *   FILE 134
//*           REVLMOD$ - JCL to assemble REVLMOD.                   *   FILE 134
//*                                                                 *   FILE 134
//*           REVLSAMP - Sample JCL to use REVLMOD.                 *   FILE 134
//*                                                                 *   FILE 134
//*           REVMSGS  - REVIEW fullscreen message CSECT.           *   FILE 134
//*                                                                 *   FILE 134
//*           REVOUT   - Fullscreen job status and held SYSOUT      *   FILE 134
//*                      display - an alias of 'REVIEW'.            *   FILE 134
//*                                                                 *   FILE 134
//*           REVOUT#  - TSO help for REVOUT.                       *   FILE 134
//*                                                                 *   FILE 134
//*           REVOUTJB - TSO clist used by REVOUT.                  *   FILE 134
//*                                                                 *   FILE 134
//*           REVPCX.. - Sample PCX files to allow testing of       *   FILE 134
//*                      REVIEW picture rendering without file      *   FILE 134
//*                      transfer - need 3270 graphics terminal.    *   FILE 134
//*                      Note that GDDM (base) may be called.       *   FILE 134
//*                                                                 *   FILE 134
//*           REVPDS#  - REVIEW PDS member list TSO HELP.           *   FILE 134
//*                                                                 *   FILE 134
//*           REVPDSE# - REVIEW PDSE program member list TSO HELP.  *   FILE 134
//*                                                                 *   FILE 134
//*           REVPLIB  - TSO/E XMIT file of REVIEW's ISPF panels.   *   FILE 134
//*                                                                 *   FILE 134
//*           REVPROF  - ISPF profile member for REVIEW.            *   FILE 134
//*                                                                 *   FILE 134
//*           REVSMF   - SMF record formatting routine of REVIEW.   *   FILE 134
//*                      Handles lots of SMF records with some code *   FILE 134
//*                      pinched from $SMFBRWS.  Updated to         *   FILE 134
//*                      MVS/SP5.2 level.  Several record formats   *   FILE 134
//*                      are now left/right scroll sensitive.       *   FILE 134
//*                      See member REVIEW@ for discussion.         *   FILE 134
//*                                                                 *   FILE 134
//*           REVSMF$  - JCL to assemble REVSMF.                    *   FILE 134
//*                                                                 *   FILE 134
//*           REVSUBS  - Source of REVIEW subroutine CSECTs.        *   FILE 134
//*                                                                 *   FILE 134
//*           REVTAPE  - Sample clist showing use of REVIEW to find *   FILE 134
//*                      out what is on a tape.  Can be handy if    *   FILE 134
//*                      you don't know what is on a tape and you   *   FILE 134
//*                      are allergic to JCL.                       *   FILE 134
//*                                                                 *   FILE 134
//*           REVUNIX# - REVIEW UNIX directory list TSO help.       *   FILE 134
//*                                                                 *   FILE 134
//*           RIAWHO   - A CICS transaction.  Searches the TCT.     *   FILE 134
//*                      If userid supplied, returns the transac-   *   FILE 134
//*                      tion, terminal id, and netname.            *   FILE 134
//*                      If termid supplied, returns the userid,    *   FILE 134
//*                      transaction and netname.                   *   FILE 134
//*                      Applid, time, and date are also displayed. *   FILE 134
//*                      Okay for autoinstall.  (From Ann Austin.)  *   FILE 134
//*                                                                 *   FILE 134
//*           R062A10  - Object deck from CBT file 352.             *   FILE 134
//*                      Assembler subroutine of 'PROGRAM'          *   FILE 134
//*                      included here for completeness.            *   FILE 134
//*                                                                 *   FILE 134
//*           SCANX    - PDS scanner.  Search arguments can be from *   FILE 134
//*                      the simple to the boolean ridiculous.  Can *   FILE 134
//*                      also select/exclude certain member groups  *   FILE 134
//*                      (based on member name prefix) to reduce    *   FILE 134
//*                      the search time.  Most conveniently        *   FILE 134
//*                      invoked from TSD utility panels.           *   FILE 134
//*                                                                 *   FILE 134
//*           SHOWDS   - Famous TSO command lifted from CBT mods    *   FILE 134
//*                      file of share tape in 1983 and modified    *   FILE 134
//*                      for ICF etc.  A must.  Won't recall        *   FILE 134
//*                      migrated data sets by accident.  Read      *   FILE 134
//*                      leading comments in source for exact       *   FILE 134
//*                      details.  Similar versions probably        *   FILE 134
//*                      available from elsewhere on the CBT tape.  *   FILE 134
//*                      Should work without error on all known MVS *   FILE 134
//*                      levels up to z/OS.                         *   FILE 134
//*                                                                 *   FILE 134
//*           SHOWDS$  - JCL to assemble SHOWDS.                    *   FILE 134
//*                                                                 *   FILE 134
//*           SHOWDS#  - TSO help for SHOWDS.                       *   FILE 134
//*                                                                 *   FILE 134
//*           SKJ..... - See $$TSDDOC.                              *   FILE 134
//*                                                                 *   FILE 134
//*           SNAKE    - Greg Price's interpretation for TSO of a   *   FILE 134
//*                      program seen on a Unix system.             *   FILE 134
//*                                                                 *   FILE 134
//*           SNAKE$   - JCL to assemble SNAKE.                     *   FILE 134
//*                                                                 *   FILE 134
//*           SPGSMPE  - SMP/E dialog front-end for sysprogs who    *   FILE 134
//*                      routinely access more than one global      *   FILE 134
//*                      zone.  See ISR@PRIM for invocation.        *   FILE 134
//*                      Also see member $$INDEX9 for discussion    *   FILE 134
//*                      on various methods of invocation with      *   FILE 134
//*                      LIBDEFs and so on.  (This is option "W".)  *   FILE 134
//*                                                                 *   FILE 134
//*           SPGSMPEP - Panel for SPGSMPE clist.                   *   FILE 134
//*                                                                 *   FILE 134
//*           SPGSMPE4 - SPGSMPE clist for SMP/E release 4.         *   FILE 134
//*                                                                 *   FILE 134
//*           SPGSMPE5 - SPGSMPE clist for SMP/E release 5.1.       *   FILE 134
//*                                                                 *   FILE 134
//*           SVC56FE  - Front end to SVC 56 (ENQ) to convert all   *   FILE 134
//*                      SYSIKJUA enqueues to SHARED.  Part of the  *   FILE 134
//*                      MULTITSO package.  Install with SVC56FE$.  *   FILE 134
//*                                                                 *   FILE 134
//*           SVC56LDR - Program to activate SVC56FE.  Part of the  *   FILE 134
//*                      MULTITSO package.  Install with SVC56LD$.  *   FILE 134
//*                                                                 *   FILE 134
//*           SVMDSSU  - Front end to DF/DSS to backup VM volumes   *   FILE 134
//*                      under MVS.  See member $$INDEX2 for a      *   FILE 134
//*                      detailed discussion.                       *   FILE 134
//*                                                                 *   FILE 134
//*           TERMTEST - Non-GDDM TSO terminal capablity tester and *   FILE 134
//*                      symbol editor.  Crank it up for a test     *   FILE 134
//*                      run.  The snazzier the terminal the better *   FILE 134
//*                      (pretty well).  Needs the DCS macro to     *   FILE 134
//*                      assemble.  Program organized like a dog's  *   FILE 134
//*                      dinner but it does the job; a triumph of   *   FILE 134
//*                      the monolithic approach.  A mantelpiece.   *   FILE 134
//*                      Installation recomendation:                *   FILE 134
//*                      install into linklist so that any user can *   FILE 134
//*                      use it on his/her own terminal while in    *   FILE 134
//*                      diagnostic telephonic dialog with          *   FILE 134
//*                      system/network support.  (eg. is the Query *   FILE 134
//*                      bit on?  What screen sizes does the VTAM   *   FILE 134
//*                      logmode allow?  Which APL characters are   *   FILE 134
//*                      correctly supported?  Etc.)                *   FILE 134
//*                      Needless to say, full-screen program       *   FILE 134
//*                      developers may find TERMTEST handy to      *   FILE 134
//*                      determine or verify the codes for specific *   FILE 134
//*                      screen locations, graphic characters and   *   FILE 134
//*                      attention identifiers.  On the other hand, *   FILE 134
//*                      someone may just want to play around with  *   FILE 134
//*                      features of the terminal hardware.  Also   *   FILE 134
//*                      see "TERMTEST TALK" in member $$INDEX2.    *   FILE 134
//*                                                                 *   FILE 134
//*           TERMTYPE - Macro to perform TSS TERMTYPE function.    *   FILE 134
//*                      supplied here so that TERMTEST and VIEW    *   FILE 134
//*                      may be assembled without source changes.   *   FILE 134
//*                                                                 *   FILE 134
//*           TESTLSTI - TSO TEST zap from $SP4MODS updated due     *   FILE 134
//*                      PUT maintenance.                           *   FILE 134
//*                                                                 *   FILE 134
//*           TEWN     - Wacky screen test.                         *   FILE 134
//*                                                                 *   FILE 134
//*           TSD..... - See $$TSDDOC.                              *   FILE 134
//*                                                                 *   FILE 134
//*           TSOPNAME - Dinky little prog to copy RACF programmer  *   FILE 134
//*                      name into JES2 JCT programmer name field.  *   FILE 134
//*                      Intended for TSO logon clist so TSU        *   FILE 134
//*                      generated output has the programmer name   *   FILE 134
//*                      in the separators.  JES2 2.2.0/3.1.1       *   FILE 134
//*                      version supplied here.  Can be changed     *   FILE 134
//*                      easily to support Top Secret rather than   *   FILE 134
//*                      RACF.  (Not needed for ACF2.)              *   FILE 134
//*                                                                 *   FILE 134
//*           UIDSTR   - TSO command for within clists only.        *   FILE 134
//*                      Returns the ACF2 uid string into a clist   *   FILE 134
//*                      variable called &UIDSTR.                   *   FILE 134
//*                                                                 *   FILE 134
//*           VIEW     - MVS/370 (and, if you're interested, MSP)   *   FILE 134
//*                      program to perform a SENSE ID to a         *   FILE 134
//*                      nominated I/O device, or a read buffer to  *   FILE 134
//*                      a nominated graphic display device.  Does  *   FILE 134
//*                      not support extended architecture.         *   FILE 134
//*                                                                 *   FILE 134
//*           VMUCBZAP - Much the same as SVMDSSU except that it    *   FILE 134
//*                      was not specifically a front end to        *   FILE 134
//*                      anything.  Lets you BROWSE/REVIEW/ZAP or   *   FILE 134
//*                      whatever VM minidisks from MVS.  See       *   FILE 134
//*                      member $$INDEX2 for more details.          *   FILE 134
//*                                                                 *   FILE 134
//*           WORM     - Greg Price's interpretation for TSO of a   *   FILE 134
//*                      program seen on a Unix system.  A          *   FILE 134
//*                      breakthrough in er... something.  Useful   *   FILE 134
//*                      (?) to measure TPUT elapsed time to get an *   FILE 134
//*                      idea of network delay.  Read comments in   *   FILE 134
//*                      source for full doco.                      *   FILE 134
//*                                                                 *   FILE 134
//*           WORM$    - JCL to assemble WORM.                      *   FILE 134
//*                                                                 *   FILE 134
//*           X....... - Components of the famous SUPERLST VTOC     *   FILE 134
//*                      lister.  Fully supports the latest VTOC    *   FILE 134
//*                      snazzies.  Read comments in XVTCLIST for   *   FILE 134
//*                      details.  (Small fix applied. SG per GIP)  *   FILE 134
//*                                                                 *   FILE 134
//*           XSPLIT   - Clist to create new ISPF session over      *   FILE 134
//*                      your current ISPF session.  Needs an       *   FILE 134
//*                      addition to your ISPCMDS.  See $$INDX11.   *   FILE 134
//*                                                                 *   FILE 134
//*           XVTOCASM - JCL to assemble SUPERLST.                  *   FILE 134
//*                                                                 *   FILE 134
//*           ZAP      - UCLA TSO ZAP command from the CBT mods     *   FILE 134
//*                      file of version 22 of the SHARE tape circa *   FILE 134
//*                      1983 with some extra modifications.        *   FILE 134
//*                      Perhaps the main change is full-volume     *   FILE 134
//*                      zapping support which, of course, requires *   FILE 134
//*                      the appropriate APF and RACF authorities.  *   FILE 134
//*                                                                 *   FILE 134
//*           ZAP$     - JCL to assemble ZAP.                       *   FILE 134
//*                                                                 *   FILE 134
//*           ZAP$DOC  - Bruce Bordonaro's notes on this version    *   FILE 134
//*                      of the UCLA ZAP command.                   *   FILE 134
//*                                                                 *   FILE 134
//*           ZAP#     - TSO help for ZAP.                          *   FILE 134
//*                                                                 *   FILE 134
//*           For additional information see the members            *   FILE 134
//*           $$INDEX through $$INDX40.                             *   FILE 134
//*                                                                 *   FILE 134

//***FILE 135 is from Mr Greg Price of Prycroft Six                 *   FILE 135
//*           in Melbourne,  Victoria,  Australia.                  *   FILE 135
//*           This file is in IEBCOPY format and contains           *   FILE 135
//*           ready-to-use load modules.                            *   FILE 135
//*           Current level of REVIEW is 49.0.                      *   FILE 135
//*                                                                 *   FILE 135
//*        ** Programs and commands from file 134:                  *   FILE 135
//*                                                                 *   FILE 135
//*           $CRYPT   - TSO cp - aliases $ENCRYPT and $DECRYPT     *   FILE 135
//*           $FREEALL - TSO cp                                     *   FILE 135
//*           $HBLIST  - TSO cp - dsname 'HSM.BCDS' hard coded      *   FILE 135
//*           $HMLIST  - TSO cp - dsname 'HSM.MCDS' hard coded      *   FILE 135
//*           $HMLISTW - TSO cp - dsname 'HSM.MCDS' hard coded      *   FILE 135
//*           $LISTX   - TSO cp - alias $LISTM                      *   FILE 135
//*           ANIM1-5  - TSO cp or pgm                              *   FILE 135
//*           CDSCB    - TSO cp                                     *   FILE 135
//*           CONCAT   - TSO cp                                     *   FILE 135
//*           CUBE     - TSO cp or pgm                              *   FILE 135
//*           DCPU     - TSO/batch/STC pgm                          *   FILE 135
//*           DDASD    - TSO cp or batch/STC pgm                    *   FILE 135
//*           DIVER    - TSO cp or pgm - GE support assumed         *   FILE 135
//*           DUPTIME  - TSO cp or TSO/batch/STC pgm - alias DUP    *   FILE 135
//*           FLAG     - TSO cp or pgm - TPUT demo                  *   FILE 135
//*           FSHELP   - TSO cp - alias FSH - alias of REVIEW       *   FILE 135
//*           GE2      - TSO cp or pgm - TPUT demo                  *   FILE 135
//*           GRPSTR   - TSO cp within clist only - RACF only       *   FILE 135
//*           HEL      - TSO cp - fullscreen help - alias of REVIEW *   FILE 135
//*           IEFU83   - SMF exit from $$IEFU83                     *   FILE 135
//*           IKJEFF10 - TSO exit - ISPF V3.4 offsets assumed       *   FILE 135
//*           IKJEFF53 - TSO exit                                   *   FILE 135
//*           IMAGE1-2 - TSO cp or pgm                              *   FILE 135
//*           LIFE     - TSO cp                                     *   FILE 135
//*           LISTICAT - List ICF catalog utility                   *   FILE 135
//*           LISTVOL  - TSO cp - alias LISTV                       *   FILE 135
//*           MONO     - TSO pgm - Monopoly                         *   FILE 135
//*           MSGASIDX - MPF exit                                   *   FILE 135
//*           MSGFLUSH - MPF exit from $$IEFU83                     *   FILE 135
//*           MSGJOBLG - MPF exit from $$IEFU83                     *   FILE 135
//*           MSGNOJLG - MPF exit from $$IEFU83                     *   FILE 135
//*           MSGNOLOG - MPF exit from $$IEFU83                     *   FILE 135
//*           MSG2USER - MPF exit from $SP4MODS                     *   FILE 135
//*           OFFLMOD  - TSO/batch C utility by Jason Winter.       *   FILE 135
//*           PROGRAM  - TSO pgm - PL/I Adventure                   *   FILE 135
//*           PS-PS7   - TSO cp or pgm - TPUT demo                  *   FILE 135
//*           REVIEW   - TSO cp - has the following aliases:        *   FILE 135
//*                      REV,REVED,REVOUT,REVVSAM,HEL,FSHELP,FSH.   *   FILE 135
//*           REVLMOD  - TSO/batch pgm - mainly for use by REVIEW   *   FILE 135
//*           REVSMF   - External subroutine of REVIEW              *   FILE 135
//*           RFE      - REVIEW Front End                           *   FILE 135
//*           SCANX    - TSO/batch PDS search utility program       *   FILE 135
//*           SHOWDS   - TSO cp - alias SDS                         *   FILE 135
//*           SKJ$LC00 - TSO cp - aliases $LCSPF, $LISTC and $SPACE *   FILE 135
//*           SMFJBTIM - SMF type26 post-processing utility program *   FILE 135
//*           SNAKE    - TSO cp or pgm -                            *   FILE 135
//*                      aliases HALFSNAK, HS, QS and QUARTERS      *   FILE 135
//*           SUPERLST - VTOC listing utility program               *   FILE 135
//*           TERMTEST - TSO cp or pgm - TSO 3270 terminal tester   *   FILE 135
//*           TESTDCS-2- TSO cp or pgm - TPUT demo                  *   FILE 135
//*           TEWM     - TSO cp or pgm - TPUT demo                  *   FILE 135
//*           TSOPNAME - TSO cp or pgm - check JES2/RACF levels     *   FILE 135
//*           UIDSTR   - TSO cp within clist only - ACF2 only       *   FILE 135
//*           VIEW     - TSO program - pre-XA only                  *   FILE 135
//*           WORM     - TSO cp or pgm - aliases HALFTEST, HW, QW,  *   FILE 135
//*                      HALFWORM, QUARTEST and QUARTERW            *   FILE 135
//*           ZAP      - TSO cp - alias ZAP$ (ZAP$ is used by PDS)  *   FILE 135
//*                                                                 *   FILE 135
//*        ** Programs and commands from file 90:                   *   FILE 135
//*                                                                 *   FILE 135
//*           DELINKI  - Utility which can be used by REVIEW        *   FILE 135
//*           DWNSPDSR - External subroutine of DELINKI             *   FILE 135
//*                                                                 *   FILE 135
//*        ** Programs and commands from file 93:                   *   FILE 135
//*                                                                 *   FILE 135
//*           PDSLOAD  - Utility which can be used by REVIEW        *   FILE 135
//*                                                                 *   FILE 135
//*        ** Programs and commands from file 182:                  *   FILE 135
//*                                                                 *   FILE 135
//*           PDS86    - TSO cp - alias PDS                         *   FILE 135
//*                      This is for (mainly non-U.S.) sites who    *   FILE 135
//*                      prefer the DD/MM/YY date format.           *   FILE 135
//*                                                                 *   FILE 135
//*        ** Programs and commands from file 183:                  *   FILE 135
//*                                                                 *   FILE 135
//*           BR       - TSO cp - ISPF only - BROWSE any dsorg      *   FILE 135
//*           FASTPATH - TSO cp - ISPF only - adds in-core ISPCMDS  *   FILE 135
//*           LCAT     - TSO cp - ISPF only - alias LC              *   FILE 135
//*                                                                 *   FILE 135
//*        ** Programs and commands from file 296:                  *   FILE 135
//*                                                                 *   FILE 135
//*           COMPARE  - TSO cp - front end to COMPAREB/IEBCOMPR    *   FILE 135
//*           COMPAREB - Yale compare utility program               *   FILE 135
//*                                                                 *   FILE 135
//*        ** Programs and commands from file 300:                  *   FILE 135
//*                                                                 *   FILE 135
//*           IKJT9FI  - TSO TEST subcommand - update IKJTSO00      *   FILE 135
//*           IKJT9LB  - TSO TEST subcommand - update IKJTSO00      *   FILE 135
//*           LOGO     - GDDM example from source member GDDM       *   FILE 135
//*           NITEFLT  - GDDM example from source member GDDM       *   FILE 135
//*           SABREBAT - GDDM example from source member GDDM       *   FILE 135
//*           SHUTTLE  - GDDM example from source member GDDM       *   FILE 135
//*                                                                 *   FILE 135
//*        ** Programs and commands from file 492:                  *   FILE 135
//*                                                                 *   FILE 135
//*           SHOWzOS  - TSO cp or pgm - ISPF recommended           *   FILE 135
//*                                                                 *   FILE 135

```
