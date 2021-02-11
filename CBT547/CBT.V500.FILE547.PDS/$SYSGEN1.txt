//SG0160  JOB  (SYSGEN),
//             'Stage1',
//             CLASS=A,
//             MSGCLASS=A,
//             MSGLEVEL=(1,1),
//             TIME=1440,
//             REGION=4096K
//*********************************************************************
//*
//*                       MVS 3.8 SYSGEN
//*                       ==============
//*
//* DESC: Run Stage 1 sysgen
//*
//* Note: The space allocation for the system target libraries has been
//*       roughly doubled, to allow the stage 2 process to be completed
//*       without running in an "out of space" conditions
//*
//*  Consoles:
//*
//*   ! CUA ! Devt ! Type             ! Alternate   !
//*   !-----+------+------------------+-------------!
//*   !     !      !                  !             !
//*   ! 010 ! 3277 ! Master           ! 011         !
//*   ! 011 ! 3277 ! Secons           ! 010         !
//*   ! 009 ! 3215 ! Secons           ! 01F         !
//*   ! 01F ! 3215 ! Secons           ! 009         !
//*   ! 30E ! 1403 ! Secons/Hardcopy  ! ./.         !
//*
//*
//*  Printers:
//*
//*  ! Devt ! Cua - Cua ! Cua - Cua ! Cua - Cua ! Cua - Cua ! Cua - Cua !
//*  !------+-----------+-----------+-----------+-----------!-----------!
//*  ! 1403 ! 00E - 00F ! 10E - 10F ! 20E - 20F ! 30E - 30F !           !
//*  ! 3211 ! 002 - 003 ! 102 - 103 ! 202 - 203 ! 302 - 302 !           !
//*
//*
//*  Card readers/Punchers:
//*
//*  ! Devt ! Cua - Cua ! Cua - Cua ! Cua - Cua ! Cua - Cua ! Cua - Cua !
//*  !------+-----------+-----------+-----------+-----------!-----------!
//*  ! 2540 ! 00C - 00D ! 10C - 10D ! 20C - 20D ! 30C - 30D !           !
//*
//*
//*  Display Terminals (including display consoles)
//*
//*  ! Devt ! Cua - Cua ! Cua - Cua ! Cua - Cua ! Cua - Cua ! Cua - Cua !
//*  !------+-----------+-----------+-----------+-----------!-----------!
//*  ! 3270 ! 010 - 011 !           !           !           !           !
//*  ! 3270 ! 0C0 - 0C8 ! 1C0 - 1C8 ! 2C0 - 2C8 ! 3C0 - 3C8 !           !
//*
//*
//*  DASD devices
//*
//*  ! Devt ! Cua - Cua ! Cua - Cua ! Cua - Cua ! Cua - Cua ! Cua - Cua !
//*  !------+-----------+-----------+-----------+-----------!-----------!
//*  ! 2314 !           ! 130 - 13F ! 230 - 23F ! 330 - 33F !           !
//*  ! 3350 !           ! 140 - 14F ! 240 - 24F ! 340 - 34F !           !
//*  ! 3330 !           ! 150 - 15F ! 250 - 25F ! 350 - 35F !           !
//*  ! 3340 !           ! 160 - 16F ! 260 - 26F ! 360 - 36F !           !
//*  ! 3375 !           ! 170 - 17F ! 270 - 27F ! 370 - 37F !           !
//*  ! 3380 !           ! 180 - 18F ! 280 - 28F ! 380 - 38F !           !
//*  ! 3390 !           ! 190 - 19F ! 290 - 29F ! 390 - 39F !           !
//*  !      !           !           !           !           !           !
//*  !      !           !  Shared   !  Shared   !           !           !
//*  !      !           !  DASD     !  DASD     !           !           !
//*  !      !           !           !           !           !           !
//*
//*
//*  Tape devices
//*
//*  ! Devt ! Cua - Cua ! Cua - Cua ! Cua - Cua ! Cua - Cua ! Cua - Cua !
//*  !------+-----------+-----------+-----------+-----------!-----------!
//*  ! 3420 !           !           !           !           ! 480 - 487 !
//*
//*
//*  CTCs
//*
//*  ! Devt ! Cua - Cua ! Cua - Cua !
//*  !------+-----------+-----------!
//*  ! 3088 ! 500 - 507 ! 600 - 607 !
//*  ! 3088 ! 510 - 517 ! 610 - 617 !
//*
//*
//*
//*
//*********************************************************************
//*
//JOBCAT   DD  DISP=SHR,DSN=SYS1.VMASTCAT
//CLEANUP EXEC PGM=IDCAMS,REGION=768K
//SYSPRINT DD  SYSOUT=*
//SYSIN    DD  *
 DELETE SYS1.STAGE1.OUTPUT NONVSAM
 SET LASTCC = 0
 SET MAXCC  = 0
