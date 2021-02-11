//UNPAX    JOB ACCOUNT,PROGRAMMER,
//         CLASS=?,                  <== CHANGE
//         MSGCLASS=?,               <== CHANGE
//         NOTIFY=&SYSUID
//         SET  SBPXEXEC=SYS1.SBPXEXEC <=== CHANGE?
//UNPAX    EXEC PGM=IKJEFT01,
//         REGION=0M
//SYSEXEC  DD   DISP=SHR,DSN=&SBPXEXEC
//* THE ABOVE CONTAINS THE OSHELL REXX PROGRAM
//SYSTSPRT DD   SYSOUT=*
//SYSTSIN  DD   *
 /* change the subdirectory in the two commands
    below to where you want to put SQLITE */
MKDIR '/where/to/put/sqlite' MODE(7,5,5)
OSHELL cd /where/to/put/sqlite; +
       pax -rzf "//'this.pds.library(PAXFULL)'"
 /* Change PAXFULL to PAXRUN if desired */
 /* Run the following, changing as needed, to restore
    the testcob2.sqlite3 data base file used by the
    TESTCOB2 example program. */
OSHELL cd /tmp; pax -rzf "//this.pds.library(TESTDB)"
/*
//
