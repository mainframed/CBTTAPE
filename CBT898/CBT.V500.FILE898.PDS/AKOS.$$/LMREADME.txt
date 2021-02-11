 LINEMAC/LMEXIT/LMAC.
 ~~~~~~~~~~~~~~~~~~~~
 LMAC is an "IBM" supplied line command processor. It intercepts line
 commands and if it is not a recognised ISPF edit command passes them to
 a user written "exit" for processing.

 "LINEMAC" is the name of the exit used.  (You may create and call an
 exit whatever you like if you are adventurous.)

 LINEMAC is a set of predefined line commands and LMEXIT is an 'exit'
 called by LINEMAC to execute user defined line commands.

 While LINEMAC can readily be user customise, any modifications will not
 be supported, however, limited support (advice) will be provided for
 user modified LMEXIT.

 LMAC permits user customised line commands and can be called whatever
 you like. However, LINEMAC and LMEXIT are site customised and standards
 and are the only supported interface with LMAC.

 The following documentation is designed for a new implementation and
 many requirements would not be necessary if you are a new user to the
 facility already installed at the site.

 To enable customised line command facility.
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 If the LINEMAC package is already available on the system GoTo
   STEP2 - If the datasets are not prealloacted during logon.
   STEP3 - If already prealocated and you have not "Auto enabled" it in
           a previous session.

 STEP1:
 ------
 Under ISPF 3.4 issue command "RECEIVE INDA(/)" against your uploaded
 dataset. Suggest you receive it into the default dataset.

 Load module LMAC has been XMITed into member LMACLMOD of distribution
 dataset. To create the required load library with member LMAC, issue
 command "RECEIVE INDA(/(LMACLMOD))" against the above "received into"
 dataset (after entering REFRESH on the ISPF 3.4 command line).

 If you used the default for both receives, no further action is
 required.

 (If the uploaded dataset is TERSED use RECFM=FB,LRECL=1024. You will
 need to unTERSE it before RECEIVing it or use the RECV command, if
 available, to do both.)

 STEP2:
 ------
 Exit ISPF into native TSO (READY prompt) and enter:

     EX 'userid.LINEMAC.REXX(LMALLOC)'

 to allocate the libraries to the appropriate ISPF concatenations and
 bring up the "$$README" member under a browse session.

 STEP3:
 ------
 Now let's activate the line command facility and put it to use. To
 prevent this browse session being executed take note and do the
 following:

   1. Enter "TSO LMAC" on the command line.

   2. In the popup display, enter the following:

         Edit macro name . . . LINEMAC                <- "LINEMAC"
         / Automatically enable line macros           <- "/" to activate

   3. Use END PF key to exit.

   4. You will be presented with the dataset allocation member
         'userid.LINEMAC.REXX(LMALLOC)'
      and issue line command "CL" on line 40. This should place comment
      lines "/*      */" around the line preventing subsequent $$README
      presentation. Congratulations, you have issued your first of many
      line commands.

   5. Use END PF key to return back to ISPF.

   6. Issue TSO LMAC in all applids you want it active in. Alternatively
      you can issue command "!LMAC" in any edit session LINEMAC is not
      active in. (You may need to enter "!LMAC ?" at your site to make
      it permanent.)

 Notes (activation):
 ~~~~~~~~~~~~~~~~~~~
 1. LMAC has to be activated in each applid that you would execute line
    commands in. The two that come to mind immeditely are ISR (normal
    PDF etiting outside an application dialog) and SDSF.  If there are
    applications and 3rd. party products that use the editor under their
    own applid, LMAC will need to be activated seperately (and removed
    if no longer required).

 2. Datasets can be deallocated by issuing the following command under
    native TSO (READY prompt):

     EX 'userid.LINEMAC.REXX(LMALLOC)' 'MINUS'

    instead of logging off and back on.

 3. The LMAC command gets it's hooks into your application profiles.
    Deallocating (or not allocating) the LINEMAC datasets will still
    generate error "COMMAND LINEMAC NOT FOUND" error as well as the
    appropriate "Invalid command" ISPF messages.
    To totally remove LINEMAC either have the original (demo) install
    dataset allocated or make available in a SYSPROC/SYSEXEC dataset to
    issue command "LMACR" in all applid's it was activated in. After
    that you can safely delete the demo dataset.

 4. Enter "HELP" on any line to get a listing of all the available line
    commands. Commands may indicate any extra routines required.
    Note, commands will be sorted for display purposes within each exit.
    Duplicated commands will be executed in first hit sequence per exit
    and then exit sequence.  So if you are not getting the desired
    results, check for duplicates.  (Easier done by converting notelines
    to data, exclude all and look for your desired command.)

    Enter "HELPX" on any line to get a listing of the more complex
    commands that cannot be described on the single "HELP" line.
    Note, that these outputs are a subset expansion of all commands and
    are made available sololy at the discretion of the individual exit's
    author.  The

    Line command "HELP+" will give details in designing your own line
    commands. (Remember, it gets only as complex as you want it to be.)

 5. If in doubt for a great command, seek support.

 6. This packaging contains a lot of extra members to supplement all the
    command available. The following is an essential list.
      LINEMAC  - Main driver.
      LMACR    - Remove LINEMAC from an applid. This is required if
                 command LMAC is not available and you don't want those
                 "not available" messages complicating your life.
      LMEXIT   - Only required if you want to create your own commands
                 and don't want to change LINEMAC.
      LMP      - Macro to permit passing parameters to LINEMAC or exits.
      LMPRMEMB - To be able to browse, view or edit members from indexes
      XB and   - To be able to browse, view or edit a dataset extracted
      CSREENC    from a line. Although designed for JCL, will try to
                 extract dataset name. Can be influenced by cursor
                 placement.
                 Note, XB (with SCREENC available) can be used on any
                 screen, even a menu screen of browse session.
 7. Do not modify members LM1, LM2 or LM3.  They are infrastructure
    static code that execute your line commands.
    Only change LINEMAC or exits between the indicated spots.  If you
    cream the infrastructure, use "LMM" parameter "I" to update the
    infrastructure.

 8. Of the LMM options "E', "C" and "B" are virtually obsolete as the
    tendency is not to re-build exits but rather chain them.
    When building your commands use "LMM A" to analyse you creation.

 9. Following are displays of HELP, HELPX and HELP+ line commands
    made into data ("MD9999" line command).  This list is subject to the
    dynamics of LINEMAC and user exits and may differ from below
    depending on site (Alex, Nov 2007).