//ASM     EXEC PGM=IFOX00,REGION=4096K,TIME=1440,
//             PARM='NOLIST,TERM'
//SYSPRINT  DD SPACE=(121,(9500,200),RLSE),
//             DCB=(RECFM=FB,LRECL=121,BLKSIZE=3509),SYSOUT=A
//SYSTERM   DD SPACE=(121,(9500,200),RLSE),
//             DCB=(RECFM=FB,LRECL=121,BLKSIZE=3509),SYSOUT=A
//SYSPUNCH DD  DISP=(NEW,CATLG),
//             DSN=SYS1.STAGE1.OUTPUT,
//             UNIT=3350,
//             VOL=SER=MVSRES,
//             SPACE=(TRK,(30,30),RLSE),
//             DCB=(LRECL=80,BLKSIZE=19040,RECFM=FB)
//SYSUT1   DD  UNIT=3350,SPACE=(1700,(9000,1000)),DSN=&&SYSUT1
//SYSUT2   DD  UNIT=3350,SPACE=(1700,(6000,1000)),DSN=&&SYSUT2
//SYSUT3   DD  UNIT=3350,SPACE=(1700,(6000,1000)),DSN=&&SYSUT3
//SYSLIB   DD  DISP=SHR,DSN=SYS1.AGENLIB,DCB=BLKSIZE=32720
//         DD  DISP=SHR,DSN=SYS1.AMODGEN
//SYSIN    DD  *
*====================================================================*
*                                                                    *
*          Console Definitions                                       *
*                                                                    *
* Note:  Route Code 14 has been excluded, because it is being used   *
*        by the IEFACTRT exit program                                *
*                                                                    *
*====================================================================*
               SPACE   2
      CONSOLE MCONS=010,ALTCONS=011,                                   +
               ROUTCDE=(3,4,5,6,7,8,9,10,11,12,13,15,16),              +
               PFK=12
      CONSOLE SECONS=011,ALTCONS=010,                                  +
               ROUTCDE=(1,2,3,4,5,6,7,8,9,10,11,12,13,15,16),          +
               PFK=12,VALDCMD=(1,2,3)
      CONSOLE SECONS=009,ALTCONS=01F,ROUTCDE=ALL,VALDCMD=(1,2,3)
      CONSOLE SECONS=01F,ALTCONS=009,ROUTCDE=ALL,VALDCMD=(1,2,3)
      CONSOLE SECONS=O-30E,ROUTCDE=ALL
               EJECT
*====================================================================*
*                                                                    *
*          Channel Definitions                                       *
*                                                                    *
*====================================================================*
               SPACE   2
CHANL00 CHANNEL ADDRESS=(0),TYPE=MULTIPLEXOR
CHANL14 CHANNEL ADDRESS=(1,2,3,4,5,6),TYPE=BLKMPXR
               EJECT
*====================================================================*
*                                                                    *
*          Device Definitions                                        *
*                                                                    *
*====================================================================*
               SPACE   2
PRT002   IODEVICE                                                      +
               UNIT=3211,ADDRESS=002
PRT003   IODEVICE                                                      +
               UNIT=3211,ADDRESS=003
PRT102   IODEVICE                                                      +
               UNIT=3211,ADDRESS=102
