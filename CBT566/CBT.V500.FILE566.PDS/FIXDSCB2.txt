***********************************************************************
*        WILL  WORK ON MVS 3.8                                        *
***********************************************************************
*                                                                     *
*                       F I X D S C B                                 *
*                                                                     *
*     THIS IS A SYSTEM PROGRAMMER UTILITY PROGRAM DESIGNED            *
*     TO FACILITATE THE MODIFICATION (OR REPAIR) OF DATA SET          *
*     CONTROL BLOCKS (DSCB'S).  THIS PROGRAM DOES NOT DO              *
*     ANY TYPE OF SECURITY VALIDATION.  CHANGES ARE MADE TO           *
*     THE DSCB'S AS REQUESTED, WITHOUT REGUARD TO THEIR               *
*     CORRECTNESS OR APPLICABILITY TO THE SPECIFIC DATASET.           *
*     TO SOME PERSONS (AUDITORS OR SECURITY TYPES IN PARTICULAR)      *
*     THIS PROGRAM WILL REPRESENT ONE BIG INTEGRITY EXPOSURE.         *
*     SOME MEANS MUST BE FOUND TO CONTROL THE AVAILABILITY            *
*     AND USE OF THIS UTILITY.  THIS RESPONSIBILITY IS LEFT           *
*     TO THE INDIVIDUAL SHOP TO IMPLEMENT.                            *
*                                                                     *
*     AUTHOR: DAVID ALAN WEAVER                                       *
*             AMDAHL SYSTEMS ENGINEER                                 *
*             HOUSTON LIGHTING & POWER                                *
*                                                                     *
*     DATE WRITTEN: NOVEMBER, 1979                                    *
*                                                                     *
*     RELEASE LEVEL 1.0                                               *
*                                                                     *
*     MODIFICATION RECORD:                                            *
*                                                                     *
*     DATE    INITIALS      MODIFICATION                              *
*   12/15/79    DAW         CHANGED TO RUN UNDER TSO AS A CP          *
*   01/01/80    DAW         CHANGED TO REQUIRE OPER STATUS UNDER TSO  *
*                                                                     *
*                                                                     *
*                                                                     *
*                                                                     *
*                                                                     *
***********************************************************************
         EJECT
***********************************************************************
*                                                                     *
* OPERATION: FIXDSCB MUST BE LINKEDITED WITH AN AUTHORIZATION         *
*            CODE OF 1 AND PLACED IN AN AUTHORIZED LIBRARY.           *
*                                                                     *
*            FIXDSCB OPERATES IN ONE OF THREE MODES: BATCH, TSO, OR   *
*            STARTED TASK.  WHEN EXECUTED AS A BATCH PROGRAM          *
*            ALL I/O IS HANDLED THROUGH SYSIN/SYSPRINT DD             *
*            CARDS.  WHEN EXECUTED AS A STARTED TASK ALL I/O          *
*            IS DONE VIA WTO/WTOR THROUGH THE STARTING CONSOLE.       *
*            WHEN EXECUTED AS A TSO COMMAND PROCESSOR ALL I/O         *
*            IS DONE VIA TPUT/TGET TO THE TSO SESSION.                *
*            NOTE: UNDER MVS, IF FIXDSCB IS TO BE USED UNDER TSO      *
*                  THE NAME IT IS LINKEDITED UNDER MUST BE ADDED      *
*                  TO THE COMMAND AUTHORIZATION TABLE (IKJEFTE2)      *
*                  IN THE TMP (IKJEFT02).  SEE THE SPL: TSO FOR       *
*                  DETAILS ABOUT USING AUTHORIZED COMMANDS UNDER      *
*                  TSO.                                               *
*                                                                     *
*            IF AN EXECUTION PARAMETER OF "TEST" IS SUPPLIED          *
*            DURING ANY EXECUTION OF FIXDSCB, NO MODIFICATIONS        *
*            WILL BE APPLIED TO ANY DSCB.  THE PROGRAM WILL           *
*            SIMPLY RUN THROUGH IT'S LOGIC.                           *
*                                                                     *
*            ALL PRIMARY COMMANDS (SEE BELOW) MUST SUPPLY             *
*            A DATASET NAME AND THE VOLUME SERIAL ON WHICH            *
*            IT RESIDES.  THIS CRITERIA WAS CHOSEN OVER CATALOG       *
*            SEARCHES TO AVOID THE ACCIDENTAL MODIFICATION OF         *
*            A DSCB OF THE SAME NAME ON ANOTHER VOLUME THAN           *
*            INTENDED IF THE CATALOG POINTS SOMEWHERE ELSE.           *
*            THE THEORY IS: IF YOU KNOW IT NEEDS TO BE FIXED          *
*                           THEN YOU BETTER KNOW WHERE IT IS.         *
*                                                                     *
*            FIXDSCB WILL OPERATE UNDER SVS OR MVS.                   *
*            WHEN USED UNDER MVS SOME ADDITIONAL FLEXIBILITY IS       *
*            GAINED BY THE FACT THAT FIXDSCB WILL DYNAMICALLY ALLO-   *
*            CATE THE SPECIFIED VOLUME IF IT CANNOT FIND A REFER-     *
*            ENCE TO IT IN THE TIOT.  THIS ALLOWS A VERY SIMPLE       *
*            PROC TO BE USED FOR STARTED TASK.  UNDER SVS YOU WILL    *
*            HAVE TO INCLUDE AN ANYNAME DD CARD FOR EACH VOLUME       *
*            YOU INTEND TO MODIFY.  FOR MVS BATCH USAGE, IT IS        *
*            SUGGESTED THAT YOU INCLUDE AN ANYNAME DD CARD FOR        *
*            EACH VOLUME TO BE MODIFIED TO SAVE THE OVERHEAD OF       *
*            ALLOCATING THEM DYNAMICALLY.                             *
*                                                                     *
*            NOTE: IT IS ENTIRELY POSSIBLE (USING THIS UTILITY)       *
*                  TO RENAME A DATSET TO A NAME WHICH ALREADY         *
*                  EXIST ON THE PACK.  CAUTION SHOULD BE USED         *
*                  WHEN DOING RENAMES TO SEE THAT THIS CONDITION      *
*                  DOES NOT ARISE.                                    *
*                  SUBNOTE: THIS "FLAW" WAS LEFT IN INTENTIONALLY.    *
*                           I LEAVE IT TO YOUR IMAGINATION JUST HOW   *
*                           IT COULD BE EXPLOITED CONSTRUCTIVELY.     *
*                                                                     *
*                                                                     *
*                                                                     *
***********************************************************************
         EJECT
***********************************************************************
*                                                                     *
*        A WORD OR TWO ABOUT THE SCRATCH COMMAND:                     *
*                                                                     *
*          THE SCRATCH PRIMARY COMMAND IS EXECUTED IN A RATHER        *
*          UNIQUE WAY.  THE DATASET IS FIRST RENAMED TO A SPECIAL     *
*          NAME (FIXDSCB.SCRATCH.DATASET) AND ANY EXPIRATION DATE     *
*          AND PASSWORD FLAGS ARE SET TO ZERO.  THE RENAMED           *
*          DATASET IS THEN SCRATCHED VIA THE SCRATCH SVC.             *
*          THIS PROCEDURE FACILITATES SCRATCHING DATASETS WHICH       *
*          MAY HAVE THE SAME NAME AS A DATASET WHICH IS OPEN          *
*          (AND THUS ENQUED) ON ANOTHER PACK (SUCH AS SYS1.LINKLIB).  *
*          THIS ALSO MAKES IT POSSIBLE TO SCRATCH A DATASET           *
*          WHICH IS REALLY OPEN BY SOME OTHER TASK SO BE VERY         *
*          CAUTIOUS IN USING THIS COMMAND.                            *
*                                                                     *
***********************************************************************
         EJECT
***********************************************************************
*                                                                     *
* FIXDSCB PROGRAM INFORMATION:                                        *
*                                                                     *
*                                                                     *
* FUNCTION: TO MODIFY A DATASETS DSCB ACCORDING TO SUPPLIED           *
*           COMMANDS.  SUPPORTED FUNCTIONS ARE:                       *
*                                                                     *
*           RENAME .......... RENAME A DATASET TO A NEWNAME           *
*           PROTECT ......... TURN ON A DSCB'S PASSWORD BITS          *
*           SETNOPWR ........ TURN ON A DSCB'S NOPASSWORD READ ENABLE *
*           UNLOCK .......... TURN OFF A DSCB'S PASSWORD BITS         *
*           RENEW ........... RESET CREATION DATE TO CURRENT DATE     *
*           EXPIRE .......... SWAP CREATION AND EXPIRATION DATES      *
*           EXTEND .......... SET EXPIRATION DATE TO 99:365           *
*           ZEROEXPD ........ SET EXPIRATION DATE TO 00:000           *
*           SCRATCH ......... DELETE SPECIFIED DATASET                *
*                                                                     *
*           IN ADDITION TO THESE FUNCTIONS A NAME DEFINITION CARD     *
*           FOLLOWED BY SUBCOMMAND CARDS PERTAINING TO THAT           *
*           DATASET MAY BE ENTERED.  VALID SUBCOMMANDS ARE:           *
*                                                                     *
*           RECFM ........... RESET RECORD FORMAT TO THAT SPECIFIED   *
*           LRECL ........... RESET LRECL TO SPECIFIED VALUE          *
*           BLKSIZE ......... RESET BLKSIZE TO SPECIFIED VALUE        *
*           DSORG ........... RESET DSORG TO THAT SPECIFIED           *
*           KEYL ............ RESET KEY LENGTH TO THAT SPECIFIED      *
*           RKP ............. RESET RELATIVE KEY POSITION             *
*           OPTCODE ......... RESET OPTCODE VALUE (SEE JCL MANUAL)    *
*                                                                     *
***********************************************************************
         EJECT
***********************************************************************
*                                                                     *
*    COMMAND FORMATS ARE AS FOLLOWS:                                  *
*                                                                     *
* INPUT IS FREE FORM RESTRICTED ONLY THAT COMMANDS MAY BEGIN IN       *
* COLUMN 1 OR AFTER AND SUBCOMMANDS OF THE NAME COMMAND MUST BEGIN    *
* IN COLUMN 2 OR AFTER.                                               *
* THE KEYWORDS VOLUME, DSNAME, AND NEWNAME MAY APPEAR IN ANY ORDER.   *
*                                                                     *
* AT LEAST ON KEYWORD MUST APPEAR ON THE COMMAND CARD.  COMMAND       *
* CARDS MAY BE CONTINUED ONTO A NEW CARD. CONTINUE CARDS ARE          *
* FREE FORMAT (COL 1-71 MAY BE USED). EMBEDDED BLANKS MAY NOT         *
* APPEAR IN THE KEYWORD STRINGS.  COMMENTS MAY BE ENTERED ON          *
* COMMAND CARDS BY SEPERATING THEM FROM ANY VALUES BY AT LEAST        *
* ONE BLANK.  COMMENT CARDS MAY BE CODED BY PLACING AN ASTERISK       *
* IN COLUMN 1.  COMMENT CARDS MAY APPEAR ANYWHERE IN THE INPUT        *
* STREAM.                                                             *
* NOTE: COLUMN 72 MUST CONTAIN A BLANK AT ALL TIMES                   *
*                                                                     *
* CARD FORMATS:                                                       *
* RENEW   VOLUME=XXXXXX,DSNAME=DATASET-NAME                           *
* PROTECT VOLUME=XXXXXX,DSNAME=DATASET-NAME                           *
* UNLOCK  VOLUME=XXXXXX,DSNAME=DATASET-NAME                           *
* EXPIRE  VOLUME=XXXXXX,DSNAME=DATASET-NAME                           *
* EXTEND  VOLUME=XXXXXX,DSNAME=DATASET-NAME                           *
* RENAME  VOLUME=XXXXXX,DSNAME=DATASET-NAME,NEWNAME=NEW-DATASET-NAME  *
* SCRATCH VOLUME=XXXXXX,DSNAME=DATASET-NAME                           *
* NAME    VOLUME=XXXXXX,DSNAME=DATASET-NAME                           *
*     WHERE:                                                          *
*     XXXXXX IS THE DASD VOLUME SERIAL THAT CONTAINS THE              *
*     DATASET (DSCB) TO BE MODIFIED.                                  *
*     DATASET-NAME IS THE NAME OF THE DATA SET (DSCB) TO              *
*     BE MODIFIED.                                                    *
*     NEW-DATASET-NAME IS THE NEW NAME TO BE ASSIGNED TO THE          *
*     DATASET SPECIFIED BY THE DSNAME KEYWORD (RENAME COMMAND ONLY).  *
*                                                                     *
*        KEYWORDS MAY BE ABBREVIATED AS FOLLOWS:                      *
*                                                                     *
*           DSNAME - DSN OR D                                         *
*           VOLUME - VOL OR V                                         *
*           NEWNAME- NEWN OR N                                        *
*                                                                     *
***********************************************************************
         EJECT
***********************************************************************
*                                                                     *
* NAME COMMAND: SUBCOMMAND SPECIFICATIONS                             *
*                                                                     *
* NAME   VOLUME=XXXXXX,DSNAME=DATASET-NAME  (SEE ABOVE)               *
*       NOTE: THE NAME CARD DEFINES A DATASET DSCB TO BE WORKED ON.   *
*             ALL MODIFICATION CARDS THAT FOLLOW IT PERTAIN TO THAT   *
*             DATASET UNTIL ANOTHER PRIMARY COMMAND IS ENCOUNTERED    *
*             (RENEW, SCRATCH, EXPIRE, ETC...) OR AN END-OF-FILE      *
*             OCCURS.                                                 *
*                                                                     *
*  LRECL=XXXXX    (WHERE XXXXX IS THE DESIRED LRECL)                  *
*  BLKSIZE=XXXXX  (WHERE XXXXX IS THE DESIRED BLOCK SIZE)             *
*  RECFM=XXXXX    (WHERE XXXXX IS THE DESIRED RECORD FORMAT)          *
*                 (SEE RECFMTAB FOR SUPPORTED RECFM VALUES)           *
*  DSORG=XXX      (WHERE XXX IS THE DESIRED DATASET ORGANIZATION)     *
*                 (CAUTION: NO CHECKING IS DONE!)                     *
*                 (SEE DSORGTAB FOR SUPPORTED DSORG VALUES)           *
*  KEYL=XXX       (WHERE XXX IS THE DESIRED KEY LENGTH)               *
*  RKP=XXX        (WHERE XXX IS THE DESIRED RELATIVE KEY POSITION)    *
*  OPTCODE=X      (WHERE X IS THE DESIRED OPTCODE LETTER)             *
*                                                                     *
*             ONLY ONE DSNAME SUBCOMMAND IS ALLOWED PER CARD.         *
*             IF A PARTICULAR SUBCOMMAND IN ENTERED MORE THAN         *
*             ONCE THE LAST OCCURENCE OF THE SUBCOMMAND WILL          *
*             BE THE ONE USED.  IF AN ERROR OCCURS DURING PROCESSING  *
*             OF ANY SUBCOMMAND THE ENTIRE SUBCOMMAND SET             *
*             FOR THE CURRENT NAME COMMAND WILL BE DISCARDED.         *
*                                                                     *
*                                                                     *
***********************************************************************
         EJECT
***********************************************************************
*                                                                     *
*   REGISTER USAGE:                                                   *
*                                                                     *
*     R0 ..... LOCAL USAGE                                            *
*     R1 ..... LOCAL USAGE                                            *
*     R2 ..... LOCAL USAGE                                            *
*     R3 ..... LOCAL USAGE                                            *
*     R4 ..... LOCAL USAGE                                            *
*     R5 ..... POINTER TO CARD KEYWORDS (SCAN POINTER)                *
*     R6 ..... BAL TO CARD SCAN LOGIC (COMCARD)                       *
*     R7 ..... BAL TO SIMPLE COMMON ROUTINES (SKIPB, PUTCARD, ..ETC)  *
*     R8 ..... BAL TO CARD FETCH ROUTINE (GETACARD)                   *
*     R9 ..... ADDRESS DSCB WORKAREA                                  *
*     RA ..... PROGRAM BASE REGISTER 1                                *
*     RB ..... PROGRAM BASE REGISTER 2                                *
*     RC ..... PROGRAM BASE REGISTER 3                                *
*     RD ..... SAVE AREA CHAIN POINTER                                *
*     RE ..... RETURN REG                                             *
*     RF ..... ENTRY REG                                              *
*                                                                     *
***********************************************************************
         EJECT
         MACRO
&NAME    MSGEXIT &SPMSG=,&MSG=,&RETURN=,&ABEND=,&RC=8
         LCLC  &ERRID
         LCLC  &NAMEX
         AIF   ('&SPMSG' NE '').MSGOK
         AIF   ('&MSG' NE '').MSGOK
         MNOTE 8,'** ERROR - NO MESSAGE NUMBER SPECIFIED.'
         MEXIT
.MSGOK   ANOP
         AIF   ('&RETURN' NE '' OR '&ABEND' NE '').RETOK
         MNOTE 8,'** ERROR - NO RETURN LABEL OR ABEND CODE SPECIFIED.'
         MEXIT
.RETOK   ANOP
         AIF   ('&NAME' NE '').NAMEOK
&ERRID   SETC  'ERROR&MSG'
         AGO   .IDSET
.NAMEOK  ANOP
&ERRID   SETC  '&NAME'
.IDSET   ANOP
&ERRID   DS    0H
         ST    RF,RCSAVE
         AIF   ('&RC' EQ '').NORC
         AIF   ('&MSG' EQ '').SPRC
         LA    R0,&RC
         ST    R0,FUNCRC
         C     R0,HIGHRC
         BL    MSGRC&MSG
         ST    R0,HIGHRC
MSGRC&MSG DS   0H
         AGO   .NORC
.SPRC    ANOP
&NAMEX   SETC  'SPRC'.'&SYSNDX'
         LA    R0,&RC
         ST    R0,FUNCRC
         C     R0,HIGHRC
         BL    &NAMEX
         ST    R0,HIGHRC
&NAMEX    DS   0H
.NORC    ANOP
         AIF   ('&SPMSG' NE '').DOSP
         LA    R1,&MSG
         STH   R1,MPLNUM
         XC    MPLSPADR,MPLSPADR
         AGO   .DUMPX
.DOSP    ANOP
         LA    R1,&SPMSG
         ST    R1,MPLSPADR
         XC    MPLNUM,MPLNUM
.DUMPX   ANOP
         BAL   R7,MSGOUT
         AIF   ('&RETURN' EQ '').GODUMP
         B     &RETURN
         MEXIT
.GODUMP  ANOP
         ABEND &ABEND,DUMP
         MEXIT
         MEND
         EJECT
         MACRO
         MSGSETUP &TEXT
         LCLC  &SEQ
&SEQ     SETC  'MSG'.'&SYSNDX'
MSGTABLE CSECT
         DC    A(&SEQ)            ADDRESS OF MESSAGE BUFFER
MSGTEXT  CSECT
&SEQ     DS    0F
         DC    AL2(&SEQ.L)        LENGTH OF TEXT
         DC    X'4000'            MCS FLAGS FOR WTO
&SEQ.B   DC    C&TEXT
&SEQ.L   EQU   *-&SEQ             LENGTH OF WTO MESSAGE SETUP
         MEND
FIXDSCB  TITLE 'FIXDSCB - A DSCB MODIFICATION UTILITY.'
FIXDSCB  CSECT
         SAVE  (14,12),T,*        SAVE REGS
         LR    RA,RF              POINT BASE REGISTER TO ENTRY POINT
         LA    RB,2048(RA)        SET UP
         LA    RB,2048(RB)            SECOND BASE REG
         LA    RC,2048(RB)        SET UP
         LA    RC,2048(RC)            THIRD BASE REG
         USING FIXDSCB,RA,RB,RC   ESTABLISH BASE REGISTERS
         LA    R2,SAVEAREA        POINT TO SAVEAREA
         ST    RD,SAVEAREA+4      POINTER TO CALLERS SAVEAREA
         ST    R2,8(RD)           POINTER TO CALLED SAVEAREA
         LR    RD,R2              STANDARD POINTER TO SAVEAREA
         LR    R2,R1              SAVE ANY PARM POINTER
         EXTRACT TSOWORD,FIELDS=(TSO) CHECK FOR TSO SESSION
         L     R1,TSOWORD         PICK UP BYTE ADDRESS
         TM    0(R1),X'80'        IS TSO SESSION BIT ON?
         BO    SETUPTSO           BRANCH IF SO
         EJECT
*
*        EXECUTION IS BATCH OR STARTED TASK
*
         SPACE 3
         LTR   R2,R2              IS ANY PARM PRESENT
         BZ    NOPARM             BRANCH IF NOT
         L     R1,0(R2)           LOAD PARM POINTER
         LH    R2,0(R1)           PICK UP PARM LEN
         LTR   R2,R2              IS LEN ZERO
         BZ    NOPARM             BRANCH IF SO
         C     R2,FOUR            IS LENGTH = 5
         BNE   ERROR27            BRANCH IF NOT
         CLC   TESTPARM,2(R1)     IS PARM 'TEST'
         BNE   ERROR27            BRANCH IF NOT
         OI    MASTFLAG,TESTONLY
         B     NOPARM
         EJECT
*
*        EXECUTION IS AS A TSO COMMAND PROCESSOR
*
         SPACE 3
SETUPTSO DS    0H
         STAX  DEFER=YES          DISALLOW ATTENTION INTERRUPTS
         OI    IOFLAG,TSOSESS     MARK AS TSO SESSION
         OI    MPLIOF,TSOSESS     FLAG MPL AS WTO I/O REQUIRED
         ST    R2,CPPLHOLD        SAVE CPPL POINTER
         USING CPPL,R2            ADDRESS COMMAND PROCESSOR PARM LIST
         L     R1,CPPLPSCB        GET PSCB ADDRESS
         USING PSCB,R1
         TM    PSCBATR1,PSCBCTRL  DOES USER HAVE OPER AUTHORITY?
         BNO   ERROR36            GET OUT IF NOT
         DROP  R1
         L     R3,CPPLCBUF        PICK UP ADDRESS OF COMMAND BUFFER
         USING CMDBUFR,R3         ADDRESS COMMAND BUFFER
         LH    R1,CMDBLEN         PICK UP BUFFER LENGTH
         S     R1,FOUR            DROP BY 4
         CH    R1,CMDBOFF         COMPARE TO OFFSET
*                                 IF LEN-4=OFFSET THEN NO PARMETERS
*                                 SPECIFIED
         BE    NOPARM
         LH    R1,CMDBOFF         PICK UP OFFSET VALUE
         LA    R1,4(R1,R3)        COMPUTE FIRST PARM ADDRESS
         OC    0(4,R1),BLANKS     SHIFT TO UPPERCASE
         CLC   TESTPARM,0(R1)     IS PARM "TEST"
         BNE   ERROR27            BRANCH TO ERROR IF NOT
         OI    MASTFLAG,TESTONLY
         B     NOPARM
         DROP  R2
         DROP  R3
         EJECT
*
*        INITIALIZE FOR RUN
*
         SPACE 3
NOPARM   DS    0H
         L     R1,CVTPTR          GET ADDRESS OF CVT
         S     R1,PREFIXL         BACKUP TO START OF PREFIX
         USING CVTFIX,R1          ADDRESS CVT AT PREFIX
         CLC   CVTNUMB,MVSCODE    IS THIS AN MVS SYSTEM
         BNE   NONMVS             SKIP IF NOT
         OI    MASTFLAG,MVSSYS    TURN ON MVS FLAG
         DROP  R1
NONMVS   DS    0H
         TM    IOFLAG,TSOSESS     IS THIS A TSO SESSION
         BO    MESSAG33           BRANCH IF SO
         SPACE 1
         XR    R1,R1
         USING PSA,R1             ADDRESS PSA
         L     R1,PSAAOLD         GET OLD ASCB ADDRESS
         DROP  R1
         USING ASCB,R1            ADDRESS OUR ASCB
         L     R1,ASCBCSCB        GET CSCB ADDRESS
         DROP  R1
         USING CHAIN,R1           ADDRESS CSCB
         CLI   CHUCMP,HEXZERO     IS THIS FROM A CONSOLE (STARTED TASK)
         BE    NOCON              BRANCH IF NOT
         OI    IOFLAG,CONSOLE     FLAG AS CONSOLE I/O REQUIRED
         OI    MPLIOF,CONSOLE     FLAG MPL AS WTO I/O REQUIRED
         MVC   CONID,CHUCMP       SAVE CONSOLE ID
         MVC   MPLCON,CONID       SAVE CONSOLE ID IN MPL
         B     MESSAG33           DO NOT OPEN SYSIN/SYSPRINT FOR IO
NOCON    DS    0H
         OPEN  (SYSIN,INPUT)
         OPEN  (SYSPRINT,OUTPUT)
         DROP  R1
         EJECT
*
*        GET A COMMAND CARD AND PARSE IT FOR KEYWORDS
*
         SPACE 3
LOOP1    DS    0H
         BAL   R5,CARDIN
LOOP2    DS    0H
         MVI   MSGCC,LINES3       SET CARRIAGE CONTROL
         BAL   R7,PUTBLANK        GO PRINT BLANK LINE
         BAL   R7,PUTCARD         GO PRINT CARD
         CLI   CARD,ASTERISK      COMMENT CARD?
         BE    LOOP1              SKIP IF SO
         BAL   R7,SKIPB           SKIP LEADING BLANKS ON CARD
         LTR   R5,R5              IS CARD ALL BLANKS
         BZ    LOOP1              BRANCH IF SO
         XC    FUNCRC,FUNCRC      ZERO OUT FUNCTION RETURN CODE
         MVI   DSCBNAME,BLANK     SET DSN TO OMMITTED
         MVI   VOLUME,BLANK       SET VOL TO OMMITTED
         MVI   COMFLAG,HEXZERO    SET COMMAND CARD FLAG TO ZEROS
         BAL   R6,COMCARD         PICK APART THE COMMAND CARD
         TM    MASTFLAG,COMBADF   WAS COMMAND INVALID
         BO    ERROR5
         EJECT
*
*        CHECK THAT ALL REQUIRED KEYWORDS WERE SPECIFIED
*
         SPACE 3
         L     R1,CURRENTF        LOAD CURRENT FUNCTION TABLE ADRS
         L     R1,COMTRKWL(R1)    PICK UP RKW LIST ADRS
         LTR   R1,R1              IS RKW ADRS ZERO (NO KEYWORDS REQRD)
         BZ    LOOPVGO            GET OUT OF LOOP IF SO
         L     R4,0(R1)           PICK UP FIRST KWT ADRS
         XR    R2,R2              CLEAR REGS FOR OR
         XR    R3,R3              CLEAR REGS FOR OR
         IC    R3,COMFLAG         PICK UP COMMAND FLAG
LOOPRKW  DS    0H
         LTR   R4,R4              IS KWT ADRS ZERO
         BZ    LOOPVGO            END OF KW TESTING IF SO
         IC    R2,4(R4)           PICK UP REQUIRED FLAG MASK
         NR    R2,R3              TEST FOR KW SPECIFIED
         BZ    LOOPRERR           BRANCH IF OMMITTED
         LA    R1,4(R1)           BUMP TO NEXT RKW ADRS IN LIST
         L     R4,0(R1)           PICK UP NEXT KWT ADRS
         B     LOOPRKW            CONTINUE
LOOPRERR DS    0H
         L     R2,4(R4)           PICK ERROR ROUTINE ADRS
         BR    R2                 BRANCH TO ERROR ROUTINE
         EJECT
*
*        FIND A DD IN TIOT THAT MATCHES VOLUME REQUESTED
*        NOTE: WE MUST EXTRACT TIOT ADDRESS EACH TIME
*              SINCE IT MIGHT CHANGE DUE TO DYNAMIC ALLOCATION.
*
         SPACE 3
LOOPVGO  DS    0H
         CLI   VOLUME,BLANK       IS A VOLUME PRESENT
         BE    NOVOL              SKIP IF NOT
         EXTRACT TIOTADRS,FIELDS=(TIOT) GET TIOT ADDRESS
         L     R1,TIOTADRS        PICK UP TIOT ADDRESS
         USING TIOT1,R1           ADDRESS TIOT
         XR    R3,R3              CLEAR INDEX REG
LOOPVOL  DS    0H
         L     R2,TIOESTTB        PICK UP TIOT ENTRY UCB ADDRESS
         USING UCBCMSEG,R2        ADDRESS UCB
         CLC   VOLUME,UCBVOLI     VOLUME MATCH
         BE    FOUNDV             BRANCH IF SO
         IC    R3,TIOELNGH        PICK UP ENTRY LENGTH
         LA    R1,0(R3,R1)        BUMP TO NEXT TIOT ENTRY
         CLI   TIOELNGH,HEXZERO   END OF TIOT?
         BE    CKMVS              GO CHECK FOR MVS SYSTEM
         B     LOOPVOL            CONTINUE SEARCH
         SPACE 2
FOUNDV   DS    0H
         MVC   VOLUNIT,UCBTYP     SAVE UNIT TYPE IN FOR LATER
         DROP  R2                 DROP ADDRESSABILITY TO UCB
         LA    R2,XDAPDCB         GET ADDRESS OF VTOC DCB
         USING IHADCB,R2          ADDRESS XDAP DCB
         MVC   DCBDDNAM,TIOEDDNM  MOVE IN DDNAME
         B     GETJFCB            GO GET THE XDAP DCB JFCB
         DROP  R2                 DROP ADDRESSABILITY TO DCB
         DROP  R1                 DROP ADDRESSABILITY TO TIOT
         EJECT
*
*        CHECK FOR MVS OPERATING SYSTEM
*        IF MVS THEN DYNAMICALLY  ALLOCATE VOLUME REQUIRED
*
         SPACE 3
CKMVS    DS    0H
         TM    MASTFLAG,MVSSYS    IS THIS MVS
         BO    ALOCDYN            ALLOCATE DYNAMICALLY
         TM    IOFLAG,TSOSESS     IS THIS A TSO SESSION
         BO    ALOCDAIR           GO ALLOCATE WITH DAIR IF SO
         B     ERROR29            CANNOT DYNAMICALLY ALLOCATE
         SPACE 3
ALOCDYN  DS    0H
         XC    S99F1,S99F1        CLEAR SVC 99 RB FLAG1
         XC    S99F2,S99F2        CLEAR SVC 99 RB FLAG2
         LA    R1,S99RBPTR        LOAD ADDRESS OF RB POINTER
         DYNALLOC
         LTR   RF,RF              CHECK SVC 99 RETURN CODES
         BNZ   DYNERROR           BRANCH IF BAD
         CLC   S99ERROR,ZERO      CHECK ERROR CODE
         BNE   DYNERROR           BRANCH IF BAD
         B     SETDDN
         EJECT
*
*        SET UP SPECIAL MESSAGE FOR DYNAMIC ALLOCATION FAILURE
*
         SPACE 3
DYNERROR DS    0H
         ST    RF,DYNRETC         STORE RETURN CODE IN HOLDER
         BAL   R7,FIXDIGIT        GO FIX RC
         STCM  RF,15,SPMSG3R1     STORE IN MESSAGE
         LH    RF,S99ERROR        PICK UP ERROR CODE
         BAL   R7,FIXDIGIT        GO FIX IT
         STCM  RF,15,SPMSG3R2     STORE IN MESSAGE
         LH    RF,S99INFO         PICK UP INFORMATION CODE
         BAL   R7,FIXDIGIT        GO FIX IT
         STCM  RF,15,SPMSG3R3     STORE IN MESSAGE
         MVI   DFFLAGS+1,X'32'    FLAG AS SVC99 REQUEST
         LA    R1,S99RB
         ST    R1,DFS99RB         STORE SVC 99 RB ADDRS IN DF BLOCK
         LA    R1,DFS99RB         GET ADDRESS OF DF PARM BLOCK
         LINK  EP=IKJEFF18
         LTR   RF,RF              EXTRACT WORK OK
         BZ    DOS99ER
         XC    DFBUFL1(2),DFBUFL1 CLEAR BUFFER LENGTH OF DF MSG
         XC    DFBUFL2(2),DFBUFL2 CLEAR BUFFER LENGTH OF DF MSG
         B     ERROR12
DOS99ER  DS    0H
         MVI   DFBUF01,X'40'      SET DF BUFFERS INTO WTO FORMAT
         MVI   DFBUF01+1,X'00'
         MVI   DFBUF02,X'40'
         MVI   DFBUF02+1,X'00'
         B     ERROR12
         EJECT
*
*        ALLOCATE THE VOLUME FOR TSO SESSION USING DAIR
*
*        NOTE: DAIR IS USED INSTEAD OF SVC 99 TO MAINTAIN
*              NON-MVS COMPATIBILITY.
*
         SPACE 3
ALOCDAIR DS    0H
         XC    DECB,DECB          CLEAR DAIR ECB
         L     R2,CPPLHOLD
         USING CPPL,R2 ADDRESS CPPL
         LA    R1,DAPLIST
         USING DAPL,R1
         MVC   DAPLUPT,CPPLUPT    MOVE IN UPT ADDRESS
         MVC   DAPLECT,CPPLECT    MOVE IN ECT ADDRESS
         MVC   DAPLPSCB,CPPLPSCB  MOVE IN PSCB ADDRESS
         LINK  EP=IKJDAIR         INVOKE DAIR
         LTR   RF,RF              DAIR WORK
         BZ    SETDDN             BRANCH SO
         EJECT
*
*        SET UP SPECIAL MESSAGE FOR DAIR ALLOCATION FAILURE
*
         SPACE 3
DAIREROR DS    0H
         ST    RF,DYNRETC         STORE DAIR RETURN CODE
         BAL   R7,FIXDIGIT        GO FIX RC
         STCM  RF,15,SPMSG4R1     STORE IN MESSAGE
         LH    RF,DA08DARC        PICK UP ERROR CODE
         BAL   R7,FIXDIGIT        GO FIX IT
         STCM  RF,15,SPMSG4R2     STORE IN MESSAGE
         LH    RF,DA08CTRC        PICK UP CATALOG CODE
         BAL   R7,FIXDIGIT        GO FIX IT
         STCM  RF,15,SPMSG4R3     STORE IN MESSAGE
         MVI   DFFLAGS+1,X'01'    FLAG AS SVC99 REQUEST
         LA    R1,DA08CD          PICK UP DAIR 08 BLOCK
         ST    R1,DFDAPLP         STORE DAIR RB ADDRS IN DF BLOCK
         LA    R1,DFDAPLP         GET ADDRESS OF DF PARM BLOCK
         LINK  EP=IKJEFF18
         LTR   RF,RF              EXTRACT WORK OK
         BZ    DODAIRER
         XC    DFBUFL1(2),DFBUFL1 CLEAR BUFFER LENGTH OF DF MSG
         XC    DFBUFL2(2),DFBUFL2 CLEAR BUFFER LENGTH OF DF MSG
         B     ERROR39
DODAIRER DS    0H
         MVI   DFBUF01,X'40'      SET DF BUFFERS INTO WTO FORMAT
         MVI   DFBUF01+1,X'00'
         MVI   DFBUF02,X'40'
         MVI   DFBUF02+1,X'00'
         B     ERROR39
         DROP  R2
         DROP  R1
         EJECT
*
*        SET UP THE DDNAME IN THE DCB
*
         SPACE 3
SETDDN   DS    0H
         LA    R2,XDAPDCB         GET ADDRESS OF DCB
         USING IHADCB,R2          ADDRESS IT
         MVC   DCBDDNAM,BLANKS    BLANK OUT DDNAME
         MVC   DCBDDNAM(6),VOLUME MAKE VOLSER DDNAME ALSO
         DROP  R2                 DROP DCB ADDRESSABILITY
         CLC   COMMAND,SCRTCH     IS THIS A SCRATCH COMMAND
         BE    LOOPVGO            IF SO, GO BACK THROUGH TIOT VOLUME
*                                 SEARCH TO PICK UP UCB DEVICE TYPE
         EJECT
*
*        GET THE JFCB FOR THE DD FOUND AND OPEN THE VTOC
*
         SPACE 3
GETJFCB  DS    0H
         RDJFCB (XDAPDCB,(UPDAT)) GET THE JFCB
         LTR   RF,RF              DID WE REALLY GET IT ??
         BNZ   ERROR1
         LA    R1,JFCBAREA        GET ADDRESS OF INTERNAL JFCB
         USING JFCBDSCT,R1        ADDRESS JFCB
         MVI   JFCBDSNM,HEXFOUR   FIX UP THE DSNAME
         MVC   JFCBDSNM+1(43),JFCBDSNM          OF THE VTOC
         OI    JFCBTSDM,JFCNWRIT  DO NOT MERGE BACK
         OI    JFCBOPS1+4,JFCBMOD FLAG JFCB AS MODIFIED
         DROP  R1                 DROP JFCB ADDRESSABILITY
         OPEN  (XDAPDCB,(UPDAT)),TYPE=J  OPEN THE VTOC
         LA    R1,XDAPDCB         PICK UP DCB ADDRESS
         USING IHADCB,R1          ADDRESS DCB
         TM    DCBOFLGS,DCBOFOPN  DID OPEN WORK
         BNO   ERROR31            BRANCH IF NOT
         DROP  R1
         EJECT
*
*        FIND THE CCHHR OF THE DATASETS DSCB IN THE VTOC VIA OBTAIN
*
         SPACE 3
NOVOL    DS    0H
         CLI   DSCBNAME,BLANK     IS A VOLUME PRESENT
         BE    NODSN              SKIP IF NOT
         OBTAIN DSCBADDR          GET CCHHR OF DSCB
         LTR   RF,RF              DID WE GET IT ???
         BNZ   ERROR2
         EJECT
*
*        READ THE DSCB FOR DATASET FROM VTOC VIA XDAP READ
*
         SPACE 3
         MVC   XDAPBLRF+3(5),WORKAREA+96  LOAD CCHHR FOR XDAP I/O
         PRINT NOGEN
         XDAP  XDAPRECB,RI,XDAPDCB,WORKAREA,140,(WORKAREA,44),XDAPBLRF
         PRINT GEN
         WAIT  ECB=XDAPRECB       ISSUE THE WAIT FOR XDAP I/O
         CLI   XDAPRECB,XDAPGOOD  WAS THE READ SUCCESSFUL ???
         BNE   ERROR3
         LA    R9,WORKAREA        GET ADDRESS OF DSCB WORKAREA
         USING DSCB,R9            ADDRESS DSCB
         EJECT
*
*        FIND THE ADDRESS OF THE ROUTINE TO PROCESS THE COMMAND
*        IN THE COMMAND TABLE.
*
         SPACE 3
NODSN    DS    0H
         L     R2,CURRENTF        RELOAD FUNCTION TABLE ADDRESS
         L     R2,COMTADR(R2)     GET ADDRESS OF COMMAND ROUTINE
         BR    R2
         EJECT
*
*        RENEW THE CREATION DATE TO TODAYS DATE
*
         SPACE 3
RENEW    DS    0H
         TIME  DEC                GET THE TIME AND DATE
         MVC   THYMEOYR,PACK8ZRO  ZERO OUT THE YEAR
         MVC   DAYTHYME,PACK8ZRO  ZERO OUT THE DAY
         STH   R1,DAYTHYME+6      CONVERT TO USABLE FORMAT
         SRL   R1,8
         IC    R1,MASKC0
         SRL   R1,R4
         STH   R1,THYMEOYR+6
         CVB   R1,DAYTHYME
         ST    R1,DAYTHYME+4
         CVB   R1,THYMEOYR
         ST    R1,THYMEOYR+4
         MVC   DS1CREDT(1),THYMEOYR+7    MOVE IN YEAR
         MVC   DS1CREDT+1(2),DAYTHYME+6  MOVE IN DAY OF YEAR
         B     WRITDSCB
         EJECT
*
*        SWAP THE CREATION AND EXPIRATION DATE FIELDS
*
         SPACE 1
EXPIRE   XC    DS1CREDT,DS1EXPDT  INVERT
         XC    DS1EXPDT,DS1CREDT         TWO
         XC    DS1CREDT,DS1EXPDT              FIELDS
         B     WRITDSCB
         SPACE 3
*
*        SET THE EXPIRATION DATE TO 00:000
*
         SPACE 1
ZEROEXPD DS    0H
         MVC   DS1EXPDT,ZERODATE
         B     WRITDSCB
         SPACE 3
*
*        SET THE EXPIRATION DATE TO 99:365
*
         SPACE 1
EXTEND   DS    0H
         MVC   DS1EXPDT,MAXDATE
         B     WRITDSCB
         EJECT
*
*        SET THE PASSWORD PROTECTION BITS FOR FULL PROTECTION
*
         SPACE 1
PROTECT  OI    DS1DSIND,DS1IND10
         NI    DS1DSIND,FULLMASK-DS1IND04
         B     WRITDSCB
         SPACE 3
*
*        SET THE PASSWORD PROTECTION BITS FOR READ ONLY ACCESS ALLOWED
*
         SPACE 1
SETNOPWR OI    DS1DSIND,DS1IND10
         OI    DS1DSIND,DS1IND04
         B     WRITDSCB
         SPACE 3
*
*        SET THE PASSWORD PROTECTION BIT OFF
*
         SPACE 1
UNLOCK   NI    DS1DSIND,FULLMASK-DS1IND10
         NI    DS1DSIND,FULLMASK-DS1IND04
         B     WRITDSCB
         EJECT
*
*        CHANGE THE DSNAME TO A NEW NAME
*
         SPACE 1
RENAME   DS    0H
         MVC   DS1DSNAM,NEWNAME
         B     WRITDSCB
         EJECT
*
*        PERFORM SCRATCH REQUEST
*
*        LOGIC: DATASET IS RENAMED TO 'FIXDSCB.SCRATCH.DATASET',
*               ANY PASSWORD PROTECTION BITS ARE TURNED OFF,
*               AND THE EXPIRATION DATE IS RESET TO ZERO.
*               THE MODIFIED DATASET IS THEN DELETED VIA
*               A SCRATCH SVC.
*
         SPACE 1
SCRATCH  DS    0H
         MVC   DS1DSNAM,TEMPNAME  MOVE TEMPNAME TO DSCB
         NI    DS1DSIND,FULLMASK-DS1IND10 TURN OFF ANY
         NI    DS1DSIND,FULLMASK-DS1IND04        PASSWORD BITS
         MVC   DS1EXPDT,ZERODATE  SET EXPDT TO ZERO
         TM    MASTFLAG,TESTONLY  IS THIS A TEST
         BO    MESSAG28           SKIP IF SO
         SCRATCH SCRLIST          SCRATCH ANY REMAINING TEMP DATASET
         PRINT NOGEN
         XDAP  XDAPWSCR,WI,XDAPDCB,WORKAREA,140,(WORKAREA,44),XDAPBLRF
         PRINT GEN
         SPACE 3
*
*        WAIT FOR RENAME TO COMPLETE AND THEN SCRATCH THE
*        RENAMED DATASET.
*
         SPACE 1
         WAIT  ECB=XDAPWSCR       ISSUE WAIT FOR XDAP I/O
         CLI   XDAPWSCR,XDAPGOOD  WAS IT SUCCESSFUL ??
         BNE   ERROR35            IF NOT GET OUT.
         CLOSE XDAPDCB            CLOSE VTOC
         XR    R0,R0              ZERO REG 0 FOR SCRATCH (NO UCB)
         SCRATCH SCRLIST          ISSUE SCRATCH REQUEST
         LTR   RF,RF              SCRATCH WORK OK
         BZ    FUNCMSG            BRANCH IF SO
         SPACE 1
* IF SCRATCH FAILED PRINT A MESSAGE AND ABEND
         ST    RF,FUNCRC          SAVE AS FUNCTION RETURN CODE
         CVD   RF,DOUBLE
         UNPK  SPMSG2R1,DOUBLE
         OI    SPMSG2R1+3,SIGN    MAKE SIGN PRINTABLE
         LH    RF,VOLSTAT         PICK UP REASON CODE
         CVD   RF,DOUBLE
         UNPK  SPMSG2R2,DOUBLE
         OI    SPMSG2R2+3,SIGN    MAKE SIGN PRINTABLE
         B     MSGSP2             GO PRINT SPECIAL MESSAGE
         EJECT
*
*        PROCESS NAME SUBCOMMANDS
*
         SPACE 3
NAME     DS    0H
         OI    MASTFLAG,GETSUBC   FLAG GET AS SUBCOMMAND REQUEST
         BAL   R8,GETACARD        GO GET A SUBCOMMAND CARD
         NI    MASTFLAG,FULLMASK-GETSUBC TURN OFF SUBC REQUEST FLAG
         BAL   R7,SKIPB           SKIP LEADING BLANKS ON SUBCOMMAND
         LTR   R5,R5              ALL BLANKS (IMPOSSIBLE)
         BZ    NAME               SKIP IF SO
         LA    R2,SUBTABLE        GET ADDRESS OF SUBCOMMAND TABLE
SUBTCK   DS    0H
         CLI   0(R2),BLANK        END OF TABLE?
         BE    SUBTPRIM           BRANCH IF SO
         L     R3,SUBTSCL(R2)     LOAD LENGTH OF SUBCOMMAND
         BCTR  R3,0               DROP FOR EXECUTE
         EX    R3,SUBCTEST        TEST FOR SUBCOMMAND
         BNE   SUBTNO
* PRINT VALID SUBCOMMAND CARD
         MVI   MSGCC,LINES1       SET CARRIAGE CONTROL
         BAL   R7,PUTCARD
         L     R2,SUBTADR(R2)     LOAD ADDRESS OF ROUTINE
         BR    R2
SUBTNO   DS    0H
         LA    R2,SUBTLEN(R2)     BUMP TO NEXT ENTRY
         B     SUBTCK
         EJECT
*
*        CHECK IF UNKNOWN SUBCOMMAND IS REALLY A PRIMARY COMMAND
*
         SPACE 1
SUBTPRIM DS    0H
         OI    MASTFLAG,PARTSCAN  SET FOR COMMAND SCAN ONLY
         BAL   R6,COMCARD
         NI    MASTFLAG,FULLMASK-PARTSCAN TURN OFF PARTSCAN FLAG
         TM    MASTFLAG,COMBADF WAS COMMAND INVALID
         BO    ERROR9
         LA    R2,COMTABLE        GET ADDRESS OF COMMAND TABLE
SUBTPRM2 DS    0H
         CLI   0(R2),BLANK        END OF TABLE
         BE    SUBTBAD            MUST BE BAD SUBCOMMAND
         CLC   COMMAND2,0(R2)     IS THIS A PRIMARY COMMAND
         BE    SUBTPRMF           YES, GET OUT OF LOOP
         LA    R2,COMTLEN(R2)     BUMP TO NEXT EXTRY
         B     SUBTPRM2
SUBTPRMF DS    0H
         OI    MASTFLAG,PRIMEND   FLAG NAME ENDED BY PRIMARY COMMAND
         B     WRITDSCB
SUBTBAD  DS    0H
*        PRINT INVALID SUBCOMMAND CARD
         MVI   MSGCC,LINES1       SET CARRIAGE CONTROL
         BAL   R7,PUTCARD
         B     ERROR9
         EJECT
*
*        RESET THE LRECL TO THE SPECIFIED VALUE
*
         SPACE 1
LRECL    DS    0H
         LA    R5,5(R5)           SKIP PAST LRECL KEYWORD
         CLI   0(R5),EQUAL        IS IT AN = SIGN
         BNE   ERROR9             SKIP IF NOT
         LA    R5,1(R5)           SKIP THE =
         LR    R3,R5              SAVE START OF LRECL
LRECLL1  DS    0H
         CLI   0(R3),BLANK        END OF NUMBER
         BE    LRECLEND
         LA    R3,1(R3)           BUMP TO NEXT COL
         B     LRECLL1            CONTINUE
         SPACE 1
LRECLEND DS    0H
         SR    R3,R5              CALCULATE LENGTH
         C     R3,ONE             IS IT ZERO
         BL    NAME               SKIP CARD IF SO
         BCTR  R3,0               DROP FOR EXECUTE
         EX    R3,LRECLPCK        PACK THE LRECL VALUE
         CVB   R3,DOUBLE          CONVERT LRECL TO BINARY
         C     R3,BIGLRECL        IS LRECL TOO BIG
         BH    ERROR10            BRANCH IF SO
         STH   R3,DS1LRECL        STORE IN DSCB
         OI    COMFLAG,REWRITE    FLAG DSCB TO BE REWRITTEN
         B     NAME               GO BACK FOR ANOTHER CARD
         EJECT
*
*        RESET THE BLKSIZE TO THE SPECIFIED VALUE
*
         SPACE 1
BLKSIZE  DS    0H
         LA    R5,7(R5)           SKIP PAST BLKSIZE KEYWORD
         CLI   0(R5),EQUAL        IS IT AN = SIGN
         BNE   ERROR9             SKIP IF NOT
         LA    R5,1(R5)           SKIP THE =
         LR    R3,R5              SAVE START OF BLKSIZE
BLKSZL1  DS    0H
         CLI   0(R3),BLANK        END OF NUMBER
         BE    BLKSZEND
         LA    R3,1(R3)           BUMP TO NEXT COL
         B     BLKSZL1            CONTINUE
         SPACE 1
BLKSZEND DS    0H
         SR    R3,R5              CALCULATE LENGTH
         C     R3,ONE             IS IT ZERO
         BL    NAME               SKIP CARD IF SO
         BCTR  R3,0               DROP FOR EXECUTE
         EX    R3,BLKSZPCK        PACK THE BLKSIZE VALUE
         CVB   R3,DOUBLE          CONVERT BLKSIZE TO BINARY
         C     R3,BIGLRECL        IS BLKSIZE TOO BIG
         BH    ERROR11            BRANCH IF SO
         STH   R3,DS1BLKL         STORE IN DSCB
         OI    COMFLAG,REWRITE    FLAG DSCB TO BE REWRITTEN
         B     NAME               GO BACK FOR ANOTHER CARD
         EJECT
*
*        RESET THE RECORD FORMAT TO THAT SPECIFIED
*
         SPACE 1
RECFM    DS    0H
         LA    R5,5(R5)           SKIP PAST RECFM KEYWORD
         CLI   0(R5),EQUAL        IS IT AN = SIGN
         BNE   ERROR9             SKIP IF NOT
         LA    R5,1(R5)           SKIP THE =
         LR    R3,R5              SAVE START OF RECMF
         MVC   RECFMH(5),0(R5)    MOVE RECFM TO HOLDER
         LA    R2,RECFMTAB        GET ADDRESS OF RECFM TABLE
RECFMLP  DS    0H
         CLI   0(R2),BLANK        END OF TABLE
         BE    ERROR21            ERROR IF SO
         CLC   RECFMH,0(R2)       RECFM MATCH TABLE ENTRY
         BE    RECFMFND           BRANCH IF SO
         LA    R2,RECFMLEN(R2)    BUMP TO NEXT ENTRY
         B     RECFMLP
RECFMFND DS    0H
         MVC   DS1RECFM,RECFMASK(R2) MOVE MASK BYTE TO DSCB
         OI    COMFLAG,REWRITE    FLAG DSCB TO BE REWRITTEN
         B     NAME               GO BACK FOR ANOTHER CARD
         EJECT
*
*        RESET THE OPTCODE TO THAT SPECIFIED
*
         SPACE 1
OPTCODE  DS    0H
         LA    R5,7(R5)           SKIP PAST OPTCODE KEYWORD
         CLI   0(R5),EQUAL        IS IT AN = SIGN
         BNE   ERROR9             SKIP IF NOT
         LA    R5,1(R5)           SKIP THE =
         LR    R3,R5              SAVE START OF OPTCODE
         MVC   OPTCODEH(1),0(R5)  MOVE OPTCODE TO HOLDER
         LA    R2,OPTCODET        GET ADDRESS OF OPTCODE TABLE
OPTCODEL DS   0H
         CLI   0(R2),BLANK        END OF TABLE
         BE    ERROR34            ERROR IF SO
         CLC   OPTCODEH,0(R2)     OPTCODE MATCH TABLE ENTRY
         BE    OPTCODEF           BRANCH IF SO
         LA    R2,OPTCLEN(R2)     BUMP TO NEXT ENTRY
         B     OPTCODEL
OPTCODEF DS  0H
         MVC   DS1OPTCD,OPTCMASK(R2) MOVE MASK BYTE TO DSCB
         OI    COMFLAG,REWRITE    FLAG DSCB TO BE REWRITTEN
         B     NAME               GO BACK FOR ANOTHER CARD
         EJECT
*
*        RESET THE DSORG TO THAT SPECIFIED
*
         SPACE 1
DSORG    DS    0H
         LA    R5,5(R5)           SKIP PAST DSORG KEYWORD
         CLI   0(R5),EQUAL        IS IT AN = SIGN
         BNE   ERROR9             SKIP IF NOT
         LA    R5,1(R5)           SKIP THE =
         LR    R3,R5              SAVE START OF RECMF
         MVC   DSORGH(5),0(R5)    MOVE DSORG TO HOLDER
         LA    R2,DSORGTAB        GET ADDRESS OF DSORG TABLE
DSORGLP  DS    0H
         CLI   0(R2),BLANK        END OF TABLE
         BE    ERROR22            ERROR IF SO
         CLC   DSORGH,0(R2)       DSORG MATCH TABLE ENTRY
         BE    DSORGFND           BRANCH IF SO
         LA    R2,DSORGLEN(R2)    BUMP TO NEXT ENTRY
         B     DSORGLP
DSORGFND DS    0H
         MVC   DS1DSORG(1),3(R2)  MOVE DSORG MASK TO DSCB
         OI    COMFLAG,REWRITE    FLAG DSCB TO BE REWRITTEN
         B     NAME               GO BACK FOR ANOTHER CARD
         EJECT
*
*        RESET THE KEYL TO THE SPECIFIED VALUE
*
         SPACE 1
KEYL     DS    0H
         LA    R5,4(R5)           SKIP PAST KEYL KEYWORD
         CLI   0(R5),EQUAL        IS IT AN = SIGN
         BNE   ERROR9             SKIP IF NOT
         LA    R5,1(R5)           SKIP THE =
         LR    R3,R5              SAVE START OF KEYL
KEYLL1   DS    0H
         CLI   0(R3),BLANK        END OF NUMBER
         BE    KEYLEND
         LA    R3,1(R3)           BUMP TO NEXT COL
         B     KEYLL1             CONTINUE
         SPACE 1
KEYLEND  DS    0H
         SR    R3,R5              CALCULATE LENGTH
         C     R3,ONE             IS IT ZERO
         BL    NAME               SKIP CARD IF SO
         BCTR  R3,0               DROP FOR EXECUTE
         EX    R3,KEYLPCK         PACK THE KEYL VALUE
         CVB   R3,DOUBLE          CONVERT KEYL TO BINARY
         C     R3,BIGKEYL         IS KEYL TOO BIG
         BH    ERROR23            BRANCH IF SO
         STC   R3,DS1KEYL         STORE IN DSCB
         OI    COMFLAG,REWRITE    FLAG DSCB TO BE REWRITTEN
         B     NAME               GO BACK FOR ANOTHER CARD
         EJECT
*
*        RESET THE RELATIVE KEY POSITION TO THE SPECIFIED VALUE
*
         SPACE 1
RKP      DS    0H
         LA    R5,3(R5)           SKIP PAST RKP KEYWORD
         CLI   0(R5),EQUAL        IS IT AN = SIGN
         BNE   ERROR9             SKIP IF NOT
         LA    R5,1(R5)           SKIP THE =
         LR    R3,R5              SAVE START OF RKP
RKPL1    DS    0H
         CLI   0(R3),BLANK        END OF NUMBER
         BE    RKPEND
         LA    R3,1(R3)           BUMP TO NEXT COL
         B     RKPL1              CONTINUE
         SPACE 1
RKPEND   DS    0H
         SR    R3,R5              CALCULATE LENGTH
         C     R3,ONE             IS IT ZERO
         BL    NAME               SKIP CARD IF SO
         BCTR  R3,0               DROP FOR EXECUTE
         EX    R3,RKPPCK          PACK THE RKP VALUE
         CVB   R3,DOUBLE          CONVERT RKP TO BINARY
         C     R3,BIGRKP          IS RKP TOO BIG
         BH    ERROR24            BRANCH IF SO
         STCM  R3,3,DS1RKP        STORE IN DSCB
         OI    COMFLAG,REWRITE    FLAG DSCB TO BE REWRITTEN
         B     NAME               GO BACK FOR ANOTHER CARD
         EJECT
*
*        END THE NAME SUBCOMMAND SET
*
         SPACE 3
ENDNAME  DS    0H
         SPACE 5
*
*        WRITE THE DSCB BACK OUT
*
         SPACE 3
WRITDSCB DS    0H
         CLC   COMMAND,COMNAME    NAME SUBCOMMAND SET?
         BNE   WRITEIT            BRANCH IF NOT
         TM    COMFLAG,REWRITE    WAS DSCB MODIFIED
         BNO   ERROR30            DO NOT WRITE IT IF NOT
WRITEIT  DS    0H
         TM    MASTFLAG,TESTONLY  IS THIS A TEST
         BO    MESSAG28           SKIP IF SO
         PRINT NOGEN
         XDAP  XDAPWECB,WI,XDAPDCB,WORKAREA,140,(WORKAREA,44),XDAPBLRF
         PRINT GEN
         EJECT
*
*        WAIT FOR DSCB WRITE TO COMPLETE AND THEN CLOSE VTOC,
*        PRINT MESSAGE, AND RETURN FOR A NEW COMMAND.
*
         SPACE 3
         WAIT  ECB=XDAPWECB       ISSUE WAIT FOR XDAP I/O
         CLI   XDAPWECB,XDAPGOOD  WAS IT SUCCESSFUL ??
         BNE   ERROR4             IF NOT GET OUT.
         SPACE 1
CLOSEX   DS    0H
         CLOSE XDAPDCB
         EJECT
*
*        ISSUE THE FUNCTION COMPLETED MESSAGE
*
         SPACE 3
FUNCMSG  DS    0H
         CLC   FUNCRC,ZERO        WAS COMMAND SUCCESSFUL
         BE    MESSAG32           PRINT MESSAGE IF SO
FUNCMSG2 DS    0H
         L     R1,FUNCRC
         CVD   R1,DOUBLE
         UNPK  SPMSG0R,DOUBLE
         OI    SPMSG0R+3,SIGN     MAKE SIGN PRINTABLE
         B     MSGSP0
FUNCMEND DS    0H
         NI    MASTFLAG,FULLMASK-COMBADF TURN OFF ANY BAD COMMAND FLAG
         TM    MASTFLAG,GETSUBC   DID EODAD OCCUR DURING SUBC PRCS
         BO    CLOSE2             GET OUT IF SO
         TM    MASTFLAG,PRIMEND   WAS A PRIMARY COMMAND FOUND
         BNO   LOOP1              BRANCH IF NOT
         NI    MASTFLAG,FULLMASK-PRIMEND TURN OFF FLAG
         B     LOOP2              GO PROCESS ENCOUNTERED COMMAND
         EJECT
*
*        CLOSE THE FILES AND TERMINATE
*
         SPACE 3
END      DS    0H
CLOSE    DS    0H
         TM    MASTFLAG,GETSUBC   WAS GET FOR A SUBCOMMAND
         BO    WRITDSCB           GO FINISH NAME COMMAND IF SO
         TM    MASTFLAG,CARD2TRY  WAS GET FOR A CONTINUATION CARD
         BO    ERROR25            BRANCH IF SO
CLOSE2   DS    0H
         L     R1,HIGHRC
         C     R1,FUNCRC
         BH    GOTRC
         L     R1,FUNCRC
GOTRC    DS    0H
         CVD   R1,DOUBLE
         UNPK  SPMSG1R,DOUBLE
         OI    SPMSG1R+3,SIGN     MAKE SIGN PRINTABLE
         B     MSGSP1             GO PRINT SPECIAL MESSAGE
CLOSEND  DS    0H
         TM    IOFLAG,CONSOLE     CONSOLE I/O USED
         BO    RETURN
         TM    IOFLAG,TSOSESS     TSO I/O USED
         BO    RETURN
         CLOSE SYSIN
         CLOSE SYSPRINT
RETURN   DS    0H
         L     RF,HIGHRC          GET RETURN CODE
         L     13,SAVEAREA+4      POINT TO CALLERS SAVEAREA
         RETURN (14,12),T,RC=(15) STANDARD RETURN
         EJECT
*
*        PARSE A COMMAND CARD FOR KEYWORDS
*
         SPACE 3
COMCARD  DS    0H
         MVC   COMMAND,BLANKS     BLANK OUT COMMAND NAME HOLDER
         MVC   COMMAND2,BLANKS    BLANK OUT COMMAND NAME HOLDER
         LR    R3,R5              GET START OF CARD
         LA    R4,9               SET MAX COMMAND NAME LENGTH
COMCLOOP DS    0H
         CLI   0(R3),BLANK        BLANK?
         BE    COMCEND            YES, END OF COMMAND NAME
         CLI   0(R3),EQUAL        INVALID =?
         BE    COMBAD             YES, FLAG AS BAD
         LA    R3,1(R3)           BUMP TO NEXT CARD COLUMN
         BCT   R4,COMCLOOP
         B     COMBAD             GO FLAG AS BAD
COMCEND  DS    0H
         LA    R4,1(R3)           SAVE ADDRESS OF NEXT BYTE
         SR    R3,R5              SUBTRACT TO GEN COMMAND LENGTH
         ST    R3,COMLEN          SAVE LENGTH OF COMMAND
         BCTR  R3,0               DROP FOR EXECUTE
         TM    MASTFLAG,PARTSCAN  COMMAND SCAN ONLY?
         BO    COMMOVE2
         EX    R3,COMMOVE         MOVE IN COMMAND NAME
         B     COMPRECK
         SPACE 1
COMMOVE2 DS    0H
         EX    R3,COM2MOVE        MOVE IN COMMAND NAME
         BR    R6
         SPACE 1
COMBAD   DS    0H
         OI    MASTFLAG,COMBADF SET BAD COMMAND FLAG
         BR    R6
         EJECT
*
*        CHECK THE COMMAND VERB FOR ONE THAT WE RECOGNIZE.
*
         SPACE 3
COMPRECK DS    0H                 SEARCH FOR A KEYWORD AFTER COMMAND
         LA    R2,COMTABLE        GET ADDRESS OF COMMAND TABLE
COMPREF  DS    0H
         CLI   0(R2),BLANK        END OF TABLE
         BE    COMBAD             ERROR IF SO
         CLC   COMMAND,0(R2)      IS THIS THE COMMAND
         BE    COMKEYSR           YES, GET OUT OF LOOP
         LA    R2,COMTLEN(R2)     BUMP TO NEXT EXTRY
         B     COMPREF
         EJECT
*
*        SEARCH THE CARD FOR KEYWORDS
*
         SPACE 3
COMKEYSR DS    0H
         ST    R2,CURRENTF        SAVE TABLE ENTRY ADDRESS
         LA    R1,71              LOAD TOTAL CARD LENGTH - 1
         S     R1,COMLEN          SUBTRACT OFF COMMAND LENGTH
COMKEYSX DS    0H                 SEARCH FOR A KEYWORD AFTER COMMAND
*                                 ONLY KEYWORDS ALLOWED ARE:
*                                   DSNAME=, DSN=, D=
*                                   VOLUME=, VOL=, V=
*                                   NEWNAME=, NEWN=, NN=, N=
*
         SPACE 1
         LR    R5,R4              SAVE ADDRESS OF POSSIBLE KEYW START
         CLI   0(R4),BLANK        BLANK?
         BNE   COMCKWT            NO
         LA    R4,1(R4)           BUMP TO NEXT COL
         BCT   R1,COMKEYSX
         SPACE 1
*        THE REST OF THE CARD WAS BLANK.  IS THIS AN ERROR?
         L     R2,COMTRKWL(R2)    PICK UP KWT LIST ADDRESS
         LTR   R2,R2              IS IT ZERO (NO KEYWORDS REQUIRED)
         BZR   R6                 RETURN IF SO
         B     ERROR38            ERROR IF NOT
         EJECT
*
*        TEST IF ANY OF THE REQUIRED KEYWORDS MATCHE THE KEYWORD FOUND
*
         SPACE 3
COMCKWT  DS    0H
         L     R2,COMTRKWL(R2)    PICK UP REQUIRED KEYWORD LIST ADRS
         LTR   R2,R2              ANY KEYWORDS REQUIRED
         BZ    COMCOPTS           CHECK FOR OPTIONAL KEYWORDS
         L     R3,0(R2)           PICK UP FIRST KWT ADDRS
         STM   R2,R3,SAVEREGS     SAVE REGS FOR NEXT PASS
COMCKEY  DS    0H
         LM    R2,R3,SAVEREGS     SAVE REGS FOR NEXT PASS
COMCKEY2 DS    0H
         LTR   R3,R3              IS NEXT KWT ADDRESS ZERO
         BZ    COMCOPTS           GO LOOK FOR OPTIONAL KEYWORDS
         L     RE,0(R3)           PICK UP RTN ADDRESS
         LA    R3,8(R3)           BUMP TO LIST PROPER
         XR    R1,R1              CLEAR REG 1 FOR LENGTH
COMCKEYL DS    0H
         IC    R1,0(R3)           PICK UP LENGTH
         LTR   R1,R1              END OF KWT
         BNZ   COMCKEYM           BRANCH IF NOT
         LA    R2,4(R2)           BUMP TO NEXT KWT SLOT
         L     R3,0(R2)           PICK UP NEXT KWT ADDRESS
         B     COMCKEY2           PROCESS NEXT KWT
COMCKEYM DS    0H
         BCTR  R1,0               DROP FOR EXECUTE
         EX    R1,KEYWTEST        COMPARE FOR KEYWORD MATCH
         BNE   COMCNOM            BRANCH TO ROUTINE IF MATCH
         L     R2,CURRENTF        RELOAD CURRENT FUNCTION TABLE ADRS
         L     R2,COMTRKWL(R2)    RESER RKW LIST TO START
         L     R3,0(R2)           PICK UP FIRST KWT ADDRS
         BR    RE                 BRANCH TO ROUTINE
COMCNOM  DS    0H
         LA    R3,2(R1,R3)        BUMP TO NEXT ENTRY IN KWT
         B     COMCKEYL
         EJECT
*
*        SINCE THE KEYWORD DOES NOT MATCH A REQUIRED KEYWORD
*        SEE IF IT MAY BE AN OPTIONAL KEYWORD.
*
*        NOTE: NO OPTIONAL KEYWORDS ARE DEFINED IN THIS RELEASE.
*              THIS FACILITY WAS BUILT IN FOR FUTURE COMPATIBILITY
*              TO ANY NEW FUNCTIONS.
*
         SPACE 3
COMCOPTS DS    0H
         L     R2,CURRENTF        PICK UP CURRENT TABLE ENTRY ADRS
         L     R2,COMTOKWL(R2)    PICK UP OPTIONAL KEYWORD LIST ADRS
         LTR   R2,R2              IS IT ZERO (NO OPTIONAL KEYWORDS)
         BZ    ERROR20            ERROR IF SO
         L     R3,0(R2)           PICK UP FIRST KWT ADDRS
COMOKEY  DS    0H
COMOKEY2 DS    0H
         LTR   R3,R3              IS NEXT KWT ADDRESS ZERO
         BZ    ERROR20            BAD KEYWORD IF SO
         L     RE,0(R3)           PICK UP RTN ADDRESS
         LA    R3,8(R3)           BUMP TO LIST PROPER
         XR    R1,R1              CLEAR REG 1 FOR LENGTH
COMOKEYL DS    0H
         IC    R1,0(R3)           PICK UP LENGTH
         LTR   R1,R1              END OF KWT
         BNZ   COMOKEYM           BRANCH IF NOT
         LA    R2,4(R2)           BUMP TO NEXT KWT SLOT
         L     R3,0(R2)           PICK UP NEXT KWT ADDRESS
         B     COMOKEY2           PROCESS NEXT KWT
COMOKEYM DS    0H
         BCTR  R1,0               DROP FOR EXECUTE
         EX    R1,KEYWTEST        COMPARE FOR KEYWORD MATCH
         BNE   COMONOM            BRANCH TO ROUTINE IF MATCH
         L     R2,CURRENTF        RELOAD CURRENT FUNCTION TABLE ADRS
         L     R2,COMTOKWL(R2)    RESER OKW LIST TO START
         L     R3,0(R2)           PICK UP FIRST KWT ADDRS
         STM   R2,R3,SAVEREGS     SAVE REGS FOR NEXT PASS
         BR    RE                 BRANCH TO ROUTINE
COMONOM  DS    0H
         LA    R3,2(R1,R3)        BUMP TO NEXT ENTRY IN KWT
         B     COMOKEYL
         EJECT
*
*        PROCESS THE DSNAME KEYWORD
*
         SPACE 3
COMDSN   DS    0H
         LA    R5,1(R1,R5)        BUMP PAST KEYWORD
         TM    COMFLAG,DSNKEY     HAS DSN ALLREADY BEEN SPECIFIED
         BO    ERROR13            BRANCH IF SO
         OI    COMFLAG,DSNKEY     FLAG DSN AS SPECIFIED
         LR    R3,R5              LOAD START OF DSNAME
         MVI   DSCBNAME,BLANK     BLANK OUT DSNAME HOLDER
         MVC   DSCBNAME+1(43),DSCBNAME
COMDSNBL DS    0H
         CLI   0(R3),BLANK        END OF DSNAME
         BE    COMDSNE            YES
         CLI   0(R3),COMMA        END OF DSNAME
         BE    COMDSNE            YES
         LA    R3,1(R3)           CONTINUE
         B     COMDSNBL
COMDSNE  DS    0H
         LR    R2,R3              SAVE POINTER
         SR    R3,R5              COMPUTE DSN LENGTH
         C     R3,FOURFOUR        LONGER THAN 44?
         BH    ERROR14            BRANCH IF SO
         C     R3,ONE             LESS THAN ONE
         BL    ERROR14            BRANCH IF SO
         BCTR  R3,0               DROP FOR EXECUTE
         EX    R3,DSNMOVE         MOVE IN DSNAME
         LR    R5,R2              RESTORE TO NEXT POSSIBLE POSITION
         CLI   0(R5),BLANK        END OF STRING
         BER   R6                 RETURN IF SO
         LA    R5,1(R5)           BUMP TO NEXT CHAR
         CLI   0(R5),BLANK        NEW CARD REQUIRED?
         BNE   COMCKEY            BRANCH IF NOT
         OI    IOFLAG,CONTINUE    MARK AS CONTINUE
         BAL   R8,GETACARD        GO GET ONE IF SO
         NI    IOFLAG,FULLMASK-CONTINUE TURN OFF CONT FLAG
         B     COMCKEY            GO LOOK FOR ANOTHER KEYWORD
         EJECT
*
*        PROCESS THE VOLUME KEYWORD
*
         SPACE 3
COMVOL   DS    0H                 PROCESS VOL KEYWORD
         LA    R5,1(R1,R5)        BUMP PAST KEYWORD
         TM    COMFLAG,VOLKEY     HAS VOL ALLREADY BEEN SPECIFIED
         BO    ERROR15            BRANCH IF SO
         OI    COMFLAG,VOLKEY     FLAG VOL AS SPECIFIED
         LR    R3,R5              LOAD START OF VOLSER
         MVC   VOLUME,BLANKS      BLANK OUT VOLSER HOLDER
COMVOLBL DS    0H
         CLI   0(R3),BLANK        END OF VOLUME
         BE    COMVOLE            YES
         CLI   0(R3),COMMA        END OF VOLUME
         BE    COMVOLE            YES
         LA    R3,1(R3)           CONTINUE
         B     COMVOLBL
COMVOLE  DS    0H
         LR    R2,R3              SAVE POINTER
         SR    R3,R5              COMPUTE VOL LENGTH
         C     R3,SIX             LONGER THAN 6?
         BH    ERROR16            BRANCH IF SO
         C     R3,ONE             LESS THAN ONE
         BL    ERROR16            BRANCH IF SO
         STH   R3,S99DDLEN        SAVE LENGTH IN DDNAME TEXT UNIT
         STH   R3,S99VLEN         SAVE LENGTH IN VOLSER TEXT UNIT
         LA    R1,2(R3)           BUMP BY 2 FOR DSN LENGTH
         STH   R1,S99DSLEN        STORE IN DSN TEXT UNIT LENGTH
         STH   R1,DAIRDSNB        STORE IN DAIR DSN BUFFER LENGTH
         MVC   DA08DDN,BLANKS     BLANK OUT DDNAME IN DAPB
         BCTR  R3,0               DROP FOR EXECUTE
         EX    R3,VOLMOVE         MOVE IN VOLUME
         EX    R3,VOLMOVE2        MOVE IN VOLUME (TO DDNAME TEXT UNIT)
         EX    R3,VOLMOVE3        MOVE IN VOLUME (TO VOLSER TEXT UNIT)
         EX    R3,VOLMOVE4        MOVE IN VOLUME (TO DSNAME TEXT UNIT)
         EX    R3,VOLMOVE5        MOVE IN VOLUME (TO DAIR BLOCK AS SER)
         EX    R3,VOLMOVE6        MOVE IN VOLUME (TO DAIR BLOCK AS DSN)
         EX    R3,VOLMOVE7        MOVE IN VOLUME (TO DAIR BLOCK AS DDN)
         LR    R5,R2              RESTORE TO NEXT POSSIBLE POSITION
         CLI   0(R5),BLANK        END OF STRING
         BER   R6                 RETURN IF SO
         LA    R5,1(R5)           BUMP TO NEXT CHAR
         CLI   0(R5),BLANK        NEW CARD REQUIRED?
*                                 (IF BLANK AFTER COMMA THEN MUST BE
*                                  CONTINUED ON NEXT CARD.)
         BNE   COMCKEY
         OI    IOFLAG,CONTINUE    MARK AS CONTINUE
         BAL   R8,GETACARD        GO GET ONE IF SO
         NI    IOFLAG,FULLMASK-CONTINUE TURN OFF CONT FLAG
         B     COMCKEY            GO LOOK FOR ANOTHER KEYWORD
         EJECT
*
*        PROCESS THE NEWNAME KEYWORD (VALID FOR RENAME COMMAND ONLY)
*
         SPACE 3
COMNEWN  DS    0H                 PROCESS NEW KEYWORD
         LA    R5,1(R1,R5)        BUMP PAST KEYWORD
         TM    COMFLAG,NEWNKEY    HAS NEW ALLREADY BEEN SPECIFIED
         BO    ERROR17            BRANCH IF SO
         OI    COMFLAG,NEWNKEY    FLAG NEW AS SPECIFIED
         LR    R3,R5              LOAD START OF NEWNAME
         MVI   NEWNAME,BLANK      BLANK OUT NEWNAME HOLDER
         MVC   NEWNAME+1(43),NEWNAME
COMNEWBL DS    0H
         CLI   0(R3),BLANK        END OF NEWNAME
         BE    COMNEWE            YES
         CLI   0(R3),COMMA        END OF NEWNAME
         BE    COMNEWE            YES
         LA    R3,1(R3)           CONTINUE
         B     COMNEWBL
COMNEWE  DS    0H
         LR    R2,R3              SAVE POINTER
         SR    R3,R5              COMPUTE NEW LENGTH
         C     R3,FOURFOUR        LONGER THAN 44?
         BH    ERROR19            BRANCH IF SO
         C     R3,ONE             LESS THAN ONE
         BL    ERROR19            BRANCH IF SO
         BCTR  R3,0               DROP FOR EXECUTE
         EX    R3,NEWNMOVE        MOVE IN NEWNAME
         LR    R5,R2              RESTORE TO NEXT POSSIBLE POSITION
         CLI   0(R5),BLANK        END OF STRING
         BER   R6                 RETURN IF SO
         LA    R5,1(R5)           BUMP TO NEXT CHAR
         CLI   0(R5),BLANK        NEW CARD REQUIRED?
         BNE   COMCKEY            BRANCH IF NOT
         OI    IOFLAG,CONTINUE    MARK AS CONTINUE
         BAL   R8,GETACARD        GO GET ONE IF SO
         NI    IOFLAG,FULLMASK-CONTINUE TURN OFF CONT FLAG
         B     COMCKEY            GO LOOK FOR ANOTHER KEYWORD
         EJECT
*
*        GET A NEW CARD (REQUIRED CONTINUATION CARD)
*
         SPACE 3
GETACARD DS    0H
         OI    MASTFLAG,CARD2TRY  FLAG AS CARD2 TRY FOR EODAD
         BAL   R5,CARDIN          GET ANOTHER CARD
         NI    MASTFLAG,FULLMASK-CARD2TRY TURN OFF CARD2 FLAG
         BAL   R7,SKIPB           CHECK FOR ALL BLANKS
         LTR   R5,R5              ALL BLANKS?
         BNZ   GETCKAS            SKIP IF NOT
         BAL   R7,PUTCARD         PRINT BLANK CARD
         B     GETACARD           GET ANOTHER CARD
GETCKAS  DS    0H
         CLI   CARD,ASTERISK      COMMENT CARD?
         BE    GETPRINT           PRINT IF SO
         TM    MASTFLAG,GETSUBC   LOOKING FOR A SUBCOMMAND
         BNO   GETPRINT           GO PRINT IF NOT (CONTINUATION CARD)
         CLI   CARD,BLANK         COULD IT BE A VALID SUBCOMMAND CARD
         BER   R8                 RETURN TO CALLER IF SO
         OI    MASTFLAG,PRIMEND   MARK NAME SET ENDED BY PRIMARY
         NI    MASTFLAG,FULLMASK-GETSUBC TURN OFF SUBCOMMAND FLAG
         B     WRITDSCB
GETPRINT DS    0H
         MVI   MSGCC,LINES1       SET CARRIAGE CONTROL
         BAL   R7,PUTCARD
         CLI   CARD,ASTERISK      COMMENT CARD?
         BE    GETACARD           SKIP IF SO
GETON    DS    0H
         BAL   R7,SKIPB           GO SKIP THE BLANKS
         LTR   R5,R5              ALL BLANK?
         BZ    GETACARD           GET ANOTHER CARD IF SO
         BR    R8                 RETURN TO CALLER
         EJECT
*
*        GET A CONTROL CARD FROM SOMEWHERE (TSO, SYSIN, OR CONSOLE)
*
         SPACE 3
CARDIN   DS    0H
         TM    IOFLAG,CONSOLE     CONSOLE I/O REQUIRED
         BO    DOCONIO            BRANCH IF SO
         TM    IOFLAG,TSOSESS     TPUT/TGET TSO I/O REQUIRED
         BO    DOTSIO             BRANCH IF SO
         GET   SYSIN,CARD         GET A CARD FROM SYSIN DD
         BR    R5                 RETURN TO CALLER
         EJECT
*
*        CONTROL CARDS ARE OBTAINED FROM STARTING CONSOLE
*
         SPACE 3
DOCONIO  DS    0H
         XC    WTORECB,WTORECB    CLEAR ECB
         IC    R0,CONID           PICK UP CONSOLE IDENTIFIER
         MVI   CARD,C' '          BLANK OUT REPLY HOLDER
         MVC   CARD+1(79),CARD
         TM    IOFLAG,CONTINUE    IS THIS A CONTINUE CARD
         BO    DOCONT             BRANCH IF SO
*        ENTER CONSOLE PROMPT FOR CONTROL CARD
         LA    R1,CARDMSGW        PICK UP MSG BUFFER ADDRESS
         WTOR  MF=(E,(1))
         B     DOWAIT
DOCONT   DS    0H
*        ENTER CONSOLE PROMPT FOR CONTINUATION OF CONTROL CARD
         LA    R1,CONTMSGW        PICK UP MSG BUFFER ADDRESS
         WTOR  MF=(E,(1))
         SPACE 1
DOWAIT   DS    0H
         WAIT  ECB=WTORECB
         OC    CARD,UPMASK        SHIFT TO UPPERCASE
         BR    R5
         EJECT
*
*        CONTROL CARDS ARE OBTAINED FROM TSO CONSOLE
*
         SPACE 3
DOTSIO   DS    0H
         MVI   CARD,C' '          BLANK OUT REPLY HOLDER
         MVC   CARD+1(79),CARD
         TM    IOFLAG,CONTINUE    IS THIS A CONTINUE CARD
         BO    DOTSCONT           BRANCH IF SO
*        ENTER TSO PROMPT FOR CONTROL CARD
         TPUT  CARDMSG,CARDMSGL
         B     DOTSTGET
DOTSCONT DS    0H
*        ENTER CONSOLE PROMPT FOR CONTINUATION OF CONTROL CARD
         TPUT  CONTMSG,CONTMSGL
         SPACE 1
DOTSTGET DS    0H
         STAX  DEFER=NO           ALLOW ATTENTION INTERRUPTS
         TGET  CARD,80            GET A CONTROL CARD
         STAX  DEFER=YES          DISALLOW ATTENTION INTERRUPTS
         OC    CARD,UPMASK        FOLD TO UPPERCASE
         BR    R5
         EJECT
*
*        SKIP LEADING BLANKS ON CARDS
*
         SPACE 3
SKIPB    DS    0H
         LA    R5,CARD
         LA    R1,72              LOAD COUNT MAX
SKIPLOOP DS    0H                 SEARCH FOR FIRST NON-BLANK COL
         CLI   0(R5),BLANK        BLANK
         BNE   SKIPEND            BRANCH IF NOT
         LA    R5,1(R5)           BUMP TO NEXT COL
         BCT   R1,SKIPLOOP
         LA    R5,0               INDICATED TOTALLY BLANK
SKIPEND  DS    0H
         BR    R7                 RETURN TO CALLER
         EJECT
*
*        PRINT CARD IMAGE
*
         SPACE 3
PUTCARD  DS    0H
         TM    IOFLAG,CONSOLE     ARE WE ON A CONSOLE
         BOR   R7                 DO NOT ECHO CARD BACK IF SO
         TM    IOFLAG,TSOSESS     ARE WE A TSO SESSION
         BOR   R7                 DO NOT ECHO CARD BACK IF SO
         MVI   MSGLINE,BLANK      BLANK OUT MESSAGE LINE
         MVC   MSGLINE+1(131),MSGLINE
         MVC   MSGLINE(80),CARD   MOVE CARD IMAGE TO MESSAGE LINE
         PUT   SYSPRINT,MSGBUFFR  PRINT CARD IMAGE
         BR    R7
         SPACE 5
*
*        PRINT A BLANK LINE
*
         SPACE 3
PUTBLANK DS    0H
         TM    IOFLAG,CONSOLE     ARE WE ON A CONSOLE
         BOR   R7                 DO NOT PUT BLANK LINES IF SO
         TM    IOFLAG,TSOSESS     ARE WE A TSO SESSION
         BOR   R7                 DO NOT PUT BLANK LINES IF SO
         MVI   MSGLINE,BLANK      BLANK OUT MESSAGE LINE
         MVC   MSGLINE+1(131),MSGLINE
         PUT   SYSPRINT,MSGBUFFR  PRINT A BLANK LINE
         BR    R7
         EJECT
*
*        PRINT MESSAGE
*
         SPACE 3
MSGOUT   DS    0H
         STH   R1,MPLNUM
         LA    R1,MPL
         L     RF,VMSG
         BALR  RE,RF
         LTR   RF,RF
         BZR   R7
         ABEND 777,DUMP
         EJECT
*
*        THIS PORTION OF CODE TAKES THE HEX RETURN CODE IN REG 15
*        AND CONVERTS IT TO INTEGER BINARY.
*
         SPACE 3
FIXDIGIT DS    0H
         LA    R1,RCWORD+3             GET ADDRESS OF END OF WORK WORD
         LR    RE,RF                   TRANSFER RC TO WORK REG
         LA    R4,4                    LOAD NUMBER OF BYTES IN RC
FIXDLOOP DS    0H
         SRDL  RE,4                    SHIFT 4 BITS TO R2
         SRL   RF,28                   SHIFT R3 BITS TO LOW END
         STC   RF,0(R1)                STORE IN BYTE IN WORK AREA
         BCTR  R1,0                    BACK UP WORD POINTER
         BCT   R4,FIXDLOOP             DO NEXT BYTE
         SPACE 3
         TR    RCWORD,FIXTABLE         TRANSLATE TO PRINTABLE HEX
         SPACE 3
         L     RF,RCWORD               RELOAD RETURN CODE (PRINTABLE)
         BR    R7                      RETURN TO CALLER
         SPACE 3
*
*        TRANSLATION TABLE FOR MAKING RETURN CODES PRINTABLE HEX.
*
         SPACE 3
FIXTABLE DS    0F
         DC    X'F0F1F2F3F4F5F6F7F8F9C1C2C3C4C5C6'
         EJECT
*
*        INFORMATION AND ERROR MESSAGE NODE POINTS
*
         PRINT NOGEN
         SPACE 1
*
* A MESSAGE NODE IS BUILT BY THE MSGEXIT MACRO.
*        IT MACRO REQUIRES THE SEQUENCE NUMBER OF
*        THE MESSAGE TO BE PRINTED, A RETURN LABEL OR ABEND
*        CODE (BUT NOT BOTH), AND AN OPTIONAL RETURN CODE.
*        THE RETURN CODE DEFAULTS TO 8 AND SETS THE FUNCTION
*        IN PROGRESS RETURN CODE.
*
         SPACE 1
* SPECIAL EXECUTION MESSAGES (RETURN CODES, ETC.)
MSGSP0   MSGEXIT SPMSG=SPMG0WTO,RETURN=FUNCMEND,RC=
MSGSP1   MSGEXIT SPMSG=SPMG1WTO,RETURN=CLOSEND,RC=
MSGSP2   MSGEXIT SPMSG=SPMG2WTO,RETURN=ERROR36,RC=
MSGSP3   MSGEXIT SPMSG=SPMG3WTO,RETURN=MSGSP5
MSGSP4   MSGEXIT SPMSG=SPMG4WTO,RETURN=MSGSP5
MSGSP5   MSGEXIT SPMSG=SPMG5WTO,RETURN=MSGSP6
MSGSP6   MSGEXIT SPMSG=SPMG6WTO,RETURN=FUNCMSG
         SPACE 1
* NORMAL EXECUTION MESSAGES
MESSAG28 MSGEXIT MSG=28,RETURN=CLOSEX,RC=0
MESSAG32 MSGEXIT MSG=32,RETURN=FUNCMSG2,RC=0
MESSAG33 MSGEXIT MSG=33,RETURN=LOOP1,RC=0
         SPACE 1
* ERROR AND EXCEPTION MESSAGES
ERROR1   MSGEXIT MSG=1,ABEND=991
ERROR2   MSGEXIT MSG=2,RETURN=FUNCMSG
ERROR3   MSGEXIT MSG=3,ABEND=998
ERROR4   MSGEXIT MSG=4,ABEND=999
ERROR5   MSGEXIT MSG=5,RETURN=FUNCMSG
ERROR6   MSGEXIT MSG=6,RETURN=FUNCMSG
ERROR7   MSGEXIT MSG=7,RETURN=FUNCMSG
ERROR8   MSGEXIT MSG=8,RETURN=FUNCMSG
ERROR9   MSGEXIT MSG=9,RETURN=NAME
ERROR10  MSGEXIT MSG=10,RETURN=FUNCMSG
ERROR11  MSGEXIT MSG=11,RETURN=FUNCMSG
ERROR12  MSGEXIT MSG=12,RETURN=MSGSP3,RC=
ERROR13  MSGEXIT MSG=13,RETURN=FUNCMSG
ERROR14  MSGEXIT MSG=14,RETURN=FUNCMSG
ERROR15  MSGEXIT MSG=15,RETURN=FUNCMSG
ERROR16  MSGEXIT MSG=16,RETURN=FUNCMSG
ERROR17  MSGEXIT MSG=17,RETURN=FUNCMSG
ERROR18  MSGEXIT MSG=18,RETURN=FUNCMSG
ERROR19  MSGEXIT MSG=19,RETURN=FUNCMSG
ERROR20  MSGEXIT MSG=20,RETURN=FUNCMSG
ERROR21  MSGEXIT MSG=21,RETURN=FUNCMSG
ERROR22  MSGEXIT MSG=22,RETURN=FUNCMSG
ERROR23  MSGEXIT MSG=23,RETURN=FUNCMSG
ERROR24  MSGEXIT MSG=24,RETURN=FUNCMSG
ERROR25  MSGEXIT MSG=25,RETURN=ERROR26
ERROR26  MSGEXIT MSG=26,RETURN=CLOSE2
ERROR27  MSGEXIT MSG=27,RETURN=CLOSE,RC=12
ERROR29  MSGEXIT MSG=29,RETURN=FUNCMSG
ERROR30  MSGEXIT MSG=30,RETURN=CLOSEX,RC=4
ERROR31  MSGEXIT MSG=31,ABEND=992
ERROR34  MSGEXIT MSG=34,RETURN=FUNCMSG
ERROR35  MSGEXIT MSG=35,ABEND=999
ERROR36  MSGEXIT MSG=36,ABEND=997
ERROR37  MSGEXIT MSG=37,RETURN=CLOSE,RC=12
ERROR38  MSGEXIT MSG=38,RETURN=FUNCMSG
ERROR39  MSGEXIT MSG=39,RETURN=MSGSP4,RC=
         EJECT
*
*        SPECIAL MESSAGES (REQUIRE RETURN CODES OR MODIFICATION)
*
*          SPECIAL MESSAGES ARE CONSTRUCTED AS A VALID WTO
*          REMOTE PARAMETER LIST (MF=L).  SPECIAL MESSAGES
*          ARE PRINTED VIA THE 'SPMSG' PARAMETER OF THE
*          MSGEXIT MACRO.
*
         SPACE 3
         PRINT GEN
         SPACE 1
SPMG0WTO DS    0F                 MESSAGE 0 WTO FORMAT
         DC    AL2(SPMSG0L)
         DC    X'4000'
SPMSG0   DC    C' FDB9998I **** FUNCTION PROCESSING COMPLETE.  RETURN CX
               ODE IS '
SPMSG0R  DC    CL4'0000'
         DC    C'.'
SPMSG0L  EQU   *-SPMG0WTO
         SPACE 2
SPMG1WTO DS    0F                 MESSAGE 1 WTO FORMAT
         DC    AL2(SPMSG1L)
         DC    X'4000'
SPMSG1   DC    C' FDB9999I **** ALL PROCESSABLE FUNCTIONS COMPLETE.  HIX
               GHEST RETURN ENCOUNTERED WAS '
SPMSG1R  DC    CL4'0000'
         DC    C'.'
SPMSG1L  EQU   *-SPMG1WTO
         SPACE 2
SPMG2WTO DS    0F                 MESSAGE 2 WTO FORMAT
         DC    AL2(SPMSG2L)
         DC    X'4000'
SPMSG2   DC    C' FDB9997D **** DISASTER - SCRATCH FAILED AFTER DUMMY RX
               ENAME.  SCRATCH RETURN CODE = '
SPMSG2R1 DC    CL4'0000'
         DC    C'.  REASON CODE = '
SPMSG2R2 DC    CL4'0000'
         DC    C'.'
SPMSG2L  EQU   *-SPMG2WTO
         SPACE 2
SPMG3WTO DS    0F                 MESSAGE 3 WTO FORMAT
         DC    AL2(SPMSG3L)
         DC    X'4000'
SPMSG3   DC    C' FDB9996D **** ERROR - RETURN CODE = '
SPMSG3R1 DC    CL4'0000'
         DC    C',  ERROR CODE = '
SPMSG3R2 DC    CL4'0000'
         DC    C',  INFORMATION CODE= '
SPMSG3R3 DC    CL4'0000'
         DC    C'.'
SPMSG3L  EQU   *-SPMG3WTO
         SPACE 2
SPMG4WTO DS    0F                 MESSAGE 4 WTO FORMAT
         DC    AL2(SPMSG4L)
         DC    X'4000'
SPMSG4   DC    C' FDB9995D **** ERROR - RETURN CODE = '
SPMSG4R1 DC    CL4'0000'
         DC    C',  ERROR CODE = '
SPMSG4R2 DC    CL4'0000'
         DC    C',  CATALOG CODE= '
SPMSG4R3 DC    CL4'0000'
         DC    C'.'
SPMSG4L  EQU   *-SPMG4WTO
         SPACE 2
         EJECT
*
*        SPECIAL WTOR MESSAGE BUFFERS
*
         SPACE 3
CARDMSGW DS    0F                 CARD MESSAGE WTOR FORMAT HEADDER
         DC    AL1(80)            REPLY LENGTH
         DC    AL3(CARD)          ADDRESS IF REPLY BUFFER
         DC    A(WTORECB)         ADDRESS OF EVENT CONTROL BLOCK
         DC    AL2(CARDMSGL)      LENGTH OF MESSAGE
         DC    X'4000'            MCS FLAGS
CARDMSG  DC    C' FDB9990R **** ENTER FIXDSCB CONTROL CARD'
CARDMSGL EQU   *-CARDMSG
CONTMSGW DS    0F                 CONT MESSAGE WTOR FORMAT HEADDER
         DC    AL1(80)            REPLY LENGTH
         DC    AL3(CARD)          ADDRESS IF REPLY BUFFER
         DC    A(WTORECB)         ADDRESS OF EVENT CONTROL BLOCK
         DC    AL2(CONTMSGL)      LENGTH OF MESSAGE
         DC    X'4000'            MCS FLAGS
CONTMSG  DC    C' FDB9991R **** CONTINUE FIXDSCB CONTROL CARD'
CONTMSGL EQU   *-CONTMSG
         EJECT
*
*        REMOTELY EXECUTED INSTRUCTIONS
*
         SPACE 3
COMMOVE  MVC   COMMAND(0),0(R5)   MOVE IN COMMAND NAME (EXECUTED)
COM2MOVE MVC   COMMAND2(0),0(R5)  MOVE IN COMMAND NAME (EXECUTED)
DSNMOVE  MVC   DSCBNAME(0),0(R5)  MOVE IN DSNAME       (EXECUTED)
NEWNMOVE MVC   NEWNAME(0),0(R5)   MOVE IN NEW DSNAME   (EXECUTED)
VOLMOVE  MVC   VOLUME(0),0(R5)    MOVE IN VOLSER       (EXECUTED)
VOLMOVE2 MVC   S99DDTXT(0),0(R5)  MOVE IN VOLSER       (EXECUTED)
VOLMOVE3 MVC   S99VTEXT(0),0(R5)  MOVE IN VOLSER       (EXECUTED)
VOLMOVE4 MVC   S99DSNAM(0),0(R5)  MOVE IN VOLSER       (EXECUTED)
VOLMOVE5 MVC   DA08SER(0),0(R5)   MOVE IN VOLSER       (EXECUTED)
VOLMOVE6 MVC   DAIRDSNV(0),0(R5)  MOVE IN VOLSER       (EXECUTED)
VOLMOVE7 MVC   DA08DDN(0),0(R5)   MOVE IN VOLSER       (EXECUTED)
RECMOVE  MVC   RECFMH(0),0(R5)    MOVE IN RECORD FORMAT(EXECUTED)
LRECLPCK PACK  DOUBLE,0(0,R5)     PACK IN LRECL VALUE  (EXECUTED)
BLKSZPCK EQU   LRECLPCK           PACK IN BLKSIZE VALUE(EXECUTED)
RKPPCK   EQU   LRECLPCK           PACK IN RKP VALUE    (EXECUTED)
KEYLPCK  EQU   LRECLPCK           PACK IN KEYL VALUE   (EXECUTED)
SUBCTEST CLC   0(0,R2),0(R5)      TEST FOR SUBCOMMAND  (EXECUTED)
KEYWTEST CLC   1(0,R3),0(R5)      TEST FOR KEYWORD     (EXECUTED)
         EJECT
*
*        REGISTER AND OTHER EQUATES
*
         SPACE 3
R0       EQU   0
R1       EQU   1
R2       EQU   2
R3       EQU   3
R4       EQU   4
R5       EQU   5
R6       EQU   6
R7       EQU   7
R8       EQU   8
R9       EQU   9
RA       EQU   10
RB       EQU   11
RC       EQU   12
RD       EQU   13
RE       EQU   14
RF       EQU   15
         SPACE 2
BLANK    EQU   C' '
ASTERISK EQU   C'*'
COMMA    EQU   C','
EQUAL    EQU   C'='
LINES1   EQU   C' '
LINES3   EQU   C'3'
SIGN     EQU   X'F0'
XDAPGOOD EQU   X'7F'
HEXZERO  EQU   X'00'
HEXFOUR  EQU   X'04'
FULLMASK EQU   X'FF'
         EJECT
*
*        REMOTE CAMLIST MACRO EXPANSION
*
         SPACE 3
DSCBADDR CAMLST SEARCH,DSCBNAME,VOLUME,WORKAREA
         SPACE 1
SCRLIST  CAMLST SCRATCH,TEMPNAME,,VOLIST
         EJECT
*
*        DATA CONTROL BLOCKS (DCB'S)
*
         SPACE 3
         PRINT NOGEN
XDAPDCB  DCB   MACRF=(E),DSORG=DA,DDNAME=DDNAME,EXLST=EXITLIST
SYSPRINT DCB   MACRF=(PM),DDNAME=SYSPRINT,RECFM=FBA,LRECL=133,         X
               BLKSIZE=1330,DSORG=PS
SYSIN    DCB   MACRF=(GM),DDNAME=SYSIN,DSORG=PS,EODAD=CLOSE
         PRINT GEN
         EJECT
*
*        DYNAMIC DATA AREAS
*
         SPACE 2
SAVEAREA DC    9D'0'
SAVEREGS DC    9D'0'
MPL      DS    0F
MPLMTT   DC    A(MSGTABLE)        ADDRESS OF MESSAGE TABLE
MPLDCB   DC    A(SYSPRINT)        ADDRESS OF DCB
MPLSPADR DC    A(0)               ADDRESS OF SPECIAL MESSAGE
MPLNUM   DC    H'0'               MESSAGE NUMBER TO BE PRINTED
MPLIOF   DC    X'0'               MPL I/O FLAG
MPLCON   DC    X'0'               MPL CONSOLE ID
CARD     DC    CL80' '            INPUT CARD IMAGE
HIGHRC   DC    F'0'               HIGHEST RETURN CODE ENCOUNTERED
FUNCRC   DC    F'0'               CURRENT FUNCTION RETURN CODE
TSOWORD  DS    A                  ADDRESS OF EXTRACTED TSO INDICATOR
TIOTADRS DS    A                  EXTRACTED TIOT ADDRESS
CPPLHOLD DS    A                  TSO CPPL ADDRESS
THYMEOYR DC    D'0'               YEAR COMPUTATION HOLDER
DAYTHYME DC    D'0'               DAY COMPUTATION HOLDER
DOUBLE   DC    D'0'               PACKING WORD
CURRENTF DC    F'0'               ADDRESS OF CURRENT FUNCTION T/ENTRY
COMLEN   DC    F'0'               LENGTH OF COMMAND
COMMAND  DC    CL8' '             CURRENT COMMAND
COMMAND2 DC    CL8' '             POSSIBLE NEW COMMAND DURING NAME
RECFMH   DC    CL5' '             RECORD FORMAT HOLDER
OPTCODEH DC    C' '               OPT CODE HOLDER
DSORGH   DC    CL3' '             DATASET ORGANIZATION HOLDER
NEWNAME  DC    CL44' '            NEW DATASET NAME HOLDER
         SPACE 1
* MASTER FLAG FOR ENTIRE RUN
MASTFLAG DC    X'00'
TESTONLY EQU   X'80'  THIS RUN IS A TEST ONLY (NO REWRITE OF DSCB'S)
CARD2TRY EQU   X'40'  THIS GET FOR A CONTINUATION OR SUBCOMMAND CARD
GETSUBC  EQU   X'20'  THIS GET FOR A SUBCOMMAND CARD
PRIMEND  EQU   X'10'  PRIMARY ENCOUNTERED DURING SUBCOMMAND PROCESSING
PARTSCAN EQU   X'08'  SCAN CARD FOR COMMAND ONLY
COMBADF  EQU   X'04'  SCANNED COMMAND CONTAINED AN = SIGN
MVSSYS   EQU   X'02'  SYSTEM IS AN MVS RELEASE (SVC 99 AVAILABLE)
         SPACE 1
* FUNCTION FLAG FOR ONE FUNCTION REQUEST
COMFLAG  DC    X'00'
DSNKEY   EQU   X'80'  THE DSN KEYWORD HAS BEEN ENCOUNTERED IN SCAN
VOLKEY   EQU   X'40'  THE VOLUME KEYWORD HAS BEEN ENCOUNTERED IN SCAN
NEWNKEY  EQU   X'20'  THE NEWNAME KEYWORD HAS BEEN ENCOUNTERED IN SCAN
REWRITE  EQU   X'01'  THE DSCB HAS BEEN MODIFIED AND MUST BE WRITTEN
         SPACE 1
* I/O TYPE INDICATOR FLAG
IOFLAG   DC    X'00'
CONSOLE  EQU   X'80'  ALL I/O MUST BE WTO/WTOR TO STARTING CONSOLE
CONTINUE EQU   X'40'  CONTINUE CARD REQUIRED
TSOSESS  EQU   X'20'  ALL I/O MUST BE TPUT/TGET TO TSO
         SPACE 1
         DS    0F
EXITLIST DC    X'87',AL3(JFCBAREA) READ JFCB EXIT
         DS    0D
JFCBAREA DS    CL176              INTERNAL JFCB AREA
WORKAREA DS    0D                 OBTAIN WORK AREA
         DS    148C
DSCBNAME DS    CL44
VOLIST   DS    0CL12
         DC    H'1'
VOLUNIT  DC    X'00000000'
VOLUME   DC    CL6' '
VOLSTAT  DC    H'0'
XDAPBLRF DC    XL8'0000000000000000'
RCSAVE   DC    F'0'               SAVE AREA FOR REG 15 DURING MSG RTNS
RCWORD   DC    F'0'               WORK WORD FOR RC FIXING FOR PRINT
MSGBUFFR DS    0CL133
MSGCC    DC    C' '
MSGLINE  DC    CL132' '
CONID    DC    X'00'    CONSOLE ID FOR STARTED TASK I/O VIA WTO
WTORECB  DC    F'0'     ECB FOR WTOR REPLY WAIT
DECB     DC    F'0'     ECB FOR DAIR
TEMPNAME DC    CL44'FIXDSCB.SCRATCH.DATASET'
DAIRDSNB DC    H'8'
         DC    X'5050'
DAIRDSNV DC    CL42' '
         EJECT
*
*        MESSAGE EXTENSION ROUTINE MESSAGES
*
         SPACE 3
         EJECT
*
*        DYNAMIC ALLOCATION (DAIR08) CONTROL BLOCK
*
         SPACE 3
DAPLIST  DS    0F
         DC    A(0,0)
         DC    A(DECB)
         DC    A(0)
         DC    A(DAIR08)
         SPACE 3
DAIR08   DS    0F
DA08CD   DC    X'0008'
DA08FLG  DC    X'0000'
DA08DARC DC    X'0000'
DA08CTRC DC    X'0000'
DA08PDSN DC    A(DAIRDSNB)
DA08DDN  DC    CL8' '
DA08UNIT DC    CL8'SYSDA'
DA08SER  DC    CL6' '
         DC    CL2' '
DA08BLK  DC    A(80)
DA08PQTY DC    A(1)
DA08SQTY DC    A(0)
DA08DQTY DC    A(0)
DA08MNM  DC    CL8' '
DA08PSWD DC    CL8' '
DA08DSP1 DC    X'04'
DA08DSP2 DC    X'04'
DA08DSP3 DC    X'04'
DA08CTL  DC    X'40'
DA08RSV  DC    AL3(0)
DA08DSO  DC    X'00'
DA08ALN  DC    CL8' '
         EJECT
*
*        DYNAMIC ALLOCATION (SVC 99) CONTROL BLOCKS
*
         SPACE 3
         DS    0F                 MOVE TO FULL WORD BOUNDARY
S99RBPTR DC    X'80',AL3(S99RB)   SVC 99 REQUEST BLOCK POINTER
         SPACE 1
S99RB    DS    0F                 SVC 99 REQUEST BLOCK
         DC    AL1(20)            RB LENGTH
         DC    AL1(01)            VERB 01 = DSNAME ALLOCATION (TEMP)
S99F1    DC    AL2(0)             FLAGS1
S99ERROR DC    AL2(0)             ERROR CODES
S99INFO  DC    AL2(0)             INFORMATION CODES
         DC    A(S99TUPL)         TEXT UNIT POINTER LIST
         DC    A(0)               RESERVED
S99F2    DC    A(0)               FLAGS2
         SPACE 1
S99TUPL  DS    0F                 SVC 99 TEXT UNIT POINTER LIST
         DC    A(S99DSN)          DSNAME TEXT UNIT
         DC    A(S99DDN)          DDNAME TEXT UNIT
         DC    A(S99VOL)          VOLUME TEXT UNIT
         DC    A(S99DSTAT)        DATASET STATUS TEXT UNIT
         DC    A(S99DISP)         DATASET DISPOSITION
         DC    A(S99UNIT)         UNIT NAME TEXT UNIT
         DC    A(S99TRACK)        DATASET TRACK TEXT UNIT
         DC    A(S99SPACE)        DATASET SPACE TEXT UNIT
         DC    X'80',AL3(0)       END OF LIST
         SPACE 1
S99DSN   DS    0F                 VOLUME TEXT UNIT
S99DSKEY DC    X'0002'
S99DS#   DC    X'0001'
S99DSLEN DC    X'0002'
S99DSTXT DC    X'5050'            TEMPORARY DSN=&&VOLSER
S99DSNAM DC    CL6' '
         SPACE 1
S99DDN   DS    0F                 VOLUME TEXT UNIT
S99DDKEY DC    X'0001'
S99DD#   DC    X'0001'
S99DDLEN DC    X'0008'
S99DDTXT DC    CL8' '
         SPACE 1
S99VOL   DS    0F                 VOLUME TEXT UNIT
S99VKEY  DC    X'0010'
S99V#    DC    X'0001'
S99VLEN  DC    X'0006'
S99VTEXT DC    CL6' '
         SPACE 1
S99DSTAT DS    0F                 DS STATUS TEXT UNIT
S99DKEY  DC    X'0004'
S99D#    DC    X'0001'
S99DLEN  DC    X'0001'
S99DTEXT DC    X'04'              DISP = OLD
         SPACE 1
S99DISP  DS    0F                 VOLUME TEXT UNIT
S99DIKEY DC    X'0005'
S99DI#   DC    X'0001'
S99DILEN DC    X'0001'
S99DITXT DC    X'04'
         SPACE 1
S99UNIT  DS    0F                 UNIT NAME TEXT UNIT
S99UKEY  DC    X'0015'
S99U#    DC    X'0001'
S99ULEN  DC    X'0005'
S99UTEXT DC    C'SYSDA'
         SPACE 1
S99TRACK DS    0F                 SPACE TYPE TEXT UNIT
S99TKEY  DC    X'0007'
S99T#    DC    X'0000'
         SPACE 1
S99SPACE DS    0F                 SPACE AMOUNT TEXT UNIT
S99SPKEY DC    X'000A'
S99SP#   DC    X'0001'
S99SPLEN DC    X'0003'
S99SPTXT DC    X'000001'          1 UNIT (TRACK)
         EJECT
*
*        DAIRFAIL PARAMETER BLOCKS
*
         SPACE 3
DFS99RB  DC    A(0)
DFDAPLP  EQU   DFS99RB
DFRCP    DC    A(DYNRETC)
DFJEFF02 DC    A(ZERO)
DFIDP    DC    A(DFFLAGS)
DFCPPLP  DC    A(0)
DFBUFFP  DC    A(DFBUFS)
DYNRETC  DC    A(0)
DFFLAGS  DC    X'4000'
DFBUFS   DS    0F
DFFLMSG  EQU   *
DFBUFL1  DC    AL2(0)
DFBUF01  DC    AL2(0)
DFBUFT1  DC    CL251' '
DFSLMSG  DS    0F
DFBUFL2  DC    AL2(0)
DFBUF02  DC    AL2(0)
DFBUFT2  DC    CL251' '
SPMG5WTO EQU   DFFLMSG            USE DF BUFFER FOR MESSAGE 5
SPMG6WTO EQU   DFSLMSG            USE DF BUFFER FOR MESSAGE 6
         EJECT
*
*        CONSTANTS
*
         SPACE 3
ZERO     DC    F'0'
ONE      DC    F'1'
FOUR     DC    F'4'
SIX      DC    F'6'
FOURFOUR DC    F'44'
BIGLRECL DC    F'32768'
BIGKEYL  DC    F'255'
PREFIXL  DC    F'256'
BIGRKP   DC    F'32767'
VMSG     DC    V(FIXDMSGR)
UPMASK   DC    CL80' '            MASK FOR UPPERCASE CONVERSION
TESTPARM DC    CL4'TEST'
BLANKS   DC    CL8' '
PACK8ZRO DC    PL8'0'
SCRTCH   DC    CL8'SCRATCH'
COMNAME  DC    CL8'NAME'
MVSCODE  DC    C'03'
MAXDATE  DC    X'63016D'          DATE = 99:365 (IN HEX)
ZERODATE DC    X'000000'          DATE = 00:000 (IN HEX)
MASKC0   DC    X'C0'
         EJECT
*
*        COMMAND TABLE
*
         SPACE 3
COMTABLE DS    0F
         DC    CL8'RENEW'                  RENEW COMMAND
COMTADR  EQU   *-COMTABLE         ADDRESS OF COMMAND ROUTINE
         DC    A(RENEW)
COMTRKWL EQU   *-COMTABLE
         DC    A(RKWLIST1)        ADDRESS OF REQUIRED KWT LIST
COMTOKWL EQU   *-COMTABLE
         DC    A(0)               ADDRESS OF OPTIONAL KWT LIST
COMTLEN  EQU   *-COMTABLE         LENGTH OF A TABLE ENTRY
         DC    CL8'PROTECT',A(PROTECT),A(RKWLIST1),A(0)
         DC    CL8'SETNOPWR',A(SETNOPWR),A(RKWLIST1),A(0)
         DC    CL8'UNLOCK',A(UNLOCK),A(RKWLIST1),A(0)
         DC    CL8'EXPIRE',A(EXPIRE),A(RKWLIST1),A(0)
         DC    CL8'EXTEND',A(EXTEND),A(RKWLIST1),A(0)
         DC    CL8'ZEROEXPD',A(ZEROEXPD),A(RKWLIST1),A(0)
         DC    CL8'RENAME',A(RENAME),A(RKWLIST2),A(0)
         DC    CL8'NAME',A(NAME),A(RKWLIST1),A(0)
         DC    CL8'SCRATCH',A(SCRATCH),A(RKWLIST1),A(0)
         DC    CL8'END',A(END),A(0),A(0)
         DC    C' '               END OF TABLE
         EJECT
*
*        KEYWORD TABLES
*
*       A KWT IS A TABLE THAT DESCRIBES A KEYWORD AND ALL ACCEPTABLE
*       ABREVIATIONS OF IT.
*
         SPACE 3
KWTDSN   DC    A(COMDSN)          ADRS OF ROUTINE TO HANDLE KEYWORD
         DC    AL1(DSNKEY)        FLAG THAT INDICATES KW SUPPLIED
         DC    AL3(ERROR6)        ADRS OF ERROR RTN IF KW OMITTED
         DC    AL1(7)             LENGTH
         DC    C'DSNAME='         KEYWORD
         DC    AL1(4)             LENGTH
         DC    C'DSN='            ABREVIATION
         DC    AL1(2)             LENGTH
         DC    C'D='              ABREVIATION
         DC    AL1(0)             END OF KWT
         SPACE 3
KWTVOL   DC    A(COMVOL)          ADRS OF ROUTINE TO HANDLE KEYWORD
         DC    AL1(VOLKEY)        FLAG THAT INDICATES KW SUPPLIED
         DC    AL3(ERROR7)        ADRS OF ERROR RTN IF KW OMITTED
         DC    AL1(7)             LENGTH
         DC    C'VOLUME='         KEYWORD
         DC    AL1(4)             LENGTH
         DC    C'VOL='            ABREVIATION
         DC    AL1(2)             LENGTH
         DC    C'V='              ABREVIATION
         DC    AL1(0)             END OF KWT
         SPACE 3
KWTNEWN  DC    A(COMNEWN)         ADRS OF ROUTINE TO HANDLE KEYWORD
         DC    AL1(NEWNKEY)       FLAG THAT INDICATES KW SUPPLIED
         DC    AL3(ERROR8)        ADRS OF ERROR RTN IF KW OMITTED
         DC    AL1(8)             LENGTH
         DC    C'NEWNAME='        KEYWORD
         DC    AL1(5)             LENGTH
         DC    C'NEWN='           ABREVIATION
         DC    AL1(3)             LENGTH
         DC    C'NN='             ABREVIATION
         DC    AL1(2)             LENGTH
         DC    C'N='              ABREVIATION
         DC    AL1(0)             END OF KWT
         EJECT
*
*        RKWLIST'S ARE LIST OF REQUIRED KWT FOR A FUNCTION
*
         SPACE 3
RKWLIST1 DS    0H
         DC    A(KWTDSN)
         DC    A(KWTVOL)
         DC    A(0)
         SPACE 3
RKWLIST2 DS    0H
         DC    A(KWTDSN)
         DC    A(KWTVOL)
         DC    A(KWTNEWN)
         DC    A(0)
         SPACE 3
*
*        OKWLIST'S ARE LIST OF OPTIONAL KWT FOR A FUNCTION
*
         SPACE 3
*        NO OKW'S ARE IN USE AT THIS TIME
         SPACE 3
         EJECT
*
*       SUBCOMMAND TABLE
*
        SPACE 3
SUBTABLE DS    0F
         DC    CL8'LRECL'                  LRECL CHANGE
SUBTADR  EQU   *-SUBTABLE         ADDRESS OF PROCESSING ROUTINE
         DC    A(LRECL)
SUBTSCL  EQU   *-SUBTABLE         LENGTH OF THE SUBCOMMAND NAME
         DC    A(5)
SUBTLEN  EQU   *-SUBTABLE         LENGTH OF A SUBC TABLE ENTRY
         DC    CL8'BLKSIZE',A(BLKSIZE,7)   CHANGE BLKSIZE
         DC    CL8'DSORG',A(DSORG,5)       RESET DSORG
         DC    CL8'RECFM',A(RECFM,5)       RESET RECORD FORMAT
         DC    CL8'KEYL',A(KEYL,4)         RESET KEY LENGTH
         DC    CL8'RKP',A(RKP,3)           RESET REL KEY POSITION
         DC    CL8'OPTCODE',A(OPTCODE,7)   RESET OPTCODE
         DC    CL8'ENDNAME',A(ENDNAME,7)   END NAME SUBCOMMAND LIST
         DC    C' '               END OF TABLE
         EJECT
*
*        RECORD FORMAT TABLE
*
         SPACE 3
RECFMTAB DS    0H
FIXED    EQU   X'80'
VARIABLE EQU   X'40'
UNDEFINE EQU   X'C0'
TOVRFLOW EQU   X'20'
BLOCKED  EQU   X'10'
FSTANDRD EQU   X'08'
VSPANNED EQU   X'08'
ASACC    EQU   X'04'
MCHCC    EQU   X'02'
         DC    CL5'U    '
RECFMASK EQU   *-RECFMTAB         OFFSET TO MASK BYTE IN ENTRY
         DC    AL1(UNDEFINE)
RECFMLEN EQU   *-RECFMTAB
         DC    CL5'UT   ',AL1(UNDEFINE+TOVRFLOW)
         DC    CL5'UA   ',AL1(UNDEFINE+ASACC)
         DC    CL5'UM   ',AL1(UNDEFINE+MCHCC)
         DC    CL5'UTA  ',AL1(UNDEFINE+TOVRFLOW+ASACC)
         DC    CL5'UTM  ',AL1(UNDEFINE+TOVRFLOW+MCHCC)
         DC    CL5'F    ',AL1(FIXED)
         DC    CL5'FB   ',AL1(FIXED+BLOCKED)
         DC    CL5'FS   ',AL1(FIXED+FSTANDRD)
         DC    CL5'FT   ',AL1(FIXED+TOVRFLOW)
         DC    CL5'FBS  ',AL1(FIXED+BLOCKED+FSTANDRD)
         DC    CL5'FBT  ',AL1(FIXED+BLOCKED+TOVRFLOW)
         DC    CL5'FBST ',AL1(FIXED+BLOCKED+FSTANDRD+TOVRFLOW)
         DC    CL5'FA   ',AL1(FIXED+ASACC)
         DC    CL5'FBA  ',AL1(FIXED+BLOCKED+ASACC)
         DC    CL5'FSA  ',AL1(FIXED+FSTANDRD+ASACC)
         DC    CL5'FTA  ',AL1(FIXED+TOVRFLOW+ASACC)
         DC    CL5'FBSA ',AL1(FIXED+BLOCKED+FSTANDRD+ASACC)
         DC    CL5'FBTA ',AL1(FIXED+BLOCKED+TOVRFLOW+ASACC)
         DC    CL5'FBSTA',AL1(FIXED+BLOCKED+FSTANDRD+TOVRFLOW+ASACC)
         DC    CL5'FM   ',AL1(FIXED+MCHCC)
         DC    CL5'FBM  ',AL1(FIXED+BLOCKED+MCHCC)
         DC    CL5'FSM  ',AL1(FIXED+FSTANDRD+MCHCC)
         DC    CL5'FTM  ',AL1(FIXED+TOVRFLOW+MCHCC)
         DC    CL5'FBSM ',AL1(FIXED+BLOCKED+FSTANDRD+MCHCC)
         DC    CL5'FBTM ',AL1(FIXED+BLOCKED+TOVRFLOW+MCHCC)
         DC    CL5'FBSTM',AL1(FIXED+BLOCKED+FSTANDRD+TOVRFLOW+MCHCC)
         DC    CL5'V    ',AL1(VARIABLE)
         DC    CL5'VB   ',AL1(VARIABLE+BLOCKED)
         DC    CL5'VS   ',AL1(VARIABLE+VSPANNED)
         DC    CL5'VT   ',AL1(VARIABLE+TOVRFLOW)
         DC    CL5'VBS  ',AL1(VARIABLE+BLOCKED+VSPANNED)
         DC    CL5'VBT  ',AL1(VARIABLE+BLOCKED+TOVRFLOW)
         DC    CL5'VBST ',AL1(VARIABLE+BLOCKED+VSPANNED+TOVRFLOW)
         DC    CL5'VA   ',AL1(VARIABLE+ASACC)
         DC    CL5'VBA  ',AL1(VARIABLE+BLOCKED+ASACC)
         DC    CL5'VSA  ',AL1(VARIABLE+VSPANNED+ASACC)
         DC    CL5'VTA  ',AL1(VARIABLE+TOVRFLOW+ASACC)
         DC    CL5'VBSA ',AL1(VARIABLE+BLOCKED+VSPANNED+ASACC)
         DC    CL5'VBTA ',AL1(VARIABLE+BLOCKED+TOVRFLOW+ASACC)
         DC    CL5'VBSTA',AL1(VARIABLE+BLOCKED+VSPANNED+TOVRFLOW+ASACC)
         DC    CL5'VM   ',AL1(VARIABLE+MCHCC)
         DC    CL5'VBM  ',AL1(VARIABLE+BLOCKED+MCHCC)
         DC    CL5'VSM  ',AL1(VARIABLE+VSPANNED+MCHCC)
         DC    CL5'VTM  ',AL1(VARIABLE+TOVRFLOW+MCHCC)
         DC    CL5'VBSM ',AL1(VARIABLE+BLOCKED+VSPANNED+MCHCC)
         DC    CL5'VBTM ',AL1(VARIABLE+BLOCKED+TOVRFLOW+MCHCC)
         DC    CL5'VBSTM',AL1(VARIABLE+BLOCKED+VSPANNED+TOVRFLOW+MCHCC)
         DC    C' '
         EJECT
*
*        OPTCODE TABLE
*
         SPACE 3
OPTCODET DS    0H
OPTW     EQU   X'80'
OPTU     EQU   X'40'
OPTC     EQU   X'20'
OPTH     EQU   X'10'
OPTO     EQU   X'10'
OPTQ     EQU   X'08'
OPTZ     EQU   X'04'
OPTT     EQU   X'02'
OPTJ     EQU   X'01'
         DC    C'W'
OPTCMASK EQU   *-OPTCODET         OFFSET TO MASK BYTE IN ENTRY
         DC    AL1(OPTW)          WRITE VALIDITY CHECK (DASD)
OPTCLEN  EQU   *-OPTCODET
         DC    C'U',AL1(OPTU)     ALLOW DATA CHECK (INVALID CHAR)
         DC    C'C',AL1(OPTC)     CHAINED SCHEDULING
         DC    C'H',AL1(OPTH)     OCR HOPPER ENPTY EXIT?
         DC    C'O',AL1(OPTO)     OCR ON-LINE CORRECTION
         DC    C'Q',AL1(OPTQ)     ASCII TRANSLATION REQUIRED
         DC    C'Z',AL1(OPTZ)     REDUCED ERROR RECOVERY
         DC    C'T',AL1(OPTT)     USER TOTALING
         DC    C'J',AL1(OPTJ)     DYNAMIC SELECT OF TRANSLATE TAB
         DC    C' '               END OF TABLE
         EJECT
*
*        DATASET ORGANIZATION TABLE
*
         SPACE 3
DSORGTAB DS    0H
ISAM     EQU   X'80'
PHYSEQ   EQU   X'40'
DIRECT   EQU   X'20'
PDS      EQU   X'02'
UNMOVE   EQU   X'01'
         DC    CL3'PS ',AL1(PHYSEQ)
DSORGLEN EQU   *-DSORGTAB
         DC    CL3'PSU',AL1(PHYSEQ+UNMOVE)
         DC    CL3'DA ',AL1(DIRECT)
         DC    CL3'DAU',AL1(DIRECT+UNMOVE)
         DC    CL3'IS ',AL1(ISAM)
         DC    CL3'ISU',AL1(ISAM+UNMOVE)
         DC    CL3'PO ',AL1(PDS)
         DC    CL3'POU',AL1(PDS+UNMOVE)
         DC    C' '
         EJECT
*
*        LITERALS (IF ANY)
*
         SPACE 3
         LTORG
         EJECT
*
*        ERROR MESSAGE TABLE CSECTS
*
         SPACE  3
         PRINT NOGEN
ERRMSG1  MSGSETUP   ' FDB0001D **** DISASTER - READ OF JFCB FAILED.'
ERRMSG2  MSGSETUP   ' FDB0002E **** ERROR - OBTAIN FAILURE.  DATA SET NX
               OT FOUND ON VOLUME SPECIFIED.  CHECK FOR SPELLING ERRORSX
               .'
ERRMSG3  MSGSETUP   ' FDB0003D **** DISASTER - XDAP READ FAILED.  RUN AX
               BORTED.'
ERRMSG4  MSGSETUP   ' FDB0004D **** DISASTER - XDAP WRITE FAILED.  RUN X
                ABORTED.'
ERRMSG5  MSGSETUP   ' FDB0005E **** ERROR - UNKNOWN COMMAND SPECIFIED. X
                THIS CONTROL CARD IGNORED.'
ERRMSG6  MSGSETUP   ' FDB0006E **** ERROR - DATASET NAME NOT SPECIFIED.X
                 COMMAND NOT EXECUTED.'
ERRMSG7  MSGSETUP   ' FDB0007E **** ERROR - VOLUME SERIAL NUMBER NOT SPX
               ECIFIED.  COMMAND NOT EXECUTED.'
ERRMSG8  MSGSETUP   ' FDB0008E **** ERROR - NEW DATASET NAME NOT SPECIFX
               ED ON RENAME REQUEST.  COMMAND NOT EXECUTED.'
ERRMSG9  MSGSETUP   ' FDB0009E **** ERROR - UNKNOWN SUBCOMMAND FOR NAMEX
               .  ENTIRE NAME SUBCOMMAND SET IGNORED.'
ERRMSG10 MSGSETUP   ' FDB0010E **** ERROR - INVALID LOGICAL RECORD LENGX
               TH SPECIFIED.  ENTIRE NAME SUBCOMMAND SET IGNORED.'
ERRMSG11 MSGSETUP   ' FDB0011E **** ERROR - INVALID BLOCK SIZE SPECIFIEX
               D.  ENTIRE NAME SUBCOMMAND SET IGNORED.'
ERRMSG12 MSGSETUP   ' FDB0012E **** ERROR - VOLUME SPECIFIED NOT REFEREX
               NCED IN A DD CARD AND DYNAMIC ALLOCATION ATTEMPT FAILED.X
                 COMMAND NOT EXECUTED.'
ERRMSG13 MSGSETUP   ' FDB0013E **** ERROR - DATASET NAME SPECIFIED MULTX
               PLE TIMES.  COMMAND NOT EXECUTED.'
ERRMSG14 MSGSETUP   ' FDB0014E **** ERROR - INVALID DATA SET NAME SPECIX
               FIED.  COMMAND NOT EXECUTED.'
ERRMSG15 MSGSETUP   ' FDB0015E **** ERROR - VOLUME SERIAL SPECIFIED MULX
               TIPLE TIMES.  COMMAND NOT EXECUTED.'
ERRMSG16 MSGSETUP   ' FDB0016E **** ERROR - INVALID VOLUME SERIAL NUMBEX
               R SPECIFIED.  COMMAND NOT EXECUTED.'
ERRMSG17 MSGSETUP   ' FDB0017E **** ERROR - NEW DATASET NAME KEYWORD SPX
               ECIFIED MULTIPLE TIMES.  COMMAND NOT EXECUTED.'
*
ERRMSG18 MSGSETUP   ' FDB0018E **** ERROR - '  AVAILIABLE MESSAGE
*
ERRMSG19 MSGSETUP   ' FDB0019E **** ERROR - INVALID NEW DATASET NAME SPX
               ECIFIED FOR RENAME COMMAND.  COMMAND NOT EXECUTED.'
ERRMSG20 MSGSETUP   ' FDB0020E **** ERROR - UNKNOWN KEYWORD DETECTED ONX
                COMMAND CARD.  COMMAND NOT EXECUTED.'
ERRMSG21 MSGSETUP   ' FDB0021E **** ERROR - INVALID RECORD FORMAT SPECIX
               FIED.  ENTIRE NAME SUBCOMMAND SET IGNORED.'
ERRMSG22 MSGSETUP   ' FDB0022E **** ERROR - INVALID DATA SET ORGANIZATIX
               ON SPECIFIED.  ENTIRE NAME SUBCOMMAND SET IGNORED.'
ERRMSG23 MSGSETUP   ' FDB0023E **** ERROR - INVALID KEY LENGTH SPECIFIEX
               D.  ENTIRE NAME SUBCOMMAND SET IGNORED.'
ERRMSG24 MSGSETUP   ' FDB0024E **** ERROR - INVALID RELATIVE KEY POSITIX
               ON SPECIFIED.  ENTIRE NAME SUBCOMMAND SET IGNORED.'
ERRMSG25 MSGSETUP   ' FDB0025E **** ERROR - UNEXPECTED END-OF-FILE OCCUX
               RRED DURING CONTINUATION CARD PROCESSING.'
ERRMSG26 MSGSETUP   ' FDB0026E      LAST COMMAND WAS NOT EXECUTED.'
ERRMSG27 MSGSETUP   '0FDB0027E **** ERROR - INVALID EXECUTION PARAMETERX
                SPECIFIED.  "TEST" IS THE ONLY VALID PARM.  RUN ABORTEDX
                .'
MSG28    MSGSETUP   ' FDB0028I **** NOTE:  TEST RUN ONLY.  DSCB WILL NOX
               T BE REWRITTEN TO VTOC ON VOLUME.'
ERRMSG29 MSGSETUP   ' FDB0029E **** ERROR - VOLUME SERIAL REQUESTED NOTX
                REFERENCED IN A JCL STATEMENT.  COMMAND NOT EXECUTED.'
ERRMSG30 MSGSETUP   ' FDB0030I **** NOTE:  NO MODIFICATIONS WERE MADE TX
               O THE DSCB FOR THIS DATASET.  DSCB NOT REWRITTEN.'
ERRMSG31 MSGSETUP   ' FDB0031D **** DISASTER - OPEN FAILED FOR VTOC OF X
               VOLUME SPECIFIED.  POSSIBLE DISASTEROUS ERROR.  RUN ABORX
               ED.'
MSG32    MSGSETUP   ' FDB0032I **** COMMAND EXECUTED SUCCESSFULLY.'
MSG33    MSGSETUP   ' FDB0033I **** REPLY END TO TERMINATE FIXDSCB.'
ERRMSG34 MSGSETUP   ' FDB0034E **** ERROR - INVALID OPTCODE SPECIFIED. X
                ENTIRE NAME SUBCOMMAND SET IGNORED.'
ERRMSG35 MSGSETUP   ' FDB0035D **** DISASTER - XDAP WRITE FAILED DURINGX
                DUMMY RENAME FOR SCRATCH REQUEST.  RUN ABORTED.'
ERRMSG36 MSGSETUP   ' FDB0036D **** DATASET SPECIFIED HAS BEEN LEFT RENX
               AMED TO "FIXDSCB.SCRATCH.DATASET".  RUN ABORTED.'
ERRMSG37 MSGSETUP   ' FDB0037E **** ERROR - OPER STATUS REQUIRED TO USEX
                FIXDSCB UNDER TSO.  RUN TERMINATED.'
ERRMSG38 MSGSETUP   ' FDB0038E **** ERROR - AT LEAST ONE KEYWORD MUST OX
               CCUR ON THE COMMAND CARD.  COMMAND IGNORED.'
ERRMSG39 MSGSETUP   ' FDB0039E **** ERROR - VOLUME SPECIFIED NOT REFEREX
               NCED IN A DD CARD AND TSO DAIR FAILED.  COMMAND NOT EXECX
               UTED.'
ERRMSG40 MSGSETUP   ' '           DUMMY MESSAGE
ERRMSG41 MSGSETUP   ' '           DUMMY MESSAGE
ERRMSG42 MSGSETUP   ' '           DUMMY MESSAGE
ERRMSG43 MSGSETUP   ' '           DUMMY MESSAGE
ERRMSG44 MSGSETUP   ' '           DUMMY MESSAGE
ERRMSG45 MSGSETUP   ' '           DUMMY MESSAGE
ERRMSG46 MSGSETUP   ' '           DUMMY MESSAGE
ERRMSG47 MSGSETUP   ' '           DUMMY MESSAGE
ERRMSG48 MSGSETUP   ' '           DUMMY MESSAGE
ERRMSG49 MSGSETUP   ' '           DUMMY MESSAGE
ERRMSG50 MSGSETUP   ' '           DUMMY MESSAGE
         PRINT GEN
         SPACE 3
         DROP RA,RB,RC
         DROP R9
         TITLE 'FIXDMSGR - SYSPRINT/WTO/TPUT MESSAGE INTERFACE'
FIXDMSGR CSECT
*
*        FUNCTION: TO BUILD THE PROPER CONTROL BLOCKS AND TO USE
*                  THE PUT OR WTO I/O ROUTINES TO PRINT A MESSAGE.
*
*        INPUT   : REG. 1 CONTAINS THE ADDRESS OF THE MESSAGE
*                  PARAMETER LIST
*                  OFFSET LENGTH DESCRIPTION
*                  +0     4      MESSAGE TABLE ADDRESS
*                  +4     4      DCB ADDRESS
*                  +8     4      ADDRESS OF ANY SPECIAL MESSAGE
*                  +12    2      MESSAGE NUMBER
*                  +14    1      I/O FLAG (SYSPRINT, WTO, OR TSO)
*                  +15    1      CONSOLE ID (FOR WTO)
*
*                MESSAGE TABLE FORMAT:
*                  A LIST OF FULL-WORDS CONTAINING THE ADDRESS OF
*                  THE MESSAGE BUFFERS.
*
*                SPECIAL MESSAGES:
*                  SPECIAL MESSAGES ARE MESSAGES WHICH HAVE BEEN
*                  MODIFIED AND DO NOT EXIST IN THE NORMAL MESSAGE
*                  TABLE.  IF THE SPECIAL MESSAGE POINTER IS NON-
*                  ZERO THEN THAT MESSAGE IS USED INSTEAD OF LOOKING
*                  UP A MESSAGE IN THE TABLE.  SPECIAL MESSAGES MUST
*                  BE CONSTRUCTED IN THE FORM OF A VALID WTO BUFFER.
*                  EXAMPLE:
*                     SPMSG   DC   AL2(LENGTH OF TEXT + 4)
*                             DC   X'4000'       WTO FLAGS
*                             DC   C'TEXT'
*
         EJECT
*
*        INITIALIZATION
*
         SAVE  (14,12)            SAVE CALLER'S REGS.
         LR    RC,RF
         USING FIXDMSGR,RC        ADDRESS CSECT
         LR    R2,R1              PICK UP MESSAGE PARAM. LIST ADDR.
         USING MPLDSECT,R2        ADDRESS PARM LIST
         GETMAIN R,LV=LWASIZE,SP=LWASP OBTAIN LOCAL WORK AREA
         XC    0(LWASIZE,R1),0(R1)
         ST    RD,4(,R1)          CHAIN
         ST    R1,8(,RD)            SAVE
         LR    RD,R1                   AREAS
         USING LWAMAP,RD          ADDRESS WORK AREA
*        INITIALIZE LOCAL WORK AREA
         SPACE 1
         LA    RB,0               PRESET RC TO ZERO
         L     R3,MPLSPADD        PICK UP ADDRESS OF POSSIBLE SP MSG
         LTR   R3,R3              ANY SPECIFIED?
         BNZ   DOSPMSG            BRANCH IF SO
         L     R5,MPLMTTD         PICK UP MESSAGE TABLE ADDR.
         LH    R4,MPLNUMD         PICK UP MESSAGE NUMBER
         LTR   R4,R4              MESSAGE NUM SPECIFIED?
         BZ    ERRORXIT           BRANCH IF NOT
         BCTR  R4,0
         SLL   R4,2               COMPUTE TABLE INDEX
         L     R3,0(R4,R5)        PICK UP MESSAGE BUFFER ADDR.
DOSPMSG  DS    0H
         LH    R1,0(R3)           PICK UP LINE LENGTH
         LTR   R1,R1              LENGTH 0?
         BE    NOCLOSE            THEN GET OUT.  NO MESSAGE TO PRINT
         XC    MPLSPADD,MPLSPADD  ZERO OUT SPECIAL MESSAGE POINTER
         TM    MPLIOFD,CONSOLE    ARE WE A STARTED TASK
         BO    DOWTOIO            USE WTO TYPE I/O IF SO
         TM    MPLIOFD,TSOSESS    ARE WE A TSO SESSION
         BO    DOTSOIO            USE TPUT TYPE I/O IF SO
         L     R6,MPLDCBD         PICK UP DCB ADDRESS
         USING IHADCB,R6          ADDRESS DCB
         TM    DCBOFLGS,DCBOFOPN  IS DCB OPEN
         BO    DCBOPEN            BRANCH IF SO
         OI    LWAFLAG,OPENHERE   FLAG AS OPENED HERE
         OPEN  ((6),OUTPUT)       OPEN IT UP
         TM    DCBOFLGS,DCBOFOPN  DID IT WORK
         BZ    ERROROPN           BRANCH IF NOT
DCBOPEN  DS    0H
         DROP  R6
         SPACE 1
PUTOUT   DS    0H
         MVI   LWALINE,BLANK      BLANK OUT LINE BUFFER
         MVC   LWALINE+1(132),LWALINE
         LH    R1,0(R3)           PICK UP LINE LENGTH
         S     R1,FIVE            DROP FOR EXECUTED INST AND FOR
*                                 WTO HEADDER OMISSION
         EX    R1,LINEMOVE        MOVE TO BUFFER
         PUT   (6),LWALINE
         SPACE 1
EXITROUT DS    0H
         TM    LWAFLAG,OPENHERE
         BNO   NOCLOSE
         CLOSE ((6))              WE OPENED IT SO WE CLOSE IT
         B     NOCLOSE
         EJECT
*
*        DO WTO TO STARTING CONSOLE
*
         SPACE 3
DOWTOIO  DS    0H
         IC    R0,MPLCOND         PICK UP CONSOLE ID
         LR    R1,R3              POINTER TO WTO MESSAGE AREA IN LIST
         WTO   MF=(E,(1))         EXECUTE
         B     NOCLOSE
         EJECT
*
*        DO TPUT TO TSO SESSION
*
         SPACE 3
DOTSOIO  DS    0H
         LH    R0,0(R3)           PICK UP MESSAGE LENGTH
         S     R0,MPLFOUR         DROP BY FOUR (COMPENSATE FOR HEADER)
         LA    R1,4(R3)           PICK UP MESSAGE TEXT ADDRESS
         O     R1,TPUTFLAG        SET IN FLAGS
         LA    RF,0               SET UID POINTER TO ZERO
         TPUT  (1),(0),R          EXECUTE TPUT
         B     NOCLOSE
         EJECT
*
*        DI-INITIALIZE AND EXIT
*
         SPACE 3
NOCLOSE  DS    0H
         XC    LWAFLAG,LWAFLAG    ZERO OUT THE FLAGS
         XC    MPLNUMD,MPLNUMD    ZERO MSG NUMBER
         LR    R1,RD              LOAD PARAMETER REG. 1
         L     RD,4(,RD)          RESTORE CALLER'S SAVE REG.
         FREEMAIN R,LV=LWASIZE,SP=LWASP,A=(1) FREE LOCAL WORK AREA
         LR    RF,RB              LOAD RETURN CODE
         RETURN (14,12),RC=(15)   RETURN TO CALLER
ERRORXIT DS    0H
         LA    RB,20              INDICATE INVALID PARAMETER LIST
         B     NOCLOSE
ERROROPN DS    0H
         LA    RB,24              INDICATE OPEN FAILURE
         B     NOCLOSE
         EJECT
*
*        LOCAL CONSTANTS AND EXECUTED INSTRUCTIONS
*
         SPACE 1
TPUTFLAG DC    F'0'               TPUT FLAGS
MPLFOUR  DC    F'4'
FIVE     DC    F'5'
LINEMOVE MVC   LWALINE(0),4(R3)
         SPACE 3
*
*        LOCAL WORK AREA MAPPING
*
         SPACE 1
LWAMAP   DSECT
         DS    18F                REG. SAVE AREA
LWALINE  DS    CL133
LWAFLAG  DS    X
OPENHERE EQU   X'80'              DCB SUPPLIED OPENED LOCALLY
LWASIZE  EQU   *-LWAMAP
LWASP    EQU   1
         SPACE 3
*
*        TSO COMMAND BUFFER MAPPING DSECT (CBUFF)
*
         SPACE 1
CMDBUFR  DSECT
CMDBLEN  DS    H
CMDBOFF  DS    H
CMDBTEXT DS    C
         SPACE 3
*
*        MESSAGE PARAMETER LIST MAPPING DSECT (MPL)
*
         SPACE 1
MPLDSECT DSECT
MPLMTTD  DS    A
MPLDCBD  DS    A
MPLSPADD DS    A
MPLNUMD  DS    H
MPLIOFD  DS    C
MPLCOND  DS    C
         EJECT
*
*        FORMAT 1 DSCB MAPPING DSECT
*
         SPACE 3
DSCB     DSECT
         IECSDSL1 1
         EJECT
*
*        EXTERNAL DATA AREA MAPPING DSECTS
*
         SPACE 3
         PRINT NOGEN
JFCBDSCT DSECT
         IEFJFCBN
JFCBMOD  EQU   X'80'
         SPACE 1
         DCBD DSORG=XE,DEVD=DA
         SPACE 1
         IEFTIOT1
         SPACE 1
         IEFUCBOB
         SPACE 1
         IHAPSA
         SPACE 1
         IEECHAIN
         SPACE 1
         IKJDAPL
         SPACE 1
         IKJPSCB
         SPACE 1
         IKJCPPL
         SPACE 1
         IHAASCB
         SPACE 1
         CVT DSECT=YES,PREFIX=YES
         END
