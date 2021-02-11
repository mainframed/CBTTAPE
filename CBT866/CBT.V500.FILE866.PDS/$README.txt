Member list:

BSPUFI     - C program -- Batch SPUFI
CBSPUFI    - a compile job
BINDPLAN   - a bind plan job
DEMOJOB    - a demo job
DEMOSQL    - input for demo job
DEMOSQL1   - input for demo job
OUTSQL     - output SQL w/o tags

/**********************************************************************/
/*                                                                    */
/* Title       :  C SQL-DB2-TSO Processor/Executor/Monitor            */
/*                                                                    */
/* Author      :  Vladimir Mestovski, IBA, Minsk, Belarus             */
/*             :  v2gri033@us.ibm.com  -- preffered for bugs          */
/*             :  mestovsky@iba.by     -- additional                  */
/*             :  for free use, not for sell                          */
/*                                                                    */
/* Environments:  z/OS                                                */
/*                                                                    */
/* Function:                                                          */
/*                                                                    */
/*  The program reads and executes SQL statements from the INSQL file.*/
/*  Before execution it substitutes tags from TAGS file (if specified)*/
/*  and writes adjusted statements to the OUTSQL file (if specified). */
/*  It also recognizes and executes special comments and functional   */
/*  commands that can be considered as an extension of SQL(see below).*/
/*                                                                    */
/* Parameters:                                                        */
/*                                                                    */
/*     INSQL(file) - input file with SQL statements,                  */
/*                   where 'file' is DD:name or file-name,            */
/*                   RECFM=FB, LRECL=any-allowed.                     */
/*      TAGS(file) - input, optional, tags & its values,              */
/*                   RECFM=FB, LRECL=any-allowed.                     */
/*    OUTSQL(file) - output, optional, SQL w/o tags                   */
/*                   RECFM=FB, LRECL=80                               */
/*        SCAN(ON) - optional, just substitute tags, do not run SQL   */
/*      PRINT(OFF) - optional, do not print out input statements      */
/*                                                                    */
/* Output report:                                                     */
/*                                                                    */
/*     DD:SYSPRINT - RECFM=FBA,LRECL=any-allowed                      */
/*                   No page break, no partitions for select reports, */
/*                   no extra SQLCA fields, but                       */
/*                   CPU and TOTAL timings after each SQL statement.  */
/* Return Codes:                                                      */
/*             0 - program completed successfully                     */
/*             4 - warning(s) was issued                              */
/*             8 - syntax error                                       */
/*            12 - SQL error happened                                 */
/*            NN - various errors                                     */
/*                                                                    */
/* Functional commands:                                               */
/* -------------------                                                */
/* 1. WRITE Ýdlm¨ {FILE file } ÝAPPEND¨ {select-stmnt;   }            */
/*                {STACK DATA}          {DB2-command;    } (zOS only) */
/*                                      {DDL select-stmnt}            */
/*    Writes out a select/DSN report to a file or to internal stack.  */
/*    Keyword 'dlm' specifies a column delimeter or file format:      */
/*     CSV   -- CSV format with fixed positions of commas             */
/*     TAB   -- tab delimeter (x'\t')                                 */
/*     COMMA -- comma (',')                                           */
/*     BAR   -- vertcal bar ('|')                                     */
/*     NODLM -- without any delimeter                                 */
/*     ASIS  -- no delimeter, binary file, numbers are not converted  */
/*     RPT   -- full report with column names                         */
/*    Default 'dlm' is a blank.                                       */
/*    Keyword 'file' can be specified as DD:NAME or real file-name.   */
/*    APPEND allows to write data to the end of the existing file but */
/*    not to the existing PDS/PDSE member (zOS restriction).          */
/*    STACK DATA directs output to data memory stack.                 */
/*                                                                    */
/* 2. READ Ýdlm¨ {FILE file1} ÝDISCARD Ýfile2¨¨                       */
/*               {STACK DATA}                                         */
/*       INSERT INTO ... VALUES(*|column-positions);                  */
/*                                                                    */
/*    (where dlm is same as WRITE dlm except RPT)                     */
/*    Read file1 records in and inserts them into a table.            */
/*    Keyword DISCARD allows to bypass records with wrong data and    */
/*    write them out to file2 (if specified).                         */
/*    Column positions specify data position for each column.         */
/*    Format is like the format of the LOAD utility, for example:     */
/*    VALUES(1.12,14:15,...)                                          */
/*    The VALUES(*) tells the program to find fields using dlm.       */
/*    STACK DATA invokes input from data memory stack.                */
/*                                                                    */
/* 3. STACK ÝFIFO|LIFO¨ ÝDDL¨ select-stmnt;                           */
/*          ÝDATA {ÝDDL¨ select-stmnt;|DB2-command;}¨                 */
/*                                                                    */
/*    Redirect a select report to the top of program's input (LIFO)   */
/*    or to the bottom (FIFO-default). The STACK allows to execute    */
/*    new statement(s) generated by a select-statement.               */
/*    STACK DATA directs output to data memory stack.                 */
/*                                                                    */
/* 4. SAVE DATA AS table select-statement;                            */
/*                                                                    */
/*    It works as "INSERT INTO table select-statement".               */
/*    If the table is a SESSION one and it was not declared before    */
/*    the SESSION table is declared implicitly with fields used in    */
/*    a select-statement.                                             */
/*                                                                    */
/* 5. INCLUDE FILE file;                                              */
/*                                                                    */
/*    It adds additional SQL statements from a file to main input.    */
/*    Embedded INCLUDEs are not allowed.                              */
/*                                                                    */
/* 6. DDL ÝTABLE name¨ select-statement;                              */
/*                                                                    */
/*    It generates                                                    */
/*        DECLARE GLOBAL TEMPORARY TABLE name (                       */
/*         column-definitions                                         */
/*        ) ON COMMIT PRESERVE ROWS;                                  */
/*    Default name is Tnn.                                            */
/*                                                                    */
/* 7. EXPLAIN sql-statement;  (only for z/OS, no PLAN_TABLE on AIX)   */
/*                                                                    */
/*    Prepares and displays EXPLAIN report for a given SQL statement. */
/*    You must have PLAN_TABLE under your user ID or set the current  */
/*    SQLID to an ID that has such table, for example:                */
/*       SET CURRENT SQLID='MDCT';                                    */
/*                                                                    */
/* 8. SYStem system-command;                                          */
/*                                                                    */
/*    Executes a given command (TSO,shell,...) by C-system() function.*/
/*    Use --#SET SYSRC nn if you need to suppress the nn code.        */
/*                                                                    */
/* 9. DB2 command; (AIX only)                                         */
/*                                                                    */
/*    Executes a given db2-command.                                   */
/*    It is the same as "SYSTEM DB2 command"                          */
/*                                                                    */
/* 10 DB2 -command (zOS only)                                         */
/*                                                                    */
/*    Executes a given -DB2command,not DSN one. By default DB2 prints */
/*    out a report to the SYSPRINT output. Use WRITE before DB2       */
/*    if you want to redirect its output to a file or data stack for  */
/*    further processing.                                             */
/*                                                                    */
/* 11 CONNECT TO location USER userid USING netrc-file                */
/*                                                                    */
/*    Executes CONNECT with the password taken from netrc-file.       */
/*    (DD:NETRC,'MDCV.PROD.PASSWORD(userid)',/home/userid/.netrc)     */
/*    'location' and 'userid' are case sensitive for search netrc-file*/
/*                                                                    */
/* 12 Conditional functional commands (where n=1-4):                  */
/*                                                                    */
/*  - RC=0|4|8;  -- reset the current RC                              */
/*  - RCn=RC;    -- save the current RC                               */
/*  - RCn=0|4|8; -- reset saved RCn                                   */
/*  - IF RCÝn¨=0|4|8 any-statement; -- run a statement when IF is true*/
/*  - IF RCÝn¨=0|4|8 DO; any-statements; ENDIF;                       */
/*                                                                    */
/* 13 Terminating execution:                                          */
/*                                                                    */
/*  - END; -- stop processing of input and exit with current RC       */
/*  - EXIT m|RCÝn¨; -- exit with a given RC (m=0-8,n=1-4);            */
/*                                                                    */
/* 14 SAY|ECHO string;                                                */
/*                                                                    */
/*    Display string. The command itself is not printed out.          */
/*                                                                    */
/* 15. ÝEXEC SQL¨ WHENEVER SQLERROR   {ROLLBACK;}  (default)          */
/*                                    {CONTINUE;}                     */
/*     ÝEXEC SQL¨ WHENEVER SQLWARNING {CONTINUE;}  (default)          */
/*                                    {SUPPRESS;}                     */
/*                                    {ROLLBACK;}                     */
/*    ROLLBACK -- exit with ROLLBACK after the 1st SQL error/warning. */
/*    CONTINUE -- print out messages and continue processing          */
/*    SUPPRESS -- do not print out warning messages                   */
/*                                                                    */
/* 16. RUNSTATS TABLE table-name other-options; (FISHKILL,not DB2LAB) */
/*                                                                    */
/*    It needs the SYSPROC.DSNUTILS stored procedure started correctly*/
/*    It retrieves the need DB&TSnames from the SYSIBM.SYSTABLES table*/
/*    and insert them into RUNSTATS clause with TABLESPACE key word.  */
/*                                                                    */
/* Special comments:                                                  */
/* -----------------                                                  */
/*                                                                    */
/* --#SET SIGNPOS ON|OFF|NO (default ON)                              */
/*    OFF does not add a sign position for character numbers          */
/* --#SET EXCEL ON|OFF    (default ON)                                */
/*    ON indicates that input file was created by Excel(not fixed pos)*/
/* --#SET NULLCHAR Ýc|BLANK¨  (default '?')                           */
/*    Specifies a char for a NULL value in a SELECT report            */
/* --#SET LOADNULL ON|OFF (default OFF)                               */
/*    ON allows to interpret a NULLCHAR as a NULL for READ command    */
/* --#SET MULTIROWS nn    (default 100, valid range  1-32767)         */
/*    Specifies number of multi-rows for SELECT(WRITE) & INSERT(READ) */
/* --#SET NUMVARS nn      (default 256, valid range 50-32767)         */
/*    Specifies max number of columns in a table                      */
/* --#SET SYSRC nn        (default 4,   valid range  0-32   )         */
/*    Specifies max RC allowed from SYSTEM command                    */
/* --#SET SQLDLM c        (default ';')                               */
/*    Specifies a delimeter of statements in INSQL file               */
/* --#SET TRACE ON|OFF    (default OFF)                               */
/*    For internal use, display additional info for debugging         */
/* --#SET SCAN ON|OFF     (default OFF)                               */
/*    OFF -- do not run any statement, just substitute TAGs           */
/* --#SET PRINT ON|OFF    (default ON)                                */
/*    ON -- print out input statements, OFF -- do not print           */
/* --;                                                                */
/*    Remove from processing INSQL records beginning with '--;'       */
/*    Use the comment in the TAG file if you want to hide test stmnts.*/
/*    <TST>   --;    <-- to hide, do not print out the record         */
/*    <TST>   null   <-- to actvate                                   */
/* --!                                                                */
/*    Print out the line ignoring #SET PRINT OFF                      */
/*                                                                    */
/* The program can run any SQL statement that can be                  */
/* dynamically prepared (see IBM SQL Reference) plus some             */
/* additional statements:                                             */
/*                                                                    */
/*   CONNECT                                                          */
/*   CONNECT RESET                                                    */
/*   CONNECT TO location                                              */
/*   CONNECT TO location USER userid USING netrc-file                 */
/*                                                                    */
/* A list of supported SQL Data Types:                                */
/*                                                                    */
/*     CHAR      VARCHAR     LONG VARCHAR                             */
/*     DECIMAL   SMALLINT    INTEGER                                  */
/*     DATE      TIME        TIMESTAMP                                */
/*     FLOAT     FLOAT(n)    DOUBLE PRECISION                         */
/*     REAL                                                           */
/*                                                                    */
/**********************************************************************/