PRT103   IODEVICE                                                      +
               UNIT=3211,ADDRESS=103
PRT202   IODEVICE                                                      +
               UNIT=3211,ADDRESS=202
PRT203   IODEVICE                                                      +
               UNIT=3211,ADDRESS=203
PRT302   IODEVICE                                                      +
               UNIT=3211,ADDRESS=302
PRT303   IODEVICE                                                      +
               UNIT=3211,ADDRESS=303
CON009   IODEVICE                                                      +
               UNIT=3215,ADDRESS=009
RDR00C   IODEVICE                                                      +
               UNIT=2540R,MODEL=1,ADDRESS=00C
PCH00D   IODEVICE                                                      +
               UNIT=2540P,MODEL=1,ADDRESS=00D
RDR10C   IODEVICE                                                      +
               UNIT=2540R,MODEL=1,ADDRESS=10C
PCH10D   IODEVICE                                                      +
               UNIT=2540P,MODEL=1,ADDRESS=10D
RDR20C   IODEVICE                                                      +
               UNIT=2540R,MODEL=1,ADDRESS=20C
PCH20D   IODEVICE                                                      +
               UNIT=2540P,MODEL=1,ADDRESS=20D
RDR30C   IODEVICE                                                      +
               UNIT=2540R,MODEL=1,ADDRESS=30C
PCH30D   IODEVICE                                                      +
               UNIT=2540P,MODEL=1,ADDRESS=30D
PRT00E   IODEVICE                                                      +
               UNIT=1403,ADDRESS=00E,MODEL=2
PRT00F   IODEVICE                                                      +
               UNIT=1403,ADDRESS=00F,MODEL=2
PRT10E   IODEVICE                                                      +
               UNIT=1403,ADDRESS=10E,MODEL=2
PRT10F   IODEVICE                                                      +
               UNIT=1403,ADDRESS=10F,MODEL=2
PRT20E   IODEVICE                                                      +
               UNIT=1403,ADDRESS=20E,MODEL=2
PRT20F   IODEVICE                                                      +
               UNIT=1403,ADDRESS=20F,MODEL=2
PRT30E   IODEVICE                                                      +
               UNIT=1403,ADDRESS=30E,MODEL=2
PRT30F   IODEVICE                                                      +
               UNIT=1403,ADDRESS=30F,MODEL=2
CON010   IODEVICE                                                      +
               ADDRESS=010,                                            +
               UNIT=3277,MODEL=2,                                      +
               FEATURE=(AUDALRM,EBKY3277,NUMLOCK,DOCHAR,KB78KEY)
CON011   IODEVICE                                                      +
               ADDRESS=011,                                            +
               UNIT=3277,MODEL=2,                                      +
               FEATURE=(AUDALRM,EBKY3277,NUMLOCK,DOCHAR,KB78KEY)
CON01F   IODEVICE                                                      +
               UNIT=3215,ADDRESS=01F
LCL0C0   IODEVICE                                                      +
               ADDRESS=(0C0,8),                                        +
               UNIT=3277,                                              +
               MODEL=2,                                                +
               FEATURE=(AUDALRM,EBKY3277,NUMLOCK,DOCHAR,KB78KEY)
LCL1C0   IODEVICE                                                      +
               ADDRESS=(1C0,8),                                        +
               UNIT=3277,                                              +
               MODEL=2,                                                +
               FEATURE=(AUDALRM,EBKY3277,NUMLOCK,DOCHAR,KB78KEY)
LCL2C0   IODEVICE                                                      +
               ADDRESS=(2C0,8),                                        +
               UNIT=3277,                                              +
               MODEL=2,                                                +
               FEATURE=(AUDALRM,EBKY3277,NUMLOCK,DOCHAR,KB78KEY)
LCL3C0   IODEVICE                                                      +
               ADDRESS=(3C0,8),                                        +
               UNIT=3277,                                              +
               MODEL=2,                                                +
               FEATURE=(AUDALRM,EBKY3277,NUMLOCK,DOCHAR,KB78KEY)
