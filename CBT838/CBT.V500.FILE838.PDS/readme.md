
## $$README.txt
```
1                                                          CECDYN   1/4
0+---------------------------------------------------------------------+
 |                                                                     |
 |       The accompanying programs, developed at Centerior Energy      |
 |  Corporation, are submitted for unrestricted distribution.  The     |
 |  programs have met a basic set of programming and documentation     |
 |  standards, but have not been tested in any formal fashion by       |
 |  Centerior Energy Corporation.  The user is expected to make the    |
 |  final evaluation as to the usefulness in their own environment.    |
 |                                                                     |
 |       Centerior Energy Corporation makes no warranty, expressed or  |
 |  implied, including, but not limited to, the implied warranties of  |
 |  merchantability and fitness for a particular purpose as to the     |
 |  documentation, function, or performance of these programs.         |
 |                                                                     |
 |       Acceptance and use of these programs constitutes a release    |
 |  from liability of Centerior Energy Corporation for any problems    |
 |  use of the programs may cause at the user's installation.          |
 |                                                                     |
 |       The programs are made available by Centerior Energy           |
 |  Corporation without charge or consideration.  Recipients are free  |
 |  to make the programs available to others in like manner.  They     |
 |  may not be sold.                                                   |
 |                                                                     |
 |       The assembler macros CECDYN, BREAK, and CONTINUE, and the     |
 |  example test program DUMPINFO were written by:                     |
 |                                                                     |
 |    Leslie J. Somos                                                  |
 |    Centerior Energy Corporation                                     |
 |    Mail Stop IND-149                                                |
 |    6200 Oak Tree Boulevard                                          |
 |    Independence, Ohio 44131                                         |
 |                                                                     |
 |       The assembler macros DO, OD, IF, ELSE, ELSEIF, FI, THEN,      |
 |  and EQUBC, were contributed to the SHARE MVS Group Modification    |
 |  Tape, by:                                                          |
 |    Donald S. Higgins                                                |
 |    Florida Power Corporation                                        |
 |    P.O.Box 14042       B-3-B                                        |
 |    St. Petersburg, FL 33733                                         |
 |                                                                     |
 |                                                                     |
 |       Centerior Energy Corporation does not guarantee to keep any   |
 |  material provided up to date, nor does it guarantee to provide     |
 |  any corrections or extensions described by the user or             |
 |  corrections or extensions made in the future by Centerior Energy   |
 |  Corporation itself.                                                |
 |                                                                     |
 +---------------------------------------------------------------------+
-                                                            21-APR-1993
1                                                          CECDYN   2/4
 BACKGROUND
0    I work in the Technical Services department of Centerior Energy
 Corporation, an electric utility located in northern Ohio.
-    The IBM manual describing Dynamic Allocation (SVC 99) has page
 upon page of text, listing all the text units available.  (For the
 release of MVS that I work with, the manual is GC28-1150 MVS/Extended
 Architecture System Programming Library: System Macros and Facilities
 Volume 1.)
0    While I was writing a program that made multiple calls to SVC 99,
 I noticed that I repeated a small segment of code, with slight
 variations.  I decided to fold the intelligence necessary into a
 macro, so I would not need to use my (error-prone) memory as much.
 That macro is CECDYN.
-IMPLEMENTATION
0    Because CECDYN uses SETC symbol names longer than 7 characters,
 it can only be used with IEV90 (the H-level assembler), or higher.
0    CECDYN has profuse internal comments.  It also has a DEBUG
 facility, which can be turned on if you suspect it is processing
 incorrectly.  The debugging is turned on by coding " CECDYN DEBUG ".
 Also, any detected internal error turns on debugging.
0    The information listed in the IBM manual for each text unit key
 is encoded in an internal table in CECDYN.
0    CECDYN calls itself multiple times, like an assembler source-
 level subroutine.  It was coded this way, so that CECDYN is a single
 unit, and not multiple macros.
     Only keyword parameters are used in user calls to CECDYN, no
 positional parameters.  Positional parameters are only used in
 recursive inner macro self-calls.
     There are 5 internal entry points, and a branch table at label
 .SUBROUT .  The internal entry points and their functions are:
 .CMT2   give a value to symbol &CEC#CMT2VAL, displayed in MNOTEs;
 .CREAT  actually generate lines of code;
 .DEBUG  either turn on debugging, or display debugging messages;
 .DOKEY  check a text unit key against internal information;
 .MNOTE  actually issue all MNOTEs.
     The 'internal table' of text units is implemented as a series of
 calls to the .DOKEY subroutine, within a loop that looks at each
 sublist entry in the TEXT parameter.  Each call to the .DOKEY
 subroutine encodes the processing necessary for a particular text unit
 key, and if it matches the key being processed, also turns on a flag
 that short-circuits scanning the following calls to the .DOKEY
 subroutine.
1                                                          CECDYN   3/4
 EXAMPLES
0    The IBM manual referred-to above has an example of a dynamic
 allocation request to allocate SYS1.LINKLIB with a status of SHARE.
 The corresponding code, using CECDYN, is:
-DYN   CSECT ,
       USING *,15
       STM   14,12,12(13)
       BALR  12,0
 BEGIN DS    0H
       USING BEGIN,12
 * (All names generated by the CECDYN macro will begin with 'ABC'.)
       LA    0,L'ABCDSECT  AMOUNT OF STORAGE REQUIRED FOR THIS REQUEST.
       GETMAIN R,LV=(0)    GET THE STORAGE NECESSARY FOR THE REQUEST.
       LR    8,1           SAVE THE ADDRESS OF THE RETURNED STORAGE.
       CECDYN PREFIX=ABC,        All names generated begin with 'ABC'
                MF=(E,(8)),      Build the parameter list here
                VERB=AL,   SET THE VERB CODE TO ALLOCATION FUNCTION.
                TEXT=((DSNAM,'SYS1.LINKLIB'),     FIRST TEXT UNIT
                (STATS,SHR),                      SECOND TEXT UNIT
                (RTDDN))                          THIRD TEXT UNIT
       DYNALLOC            INVOKE SVC 99 TO PROCESS THE REQUEST.
       USING ABCDSECT,8          All the ABC- names are found here
 * The returned DDNAME is found at label ABCRTDDN
       LM    14,12,12(13)
       BR    14            RETURN TO CALLER.
       END
-
_    There are also examples in CECDYN itself, at the end, where they
 will not interfere with the normal functioning of the macro.
1                                                          CECDYN   4/4
 EXAMPLES
0    When the supplied test program DUMPINFO is run with the supplied
 JCL:
 //GO2      EXEC PGM=*.LINK2.SYSLMOD
 //SYSUDUMP DD  SYSOUT=&SYSOUT,DCB=DSORG=PSU
 //INTRDR   DD  SYSOUT=(,INTRDR)
 //OL#CT#DL DD  DSN=*.LINK2.SYSLMOD,DISP=(OLD,CATLG,DELETE),
 //             DCB=DSORG=IS,
 //             UNIT=SYSDA,VOL=REF=*.LINK2.SYSLMOD
 //SH#DL#CT DD  DSN=*.GO.STEPLIB,DISP=(SHR,DELETE,CATLG),
 //             DCB=DSORG=DAU,
 //             UNIT=SYSDA,VOL=REF=*.GO.STEPLIB
 //NW#UC#KP DD  DSN=&&JUNK(@#$@#$),DISP=(NEW,UNCATLG,KEEP),
 //             DCB=DSORG=CX,
 //             UNIT=SYSDA,SPACE=(CYL,1)
 //DUMMY#DA DD  DUMMY,DCB=DSORG=DA
 //SYSLIB   DD  DSN=SYS1.MACLIB,DISP=(SHR,KEEP,KEEP)
 //         DD  DSN=&&CONCAT(MD#PS#UC),DISP=(MOD,PASS,UNCATLG),
 //             DCB=DSORG=POU,
 //             UNIT=SYSDA,SPACE=(TRK,(1,,1))
 //SYSIN    DD  *
-then the results should resemble:
0DUMPINFO (ASM 04/21/93 14.16) CENTERIOR JOB 7678  M831CDYN  GO2
0RELNO DDN     DSN                                         MEM      STA    NDP
 0001 PGM=*.DD SYS93111.T141625.RA000.M831CDYN.TEMPLOAD    DUMPINFO 01=OLD
08=KE
 0002 SYSUDUMP JES2.JOB07678.SO000115                               02=MOD
04=DE
 0003 INTRDR   JES2.JOB07678.SO000116                               02=MOD
04=DE
 0004 OL#CT#DL SYS93111.T141625.RA000.M831CDYN.TEMPLOAD    DUMPINFO 01=OLD
10=PA
 0005 SH#DL#CT SYS93111.T141625.RA000.M831CDYN.TEMPLOAD    DUMPINFO 08=SHR
04=DE
 0006 NW#UC#KP SYS93111.T141625.RA000.M831CDYN.JUNK        @#$@#$   04=NEW
10=PA
 0007 DUMMY#DA NULLFILE                                             04=NEW
04=DE
 0008 SYSLIB   SYS1.MACLIB                                          08=SHR
08=KE
 0009          SYS93111.T141625.RA000.M831CDYN.CONCAT      MD#PS#UC 02=MOD
10=PA
 000A SYSIN    JES2.JOB07678.SI000106                               04=NEW
04=DE
 000B SYSPRINT JES2.JOB07678.SO000117                               02=MOD
04=DE
0LST-INDICATE LAST: 80,LAST.
 STA - DSET STATUS: 01,=OLD; 02,=MOD; 04,=NEW; 08,=SHR.
 NDP - NORMAL DISP: 01,=UNC; 02,=CAT; 04,=DEL; 08,=KEE; 10,=PAS.
 CDP - COND"L DISP: 01,=UNC; 02,=CAT; 04,=DEL; 08,=KEE; 10,=PAS.
 ORG - ORGANIZATION: 0004,=TR ; 0008,=VSA; 0020,=TQ ; 0040,=TX ; 0080,=GS ;
0200
 ORG - ORGANIZATION: 2000,=DA ; 2100,=DAU; 4000,=PS ; 4100,=PSU; 8000,=IS ;
8100
 TYP - TYPE: 80,=DUMM; 40,=TERM; 20,=SYSI; 10,=SYSO.
 ATT - BIT 0=PERM'LY CONCAT'D; BIT 1=IN USE; BIT 2=PERM'LY ALLOCATED; BIT
3=CONV
1/*
 //* REFER M831.SOMOS.TEXT(CECDYN) AS OF 21-APR-1993 AT 16:45
 //
```

