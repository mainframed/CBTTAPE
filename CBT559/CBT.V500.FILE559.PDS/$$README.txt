************************************************************************
* File 559 is primarily C language source programs. Many of these      *
* programs were written for use on a PC and are of principal value in  *
* demonstrating simple C language programs. Most of the programs can be*
* compiled and run as-is on a mainframe in a TSO session by allocating *
* SYSIN, SYSOUT, and SYSPRINT to DA(*) which is the terminal, so that  *
* program data entry can be keyed in real-time, and the printf() output*
* will be displayed on the terminal.                                   *
*                                                                      *
************************************************************************
* Some notes on mainframe vs PC C language differences:                *
* 1. Some escape sequences (\n, \/, etc) differ. For the mainframe,    *
*    when the compiler complains about an escape sequence, it is       *
*    usually correct to just remove the leading back-slash.            *
*                                                                      *
* 2. The mainframe C compiler likes source code in columns 1-72, and   *
*    will issue warning messages "CBC3389 SOME TEXT NOT SCANNED..."    *
*    when it finds code or comments beyond column 72.                  *
*                                                                      *
* 3. For some reason the mainframe compiler's header files contain     *
*    many elements (function prototypes, data elements, etc) that are  *
*    "protected by a feature test macro." These are often noted in     *
*    the IBM manual SC28-1663 "OS/390 c/c++ Run-Time Library Reference"*
*    and the solution is to add the following line before any #includes*
*        #define _ALL_SOURCE                                           *
*                                                                      *
* 4. Function names, whether external or contained within the program  *
*    are considered to be external symbols by the mainframe compiler,  *
*    and they will be truncated to 8 characters. It is probably safest *
*    to change the names of any functions longer than 8 characters, or *
*    that contain underscores so that they are 8 characters or less and*
*    begin with an alphabetic character and contain only a-z and 0-9.  *
*                                                                      *
* 5. When a function prototype contains a reference to a structure,    *
*    the mainframe compiler requires that the prototype follow the     *
*    structure definition.                                             *
*                                                                      *
* 6. Square brackets are a major hassle on the mainframe, and the      *
*    $README member contains a discussion and suggested solution or    *
*    circumvention.                                                    *
*                                                                      *
* 7. For writing new mainframe C programs, you may find the SKELETON   *
*    program to be a good starting point, as it contains a "bare-bones"*
*    set of code.                                                      *
*                                                                      *
* 8. The mainframe C compiler requires specific #include statements for*
*    header files that were found automatically by the PC C compiler I *
*    used.                                                             *
*                                                                      *
* 9. OPEN statements for files differ on the mainframe from normal PC  *
*    use. Some examples are:                                           *
*      fopen("asa.file", "w,recfm=fba");                               *
*      fopen("test.file","wb, recfm=f, lrecl=80");                     *
*      fopen(qual_pds,"rb");                                           *
*      fopen("a.b(memnm)","r");                                        *
*      fopen("mygdg(+1)","a,recfm=f");                                 *
*      fopen("a.b","w+");                                              *
*      fopen("dd:vsamesds","rb,type=record");                          *
************************************************************************
* The first line for each program listed below has a parenthesized,    *
* abbreviated attribute field showing the type (text only, subroutine, *
* main program, etc), main processing function (formatting, abend,     *
*listing, dynamic allocation, copy, etc.)  and primary data type       *
* processed (assembler source code, listing, vtoc qsam file, vsam file,*
* catalog data, etc.). following the attribute field is a short        *
* description of the program. There may be lines following the first   *
* which identify members in other files that are related (JCL, etc).   *
************************************************************************
*   ====> (TYPE/FUNC/DATA) <====
$$README  (TEXT/    /    ) . GENERAL INFORMATION ON C AND THIS LIBRARY
ABAL      (MAIN/FMT /QSAM) . SIMPLE C LANGUAGE SOURCE PROGRAM REFORMAT.
+         JCL SAMPJCL(ABAL)
BLDFUNCD  (MAIN/FMT /QSAM) . READS RECFM=V REFORMATS TO RECFM=F DATASETS
+         JCL SAMPJCL(BLDFUNCD)
CALLBIN   (MAIN/SRCH/QSAM) . DOES A BINARY SEARCH OF A SEQUENTIAL FILE
CAPACITR  (MAIN/COMP/    ) . COMPUTE AND DISPLAY CAPACITANCE
+         JCL SAMPJCL(CAPACITR)
CBC3GDC4  (MAIN/SAMP/    ) . IBM SAMPLE USING THE DECIMAL DATA TYPE
+         JCL SAMPJCL(CBC3GDC4)
CFUNC     (SUBR/TEST/    ) . FOR TESTING CALLS FROM ASSEMBLER, COBOL
+         CALLED BY PROGRAM CALLCPGM IN FILE 563.
+         JCL SAMPJCL(CALLCPGM)
+         DATA FOR EXECUTION FILE564.DATA(CALLCPGM)
CIRCLE    (MAIN/COMP/    ) . DISPLAYS THE CIRCUMFERENCE, VOLUME, AND
+                               AREA OF A CIRCLE, GIVEN THE RADIUS.
+                               SHOWS PASSING PARAMETER IN EXEC PARM.
+         JCL SAMPJCL(CIRCLE)
CMPRFILE  (MAIN/CMPR/QSAM) . COMPARES TWO FILES BYTE-BY-BYTE REPORTING
+                               DIFFERENCES AND STOPS AFTER 10TH DIFF-
+                               ERENCE. DSNAMES ARE PASED AS PARMS ON
+                               THE EXEC STATEMENT.
+         JCL SAMPJCL(CMPRFILE)
CONV      (MAIN/SAMP/    ) . USES THE ATOL() FUNCTION TO CONVERT A
+                               STRING OF DECIMAL DIGITS TO A LONG.
COPYSOME  (MAIN/STRP/QSAM) . COPIES THE FIRST 100K BYTES AND LAST 100K
+                               BYTES OF AN INPUT FILE TO CREATE A
+                               SMALLER TEST FILE.
COPYSUBR  (MAIN/STRP/QSAM) . COPIES EVERY 50TH RECORD FROM AN INPUT FILE
+                               TO BUILD A SMALLER FILE FOR TESTING.
COUNTBYT  (MAIN/SUM /QSAM) . COUNT ALL BYTES IN A FILE BY BYTE VALUE
+                               (TOTAL OF ALL LETTER A'S, B'S, C'S, ETC)
+                               AND PRINT TOTALS. (ALSO SEE COUNTBY0)
+         JCL SAMPJCL(COUNTBYT)
COUNTBY0  (MAIN/SUM /QSAM) . COUNT ALL BYTES IN A FILE BY BYTE VALUE
+                               (TOTAL OF ALL LETTER A'S, B'S, C'S, ETC)
+                               AND PRINT TOTALS. (ALSO SEE COUNTBYT)
CSECMCH2  (MAIN/MTCH/QSAM) . SAMPLE FILE MATCH-MERGE.
+         JCL SAMPJCL(CSECMCH2)
C2COMPCK  (MAIN/MTCH/QSAM) . COMPARES THREE INPUT FILES, PRINTS
+                               DIFFERENCES.
+         JCL SAMPJCL(C2COMPCK)
DATECALC  (MAIN/DATE/    ) . GIVEN A TWO-DIGIT YEAR, PRINTS THE DAY OF
+                               WEEK FOR JAN 1ST.
DAYJAN1   (MAIN/DATE/    ) . GIVEN A 4-DIGIT YEAR > 1752, PRINTS THE
+                               DAY OF WEEK FOR JAN 1ST.
DAYWEEK   (MAIN/DATE/    ) . PRINTS DAY-OF-WEEK FOR ANY DATE MORE RECENT
+                               THAN JAN 1, 1752. USER PROVIDES THE DATE
+                               AS MM/DD/YYYY.
DIVIDE    (MAIN/COMP/    ) . DIVIDE USING INTEGERS TOO LARGE FOR LONG
+                               LONG INTEGERS WHERE THE REMAINDER IS
+                               NEEDED AND/OR AN EXACT QUOTIENT IS
+                               REQUIRED.
DOWNLOAD  (MAIN/SAMP/    ) . DOWNLOAD A CHARACTER SET TO THE EPSON FX-85
+                               PRINTER IN EPSON MODE.
DROPCR    (MAIN/FMT /QSAM) . READS A STANDARD ASCII TEXT FILE HAVING
+                               LINES ENDING IN CARRIAGE-RETURN AND LINE
+                               FEED AND COPIES IT, DROPPING THE
+                               CARRIAGE RETURN BYTES.
DUMPHEX   (MAIN/DSPL/QSAM) . PRINTS A FILE IN HEX AND CHARACTER FORMAT.
+                            (ALSO SEE HEXDUMP).
EASTER    (MAIN/DATE/QSAM) . COMPUTES MONTH AND DAY OF EASTER FOR ANY
+                               YEAR 1584-2900.
EDGEFIND  (MAIN/GENL/QSAM) . SAMPLE PROGRAM THAT READS A FILE, WRITES A
+                              REPORT.
+         JCL SAMPJCL(EDGEFIND)
EDGESTRP  (MAIN/STRP/QSAM) . SAMPLE PROGRAM THAT READS A FILE, STRIPS
+                               SOME RECORDS, AND WRITES A REFORMATTED
+                               VERSION OF THE SELECTED RECORDS.
+         JCL SAMPJCL(EDGESTRP)
EDGEVSCB  (MAIN/GENL/QSAM) . SAMPLE PROGRAM TO READ A FILE, WRITE A
+                               REPORT.
+         JCL SAMPJCL(EDGEVSCB)
EDIT      (SUBR/FMT /    ) . A SUBRUTINE THAT PROVIDES NUMERIC DATA
+                                EDITING FOR PRINTING INCLUDING LEADING
+                                ZERO SUPPRESSION, AND COMMA AND DECIMAL
+                                POINT INSERTION. SEE TESTEDIT.C FOR A
+                                PROGRAM TO TEST THE FUNCTION.
EDIT2     (MAIN/FMT /    ) . DEMONSTRATES NUMERIC DATA FORMATTING BY
+                                OBTAINING A PATTERN AND A NUMBER FROM
+                                THE USER, AND DISPLAYS THE RESULT.
EMPEROR   (MAIN/SAMP/QSAM) . A GAME ADAPTED FROM ONE WRITTEN IN PL/I
+                                FOR THE MAINFRAME.
ENDCKDUP  (MAIN/SAMP/QSAM) . SAMPLE PROGRAM THAT READS A FILE, CHECKS
+                               FOR RECORDS HAVING DUPLICATE DATA IN
+                               SELECTED FIELDS, WRITES FILE OF DUPS.
+         JCL SAMPJCL(ENDCKDUP)
ENDVELMT  (MAIN/SAMP/QSAM) . SAMPLE FILE MATCH PROGRAM.
+         JCL SAMPJCL(ENDVELMT)
ENDVPGLS  (MAIN/SAMP/QSAM) . SAMPLE FILE STRIP PROGRAM.
+         JCL SAMPJCL(ENDVPGLS)
ENDVRTVL  (MAIN/SAMP/QSAM) . SAMPLE OF GENERAL FILE PROCESSING.
+         JCL SAMPJCL(ENDVRTVL)
ENDVRTV2  (MAIN/SAMP/QSAM) . SAMPLE OF GENERAL FILE PROCESSING.
+         JCL SAMPJCL(ENDVRTV2)
ENDVXPND  (MAIN/SAMP/QSAM) . SAMPLE PROGRAM TO EXPAND A COMPRESSED FILE.
+         JCL SAMPJCL(ENDVXPND)
ENUM      (MAIN/SAMP/    ) . SAMPLE DEMONSTRATING USE OF ENUM.
FAHRCENT  (MAIN/COMP/      . GIVEN A FAHRENHEIT TEMPERATURE, COMPUTES
+                               AND DISPLAYS THE CELSIUS EQUIVALENT.
FUNKEY    (MAIN/SAMP/QSAM) . ASSIGNS A FUNCTION KEY TO THE STRING TYPED
+                               BY THE USER. USES ANY NUMBER OF COMMAND-
+                               LINE ARGUMENTS.
GENLDAT2  (SUBR/SAMP/QSAM) . GENERALIZED DATE SUBROUTINE THAT PROVIDES
+                               Y2K SUPPORT WITH 4-DIGIT YEARS.
+         LOADED BY FILE558(ALLDSNS, CALLGND2, CALLGND3)
+         CALLED BY FILE558(MSASMRPT, MSMCHRPT)
+         CALLED BY FILE563(DATEINFO, DATES)
GETWORDS  (MAIN/EXTR/QSAM) . READS A TEXT FILE AND EXTRACTS ENGLISH
+                               WORDS FOR USE IN CREATINGA LIST OF
+                               COMMON ENGLISH WORDS.
HELLO     (MAIN/SAMP/    ) . CLASSIC C HELLO PROGRAM
HEXDUMP   (MAIN/SAMP/QSAM) . PRINT A FILE IN HEX AND CHARACTER FORMAT.
+                            (ALSO SEE DUMPHEX).
KBDTEST   (MAIN/CONV/    ) . CONVERTS THE VALUE FOR THE KEY PRESSED TO
+                               DECIMAL AND DISPLAYS THE RESULT.
MOFN      (MAIN/COMP/QSAM) . CALCULATES ALL POSSIBLE COMBINATIONS OF N
+                               ITEMS TAKEN M AT A TIME AND WRITES THE
+                               RESULTING DATA TO A FILE.
MOFN2     (MAIN/SAMP/QSAM) . ANOTHER VERSION OF MOFN. THE FILE PRODUCED
+                               IS READ BY PROGRAM SPLIT4.C.
MOVSTRU   (MAIN/SAMP/    ) . SAMPLE SHOWING STRUCTURE DEFINITION,
+                               MOVING DATA TO FIELDS WITHIN THE
+                               STRUCTURES, MOVING ONE STRUCTURE
+                               TO ANOTHER, PRINTING RESULTS.
MSASMMOD  (MAIN/FMT /QSAM) . SAMPLE PROGRAM TO READ A FILE, SELECT SOME
+                               RECORDS, REFORMAT THEM AND WRITE TO THE
+                               OUTPUT FILE.
+         JCL SAMPJCL(MSASMMOD)
MSMCHMOD  (MAIN/FMT /QSAM) . ANOTHER SAMPLE FILE PROCESSING PROGRAM.
+         JCL SAMPJCL(MSMCHMOD)
MVSTRUC   (MAIN/SAMP/    ) . SAMPLE SHOWING STRUCTURE OPERATIONS.
NETPAY    (MAIN/COMP/    ) . COMPUTES NET PAY USING HARD-CODED VALUES
+                               FOR GROSS PAY, DEDUCTIONS, WITHHOLDING
+                               PERCENTAGES, ETC.
NOTRLBK   (MAIN/COPY/QSAM) . COPY A TEXT FILE, DROPPING ALL TRAILING
+                               BLANKS ON EACH LINE.
PRIME     (MAIN/COMP/    ) . FIND OUT IF A NUMBER IS PRIME.
PRIMES    (MAIN/COMP/    ) . FIND OUT IF A NUMBER IS PRIME.
PRINT     (MAIN/PRNT/QSAM) . PRINTS A TEXT FILE TO THE PRINTER.
PRINTALL  (MAIN/COMP/    ) . DISPLAYS ALL HEX CHARACTERS 00-FF
PRTEXACT  (MAIN/FMT /QSAM) . PRINT A FILE IN HEX AND CHARACTER.
PRVINIT   (SUBR/SAMP/QSAM) . SAMPLE FUNCTION TO OPEN FILE
PRVSEAR   (SUBR/SAMP/QSAM) . SAMPLE BINARY SEARCH OF A FILE
PRVSERV   (HDR /SAMP/    ) . SAMPLE HEADER FILE FOR PRV... PGMS
PRVTERM   (SUBR/SAMP/QSAM) . SAMPLE FILE CLOSE FUNCTION
PTRARAY   (SUBR/SAMP/    ) . ARRAY CODING SAMPLE USING POINTER
PUREBRE   (MAIN/STRP/QSAM) . SAMPLE FILE STRIP PROGRAM.
RDVSMSEQ  (MAIN/SAMP/QSAM) . READS A VSAM KSDS, COUNTS RECORDS, PRINTS
+                               RECORD TOTAL.
+         JCL SAMPJCL(RDVSMSEQ)
READC     (MAIN/SAMP/QSAM) . READS AND PRINTS A TEXT FILE ONE BYTE AT
+                               A TIME.
READDIR   (MAIN/SAMP/QSAM) . ATTEMPT TO READ A PDS DIRECTORY AS A FILE.
REMOVE0A  (MAIN/COPY/QSAM) . COPY A FILE, REMOVING ALL NEWLINE'S (X'0A')
RENGREG   (MAIN/SAMP/QSAM) . RENAMES A FILE.
RUNTESTS  (MAIN/SAMP/QSAM) . SAMPLE PROGRAM READS FILES INTO MEMORY
+                               ARRAYS AND COMPARES FOR DUPLICATES.
+         JCL SAMPJCL(RUNTESTS)
SETDIARY  (MAIN/SAMP/QSAM) . SAMPLE PROGRAM TO UPDATE A SIMPLE TEXT
+                               FILE WITH ENTRIES FROM A "SUSPENSE" FILE
+                               THAT CONTAINS RECURRING "TO-DO" ITEMS.
SHFTRITE  (MAIN/SAMP/QSAM) . READS A TEXT FILE AND SHIFTS DATA RIGHT
+                               AND EXPANDS TABS TO BLANKS USING VALUES
+                               SUPPLIED BY THE CALLER.
SKELETON  (MAIN/SAMP/QSAM) . GENERIC CODE TO USE IN WRITING A PROGRAM.
SORTNUM   (MAIN/SAMP/QSAM) . BUBBLE SORT OF A NUMERIC ARRAY.
SORTSTR   (MAIN/SAMP/QSAM) . SORTS A TYPED IN LIST OF NAMES INTO AN
+                               ARRAY.
SPLIT4    (MAIN/SPLT/QSAM) . SPLITS AN INPUT FILE INTO EIGHT OUTPUT
+                               FILES. READS THE FILE CREATED BY
+                               PROGRAM MOFN2().
STMENU2   (MAIN/RPRT/QSAM) . READS FILE, PRODUCES REPORT.
STRGINS   (SUBR/SAMP/    ) . INSERTS A CHARACTER IN A STRING.
SUBRUPDT  (MAIN/SAMP/QSAM) . UPDATES A MASTER FILE WITH A TRANSACTION
+                               FILE USING ADD/CHANGE/DELETE LOGIC.
TABTOSP   (SUBR/XPND/    ) . EXPANDS TAB CHARACTERS TO EIGHT BLANKS.
TESTBOX   (MAIN/SAMP/    ) . SAMPLE OF ENCLOSING A STRING IN A BOX.
TESTHEX   (MAIN/DSPL/    ) . DISPLAYS DECIMAL EQUIVALENTS OF SELECTED
+                               HEX VALUES.
TRYEDIT   (MAIN/SAMP/QSAM) . TEST THE EDIT() SUBROUTINE (SEE EDIT.C)
TRYFMOD   (MAIN/SAMP/    ) . DEMONSTRATE USE OF THE FMOD() FUNCTION.
TYPE2     (MAIN/SAMP/QSAM) . READS STRINGS FROM A FILE.
UNUCASE   (MAIN/CVRT/QSAM) . COPY UPPER-CASE-ONLY FILE CREATING AN UPPER
+                               AND LOWER CASE FILE.
UPPRCASE  (MAIN/CVRT/QSAM) . COPY FILE CHANGING ALL LOWER-CASE ALPHA
+                               CHARACTERS TO UPPER-CASE.
VALUES    (MAIN/SAMP/    ) . SAMPLE OF FUNCTION THAT ACCEPTS TWO INTEGER
+                               ARGUMENTS.
VENUS     (MAIN/SAMP/QSAM) . SAMPLE USING PRINTF() TO DISPLAY A STRING.
VSAMCALC  (MAIN/COMP/    ) . COMPUTES PHYSICAL RECORDS-PER-TRACK ON A
+                               3390 DISK FOR RECORDS SIZES IN
+                               MULTIPLES OF 4096 BYTES.
WAYNE     (MAIN/COMP/QSAM) . ASKS FOR AGE IN YEARS, CALCULATES, AND
+                              DISPLAYS AGE IN DAYS.
WLOOP     (MAIN/LOOP/QSAM) . SHOWS A WHILE LOOP USED TO CONTROL PRINTING
WORDCNTF  (MAIN/CNTR/QSAM) . COUNTS WORDS IN A TEXT FILE.
WRITE     (MAIN/FMT /QSAM) . WRITES FORMATTED DATA TO A FILE.
WRITEC    (MAIN/SAMP/QSAM) . WRITES ONE CHARACTER AT A TIME TO A FILE.
