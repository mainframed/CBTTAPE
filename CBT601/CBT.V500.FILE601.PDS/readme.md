
## $GPDOC.txt
```
This version of QUEUE was modified from the 1982 MVS/370 version
shipped by Volker Bandke on his first MVS Turnkey CD.

Modifications by Greg Price of PRYCROFT SIX PTY LTD
       during June to November 2002 for MVS 3.8J.

       Updated 5th February 2003.

       Updated 7th February 2003:
CTSO changed to ensure that fullscreen mode is on after a TSO command.

       Updated 15th February 2003:
- Change screen buffer definitions in QCOMMON from DC to DS statements
  to reduce the object deck size by about 200 card images.
- Increase the static screen buffer sizes in QCOMMON (all three of them)
  in order to be able to handle screen sizes up to 9920 (like 62x160).
  For every 8 bytes of extra screen size QUEUE can handle, the size of
  the load module grows by 24 bytes.  A dynamic buffer acquistion scheme
  may well be an improvement that could be made.
- Use a NOEDIT TPUT for screen sizes larger than 4096 so that 14-bit
  buffer addresses are not translated before transmission.  Addresses >
  4095 must be sent as binary numbers, and therefore can be corrupted
  if any filtering of invalid characters takes place.  They are inserted
  into the data stream by the compression of repeated characters.  The
  compression of the data stream probably becomes more important as the
  size of the screen becomes larger.
- Reinstate the TPUT MF=L area in QCOMMON for the NOEDIT TPUT.
- Add the X operand to the MODEL command to set the current terminal's
  alternate size as the QUEUE screen size.  This is independent of the
  screen size used by TSO line-mode screen management.
- Show the Userid and the Terminal name on the top line on wide screens.
- Ensure that the correct screen size is restored after a TSO command.

       Updated 4th March 2003:
- Restore SYSOUT data display after a TSO command is issued during a
  display of SYSOUT data.
- Do not trigger a PRINT when a PREV command is issued.

       Updated 28th March 2003: add IEF702I to LNCDTABL.


Changes during 2002 include:

- Rationalisation to TPUT and TGET macros.

  Problems with some maintenance levels of TPUT and/or TGET macros
  have been circumvented by converting all TPUT and TGET macro calls
  from MF=E to inline macros (which translate to a single SVC) with
  registers being pre-loaded as required by program logic.  The MF=L
  work areas have been dispensed with.  The TTPUT and TTGET members
  have been deleted from this file.


- Addition of support for 3270 character attributes.

  A shadow buffer is maintained (in a similar fashion to ISPF
  DYNAMIC areas) to specify the character attributes (as opposed
  to field attributes) of each screen location.  The new BLD3270
  routine creates a 3270 data stream from the primary and shadow
  buffers, and calls the CB3270 routine (found on a SHARE or CBT
  tape in the 1980s and which I originally added to the Fujitsu
  port of QUEUE at the time) which has also been added with this
  upgrade to apply 3270 data stream compression.

  The new QHEAD macro, and changes to QTILT and many routines use
  the shadow buffer to specify colour and highlighting to be used
  for headings, display lines, and error messages.

  Uses of this capabiliy include showing immediate action SYSLOG
  messages in white, colour coding JMSG output, and highlighting
  active work in queue lists.  These two features are performed
  in routine LISTDS (formerly Q15).  The LNCDTABL table which has
  the attribute codes for JMSG messages must have its entries in
  collating sequence order.

  The new MONO and COLO commands can toggle the "use 3270 extended
  data stream orders to activate extended colour and highlighting"
  switch.  The switch is on in the QCOMMON source.  If a 3270 terminal
  or emulation thereof cannot handle 3270 EDS then the switch can be
  turned off in the source and QUEUE can then be reassembled.  That
  this is the actual problem can be tested by issuing 'Q MONO' from
  the READY prompt.


- Addition of support for selection codes.

  Removing the 3270 data stream from the in-storage buffer of
  the screen image under construction meant that it was simple to
  introduce internal codes to represent field attribute bytes,
  which in turn allowed new input fields to be easily created.
  Most of the status displays have now had a selection input
  field added to each item in the list.  This allows items to be
  processed by selection as opposed to being processed by a
  command where the name of the item has to be typed in.


- Jump from leader dots or "point-and-shoot".

  The "jump from leader dots" facility (as it is called in ISPF)
  is controlled by the QFLG2PNS bit in byte QFLAG2 in QCOMMON.
  When active, the 'S' selection code is implied by locating the
  cursor over an input selection field in column 2 without actually
  typing any text character into the field.  This feature is also
  called "point-and-shoot" in the source code.  As a result of this
  feature autoskip has been removed from the attribute bytes so that
  the cursor does not automatically move to the next selection field
  thereby triggering an inadvertent selection.


- Removal of need to assemble local constants.

  Previously the names of all systems present in the MAS, as well as
  the unit and volume of the checkpoint data set to be accessed had
  to be assembled from the source or zapped into the load module.
  Now, the system identifiers are read from the checkpoint data set,
  SYSALLDA is used as the unit name, and the volume is ascertained
  from the primary subsystem vector table.  Hence, local customisations
  pertaining to data set placement or system identifier names do not
  generate a need to update QUEUE to maintain accuracy or convenience.
  (The CKPT(unit,volser) operand is still allowable, but if no CKPT
  operand is supplied the currently operational checkpoint will be
  used.)


- Addition of NEXT and PREV commands.

  When a job is selected with an 'S' selection code, the job log is
  shown.  Movement to subsequent data sets can be achieved with the
  NEXT command.  'N 3' from the job log will cause SPOOL data set 101
  of the job to be displayed.  PREV provides access to data sets with
  lower data set identifiers.  I have obviously lifted this idea from
  SDSF.  Unlike SDSF, SYSIN data sets are always eligible for display.


- PF3/15 variable meaning.

  PF3/15 meant "exit QUEUE".  Whenever it does not mean that now the
  actual meaning of PF3/15 is shown on the bottom right corner of the
  screen.  These "other meanings" are an attempt to make PF3/15 cause
  a single level back-out rather than termination of the whole program.
  EXIT and END and E still mean "exit QUEUE" no matter where in QUEUE
  they are issued, but PF3/15 no longer always means END.


- HELP processing updated.

  The display of an extra blank page no longer occurs.  The extra
  commands/operands have been documented.  An extra page on selection
  codes has been added.  The fact that the only allowable selection
  code from a DD display is 'S' is not listed.  When HELP is invoked
  from the display of a SPOOL data set, PF3/15 functions as "leave
  HELP and return to the data set".


- Scrolling changes.

  The scrolling has been made more SPF-like.  A scroll amount override
  of H (half-page), P (page) or M (maximum) is now allowed.  Much of
  the code for this change was lifted from the OSIV/F4 (MSP) revamp
  carried out by Mike Holloway (MAH) of Fujitsu Australia in 1982/1983.
  (Mike's version included support for AF/JES.  Fj's JES2 was called
  JES, and their JES3 was called JESE.)

  2003-02-05  The page and half page scrolling amounts have now been
  fixed to not always be derived from a 24-line screen, but from the
  number of lines the screen currently has.


- PF8/20 fiddle.

  Scrolling is only active in QUEUE when viewing a SPOOL data set.
  Sometimes I find myself looking at a list of jobs or data sets in
  QUEUE and when I want to see the next page I press PF8 instead of
  ENTER.  To accommodate my habit PF8/20 now functions as ENTER
  whenever a SPOOL data set is not being browsed.  This avoids the
  disruption of the error message and having to restart at the
  beginning of the list.


- Initial command change.

  The default initial command is changed from HELP to STATUS.
  This is more likely to be useful on repeated usage.
  This value is set in QCOMMON and can be changed by source
  update or SUPERZAP to the CSECT.


- Display of data set identifier.

  The DSID shown in the heading line was taken from the second
  operand of the L command.  If the data set was displayed by
  another command then the DSID field would not be filled in.
  Now it is always shown from the DSID used by QUEUE to access
  the data set.


- Display of priority.

  The PRIORITY column of the STATUS display shows the JQE or job
  JES2 priority in the 1 to 15 range.  Output elements also have a
  JOE priority.  For a display with 14.4 showing, 14 is the JQE
  priority and 4 is the JOE priority.  Held SYSOUT (denoted by
  "HELD OUT" in QUEUE) has not yet had JOEs assigned to it by this
  version of JES2.  (This was later changed.)  A JOE represents
  a work element that can be processed by a printer or a punch.
  Only held SYSOUT can be processed by the TSO OUTPUT command.


- Century and day-of-the-week fixed in PRINT heading.

  The heading produced by the PRINT command had the century
  hard-coded.  Also, the day-of-the-week logic was not working
  for at least 2002, and possibly the 21st century.  The GETTIME
  routine was completely rewritten (with new Zeller's congruence
  code) to work with 20th and 21st century dates.  (This was
  deemed to be simpler than debugging the existing code.)


- New MODEL logic.

  The MODEL command screen handling logic has been redone.
  It will be interesting to see if it works when (and if)
  alternate screen size support is ever added to the free
  versions of TSO and VTAM.

  2003-02-05  Well, at least 32-line and 43-line screens worked okay.
  The largest supported screen size has been increased from Model-4
  to Model-5.  All STSIZE macros have been removed (because STSIZE
  sets the size for TSO line-mode screen management, and has little
  to do with a fullscreen application like QUEUE).  The TSO TERMINAL
  command can be used from within QUEUE via the TSO subcommand if the
  line-mode dimensions need to be changed without leaving QUEUE.

- New SPIN command.

  The CSPIN source member was pretty much copied as-is from the
  "modern" version of QUEUE (for SP5.2).  Incorrect line number
  in heading after SAVE or SPIN has been fixed.


- New SLOG default.

  SLOG (or SL) with no operands, or with an operand of SYSLOG,
  will now attempt to show the current/active SYSLOG.  The
  default is still to show the latest data set of a given
  SYSLOG job.  "SL SYSLOG 1" and "SL SYSLOG -1" are equivalent,
  and specify the second-latest data set.


- Notes about DC.

  The address spaces shown in DC are ascertained from JES2 control
  blocks.  As a result, address spaces without a JES2 job identifier
  such as JES2 itself will not be shown.  A small code change allowed
  the selection of ASID 1 (under the auspices of SYSLOG) to be
  selected.  I sought to make this change because my recollection is
  that ASID 1 was displayed.  (A subtle change by SE2, perhaps?)
  (MVS truism: CPU time consumed by paging activity will be most
  evident as SRB time of ASID 1.  Q's DC is one of the few monitors
  which shows the TCB and SRB times as separate items.)

  The operand is a 0-3 character string made up from the letters J,
  S and T to specify the address space types to be included.  No
  operand specifies the inclusion of all address spaces.  Another
  change lifted from Mike Holloway's version for MSP.

  Highlighted (ie. yellow) jobs are swapped in.  This is derived from
  the real storage usage because this level of MVS does not have
  logical swapping.  Which brings us to the most crucial change made
  to QUEUE by this series of updates:  The DC column heading has been
  corrected from SLOTS to FRAMES.


```

