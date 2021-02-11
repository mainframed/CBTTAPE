
## $DOC.txt
```
RUNC is an ISPF Edit macro that will invoke TSO, ISPF, (E)JES, SDSF, and
TSO Console commands that are imbedded within the active EDIT or View
data.

ERC is provided as a sample command that can be implemented in the site ISPF
command table. ERC will prompt the first time used for the dataset name of the
commands dataset and then open that dataset. This is a fast path to the
commands.

   Members:

      $DOC     - this member
      $ERCDOC  - doc on how to use the ERC command
      $RUNCLOG - How to use the %RUNCLOG command
      $USERDOC - doc to help the end user
      JUST$FUN - short article about RUNC
      EKKO     - Assembler source for EKKO
      EKKO$    - JCL to assemble and link EKKO
      EKKOH    - TSO Help member for EKKO
      LICENSE  - GPL License
      SUPPORT  - Statement of Support
      TESTRUNC - Sample exec to test RUNC

Installation:

Implementation:
   1. Copy the  EXEC members into your SYSEXEC (or SYSPROC) library
   2. Copy the  PANELS members into your ISPPLIB library
   3. Receive the LOAD.XMIT dataset to create a LOAD library
   4. Optional: Copy the LOAD member EKKO into your ISPLLIB, STEPLIB, or
      Linklist library (see info on EKKO below)
      - *IF* using EKKO then edit the RUNC exec to change the rputl
        variable as documented in the code to use EKKO instead of the
        %RUNCPUTL exec
   5. Optional: If using EKKO then copy EKKOH into your SYSHELP
      dataset as EKKO. This is the TSO Help member.
   6. Test with the TESTRUNC exec
      Does altlib/libdef and invokes ISPF edit on a dataset to
      allow testing/validation of RUNC.

Dependencies:
   1. STEMEDIT from CBTTape.org File 183 is required for RUNC to be used.
      Download and install.
      *or*
      Use the version of the STEMEDIT load module included in the
      Load library distributed with this package.

RUNCPUTL not required if the EKKO command is used.

If using the EKKO command:
 - copy the EKKOH member into your installation local HELP PDS as EKKO.
 - Use member EKKO$ JCL to assemble and linkedit the EKKO command into
   a load library. The library can be in either Linklist, a Steplib, or
   an ISPLLIB library.

Copy the SAMPLES members into a new PDS that will be the location for
your sample command members that you can share with your users. The PDS
can be RECFM=FB LRECL=80 or RECFM=VB LRECL=255 - your choice.  Using ERC
for the shared command PDS is acceptable and will, by default, open the
command PDS, or member, using ISPF View. This allows multiple users of
the same data without enabling Edit capabilities.

NOTE: the RUNCPUTL works but is not as efficient as a real TSO command.
      Thus RUNC allows the installation to change the customization
      variable RPUTL from %runcputl to ekko.  EKKO is a TSO command
      included in this package (thanks to Sam Golob for pointing me to
      it).  EKKO does the same thing as RUNCPUTL but using assembler
      code so it is more efficient. This will be obvious if large
      amounts of data are captured during the command execution.

      The Log dataset type is also a customization value in the RUNC
      exec.  Find *custom* and change the logtype as documented in the
      code.

Update your ISPCMDS ISPF Command Table to add ERC:

     Verb:    ERC
     Trunc:   0
     Action:  SELECT CMD(%ERC &ZPARM) NEWAPPL(ISR)
     Desc:    Edit RUNC Command Dataset

Usage:  See $USERDOC
```

## $ERCDOC.txt
```
The ERC command is an optional command that will open a dataset that is
defined with members containing commands in ISPF View (or Edit)

ERC must have been installed and be defined in the ISPF command table so
that it can be entered on any ISPF command line.

The first time the ERC command is used the user will be presented with
an ISPF panel to enter the dataset name where the user has members with
commands.

Syntax is:   ERC
             ERC member-name          (e.g. ABC)
             ERC member-name-mask     (e.g. AB*, %BC, A%C)
             ERC /SET
             ERC -E member-name       (e.g. ABC)
             ERC ?

When entered with a ? then a short ISPF tutorial will be presented.

When entered without a member-name then the command dataset will be
opened in ISPF Edit or View.

When a member-name is specified then that member is opened in ISPF Edit
or View.

When a member-name-mask is used then only those members that match the
mask will be presented in the member list of ISPF Edit. The mask must
conform to the ISPF Edit mask ( % and * )

When the /SET is specified the user will be presented with a ISPF Panel
to change or define the command dataset.

When the -E option is used then the command dataset is opened in ISPF Edit.

The reason for using View as the default is to allow a shared command dataset.

If the command dataset is prefixed with the active users userid then the
default action will be Edit instead of View.
```