*----------------------------------------------------------------------*
*                                                                      *
* Line commands are brought to you with the compliments of Choon Lim,  *
* Doug Nadel and Alex Kara.  - 2003 -                                  *
*                                                                      *
*----------------------------------------------------------------------*

  The following line commands have been self extracted out of the
  LINEMAC macro. They are alphabetic sequenced for presentation purposes
  if the '$SORT' command is available. Nevertheless, they should be
  organised as the most used first.

  Cmd    Description
  ------ ---------------------------------------------------------------
  $S     Generate Parse SOURCE command
  /      Super Search launcher
  `      Repeat last LINEMAC command
  AL     All those alpha, national combinations you always wanted
  BD     Browse/View/Edit DSN from line using CMD(%XB)
  BER    Genarate NOTELINES for REXX Browse ERror
  BM     Browse/Edit/View memb from line using MAC(LMPRMEMB)
  BMC    Browse/Edit/View memb at cursor using MAC(LMPRMEMB)
  BOX    Create a 'BOX' block
  CE     Center line
  CL     Comment line with '/*...*/' cols 1&71 (toggle, shift NB)
  CLC    Comment line with '/*...*/,' cols 1&70 (toggle, shift NB)
  CLD    Comment line with doco in 45&71 and cursor placement (No tog
  CLN    As for "CL" but only non-excluded lines
  CLX    As for "CL" but only excluded lines
  CM     Copy member 'a' to 'b' using MAC(LMPRMEMB)
  CMU    Copy member 'a' to 'b' using MAC(LMPRMEMB) + Update
  CP     Copy member (1st. word) from same PDS after cursor (LMPRMEMB)
  CURSO  ISREDIT Get/Place Cursor position
  DATAN  Check if data is numeric using datatype builtin fn
  DATAW  Get maximum data width of screen being edited
  DL     DSLIST (ISPF opt 3.4 for dataset)
  DLAST  Delete last (ex. only, only Terry Pollard would want this
  DM     Delete memb from line using MAC(LMPRMEMB)
  DMU    Delete memb from line using MAC(LMPRMEMB) + Update
  DOL    Do Loop sample codes
  DT     Delete all from current line to the top line
  ED     Browse/View/Edit DSN from line using CMD(%XB)
  EIO    EXECIO Notelines (quick dirty)
  EIOL   EXECIO in loop Notelines using source skip-blocks (memb req
  EM     Browse/Edit/View memb from line using MAC(LMPRMEMB)
  EMC    Browse/Edit/View memb at cursor using MAC(LMPRMEMB)
  FT     Add File Tailoring dialog (sample, must be customised)
  GC     Create a 'General comment' block
  HELP+  Display HELP for building line commands.
  HELPX  HELP eXpanded. Help for line commands in greater detail
  ICL    Insert comment after last (example only 2 demo ")D" function
  IEBCO  Sample IEBCOPY JCL
  IF     Create an 'If,Else' block and a Noteline for the power hungry
  INSA   ISREDIT Insert a line in Edit session
  ITS    Convert a series of IFs to Select Block
  ITW    Convert an If to a When
  KM     SuperC memb from line using MAC(LMPRMEMB)
  LEF    Left Justify
  LEV    Generate macro Level checking code. Use in ")M" destined mac
  LMV    LINEMAC (infrastructure component) versions
  MK     Mark a block for instream NOTELINE Help processing
  MS     Stats memb from line using MAC(LMPRMEMB)
  NAT    Insert NATional characters as NOTELINES
  OT     Insert OutTrap block code - Requires member REXX($OUTT)
  PARSE  Parse - a collection of sample codes as NOTELINES
  POPMA  Popup window for messages
  POPMB  Popup window for messages with response
  QS     Quick search for dataset functions
  RIT    Right Justify
  RL     Reverse line
  RM     Rename memb from line using MAC(LMPRMEMB)
  RMU    Rename memb from line using MAC(LMPRMEMB) + Update
  SEL    Create a 'SELECT' block
  SELA   Select when sample codes
  SL     Seperator line before cursor  "/*------.....------*/"
  SLA    Seperator line After cursor  "/*------.....------*/"
  SM     Stats memb from "Index" line using MAC(LMPRMEMB)
  ST     Stats memb from "Index" line using MAC(LMPRMEMB)
  SU     Set (status)=USER_STATE before line
  SUB    Submit job
  SUBM   Submit member - Macro(LMPRMEMB)
  SYN    Genarate Syntax error processing code
  SYSDS  TSO Sysdsn to check existence od dataset
  TFX    Redirection to ISPF option 3.4
  TR     Turn TRace on, with complementary alternatine NOTE lines
  TRA    Trace ?R
  TRC    Copy a test for "Toggle TRACE" block after a screen display
  TRF    Find all the traces generated by TR, TRO and TRT line cmds
  TRI    Insert Trace ?I
  TRO    Turn Trace off and prepare for reactvation with comp NOTES
  TRT    Trace toggle code (Reactivate of "TRO"d) with comp NOTES
  US     Set USER_STATE=(ststus) aftr line
  VB     VSAM Browse - using CMD(%VB)
  VD     Browse/View/Edit DSN from line using CMD(%XB)
  VM     Browse/Edit/View memb from line using MAC(LMPRMEMB)
  VMC    Browse/Edit/View memb at cursor using MAC(LMPRMEMB)
  WA     Demonstrate the use of the 'WA' command
  XM     Execute memb from line using MAC(LMPRMEMB)
  ZEDSM  Pop ISPF message Zedsmsg/Zedlmsg Setmsg


  LMEXITAK line commands:
  -----------------------

  $D     Generate IDCAMS delete dataset statements
  AP     Add POP up window code - Member REXX($ADPOP)
  CALC   Calculate - Evaluate arithmetic expression on line
  CON    Concatenate datasets using the "CONC" command.
  CONC   Concatenate datasets using the "CONC" command.
  CONCI  Concatenate datasets using the "CONC" command.
  CONI   Concatenate datasets using the "CONC" command.
  DBP    DSECT Build Pointer (to IBM macros) requires macro DSECTBP
  EX     Export copy line (block) - Macro(EXP) required
  EXM    Export MOVE line (block) - Macro(EXP) required
  EXP    Export copy line (block) - Macro(EXP) required
  EXPM   Export MOVE line (block) - Macro(EXP) required
  IM     Import after line - Macro(IMP) required
  IMP    Import after line - Macro(IMP) required
  JF     Jcl Format - MACRO(JF) req'd
  JFH    Help for 'JF' line command
  KP     Keyword Parameter parse/remove statements
  KW     *** Undocumented by author ***
  LMID   LINEMAC identifier
  LMR    LINEMAC restore line to original image
  MLC    Move LHS from cursor column with prompt for to cursor
  MLCN   As "MLC" above but for Non-excluded lines only
  MLCX   As "MLC" above but for eXcluded lines only
  MMA    Invoke "Member Manager" against this and next lines.
  MME    Invoke "Member Manager" against this and next lines (parm 'E1')
  MMV    Invoke "Member Manager" against this and next lines (parm '/V')
  MRC    Move RHS from cursor column with prompt for to cursor
  MRCN   As "MRC" above but for Non-excluded lines only
  MRCX   As "MRC" above but for eXcluded lines only
  MVC    Move RHS from cursor column with prompt for to cursor
  MVCN   As "MVC" above but for Non-excluded lines only
  MVCX   As "MVC" above but for eXcluded lines only
  ON     Overlay on N-excluded lines
  ONC    Overlay on N-excluded lines selective Column
  ONCU   Overlay on N-excluded lines Unconditional selective Column
  ONU    Overlay on N-excluded lines Unconditional
  ONUC   Overlay on N-excluded lines Unconditional selective Column
  OX     Overlay on eXcluded lines
  OXC    Overlay on eXcluded lines selective Column
  OXCU   Overlay on eXcluded lines Unconditional selective Column
  OXU    Overlay on eXcluded lines Unconditional
  OXUC   Overlay on eXcluded lines Unconditional selective Column
  QIT    Change text to Queue 'text' - Macro(QIT) required
  REV    REVerse the order of lines - Macro(REV)
  RSC    Remove Semi-Colon. Parse joined commands 1 per line.
  RSCN   AS for "RSC" but for non-excluded lines only
  RSCX   AS for "RSC" but for excluded lines only
  SFP    Execute S/F - Macro(SFPK) (S/F PacKage extract)
  SIT    Create "Say 'v1=>'v1'<'" from "v1" 4 debug'n-Macro(SAYIT)
  SITI   Create "Say 'v1=>'v1'<'" from "v1" 4 debug-Macro(SAYIT)
  SJF    SDSF JCL Formatter - Macro(SJF) required
  VAPF   Verify APF entry of DSNAME vs VOLUME (allow for ******) list NF
  VAPFA  Verify APF entry of DSNAME vs VOLUME (allow for ******) list AL
  VAPFN  Same as "VAPF" but in a NOTELINE for prmlib APF list members
  VB     VSAM Browse - using CMD(%VB)
  VLNK   Verify LNKLST entry of DSNAME vs VOLUME (allow for ******) list
  VLNKA  Verify LNKLST entry of DSN vs VOLUME (allow for ******) list AL
  VLNKN  Same as "VLNK" but in a NOTELINE for prmlib LNKLST list members


  LMEXIT line commands:
  ---------------------

  $DSEL  Invoke $DSNSEL
  paul   paul's demo to insert filler
  CON    Concatenate datasets using the "CONC" command.
  CONC   Concatenate datasets using the "CONC" command.
  DAL    Generate define dataset ALIAS JCL
  JOE    Generate define dataset ALIAS JCL
  LI     Generate LISTDSI command and test for valid dataset
  NL     Convert line into a NOTELINE  (can block)
  OCJ    Issue Operator Command in JCL
  OCJS   Issue Operator Command in JCL & automatically submit it
  OUT    Generate OUTTRAP commands.
  PI     Progress Indicator (after - default)
  PIA    Progress Indicator (after)
  PIAN   Progress Indicator (after)  as NOTELINE
  PIB    Progress Indicator (before)
  PIBN   Progress Indicator (before) as NOTELINE
  PIL    Progress Indicator (locate)
  PIN    Progress Indicator (after)  as NOTELINE
  PRM    Generate parsed LABEL macro commands.
  QH     Quick Help_me instream NOTELINE Help processing
  REX    Execute member as REXX command.
  SD     Show difference between adjacent lines  (marks with '*')
  SDA    - As "SD" but Adjacent lines are compared
  SID    Get SYSID using REXX (as NoteLine)
  SLN    Shift Left Non-excluded lines
  SN     Shift Right Non-excluded lines
  SRC    Generate SOURCE REXX command (as NoteLine)
  SRN    Shift Right Non-excluded lines
  TEX    Testing numerics in command.
  TVOL   Generate commands to test validity of a VOLSER
  XAC    eXecute As Command
  XAM    eXecute As Macro
  XAT    eXecute As a Tso command
  XP     Generate eXtract Parm parameter (in Notelines)


  LMEXITMP line commands:
  -----------------------

  %      Invoke Multi-procs with func as parm "/ff"
  %A     Multi-procs option - A
  %AC    Multi-procs option - AC
  %AI    Multi-procs option - AI
  %AL    Multi-procs option - AL
  %AM    Multi-procs option - AM
  %AS    Multi-procs option - AS
  %AU    Multi-procs option - AU
  %B     Multi-procs option - B
  %BA    Multi-procs option - BA
  %BI    Multi-procs option - BI
  %C     Multi-procs option - C
  %CA    Multi-procs option - CA
  %CAK   Multi-procs option - CAK
  %CH    Multi-procs option - CH
  %CI    Multi-procs option - CI
  %CL    Multi-procs option - CL
  %CN    Multi-procs option - Cn
  %CO    Multi-procs option - CO
  %D     Multi-procs option - D
  %DA    Multi-procs option - DA
  %DL    Multi-procs option - DL
  %DR    Multi-procs option - DR
  %DS    Multi-procs option - DS
  %E     Multi-procs option - E
  %EA    Multi-procs option - EA
  %EM    Multi-procs option - EM
  %EQ    Multi-procs option - EQ
  %EX    Multi-procs option - EX
  %F     Multi-procs option - F
  %FC    Multi-procs option - FC
  %FX    Multi-procs option - FX
  %HB    Multi-procs option - HB
  %HC    Multi-procs option - HC
  %HD    Multi-procs option - HD
  %HELP  Multi-procs help tutorial
  %HELPM Multi-procs help tutorial
  %HL    Multi-procs option - HL
  %HM    Multi-procs option - HM
  %HQ    Multi-procs option - HQ
  %HR    Multi-procs option - HR
  %HU    Multi-procs option - HU
  %I     Multi-procs option - I
  %IB    Multi-procs option - IB
  %IE    Multi-procs option - IE
  %IT    Multi-procs option - IT
  %IU    Multi-procs option - IU
  %IV    Multi-procs option - IV
  %IX    Multi-procs option - IX
  %LC    Multi-procs option - LC
  %LD    Multi-procs option - LD
  %LE    Multi-procs option - LE
  %LI    Multi-procs option - LI
  %LM    Multi-procs option - LM
  %LV    Multi-procs option - LV
  %M     Multi-procs option - M
  %MA    Multi-procs option - MA
  %ME    Multi-procs option - ME
  %ML    Multi-procs option - ML
  %MP    Multi-procs header (option label less "l_5")...
  %MV    Multi-procs option - MV
  %O     Multi-procs option - O
  %OCJ   Multi-procs option - OCJ
  %OCJS  Multi-procs option - OCJS
  %OO    Multi-procs option - OO
  %P     Multi-procs option - P
  %PC    Multi-procs option - PC
  %PD    Multi-procs option - PD
  %PE    Multi-procs option - PE
  %PM    Multi-procs option - PM
  %PO    Multi-procs option - PO
  %PX    Multi-procs option - PX
  %R     Multi-procs option - R
  %RC    Multi-procs option - RC
  %RL    Multi-procs option - RL
  %SC    Multi-procs option - SC
  %SF    Multi-procs option - SF
  %SK    Multi-procs option - SK
  %SM    Multi-procs option - SM
  %SU    Multi-procs option - SU
  %T     Multi-procs option - T
  %TR    Multi-procs option - TR
  %UF    Multi-procs option - UF
  %V     Multi-procs option - V
  %VB    Multi-procs option - VB
  %VC    Multi-procs option - VC
  %VI    Multi-procs option - VI
  %VP    Multi-procs option - VP
  %W     Multi-procs option - W
  %XB    Multi-procs option - XB
  %XE    Multi-procs option - XE
  %XM    Multi-procs option - XM
  %Z     Multi-procs option - Z
  %ZA    Multi-procs option - ZA
  %ZB    Multi-procs option - ZB
  %ZV    Multi-procs option - ZV
  HELP%  Multi-procs help tutorial
  HELPM% Multi-procs help tutorial


  LMEXITCL line commands:
  -----------------------

  ALIG   Align blank delimited columns
  CJ     Comment JCL statement - Macro(#CJ)
  CONS   Issue system console commands
  DCB    Insert DCB info
  DEL    Delete every nth line
  DELW   Delete word(s) based on search string
  EXTC   Extract column and output to a dataset
  FIL    Fill specified columns with blanks/char str
  INC    Replace/generate a string with incremental number
  INS    Insert a string on every nth line
  KPW    Keep words(s) based on search string
  PFX    Prefix a string on every nth line - MACRO(#PREFIX)
  QA     Quick allocation of list of datasets - Macro(#QA)
  RBL    Remove blanks between columns - Macro(#REMBLAN)
  RECX   TSO Receive from a member (use with XMITX $INDEX)
  SFL    Shift left to a specified string
  SFX    Suffix a string on every nth line
  SPLT   Split lines into one word per line - Macro(#SPLITLN)
  SUBS   Substitute with value from each line of a dataset
  SWP    Swap columns within edited member - Macro(#SWAPCOL)
  TEST   For testing edit macro
  UNIT   Insert unit, volser and space info


  LMEXITWC line commands:
  -----------------------

  BOX    Create a 'BOX' block
  CR     CICS Regions


  LMEXITZZ line commands:
  -----------------------

  EIOM   Progress Indicator for installations
  EIOR   EXECIO in loop Notelines using source skip-blocks (memb req
  ZA     Progress Indicator for installations

*-----------------------< LMHELP00 for LINEMAC >-----------------------*
  The following line commands have been expanded as a 1 line description
  is considered insufficient.

  Cmd    Description
  ------ ---------------------------------------------------------------
         Member processing line commands:
         --------------------------------
         All the following commands use routine "LMPRMEMB". It has been
         basically designed to process members using an index of the
         PDS.
         Some commands will accept parameters by overtyping the line (as
         command line data cannot be processed), however, this will
         cream your data.  To automatically restore your data, enter
         "/R" as the last word on the line.  The simplest way to achieve
         this is to type in your parameter(s) followed by a space
         seperated /R and the do an EOL (erase End_Of_Line).

         Notes:
          1. Data in columns 73-80 are ignored.
          2. It is recommended that you use the "INDEX" command to keep
             your index member list up to date.  If LINEMAC is
             available, it's highly probable that "INDEX" will also be.
             Enter "INDEX ?"  in any edit/view session to see if it
             available. The "?"  parameter will display the tutorial as
             notelines and the "INDEX" command cannot accidentaly
             change/corrupt your member UNLESS the member name contains
             "INDEX" in it.
          3. Ensure you scroll to the top before crying WOLF.

  BM     Browse memb from line.
  BMC    Browse memb at cursor (requires cursor placement).
  CM     Copy member 'a' to 'b' using MAC(LMPRMEMB). You will be
         prompted for the new name (and dataset/volume if required).
         Member may be copied to another dataset (catalogued/un).
         If member exists (in destination dataset), you will be prompted
         to enter "REPLACE" on the command line.
  CMU    Copy member 'a' to 'b' + Update "index" with new line.
  CP     Copy member (1st. word) from same PDS after cursor into
         session.  This command exploits this feature by permitting you
         to insert the source member, followed by '/R' and EOF.  If you
         do not like this, put your cursor on the command line, enter
         "COPY member_name" scroll down and place a "A" on the line you
         want it copied after and hit enter.
  DM     Delete member from line.
  DMU    Delete member from line + Delete line from "index".
  EM     Edit memb from line.
  EMC    Edit memb at cursor (requires cursor placement).
  KM     Compare memb from line using SuperC. "With" dataset(member) can
         be overtyped over 2nd. member (initialised to 1st. member in
         SuperC screen.)
         This facility requires access to customise IBM panels. See your
         dialog developer if it doe not work and you want it.
         (Why "K" for Compare, because "C" has been taken.)
  MS     Stats memb from line (same as 'SM' but I confuse them hence I
         habe both.
  RM     Rename memb from line.
  RMU    Rename memb from line + Update line in "index".
  SM     Stats memb from line (same as MS).
  ST     Stats memb from line (same as MS).
  SUBM   Submit memb from line.
  VM     View memb from line.
  VMC    View memb at cursor (requires cursor placement).
  XM     Execute memb from line.

                             ******

  BD     Browse Dataset from line.
  DL     DSLIST (ISPF opt 3.4 for dataset).
  ED     Edit DSN from line.
  VD     View DSN from line.
         The above four command should be used if you are unfortunate
         enough not to have "XE" available, however, you will need
         access to command "XB".

                             ******

  CL     Comment line with '/*...*/' in cols 1 & 71.  This is a toggle.
         Note: If columns 1 and 2 are not blanks, the line will be
               shifted right accordingly.  When toggled back, any prior
               shifting cannot be reversed as there is no record kept of
               the shift and you cannot determine whether the blanks
               were previously there or not.
  CLC    Comment line with '/*...*/,' cols 1 & 70. Works similar to the
         "CL" line command except that a comma is appended to indicate
         the line is continued.  This is made available for cases where
         commenting a line may interfere with logic or syntax.  Again,
         any shifting cannot be reversed.
  CLD    Comment line with '/*...*/,' cols 45 & 71. This command is
         designed for on line doco (usually variable setting doco). The
         cursor will automatically be placed within the comment
         delimiters.  This command is not togglable.

                             ******

         Help features:
         --------------
  HELP   This consists of a one-line list of all the commands extracted
         dynamically from LINEMAC and all the associated chained exits.
         As the list is dynamically built it will always be up to date,
         however, it short description is only as reputable as it's last
         dodgy modifier.
         Note:
          1. Some commands may appear in multiple exits. These may be
             duplicates or may actually have different functionality
             from another author.  Nevertheless, while the list may be
             sorted within the exit(s), the exits are displayed in a
             hierarchical order of execution and the command listed
             first will be the one executed.
  HELPX  This command will expand on the single line description offered
         by the 'HELP' command (at the discretion of the author).  It
         will be as up to date as dictated by the conscience of the
         exit's author (hence seek out the author based on the last 2
         characters of the exit name).
  HELP+  This command will display HELP for building line commands, it's
         infrastructure and goes into fair depth to identify and define
         the functionality of the LineMac Manager (LMM).

                             ******

  LEV    Generate macro Level checking code. Use in ")M" destined mac
         Use this command on existing macros called by LINEMAC or an
         exit.

                             ******

  LMV    LINEMAC (infrastructure component) versions.  Use this command
         to find the version identifiers for the 3 LINEMAC infra-
         structure components LM1, LM2 and LM3. Very useful for
         identifying back leveled versions.

                             ******

  VB     VSAM Browse - using CMD(%VB).
         This feature may be made available for sites without File-Aid.
         Note: Requires access to command "VB" and its infra structure.

*----------------------------------------------------------------------*
+
*----------------------< LMHELPAK for LMEXITAK >-----------------------*
  The following line commands have been expanded as a 1 line description
  is considered insufficient.

  Cmd    Description
  ------ ---------------------------------------------------------------
  CON    Concatenate datasets using the "CONC" command.
  CONC   Concatenate datasets using the "CONC" command.
  CONCI  Concatenate datasets using the "CONC" command.
         Blocked datasets will be concatenated and allocated to a
         generated DDname and presented using "ISPFALOC".  Use CONCI
         to invoke "ISRDDN" instead of "ISPFALOC".
         Notes:
          1. Requires access to macros "CONC" (and optionally
             "ISPFALLOC" and it's associated packaging).
          2. While "ISRDDN" is supported by IBM "CONC" is supported by
             the author of "ISPFALOC".  If "ISPFALOC" goes out of
             support then so does "CONC".
          3. "ISPFALOC" is more customisable than "ISRDDN".  Fell free
             to use whicever you prefer, but, as I'm the author I have
             made "ISPFALOC" as the default.

                             ******

  JF     JCL Formater.  Use line command JFH for instructions on the JF
  JFH    command (edit-macro 'JF' and don't forget to max UP if line 1
         is not at top of screen).
         Note: Requires access to macro "JF".

                             ******

         Member Manager:
         ---------------
  MMA    Invoke "Member Manager" against this and next lines.
  MME    Invoke "Member Manager" against this and next lines (parm 'E1')
  MMV    Invoke "Member Manager" against this and next lines (parm '/V')
         Invoke "MM" against two adjacent lines containig datasets in
         "XB" parsable format (which is practically any format except
         reverse spelling).  If an uncataloged dataset is to be
         processed utilise the "XB" volume parser feature by appending
         ",VOL=SER=voser" after the dataset name (as you would in JCL).
            eg.   SYS1.PARMLIB                  /* (on volume SYSR01) */
                  SYS1.PARMLIB,VOL=SER=SYSR02   /* alternate volume   */

         Use 'MMV' for catalogued datasets you wish to have the volume
         included (or use the '/V' command when is being processed).

         While "MM" will accept 'E1' or 'E2' as a parameter, only 'E1'
         is acceptable by LINEMAC ('MME' command).  If you wish to use
         'E2' it is suggested you reverse the order of the data lines
         and use 'E1'. (You can always export member to avoid
         corruption.)  To execute these line commands you need access to
         the "MM" package.
         Note:
           - Requires access to command 'MM' and it's infrastructure.
           - If you want to compare 2 non adjacent lines, use the block
             line command format (eg. MMAA), and the 1st. and last lines
             in the block will be compared.

                             ******

 MVC    Move RHS from cursor column with prompt for to cursor.
 MVCN   - As "MVC" above but for Non-excluded lines only.
 MVCX   - As "MVC" above but for eXcluded lines only.
 MRC    Move RHS from cursor column with prompt for to cursor.
 MRCN   - As "MRC" above but for Non-excluded lines only.
 MRCX   - As "MRC" above but for eXcluded lines only.
 MLC    Move LHS from cursor column with prompt for to cursor.
 MLCN   - As "MLC" above but for Non-excluded lines only.
 MLCX   - As "MLC" above but for eXcluded lines only.
        This line command will permit movement (shifting) of data from
        the current cursor position to another position that is input in
        a panel that displays the contents of the current line the
        cursor is on.  Data either side of the line (depending on data
        depth either by choice or screen size restricted) will be
        displayed with a column marker over it. Use this feature to
        align columns.
        Alternatively use the "COL" marker which is adjusted for any
        right scrolls.
        Move the cursor to where you want the data moved.
        The way the data is moved (relative to the cursor) depends on
        the command used. "ML*" will move the data to the left of the
        cursor with the cursor indicating the LAST character. The other
        commands will move the data to the right of the cursor with the
        cursor indicating the FIRST character.
        Notes:
          - Requires:
              REXX:
                MVC      - Main driver (macro).
                $DAT@CSR - Function to return data at cursor position.
              Panel:
                MVCP     - Cursor positioning panel.
          - Ensure that what it shifts is actually what you want.
          - The source of the data will be from where the cursor is on
            entry to the "move to". Be carefull when you leave the
            cursor in the sequence number part of the data. Cursor in
            this part of the line will default to column 1.
            If you screw up this way, rather than cancel out and start
            again, you may enter "NS" on the command and place the
            cursor in a new column, indicating a new start, thereby the
            cursor will be left asis and you will be given an oportunity
            to enter the new destination.
          - If the cursor is over the sequence number (either on
            invocation of the line command or in the "move to" screen),
            column 1 will be assumed.
          - Does not set or change BNDS settings. In fact it ignores
            them so watch it.
          - The display screen may present an image of the original
            screen to a depth of 3, 5, 7 or 9 lines. The greater the
            depth, the better your orientation to judge where to move.
            There is an input field on the screen to permit depth change
            provided your terminal model supports that depth. (Model 2
            terminals are locked into depth=3.)

                            ******

         Selective Overlays:
         -------------------
  ON     Overlay on N-excluded lines
  ONC    Overlay on N-excluded lines selective Column
  ONCU   Overlay on N-excluded lines Unconditional selective Column
  ONU    Overlay on N-excluded lines Unconditional
  ONUC   Overlay on N-excluded lines Unconditional selective Column
  OX     Overlay on eXcluded lines
  OXC    Overlay on eXcluded lines selective Column
  OXCU   Overlay on eXcluded lines Unconditional selective Column
  OXU    Overlay on eXcluded lines Unconditional
  OXUC   Overlay on eXcluded lines Unconditional selective Column
         The above ON* and OX* line commands are designed to issue
         overlay commands over either the eXcluded on Non-excluded lines
         in a block command. The first line in the block (or repetition)
         will be overlaid either the excluded or non excluded lines.

         You may do an unconditional overlay (ie. overlay even if the
         column is not spaces) by including a 'U' to the command (must
         follow the 'X' or 'N').

         You may limit the overlay to a (single) column range as
         follows:
           - Include a 'C' to the command (must follow the 'X' or 'N').
           - Overtype the 1st. line with the column range as word 1.
             Format 'sc-ec' where:
               sc   - Start column.
               '-'  - Literal seperator.
               ec   - End column.  Must be greater than 'sc' and if
                      greater than record length it will be changed
                      accordingly.
           - The cursor must be placed back on the 1st. line (if a last
             block line is used) when the [ENTER] button is pressed to
             ensure it's original value can be restored.
         Notes on column selection:
          1. If the cursor is not on the first line, the original value
             will not be restored and in fact the column range entered
             will be included in the overlay.
          2. If you think it is too much mucking about repositioning
             the cursor, you can customise line 1 to only include the
             columns you need to overlay.  However that customised line
             is only good for one use and must be changed for other
             overlays.

         By mixing excluded lines with conditional and unconditional
         overlays, incredible special effects can be generated (better
         than any CGI).

                             ******

  VAPF   Verify APF entry of DSNAME vs VOLUME (list only 'NotFound')
  VAPFA  Verify APF entry of DSNAME vs VOLUME (list ALL with approp Msg)
  VAPFN: -  Same as "VAPF" but in a NOTELINE for prmlib APF list members
         This routine will verify parmlib APF members reporting on
         dataset against the volume specified.  For volumes of '******'
         the resvol will be determined and checked for the dataset.
         If the line contains the literal 'DSN=' or 'DSNAME=' it will be
         assumed to be executable JCL (as opposed to parmlib APF member)
         and the ranged datests will be compared with the memory
         resident APF list against any catalog information and reported
         accordingly.
         All reports will be notelines above the relevant line.
         Notes:
           - Some feature may require access to command 'VAPF'.
           - Datasets will be compared with the current LPAR and shared
             APF list may report "errors" that may not be actual errors
             on correct LPARs.
           - VAPFA will issue say statements as NOTELINES mixed will all
             the lines would be confusing.
           - VAPFN. The best way to utilise this feature is to exclude
             all the lines you wish to check and enter 'VAPFN' on the
             block exclude to just bring up the 'not found' ones only.

                             ******

*----------------------------------------------------------------------*
+
*-----------------------< LMHELP01 for LMEXIT >------------------------*
  The following line commands have been expanded as a 1 line description
  is considered insufficient.

  Cmd    Description
  ------ ---------------------------------------------------------------
  PI     Progress Indicator (after - default)
  PIA    Progress Indicator (after)
  PIAN   Progress Indicator (after)  as NOTELINE
  PIB    Progress Indicator (before)
  PIBN   Progress Indicator (before) as NOTELINE
  PIL    Progress Indicator (locate)
  PIN    Progress Indicator (after)  as NOTELINE
         PI* is a string of line commands designed to generate a
         progress indicator entry in the edit/view session for
         documentation purposes.  Any non-NOTELINE command will search
         and remove any preceeding PI's.
         Note:
          1. Any following PI will be left untouched.
          2. Issue a command with a 'N' suffix to ensure it meets your
             need.

                             ******

  SD     Show difference between adjacent lines  (marks with '*')
  SDA    - As "SD" but Adjacent lines are compared
         This command will will compare two (or more adjacent lines
         against the first line) and notify the difference with an
         asterisk (*) above the difference in a NOTELINE.  Because of
         this feature (noteline), comparison is only for the scope of
         the screen and if any scrolling is performed, you must reset
         (or delete notelines) and re-issue the command.
         Notes:
         1. This command is not meant to be a file comparere but may
            compliment the "XD" (eXclude Duplicates - if available)
            command or any comparison routine that compares datasets/
            members (eg. SuperC) when the difference between two lines
            may be difficult to detect.
         2. "SD" on one line will compare it with the NEXT line.
         3. Blocking will compare all the following lines with the first
            line and not necesarily the previous line unless you use the
            "SDA" command.
         4. A blank line will be displayed if all chacters are matched
            otherwise either an "offscreen differences" or "lines same"
            message will be notelined.

                             ******

  SN     Shift Right Non-excluded lines
  SLN    Shift Left Non-excluded lines
  SRN    Shift Right Non-excluded lines
         The above commands are designed to shift selected lines only
         either left or right. As you cannot pass the number of columns
         to shift in the line command or as a command line parameter you
         can specify the number of columns to shift by:
         1. Cursor placement where you wish to shift column 1 to.
            Using this option, you do not need to reposition the cursor
            on the first line of the block.
            Notes: - If you place the cursor on column 10 column 1 is
                     shifted to column 10, which would actually be a
                     shift of 9.  This may not give your desired results
                     for a left shift without practice.
                   - Consider leading spaces.  They may conflict with
                     your wishes when choosing destination column.
         2. Overtype the line so that the first word specifies a numeric
            shift amount.
            - The cursor must be placed back on the 1st. line (if a last
              block line is used) when the [ENTER] button is pressed to
              ensure it's original value can be restored.
         Use common sense (or a trial run if you have BNDS on or off).

         Notes on the overtype method:
          1. If the cursor is not on the first line, the original value
             will not be restored and in fact the column range entered
             will be included in the overlay.
          2. If you think it is too much mucking about repositioning
             the cursor do it manually.

                             ******

*----------------------------------------------------------------------*
+
*----------------------< LMHELPMP for LMEXITMP >-----------------------*
  The following line commands have been expanded as a 1 line description
  is considered insufficient.

  Cmd    Description
  ------ ---------------------------------------------------------------
  %HELP  -or- HELP%
         Multi-procs help tutorial.  This line command will invoke the
         dynamic tutorial for "XE" which will list all the Multi-Procs
         commands.  You will need access to Multi-Procs tutorial (not
         commonly distributed) for further details on individual
         commands.  Refer to your dialog developer for availability of
         detailed tutorial.

         Multi-Procs (MP) line commands:
         -------------------------------
  %*     Prefix any MP command with a '%' to pass the extracted dataset
         (or DSLIST mask) to MP (CSMDSN) for processing if it is
         available.  If it is not available you will get a line command
         error.
         As an alternative you may have the MP command following the
         dataset prefixed by a '/' (which is a valid MP interface prefix
         exploited by the "XE" routine). By this method you only need to
         enter '%' by itself to execute the MP command against the
         evaluated dataset. "XB" is used as the processor to extract the
         dataset name from the line.  For further details on how "XB"
         works enter 'TSO %BR XB ?' on the command line for further
         details.
         Note: The default action is '%V' which is view (or '/V' passed
               to MP) unless the dataset "name" containg a masking
               patterm containing "%" or "*" whereby the action will be
               '%DL' (dataset list - ISPF 3.4).
         Examples:
         1.  A % line command will result in the following dataset being
             edited:
               SYS1.PROCLIB.CPU1,VOL=SER=DASD01      /E
         2.  A % line command will result in the string being passed to
             DSLIST (ISPF 3.4):
               SYS*.PROCLIB                          /DL

*----------------------------------------------------------------------*
+
*----------------------< LMHELPWC for LMEXITWC >-----------------------*
  Line commands specifically created for WCI.

  Cmd    Description
  ------ ---------------------------------------------------------------
  CR     CICS regions

                             ******

*----------------------------------------------------------------------*
+
*----------------------< LMHELPZZ for LMEXITZZ >-----------------------*
  Line commands specifically created for for demonstration purposess
  into terminator exit "LMEXITZZ".

  Cmd    Description
  ------ ---------------------------------------------------------------
         The details can be expanded for as many lines as your heart
         desires. Between the two "mark" lines it is free form text.
         Gotchas:
         1. Data past column 72 will not be displayed.
         2. You will need to pair up '/*' and '*/' comment indicators.
            Best way to do this id to place the complimentary one past
            column 72 so it will not be displayed (as per gotcha #1).
         3. No pretty pretties.  To jazz up your presentation, create a
            dedicated line command to launch your design of extra info
            if your line command does not include it's own doco.

                             ******

  EIOM   Progress Indicator for installations
         Extra detail line 1
         ........
         Extra detail line last

                             ******

  EIOR   EXECIO in loop Notelines using source skip-blocks (memb req

                             ******

  ZA     Progress Indicator for installations

                             ******

*----------------------------------------------------------------------*
LMM Tutorial (optput of HELP+ made into data).
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

G'day.

*----------------------------------------------------------------------*

LINEMAC/LMEXIT/LMAC.
--------------------
LMAC is an "IBM" supplied line command processor.

LINEMAC is a set of predefined line commands and LMEXIT is colloqualy
refered to as 'chained' exit(s) anchored off LINEMAC to execute user
defined line commands.

While LINEMAC can readily be user customise, any modifications will not
be supported, however, limited support (advice) will be provided for
user modified LMEXIT.  LINEMAC commands will be executed before any
LMEXIT command.

LMAC permits user customised line commands outside of the LINEMAC and
LMEXIT format which will not be supported.

LINEMAC/LMEXIT is site customised and the only supported interface with
LMAC.

*----------------------------------------------------------------------*
Quick ref:
==========
LMM options:
------------
  A - Analyse LINEMAC/LMEXIT for valid format.
  E - Extract from LINEMAC/LMEXIT into individual members.
  C - Configure build member.
  B - Build LINEMAC/LMEXIT.
  TC- Trace Chain. Lists all the exits in the LINEMAC chain. Additional
      parameter of '/R' will return the chains in a string, eg.
         path=LMM('TC /R')    - then parse the path.
      Sample path returned:
         ALK2567.$$(LINEMAC) -> ALK2567.$$(LMEXITAK) -> ALK2567.$$(...
                  ****
  I - Update infrastructure code from members LM1, LM2 and LM3.
      You may control the member update by using format 'In',
      where "n" can have the following values:-
        1 - Replace appropriate code with new LM1 member.
        2 - Replace appropriate code with new LM2 member.
        3 - Replace code with new LM3 member.
  F - Update infrastructure code from members LM1, LM2 and LM3.
      Similar to 'I' except that the infrastructure did not have to
      exist.  This "Forces" build and is ideal for creating a new
      exit.
      You may control the member update by using format 'Fn',
      where "n" can have the following values:-
        1 - Replace appropriate code with new LM1 member.
        2 - Replace appropriate code with new LM2 member.
        3 - Replace code with new LM3 member.
                  ****
  n - Non-National characters "!+/`%" translated and returned in
      ISPF message.
                  ****
  ? - This tutorial (also accessible using the "HELP+" line command).
                  ****