## $RNBDOC.txt
```
THIS DATASET WAS OBTAINED FROM FILE 322 ON VER193 OF THE CBT TAPE, AND
WAS THEN MODIFIED AT RAINIER NATIONAL BANK.

RNB00 -                - MOVED DSECTS AROUND FOR IFOX ASSEMBLER
        Q4  (DDNAME)
        Q10 (INIT)
        Q12 (JLOG)
        Q15 (LISTDS)
        Q20 (SEARCH)
        Q25 (FINDPDDB)
        Q26 (SYSOUT)
        Q33 (CPPDB)
RNB01 - Q1  (QUEUE)    - FIX TO FINAL TPUT MESSAGE TO ALLOW TO WORK WITH
                           BOTH TCAM AND VTAM
RNB02 - Q10 (INIT)     - REMOVE PART OF UF010: DON'T USE OPER AUTHORITY
                           TO SET QXAUTH. ALSO UF024: DON'T USE DBC.
RNB03 - Q10 (INIT)     - FOR RACF: IF &QRACF = 1, AND IF &QNEWUSR ISN'T
                           NULL, THEN IF APF-AUTHORIZED CHANGE THE
                           USERID IN THE ACEE SO THE USER CAN ACCESS A
                           RACF-PROTECTED SPOOL/CHECKPOINT DATA SET.
      - Q16 (PARSE)    - IF &QRACF = 1 THEN USE RACF TO CHECK AUTHORITY
                           TO USE THE XP COMMAND.
      - Q17 (READSPC)  - IF &QRACF = 1 THEN WHEN A JCT IS READ FROM THE
                           SPOOL BLANK THE PASSWORD AND NEWPASSWORD.
      - Q22 (XDS)      - IF &QRACF = 1 THEN DO A SPECIAL CHECK TO SEE IF
                           THE USER IF ALLOWED TO DO THE XDS COMMAND.
RNB04 - Q12 (JLOG)     - FIX TO ALLOW JLOG TO WORK FOR JOBS THAT ARE IN
                           EXECUTION BUT THAT HAVEN'T FINISHED THE FIRST
                           STEP. THIS WILL SHOW ONLY THE 'JOB STARTED'
                           MESSAGE.
RNB05 - Q14 (LIST)     - IF &QRNB = 1 THEN DO THE FOLLOWING:
                           (1) REMOVE THE PART OF UF005 THAT ALLOWS L TO
                               PROCESS DSID'S < 101 AND THAT ALLOWS AUTH
                               USERS TO LIST ANY JOB.  THIS REQUIRES THE
                               XD COMMAND TO BE USED TO LIST STRANGE
                               THINGS.
                           (2) ALLOW TSO USERS TO ACCESS ANY JOB THAT
                               STARTS WITH THEIR USERID OR THAT HAS A
                               NOTIFY FOR THEIR USERID. THIS WILL NOT
                               BE ALLOWED FOR USERID'S STARTING WITH
                               'PJS' DUE TO LOCAL RESTRICTIONS.
                           (3) ALLOW TSO USERS WHOSE USERID'S START WITH
                               'TEC' TO PROCESS ANY 'TEC...' JOB OR ANY
                               JOB WITH A NOTIFY FOR A TEC USER. ALSO
                               ALLOW THEM TO PROCESS OUTPUT FROM STARTED
                               TASKS.
RNB06 - Q16 (PARSE)    - ADDED THE FOLLOWING COMMAND ABBREVIATIONS FOR
                           CONSISTENCY WITH PREVIOUS VERSIONS:
                                 JC  FOR JCL
                                 JL  FOR JLOG
                                 JM  FOR JMSG
                                 SL  FOR SLOG
                                 FT  FOR FTIM
                                 DE  FOR DEL
                                 RE  FOR REQ
                         ALSO, IF &QRNB = 1, DELETE COMMANDS TSO, EXEC,
                           AND MODEL.
RNB07 - Q24 (ACTIVE)   - WHEN LISTING BATCH JOBS SAY THEY
                           ARE ON THE XEQ QUEUE INSTEAD OF THE INPUT
                           QUEUE TO BE MORE CONSISTENT WITH WHAT THE
                           OPERATORS USUALLY SEE.
RNB08 - Q26 (SYSOUT)   - IF &QRNB = 1, ALLOW USERS TO MANIPULATE JOBS
                           THAT START WITH THEIR USERID'S OR THAT HAVE
                           A NOTIFY FOR THEIR USERID, UNLESS THE USERID
                           STARTS WITH 'PJS'.
                         IF &QRNB = 1, ALLOW 'TEC' USERS TO MANIPULATE
                           ANY TEC JOB OR STARTED TASK OUTPUT.
RNB09 - Q26 (SYSOUT)   - IF &QRNB = 1, FOR A REQ OPERATION, IF A NEW
                           CLASS IS NOT GIVEN, USE CLASS C AS THE
                           DEFAULT NEW CLASS.
RNB10 - Q27 (PRINT)    - IF &QRNB = 1, USE C AS THE DEFAULT SYSOUT
                           CLASS.
RNB11 - Q4  (DDNAME)   - ALLOW DDNAME COMMAND TO BE
                           ISSUED AS   DDNAME JOBID S
                           WHERE THE S INDICATES THAT THE SPIN DATA
                           SETS SHOULD ALSO BE LISTED. THIS WAS ADDED
                           BECAUSE WE HAVE SOME LONG RUNNING BATCH JOBS
                           (IMS) THAT SPIN THINGS AND THE STANDARD Q
                           COMMAND DOESN'T SEARCH THE SPIN Q FOR BATCH
                           JOBS.
RNB12 - Q4  (DDNAME)   - IF &QSP = 1, DON'T FORMAT THE MESSAGE 'ALREADY
                           PRINTED', AS IT APPEARS THAT THE FLAG BIT
                           IN THE PDDB IS NOT USED ANY MORE, CAUSING
                           ALL SPIN DATA SETS TO APPEAR PRINTED, EVEN
                           WHEN THEY'RE NOT.
RNB13 - Q5  (DISPLAY)  - FIX SOME PROBLEMS WITH TCAM
                           AND THE PROCESSING OF THE TEST-REQUEST,
                           SYSTEM-REQUEST, AND THE PA2/PA3 KEYS.
RNB14 - Q5  (DISPLAY)  - BUG FIX FOR FULL-SCREEN PROCESSING. WITH THIS
                           FIX THE USER CAN ENTER A COMMAND IN EITHER
                           INPUT FIELD, NOT JUST THE BOTTOM ONE.
RNB15 - Q5  (DISPLAY)  - RESTORE THE PFK DEFINITIONS FOR
                           PF7/8 TO '- 27' AND '+ 27' AS ORIGINALLY
                           SUPPLIED BY THE ICBC MOD. WE DON'T HAVE
                           THE OTHER 3278 MODELS, AND SCROLLING IS
                           EASIER THIS WAY. WITH NERDC'S CHANGES TO
                           MAKE THE KEYS 'PB' AND 'PF' IT IS DIFFICULT
                           TO SCROLL UP OR DOWN A FEW LINES.
RNB16 - Q20 (SEARCH)   - PROCESS BOTH THE LOCAL AND REMOTE QUEUES FOR
                           JOBS AWAITING PRINT/PUNCH.
                         ALSO FIX A BUG IN UF020 THAT WAS CLEARING THE
                           JOEFLAG  WHEN JUST THE JOEJQE POINTER SHOULD
                           BE CLEARED.
RNB17 - Q7  (FORMAT)   - WHEN FORMATTING JOES:
                           (1) IF THE JOE IS BEING PROCESSED BY PSO,
                               INDICATE EXT-WTR FOR A DEVICE TYPE.
                           (2) USE $JOEBUSY FLAG TO INDICATE WHETHER JOB
                               IS REALLY PRINTING/PUNCHING. OTHERWISE,
                               AN INTERRUPTED JOB STILL SHOWS AS ON THE
                               PRINTER/PUNCH.
                           (3) FOR SP2, FIX A BUG IN GETTING TO THE
                               CHECKPOINT JOE AND IN COMPUTING THE LINES
                               LEFT TO PRINT/PUNCH.
                           (4) FOR SP2, IF THE JOE IS NOT ACTIVE, BUT
                               THE CHECKPOINT JOE IS VALID, SHOW THE
                               LINES LEFT, NOT THE ORIGINAL LINE COUNT.
RNB18 - Q7  (FORMAT)   - DISTINGUISH BETWEEN JOES WITH REMOTE ROUTING
                           AND THOSE WITH SPECIAL LOCAL ROUTING (DESTID
                           INITIALIZATION STATEMENT IN JES PARMS).
RNB19 - Q20 (SEARCH)   - FOR STATUS OR DJ COMMANDS IN THE SP2 VERSION,
                           ALSO SEARCH THE DUMP Q, THE CONVERSION Q,
                           AND THE OUTPUT Q. THIS ALLOWS THE USER TO
                           FIND HIS JOB IF IT'S AWAITING DUMP, AWAITING
                           CONVERSION, OR AWAITING OUTPUT PROCESSING.
      - Q7  (FORMAT)   - WHEN LISTING JQE'S, DON'T ASSUME INPUT QUEUE
                           BUT USE JQETYPE INSTEAD. ALSO, SPECIAL
                           HANDLING FOR AWAITING CONVERSION, AWAITING
                           DUMP, AND AWAITING OUTPUT.
RNB20 - Q7  (FORMAT)   - DISTINGUISH BETWEEN NORMAL HOLD, HELD VIA $HA,
                           AND DUPLICATE HOLD. ALSO, FOR JOES, IF THE
                           SELECT=NO FLAG IS ON, FLAG WITH S=N TO SHOW
                           WHY THE OUTPUT WON'T PRINT.
RNB21 - Q7  (FORMAT)   - FIX THE SETDEVIC ROUTINE FOR SP2 SO THE PROPER
                           DEVICE NAMES SHOW UP FOR JOBS ON PRINTERS,
                           ETC.
RNB22 - Q6  (FINDJOB)  - IF JOBNAME = *, AFTER READING THE JCT, ENSURE
                           THAT JQEJNAME = JCTJNAME AND THAT QPJOBID =
                           JCTJBKEY IN CASE THE JOB HAS PURGED AND THE
                           JCT HAS BEEN REUSED SINCE WE LAST READ THE
                           CHECKPOINT. THIS IS UNLIKELY, BUT SEEMS TO BE
                           POSSIBLE.
RNB23 - Q8  (HELP)     - MISCELLANEOUS CHANGES TO THE NERDC HELP INFO.
                           THE ORIGINAL NERDC VERSION IS MEMBER $Q8, AND
                           THE OLD RNB MEMBER IS #Q8.
RNB24 - Q23 (INITS)    - BUG FIX, AS SUGGESTED BY JACK SHUDEL
RNB25 - Q7  (FORMAT)   - ADD 'COUNT' OPTION TO THE HO COMMAND TO HELP
                           FIND WHICH JOBS ARE TIEING UP SPOOL SPACE.
                           WHEN THE COUNT OPTION IS USED, THE JCT FOR
                           EACH JQE WITH HELD OUTPUT WILL BE READ AND
                           THE JCT TOTAL LINE COUNT WILL BE DISPLAYED.
RNB26 - Q24 (ACTIVE)   - BUG FIX (SORT OF): THE DC COMMAND WAS SHOWING
                           A LOT OF STRANGE JOBS. THIS FIX MAKES IT MORE
                           REASONABLE, BUT IT'S STILL NOT QUITE RIGHT.
                           ALL OF THE STARTED TASKS, E.G. TCAM, DON'T
                           SHOW UP.

========================================================================
KNOWN PROBLEMS:
  (1) DC S DOESN'T SHOW ALL OF THE STARTED TASKS.
  (2) JOE PRIORITIES ARE (PROBABLY) INCORRECT, AS THE CALCULATIONS
      CHANGED FOR SP2 AND Q HASN'T BEEN UPDATED TO REFLECT THAT.
  (3) IT APPEARS THAT THE LINE COUNTS FOR JOBS ON A REMOTE PRINTER ARE
      MAINTAINED DIFFERENTLY THAT FOR JOBS ON A LOCAL PRINTER. THIS HAS
      NOT BEEN FULLY RESEARCHED YET, BUT IT SEEMS THAT THE LINE COUNT
      REPORTED BY Q FOR A JOB ON A REMOTE PRINTER IS APPROXIMATELY THE
      NUMBER OF LINES PRINTED, NOT THE NUMBER THAT REMAIN TO BE PRINTED.
  (4) ONLY 2 (POSSIBLY 3) CHARACTER REMOTE NUMBERS CAN BE USED.
  (5) NJE NODE NUMBERS ARE IGNORED.
  (6) THE NJE JOB/SYSOUT TRANSMITTERS AND RECEIVERS ARE IGNORED AS
      DEVICES AND AS QUEUES.
```

