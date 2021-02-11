
## @FILE747.txt
```
//***FILE 747 is from Mark Naughton of British Airways and contains *   FILE 747
//*           a program to read the OPERLOG.                        *   FILE 747
//*                                                                 *   FILE 747
//*           email:  mark.naughton@ba.com                          *   FILE 747
//*                   mark@blue-shantung.co.uk                      *   FILE 747
//*                                                                 *   FILE 747
//*     L O G R 64 - SYSTEM LOGGER READER         |                 *   FILE 747
//*     Mark Naughton 2001-2006                                     *   FILE 747
//*                                                                 *   FILE 747
//*     History                                                     *   FILE 747
//*     -------                                                     *   FILE 747
//*     25/09/2001 - 1.0.0 - LOGREAD is working correctly now.      *   FILE 747
//*                           (History to end of Version 1.0.9      *   FILE 747
//*                           deleted)                              *   FILE 747
//*     11/08/2003 - 1.0.9 - Support for multiple jobnames added.   *   FILE 747
//*     17/07/2006 - 2.0.0 - Started 64-bit version.                *   FILE 747
//*     14/08/2006 -        - Finished 64-bit version - runs        *   FILE 747
//*                           faster, more features than            *   FILE 747
//*                           before! Testing complete.             *   FILE 747
//*                                                                 *   FILE 747
//*     Parameters                                                  *   FILE 747
//*     ----------                                                  *   FILE 747
//*                                                                 *   FILE 747
//*     All parameters are specified in the SYSIN DD.               *   FILE 747
//*                                                                 *   FILE 747
//*     START(yyyjjj.hhmm)   -> Start date and time                 *   FILE 747
//*     END(yyyyjjj.hhmm)    -> End date and time                   *   FILE 747
//*     SYS(ssss)            -> System name                         *   FILE 747
//*     MSG(mmmmmmmmmmmm)    -> Message ID                          *   FILE 747
//*     JOB(jjjjjjjjjjjj)    -> Jobname                             *   FILE 747
//*     SYSLOG               -> Display output like SYSLOG          *   FILE 747
//*     NOHEADER             -> Do not display the header in        *   FILE 747
//*                             the display                         *   FILE 747
//*     TODAY                -> Use todays date from 00:00 to       *   FILE 747
//*                             current time                        *   FILE 747
//*     YESTERDAY            -> Use yesterday's date from           *   FILE 747
//*                             00:00 to 23:59                      *   FILE 747
//*                                                                 *   FILE 747
//*     If the date/time parameters are not specified, the          *   FILE 747
//*     program abends with U0001 or U0002.                         *   FILE 747
//*                                                                 *   FILE 747
//*     You can specify multiple systems, messages and              *   FILE 747
//*     jobnames separated by a space, for the length of the        *   FILE 747
//*     line).                                                      *   FILE 747
//*                                                                 *   FILE 747
//*     ERROR CODES                                                 *   FILE 747
//*     -----------                                                 *   FILE 747
//*                                                                 *   FILE 747
//*     ABEND U0001 - Invalid Start Date parameter                  *   FILE 747
//*     ABEND U0002 - Invalid End Date parameter                    *   FILE 747
//*     ABEND U0003 - No SYSIN DD specified                         *   FILE 747
//*     ABEND U0004 - Incorrect specification for parameter         *   FILE 747
//*     ABEND U0005 - Cannot connect to logstream                   *   FILE 747
//*     ABEND U0006 - Cannot start a browse function in             *   FILE 747
//*                   logstream                                     *   FILE 747
//*     ABEND U0007 - Cannot read from the logstream                *   FILE 747
//*                                                                 *   FILE 747
//*     R6 and R7 contain RETCODE and RSNCODE for diagnosis.        *   FILE 747
//*                                                                 *   FILE 747
```