Control Commands summary:
-------------------------
  )*    :comment.
  )A    :column Alignment.
  )C    :Cursor placement.
  )D    :Delete line.
  )E    :Dataline (after).
  )EB   :Dataline before.
  )EA   :Dataline after.
  )ER   :Dataline replace.
  )E#   :Repeated Dataline.
  )H    :Help message (ISPF message).
  )I    :Import dataset(member).
  )M    :execute Macro. (Parms - "linef,linet,lcmd parms")
  )N    :Noteline (before).
  )NA   :Noteline after.
  )NB   :Noteline before.
  )O    :Overlay line.
  )R    :Rexx command.
  )RC   :set RC on exit.
  )RL   :Restore line from original value.
  )S    :(Not fully developed.)
  )T    :rexx Trace.
  )WA   :Word At cursor. (Requires command "$WORDAT".)

Instream routines:
------------------
   mark    - Returns the relative line number.
   n_b     - Noteline before with value of Arg(1)
   n_bm    - Noteline before with value of Arg(1) + preset maskline
   n_a     - Noteline after with value of Arg(1)
   e_b     - Dataline before with value of Arg(1)
   e_a     - Dataline after with value of Arg(1)
   e_o     - Dataline (replace) with value of Arg(1)
   Trans   - Translate Arg(1).
