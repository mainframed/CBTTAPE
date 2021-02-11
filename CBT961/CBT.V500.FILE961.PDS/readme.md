
## $$$DOC.txt
```
YCLMAC - A collection of user line commands for use in ISPF Edit and View
by YCOS Yves Colliard Software - www.ycos.de
and many others|

-------------------------------------------------------------------------

Installation:

   1. Copy YCLMACTB into ISPTLIB library (see $$$INST)
   2. Copy REXX others into SYSEXEC or SYSPROC library (see $$$INST)
   3. Update ISPF site customization table (ISPFC) (z/OS 2.2)
      GLOBAL_LINE_COMMAND_TABLE = YCLMACTB
   4. If using (E)JES instead of SDSF change the LMACJES2/3
      members from sdsf to ejes
   5. If you plan using the System Automation interface some
      more customization will be needed|
      If the name of the rexx of System Automation is not:
        SYS1.ING.SINGTREX
      then you have to create a rexx YCINGCUS in your SYSPROC/
      SYSEXEC concatenation with following content:
/* Rexx YCINGCUS */
/* User customized System Automation Call              */
/* Define the name of the dataset containing the Rexx: */
/*        AOFRYCMD                                     */
/* Default is: SYS1.ING.SINGTREX                       */
push "MY.DATA.SET"  <- replace with your name
exit 0

-------------------------------------------------------------------------

Members of this dataset:

   $$$DOC           This member that you are reading
   $$$HELP          A copy of the HELP information
   $$$HELPS         A short reference 'card' of commands
   $$$INST          some IEBCOPY to distribute members

Rexx to be added to SYSEXEC/SYSPROC
   YCLMACDS         REXX to extract DSN from records
   YCLMACHG         Summary of Changes
   YCLMACLM         REXX to get messages
   YCLMACNS         REXX to support split screen functions
   YCLMACRX         REXX to process new line commands
   YCLMAHLP         REXX to display help information
   YCLMAHLU         REXX to display user extensions help information
   Y$CL             REXX to compare members
   Y$HC             REXX short help
   Y$RU             REXX support of RU - Ruler line command

ISPF Table - must be copied to ISPTLIB
   YCLMACTB         ISPF Table of Line Commands

Rexx Additional commands - extra installation needed
Rexx to be added to SYSEXEC/SYSPROC if needed
   Y$REV            REXX to interface to Greg Price's REVIEW command
   Y$PDS            REXX to interface to Lionel Dyck's PDS
   Y$PG             REXX to interface to Lionel Dyck's PDSEGEN
   YCLMACT          REXX to support user line command table extensions

Samples to run EX command
   LMACJES2         Sample JES2 commands for use with EX
   LMACJES3         Sample JES3 commands for use with EX
   LMACMVS          Sample MVS (SDSF/EJES) commands for use with EX
   LMACTSO          Sample TSO commands for use with EX
   LMACUSS          Sample OMVS commands for use with EX
   LMACING          Sample System Automation cmds use with EX
   LMACISPF         Sample ISPF commands use with EX

Sample coding for own application
   YLM01            Sample application using own line commands
   YLM02            Sample application using own line commands

-------------------------------------------------------------------------

Addition of user/local commands:

   1. Update YCLMACT with the name of the new command
      - Update at the bottom in the User Command section
      - Follow the coding examples in YCLMACT
   2. Run the REXX YCLMACT to replace the line command table YCLMACTB
   3. Copy YCLMACTB into the ISPTLIB library
   4. Create a REXX Exec Y$xxx
      - where xxx is the 1-6 character name of the new command
   5. Update YCLMAHLU to document the new command

```

