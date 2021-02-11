 Sometimes this member may be shipped in a dataset '*.ALLIN1'
 (hereafter) referred to as ALLIN1.

 If not, please disregard references to unTERSING members etc... as all
 relevant datasets will be shipped as a seperate XMITed file.
 Note:
 All non-loadlib executables will still be housed in the 1 common
 dataset and use the $$$INDEX member extensively to identify components.

 General notes on my routines.
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 - Most routines use '?' or '/?' to launch tutorials (exception is
   "SHOWSTOR" which uses '?' to bulk change memory). Some routines
   change PF1 to 'HELPxxxx' to permit PF help.
   Suggest try '?' first and if that fails then try PF1.  The '?' holds
   true for initial command parameter, eg. "TSO SHOWSTOR ?".
 - The '$*' routines are used extensively to initialise/set site
   defaults.  If you port a routine to a new site and it 'works', that
   doesn't mean that all subroutines are present as many routines trap
   syntax errors for missing routines and set defaults.  Check the
   packaging details in each command member.  Stand alone routine's
   site customisation parameters tend to finish in a $ (*$).

 - The ALLIN1 dataset contains customised IBM panels. You can:
     1. Delete them (and loose certain command functionality as they
        are often customised to pass values on).
     2. Concatenate the 'ALLIN1' dataset at the end of the ISPPLIB
        concatenation (and loose certain command functionality).
     3. When ISPF is updated, take a copy of respective members into
        ALLIN1 and execute macro "IBMPCUST" against it (and retain all
        functionality).
 - All load modules are supplied in executable format.

   If processing a '*.ALLIN1' packaging:            The source is also
   supplied and can be extracted using the same principle as gen'ing
   the executables. (The source is in member "#AI1SRCE".)
   "#AI1LOAD" is an member containing a sequential XMITted file of the
   TERSED copy of the executable load modules dataset.
   In English to gen the executables:
     - Receive the member,
          TSO RECEIVE INDA('usrid.SUBSET1.ALLIN1(#AI1LOAD)')
     - Refer below at details of "ANY1" to get the SUBSET1.ALLIN1
       alloacted to the ISPF DDnames.  Execute in native TSO (READY
       prompt). Note, Initially SUBSET1.LOADLIB will not be found
       and will not try to be allocated to ISPLLIB by "REAL".
     - Under ISPF 3.4 against the received into dataset from above,
          TTL / /L
       This will unterse the dataset into a RECFM=U laodlib with
       '.UNTERSED' appended to it.
     - Rename that '.UNTERSED' dataset to
          'userid.ALLIN1.LOADLIB'
     - Modify member "ANY1" if the loadlib is not using recommended
       names.  Re-execute "ANY1" in native TSO.
   If you need the source use the above method against member
   "#AI1SRCE".
 - There are many redundant members in this dataset.  After 20 years of
   building, it would take too long to examine each member and I would
   rather ship obsolete/redundant members than miss that crucial one.
 - Wade through the $$$INDEX (if LINEMAC is active it should be easy
   using a "VM" (View Member) line command) and maybe read the comments
   and you may see alternative uses for some routines/subroutines.
   Most members are either self documented or process another member
   when a '?' parameter is passed.
   For the "infrastructure dataset", the type of member is identified by
   one of the following in column 12,
      ª$$$INDEX ªx) Read me splurge
   where 'x' idsentifies the member as normally residing in a dataset
   with the following 'llq':
      A - ASM
      C - CLIST
      D - DOCO/DATA
      I - ISPPLIB.IBM (customised IBM panels)
      J - JCL.CNTL
      H - ISPPLIB.TUTORIAL (help panels)
      L - LOADLIB (load module XMITed as 80 byte length member)
      M - ISPMLIB
      P - ISPPLIB
      R - REXX
      S - ISPSLIB
      T - ISPTLIB
   lower case implies it is non-executable directly out of the dataset.
 - Source and executable load modules are supplied in XMITted TERSED
   format.
   In English that means the original PDS was tersed using the Terse
   Toggler facility. Use member "TTL /L" (with the '/L' parameter)
   against member "#AI1LOAD" to un-terse it.
 - Disclaimer:
   . Some of the routines may be redundant if you know your environment
     and conversant with it's "standards".
     A lot of them were written while I was contracting and had a number
     of short contracts where I was not familiar with the site and
     needed to find things manually (often without help).
   . A number of routines front end onto ISPFALOC and SHOWSTOR which
     were developed long before the birth of ISRDDN and TASID.  I am
     slowly phasing in the replacements where they will do all that
     ISPFALOC and SHOWSTOR provide.

 The following is my recommended order of interest.
 Note: This is just a recommendation and subject to the current
       audience.  For example, the on-line SDSF held output disassembler
       may not be much chop for people not familiar with the IBM
       assembler and "PM" would be little use to someone without access
       to 'SYS1.PARMLIB'.
 (Below all this summary is an alphabetic list with brief descriptions.)


 00. MARK. Mark location in REXX program.
 01. ANY1. Notes on ISPF allocation.
 60. REAL.
 02. $ALK* members (customise for your site).
 03. $* members (handy callable functions not covered by REXX).
 04. $BR (browse output).
 06. $DATEMAN.
 08. $HELPME.
 09. $JCLDD.
 10. $PARMS.
 12. $WILD.
 54. LINEMAC.
 76. XB.
 36. EM.
 53. KM.
 49. INDEX (for both RECFM=F and RECFM=U).
 05. Notes on $$$INDEX.
 68. TTL.
 61. RECV.
 74. VR.
 75. VS.
 73. VC.
 58. ONLY.
 65. SNAP.
 77. XD.
 39. EXP.
 48. IMP.
 19. BU.
 15. BD.
 66. SYMSUB.
 35. DSNE.
 23. CONC.
 42. FP.
 38. EXECIOVS.
 72. VB.
 70. VA.
 37. ENQINFO (system enqueues).
 33. DS (DASDSPCE clone).
 57. MM (Member manager).
 55. LMD.
 28. DATE.
 29. DATEANY.
 62. SHOWSTOR.
 64. SLM.
 34. DSECT.
 31. DISASM.
 32. DISASMDO.
 41. FLIPH.
 44. GETSINFO.
 50. ISPFALOC.
 46. HOLDDATA.
 67. TRIM.
 56. LOGR.
 59. PM.
 79. WAIT4.
 14. BATCHISP.
 40. EXT.
 69. UMODEL.
 45. HELPDRVR.
 30. DELALLM.
 43. FX.
 51. JF.
 11. $WHOAMIC.
 47. IBMPCUST.
 78. XE.
 21. CALC.
 13. ASN.
 17. BIG.
 52. JOHNY.
 07. $CUSTOM (being developed).

