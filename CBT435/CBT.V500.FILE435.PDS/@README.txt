 There are thirteen (13) routines in this set:  ALIST, BLOX, DFLTHLQ,
 FCXREF, FIRSTIME, FTINIT, SQRT, LA, SQUASH, TRAPOUT, MEMBERS, TBLOOK,
 and X2B.  Some of these are subroutines (DFLTHLQ, FTINIT, TRAPOUT) and
 are not designed to run stand-alone.  The others (except BLOX) produce
 HELP text if the first parameter is a "?"; BLOX shows its HELP text if
 -no- parameters are passed.

  ALIST         produces a scrollable list of the datasets allocated to
                the specified DDNames.  {ALIST ?}
  BLOX          creates 8x7 block letters from text you specify
  DFLTHLQ       subrtn
  FCXREF        does a member-crossref by DDName {FCXREF ?}
  FIRSTIME      controls once-pre-period executions {FIRSTIME ?}
  FTINIT        subrtn; used by FIRSTIME
  LA            LISTA to the queue {LA ?}
  MEMBERS       memberlist to the queue {MEMBERS ?}
  SQRT          Square root
  SQUASH        compose IEBCOPY JCL for the current dataset {SQUASH ?}
  TBLOOK        examine any ISPF table {TBLOOK ?}
  TRAPOUT       subrtn; save TRACE output into a Sysouttrap
  X2B           hex-to-binary; used by BLOX