D23141   IODEVICE                                                      +
               ADDRESS=(130,8),                                        +
               FEATURE=(SHARED),                                       +
               UNIT=2314
D23142   IODEVICE                                                      +
               ADDRESS=(138,8),                                        +
               FEATURE=(SHARED),                                       +
               UNIT=2314
D23143   IODEVICE                                                      +
               ADDRESS=(230,8),                                        +
               FEATURE=(SHARED),                                       +
               UNIT=2314
D23144   IODEVICE                                                      +
               ADDRESS=(238,8),                                        +
               FEATURE=(SHARED),                                       +
               UNIT=2314
D23145   IODEVICE                                                      +
               ADDRESS=(330,8),                                        +
               FEATURE=(SHARED),                                       +
               UNIT=2314
D23146   IODEVICE                                                      +
               ADDRESS=(338,8),                                        +
               FEATURE=(SHARED),                                       +
               UNIT=2314
D33501   IODEVICE                                                      +
               ADDRESS=(140,8),                                        +
               FEATURE=(SHARED),                                       +
               UNIT=3350
D33502   IODEVICE                                                      +
               ADDRESS=(148,8),                                        +
               FEATURE=(SHARED),                                       +
               UNIT=3350
D33503   IODEVICE                                                      +
               ADDRESS=(240,8),                                        +
               FEATURE=(SHARED),                                       +
               UNIT=3350
D33504   IODEVICE                                                      +
               ADDRESS=(248,8),                                        +
               FEATURE=(SHARED),                                       +
               UNIT=3350
D33505   IODEVICE                                                      +
               ADDRESS=(340,8),                                        +
               UNIT=3350
D33506   IODEVICE                                                      +
               ADDRESS=(348,8),                                        +
               UNIT=3350
D33301   IODEVICE                                                      +
               ADDRESS=(150,8),                                        +
               FEATURE=(SHARED),                                       +
               UNIT=3330
D33302   IODEVICE                                                      +
               ADDRESS=(158,8),                                        +
               FEATURE=(SHARED),                                       +
               UNIT=3330
D33303   IODEVICE                                                      +
               ADDRESS=(250,8),                                        +
               FEATURE=(SHARED),                                       +
               UNIT=3330
D33304   IODEVICE                                                      +
               ADDRESS=(258,8),                                        +
               FEATURE=(SHARED),                                       +
               UNIT=3330
D33305   IODEVICE                                                      +
               ADDRESS=(350,8),                                        +
               UNIT=3330
D33306   IODEVICE                                                      +
               ADDRESS=(358,8),                                        +
               UNIT=3330
D33401   IODEVICE                                                      +
               ADDRESS=(160,8),                                        +
               FEATURE=(SHARED),                                       +
               UNIT=3340
D33402   IODEVICE                                                      +
               ADDRESS=(168,8),                                        +
               FEATURE=(SHARED),                                       +
               UNIT=3340
D33403   IODEVICE                                                      +
               ADDRESS=(260,8),                                        +
               FEATURE=(SHARED),                                       +
               UNIT=3340
D33404   IODEVICE                                                      +
               ADDRESS=(268,8),                                        +
               FEATURE=(SHARED),                                       +
               UNIT=3340
D33405   IODEVICE                                                      +
               ADDRESS=(360,8),                                        +
               UNIT=3340
D33406   IODEVICE                                                      +
               ADDRESS=(368,8),                                        +
               UNIT=3340
D33701   IODEVICE                                                      +
               ADDRESS=(170,8),                                        +
               FEATURE=(SHARED),                                       +
               UNIT=3375
D33702   IODEVICE                                                      +
               ADDRESS=(178,8),                                        +
               FEATURE=(SHARED),                                       +
               UNIT=3375
D33703   IODEVICE                                                      +
               ADDRESS=(270,8),                                        +
               FEATURE=(SHARED),                                       +
               UNIT=3375
D33704   IODEVICE                                                      +
               ADDRESS=(278,8),                                        +
               FEATURE=(SHARED),                                       +
               UNIT=3375