Not to neglect the CICS contingency.
------------------------------------
 26. CSDL (CICS).
 27. C3 (CICS).
 25. CSDC (CICS).
 24. CSDA (CICS).
 16. BFI (CICS).
 18. BTI (CICS).
 20. CDI (CICS).
 22. CDP (CICS).
 63. SITO (CICS).
 71. VAPF (CICS).

            ******************************

 00. MARK.
 ~~~~~~~~~
 This should have been named '$MARK' as most of my routines use it to
 'mark' lines in the REXX routine for internal processing.  However,
 never got-a-round-toit.

            ******************************

 01. ANY1. Notes on ISPF allocation.
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Explicitly execute member "ANY1" in native TSO (READY prompt) to
 allocate the infrastructure dataset it is executed from to the
 respective panel, skeleton and message libraries and
 'userid.SUBSET1.LOADLIB' to ISPLLIB using default values.
 "ANY1" uses generic alloctor "REAL" to allocate the datasets defined
 instream within itself.
 You can take a sneak preview of the "REAL" tutorial, before "$BR" is
 accessible through the concatenations, by entering the following under
 ISPF option 6:
     EX 'userid.SUBSET1.ALLIN1($BR)' 'REAL ?'

 02. $ALK* members (customise for your site).
 ~~~~~~~~~~~~~~~~~~
 Analyse all the $ALK* members and customise them to site defaults.
 These members are used by a majority of members in this dataset to set
 default values.  By changing these members you minimise site
 customisation.

 03. $* members (handy callable functions not covered by REXX).
 ~~~~~~~~~~~~~~~
 Comprise of:-
  1. Generic routines used by other members.
  2. Samples, notes, hints.

 04. $BR (browse output).
 ~~~~~~~~~~~~~~~~~~~~~~~~
 $BR will trap the output from any 'PUTLINE' command using the OUTTRAP
 command and present it under browser.  Suggest adding it to your
 command table (without the "$") and substitute that command for TSO to
 browse those help screens without the dreaded red screen display.  Has
 option to edit or view output.  Can process stacked ACF2 commands.
 Eg.   BR HELP ALLOC      (instead of TSO HELP ALLOC)
 Note: Called $BR as many sites use the "BR" command to browse a dataset
       using a command and is supplied in the default command table.

 05. Notes on $$$INDEX.
 ~~~~~~~~~~~~~~~~~~~~~~
 One line per member index maintained by the INDEX command. For ALLIN1,
 the following are the identifier codes.
 The '|x)' identifies the member as follows:
   R) - REXX.
   C) - CLIST
   P) - Panel.
   I) - ISPPLIB.IBM (customised IBM panels)
   S) - Skeleton.
   M) - Message.
   T) - Tables (though usually kept in it's own dataset as tables are
        usually non-transportable).
   a) - Assembler source
   d) - Non-executable data. (templates, copy-book, instructions.
   l) - Non-executable XMITed loadmodule.
   j) - JCL (often with smarts).
 For further details, refer to INDEX command.

 06. $DATEMAN.
 ~~~~~~~~~~~~
 Extension to the REXX "DATE" command.  Has miriad of options including
 dynamic calendar generation.
 Predominantly European format, but, has been conveniently 'Yankised'.

 07. $CUSTOM (being developed).
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Execute $CUSTOM as an edit macro out of it's home dataset (while
 editing it) after site customising variables at the indicated
 places.

 08. $HELPME.
 ~~~~~~~~~~~~
 This is only included to demonstrate use of inbuilt self-generating
 tutorials.  Includes onthe fly customisable smarts.
 Enter "TSO $HELPME ?" to get a feel of it's function.
 *** No it wasn't written just for you....

 09. $JCLDD.
 ~~~~~~~~~~~
 Returns the full DD value of JCL from the line number passed.  Will
 parse both backwards and forwards to build the full value of the DD
 encompasing the line number.  Any "//*" comments will be ignored as
 will line comments be.

 10. $PARMS.
 ~~~~~~~~~~~
 This is only a copy-book (template), but it is included here as it is
 a good generic keyword parser for REXX parameters.

 11. $WHOAMIC.
 ~~~~~~~~~~~~~
 $WHOAMI is a REXX routine that extracts the users name from the ACEE
 control block and is passed to routines to make the interface more
 user friendly (rather than saying 'HELLO userid.').
 $WHOAMIC customises all REXX programs that use an instream copy of
 generic routine $WHOAMI to ensure it identifies users to site
 standards.  Enter 'TSO $WHOAMIC ?' on any command line or '$WHOAMIC ?'
 in any view/edit session to get help on it's use.

 12. $WILD.
 ~~~~~~~~~~
 Function to check each word in a list against a mask. The list can be:
   - List of dataset names
   - List of member names
   - String of text/code etc.


 13. ASN.
 ~~~~~~~~
 Address Space Navigation.  Surf another address space's memory using
 "SHOWSTOR" (see below).

 14. BATCHISP.
 ~~~~~~~~~~~~~
 Generates JCL to run ISPF in batch.  It will scan your on-line
 concatenations and work out what your site names are for the required
 batch ISPF environment.

 15. BD.
 ~~~~~~~
 Back down member from a "BU"d operation. BD/BU allow you to set back
 up templates, quick edit of backup members etc.

 16. BFI (CICS).
 ~~~~~~~~~~~~~~~
 Generate BMS maps from ISPF panels. Design an ISPF panel, test it
 using option 7 and then convert it to BMS map.  Has option for
 generating 32 byte COBOL field names. Fairly comprehensive help
 available.

 17. BIG.
 ~~~~~~~~
 Generates large 14 point capital text (limit or LRECL).  Stops managers
 from nagging staff when they write large messages for those imbeciles
 that have not mastered the art of perusal.
 eg.

    I HAVE TOLD YOU......

          RRRRRRRRRRR   TTTTTTTTTTTT  FFFFFFFFFFFF  MM        MM
          RRRRRRRRRRRR  TTTTTTTTTTTT  FFFFFFFFFFFF  MMM      MMM
          RR        RR       TT       FF            MMMM    MMMM
          RR        RR       TT       FF            MM MM  MM MM
          RR        RR       TT       FF            MM   MMM  MM
          RRRRRRRRRRRR       TT       FFFFFFFF      MM    M   MM
          RRRRRRRRRRR        TT       FFFFFFFF      MM        MM
          RR    RR           TT       FF            MM        MM
          RR     RR          TT       FF            MM        MM
          RR      RR         TT       FF            MM        MM
          RR       RR        TT       FF            MM        MM
          RR        RR       TT       FF            MM        MM


 18. BTI (CICS).
 ~~~~~~~~~~~~~~~
 Converse of BFI, whereby you can convert a BMS map to an ISPF panel,
 test it and convert it back to a BMS map. map.  Has option for
 generating 32 byte COBOL field names.

 19. BU.
 ~~~~~~~
 Converse of the "BD" command where this is used to do a quick
 backup of members.

 20. CDI (CICS).
 ~~~~~~~~~~~~~~~
 Generate an Inventory of CICS transaction dumps in a CICS dump dataset.
 The SDSF output (under view) will be used to selectively print
 individual dumps from a table display.

 21. CALC.
 ~~~~~~~~~
 Calculator.  Can be used from the command line or evaluate an
 expression on a line.  Will handle square roots and has a Pi
 representation for all your circular calculations.

 22. CDP (CICS).
 ~~~~~~~~~~~~~~~
 Under edit/view of output from the "CDI" process, all the dumps will
 be presented in an ISPF table for user selection.  Provides hooks to
 keep track of abends investigated.

 23. CONC.
 ~~~~~~~~~
 Concatenates datasets allocated to a DDname (while viewing JCL) and
 present them under ISPFALOC (if available otherwise ISRDDN) for
 whatever your desire is.

 24. CSDA (CICS).
 ~~~~~~~~~~~~~~~~
 CSD analysis. When viewing a LIST (not OBJECT) of a CSD dataset,
 You can inquire on entities (wildcarded) that will present some of
 the more important fields that may affect performance.  This feature
 permits customised detail listings for wildcarded entities in a more
 readable format than the extensive "LIST OBJECTS" output.  It will
 also detail all the list(s) the owning group(s) of the entity belong
 to.

 25. CSDC (CICS).
 ~~~~~~~~~~~~~~~~
 Display all the changes made to a CICS CSD since a particular date.
 You can use the output to generate CSD define statements for
 "importing" selected changes into a different CSD (without copying the
 entire group and then customising it. Has an interface to 'CSDA' to
 generate define statements from output of CSDA analysis.

 26. CSDL (CICS).
 ~~~~~~~~~~~~~~~~
 Generate JCL to print of a CSD listed under ISPF 3.4.

 27. C3 (CICS).
 ~~~~~~~~~~~~~~
 Cics 3rd party audit.
 Macro to process CICS startup JCL and attempt the following:
   - Chain through the JCL and SYSIN data and report on some of the
     more important SIT override variables. Will display value of
     '??' if the parameter is not found in overrides.
     Notes:
       - SIT of '??' probably means the IBM default SIT '$$' is in
         use.
       - May need to manually check the SIT table (source).
   - identify use of products by locating predefined dataset in a
     matrix "matrix1".
     Note: Loadlibs may be defined in DFHRPL but not referenced
           (not used) in the region
   - identify 3rd. party DD alloaction to ensure product is used.

 28. DATE.
 ~~~~~~~~~
 Present this month in a formatted panel.  You can then change the
 display to many month.  Using member DATEHOL, you can add public
 holidays or private dates that will be highlighted when the month/year
 is displayed.  Routine is available to automatically generate USA and
 Australian public holidays (will not generate Easter holidats as that
 is governed by the moon or replacement holidays when they fall on a
 week end and government(s) determine that).

 29. DATEANY.
 ~~~~~~~~~~~~
 Display/create a calendar for any entered year.  Can even generate the
 year of YOUR birth (it does go back that far)...

 30. DELALLM.
 ~~~~~~~~~~~
 Delete all members of a PDS.

 31. DISASM.
 ~~~~~~~~~~~
 Online disassembler.  For further details on the disassembler, refer to
 "SHOWSTOR".

 32. DISASMDO.
 ~~~~~~~~~~~~~
 Using a 'CC' block command, disassemble output from an "formatted"
 dump output under SDSF (or exported dataset).
 For further details on the disassembler, refer to "SHOWSTOR".

 33. DS (DASDSPCE clone).
 ~~~~~~~~~~~~~~~~~~~~~~~~
 Colourised display for easy identification.
 Details can be ported into any REXX application.
 Permit calculation of total free space. Can be used for playing
 whatifs if you still have some 3380 DASD and are planning to convert
 to 3390 (yes there are still sites out there).
 Permit miscellaneous selections against the unit (if applicable).
 Eg. Browse contents of volume direct.
es
 34. DSECT.
 ~~~~~~~~~~
 Using a 'CC' block command, format DSECT output from an "formatted"
 dump output under SDSF (or exported dataset).
 For further details on the DSECT formatting, refer to "SHOWSTOR".

 35. DSNE.
 ~~~~~~~~~
 Very dated poor mans JCLCHECK.  Will perfrom basic DSName Exist
 operations on JCL being edited.  Does not support INCLUDE statements
 and somewhat sus for external procs (especially if no JCLLIB statement
 included). But if you don't have JCLCHECK, it may be better than
 nothing.

 36. EM.
 ~~~~~~~
 Edit member being browsed. Actually it Views member being browsed
 (written before view was avaialable and has not been renamed).  To
 actually edit a browsed or viewed member, pass parameter of '/E'.

 37. ENQINFO (system enqueues).
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Customised ENQ info processor written by Jan Jaeger. Customised to
 permit wildcarding within the resource qualifiers by using '*'
 for character strings or '%' for individual characters, eg.
    SYS%.*.PROCLIB*
 If permitted, can direcly browse, view and/or edit resources direct
 from screen (if EXTBVSAM available, browse VSAM datasets).

 38. EXECIOVS.
 ~~~~~~~~~~~~~
 This is a REXX I/O front end to Mark Winges VSAM processing through
 REXX program RXVSAM (available from the CBT tape, file #268).
 It works similar to EXECIO for non-VSAM files.  Member EXECIOVD is
 a fairly comprehensive tutorial that can be invoked direct using
 parameter '?' or through EXECIOVS using parameter '?'.  I have not
 packaged Mark's offering and include it for those that already use
 RXVSAM.

 39. EXP.
 ~~~~~~~~
 Export member to a 'clipboard'.  Similar in concept to the 'CUT'
 command, but has features like:
 - Export excluded or non-excluded lines only.
 - Export data with exclusion details imbedded in output.
 - Append to previous export (can tag source of data in exported
   member for subsequent identification).
 - Append to FRONT of previous export.

 40. EXT.
 ~~~~~~~~
 Extract data from a browsed dataset.  Use this command for exporting
 specific lines from a dataset too big to edit and ISPF forces a
 browse session.  Was devised before edit limits lifted from 256 bytes.

 41. FLIPH.
 ~~~~~~~~~~
 Flip Horizontally.  Swaps text around by column positions.  Needs a
 start middle and end parameter.  For 2 parameters, the end is assumed
 to be the end of record.

 42. FP.
 ~~~~~~~
 Find Panel.  Will try to find the panel you are displaying in the
 ISPPLIB concatenation.  Will not look in LIBDEF concatenations.

 43. FX.
 ~~~~~~~
 Minor enhancement to Bob Weinstein's FIXPDS program using ISPF. It is
 called SPFPDS# and will permit fast tracking to a particular deleted
 member number without all the interim screens (for those anoying
 instances where you work your way through 396 members only to find the
 one you actually wanted was number 395).  Alternative option is to
 bypass the interim same member as prompt.

 44. GETSINFO.
 ~~~~~~~~~~~~~
 Display system information (extent of detila is determined by user's
 access.

 45. HELPDRVR.
 ~~~~~~~~~~~~~
 My methodology of building up a tutorial with freeform text and then
 go in a colourise it with pretty colours using attribute control data
 below the line.  You can get as simple or as complex as you like. Can
 set up hyper-links and can easily link tutorials.
 Execute member "$HELPBI" to get a feel of what it does.  Most of the
 more colorful tutorials are presented by this facility.
 It makes use of dynamic panels and shadow variables.
 Once invoked, as it is already displaying a tutorial, to invoke the
 tutorials tutorial use the following commands:
   /QR  - Quick ref for commands.
   /TN  - Tutorial navigation.
   /TT  - Tutorial presenters tutorial.

 46. HOLDDATA.
 ~~~~~~~~~~~~~
 View a SMP/E APPLY CHECK (without any BYPASSes)
 held output (under SDSF, Flasher, IOF or
 whatever takes your fancy).  Enter HOLDDATA and get a display of all
 the hold data.  You can then selectively browse individual PTF's,
 print one (or all) end exclude what you want from the summary (eg.
 exclude oll the HOLD DOCs).  The PTF dataset will be extracted from
 the held output and plugged in when browsing PTFs.


 47. IBMPCUST.
 ~~~~~~~~~~~~~
 Note:
 Several IBM panels have been customised to:
   - Replace the 'Command ===>' prompt wit 'sysid ===>' prompt. This
     will readily identify the LPAR you are on without having to go
     back to the primary options panel.
   - Customise panels to permit control (pass through) by the 'DS'
     function and permit setting of the 'S' option under ISPF 3.4 to
     other than 'Dataset Information'.  Eg. set 'S' to View.
     Check for what panels have been packaged.  They bbegin with ISRU*.
     If they interfere, rename or delete from this dataset
          -OR-
     Heaven forbid "REAL" it from 'head' to 'tail' in "ANY1".
     Whatever you do, do not blame me if you loose full (or more)
     functionality from certain commands.

 48. IMP.
 ~~~~~~~~
 Converse of the "EXP" command.  Similar to the old "PASTE" command.
 (Few extra features to the "PASTE" command but why type 5 characters
 when 3 will do.)

 49. INDEX (for both RECFM=F and RECFM=U).
 ~~~~~~~~~
 Automatically maintain index (1 line per member) for PDS.  Add new
 members created and removes members deleted (option to just mark
 deleted members).  Index description may be extracted from specific
 location withing members if standards used (eg. description from 5th.
 line of each member.) Onus on user to keep description accuarate,
 INDEX keeps member list accurate.
 Under ISPF 3.4 you may enter INDEXU against loadlibs (RECFM=U) to
 present it's index under an edit session where you can then use the
 INDEX command to maintain the nmember.  When you exit you will have
 a legible $$$INDEX member of your load modules.
 (Have had issues with RECFM=U for later versions of z/OS.)

 50. ISPFALOC.
 ~~~~~~~~~~~~~
 Similar to ISRDDN, however, written back when Abraham was still
 teaching biology to Moses.  It has been included as some routines front
 end onto it and have not been ISRDDNised. (Used as front end to Multi-
 Procs.

 51. JF.
 ~~~~~~~
 JCL format.  Main purpose is to toggle DSN= to the end of the line
 to permit daset name change and EOL (erase end of line) without
 creaming that bloody trailing DISP= parameter.
 Will allign JCL.

 52. JOHNY.
 ~~~~~~~~~~
 A little bit of mainframe humour to demonstrate mainfame animation.

 53. KM.
 ~~~~~~~
 Kill member being browsed, viewed or edited.  For browsed members you
 must be in a display that cites the dataset name at the top left
 protected part of the screen.  In an edit/view session you may need
 to prefix it with a '>' (ie. 'KM') if defined in your command table.

 54. LINEMAC.
 ~~~~~~~~~~~~
 This warrants a topic (if not a library) by itself.  After reading
 this preamble, go to member "LMREADME".

 LINEMAC is an extension of Doug Nadels LMAC command.  The infrastucture
 permits extensive line command launching with the minimum of interface
 coding.  You can make the execution of commands as simple or complex as
 you like.  Packaged here is just the LINEMAC infrastucture and a basic
 sample of of it's use.  A lot of the commands and associated routines
 have not been included here, however, at the base of the "LMREADME" is
 a listing of all the commands I have developed and was displayed using
 the 'HELP' and 'HELPX' line commands.

 If active, enter '/' against any line and get a list of available
 commands. First to will get a command entry selection panel (take
 default entries) for a list of available commands.
 Note: Not all commands may be applicable to your sected line(s),
       eg. edit members of a VSAM dataset.

 For further details in developing your own commands, once launched,
 enter line command 'HELP+'.  If you read the preamble it's use is only
 limited by:
   a. Your imagination.
   b. Effort you are prepared to extoll.
   c. Resources/time available.

 55. LMD (aka. application programmer's demise).
 ~~~~~~~~
 Last modified date.  Can interrogate a RECFM=U loadlib and list
 members modified since a particular date.  Great to catch out those
 jerks that claim 'I have not made any chages for the last 6 months'
 but managed to slip it into production without change control and then
 blame the rest of the world for their programs/applications abending.

 This feature/facility is used by "MM" (Member Manager) when comparing
 two like loadlibs for differences/changes, (eg. load modules changed
 due to maintenance - after the fact and listings deleted).

 56. LOGR.
 ~~~~~~~~~~
 Routine to list the MVS logstreams.  Option to summarise, or generate
 bulk delete or define statements using masks. (Circa 2011, the IBM
 supplied offering had bugs.... big bugs.)
 This routine permits wildcarding.

 57. MM (Member manager).
 ~~~~~~~~~~~~~~~~~~~~~~~~
 Another white elephant like LINEMAC.  Started off as a simple concept
 and just kept on growing.
 Permits comparison of two datasets regarding changes.  Works on last
 modified date for text based PDS and link-edit date for load modules
 (LMD routine).
 For text based members you can:
   - invoke SuperC to compare members.
   - synchronise members between the two datasets one way (either way)
     or both ways.
   - Create an offload dataset off different members only.
   - regress/backout changed members.
   - delete unique members.
   - full browse edit, view members.
   - will handle uncatalogued dataset. Ideal for those alternate
     uncataloged RESVOL datasets.
   - Identify duplicate members (member names conflicts) in unlike
     datasets.
  *- Read MM's tutorial.

 58. ONLY.
 ~~~~~~~~~
 Only display occurances of a string.
 We all have our own favourites.  Extras offered by this are (by use
 of the following parameters):
   sc  - First numeric parameter will be treated as Starting Column
         for finds.
   ec  - Second numeric parameter will be treated as Ending Column
         for finds.
   sc-ec                                                            s
       - Note use of '-' seperator.  This format of Start-End Column
         is mutually exclusive with use of "sc" and/or "ec".
   /N  - Remove all DATA lines and leave only NOTE lines. See below
         for use.
   /NX - Do not exclude current display.  Use this parameter to
         overlay find combinations.
   +/& - The two parameters either side if the symbol must exits on
         the same line for it to be displayed.
   ccc - Any character string. You may pass many of these parameters
   ' c'- Quote the parameter if there are imbedded spaces. However,
         with this format spaces are discreet.

 59. PM.
 ~~~~~~~
 Parmlib Member navigation.  Display major parmlib members in use for
 IPL. Can uniquely call up current member (concatenated members).

 60. REAL.
 ~~~~~~~~~
 Short for REALLOC, however, I hate typing so it never got past "REAL"
 (except for a mention in the tutorial).
 "REAL" can be used in extensive ways to change your ISPF alloctions
 (under native TSO):
 Features:
   - Add datasets to head or tail of DD concatenations.
   - Removes duplicate datasets from concatenations.
   - Used to replace DD allocations.
   - Used to free DD allocations.
   - Parameters can be passed directly, from a dataset(member) of from
     instream out of invoking routine.
   - Used to deallocate previous allocations. (Not a 100% backout.)
   - Execute REXX commands dynamically.
   - Pass it variable data using dynamic variables.
   - Allocate/create datasets, eg. temporary ISPTLIB.
   - Stack members to allocate on an application basis.
   - Built in smarts to control different allocations based on LPAR.

 61. RECV.
 ~~~~~~~~~
 RECEIVE XMITed data.  I think it's origin is off the CBT tape, however,
 it was already extensively plagerised befor I got my plageristic hooks
 into it.
 Will receive from JES XMITtede data or from XMITted dataset passed as
 a parameter.  Will identify TERSED data and will invoke TT (Terse
 Toggler) before receiving it.  I XMIT and TERSE as you cannot
 selectively terse members.
 Has option to delete, overwrite or compress first output destination.
 Also you cannot terse PDS/Es.
 Contains a self extracting panel.

 62. SHOWSTOR.
 ~~~~~~~~~~~~~
 SHOWSTOR is a memory surfer.  Again this started as a basic program
 and just grew.
 In this case do not use '?' for help as '?' is a bulk memory change
 command that does wonders with a tempermental TSO address space and
 even worse wit an opereating system if you are in "authorised
 cross-memory mode.... NO OOPS button....)
 Use PF1 or enter command "HELPSHOW" for tutorial.
 Note: This is a large tutorial and unless pre-gen'd into an ISPF
 table it may take some time to load, build and display. (Use
 "HELPDRVR /CREATE" on edit of member "SHOWSTDH" to place copy of table
 in ISPTABL concatenated dataset.
 Features:
   - Navigate through accessible memory.
   - Map memory (MVS control blocks) using processed output of an
     DSECT's assembly listing (under SDSF). DSECT's used from
     SYS1.MACLIB and SYS1.MODGEN.  Mapped memory displays field name
     contents and scroll right will give field name description (scroll
     left to restore view)
   - Navigate using direct addressing.
   - Navigate to predefined control blocks using predefined names
     (indirect addressing).
     Eg. .ACEEUN for ACcessor Environment Element Usaer Name (and you
     can see who you are - in not in another address space).
   - Set your own navigation path and names (on the fly or read from
     dataset(member).
   - Disassemble memory on-line.  Chose from basic 370 assembler or the
     latest instruction set including vector commands.
   - Locate SVC's in memory.
   - Look at storage in other address spaces using Cross-Memory (front
     ended by the "ASN" command to selective from active tasks).
   - If entrusted (authorised) and sufficient controls in place, you can
     change storage in another address space.
     (Care as once there you can change it. Also being authorised, you
     can accidentally change MVS storage.. but you have to be trying
     and if you are abd slip . OOPS.)
   - Invoke from program (assmbler/COBOL) to navigate through program
     storage to debug or change and play whatt ifs).
   - Use to disassmble dump output under SDSF listings.
   - Load loadmodules into memory and scan program contents and
     disassemble on-line.
   - Save command strings for audit purposes, redisplay findings or
     replay commands at another time or on different memory data/address
     space.
 Related commands:
   ASN     - Look at storage in another address space using
             cross-memory (requires authorisation).
             Program XMEMSTOR must be authorised as it runs in
             supervisor state.
   SLM     - Show load module.  Invoke with parameter of
             'dataset(loadmod)' will load module into memory and
             pass entry point to SHOWSTOR and display that part of
             memory.

 63. SITO (CICS).
 ~~~~~~~~~~~~~~~~
 SIT Override comparison.  This routine will analyse the editted member
 with any other SIT or SIT override parameter member and display the
 differences between the two. Used to synchronise upgrades and merging
 of parameter lists.

 64. SLM.
 ~~~~~~~~
 Show Load Module.  Loads executable program into memory and displays
 it using "SHOWSTOR" (see above).

 65. SNAP.
 ~~~~~~~~~
 Take a snapshot of edit/viewed sessions excluded lines status and
 reset it after a RESET command, new edit view session or different
 member.  Can accumulate a number of SNAPshots.

 66. SYMSUB.
 ~~~~~~~~~~~
 SYMbolic SUBstitution.  Will perform sumbolic substitution in JCL.
 Big deal you may say, but it will substitute in SYSIN in DDnames.
 Will substitute system symbols not defined in JCL.  Can be used to
 dynamically substitute dates and times into JCL.  Can be run in
 simulation mode (substitutes in notelines above original) or apply
 mode (original line in notelines above the replaced substituted
 line).

 67. TRIM.
 ~~~~~~~~~~
 TRim quantified unused space of dataset over allocation (as oposed to
 TOTAL release by the ISPF opt 3.4 "FREE" command).
 Command "TR" front ends to launch command "CSMDSNTR".

 68. TTL.
 ~~~~~~~~
 Terse Toggler with self extracting "TERSMAIN" Load module (use
 parameter '/L') so you don't have to have "TERSMAIN" accesability.
 Want to know more... question it..

 69. UMODEL.
 ~~~~~~~~~~~
 Macro to place notelines at the top of member being presented. The
 data to be placed can be taken from the stack (queue), dataset(member)
 or a member in the ISPSLIB concatenation (as UMODEL usually works).
 Usually used when giving last minute instructions while showing JCL
 generated under edit/view before submission.

 70. VA.
 ~~~~~~~
 Routine to generate alter statements to rename VSAM datasets (and it's
 components) in either batch or online.
 On-line can be executed in simulation or application mode.

 71. VAPF (CICS).
 ~~~~~~~~~~~~~~~~
 Verify APF list status of 'CC' blocked datasets in startup JCL.
 Used to verify APF status of //STEPLIB concatenated datasets in CICS
 startup JCL of procs.

 72. VB.
 ~~~~~~~
 VSAM Browse.  Browse VSAM dataset.  For those sites that do not have
 File-Aid or such or you want to sneak in a VSAM browse into your
 application where you want it and not where those expensive 3PP let
 you.

 73. VC.
 ~~~~~~~
 View (and edit) Cancel.   Cancel out of the view session without being
 prompted with member changed under view message.

 74. VR.
 ~~~~~~~
 View (and edit) Restore.  Restore member from original copy.  Saves the
 "COPY member" after deleting all lines.  Will try to reposition you to
 your original place in member and take a snap befor restoration and
 reapply the snap after restoration.  For further details refer to the
 "SNAP" command.

 75. VS.
 ~~~~~~~
 View (and edit) Save.  Saves a changed view member without the invalid
 save in view message. Pass parameter of '/X' to the "VS" command to
 exit view session after the save.

 76. XB.
 ~~~~~~~
 eXternal Browse. Browse (or view/edit) dataset on line the cursor is
 on in any screen (even held output in SDSF).
 Can be viewed, edited or browsed data.  Will parse the line cursor is
 on and attempt to extract a valid dataset name (closest to the cursor).
 Routine used by LINEMAC commands to return dataset name for subsequent
 processing.

 77. XD.
 ~~~~~~~
 eXclude Duplicates.  Exclude exact matched duplicated strings (column
 delimided).
 Features (options):
   sc   - Starting column. Default is col 1.
   ec   - Ending column. Default is LRECL.
   sc-ec
        - Start-end column range.
   /C   - Contiguous lines only. Only exclude if matches previous line.
   /D   - Delete all duplicated lines (and original if '/O' used).
   /IS(string)
        - Ignore string. Ignores duplication if string is found in the
          compare columns.
   /K   - Back up member being edited using macro 'BU /P #'.
   /MS  - Exclude duplicates that match selected lines.
   /O   - Eclude original line as well as duplicates.

 78. XE.
 ~~~~~~~
 eXternal Edit.  Similar to the old easy edit off the CBT back in the
 SP days.  This works on an alias (as well as a number) associated
 with a dataset.  The alias is easier to remember.
 While XE packaged here has limited options, under full packaging it
 interfaces with Multi-Procs which has about 90 different dataset
 processing commands.
 It is included as some of the "LINEMAC" and "XB" commands interface to
 it.

 79. WAIT4.
 ~~~~~~~~~~
 Wait for a predetermined duration.  It calls an assembler program
 (with appropriate parameters) that issues a STIMER thereby not taking
 up precious cycles as many WAIT commands do by looping.


