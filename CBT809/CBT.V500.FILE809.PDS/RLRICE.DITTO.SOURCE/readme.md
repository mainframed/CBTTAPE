
## $$$DOC2.txt
```
                       Installing DITTO

1)  Allocate a SOURCE, MACLIB, ISPPLIB or ISPPENU, and if you want
    to keep DITTO in its own loadlib a LOADLIB that must be APF
    authorized.

    Space estimates:
                         3380 tracks   Directory blocks      DCB
         SOURCE              30               10          FB, 80, 3120
         MACLIB               5                5          FB, 80, 3120
         ISPPLIB or ISPPENU   2                2          FB, 80, 3120
         LOADLIB              1                1          U, 6144

   ** You do need separate SOURCE and MACLIBs.


2)  DITTO bypasses opens so it must run APF authorized.  In the TSO
    environment DITTO will dynamically authorize and de-authorize itself
    if you have an SVC for this purpose.  Add the code necessary to
    invoke your SVC in source member DITTAUTH.

3)  Edit the ASMJCL member of the SOURCE library:

         a)  Change the JOBCARD to your site's requirements
         b)  Change the MACLIB references to the name you gave to the
             DITTO maclib.
         c)  Change the SOURCE library references to the name you gave
             the DITTO source lib.
         d)  Change the LOADLIB references to the name you gave the
             DITTO loadlib or the name of an existing APF authorized
             library.

4)  Run the ASMJCL member to assemble and link DITTO (should produce
    about 75,000 lines of print).

5)  If you want to run DITTO as a started task, add a PROC to one of
    your JES proclibs (member "PROC" in the SOURCE library may be used
    as a sample).

6)  If you want to use DITTO from a TSO session:
       a) the panels must be available so either add the ISPPLIB or
          ISPPENU library to your logon proc or allocate it in a CLIST
          or REXX exec.
       b) The LOADLIB must be available so add it to your LINKLST or
          your logon proc or allocate it in a CLIST or REXX exec.
       c) If you want to do tape functions, the user must have MOUNT
          authority.




                        Using DITTO

BATCH job
When running as a batch job, DITTO reads its control statements from
SYSIN.  Control statements must contain the string '$$DITTO ' in columns
1 to 8.  Parameters are specified by keywords.  Control statements may
span more than one control statement (that is "continued").  To indicate
that a statement is continued, code a comma and a blank after the last
keyword/value on the current statement, for example:

     $$DITTO TT,IN=xxx,
     $$DITTO    OUT=yyy,
     $$DITTO    FILES=3

  in this example the command is a tape-to-tape copy, input device is
  unit 'xxx', the output device is unit 'yyy', and 3 files would be
  copied.

Keywords may be specified in any order and must be delimited from the
value by an equal (=) sign.  Keyword/values must be separated from
each other by commas.  A blank indicates end-of-statement.  Comments
may be coded on control statements after the first blank.

For a list of the commands available, execute DITTO and specifiy command
'XXX' ($$DITTO XXX).



STARTED TASK
When running as a started task DITTO will prompt the operator for
commands.  Parameters are positional.  If the operator omits a parameter
or the value specified is invalid, DITTO will prompt the operator with a
message explaining that a parameter was omitted or was invalid and will
allow the parameter to be entered without having to re-key the entire
command.  If you did omit a parameter or one was invalid and you would
rather abort the command, you may enter 'CANCEL' to the prompt for the
missing or invalid parameter and DITTO will prompt for a new command.
If you know the command you want to use, but you can't remember all of
the parameters or you can't remember their order, enter the command
with a question mark (?) and DITTO will respond with a sample of the
command.  For example if you want to do a tape-to-tape copy, the command
is 'TT'.  If you enter 'TT,?' to the command prompt, DITTO will respond
with 'TT,INCUU,OUTCUU,# OF FILES', and will prompt for a command again.
You could have just entered 'TT' and DITTO would have prompted for the
input device, then the output device, and then the number of files one
parameter at a time (since this is more time consuming, you may want to
use the question mark method).  Some parameters are optional, like the
number of records on the TP command.  If you omit the number of records,
DITTO assumes you want the entire file printed, it will not prompt for
omitted optional parameters... you may print a lot more than you had in
mind.  If you omit a required parameter and optional parameters, DITTO
will prompt for the missing required ones, not the optional ones.  If
you want to enter the optional parameter (to limit the number of records
for example), you may want to enter 'CANCEL' to the prompt for the
missing required parameter and re-enter the entire command with the
optional value specified.  If you enter an optional parameter with an
invalid value (like alpha characters in RECORDS), DITTO will prompt to
to allow a valid value to be entered.


TSO
In TSO mode DITTO prompts for commands and parameters with ISPF panels.
Parameters are positional, just like in started task mode.  Rather than
prompting for missing and invalid parameters, DITTO resends the menu
screen with error messages explaining the problem.  Tape and disk reads
always read one physical block at a time.  If you asked for de-blocking,
the logical records in the block will be separated.  Data is displayed
in ISPF tables.  The data may be browsed forward and backward one
physical block at a time.  To use tape commands, the user must have
MOUNT authority.  DITTO issues WAITs that may cause your TSO session
to 'hang' waiting I/O, especially tape... I would not use DITTO from
my TSO session without being physically close the to tape drive.



GENERAL
The commands and print are as similar to IBM's DOS/DITTO as I could make
them.  One significant difference is the 'ACQ' command.  The 'ACQ'
command allocates devices to DITTO.  This prevents MVS from allocating
the device to another user between commands (you wouldn't want to get
the tape positioned where you want it only to have another job cause
it to be re-wound).  Also MVS has a nasty habit of rewinding and
unloading tapes when they are allocated, if you allocated tapes for each
command, MVS would rewind and unload it each time.  The 'REL' command
is the complement command to 'ACQ' and releases devices (of course all
devices are released when DITTO terminates).

DITTO bypasses MVS open.  This means you can read data whether you should
be authorized or not.  It also means anyone else who has access to DITTO
can do the same.  There are no SMF records generated either, so not
only are security measures bypassed, there is no trace of the access
at all.  If you use DITTO to write on a tape, tape management systems
like TMS are not aware of the update either.
```