D33705   IODEVICE                                                      +
               ADDRESS=(370,8),                                        +
               UNIT=3375
D33706   IODEVICE                                                      +
               ADDRESS=(378,8),                                        +
               UNIT=3375
D33801   IODEVICE                                                      +
               ADDRESS=(180,8),                                        +
               FEATURE=(SHARED),                                       +
               UNIT=3380
D33802   IODEVICE                                                      +
               ADDRESS=(188,8),                                        +
               FEATURE=(SHARED),                                       +
               UNIT=3380
D33803   IODEVICE                                                      +
               ADDRESS=(280,8),                                        +
               FEATURE=(SHARED),                                       +
               UNIT=3380
D33804   IODEVICE                                                      +
               ADDRESS=(288,8),                                        +
               FEATURE=(SHARED),                                       +
               UNIT=3380
D33805   IODEVICE                                                      +
               ADDRESS=(380,8),                                        +
               UNIT=3380
D33806   IODEVICE                                                      +
               ADDRESS=(388,8),                                        +
               UNIT=3380
D33901   IODEVICE                                                      +
               ADDRESS=(190,8),                                        +
               FEATURE=(SHARED),                                       +
               UNIT=3390
D33902   IODEVICE                                                      +
               ADDRESS=(198,8),                                        +
               FEATURE=(SHARED),                                       +
               UNIT=3390
D33903   IODEVICE                                                      +
               ADDRESS=(290,8),                                        +
               FEATURE=(SHARED),                                       +
               UNIT=3390
D33904   IODEVICE                                                      +
               ADDRESS=(298,8),                                        +
               FEATURE=(SHARED),                                       +
               UNIT=3390
D33905   IODEVICE                                                      +
               ADDRESS=(390,8),                                        +
               UNIT=3390
D33906   IODEVICE                                                      +
               ADDRESS=(398,8),                                        +
               UNIT=3390
T34201   IODEVICE                                                      +
               ADDRESS=(480,8),                                        +
               UNIT=3420,                                              +
               FEATURE=OPT1600,                                        +
               MODEL=6
CTC1     IODEVICE                                                      +
               ADDRESS=(500,8),                                        +
               UNIT=CTC
CTC2     IODEVICE                                                      +
               ADDRESS=(510,8),                                        +
               UNIT=CTC
CTC3     IODEVICE                                                      +
               ADDRESS=(600,8),                                        +
               UNIT=CTC
               EJECT
CTC4     IODEVICE                                                      +
               ADDRESS=(610,8),                                        +
               UNIT=CTC
               EJECT
*====================================================================*
*                                                                    *
*          Unit Names                                                *
*                                                                    *
*====================================================================*
               SPACE   2
TAPE     UNITNAME                                                      +
               NAME=TAPE,UNIT=((480,8))
SYSDA    UNITNAME                                                      +
               NAME=SYSDA,                                             +
               UNIT=((140,8),(148,8),    3350                          +
               (240,8),(248,8),          3350                          +
               (340,8),(348,8),          3350                          +
               (150,8),(158,8),          3330                          +
               (250,8),(258,8),          3330                          +
               (350,8),(358,8),          3330                          +
               (170,8),(178,8),          3375                          +
               (270,8),(278,8),          3375                          +
               (370,8),(378,8),          3375                          +
               (180,8),(188,8),          3380                          +
               (280,8),(288,8),          3380                          +
               (380,8),(388,8),          3380                          +
               (190,8),(198,8),          3390                          +
               (290,8),(298,8),          3390                          +
               (390,8),(398,8))          3390
DISK     UNITNAME                                                      +
               NAME=DISK,                                              +
               UNIT=((140,8),(148,8),    3350                          +
               (240,8),(248,8),          3350                          +
               (340,8),(348,8),          3350                          +
               (150,8),(158,8),          3330                          +
               (250,8),(258,8),          3330                          +
               (350,8),(358,8),          3330                          +
               (170,8),(178,8),          3375                          +
               (270,8),(278,8),          3375                          +
               (370,8),(378,8),          3375                          +
               (180,8),(188,8),          3380                          +
               (280,8),(288,8),          3380                          +
               (380,8),(388,8),          3380                          +
               (190,8),(198,8),          3390                          +
               (290,8),(298,8),          3390                          +
               (390,8),(398,8))          3390
