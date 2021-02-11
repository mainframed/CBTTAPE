MXI ReadMe Text (Updated 14th February 2003)

----------------------------------------------------------------------------
Version and Release Notes :

4.3
 o  Added the MENU command and changed the entire menu system.
 o  Added the GQE command to display common storage getmains.
 o  Added the DB command to list DB2 subsystems.
 o  Added the DBBP command to list DB2 buffer pools.
 o  Added the DBDA command to list DB2 threads.
 o  Added the DBEP command to list DB2 EDM pool statistics.
 o  Added the DBGP command to list DB2 getpage requests.
 o  Added the DBLK command to list DB2 locking statistics.
 o  Added the DBZP command to list DB2 system parameters.
 o  Added the JOB() ASID() and PGM() keywords to the USP command.
 o  Added the CADS count to the DSP display.
 o  Added the DSNS count to the PAGE display.
 o  Point and shoot on column headings on tabular displays now invoke
    SORT for that column. Performing this action twice inverts the SORT
    direction.
 o  Point and shoot on the jobname in the CSR display now takes you to
    the GQE display showing orphaned storage that matches the jobname.
 o  Added the CLIENT= keyword to MXISERV to increase remote security.
 o  Added the USERTRAN= keyword to MXISERV to allow client userid
    translation.
 o  Added a TCP/IP security exit to enhance non-MVS client request
    security.
 o  Non-authorised commands can now be protected via internal or
    external security.
 o  Removed the leading zero on address space id restriction on the DA
    command.

    ** IMPORTANT **
    MXI 4.3 now provides the ability the protect non-authorised
    commands.

    Please review your RACF profiles or MXISECTB source.

    If you previously coded NOENTRY=DENY (internal) or UACC=NONE
    on MXICMD.* (external), you will need to adjust the rules to
    cater for all non-auth commands.
    ** IMPORTANT **

4.2
 o Added the CDR command to list device serial numbers.
 o Added the CON command to show MCS console screen images.
 o Added the ENC command to list enclaves.
 o Added the LOGR command to list log streams.
 o Added the MQ command to show MQ Series subsystems.
 o Added the MQC command to show MQ Series channels.
 o Added the MQCS command to show MQ Series channel status.
 o Added the MQDA command to show MQ Series active threads.
 o Added the MQQ command to show MQ Series queues.
 o Added the MQU command to show MQ Series page set usage.
 o Added the region information to the DA display for a single ASID.
 o Added the ONLY(INIT) keyword to the DA command.
 o Added the LLASMF global option to specify the SMF record number to
   be used in the MXILLIX1 exit.
 o Add support for CMF when collecting type-70 records.
 o Added the CCT MCT and RCT control block definitions to the MEM
   command.
 o Added the OMVS info to the RACF GROUP display on the RL command.
 o Added the CDR information to the DASD and TAPE displays.
 o Removed the leading zero on unit address restriction on the TAPE and
   UCB commands.

4.1
 o  Added the RSYS command to connect to remote systems
 o  Added the MXI TCP/IP Server address space.
 o  Added the MXI subsystem.
 o  Added the LLA command to show LLA module fetch statistics.
 o  Added the SOFT command to show system software levels.
 o  Indicate SCOPE=COMMON dataspaces on the DSP command display.
 o  Changed the panel title lines to include system information.
 o  MXI global options now specified via macro statements rather than
    zaps.
 o  Renamed the help panels.

3.4
 o  Added the DEV command to show DASD activity (if RMF/CMF is active).
 o  Added the HSM command to show HSM configuration.
 o  Added the WLMA command to show WLM Application Environments.
 o  Added the WLMS command to show WLM Scheduling Environments.
 o  Added the ZAP command to alter common storage contents.
 o  Added the JOB() and ASID() keywords to the PID command.
 o  Added the VIEW() keyword to the HFS command so that the user can
    toggle between path and dataset views of the file systems.
 o  The WTOR command now accepts a pattern mask for the system name so
    the results can be filtered.
 o  Added the OMVS segment on the RL display for USER profiles.
 o  Added the Sysplex information to the IPL display.
 o  All IDs listed in the RACF access lists are now point-and-shoot.
 o  The HSMQ command now reports on HSM command requests.
 o  The CAT command now displays certain catalog cache information.
 o  Add support for UIC values greater than 255 for z/OS in ESAME mode.
 o  The E-MCS wait time limits for the / command are now placed in the
    MXIOPTN CSECT rather than RDSEMCS. New ZAP instructions included in
    the INSTLIB dataset.