## $$$DOC3.txt
```

I added this member for those types who would like to understand the
"nuts and bolts" of how DITTO is designed.



DITTO was written as a learning exercise.  I "cut my teeth" on DOS and
when I began working with MVS, I wanted to learn how things like
handling abends, communicating with the operator, etc worked under MVS.
One of the first utilities that I learned to use on DOS was DITTO.  I
don't know how anyone gets by without DITTO (I never found a bug in
DITTO either).  I found that MVS has many good utilities, but nothing
quite like DITTO.

DITTO
    1) determines its environment (batch, STC, TSO)
    2) intercepts abends (ESTAE)
    3) dynamically allocates/frees devices
    4) performs EXCP I/O to tape and dasd
    5) communicates with the operator (in STC mode)
    6) uses SPF panels
    7) I found out that not all MVS's are created equal... some use JES2
       and others use JES3.  If you use JES3, and you don't allow BLP
       processing, and the tape is standard labelled, you must know the
       volser before you use the tape (even if you are only going to
       read it).  One of the main uses of DITTO is to find out what is
       on a tape by "breaking the rules", like not having to know
       volsers or data set names.  At times you may have a tape with
       "botched" labels or some other non-standard situation.  DITTO
       can allow you to position the tape where you want it, copy
       portions, back space, forward space, write tape marks anywhere...
       To get around JES, tape management systems, RACF, etc DITTO
       bypasses OPEN and "opens" the data sets itself.  So DITTO uses
       some APF required services and builds its own DEB (another
       learning experience).


At the high level the flow of DITTO is:

   1) DITTINIT determines the environment (batch, STC, or TSO)
   2) if the environment is batch or STC
         a) call the batch/STC mainline DITTMAIN
         b) if batch, DITTMAIN will call DITTCARD to obtain a command
             . DITTCARD will call DITTCDI1 to read the control records
             . DITTCARD will call DITTPARM to convert the parameters
                  one at a time into internal format.
             . DITTCARD will determine if the command was valid and
                  if all required parameters were present.
             . If the command was not valid an error message will be
                  printed and DITTCARD will look for the next command.
             . If some required parameter was invalid or missing, a
                  message will be printed for each and DITTCARD will
                  look for the next valid command.
             . If the command and all parameters were valid and present,
                  the input module address, output module address,
                  input module processing options byte, output module
                  processing options byte will be set then DITTCARD will
                  return to DITTMAIN.
         c) if STC, DITTMAIN will call DITTCONS to obtain a command.
             . DITTCONS issues a WTOR asking for a command
             . DITTCONS will verify the command and call DITTPARM to
                  convert the parameters one at a time into internal
                  format.
             . if the command was not valid, DITTCONS will issue a
                  WTO explaining the command was not valid and issue
                  another WTOR for asking for a valid command.
             . if a required parameter is missing or invalid, DITTCONS
                  will issue a WTO explaining which parameter is
                  missing or invalid and a WTOR asking for the parameter.
             . if the command is valid and all required parameters are
                  entered the input module address, output module
                  address, input module processing options byte, output
                  module processing options byte will be set then
                  DITTCONS will return to DITTMAIN.
         d) After DITTCARD or DITTCONS returns with a valid command,
            DITTMAIN calls DITTDAIR to locate the "DYNBLOK" for the
            input and output devices (except for card, punch, or print).
            The exception to this is command "ACQ" which allocates the
            devices and builds the "DYNBLOK"s.  The DYNBLOK address for
            the input device and output device are in the common area.
         e) After the input and output device are located, DITTMAIN
            enters an input-output loop.  Some commands do not have
            both an input and output module, if the command is input-
            only, the output module address will be zero.  Likewise if
            the command is output-only, the input module address will
            be zero.  The loop continues until either the input or
            output module signals "end-of-file".  Note that "end-of-file"
            can be set by output modules... for example the WTM command
            is output only, so the output module signals eof when it has
            written the requested number of tape marks.
         f) When eof is signalled, DITTMAIN performs "reset"... the
            input module address and processing options are cleared,
            output module address and processing options are cleard,
            input and output DYNBLOK addresses are cleared, DITTPARM
            is called to reset all parameters from the previous command.
         g) go back to step "b"

      if the environment is TSO, call the TSO mainline DITTTSOM.
         a) DITTTSOM defines the SPF variables.
         b) DITTTSOM builds the menu data and displays the menu panel.
         c) DITTTSOM verifies the command is valid and calls DITTPARM
               to convert the parameters to internal format.
         d) if the command is not valid, a message is added to the menu
               panel and the menu is displayed again.
         e) if a parameter is invalid or a required parameter is missing,
               a message is added to the menu explaining the problem and
               the menu is displayed again.
         f, g, h would be the same as steps d, e, and f for batch and STC modes.
         i) go to step b.

   3) The batch/STC or TSO mainlines return control to DITTINIT.
      DITTINIT frees the trace table and work areas and terminates.




All parameter conversion is performed by DITTPARM whether in batch, STC,
or TSO environment.  This reduced the amount of code over-all, and if
any special conversion technique was needed for a parameter, the same
code could be used for any other parameter with the same internal format.
The resultant value for all parameters is a field in DITTCOMM.  The
parameter definition table specifies the internal field name, internal
field id, format, displacement of the field into DITTCOMM, length of
the field in DITTCOMM, and messages to issue if the parameter is missing
or invalid.  Each parameter causes an entry to be added to an assembler
GLOBAL variable.  On commands the required and optional parameters
on the DITTFUNC macro reference the field names in this GLOBAL variable.
Part of the output of the DITTFUNC macro is two tables that contain up
10 parameter id fields.  This is how DITTO knows which fields are valid,
and required or optional for each command.  For STC and TSO modes the
order of the field names in the REQPARM parameter defines the order the
command parameters must be entered.  For batch mode, DITTCARD keeps a
table of the parameters entered on the command, then makes sure all the
parameters in the REQPARM list are in the table.
```

