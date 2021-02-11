***********************************************************************
* Many thanks go out to those of you on the MVS and Assembler         *
* ListServs who answered the many questions I had while I was         *
* creating this beastie.                                              *
***********************************************************************

OVERVIEW
  This dataset contains several programs which may be of general
  interest to other installations.  They are, of course, available on
  an as-is condition with the usual disclaimer.

  I am under no illusions about the level of my assembler coding
  skills.  I'm not an expert by any means.  However, having said
  that, these programs were used in z/OS 1.7 and our current z/OS
  1.9 environment.  They should work on any IBM supported system.
  Some may not work on earlier systems.

  This dataset contains the source code and JCL needed to establish
  an SNMP sub-agent, an EMC (Extended MCS) monitoring started task
  and an externally called storage snap program.  Run the $PDSLOAD
  job to create the macro library from the MACROS member of this
  pds.

  The IBM macros can be found in SYS1.MACLIB, TCPIP.SEZAMAC and
  SYS1.AMODGEN. A list of the macros and control block DSECTS used
  can be found in member $$CTLBLK.

  For some of the metrics I gather, I couldn't figure out how to get
  the information through control block chaining (I DID mention I
  wasn't an expert in this). To compensate for this, I use/call system
  REXX execs from which I issue JES2 commands, HSM commands, etc. and
  process the output from these commands. Not the most efficient way
  to do it, but it works.

  2/10/09 - As of this writing, I have discovered a bug with system
  REXX in that AXRCMD does not handle certain types of multi-line
  command output (e.g. $DSPOOL, F HSM,QUERY CDS, etc.). A PMR has
  been opened with IBM.

NIMAGENT
  This SNMP sub-agent attaches several subtasks which query/check
  various system metrics and updates established MIB values. These
  values may then be queried by an external monitor (such as NimBUS
  in our case) and alerting done. All of the SNMP interfacing is done
  via the Distributed Program Interface (DPI). See RFC 1228 for more
  information.

  Future enhancements:
  - Eliminate the system REXX execs by going directly to the control
    blocks
  - Finish the RENT process. Currently the sub-tasks are re-entrant
    but the overall load module is not.
  - Add a MODIFY command to dynamically change the timer interval for
    any of the sub-tasks (currently hardcoded).

NIMBEMCS
  The EMC monitoring program can be used to monitor console messages
  and issue SNMP traps to an external monitoring system for alerting
  purposes. The sample included here was based on a sample IBM
  program found in SYS1.SAMPLIB(IEAEXMCS).

  Note: The EMC monitoring program issues SNMP traps.  Ours is coded
  to use the 'awtrap' program which I found within the base Unicenter
  code from Computer Associates (CAI) and is found in the HFS/ZFS
  file:
     /cai/agent/ro/awtrap

  If you do not have access to this command, you will need to code
  or find own trap command or issue one via DPI.

PCCSSNAP
  PCCSSNAP is a re-entrant program that can be linked to from a
  program and used to snap storage areas for debugging purposes. The
  addresses of the storage area to be snapped are passed via a
  parmlist. The snap output is directed to a JES2 sysout dataset,
  which a DD (SNAPDD) is dynamically allocated for.


Dataset Contents:

  Member      Description
  --------------------------------------------------------------
  $$DISCL   - Disclaimer
  #README   - This member description list
  ASM       - Assemble/link entire sub-agent
  ASM1      - Assemble/link a single subtask
  Author    - Contact information
  LINK1     - Linkedit sub-agent
  NIMAGENT  - Started task JCL for NIMAGNT program
  NIMAGNT   - Main sub-agent
  NIMBEMCS  - Console monitoring program
  NIMBCONS  - Started task JCL for NIMBEMCS program
  NIMDASD   - Subtask: DASD checks
  NIMESTA   - Sub-agent/sub-task ESTAI routine
  NIMEXST   - Subtask: Started task existence checking
  NIMHSM    - Subtask: HSM checking
  NIMJES2   - Subtask: JES2 checking
  NIMMIB    - Subagent MIB
  NIMSYS    - Subtask: System information
  NMIBDESC  - Sample MIBDESC for TCPIP
  NMIBSDAT  - Sample MIBDATA for TCPIP
  PCCSSNAP  - Callable program to snap data areas for debugging
  QUERYJES  - System REXX exec to query JES2 metrics (used in NIMJES2)

  The following were used to develop the code to be included within
  a sub-task

  SYSREXX   - JCL to execute a program that calls a system REXX exec
  SYSREXXJ  - Program to call system REXX exec (code used in NIMJES2)
