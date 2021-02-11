//GENERJ01 JOB (6948),'TAPE TO DISK',TIME=60,CLASS=A,MSGCLASS=Q
//* ----------------------------------------------------------------- *
//* - REPLACE ???? WITH CURRENT GENERATION NUMBER                   - *
//* -         volser WITH CORRESPONDING TAPE VOLSER NUMBER          - *
//* -         useridx WITH Rescue TSO LOGON ID                      - *
//* -                                                               - *
//* - Tape volser & gen number for file are taken from most current - *
//* - VBKDSTRP printout                                             - *
//* -                                                               - *
//* - All Changes are to be made with CAPS ON                       - *
//* -                                                               - *
//* ----------------------------------------------------------------- *
//STEP2    EXEC PGM=IEBCOPY
//SYSPRINT  DD  SYSOUT=*
//SYSUT1    DD  DISP=OLD,DSN=DISASTER.RECOVER.LIBRARY.JCLLB.G????V00,
//             UNIT=3490,
//             LABEL=7,
//             VOL=SER=volser
//SYSUT2    DD  DISP=(NEW,CATLG,DELETE),
//             DSN=useridx.RECOVER.JCLLIB,
//             UNIT=3390,
//             VOL=SER=RESCUE,
//             SPACE=(TRK,(30,10,25)),
//             DCB=(DSORG=PO,RECFM=FB,LRECL=80,BLKSIZE=4080)
//SYSUT3    DD  UNIT=SYSDA,SPACE=(TRK,(4,2))
//SYSUT4    DD  UNIT=SYSDA,SPACE=(TRK,(4,2))
//SYSIN     DD  DUMMY