Available variables:
   line#   - Current line number
   line@   - Current line content. (Including overtypes)
   line#s  - Start of line range
   line#e  - end of line range
   lcmd    - line command entered (unencripted)
   #adr@   - entry address mode
   lcmd1stl- original value of the cursor line
   lcmd1l# - original 1st. line
   lcmd1c# - original column value of the 1st. line
   xcmd#   - Name of the command being exeuted. The line command member.

*----------------------------------------------------------------------*

LINEMAC and its associated exit(s) (LMEXITxx) permit users to design
their own line commands for common used code, JCL, copybooks, templates
etc.  and keep all those fiddly little edit macros in one member.
Can readily be used similar to the ISPF's "Model" feature, BUT from a
line command with smarts.

The main driver is LINEMAC and it consists of all the established site
supplied and user customised commands.  Exit LMEXIT is provided for
users to develop and play with their own commands before "importing"
them into LINEMAC. These exit commands cannot override the LINEMAC
commands, however, once established under a different command name, they
may be used to replace the same command in linemac during a rebuild
process.  (The rebuild process using "LMM" will be discussed later.)

You may chain a number of LMEXIT modules together using the "next_exit"
variable defined in the top few lines of a built member (or member LM1).
This variable is set to the next exit that is to be executed if no match
is found for the line command in the current LINEMAC/exit.  The chain is
terminated by the setting of the "next_exit" variable to NULL.
(You may interrogate the up-front exit chain using the "LMM TC" command
in any edit/view session.)