## $$$DOC4.txt
```
Ditto as developed (mostly) around 1984-1985 or so.  Before MVS/XA,
MVS/ESA, OS/390, z/OS, 31-bit mode...

DITTO was written when most tapes were still the 3420 "round reels".
Anyone who was around then knows that there was no end to the way
a round-reel tape could be botched.  Every now and then you needed
to get the normal access methods and system out of the way so you
could 'see' what was on a tape or try to salvage data.  DITTO allowed
you to position the tape with no regard for tape labels (sometimes
they were what was botched), tape marks, whatever.  You can print,
copy the tape, write tape marks, forward space, back space, skip
tape marks, whatever at any time.

To do its job, DITTO 'bends' some rules.  For one it builds its
own DEB.  It would then issue a DEBCHK to add the DEB to the
DEB chain.  Somewhere around MVS/ESA this started causing the
entire system to crash.  I have learned that if you issue an EXCP
while in key 0, the system allows you to provide a DEB that is
not on the DEB chain.  I have removed the code that does the DEBCHK
and switch to key 0 immediately before issuing EXCPs.  Both DEBCHK
and switching to key 0 require APF authorization.

```

## $$$DOC.txt
```
  MEMBER    DESCRIPTION
  $$$DOC    THIS MEMBER
  ASMJCL    SAMPLE JCL TO ASSEMBLE AND LINKEDIT DITTO
  DITTAUTH  DYNAMIC AUTH/DE-AUTH (TSO ENVIROMENT)
  DITTALOC  ACQ/REL COMMANDS
  DITTATTN  TSO ATTENTION EXIT
  DITTCARD  BATCH ENVIRONMENT COMMAND READER
  DITTCDI1  CARD READER
  DITTCDO1  CARD PUNCH
  DITTCMD   COMMANDS TABLE
  DITTCOMM  COMMON DATA MODULE
  DITTCONS  STC ENVIRONMENT COMMAND READER
  DITTDAIR  SYSTEM DAIR INTERFACE
  DITTDAI1  DASD READER
  DITTEXCP  EXCP I/O MODULE
  DITTINIT  INITIALIZATION/TERMINATION MODULE
  DITTINQ   BATCH/STC INQ FUNCTION
  DITTMAIN  BATCH/STC MAINLINE
  DITTPARM  PARAMETER CONVERTER
  DITTPRMD  DENSITY PARAMETER EDIT CHECKER
  DITTPRMO  'OPTION' PARAMETER EDIT CHECKER
  DITTPRMV  VOLSER PARAMETER EDIT CHECKER
  DITTPRO1  'PRINT' OUTPUT
  DITTPRT   PRINTER
  DITTSTAE  STAE EXIT
  DITTTINT  TAPE INITIALIZATION COMMAND
  DITTTMAP  TAPE MAP COMMAND
  DITTTPI1  TAPE READER
  DITTTPI2  FORWARD SPACE FILE COMMAND
  DITTTPI3  BACK-SPACE RECORDS COMMAND
  DITTTPI4  BACK-SPACE FILE COMMAND
  DITTTPO1  TAPE OUTPUT
  DITTTPO2  TAPE REWIND COMMAND
  DITTTPO3  TAPE REWIND-UNLOAD COMMAND
  DITTTPO4  WRITE TAPE MARK COMMAND
  DITTTSOM  TSO ENVIRONMENT MAINLINE
  DITTTSO1  TSO ENVIRONMENT DATA DISPLAY
  DITTTSO2  TSO ENVIRONMENT TAPE MAP
  DITTTSO3  TSO ENVIRONMENT INQ FUNCTION
  DITTXXXX  DUMMY END OF LOAD MODULE
  JCL       SAMPLE JCL TO EXECUTE DITTO IN BATCH
  PROC      SAMPLE JCL TO EXECUTE DITTO AS A STARTED TASK
  TSODITTO  SAMPLE CLIST TO EXECUTE DITTO FROM TSO
```