SYSSQ    UNITNAME                                                      +
               NAME=SYSSQ,                                             +
               UNIT=((140,8),(148,8),    3350                          +
               (240,8),(248,8),          3350                          +
               (340,8),(348,8),          3350                          +
               (150,8),(158,8),          3330                          +
               (250,8),(258,8),          3330                          +
               (350,8),(358,8),          3330                          +
               (170,8),(178,8),          3375                          +
               (270,8),(278,8),          3375                          +
               (370,8),(378,8),          3375                          +
               (180,8),(188,8),          3380                          +
               (280,8),(288,8),          3380                          +
               (380,8),(388,8),          3380                          +
               (190,8),(198,8),          3390                          +
               (290,8),(298,8),          3390                          +
               (390,8),(398,8))          3390
SYSVIO   UNITNAME                                                      +
               VIO=YES,                                                +
               NAME=SYSVIO,                                            +
               UNIT=(140,240,148,248)
VIO      UNITNAME                                                      +
               VIO=YES,                                                +
               NAME=VIO,                                               +
               UNIT=(140,240,148,248)
PAGE     UNITNAME                                                      +
               NAME=PAGE,                                              +
               UNIT=((160,8),(168,8),    3340                          +
               (260,8),(268,8),          3340                          +
               (360,8),(368,8))          3340
SORT     UNITNAME                                                      +
               NAME=SORT,                                              +
               UNIT=((130,8),(138,8),    2314                          +
               (230,8),(238,8),          2314                          +
               (330,8),(338,8))          2314
WORK     UNITNAME                                                      +
               NAME=WORK,                                              +
               UNIT=((140,8),(240,8))
TSO      UNITNAME                                                      +
               NAME=TSO,                                               +
               UNIT=((240,8),            3350                          +
               (180,7),(188,8),          3380                          +
               (190,8),(198,8))          3390
*====================================================================*
*                                                                    *
*          Control Program                                           *
*                                                                    *
*====================================================================*
               SPACE   2
CTLPG CTRLPROG ACRCODE=YES,  (NO  for UP)  Alternate Processor Recovery+
               APFLIB=(SYS1.VTAMLIB,MVSRES,  required for VTAM         +
               SYS1.INDMAC,MVSRES),        required for IND=YES        +
               ASCII=INCLUDE,              We do want ASCII suppot     +
               CSA=2048,                   2MB for CSA, please         +
               OPTIONS=(BLDL,              Make BLDL in real storage   +
               DEVSTAT,                    make non-ready devs offline +
               RER),                       allow reduced err recov.    +
               REAL=128,                   Max size for V=R region     +
               SQA=3,                      Increase SQA by 3 seqments  +
               STORAGE=0,                  Find real storage amount    +
               TZ=(E,1),                   One hour east of GMT        +
               WARN=0                      No Power warning feature
               EJECT
*====================================================================*
*                                                                    *
*          JOB Scheduler                                             *
*                                                                    *
*====================================================================*
               SPACE   2
SCHDL SCHEDULR BCLMT=100,                  Broadcast Notice records    +
               DEVPREF=(3350,3380,3390,3330,3340), Device Preference   +
               HARDCPY=(30E,ALL,CMDS),     Record everything on HARDCPY+
               PRISUB=JES2,                We want JES2, not JES3      +
               TAVR=800                    Density for 3400 tapes
               EJECT
*====================================================================*
*                                                                    *
*          Optional Access Methods included                          *
*                                                                    *
*====================================================================*
               SPACE   2