You can provide a dedicated line command to invoke detailed
tutorials/instructions for selective line commands (or provide your own
designed function documentation).  Alternatively each exit may be used
generically to "automatically" provide expanded details for those more
complex line commands that the one-liner provided by the "HELP" line
command displays. This expanded help will be provided for all documented
line commands (If this is not acceptable stay with the dedicated line
command method.)  Each exit will launch a member that can contain
expanded details for line commands intercepted by that exit. The member
launched is pointed to by variable "help_expd" setting in that exit.  By
default this variable's setting is LMHELP00 and LMHELP01 for LINEMAC and
LMEXIT respectively.  It is recommended to use member names LMHELxx
where 'xx' is the same last two bytes as the exit (if using LMEXITxx
formats).  It is the resposibility of the exits author/owner to provide
as much or as little expanded details for individual line commands for
that exit and to ensure that the expanded help is synchronised between
the correct exit and expanded help member.  Use member LMHELP00 as a
sample expanded help member.  It will be included as part of the LINEMAC
distribution.


For the purposes of this tutorial:
- LINEMAC will be referred to, however, all applies to LMEXIT as well.
- LMEXIT will be colloqually used for any exit identified by the
  "next_exit" variable.  While it can be any member name, it is
  recommended that format LMEXITxx is used where 'xx' is the initials of
  the author.
- 'expanded help' is colloqually used for any exit's "LMHELPxx" member
  (pointed to by the "help_expd" variable in the exit).
- ISPF considers a repetition command as the numerics following the
  line command itself. Eg. FRED81 infers a repetition of 81 lines
  following the line the command was placed on.
- ISPF considers a block command as a duplication of the last
  character. Eg. A block command for FRED would be identified by lines
  bounded by FREDD on two seperate lines. By this feature, you cannot
  have a command with the last two characters the same.
- Cursor and lines will be referred to as details returned by either a
  block command or line repetition command.

LINEMAC controls processing by passing control to an instream label
of the format "l_command:". (This will be covered in detail later.)

