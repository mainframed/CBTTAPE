  /* --------------------  rexx procedure  -------------------- *
  | Name:      RACFADM Stub                                    |
  |                                                            |
  | Function:  Allocate the RACFADM Libraries and then         |
  |            invoke the RACFADM application.                 |
  |                                                            |
  | Syntax:    %racfadm                                        |
  |                                                            |
  | Usage Notes: 1. Copy into a library in the standard        |
  |                 SYSEXEC (or SYSPROC) allocations for the   |
  |                 intended users.                            |
  |              2. Tailor the HLQ variable for the RACFADM    |
  |                 high-level-qualifier.                      |
  |                                                            |
  * ---------------------------------------------------------- */
  hlq = 'radmhlq'   /* <=== Change this variable */

  Address TSO
  "Altlib Act App(Exec) Dataset('"hlq".racfadm.exec')"
  Address ISPExec
  "Libdef ISPMLIB Dataset ID('"hlq".racfadm.msgs') stack"
  "Libdef ISPPLIB Dataset ID('"hlq".racfadm.panels') stack"
  "Libdef ISPSLIB Dataset ID('"hlq".racfadm.skels') stack"
  "Select Cmd(%RacfADM NA) NewAppl(RADM) Passlib"
  "Libdef ISPMLIB"
  "Libdef ISPPLIB"
  "Libdef ISPSLIB"
  Address TSO
  "Altlib DeAct App(Exec)"