OPTAM DATAMGT  ACSMETH=(BTAM,              Basic Telecommunications AM +
               VTAM,                       Virtual Telecommunications  +
               TCAM,                       Telecomm access mathod      +
               GAM,                        Graphics Access Method      +
               ISAM),                      Indexed Sequential          +
               IND=YES,                    Industry Subsystems         +
               TABLE=ALL,                  All character tbls for 3800 +
               UCSDFLT=ALL                 Use default UCS
               EJECT
*====================================================================*
*                                                                    *
*          System Libraries                                          *
*                                                                    *
*====================================================================*
               SPACE   2
BDCST DATASET  BRODCAST,VOL=(MVSRES,3350),SPACE=(CYL,(1))
CMDLB DATASET  CMDLIB,VOL=(MVSRES,3350),SPACE=(CYL,(6,1,71))
DCMLB DATASET  DCMLIB,VOL=(MVSRES,3350),SPACE=(CYL,(4,,35))
DUMP0 DATASET  DUMP00,VOL=(MVSRES,3350),SPACE=(CYL,(30))
DUMP1 DATASET  DUMP01,VOL=(MVSDLB,3350),SPACE=(CYL,(30))
DUMP2 DATASET  DUMP02,VOL=(MVSDLB,3350),SPACE=(CYL,(30))
HELP  DATASET  HELP,VOL=(MVSRES,3350),SPACE=(CYL,(6,1,71))
IMAGE DATASET  IMAGELIB,VOL=(MVSRES,3350),SPACE=(CYL,(2,,35))
INDMC DATASET  INDMAC,VOL=(MVSRES,3350),SPACE=(CYL,(6,1,71))
LINKL DATASET  LINKLIB,VOL=(MVSRES,3350),SPACE=(CYL,(40,1,330))
LPALB DATASET  LPALIB,VOL=(MVSRES,3350),SPACE=(CYL,(30,1,360)),        +
               PDS=SYS2.LPALIB,                                        +
               MEMBERS=(IGC0023A,IGC0023B,IGC0023C,IGC0023D,           +
               IGC0024A,IGC0024B,IGC0024C,IGC0024D,                    +
               IGC0024G,IGC0024H)
MACRO DATASET  MACLIB,VOL=(MVSRES,3350),SPACE=(CYL,(50,1,120))
MANX  DATASET  MANX,VOL=(MVSRES,3350),SPACE=(CYL,(5))
MANY  DATASET  MANY,VOL=(MVSRES,3350),SPACE=(CYL,(5))
NUCLS DATASET  NUCLEUS,VOL=(MVSRES,3350),SPACE=(CYL,(16,,71)),         +
               PDS=SYS2.NUCLEUS,                                       +
               MEMBERS=(IGC201,IGC202,IGC203,IGC204,                   +
               IGC215,IGC216,IGC221,IGC222,IGC223,IGC224,              +
               IGC225,IGC226)
PAGEL DATASET  PAGEDSN=SYS1.PAGELPA,VOL=(PAGE00,3340),                 +
               SPACE=(CYL,(120))
PAGEC DATASET  PAGEDSN=SYS1.PAGECSA,VOL=(PAGE01,3340),                 +
               SPACE=(CYL,(60))
PAGL1 DATASET  PAGEDSN=SYS1.PAGEL01,VOL=(PAGE01,3340),                 +
               SPACE=(CYL,(600))
PAGL2 DATASET  PAGEDSN=SYS1.PAGEL02,VOL=(PAGE00,3340),                 +
               SPACE=(CYL,(400))
DUPLX DATASET  DUPLEXDS,NAME=SYS1.DUPLEX,VOL=(PAGE00,3340),            +
               SPACE=(CYL,(140))
STGX  DATASET  STGINDEX,VOL=(MVSRES,3350),SPACE=(CYL,(1))
PARMS DATASET  PARMLIB,VOL=(MVSRES,3350),SPACE=(CYL,(6,,40))
PROCS DATASET  PROCLIB,VOL=(MVSRES,3350),SPACE=(CYL,(6,1,71))
SAMPL DATASET  SAMPLIB,VOL=(MVSRES,3350),SPACE=(CYL,(8,1,35))
SVCLB DATASET  SVCLIB,VOL=(MVSRES,3350),SPACE=(CYL,(2,1,35))
SWAP1 DATASET  SWAPDSN=SYS1.PAGES01,VOL=(MVSDLB,3350),                 +
               SPACE=(CYL,(20))