LINEMAC has 3 processing options, refered to as PO1, PO2 and PO3
respectively:
  1. Interpretive code.
     ------------------
     This consists of a series of control characters unique to LINEMAC
     and controls the processing of the data on the particular line.
     In its simplicity anything coded will be inserted after the
     line(s).  You can then control processing options by control
     characters. Eg. ")N" in column 1 will generate a NOTELINE while
     ")E" (or by default no control) a DATA line.
     While an overview of all available commands may seem daunting
     most are optional and should be used once you are comfortable with
     the basic commands.

  2. Instream REXX.
     --------------
     Pass control to the appropriate instream REXX routine and execute
     it. This should be relatively short code and only used if some
     processing logic is required. For mega-smarts use the ")M" feature.
     (See below for variables and routines available to instream REXX
     code.)

  3. External function.
     ------------------
     Invoke other pre defined code (should be an edit macro if you want
     access to the data). The easiest way to use this concept is by
     using the ")M" feature under "Interpretive code" option.
     Control is now in your hands and you are God. Do whatever you like.
     Effectively your program will be passed the following parameter
     string:
         "linef,linet,lcmd parms"
     where -
         linef  - Starting line.
         linet  - Ending line. Will be the same as linef if not a block.
         lcmd   - Line command entered. This is required for multiple
                  aliases.
         parms  - any aditional parameters required by program as set up
                  in LINEMAC.
     Note: linef, linet and lcmd are separated by commas and the full
     parameter passed should be parsed as follows:
         Parse VAR parm linef ',' linet ',' lcmd parms

     Different commands (refered to as aliases) may call the same
     program, hence the availability of the line command (lcmd and
     potential parameters) used to instigate the process. It is the
     responsibility of the receiving program to take the appropriate
     action.

     You may wish to pass additional variable details to your program.
     This can be achieved by tabbing into the dataline (column 1) and
     typing in appropriate data required by your program. (You may be
     overtyping valid required data.) Fear not fair adventurer as a
     snapshot of the original data is available in variable "lcmd1stl"
     in the shared pool. The original line number and column number are
     in variables "lcmd1l#" and lcmd1c# respectively, issue a
     "VGET (lcmd1stl,lcmd1l#,lcmd1c#) SHARED" and if the line has
     changed, replace it with the original value. Eg.
        Address ISPEXEC "VGET (lcmd1stl,lcmd1l#,lcmd1c#) SHARED"
        If line/=lcmd1stl Then "ISREDIT LINE &lcmd1l#=(lcmd1stl)"
     Alternatively use the ')RL' command.
     Note:-This feature can only be used for a single line and it is the
           one the cursor is on. If a line is changed and you want it
           restored the cursor MUST NOT move from that line. Do not
           attempt this feature in a block command where when you hit
           [ENTER], the cursor is on the "to" line.  If you wish to do
           this, return the cursor to the "from" line.
          -This feature will register as a change in the Edit/View
           session and stats will be updated accordingly if the
           approprate bouncing ball is followed.

     If you utilise an existing macro some modifications need to be
     made:
       a) Insert an "Address ISPEXEC 'CONTROL ERRORS RETURN'" command
          before the "ISREDIT MACRO ()" command. (Depending on your
          coding style this may not be required but it is a safety net.)
       b) If you do 'range processing' this will need to be bypassed
          when invoked through LINEMAC as the range processing has
          already been done by LINEMAC. However the line ranges are
          provided as described above.
          A line command "LEV" has been provided in LINEMAC to enter
          on the line BEFORE your range processing commands and follow
          the prompts.  Try it and you'll get the hang of it as it will
          practically hold your hand for you.

Control Commands summary:
-------------------------
  )*    :comment.
  )A    :column Alignment.
  )C    :Cursor placement.
  )D    :Delete line.
  )E    :Dataline (after).
  )EB   :Dataline before.
  )EA   :Dataline after.
  )ER   :Dataline replace.
  )E#   :Repeated Dataline.
  )H    :(Help) message.
  )I    :Import dataset(member).
  )M    :execute Macro.
  )N    :Noteline (before).
  )NA   :Noteline after.
  )NB   :Noteline before.
  )O    :Overlay ine.
  )R    :Rexx command.
  )RC   :set RC on exit.
  )RL   :Restore line from original value.
  )S    :(Not fully developed.)
  )T    :rexx Trace.
  )WA   :Word At cursor. (Requires command "$WORDAT".)

Control Commands syntax: (must start in column 1).
------------------------
  )*    :Comment card. '*' by itself becomes a valid data/note line.
         Used for doco purposes and is ignored.
  )A    :Align with column:
     *   Align with previous line. Can have +/-n for offset from auto
         align to force indentation.
     n   Align to column number 'n'
  )C    :Place Cursor on line where:
     l,c 'l' Lines from initial line, column 'c'. Initial line is used
         and this format should be the last ")C" command for that
         professional cursor placement and final presentation.
     +n  Advance cursor 'n' lines for next process.
     -n  Regress cursor 'n' lines for next process.
         You can substitute "L" for 'l' or 'n' to indicate last line.
  )D nn :Delete line. Can pass a number of individual lines to delete.
         Number should be in ascending order with '*' representing
         the curent cursor positioning. The numbers will be processed in
         reverse order and are lines relative to the line the command
         was entered on.
  )E    :Dataline (after).
  )EA   :Dataline after.
  )EB   :Dataline before.
  )EN   :Dataline noteline. Replace current line and display original
         value in NOTELINE above it.
  )ER   :Dataline replace current line.
  )E#   :Repeated Dataline to repetition-1
  )H     ISPF (Help) message. Text of message to be displayed on exit.
         ")H" commands are stackable for large messages (>line length).
  )I(c) dsn(member) range
        :Import member for block.template
     c   Generic LINEMAC command. Use this command for all lines
         in the imported member. Valid values are E, M or N where,
            E - Each imported line is a data line
            M - Each imported line is to be executed as a macro
            N - Each imported line is a NOTELINE (or NA or NB)
         Other values will be rejected and treated as blanks. 'blanks'
         infer use the control commands (or lack of) from the imported
         dataset whose format should be the same as in this line command
         block code.  You can use the 'NA' and 'NB' for the Notelines.
     dsn Import member (seq file) and process it.
     range
         Range of lines to include from dsn(member). The range format
         is:
            from-to   where:-
               from - May be either a line number or a literal (usually
                      a label).  If the literal is used, the first
                      occurance of the literal is used as the start so
                      make sure it is unique.  You may specify an offset
                      from this literal by,
                         literal(offset)
                      where "offset" can be a positive or negative
                      displacenet from the literal line. Default is 0
                      (zero).
               to   - Same format as the "from" but is the terminating
                      line.
         Eg. )I(N) REXX($EXECIOL) 25-74
             Import as NOTELINES member 'userid.REXX($EXECIOL)' and do
             NOT include lines 1 to 24 and lines 75 to end of file.
             )I(N) REXX($EXECIOL) Start_proc#1:(1)-End_proc#1:(-1)
             Include 1st. line after label "Start_proc#1:" to the
             line before label "End_proc#1:"
         Notes:- You may repeat this block format to build your
                 inclusions, however, each inclusion will be treated
                 seperately and the same file may be read multiple
                 times.
               - Invalid parameter format may cream your member with
                 unplanned data.
  )M m p:Execute an existing macro 'm'. Will pass it parameter of
         start_line,end_line,line_command_entered 'p' (any data entered)
         Eg. )M FRED /E=(1,2)
  )N    :Noteline (before)
  )NA   :Noteline after.
  )NB   :Noteline before.
  )O m  :Overlay line with a valid edit macro MASK 'm'. 'm' can be
         represented as '+m' or 'm+'. The default is '+m' indicating
         line overlaid by mask. Use the 'm+' format to stop overlay if
         there is data.
         Eg. To place open clossing REXX comments in cols 45-72,
              ")O +<45 '/*' 71 '*/'>"  <-overlay data if there
              ")O <45 '/*' 71 '*/'>+"  <-maintain original data in cols
                                         45-46 and 71-72.
         For futher details, refer to the ISPF Edit Macros MASKLINE
         command.
  )R    :Interpret line as a REXX command. (KISS... If you want complex
         code use instream REXX.)
  )RC   :Set return code. Refer below for use/non-use of this control
         command. Ignoring return codes may cause unpredictable
         results.
  )RL   :Restore Line to original value. With this feature you can
         overtype the line to use as parameters to your command.
         LINEMAC will not utmatically restore value.  You know what can
         be overtyped, you control restoration....
  )S    :Self re-execution. Stack multi functions into 1. (NOT YET
         DEVELOPED.)
  )T r i:Turns trace on. "r" can be any valid REXX trace value. "i" can
         be either CANCEL/RETURN for ISPEXEC CONTROL command. If CONTROL
         is required without REXX tracing use a '.' paceholder for the
         REXX trace indicator.
  )WA v :Returns the space delimeted word at the cursor placement and
         places it in variable 'v'.

Control Commands positioning (relative to active line):
----------------------------
  )A    - N/A (sets prefix pad).
  )C    - Current.
  )D    - Current.
  )E    - After.
  )EA   - After.
  )EB   - Before.
  )EN   - Current.
  )ER   - Current.
  )E#   - After (or repetition -1).
  )H    - N/A
  )I    - Determined by "C" value. No additional control statements
          will be accepted after procesing
  )M    - Curent line passed to macro. Macro decides action.
  )N    - Before.
  )NA   - After.
  )NB   - Before.
  )O    - Current with MASK.
          refer to the ISPF Edit Macros MASKLINE command.
  )R    - N/A
  )RC   - N/A
  )RL   - Current
  )S    - Dependant on function it calls.
  )T    - N/A
  )WA   - Current
  no )  - Treated as ")D" with full line output.

Instream routines:
------------------
If you code your own instream REXX, refer to "CL" instream example, (you
would do this to save having heaps or 1 or 2 liners in your REXX dataset
reserving precious 1-3 character member names), the following routines
are already in affect: <why duplicate?>
   mark    - Returns the relative line number relative to Arg(1),
             eg. xx=Mark(2)  /* 2nd. line number after executing line */
   n_b     - Noteline before with value of Arg(1)
   n_bm    - Noteline before with value of Arg(1) + preset maskline
             (Follow ISPF standards and please DO NO forget to turn it
              off or users will curse LINEMAC.)
   n_a     - Noteline after with value of Arg(1)
   e_b     - Dataline before with value of Arg(1)
   e_a     - Dataline after with value of Arg(1)
   e_o     - Dataline (replace) with value of Arg(1)
   Trans   - Translate Arg(1), truncated to Arg(2) from matrix of Arg(3)
             of format 'default t1 val1 t2 val2 t3 val3 .. tn valn'