3.3
 o  Added the DAE command to list Dump Elimination information.
 o  Added the HFS command to show OpenEdition file systems.
 o  Added the LX command to list linkage indexes and PC routines.
 o  Added the OMVS command to show OpenEdition configuration.
 o  Added the PID command to show OpenEdition processes.
 o  Added the WLMC command to list WLM classification rules.
 o  Added the WLMG command to list WLM classification groups.
 o  Added the SET CONSOLE command to specify the E-MCS console name used by MXI
    in the '/' command.
 o  Added the ONLY() and NOT() keywords to the RCLS command.
 o  Added the ONLY() and NOT() keywords to the UCB command.
 o  Added the CPU(MAX) and CPU(MIN) keywords to the MAKE command.
 o  The RL command now prompts in ISPF mode if no keywords specified.
 o  The HSMQ command now uses cross-memory techniques to gather the required
    information rather than parsing operator command responses.
 o  Added AFC information to the CPU UIC and RS command displays.
 o  Added the UCB address on the DASD display for a single volume.
 o  Added the UCB address on the TAPE display for a single unit.
 o  Added the Installation Data to the RL command output.
 o  Added the SVT control block to the MEM and MAP commands.
 o  Commands that the user is not authorised to use are no longer shown on their
    MXI Primary Option Menu.
 o  Removed the PC command.

3.2
 o  Authorised commands can now be protected by the RACF FACILITY class.
 o  Added the AUTO command to automatically refresh the screen.
 o  Added the EMCS command to show E-MCS consoles.
 o  Added the INIT command to show JES2 initiators.
 o  Added the MCS command to show MCS consoles.
 o  Added the MDQ command to show the memory delete queue.
 o  Added the RACF command to show RACF information.
 o  Added the RL command to show specific RACF profile information.
 o  Added the RCLS command to show RACF class information.
 o  Added the SRVC command to show the WLM service classes.
 o  Added the WLM command to show the WLM policy information.
 o  Added the XM command to show the cross-memory connections
 o  Changed the VMAP command to show user region info.
 o  Changed the DA command to include cross-memory connection info.
 o  Changed the DA command to replace performance group number with WLM service
    class for goal mode systems.
 o  Changed the IPL command to include WLM mode setting.
 o  The DASD command now shows if volume is in CAXWA chain.
 o  The EXC command now sorts the address space exceptions by severity.
 o  Added the SMFDUMP (TYPE=SYS) exception to examine the number of SMF
    datasets in DUMP REQUIRED status.
 o  The pull down menus have been re-arranged.
 o  Added the following command aliases to the MXICMDS ISPF table :
        OJOB     DA * ONLY(JOB)
        OSTC     DA * ONLY(STC)
        OTSU     DA * ONLY(TSU)
        JOBS     DA * ONLY(JOB)
        SYSTEM   DA * ONLY(STC)
        USERS    DA * ONLY(TSU)

3.1a
 o  Implemented pull down menus.
 o  The  SORT command now accepts a column name and direction rather than using
    point-and-shoot methods.
 o  All tabular displays now have just ONE line of column heading rather than
    TWO lines. All column names are now ONE word.
 o  Added the DSP command to show dataspace information.
 o  Added the PEEK command to show all ISPF screen images for a TSO user.
 o  Added the WTOR command to show all outstanding operator replies.
 o  Added the CPF command to show the command prefix table.
 o  Added the JOB() and ASID() keywords to the MEM command to allow listing
    of the storage within any address space.
 o  Added the WTOR exception (TYPE=SYS) to examine number of outstanding
    operator replies.
 o  Add support for dynamic LPA modules.
 o  Add new fields to the SSI display to indicate dynamic subsystem attributes.
 o  Cater for multi-volume datasets in the EXCP count for the DDNS command.
 o  Cater for DASD volumes whose serial number is less than 6 characters.
 o  Removed the NET command.

2.2a
 o  Added an internal security table to control authorized commands.
 o  Added the JOB() and ASID() keywords to the CDE command to
    get JPAQ and TCB loaded modules of other address spaces
 o  Added the JOB() and ASID() keywords to the TCB command to
    get the TCB structure of other address spaces
 o  Added the CHP command to list channel path information.
 o  Added the MAKE command to change address space swapability.
 o  Added the / command to issue operator commands.
 o  Added the ONLY(JPAQ) keyword to the CDE command.
 o  The TYPE=DASD and TYPE=TASK exception rules now support the use of
    pattern masks for volsers and jobnames.
 o  The PRT command will use USERID if the TSO prefix is null.
 o  Added the OMVS and RTLS statements to the PARM command.
 o  Fixed the TAPE command storage creep problem.
 o  Fixed the SGRP command storage problem.


