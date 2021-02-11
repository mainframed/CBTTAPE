
## $DOC.txt
```


 The standard copyright applies to all members submitted.

   ALTHOUGH THESE PROGRAMS HAVE BEEN TESTED AND ARE IN USE IN A
   PRODUCTION ENVIRONMENT, NO GUARANTEE IS MADE OF, OR
   RESPONSIBILITY ASSUMED FOR, CORRECT OR RELIABLE OPERATION.
   THE USE OF THESE PROGRAMS, OR RESULTS THEREOF, IS ENTIRELY
   AT THE RISK OF THE USER.

   THESE PROGRAMS ARE DONATED TO THE PUBLIC DOMAIN AND MAY
   BE FREELY COPIED. THEY MAY BE FREELY DISTRIBUTED TO ANY
   OTHER PARTY ON CONDITION THAT NO INDUCEMENT BEYOND
   REASONABLE HANDLING COSTS BE OFFERED OR ACCEPTED FOR
   SUCH DISTRIBUTION.

   THE AUTHOR DOES ASK THAT YOU LEAVE HIS NAME IN THE FILES
   AND GIVE CREDIT TO HIM AS THE ORIGINAL PROGRAMMER.


  ------------------------------------------------------------------

  NEWWAIT is used throughout these utilities and is located
  on CBT file 270.

  Note that most of the date format symbolic or 'keyword' names
  are the same throughout the different programs.
  Most of these systems draw upon multiple utilities to
  complete their tasks.  Many of the programs rely on the
  date offset system to process dates.

  EXAMPLE:
    You have a report that you pull into a file every day.
    The pull process sometimes results in an empty file,
    or yesterdays file (instead of todays).
    You use CHNGFILE to search for a date in the file and
    set a condition code of 0004 if the date is not found
    (condition code 0000 means you have todays file).

    What if the job is delayed and runs 5 minutes past midnight?
    How will your process know to use yesterdays date
    (ie: processing date), rather than todays?

    since CHNGFILE works with the OFFSET processing system,
    this will be properly handled.


  Although it is the use of call programs that make these
  systems powerful, it also makes implementation more difficult.

  ------------------------------------------------------------------

  Overview
  --------

!!  NEW (as of 2019) items added to tape:

  COBNEAT      depending on selection parms:
               Clean up cobol programs, alter comments to lower case
               Format IF statements with clean indenting
               Align "TO" statements, "VALUE" statements, "PIC" etc
               Renumber 01 level working storage field groups
               Renumber cobol paragraph names
               Use with CHNGCASE to upgrade your Cobol experience :)
               Associated items: COBNEAT1   input parm
                                 COBNRUN    jcl
                                 COBNOTE    documentation

  JCLSPLT      split long JCL lines into separate lines, leaving
               room on the right for documentation
               Associated items: JCLSPLT1   input parm
                                 JCLSRUN    jcl
                                 JCLNOTE    documentation

  JCLNEAT      use in conjunction with JCLSPLT
               depending on selection parms:
               Clean up JCL procs/jobs, alter comments to lower case
               Rename/renumber proc step names and job step names
               Swap DISP=SHR and DSN= so DISP=SHR occurs first
               (NOTE: also see Carl Hafner  CBT tape #357 member DISPDSN
                which also does this swapping)
               Add file disposition note at end of JCL line:
                   shr, old, new, del, mod
               Associated items: JCLNEAT1   input parm
                                 JCLNRUN    jcl
                                 JCLNOTE    documentation

  X12SHOW      Loop through X12 and generate descriptions for all fields
               Associated items: X12SRUN    jcl
                                 X12INPUT   X12 field descriptions
                                 X12FILE    simple X12 input file


  XLT04650     Allow replacing or removing strings within lrecl 32700
               variable length records.  Also can zap trailing spaces
               from files prior to FTP - helps with EDI scenarios where
               trailing spaces flummox the EDI engine.
               Associated items: X04650     jcl
                                 X04650P    input parm

  MIS0655B     Batch job waits for:  CICS to be up
                                     time of day
                                     string to exist in file
                                     another job to finish

  MIS0700B     Force a gap between batch job runs

  MHP0775B     Purge records from standard-record-length files

  STV0150B     Center a 79 byte field (generally for report headings)

  STV0270B     Center a 40 byte field (generally for report headings)

  XLT04660     zap pages for a group from report when totals are
               zero or blank.  specify search criteria and total field
               format.  zap all pages for group or just pages with
               zero totals.  see X04660D.

  FTPGDG       discussion and example of FTPing files to mainframe

  ------------------------------------------------------------------

  Originally on CBT 488 - some items updated as of 2019:

  - STV0400B   Y2K compliant date conversion routine with an 80/20
               sliding window
               This is called by almost all the other programs listed
               and can generate the following:

               '+00134'      '19980731  '   days future
               '-00023'      '19980224  '   days past
               'I00134'      '15380000  '   increment # minutes
                                    '--> ## nbr days calc'd past
               'D00023'      '13010000  '   decrement # minutes
               'AGE   '      '0450210   '   YYYMMDD
               'CDDEY2'      '1996366   '   EOY - CYDDD - past
               'CDDE02'      '1998031   '   EOM - CYDDD - past
               'CDD002'      '1998076   '   CYDDD minus 2 days
               'CDFEY2'      '2000366   '   EOY - CYDDD - future
               'CDFE02'      '1998151   '   EOM - CYDDD - future
               'CDF002'      '1998080   '   CYDDD plus 2 days
               'CMDEY2'      '19961231  '   EOY - CYMD - past
               'CMDE02'      '19980131  '   EOM - CYMD - past
               'CMDX  '      '19980319  '   CYMD
               'CMD002'      '19980317  '   CYMD minus 2 days
               'CMFEY2'      '20001231  '   EOY - CYMD - future
               'CMFE02'      '19980531  '   EOM - CYMD - future
               'CMF002'      '19980321  '   CYMD plus 2 days
               'CY    '      '1998      '
               'CY/DDD'      '1998/078  '
               'CY/M/D'      '1998/03/19'
               'CYDDD '      '1998078   '
               'CYDX  '      '1998      '
               'CYD002'      '1996      '   CY minus 2 years
               'CYF002'      '2000      '   CY plus 2 years
               'CYMD  '      '19980319  '
               'D     '      '19        '
               'DAY   '      'THURSDAY 4'   MON=1...SUN=7
               'DAYS  '      '00034     '   CURR - IN-DATE
               'DDD   '      '078       '
               'HMM   '      '1324      '   MILITARY TIME
               'HMSM  '      '132400    '   MILITARY TIME
               'HMSM8 '      '13240012  '   MILITARY TIME
               'H:MM  '      '13:24     '   MILITARY TIME
               'H:M:SM'      '13:24:00  '   MILITARY TIME
               'HMP   '      '0124PM    '   STANDARD TIME
               'HMSP  '      '012400PM  '   STANDARD TIME
               'H:M P '      '01:24 PM  '   STANDARD TIME
               'H:MP  '      '01:24PM   '   STANDARD TIME
               'H:M:SP'      '01:24:00PM'   STANDARD TIME
               'KEY   '      '19980319  '   = 30019681
               'M     '      '03        '
               'M/D   '      '03/19     '
               'M/D/CY'      '03/19/1998'
               'M/D/Y '      '03/19/98  '
               'MD    '      '0319      '
               'MDCY  '      '03191998  '
               'MDY   '      '031998    '
               'MIN   '      '001440    '  # MINUTES BETWEEN TIMES
               'MIN - note: time can be passed as HHMMSS## where
                            ## = number days in past (or future
                            if valueing DATA2) if input is 'HMSM  '
               'MMM   '      'MAR       '
               'MMMCY '      'MAR1998   '
               'MMMD  '      'MAR19     '
               'MMMYD '      'MAR9819   '
               'MONTH '      'MARCH     '
               'MYDEY2'      '123196    '   EOY - MDY - past
               'MYDE03'      '123197    '   EOM - MDY - past
               'MYD002'      '031798    '   MDY minus 2 days
               'MYFEY2'      '123100    '   EOY - MDY - future
               'MYFE03'      '063098    '   EOM - MDY - future
               'MYF002'      '032198    '   MDY plus 2 days
               'QTR   '      '1         '   1/2/3/4
               'SUFFIX'      'MARCH     '   IN=' 1ST'  OUT='1998'
               'Y     '      '98        '
               'YDDEY2'      '96366     '   EOY - YDDD - past
               'YDDE03'      '97365     '   EOM - YDDD - past
               'YDD002'      '98076     '   YDDD minus 2 days
               'YDFEY2'      '00366     '   EOY - YDDD - future
               'YDFE03'      '98181     '   EOM - YDDD - future
               'YDF002'      '98080     '   YDDD plus 2 days
               'YMDEY2'      '961231    '   EOY - YMD - past
               'YMDE03'      '971231    '   EOM - YMD - past
               'YMD002'      '980317    '   YMD minus 2 days
               'YMFEY2'      '001231    '   EOY - YMD - future
               'YMFE03'      '980630    '   EOM - YMD - future
               'YMF002'      '980321    '   YMD plus 2 days
               'Y/DDD '      '98/078    '
               'Y/M/D '      '98/03/19  '
               'YDDD  '      '98078     '
               'YMD   '      '980319    '

               The above conversions can be tested dynamically
               using CICS programs - See $INDEX.  This allows
               you to test all your batch calls online.
               See STVDOCU

  ------------------------------------------------------------------

  SYMBOLICS    Date symbolics in JCL can be set using these
               utilities.  Coordinated with OFFSET processing so
               the dates reflect processing date as well as
               current date.
               Basically, to use this, schedule a job ahead of each
               of your current jobs that use date symbolics, to
               update the symbolic dynamically right before it runs.

  - MIS0425B   place dates/other data at a specified location
               in a static parm.  mostly replaced by CHNGFILE which
               provides more flexible date manipulations.

  - MIS0500B   change symbolics in jcl

               OFFX=        Reflects offset processing  Y or N

               EOMDATE=     mm/dd/yy  previous end of month
               CURDATE=     mm/dd/yy  current date
               CURREOM=     mm/dd/yy  current end of month
               YESTDAY=     mm/dd/yy  yesterday
               EOYDATE=     mm/dd/yy  previous end of year
               PREVMON=     mmmccyy   month and year 1 month ago
               LASTMON=     mmmccyy   month and year 2 months ago

               CYDX=        current ccyy
               CYD###=      prev ccyy
               CYF###=      future ccyy

               QTRX=        1, 2, 3, or 4

               CMDX=        current ccyymmdd
               CMD###=      prev ccyymmdd
               CMDE##=      prev eom ccyymmdd
               CMDEY#=      prev eoy ccyymmdd
               CMF###=      future ccyymmdd
               CMFE##=      future eom ccyymmdd
               CMFEY#=      future eoy ccyymmdd
               CDDX=        current ccyyddd
               CDD###=      prev ccyyddd
               CDDE##=      prev eom ccyyddd
               CDDEY#=      prev eoy ccyyddd
               CDF###=      future ccyyddd
               CDFE##=      future eom ccyyddd
               CDFEY#=      future eoy ccyyddd

               YMDX=        current yymmdd
               YMD###=      prev yymmdd
               YMDE##=      prev eom yymmdd
               YMDEY#=      prev eoy yymmdd
               YMF###=      future yymmdd
               YMFE##=      future eom yymmdd
               YMFEY#=      future eoy yymmdd
               YDDX=        current yyddd
               YDD###=      prev yyddd
               YDDE##=      prev eom yyddd
               YDDEY#=      prev eoy yyddd
               YDF###=      future yyddd
               YDFE##=      future eom yyddd
               YDFEY#=      future eoy yyddd

               Note: To obtain current eom or eoy, pass zero for the
                     numeric value

               DAYX=        nbr days between current date and
                            Y--### or C--###
               DAYM=        nbr days between current date and
                            Y--E## or C--E##
               DAYY=        nbr days between current date and
                            Y--EY# or C--EY#

               RUNX=        2 digit sequential counter
               HMSX=        hhmms

               Reflects the offset processing switch passed in the
                 programs parm

  ------------------------------------------------------------------

  COUNT PIC DEFINITIONS

  - JCI0049B   count PIC X clauses and give a total.  useful for
               maintaining print programs or developing new programs.
               - skips redefining fields
               - handles occurs clauses

  ------------------------------------------------------------------

  OFFSET       OFFSET processing allows batch processing,
               pulling 'current date', to continue pulling the
               correct date when batch is late and runs past
               midnight.  Allows a single manual date change to be
               reflected across the board for participating batch
               applications.  Date may be altered 99599 days forward
               or backward.
               See OFFSET1 and OFFSET2

  ------------------------------------------------------------------

  CHNGFILE     Works with STV0400B to provide string find-and-replace,
               and date/time aging and format alteration.
               Allows for changes only when strings are found
               on multiple records.  jcl SPACE= replacements.
               I combine this with PULLFILE to do many different
               tasks involving string and date and condition code
               manipulation.
               Deceptively powerful.

  - CHNGFILE

    via batch, will allow you to replace strings in pds members or
    10-9999 byte files with other data, and optionally insert data
    (ie: add or remove spaces so the data to the right of the string
    stays positionally stable) similar to the SCAN and REPLACE
    function of CA-EZYEDIT.

    Data from the search record may be used as replace data.

    The move/replace may occur either at the same location the search
    data was found, or at a specified location, or at a location
    relative to the found location (+ or -).  A replace position in all
    rcds may be specified, bypassing the string search, to allow data
    movement/replacement for all records.

    The program will also search for a string, and if found, generate
    a specified return-code (condition-code) for use in procs.
    return code may also be dependent on a certain day of the week or
    month.  a default return-code may be set so that a specified code
    is set if a string is NOT found.

    Numeric fields may be altered via math statements
    (ie: add 200 to all numerics in column 12).
    Date fields in multiple formats may be altered x days past
    or future, or to a different format,
    ie: convert YMD to CYMD and increment 2 years ahead.
    The 'to' format is anything usable by stv0400b.
    partially numeric fields (   4) may be converted to numeric (0004).
    the numeric sum for a column of data can be calculated
    (w/wo string search).

    Time formats may be changed, and times may be
    incremented/decremented by x nbr of minutes.

    Reflects the offset processing switch passed in the programs parm

    Note: If compiling CHNGFILE for 80 byte records,
          Alter CHNGCPY2 prior to the compile and change the
            output load module name to CHNG0080.

          I setup a separate compiler that plugs values into
            CHNGCPY2 (using MIS0425B) so the following
            modules are produced:
            CHNG0080  CHNG0081  CHNG0121  CHNG0132  CHNG0133
            CHNG0300

  ------------------------------------------------------------------

  PULLFILE     Pull records or partial strings from files at
               relative locations.
               Change portions to upper/lowercase.

  - PULLFILE

    see PULLDOCU for documentation and examples

    NOTE:  Because PULLFILE has the ability to loop through an
           input file twice, it allows you to specify to start
           pulling records PRIOR to a found string, and to stop
           pulling PRIOR to an end string.  ie:  when a particular
           ledger is found on a report, pull that page's headers
           (assuming the ledger prints a bit further down on the
           page) and continue pulling until the next ledger is found -
           but exclude that page's headers.

    Search for a string in any fixed length file and, when found, pull
    that record or a portion of that record, plus all or a specified
    number of subsequent records (ie: only pull those selected).
    (xsi = blank).

    Also allows for pulling all records except those specified
    (ie: pull all except those excluded). (xsi = X and I).

    Also allows for pulling all records until a specified string
    is found (ie: pull all until string found).  The ending string
    may be included or excluded.
    (xsi = I and S).

    Also allows for pulling records from one found string to
    another found string.
    The ending string may be included or excluded. (xsi = blank and S).

    Combinations of the above may be coded, within the operating rules.

    example:
        exclude record with string AAA      (xsi = X)
        exclude record with string BBB      (xsi = X)
        Include all other records           (xsi = I)
        until record with string CCC found  (xsi = S)

    After string is found, start and end positions for output
    may be determined by:
    1) specifying a fixed position
    2) searching for a delimiting string, position based on
       found position, or a number +/- to found position,
       and allow include or exclude of found string
    3) a position relative to the starting or ending position

    Allows insertion of a counter or specified title or
    specified number of spaces in front of the output record.

    Pull if a string at a location is numeric.

    Convert all or portions of pulled data to upper or lowercase.

  ------------------------------------------------------------------

  DFSMShsm     System to condense the active logs into a single file
               with automatic expiration of records.
               An idcams list of log files is dynamically
               concatentated into jcl, which is then submitted.
               The logs are condensed and written to a single file,
               where the records are then managed individually
               via user defined expiration criteria.
               See HSMDOCU

  ------------------------------------------------------------------

  EXTENTS      The 'high extent checking' system is a bit crude since
               it relies on IEHLIST output.  But I find it quite
               useful to track trouble datasets before they become
               an issue.  Basically, IEHLIST output from each dasd
               volume is concatentated and sorted, and extents for
               a file are summed.  The count is then compared to a
               user maintained table, and a TSO message is sent
               to specified users.  It runs against 120 3390-3 volumes
               in three minutes.
               See $INDEX

  ------------------------------------------------------------------

  SCHEDULING   Send TSO messages or set condition codes

  - MIS0685B  powerful scheduling system
              see M0685P1 and M0685P2 for input examples                es

              send TSO messages, or set condition codes, based on a
              specified schedule.

              specific or generic date:  2000 01 24 or
                                         2000 01 ** or
                                         2000 ** 24 or
                                         **** ** **

    duration of days:    match across multiple days
    repeating days:      match every ## days (ie: biweekly)
    specified day of the week: match every monday or every weekday
    specified 'occurs':  3rd tuesday and wednesday of the month
                         Last thursday of the month
                         second to last day of the month

    Adjust match day backwards or forwards, so that actual day
    (ie:  20001225) can be specified, but notification occurs
    earlier or later (20001223).

    upon a match:
      send a message:  send a tso message prefixed with mm-dd-yy
                       to up to 12 tso users
      set a cond code: CCC = set when date matches
                       CCN = set when date does not match
                       CTM = set when within specific time ranges
      abend

    Reflects the offset processing switch passed in the programs parm

  ------------------------------------------------------------------

  DSN MASKS    MIS0540B is a called program to return 'YES' or 'NO'
               if a dataset name matches a dataset mask.
               Use for PDS member names as well.
               Will perform DSN syntax checking.


  - MIS0540B   compare a dataset name to a dataset mask, return
               'yes' or 'no'.

               masks are the same type used by RMM:  * ** %
               may also be used to compare member names to a member mask
               may be used to validate dsn names.

  ------------------------------------------------------------------

  REPORT ALTERATION
               Keeps 100 lines in an internal buffer, to allow you to
               plug codes into reports (on, above, or below the search
               string) to aid in report distribution.
               We use these programs to avoid printing UB92 bills
               that have particular codes in specified locations.

  - MIS0081B   alter an 81 or 133 byte report (assuming a carriage
    MIS0133B   control byte is in pos 1):
               load 100 record buffer and search for a string.

               when found, place a specified string ON or ABOVE
               or BELOW the record where the string was found
               up to 78 records away.
               -and/or-
               when found, insert a record from another file: ABOVE or
               BELOW the record where the string was found,
               up to 78 records away.

               write report records to a separate file.

  ------------------------------------------------------------------

  - PRNTFILE  Print files in a structured format to easily locate
              an exact position in the file.  Replaces IDCAMS print.

              Places a scale bar above and below output and allows for
              spacing between output lines.
              Print only those records containing a specified search
              string, or print from a specified search string.
              Print a specified # of lines, and allow skipping
              initial # of lines.

  ------------------------------------------------------------------

  COBOL SHELLS I've used these for years to quickly throw together
               a program that is pre-formatted with highly
               reliable print logic and field edit logic.
               I much prefer this method - pre-formatted shells -
               to borrowing other peoples code to use as a base.
               see $INDEX - DOC* members

  ------------------------------------------------------------------

  - STV0530B   convert number to alpha equivalent
    STV0530T   test STV0530B
    S0530B     JCL to invoke STV0530T

  ------------------------------------------------------------------

```