## $USERDOC.txt
```
The RUNC ISPF Edit Command is only used within ISPF Edit, or View, and
will execute any ISPF Edit, OMVS, TSO, (E)JES, SDSF, or ISPF command
found on the selected records within the active ISPF Edit data.

Syntax:  RUNC options member

options may be:

           blank (default)
           ? or HELP to display ISPF tutorial
           n - must be the first option and will skip
               the first n characters to find the command
          -A or -ALL enables all records to be considered for commands
          -B to browse the results using STEMEDIT
          -BS to toggle the prompt for the RUNC supported symbolics
          -C to display all log datasets (ISPF 3.4 list)
          -D to insert the message as Data
       or -D(prefix) where prefix is added to the beginning of the data
             followed by a space
          -I to display the messages after each individual command
          -L to log all messages to a log dataset (type based on install default
          -LD to log all messages to a sequential log dataset
          -LP to log all messages to a partitioned dataset member
          -LX to disable logging if logging was enabled via -O user defaults
          -N to insert the message as NOTELINEs
          -O to display the user default options panel
          -R to change the default Report from the site default
             of either Always generate a report regardless if the
             command generates a message or not or Only report if
             messages were generated.
          -S nnn to stop multiple command execution if the return code
             is greater than nnn
          -T to not trap and let the results go to screen
          -V to view the results using STEMEDIT
              default is to View
          -W nnn to wrap the inserted text (for -D and -N) and the
             when the command response is inserted. If nnn is W then
             the wrap value will be set to the current Edit data width.
             The wrap will occur at the closest blank or exact character
             location depending on the data.

          ONLY(string) will search for the string (e.g. xyz) in
             the command string and if not found will ignore that
             command.
          PREFIX(string) will append the string to the front of
             each command.
          SUFFIX(string) will append the string to the end of
             each command.

          ** PREFIX and SUFFIX apply only to TSO commands

member, if provided, is a member name or member mask. If a member name
then that member is opened in Edit, or View. If a member mask then the
member list will be displayed using that mask.

Both options and member are optional

Data Syntax:

   BROWSE command:  BROWSE Dataset(data-set-name)
                 or BROWSE Dataset(data-set-name) Volume(volser)
                 or BROWSE Member(member-name)
   EDIT command:    EDIT ispf-edit-command
                 or EDIT Dataset(data-set-name)
                 or EDIT Dataset(data-set-name) Macro(macro)
                 or EDIT Dataset(data-set-name) Macro(macro) Parm(parm)
                 or EDIT Dataset(data-set-name) Volume(volser)
                 or EDIT Dataset(data-set-name) Volume(volser) Macro(macro)
                 or EDIT Dataset(data-set-name) Volume(volser) Macro(macro) +
                         Parm(parm)
                 or EDIT Member(member-name)
                 or EDIT Member(member-name) Macro(macro) Parm(parm)
   (E)JES Command:  EJES ejes-command
   ISPF Command:    SELECT ispf-select-paramters
   OMVS Command:    OMVS omvs-command
                    multiple commands separated by a ;
   Rename Command:  Rename data-set volser from-member-name to-member-name
   SDSF Command:    SDSF sdsf-command
   SET Command:     SET symbolic = value
                    SET PROMPT or NOPROMPT (affects RUNC defined symbolics)
   Sleep Command:   SLEEP seconds   (default 5 seconds)
   TSO Commands:    Any TSO command
   TSO Console:     CONS z/OS command
   VIEW command:    VIEW ispf-View-command
                 or VIEW Dataset(data-set-name)
                 or VIEW Dataset(data-set-name) Macro(macro)
                 or VIEW Dataset(data-set-name) Macro(macro) Parm(parm)
                 or VIEW Dataset(data-set-name) Volume(volser)
                 or VIEW Dataset(data-set-name) Volume(volser) Macro(macro)
                 or VIEW Dataset(data-set-name) Volume(volser) Macro(macro) +
                         Parm(parm)
                 or VIEW Member(member-name)
                 or VIEW Member(member-name) Macro(macro) Parm(parm)
   <DOC>:           Documentation Popup
                    <DOC> end with </DOC>
                    <TITLE>Title for Popup
   <EXIT rc>:       Test return code after previous command and if
                    equal or greater will cease RUNC processing.
   <START>:         Defines the start of a range within the data to
                    process. Ends with <END> statement. Both must
                    be on records by themselves.

   Documentation format
             1. <DOC> on a record by itself starts the doc section
             2. </DOC> on a record by itself ends the doc section
             3. <TITLE> followed by up to 32 characters on the same
                record and between <DOC> and </DOC> records will
                be used for the title of the documentation popup.
             4. PF3 will close the popup and continue with the next
                command(s)
             5. CANCEL on the command line will close the popup and
                terminate RUNC processing

Usage Notes: 1. Select records with TSO commands using line tags, C, C#,
                or CC and CC.
             2. Use the command option of -ALL, or -A,  to process all
                records for commands.
             3. Data lines starting with *, /*, //, or //* or all blank
                will be ignored
                - use n to skip over *, /* , //, or //*
                - EXCLUDED records will also be ignored
                  ** This applies as well if an EDIT X ALL happens :-)
             4. Commands may be continued on the next record by using a
                + at the end of the command for the record
             5. The data on the line will be executed using the Address
                TSO command as a TSO command, or ADDRESS ISPExec for
                ISPF commands. For omvs the command will be executed
                using bpxwunix. For SDSF and (E)JES the appropriate
                commands will be used.
             6. Commands can be in any record in the data.
             7. Symbolics are supported in the command using the syntax
                of &symbol. An ISPF panel will be generated to prompt
                for the symbolic values.
             8. Hint: Use a symbolic at the end to allow entry of
                additional command options
             9. Multiple symbolics may be used in the same command and
                may be delineated by '<>(),."; $#&Ý¨{}/\%-_
            10. If a symbolic ends with a . then the . will be removed
                and the symbolic value will be merged with the adjacent
                text.
            11. OMVS commands are any valid OMVS command. Multiple
                commands are separated by a ;. And if SuperUser
                is required us su.
            12. EDIT, EJES and SDSF will accept multiple commands that
                are separated by a ;.
            13. -W is used with -D and -N to wrap the text that is
                inserted into the command member or dataset. This is
                useful if the command results would be truncated when
                inserted.
            14. The command members may have ISPF Edit sequence numbers,
                or not, depending on the users preference. RUNC will
                ignore them providing they are valid Edit numbers.
            15. -N and -D override -B, -I, -T, and -V
            16. -B, -T, and -V over-ride -R
            17. Comments may be included on the same record as a command
                and must start after the command and begin with a /* and
                there is no need for a closing */.
            18. When Browse/Edit/View a Member the active dataset and
                volser is implied.
            19. The Rename command requires a volser. Use * to use the
                cataloged data set.

 Special symbolics supported:

  DATE     USA Date (mm/dd/yy)
  DD       2 digit Day of Month
  DOY      Day of year (e.g. 001)
  EDATE    European Date (dd/mm/yy)
  HHMM     Hours and Minutes (hhmm)
  JDATE    Julian Date (e.g. 16001)
  LPAR     Active LPAR Name
  MM       2 digit Month
  MONTH    Month (e.g. January)
  ODATE    Ordered Date (yy/mm/dd)
  PREFIX   Current TSO Prefix
  RDSN     Current RUNC dataset name
  RMBR     Current RUNC member name
  RMEM     Current RUNC member name
  SDATE    Standard Date (yyyymmdd)
  SMFID    Active SMFID for the LPAR
  SYSID    1 Character System ID
  SYSNAME  Active LPAR Name
  SYSPLEX  Active SYSPLEX Name
  SYSPREF  Current TSO Prefix
  SYSSMFID Active SMFID for the LPAR
  SYSUID   Current userid
  UDATE    USA Date (mm/dd/yy)
  USERID   Current userid
  USERIDL  Current userid lower case
  WEEKDAY  Day of Week (e.g. Monday)
  YY       2 digit Year
  YYYY     4 digit Year

 Sample Usage:

    Create a member in a dataset:

    LISTD &dsn
    LISTC ENT(&dsn) ALL
    PDS &dsn
    PDS MY.EXEC
    SELECT PANEL(&panel)
    SELECT PANEL(ISR@PRIM) +
           opt(&opt)
    EJES D A,ALL
    EJES ST jobname
    SDSF D A,ALL
    SDSF ST jobname
    OMVS cd /u;ls -la
    CONS d a,l
    EDIT c &from &to all
    EDIT only yyy
    EDIT Dataset(&dsname)
    EDIT Dataset(&dsname) Volume(&volser)
    BROWSE Dataset(&dsname)
    BROWSE Dataset(&dsname) Volume(&volser)
    VIEW Dataset(&dsname)
    VIEW Dataset(&dsname) Volume(&volser)

Then use the RUNC command on that dataset/member and use the row
selection commands to select the record(s) to process.

The symbolics in the sample commands will bring up an ISPF panel that
will prompt the user to enter a value for each symbolic in the order
that they are found within the command. If the user decided to not
execute the current command at this point they may do so by entering
CANCEL on the ISPF command line.
```