2.1e
 o  Added the AGRP command to display SMS aggregate groups.
 o  Added the UCB command to show the actual UCB addresses of all
    devices.
 o  Added the CDE command to show the JPAQ and TCB loaded modules.
 o  Added the ONLY() and NOT() keywords to the DASD command.
 o  Added subsystem version information (via SSI-54) to the SSI command.
 o  Added support for JES3.
 o  Added the UCB MAP to the MEM command.
 o  Changed the SGRP command to show all volumes defined to the SMS
    storage group when the more detailed display is shown.
 o  Changed the TAPE command to accept unit address masking.
 o  Changed the SVC command to accept masking.
 o  Removed the authorized version of the CAT command.
 o  The command parsing routines have been changed so that all commands
    that accept keywords do NOT have to have the positional mask
    specified.
 o  Added SMS Status to the DASD display for a single volume.
 o  Improved authority checking when running under ISPF or REXX.


2.1d
 o  Added the SORTXA and SORTXD commands to sort hex values
 o  Added the JOB() and ASID() keywords to the DDNS command to
    get allocated datasets for other address spaces
 o  Added the TCB command
 o  Added the USP command
 o  Renamed the SMF command to SMFD
 o  Added new SMF command
 o  Added the A=asid form of the DA command
 o  Added the MAP command
 o  The SRCH command now presents a summary of matched
    member(s) instead of each member
 o  The EDT command can now cope with more than 8000 devices
    per unit name
 o  Show allocated jobnames and device types on the EDT command
 o  Toggle ISPF 'tab to point and shoot' setting
 o  Re-worked the help dialog
 o  MXIREXX now defaults to inlude screen headings (titles)
 o  Added the 'notitles' special parm to MXIREXX
 o  MXIREXX now correctly sets return codes
 o  Cater for null commands in MXIREXX (was giving 0c4 abends)
 o  Fixed 0C6 abends when invalid input given to the SVC or
    MEM comamnds


2.1c
 o  Added the EXC command
 o  Added CPU% and SIO on the DA display
 o  ENQC command now displays both enqueue conflicts and
    reserves at the same time
 o  MPF command now recognises SUP(ALL) entries
 o  Allow SRCH command to be issued on the PARM display
 o  Adjust alignment in the CVT mapping for MEM  CVT MAP(CVT)
 o  Allow normal attribute to be assigned to point-and-shoot
    fields
 o  Place 'Row n of n' message on all scrollable panels
 o  Assign a console key of MXI to E-MCS consoles and ensure
    migid is released
 o  Disallow lpar info collection under VM
 o  Enhance RMF Diag204 validation
 o  Add support for 62-line screens


2.1b
 o  Added the DA command
 o  Added the RS command
 o  Added the UIC command
 o  Added the SGRP() keyword to the DASD command
 o  Added EXCP counts to the DDNS command
 o  Enhancements to the DASD command displays
 o  Enhancements to the TAPE comamnd displays
 o  Show Parmlib dsnames/vols/status with the PARM command
 o  MXI now remembers current line in scrollable list when
    screen refreshed
 o  MXI now keeps the sort order when screen refreshed


2.1a
 o  Added the LLSU command
 o  Added the LLS command
 o  Added the CS command
 o  Added the CSR command
 o  Added the DCLS command
 o  Added the CA1 command
 o  Added the CAX keyword to the CAT command
 o  Added the LLS keyword to the LINK command
 o  Added APF fields for LINK and LPA command output
 o  Volser now displayed for LINK and LPA when DSCB is OFF
 o  Added support for parm to be passed via ISPF SELECT PGM(MXI)
 o  Added the MXICMDS ISPF table to ensure passthru for MXI
    commands

Known Limitations
=================

(1) MXI is written and assembled on OS/390 2.8. it should work on all
    releases of MVS from 5.2 upwards. However, I do not have access to
    every single release of MVS so I cannot guarantee that all commands
    will function on your system.
(2) The MEM command does not scroll backwards from the initial
    passed address (i.e. giving a negative offset).
(3) The control block mapping on the MEM command is generated from
    an OS/390 2.8 system.
(4) The DA command does not (and will never) get information from
    the JES2 Spool. It is too much of a headache to implement this
    code with the 'moveable' control block structure of JES2.

Additional Thanks
=================

Many thanks to the following :

        Dave Alcock
        Paul Beesley
        Jorg Berning
        Ken Brick
        Sam Golob
        John Kalinich
        Sam Knutson
        Martin Leist
        Ganesh Rao
        Brian Pierce
        Roland Schiradin
        Michael Theys
        Mark Zelden


Rob Scott
Scott Enterprise Consultancy ltd

Website : www.rocketsoftware.com
Email   : rob mximvs.com