TCMAC DATASET  TCOMMAC,VOL=(MVSRES,3350),SPACE=(CYL,(99,10,5))
TELCM DATASET  TELCMLIB,VOL=(MVSRES,3350),SPACE=(CYL,(4,1,71))
UADS  DATASET  UADS,VOL=(MVSRES,3350),SPACE=(CYL,(1,1,35))
VSCAT DATASET  VSCATLG,NAME=SYS1.VMASTCAT,VOL=(MVSRES,3350)
VTAML DATASET  VTAMLIB,VOL=(MVSRES,3350),SPACE=(CYL,(4,1,35))
               EJECT
*====================================================================*
*                                                                    *
*          TSO EDIT options                                          *
*                                                                    *
*====================================================================*
               SPACE 2
TSOED EDIT     BLOCK=(6160,6160,6160,6160,6160,6160),                  +
               CONVERT=(CAPS,CAPS,CAPS,CAPS,CAPS,CAPS),                +
               DSTYPE=(ASM,DATA,CLIST,CNTL,COBOL,PLI),                 +
               FORMAT=(FXDONLY,FIXED,FIXED,FXDONLY,FXDONLY,FIXED),     +
               FIXED=(80-255,80-255,,80-255,80-255,80-255),            +
               VAR=(,,255-255),                                        +
               USERSRC=(DATASET,DATASET,DATASET,DATASET,DATASET)
               EJECT
*====================================================================*
*                                                                    *
*          TSO options                                               *
*                                                                    *
*====================================================================*
               SPACE 2
TSOOP TSO      CMDS=YES,                                               +
               LOGLINE=4,                                              +
               LOGTIME=50
               EJECT
*====================================================================*
*                                                                    *
*          SVC table                                                 *
*                                                                    *
*====================================================================*
               SPACE 2
*
SVCTB SVCTABLE SVC-248-T4-FC00-NP, FSE, not restricted, nonpreemptible +
               SVC-244-T4-FC00-NP,      not restricted, nonpreemptible +
               SVC-243-T4-FC00,         not restricted,    preemptible +
               SVC-242-T4-FC01-NP,          restricted, nonpreemptible +
               SVC-241-T4-FC01,             restricted,    preemptible +
               SVC-234-T3-FC00-NP,                                     +
               SVC-233-T3-FC00,                                        +
               SVC-232-T3-FC01-NP,                                     +
               SVC-231-T3-FC01,                                        +
               SVC-224-T2-FC00-NP,                                     +
               SVC-223-T2-FC00,                                        +
               SVC-222-T2-FC01-NP,                                     +
               SVC-221-T2-FC01,                                        +
               SVC-216-T2-FC00-NP,  CICS SVC   <<< NOT IMPLEMENTED     +
               SVC-215-T6-FC00-NP,  CICS HPO SVC < NOT IMPLEMENTED     +
               SVC-214-T1-FC00-NP,                                     +
               SVC-213-T1-FC00,                                        +
               SVC-212-T1-FC01-NP,                                     +
               SVC-211-T1-FC01,                                        +
               SVC-204-T6-FC00-NP,                                     +
               SVC-203-T6-FC00,                                        +
               SVC-202-T6-FC01-NP,                                     +
               SVC-201-T6-FC01
*====================================================================*
*                                                                    *
*          Generate                                                  *
*                                                                    *
*====================================================================*
GENOP GENERATE GENTYPE=ALL,                Full sysgen                 +
               INDEX=SYS1,                 HLQ for datasets            +
               JCLASS=C,                   Jobclass to submit          +
               OBJPDS=SYS1.OBJPDS,         Name of Object PDS          +
               OCLASS=A,                   Output class                +
               RESVOL=(MVSRES,3350)        Residence Volume
         END
/*
//