Available variables:
   line#   - Current line number
   line@   - Current line content.  Will have any overtyping which may
             be different to "lcmd1stl"
   line#s  - Start of line range
   line#e  - end of line range
   lcmd    - line command entered (unencripted)
   #adr@   - entry address mode
   lcmd1stl- original value of the cursor line
   lcmd1l# - original 1st. line
   lcmd1c# - original column value of the 1st. line
   next_exit
           - Name of the next exit to be executed after the command/exit
             being executed to launch the current line command.
   help_expd
           - Name of the member which list the expanded help details
             ("HELPX" - LMHELPxx) for the exit that intercepted the line
             command.
   xcmd#   - Name of the command/exit being executed to launch the line
             command.

Control syntax and GOTCHAs:
---------------------------
 1. Line command format (controlled by the "LMM" program and you should
    not be concerned with this unless you make direct amendments to
    LMEXEIT outside the "LMM" program):-

    Block start:                                                /*
     "L_cmd:ms=mark(1); /* comment"
      where:
       "L_"  - identifies line as label
       "cmd" - is your line command. Try to keep it short as possible as
               you only have 6 characters and the last character must be
               repeated to identify it as a block command. Also if your
               command is 5 characters you can only indicate a 9 times
               repetition number in the last character.
               Watch accidental creaming of existing commands, eg. "LC"
               ISPF's lower case conversion.
               Special encripted labels will be created for commands
               including the following characters "!+/`%".
       ":ms=mark(1); /*
             - Used to terminate label (:), set a variable to the next
               line number (mark()), command terminator (; - optional)
               and the "/*" for comment starter. This has to be
               terminated with a "*/" if you have a dual label. Note for
               multi labels, only the last requires a "ms=mark(1);".
               For in stream REXX command, this should NOT be used as
               the absence of this identifies the block as an instream
               REXX routine to "LMM". Instream REXX should have a
               terminating "*/" to the comment on the same line.
    Block End:
     "*/ End_cmd:me=mark(-1);Return put_lines()"
      where:
       "*/"  - End of comment block. Not used in instream REXX commands.
       "End_"- Identifies last line of the command block.
       "Return .."
               Code set by ")RC" control parameter ")M" exit value or
               0 default.
      For instream REXX commands, the "me=..." is redundant if used.
 2. Return codes control execution looping. LINEMAC will return the
    start and end lines of a line command. (Let us assume the range is
    >1.)  Generally range processing is repeated for each line and as a
    result the default return from a line command process is rc=0 Which
    results in a repetition loop for the range.  The return code from a
    ")M" edit macro is used. However, your macro may just want to
    process the range of lines only once.  To prevent repetition, exit
    your macro with a non-zero return code, or if it is a generic macro
    where that would not be acceptable, use the ")RC" command to set a
    non-zero return code.  The ")RC" control should be used on any
    command where a deliberate or accidental range command should only
    be executed once.
 3. Certain combinatios of control commands may not permit the desired
    result or give strange results, especilly if you mix ")E" and ")N"
    commands because of placement commands. You may need to reorder some
    lines or reverse orders. Play around till you get the right results.
    Use the ")C +/-" command to keep track of changed line
    sequences and reposition 'active' line.
    Refer to the "LEV" line command to highlight this Gotcha.
 4. For line insertions that have legitimate ")" character in column 1,
    eg, ISPF panels and skeletons, do not use the non-control character
    format, eg. a panel model line should be coded ")E )MODEL ....".
    Alternatively import from a member.
 5. Option ")D" is to tidy up after inserting dummy lines for noteline
    positioning. Minimise its use as misuse can cream good code.
 6. ISPF only returns a range within the confines of your member.
    If you issue a line command, eg. AF23, on line 3 of a 10 line
    member, the range returned will be 7 (3 to 10).
 7. ISPF will not permit imbedded numerics. So dont try to be smart and
    create a command line "A2B" unless the command has special
    characters and is "A+B", (I learnt the hard way.)
 8. If you choose to chain exits, do not call a previouly chainde exit
    otherwise you will go into a recursive loop.


    LMM:
    ----

    Program LMM (LineMac Manager) has been provided to partially
    automate the management of the LINEMAC and LMEXIT programs.
    Theoretically LINEMAC should not be modified as any build process
    will regress changes made to LINEMAC.  Any new code should be made
    and tested in LMEXIT and eventaully extracted and built into
    LINEMAC.

    This program has 7 basic functions and will be presented in sequence
    (sometimes refered to LMM-A, LMM-E, LMM-C, LMM-B, LMM-I, LMM-T and
    LMM-H respectively):
     1. Analyse LINEMAC/LMEXIT for syntax to ensure the "extract" phase
        will process correctly.
     2. Extract "line commands" from edit/view session into individual
        members.
     3. Configures the "build" member.
     4. Builds the LINEMAC/LMEXIT edit macro.
                     ****
     5. Replaces code in LINEMAC/LMEXIT with infrastructure members
        LM1, LM2 and/or LM3 and keep the user code intact.  This
        feature eliminates the need to extract and re-build LINEMAC.
        (You still need to perfrom the extract/configure/build steps
        if you wish to merge line commands from different sources.)
                     ****
     6. Translates any potential command containg any (or a mix) of
        the following non-national characters "!+/`%".
                     ****
     7. Display this tutorial. Also called by the "HELP+" line command.
                     ****

    LMM parameters:
    ---------------
     A - Analyse LINEMAC/LMEXIT for valid format.
     E - Extract from LINEMAC/LMEXIT into individual members.
     C - Configure build member.
     B - Build LINEMAC/LMEXIT.
     TC- Trace Chain.
                     ****
     I - Update infrastructure code from members LM1, LM2 and LM3.
         You may control the member update by using format 'In',
         where "n" can have the following values:-
           1 - Replace appropriate code with new LM1 member.
           2 - Replace appropriate code with new LM2 member.
           3 - Replace code with new LM3 member in LINEMAC.
     F - Force infrastructure. Same as 'I' except that it is used
         instead of 'I' when it is a new exit and the infrastructure
         is not present. May use 'Fn', however, it is suggested to
         do all.
                     ****
     n - Non-National charcters "!+/`%" translated and returned in
         ISPF message.
                     ****
     ? - This tutorial (also accessible using the "HELP+" line command.
                     ****

    LMM process cycle:
    ------------------
    LINEMAC ->(LMM-A)-> Correct any errors reported.
    LINEMAC ->(LMM-E)-> $LMMC ->(LMM-C)-> $LMMB ->(LMM-B)-> LINEMAC

    1. Analyse LINEMAC/LMEXIT formats (LMM-A):
    ------------------------------------------
    Edit/View LINEMAC/LMEXIT program. To effectively extract line label,
    where "cmd" is the line command. If a start "l_" label is found
    without it's complimentary "End_" label, it will be insereted as a
    NOTELINE before the next "l_" label. However, if it has a "l_" label
    either before or after it infering that it may be a label in a block
    command, it will be signalled accordingly for subsequent manual
    analysis and correction.   If it is a block command ignore it
    otherwise you may convert the noteline to data and delete any
    incorrect labels.
    If the 'start' of the blocked command has a complimentary "End_"
    label (1st. "l_" label should match the "End_" label) no error
    is reported.

    2. Extract "line commands" (LMM-E):
    -----------------------------------
    Edit/View LINEMAC/LMEXIT program. Either edit the second line, the
    one with ")X dataset" commented, to change the output dataset or
    accept the default 'userid.LINEMAC.COMMANDS'. If the output dataset
    does not exist it will be created. Note, the extraction will
    overwrite any like members in the output dataset.
    Enter "LMM E" on the command line to extract all members and create
    the configure member (default is $LMMC for LINEMAC and $LMMCX for
    LMEXIT).
    The third line, The one with the ")I dataset commented, points to
    the dataset that contains the code to wrap around your build of
    LINEMAC/LMEXIT during the build process. These are members 'LM1',
    'LM2' and 'LM3'.

    The extract process will process the viewed/editted member as
    follows:
      - Will look for a "l_" and "End_" blocks and create/replace any
        like members in the output dataset.
        Gotcha:  If the "End_" label is not found, the code will not be
        extracted into a member. The command part of the label will be
        used for member names.
      - If you use any of the special characters "!+/`%" in the command
        and these characters cannot be used in member names, the
        characters are traslated to "12345" respectively. To permit a
        valid member name, the member is prefixed with a "#". While "#"
        is a permissable line command any members starting with a "#"
        and contain numbers, will include from the above characters in
        whatever combination.  If this is confusing, DONT use them.
        NOTE - "/" is reserved for SuperSearch. Use it and suffer the
               wrath of Mr. Lim.
             - The labels will be removed and will not appear in the
               extracted member.
             - The comment on the label will be inserted in a 3 line
               comment box in the member.
             - @R on line 1 is generated to indicate instream REXX and
               should not be removed/changed
             - @A on line 1 (and following if applicable) indicate multi
               aliases for that block code. It's the same code (member)
               initiated by different line commands. The first label is
               used to generate the member name.

    The extract process will automatically generate the configure
    member $LMMC/$LMMCX.
    The following lines will be generated:
     )B Destination of the build member. BY default this will be the
        dataset identified by the ")X" line in the extract process
        and member $LMMB for LINEMAC and $LMMBX for LMEXIT.
     )O Destination of the final build and the member name. The member
        name should be either LINEMAC or LMEXIT.
        (It is suggested the build is made to the same dataset as the
        extraction and copied to the appropriate SYSPROC/SYSEXEC
        dataset.)
     )I Infrastructure dataset. Residence of default members LM1 and
        LM2. These dataset is taken from the ")I" line 3 from the member
        being extracted.
     )U User dataset to use for finding build members.
        The extract process will use the extract dataset with "(*)" to
        identify all members. An ignore string as follows will be placed
        on the line:
             "- $LMM* $$$INDEX LINEMAC LMEXIT*"
        The '-' identifies ignore command followed by an ignore member
        list. Members can have a trailing '*' wildcaring indicator.
        Note, the '$LMM*' will automatically exclude the $LMMC, $LMMCX,
        $LMMB and $LMMBX members.
     )END Terminator.
     )* Are treated as comments.
     You can include any other datasets to be included when configuring
     the build member.
     Place any data you want to keep for reference but not process after
     the ")END" line.
     To generate a build member enter the "LMM C" on the command line.
     This will configure the build member and present it under the
     editor. (For further details, refer below.)

     Sample $LMMCx member:
     ---------------------
     col1
     |
     )*----------------------------------------------------------*
     )* Configure member - use "LMM C" to create.                *
     )*----------------------------------------------------------*
     )B LINEMAC.COMMANDS($LMMBX) <- build member
     )*
     )O LINEMAC.COMMANDS(LMEXIT) <- final output
     )*
     )I 'site.LINEMAC.REXX'      <- infrastructure members
     )*
     )U LINEMAC.COMMANDS(*) - $LMM* $$$INDEX LINEMAC LMEXIT*
     )*
     )*  Add any other datasets to use for the build member
     )*U 'site.LINEMAC.COMMANDS(*)'  - $LMM* $$$INDEX LINEMAC LMEXIT*
     )END
     )U 'other.LINEMAC.COMMANDS(*)' - $LMM* $$$INDEX LINEMAC LMEXIT*


    3. Configure the build member (LMM-C):
    --------------------------------------
    Edit/View $LMMC/$LMMCX members. Modify re-arrange lines if/as
    required.
    Enter "LMM C" on the command line to create the build member.

    The configure process will automatically generate the build member
    $LMMB/$LMMBX.
    The following lines will be generated:
     )O Output destination of the build process. As detected in the
        extract process. Taken directly from the ")O" in the configure
        member or defaults to current.dataset(LMEXIT) if not present.
     )I Infrastructure dataset as percolated through the extract and
        configure dataset.
     )U dataset(*) - exclude.list /* comments */
        One for each unique dataset in the configure member one of these
        lines will automatically be generated with an exclusion list
        as you supplied an '$LMM* @* LINEMAC' added if not supplied.
        Below this will be a list of all members in the dataset with
        the exception of those matching the configure exclusion list.
        This pattern will be repeated for all dataset (unique or not)
        in the config member.
        This is the hard part. You either accept all members form all
        the
        "..(*)  - exclude.list" or order and delete individual members
        till you get that warm fuzzy satisfied feeling. If you choose
        this path, back it up as the next configure run will cream all
        your hard work.  Delete any redundant lines as all specified
        members (explicit or implicit) will be included in your
        customised LMEXIT build member.  Any duplicates will be
        highlighted and ignored (at a processing overhead).
     )END
        Terminateds processing. Rather than deleting lines, suggest
        place after an ")END" control to keep for later reference
        without being processed.
     )* Comment lines that are ignored.
     Use the ")U" feature to swap macros/line commands with your
     friends.
     Enter "LMM B" on the command line to create the final LINEMAC or
     LMEXIT command. Copy this into your SYSPROC/SYSEXEC concatenation.
     Note - watch the build list as all members detected, whether
            explicitly or implicitly, will be include.
          - Paragraphs and aliases and comments will automatically be
            performed by the build process.

     Sample $LMMB member:
     --------------------
     col1
     |
     )*----------------------------------------------------------*
     )* Build member for the exit - use "LMM B" to create        *
     )*----------------------------------------------------------*
     )O LINEMAC.COMMANDS(LINEMAC)        /* This is IT!..
     )*
     )I $$ <- Infrastructure members
     )*
     )*
     )U LINEMAC.COMMANDS(*) - $LMM* $$$INDEX LINEMAC LMEXIT*
     )* Members after the '-' are to be ignored (can wildcard*)
     )*      or
     )* Delete above and include from following members. Move
     )* most used to top for those few MIP savings.
     )*
     )U LINEMAC.COMMANDS($S)
     .........
     )U LINEMAC.COMMANDS(ZEDSM)
     )*
     )END

    4. Build the LINEMAC edit macro (LMM-B):
    ----------------------------------------
    Edit/View $LMMB/$LMMBX members. Make last minute touches to arrange
    lines if/as required.
    Note: The ")I dataset" has percolated down through all the previous
          processes and caused no adverse grief if the incorect dataset
          was entered.  At this point an invalid dataset could be
          catastrophic so make sure it contains members LM1, LM2 and
          LM3.
    Enter "LMM B" on the command line to create the appropriate LINEMAC
    or LMEXIT member.
    Copy this member(s) into your SYSPROC/SYSEXEC concatenated dataset
    if the above dataset is not in the concatenation.


    5. Trace chain (LMM-TC):
    ------------------------
    Traces the chaining of exits starting at LINEMAC and ending when the
    following exit has variable "next_exit" set to nulls. The display
    will be presented in notelines at the top of the editted/viewed
    member.

    6. Update Infrastructure (LMM-I):
    ---------------------------------
    Update the infrastructure code from members LM1, LM2 and LM3 leaving
    your line command code intact.  This feature is used to apply
    shipped patches to LINEMAC/exits without the need to re-build the
    command.  (Alternatively you may re-build/rationalise LINEMAC and
    any additional exits.)
    You may control the member update by using format 'In', where "n"
    can have the following values:-
      1 - Replace appropriate code with new LM1 member.
      2 - Replace appropriate code with new LM2 member.
      3 - Replace appropriate code with new LM3 member.

    7. Translates Special characters (LMM-n):
    -----------------------------------------
    If you choose to use any of the following special characters "!+/`%"
    in your command, enter your proposed command after "LMM" to generate
    a label you can use to manually edit and modify your exit without
    going through the build extract/configure/build process.
        Eg.  LMM CP%A   -> "l_CP5A" and you will need a "End_CP5A".

    Hints and Tips:
    ---------------
     1. The line command can only be 6 characters long, however, I
        suggest you limit it to 5 to permit block commands and
        repetition.  Block mode is identified as duplicated last two
        characters.  (Thereby you could not have a line command like
        "CRAPP" as it would be considered a block of "CRAP" so I suggest
        you have a short CRAP with a single P.)  ALso a 5 character line
        command would only permit a maximum of 9 repetitions without
        blocking. Line commands cannot have embeded numerics hence the
        exploitation of special characters which are translated to
        numbers for member and program label purposes.
     2. Before executing the extraction phase, run the analysis phase
        to detect any formatting anomalies. Without this analysis and
        subsequent correction, commands may be ignored and lost during
        the build phase.
        (I repeat that I cannot emphasisse this step enough. You have
        been warned snake-eyes.)

     3. On extraction, each paragraph (line command) will be stored in
        a member bearing the commands name. The exception is when
        special characters are used and in that case the name is
        encripted with numerics.
        By design, there is a comment on each command label giving a
        brief description as a comment which is used by the "HELP" line
        command to educate the masses. During extraction, this comment
        will be immortalised in the offloaded member as line 2 skirted
        by a "comment box". This line should always be preserved as a
        short description of the command. You may continue in depth
        doco within comment lines in the head of the member. Line 2
        (with few exceptions) only will be used for internal doco and
        any other doco at the start will not be imported into LINEMAC.
        So, if you spent the last couple of days documenting your
        you-beaut world conquering member, back it up as a extraction
        will cream the member and replace your manuscript with a 3 line
        box comment extracted out of 1 line on LINEMAC.

        NOTE-NOTE - Extraction will cream existing members - NOTE-NOTE

        a) "@R" on line 1 of members indicate it is an executable piece
           of code (opt 2.c above). This is used by the build process to
           indicated that the code is to be executed and not
           interpreted.
           Note - The presence of this control line will make LINE 3 the
                  doco source.
        b) "@A" on line 1 of members indicate it is a multi invocable
           member. The next word will indicate all the commands that
           can be used to execute the original command (member) in the
           format c1=c2=c3... Only one member is created but this
           control line will generate all the appropriate labels in
           LINEMAC.
           Note - The presence of this control line will make LINE 3
                  the doco source.
     4. In block command mode (BULL) or muti-line mode (BUL25) the
        command will be executed multiple times (from-line to to-line).
        If that is your desire then do nothing. However, for example,
        you wish to pass a block to a macro once or you are adamant that
        any accidental repetition is a no-no your salvation is at hand
        as follows:
        a) Leave the REXX block or external edit macro with RC>0.
        b) In the interprative code, finish with an ")RC 4" control
           command.
     5. In executable REXX and invocation of edit macros, you have
        full control. But if you are slack and chose the interprative
        feature (which by the way is a little bewdy) the following
        low profile control command may be usefull:
          )A   - Column alignment
          )C   - Cursor placement
          )D   - Delete cursored line
          )R   - Execute REXX commands by interpreting the line
          )T   - Tracing
     6. LMEXIT will be called after the command entered is not found
        in LINEMAC. LINEMAC commands cannot be overriden through the
        exit.  If you want to use your command instead of one in
        LINEMAC, you will have to rebuild linemac pointing to your
        member in the appropriate $LMMB member.

    Recommended minimum packaging:
    ------------------------------
    The only two mandatory requirements are REXX routine "LINEMAC" and
    load module "LMAC" in their respective ISPF concatenations.

    The following members are recommended as the minimum package set:

    $DDALLOC - Routine to locate members in a DD allocation.
    $SORT    - Sort HELP commands prior to display.
    $WORDAT  - Word at character position identifier. For ")WA" command.
    LINEMAC  - Generic line edit macro command driver.
    LMACLMOD - LMAC load moule XMITed in here for easier distribution.
               Issue a TSO RECEIVE INDA() against this member to unload
               the load module.
    LMACR    - Remove line command facility.
    LMALLOC  - Alocate LINEMAC datasets(s).
    LMEXIT   - LINEMAC primary exit.
    LMM      - LINEMAC Member Manager and this tutorial.
    LMPRMEMB - LINEMAC member processor.
    LMREADME - LINEMAC readme.
    LM1      - LINEMAC front end infrastructure.
               Used by LMM to build LINEMAC or LMEXIT.
    LM2      - LINEMAC back  end infrastructure.
               Used by LMM to build LINEMAC or LMEXIT.
    LM3      - LINEMAC HELP+ infrastructure.
               Used by LMM to build LINEMAC or LMEXIT.
    REAL     - Optional ISPF concatenation allocator used by 'LMALLOC'.

    It is recommended that you browse member 'LM$INDEX' for additional
    suggested members that may be used by a prebuilt LINEMAC/LMEXIT.


