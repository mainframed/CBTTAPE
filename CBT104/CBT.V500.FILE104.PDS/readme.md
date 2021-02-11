
## $$$DOC.txt
```
//*                                                                 *
//***FILE 158 IS FROM CONNECTICUT MUTUAL LIFE INSURANCE COMPANY     *
//*           AND CONTAINS A COPY OF THEIR DSPRINT REPLACEMENT      *
//*                                                                 *
//*                J R P         (JES2 REMOTE PRINTERS)             *
//*                                                                 *
//*               THIS PRODUCT WAS DESIGNED AND WRITTEN WITH THE    *
//*           INTENT OF INCREASING USER AS WELL AS PROGRAMMER       *
//*           PRODUCTIVITY. IT("JRP") MAKES USE OF 3270 PRINTER     *
//*           DEVICES TO PRINT SPOOLED JES2 OUTPUT.  OUTPUT         *
//*           DEVICES ARE DEFINED TO "JRP" VIA A SEQUENTIAL DATA    *
//*           SET.  EACH CONTROL CARD IN THIS DATA SET DESCRIBES    *
//*           THE ATTRIBUTES OF ONE PRINTER.                        *
//*                                                                 *
//*              AFTER "JRP" INITIALIZATION,A SUBSYSTEM REQUEST     *
//*           IS ISSUED TO JES2 BASED ON EACH PRINTERS              *
//*           DESCRIPTION. IF JES2 CONFIRMS THAT OUTPUT IS          *
//*           AVAILABLE FOR THE PRINTER DESCRIBED,A SUBTASK IS      *
//*           CREATED, USING THE ATTRIBUTES DEFINED FOR THAT        *
//*           PARTICULAR DEVICE.  THE SPOOL DATASET IS READ,        *
//*           BUFFERED, THEN WRITTEN TO THE PRINTER VIA "VTAM".     *
//*                                                                 *
//*               "JRP" SUPPORTS VTAM SNA AND NONSNA TERMINALS AS   *
//*           "JRP" CONTROL TERMINALS. A MAXIMUM OF 25(TWENTY       *
//*           FIVE) TERMINALS ARE SUPPORT SIMULTANIOUSLY. ALL       *
//*           FUNCTIONS REQUIRED TO SUPPORT "JRPS" PRINTER          *
//*           DEVICES ARE AVAILIBLE FROM A "JRP" CONTROL            *
//*           TERMINAL.                                             *
//*                                                                 *
//*           MODIFIED TO HANDLE SUPPRESS PRINT CONTROL CHARACTER.  *
//*           CAN NOW BE USED TO PRINT SAS GRAPHS.                  *
//*           WORKS ON MVS/XA DFP RELEASE 2.1.0 AND JES2 2.1.7      *
//*                                                                 *
//*           MODIFIED BY:  LEWIS D. WHALEY                         *
//*                         SENIOR SYSTEMS ENGINEER                 *
//*                         NUCLEAR FUEL SERVICES, INC.             *
//*                         205 BANNER HILL ROAD                    *
//*                         ERWIN, TN  37650                        *
//*                         (615) 743-9141  EXT: 363                *
//*                                                                 *
//*                                                                 *
```

## $$DOCOL.txt
```
1











 7         JJJJJJJJJJJJJ      RRRRRRRRRRRRR            PPPPPPPPPPPP
 7        JJJJJJJJJJJJJ      RRRRRRRRRRRRRRR          PPPPPRPPPPPPPP
 7            JJJJJ         RRRRRR    RRRRRR         PPPPP    PPPPPP
 7           JJJJJ         RRRRRR     RRRRRR        PPPPP     PPPPPP
 7          JJJJJ         RRRRRRRRRRRRRRRR         PPPPPPPPPPPPPPP
 7         JJJJJES2      RRRRRRRRRRRRRRRR         PPPPPPPPPPPPPP
 7JJJJJ   JJJJJ         RRRRR        REMOTE      PPPPP
 7JJJJJ  JJJJJ         RRRRR         RRRR       PPPPPRINT
 7 JJJJJJJJJJ         RRRRR          RRRR      PPPPP
 7  JJJJJJJ          RRRRR           RRRRR    PPPPP
17TABLE OF CONTENTS
    CONTENT                                 PAGE

    INTRODUCTION............................1
    "JRP" INSTALLATION......................2
    "JRP" STARTUP...........................3
    "JRP" SHUTDOWN..........................3
    "JRP" CONTROL TERMINALS.................4
    "JRP" COMMANDS..........................5
    "JRP" ATTRIBUTE SPECIFICATION...........7
    "JRP" PRINTER STATUS....................8
    "JRP" USE OF............................9
    "JRP" SNA FEATURES......................10
    "JRP" MESSAGES..........................11
    "JRP" USER ABEND CODES..................14
    "JRP" MODULE FLOW ......................15
    "JRP" MODULE DESCRIPTIONS...............16
17INTRODUCING JRP(JES2 REMOTE PRINTERS)                       PAGE 1

        THIS PRODUCT WAS DESIGNED AND WRITTEN WITH THE INTENT OF
    INCREASING USER AS WELL AS PROGRAMMER PRODUCTIVITY. IT("JRP")
    MAKES USE OF 3270 PRINTER DEVICES TO PRINT SPOOLED JES2 OUTPUT.
    OUTPUT DEVICES ARE DEFINED TO "JRP" VIA A SEQUENTIAL DATA SET.
    EACH CONTROL CARD IN THIS DATA SET DESCRIBES THE ATTRIBUTES
    OF ONE PRINTER.
       AFTER "JRP" INITIALIZATION,A SUBSYSTEM REQUEST IS ISSUED TO
    JES2 BASED ON EACH PRINTERS DESCRIPTION. IF JES2 CONFIRMS THAT
    OUTPUT IS AVAILABLE FOR THE PRINTER DESCRIBED,A SUBTASK IS CREATED,
    USING THE ATTRIBUTES DEFINED FOR THAT PARTICULAR DEVICE.
    THE SPOOL DATASET IS READ, BUFFERED, THEN WRITTEN TO THE PRINTER
    VIA "VTAM".

    ******* IMPORTANT NOTE *******
    JRP WILL PRINT A MAXIMUM OF 256 CHARACTERS PER RECORD
    ******* IMPORTANT NOTE *******
17INSTALLATION PAGE 2

    1.  UNLOAD FILE 1 (ONE) TO 80/3120 DATA PDS:

        //STEP1   EXEC PGM=IEBCOPY
        //SYSUT1    DD DSN=JRPTP,UNIT=6250,LABEL=(1,NL),
        //             DISP=(OLD,KEEP),VOL=SER=JRP
        //SYSUT2    DD DSN="JRP.DATA",DISP=(,CATLG),VOL=SER="VOLSER",
        //          UNIT="DEVTYP",SPACE=(TRK,(20,2,5))
        //SYSPRINT  DD SYSOUT=A
        //SYSIN     DD *
          COPY INDD=SYSUT1,OUTDD=SYSUT2
        /*

    2.  TAYLOR PROC JRP FROM JRP.DATA LIB FOR YOUR APF AUTHORIZED
         STEPLIB OR REMOVE STEPLIB AND LET LINKLIST DO IT.

    3.  EDIT JRPINST MEMBER TO SPECIFY YOUR LIBRARY NAMES FOR
        SYSLIB, SYSLMOD... FOR JRPRINT BE SURE TO SPECIFY A
        LINKLIST LIBRARY FOR ACCESSIBILITY FROM TSO.

    4.  SUBMIT JRPINST TO BATCH FOR ASSEMBLY AND LINK.
        NOTE** REASSEMBLE JRP 200,210,220 FOR JES2 UPGRADE.

    5.  COPY MEMBER JRPRINTH TO SYS1.HELP CHANGING NAME TO JRPRINT

    6.  EDIT AND FORMAT THE "JRP" INITIALIZATION DATA-SET TO
        DEFINE THE REMOTE PRINTERS IN YOUR ENVIRONMENT:

         COL 1-8    :    PRINTER NAME(1-8 CHARACTERS)
         COL 10-72  :    PRINTER ATTRIBUTES AS DESCRIBED IN SECTION,
                         'ATTRIBUTE SPECIFICATION'.  THE OPERANDS
                         ARE SPECIFIED WITH KEYWORDS, AND MAY BE
                         ENTERED IN ANY ORDER.
                   *NOTE CONTROL INFORMATION FOR EACH PRINTER
                    MAY BE CONTAINED IN CONTINUATION CARDS
                    INCLUDING ,(COMMA) AFTER LAST PARAMETER
                    ON CARD "X" IN COLUMN 72 AND CONTINUATION
                    MUST BEGIN IN COLUMN 10.

          EX.:
  COL:    1        10                                                72
          RMT001   R=RMT001,SCS=N,LGMD=NSNAPRT,LU=LU0A0,S=N,         X
                   MLIN=0,F=A100,C=A,LPP=068,
          R002     R=RMT002,LGMD=SCSPRT,C=A,LU=SNA05B

      7.  ADD THE VTAM NODE'S FOR JRP AND "JRP" CONTROL TERMINALS
           AS FOLLOWS;

          JRPA     APPL   ACBNAME=JRP,AUTH=ACQ
          CJRPA    APPL   ACBNAME=CJRP,AUTH=PASS



17JRP STARTUP                                                 PAGE 3

    AFTER ALL UPDATES HAVE BEEN MADE TO JRPDATA, JRP MAY BE
    INITIATED FROM THE OPERATORS CONSOLE:

      ENTER:  S JRP
      RESP:   JRPI101 INITIALIZATION COMPLETE
      WTOR:   XX JRP100I ENTER "ICLOSE" TO SHUT DOWN

 7JRP SHUTDOWN

    TO HALT AND REQUEUE ALL CURRENT PRINTING ACTIVITY AND
    TERMINATE JRP FROM MVS OPERATOR CONSOLE ENTER:

       ENTER:  R XX,ICLOSE
       RESP:   JRPI102 ICLOSE IN PROGRESS
               JRPI104 SHUTDOWN COMPLETE, ENDING



17JRP CONTROL TERMINALS                                     PAGE 4

        "JRP" SUPPORTS VTAM SNA AND NONSNA TERMINALS AS "JRP"
    CONTROL TERMINALS. A MAXIMUM OF 25(TWENTY FIVE) TERMINALS ARE
    SUPPORT SIMULTANIOUSLY. ALL FUNCTIONS REQUIRED TO SUPPORT "JRPS"
    PRINTER DEVICES ARE AVAILIBLE FROM A "JRP" CONTROL TERMINAL.
    USE OF THESE CONTROL TERMINALS IS DESCRIBED BELOW ALTHOUGH
    PRINTER CONTROL COMMANDS ARE DESCRIBED IN SECTION "JRP COMMANDS"

     1. LOGON TO JRP CONTROL TERMINAL(USS TABLE LOGON IS PREFERABLE).
        OR  'LOGON APPLID(CJRPA)'
     2. ENTER USERID AND PASSWORD.(THIS IS ONLY MEANINGFULL TO "JRP"
        IF JRP123 SECURITY EXIT IS CODED ALTHOUGH AT LEAST ON CHARECTER
        IN USERID AND PASSWORD FIELD IS REQUIRED.)
     3. AFTER USERID AND PASSWORD ACCEPTANCE THE COMMAND SCREEN IS
        DISPLAYED. LUID IN UPPER LEFT COMMAND LINE ON LOWER LEFT.
        "JRP" CONTROL TERMINAL OR PRINTER COMMANDS MAY BE ENTERED NOW.
17JRP COMMANDS                                                PAGE 5

   THE FOLLOWING COMMANDS ARE ARE ISSUED FROM A "JRP" CONTROL TERMINAL


   PRISCN            SET TERMINAL TO 3278 MOD2 SCREEN SIZE (DEFAULT).

   ALTSCN            SET TERMINAL TO ALTERNATE SCREEN SIZE AS DEFINED
                     IN BIND.
                     ** CARE MUST BE TAKEN TO ENSURE TERMINAL
                     WILL SUPPORT THE ALTERNATE SCREEN SIZE AS DEFINED.
                     INACT/ACT OF LU WILL BE REQUIRED IF INCOMPATIBLE
                     SIZE REQUESTED.

   WRAP               SET TERMINAL IN AUTO WRAP MODE.    (DEFAULT)

   NOWRAP            "JRP" WILL SEND ONE SCREEN OF REQUESTED INFORMTION,
                     'MORE DATA....' WILL APPEAR IN LOWER LEFT OF
                     TERMINAL THEN WAIT FOR FURTHER INTERVENTION FROM
                     "JRP" OPERATOR(ENTER). NO "JRP" COMMANDS WILL BE
                     ACCEPTED BEFORE THE 'MORE DATA....' CONDITION IS
                     CLEARED.

   NOUNSOL           NO "JRP" UNSOLICITED INFORMATION WILL BE SENT TO
                     THIS TERMINAL.           (DEFAULT)

   UNSOL             "JRP" WILL SEND ANY UNSOLICITED PRINTER STATUS
                     INFORMATION TO THIS TERMINAL.
                  **NOTE: UNSOL AND NOWRAP ARE MUTUALLY EXCLUSIVE.
                     ONE MUST BE REVERSED BEFORE THE OTHER IS ACCEPTED.

   LOGON AAAAAAAA     THIS COMMAND WILL ALLOW DIRECT LOGON FROM "JRP"
                     CONTROL TERMINAL TO AAAAAAAA(ANY VALID VTAM APPLID
                     AS SPECIFIED IN LABEL OF VTAM APPL DEFINATION).

   LOGOFF             TERMINATE THIS "JRP" CONTROL TERMINAL SESSION.

   CLOSE              REQUESTS THAT "JRP" CLOSE AFTER COMPLETING ALL
                     CURRENT PRINT ACTIVITY.(THIS MAY TAKE A WHILE AND
                     ALL CONTROL TERMINAL SUPPORT IS TERMINATED AT THIS
                     POINT). CLOSE AND ICLOSE COMMANDS ARE IRREVERSIBLE
                 *NOTE: IF JRP IS CANCELED BY MVS OPERATOR OUTPUT
                        CURRENTLY PRINTING OR RETRYING ON A "JRP"
                        PRINTER WILL BE LOST!!!!!!!

   ICLOSE             REQUESTS THAT "JRP" REQUE CURRENT PRINT ACTIVITY
                     TO JES2,  TERMINATE ALL PRINTER SESSIONS AND
                     COMPLETE NORMAL CLOSE-DOWN. THIS IS THE RECOMMENDED
                     CLOSE PROCEDURE BECAUSE IT TAKES A RELATIVELY SHORT
                     PERIOD OF TIME TO COMPLETE(NORMALLY UP TO 5 MINUTES
                     WITH 50 PRINTERS DEFINED). ALL "JRP" CONTROL
                     TERMINAL SESSIONS ARE TERMINATED AFTER CLOSE OR
                     ICLOSE COMMANDS ARE ISSUED.
                     CLOSE AND ICLOSE COMMANDS ARE IRREVERSIBLE.
                 *NOTE: IF JRP IS CANCELED BY MVS OPERATOR OUTPUT
                        CURRENTLY PRINTING OR RETRYING ON A "JRP"
                        PRINTER WILL BE LOST!!!!!!!

   CANCEL LLLLLLLL    THIS COMMAND WILL TERMINATE A "JRP" CONTROL
                     TERMINAL FOR SPECIFIED VTAM LUID.
                     LLLLLLLL = VTAM LUID OF "JRP" CONTROL TERMINAL.

   RESET              THIS COMMAND WILL TERMINATE ALL "JRP"
                     CONTROL TERMINAL SESSIONS, RESET CONTROL TERMINAL
                     ACB AND REALLOW LOGONS TO "JRP" CONTROL TERMINALS.

17                                                           PAGE 6

  $DXXXXXXXX         DISPLAY THE STATUS OF PRINTER XXXXXXXX

  $DU                DISPLAY THE STATUS OF ALL PRINTERS

  $SXXXXXXXX         RESUME PRINTER XXXXXXXX'S ELIGIBILITY TO
                     RECEIVE OUTPUT AFTER A JRP $P COMMAND OR ERROR
                     CONDITION HAS MADE IT INELIGIBLE

  $SU                RESUME ALL PRINTERS ELIGIBILITY TO RECEIVE
                     OUTPUT AFTER A JRP $PU COMMAND OR ERROR CONDITION
                     HAVE MADE THEM INELIGIBLE

  $PXXXXXXXX         REMOVE ELIGIBILITY OF PRINTER XXXXXXXX TO RECEIVE
                     OUTPUT AFTER THE CURRENT PRINT ACTIVITY HAS
                     COMPLETED ON THAT DEVICE

  $PU                REMOVE ELIGIBLITY OF ALL PRINTERS TO RECEIVE
                     OUTPUT AFTER CURRENT ACTIVITY ON EACH DEVICE
                     HAS COMPLETED

  $EXXXXXXXX         RESTART ACTIVITY ON PRINTER XXXXXXXX

  $CXXXXXXXX         CANCEL THE OUTPUT ON PRINTER XXXX
                     THE SAME * RESULT MAY BE OBTAINED ON AN 'SCS'
                     EQUIPPED PRINTER BY PUSHING:
                        1.  HOLD PRINT
                        2.  CANCEL PRINT
                        3.  ENABLE PRINT
                            * THE PRINTER STATUS CODE, 59, MUST BE
                              DISPLAYED ON THE PRINTER BEFORE CANCEL
                              WILL BE ACCEPTED BY JRP

  $TXXXXXXXX         CHANGE THE INITIAL ATTRIBUTES FOR PRINTER XXXXXXXX.
                     SEE 'ATTRIBUTE SPECIFICATION' FOR THE LIST OF
                     ATTRIBUTES THAT MAY BE MODIFIED WITH THE JRP
                     '$T' COMMAND.


17ATTRIBUTE SPECIFICATION                                     PAGE 7

   CONTROL CARD RULES.
   1. PRINTER NAME(1-8 CHARACTERS) MUST BEGIN IN COLUMN 1 AND
     IN COLUMN 1 CARD 1 OF A CONTINUATION SERIES(IF CONTINUATION IS
      USED).

   2. KEYWORD PARAMETERS(TO INCLUDE CONTINUATION CARD IF USED) MUST
     BEGIN IN COLUMN 10.

   3. CONTINUATION CHARACTER MUST BE IN COLUMN 72 AND A BLANK MUST
     PRECEDE CONTINUATION CHARACTER IF CONTINUATION IS USED.

   THE FOLLOWING KEYWORDS ARE VALID TO DEFINE PRINTER ATTRIBUTES
   IN THE JRPDATA FILE FOR START-UP OR AS MODIFIES AFTER
   INITIALIZATION USING THE "JRP" $T COMMAND . *SEE "JRP COMMANDS"

      LPP=          SPECIIFY THE NUMBER OF LINES PER PAGE FOR
                    'SCS=N' PRINTERS ONLY.  THE DEFAULT IS 68
                    LINES PER PAGE FOR 12 INCH PAPER AT 8 LINES
                    PER INCH
           DEFAULT: LPP=68

      LU=           THE VTAM LOGICAL UNIT NAME FOR THE PRINTER
                    HAVING A MAXIMUM OF 8 CHARACTERS.  THE LU
                    NAME MUST BE SPECIFIED AT INITIALIZATION;
           DEFAULT: NONE. *REQUIRED AT INITIALIZATION

       R=           SPECIFIES THE RJE DESTINATION ID. IF RJE
                    NAMES ARE TO BE USED, THEY MUST BE SPECIFIED AT
                    INITIALIZATION TIME.
           DEFAULT: LOCAL.

       LGMD=        THE LOGMODE ENTRY NAME APPLICABLE FOR THIS PRINTER,
                    A MAXIMUM OF EIGHT CHARACTERS MAY BE USED.
           DEFAULT: VTAM DEFAULT ON VTAM LBUILD, OR FIRST IN MODE
                    TABLE IF NOT DEFINED ON PRINTER LBUILD DEFINITION.
                  *NOTE; IF LGMD IS SPECIFIED RELRQ EXITS WILL NOT
                         BE INVOKED.

       MLIN=        THE MAXIMUM NUMBER OF LINES TO BE PRINTED ON THIS
                    DEVICE FOR ANY ONE JOB OR TSO SPINNOFF OUTPUT.
                    WHEN THIS LIMIT IS REACHED OUTPUT WILL BE
                    TERMINATED AND OUTPUT WILL BE PURGED FROM QUEUE.
           DEFAULT: 9999 LINES

       SCS=         SET TO 'Y' OR 'N' TO SPECIFY IF A PRINTER IS
                    SCS OR DSC EQUIPPED.
           DEFAULT: SCS=Y

                    NOTE: IF SCS EQUIPPED, PRINTER MUST BE A SNA DEVICE
                    AND CAN NOT BE A LOCAL DEVICE.  IF 'SCS=Y' IS
                    SPECIFIED, THE LOGMODE MUST ALSO BE FOR A SNA
                    PRINTER.  IF 'SCS=N' IS SPECIFIED, THE LOGMODE
                    MUST BE FOR A NON-SNA DEVICE.  SCS=N WILL WORK FOR
                    EITHER SNA OR NON-SNA, BUT SNA FEATURES WILL
                    NOT BE AVAILABLE (JRP CANCEL KEY AND BRACKET
                    PROTOCOL). SEE JRP SNA FEATURES FOR MORE DETAILS.

       F=           SPECIFY A FOUR CHARACTER FORM NUMBER.  THIS
                    OPTION IS NOT REQUIRED, AND IS NOT RECOMMENDED.
           DEFAULT: NONE.

       C=           SPECIFY THE OUTPUT CLASS DESTINATION.  A MAXIMUM
                    OF 8 ONE CHARACTER OUTPUT CLASS SEARCH ARGUMENTS
                    MAY BE DEFINED WITH NO DELIMINATING COMMA'S.
           DEFAULT: NONE.


17PRINTER STATUS                                              PAGE 8


      THE JRP '$DXXXX' OR THE '$DU' COMMAND WILL DISPLAY THE PRINTER
      STATUS TO THE OPERATOR CONSOLE.  THE MEANING OF EACH OF THESE
      IS AS FOLLOWS:

   ACTIVE       THE PRINTER IS CURRENTLY ACTIVE; THE JOBNAME AND
                JOBNUMBER WILL ALSO BE DISPLAYED.

   INACTIVE     THE PRINTER IS CURRENTLY IDLE AND IS AVAILABLE TO
                OTHER VTAM APPLICATIONS.

   DRAINED      THE PRINTER IS NOT ELIGIBLE TO RECEIVE WORK DUE TO
                A PREVIOUS JRP '$P' COMMAND.   THE JRP '$S' COMMAND
                WOULD RESTORE ELIGIBLITY.

   DRAINING     THE PRINTER WILL BE INELIGIBLE TO RECEIVE WORK AFTER
                THE CURRENT ACTIVITY HAS COMPLETED ON THE SPECIFIED
                DEVICE.THE JRP '$S' COMMAND WOULD RESTORE ELIGIBILITY.

   RETRYING     THIS PRINTER IS IN RETRY STATUS. ATTEMPTS AT CONTACTING
                THIS DEVICE HAVE BEEN UNSUCCESSFUL THUS FAR, THOUGH
                IT"S RETRY LIMIT HAS NOT BEEN REACHED.

   RETRYLM      THE 'RETRY LIMIT' HAS BEEN MET DUE TO I/O ERRORS ON
                THAT DEVICE, AND THE DEVICE IS NOW IN AN INELIGIBLE
                STATUS.ISSUE THE JRP '$S' COMMAND AFTER CORRECTING THE
                HARDWARE PROBLEM (POWER OFF, HOLD, CABLE CONNECTION,
                ETC.) TO RESTORE THE ELIGIBLE STATUS.

   ABENDTCCC    THIS PRINTER SUBTASK AT SOME POINT ENCOUNTERED
                A PROBLEM LEADING TO AN ABEND. THIS STATUS IS
                POSTED AS SUCH. JRP '$S' COMMAND MUST BE ISSUED FOR
                THIS PRINTER TO RESTORE OUTPUT ELIGIBILITY.
       T   ==>  ABEND TYPE S(SYSTEM) U(USER)
       CCC ==>  ABEND CODE(I.E. 0C4)


17JRP USE OF                                                  PAGE 9
   THERE ARE A NUMBER OF WAYS TO UTILIZE JRP"S ABILITY TO INTERFACE
   WITH JES2. ONE IS TO SPECIFY OUTPUT CLASS AND SPECIAL FORM NUMBER,
   AND USE THOSE AS THE SPECIFICATION ON OUTPUT DD STATEMENT.
          BELOW IS THE SPECIFICATION FOR JRPDATA AND OUTPUT DD.

       EX JRP;PRT1      LU=VTS05A,SCS=N,LGMD=DSILGMOD,F=PRT1,C=A
       EX DD  ;//SYSPRINT DD SYSOUT=(A,,PRT1)

   ANOTHER USE, ALSO THE RECOMMENDED USE IS VIA JES NONSNA RJE ID"S.
   THIS TECHNIQUE LEAVES ROOM FOR THE GREATEST FLEXIBILITY AND
   EFFECTIVE UTILIZATION. BELOW IS AN EXAMPLE OF JRP INITIALIZATION
   CONTROL CARD AND USES OF RJE DESTINATION.

       EX JRP;  R001      LU=VTS05A,SCS=N,LGMD=DSILGMD,R=RMT001
       EX JCL; */ ROUTE RMT001  (ROUTES ALL JOB OUTPUT TO RMT001)
       EX DD ; //SYSPRINT DD SYSOUT=*,DEST=RMT001
       EX TSO;  ALLOC SYSOUT(A) DEST(RMT001) DD(SYSPRINT)

   THE RJE ID"S YOU WISH TO USE MUST BE DEFINED TO JES2. IF YOU HAVE
   NO RJE ID"S DEFINED OR WISH TO DEFINE MORE A JES2 COLD START IS
   REQUIRED.

   IT IS RECOMMENDED, ONLY TO AVOID CONFUSION, THAT THE PRINTER NAME
   BE CHOSEN BASED ON IT"S REMOTE ID(OR FORM NUMBER IF THAT IS THE
   METHOD OF USE). FOR EXAMPLE IF THE FORM NUMBER IS PRT1 THEN THE
   PRINTER NAME MIGHT BE PRT1. IF THE DESTID IS RMT001 THEN THE
   PRINTER NAME MIGHT BE RMT001 OR R001.

    ******* IMPORTANT NOTE *******
    JRP WILL PRINT A MAXIMUM OF 256 CHARACTERS PER RECORD
    ******* IMPORTANT NOTE *******


17JRP SNA FEATURES                                            PAGE 10


   1.  BRACKET PROTOCOL

       BRACKET PROTOCOL WILL PREVENT THE INTERLEAVING OF
       UNSOLICITED OUTPUT, REQUESTED WITH THE LOCAL PRINT KEY,
       AND JRP OUTPUT.

   2.  CANCEL KEY

       A. PUSH HOLD PRINT
               CANCEL PRINT
               ENABLE PRINT

          IF THE PRINTER CODE, 59, IS NOT DISPLAYED WHEN THE
          CANCEL PRINT KEY IS PUSHED, COMPLETE SEQUENCE AND RETRY.

   3.   LINES PER PAGE

        THE NUMBER OF PRINT LINES PER PAGE MAY BE CONTROLLED WITH
        THE LINE COUNT INDICATOR ON THE PRINTER.
17JRP MESSAGES                                                PAGE 11



             "MESSAGES ISSUED BY JRP100"

   JRPI101 INITIALIZATION COMPLETE
             ALL INITIALIZATION OF SUBTASK DYNAMIC AREA'S BY DATA
             IN INITIALIZATION DATA-SET HAS SUCCESSFULLY COMPLETED
             AND JRP200 SUBTASK HAS BEEN CREATED.

   JRPI102 ICLOSE IN PROGRESS
             ALL SUBTASKS ARE NOTIFIED THAT "F JRP,ICLOSE" HAS
             BEEN ISSUED. CLOSE WILL COMPLETE AFTER ALL ACTIVE PRINT
             HAS BEEN REQUEUED AND SUBTASKS TERMINATED.

   JRPI103 CLOSE IN PROGRESS
             ALL SUBTASKS ARE NOTIFIED THAT "F JRP,CLOSE" HAS
             BEEN ISSUED. CLOSE WILL COMPLETE AFTER ALL ACTIVE PRINT
             HAS COMPLETED AND SUBTASKS TERMINATED.

   JRPI104 SHUTDOWN COMPLETE, ENDING.
             "CLOSE" , "ICLOSE" OR ABEND PROCESSING HAS COMPLETED AND
             ALL SUBTASKS HAVE TERMINATED. JRP IS TERMINATING.

   JRPE100 ACB NOT AVAILABLE.
             JRP"S ACB IS IN USE, NOT ACTIVE, OR NOT DEFINED
             ABEND U001 WILL FOLLOW.

   JRPE101 JRP200 ERROR ENCOUNTERED
             JRP200 AND OR JRP210 ENCOUNTERED SOME PROBLEM
             ACCESSING JES2 BASED ON SUBSYSTEM CONTROL BLOCK DEFINATION.
17           "MESSAGES ISSUED BY JRP110-JRP121"              PAGE 12

   JRPI110 OK / INVALID
             THIS MESSAGE IS ISSUED IN RESPONSE TO ANY DISPLAY
             COMMAND OK ==> COMMAND ACCEPTED AS ENTERED,
             INVALID ==> COMMAND IN ERROR(SYNTACTICALLY , MISSPELLED ,
             OR INVALID PRINTER NAME) CONSULT USER GUIDE AND OR
             JRP ADMINISTRATOR FOR ASSISTANCE.

   JRPI111 XXXX SSSSSSSSSS JJJJJJJJ(NNNNNNNN) F=FFFF,C=CCCCCCCC,
   CONT'D      R=RRRRRRRR,S=Y/N,LPP=LLL,MLIN=MMMM,LU=LUIDENT ,SCS=Y/N,
   CONT'D      LGMD=MODEENT,RTCD=AA,FDB2=BB,SENSE=QQQQQQQQ

             THIS STATUS MESSAGE IS ISSUED IN RESPONSE TO ANY JRP
             COMMAND TO DISPLAY OR CHANGE A PRINTER STATUS.
             XXXX     ==>  PRINTER NAME
             SSSSSSSS ==>  PRINTER STATUS
             JJJJJJJJ ==>  NAME OF JOB ACTIVE ON THIS PRINTER
             NNNNNNNN ==>  NUMBER OF JOB ACTIVE ON THIS PRINTER
             FFFF     ==>  FORM NUMBER(SSOB SEARCH ARGUMENT)
             CCCCCCCC ==>  OUTPUT CLASS NUMBER(SSOB SEARCH ARGUMENT)
             RRRRRRRR ==>  REMOTE DESTINATION(SSOB SEARCH ARGUMENT)
        S=   Y/N      ==>  SEPERATOR PAGES REQUESTED(YES(Y) OR NO(N))
             LLL      ==>  LINES PER PAGE(VALID ONLY FOR SCS=N)
             MMMM     ==>  MAXIMUM LINES TO BE PRINTED PER JOB
             LUIDENT  ==>  VTAM SYMBOLIC NAME FOR THIS DEVICE
      SCS=   Y/N      ==>  SCS EQUIPTED SNA PRINTER(YES(Y) RO NO(N))
             MODEENT  ==>  MODEENT FROM LOGMODE TABLE IF NOT DEFAULT
             AA       ==>  LAST INDICATOR FROM RPLRTNCD FIELD
             BB       ==>  LAST INDICATOR FROM RPLFDBK2 FIELD
             QQQQQQQQ ==>  LAST INDICATOR FROM RPL SENSE FIELD

17            "MESSAGES ISSUED BY JRP300"                     PAGE 13

   JRPI300 JJJJJJJJ NNNNNNNN BEGINNING ON XXXX(LUIDENT)
             THIS MESSAGE IS ISSUED WHEN WHEN THE PRINTER SUBTASK
             HAS BEEN CREATED IS ABOUT TO ACQUIRE THE DEVICE FOR
             OUTPUT. WHERE:
             JJJJJJJJ ==>  NAME OF JOB ACTIVE ON THIS PRINTER
             NNNNNNNN ==>  NUMBER OF JOB ACTIVE ON THIS PRINTER
             XXXX     ==>  PRINTER NAME
             LUIDENT  ==>  VTAM SYMBOLIC DEVICE IDENTIFICATION

   JRPI301 XXXX(LUIDENT) OUTPUT TERMINATED BY WWWWWWW
             THIS MESSAGE IS ISSUED WHEN WHEN THE OUTPUT CURRENTLY
             ACTIVE ON PRINTER IS TERMINATED(DELETED FROM SPOOL)
             WHERE:
             XXXX     ==>  PRINTER NAME
             LUIDENT  ==>  VTAM SYMBOLIC DEVICE IDENTIFICATION
             WWWWWWW  ==>  HE WHO TAKES RESPONSIBILITY FOR TERMINATION

   JRPI302 XXXX(LUIDENT) OUTPUT RESTARTED BY WWWWWWW
             THIS MESSAGE IS ISSUED WHEN WHEN THE OUTPUT CURRENTLY
             ACTIVE ON PRINTER IS RESTARTED(STOPPED AND REQUEUED)
             WHERE:
             XXXX     ==>  PRINTER NAME
             LUIDENT  ==>  VTAM SYMBOLIC DEVICE IDENTIFICATION
             WWWWWWW  ==>  HE WHO TAKES RESPONSIBILITY FOR RESTART

   JRPI305 XXXX OUTPUT REQUEUED , RTNCD=RR ,FDBK2=FF SENSE=SSSS
             TWENTY CONSECUTIVE VTAM ERROR HAVE BEEN ENCOUNTERED
             ATTEMPTING TO OPEN OR WRITE TO THIS PRINTER.
             THE OUTPUT IS REQUEUED. CHECK CODES IN VTAM PROGRAMMERS GD.
             CORRECT PROBLEM IF REQUIRED.JRP $S MUST BE ISSUED TO MARK
             PRINTER WITH "RETRYLM" STATUS ELIGIBLE FOR PROCESSING.
             WHERE:
             XXXX     ==>  PRINTER NAME
             RR       ==>  VALUE FROM VTAM RPL RTNCD FIELD
             FF       ==>  VALUE FROM VTAM RPL FDBK2 FIELD
             SSSS     ==>  SENSE INFORMATION FROM VTAM RPL
             XX       ==> GENCB RETURN CODE
             *  JRP $SXXXXXXXX MUST BE ISSUED TO MARK PRINTER IN
                         "RETRYLM" STATUS ELIGIBLE FOR PROCESSING.

   JRPE300   NIB GENCB FAILED R15=XX
             NIB CONTROL BLOCK GENERATION FAILED REGISTER 15 CONTAINS
             RETURN CODE WHICH IS DOCUMENTED IN ACF VTAM PROGRAMMERS GD.
             WHERE:
             XX       ==> GENCB RETURN CODE
                      * USER ABEND CODE 4 ACOMPANIES THIS MESSAGE

   JRPE301   RPL GENCB FAILED R15=XX
             RPL CONTROL BLOCK GENERATION FAILED REGISTER 15 CONTAINS
             RETURN CODE WHICH IS DOCUMENTED IN ACF VTAM PROGRAMMERS GD.
             WHERE:
             XX       ==> GENCB RETURN CODE
                      * USER ABEND CODE 4 ACOMPANIES THIS MESSAGE

17            "JRP USER ABEND CODES"                          PAGE 14

  U200        JRP200 HAS RECOGNIZED A FAILURE BY JRP210
             CONSULT JRP MESSAGES FOR REASON.
  U220        JRP220 HAS FAILED IN DYNAMIC ALLOCATION
             CONSULT JRP SYSTEM PROGRAMMER.
  U300        JRP300 HAS FAILED FOR A DEVICE. THIS DEVICE WILL
             NOT BE USEABLE BY JRP UNTIL JRP RESTART.
17            "JRP MODULE FLOW"                               PAGE 15

 7                          --------
 7                         | JRP100 |
 7                          --------
 7                 _____________|______________
 7               |                              |
 7            --------                       --------
 7           | JRP120 |                     | JRP200 |
 7            --------                       --------
 7       ________|_______               _________|___________
 7      |                |             |         |           |
 7   --------        --------      --------   --------   --------
 7  | JRP122 |      | JRP121 |    | JRP210 | | JRP220 | | JRP300 |
 7   --------        --------      --------   --------   --------
 7      |                                                   |
 7  ---------                                            --------
 7 | JRP123  |                                          | JRP310 |
 7  ---------                                            --------
17 JRP MODULE DESCRIPTIONS                               PAGE 16

 7 JRP100           MAIN DRIVER MODULE

                    THIS MODULE FIRST READS THE JRP INITIALIZATION
                    CONTROL CARDS, GETMAINS A DYNAMIC REGION FOR THE
                    PRINTER TASK DEFINED BY THE CONTROL CARD, SETS
                    ALL PRINTER DEFAULTS, CALLS JRP110 TO VERIFY
                    CONTROL CARD PARAMETERS AND RESETS PRINTER DEFAULTS
                    AS DEFINED BY THE CONTROL CARDS. IT THEN BUILDS
                    AND OPENS VTAM PRINTER ACB. NEXT SUBTASKS JRP200
                    (JES2 PROCESSED OUTPUT INTERFACE) AND JRP120(JRP
                    CONTROL TERMINAL SUPERVISOR). AT THIS POINT JRP100
                    ISSUES THE 'JRP INITIALIZATION COMPLETE' MESSAGE AND
                    END THE SHUTDOWN WTOR. NOW THE ONLY FUNCTION OF
                    JRP100 IS TO WAIT AND SUPERVISE ORDERLY SHUTDOWN
                    ON REQUEST FROM MVS CONSOLE OPERATOR(REPLY TO
                    SHUTDOWN), AN OPERATOR OF JRP'S CONTROL TERMINAL,
                    OR IN CASE OF ANY PROBLEMS WITH THE JES2 PROCESSED
                    OUTPUT INTERFACE.

 7 JRP110           CONTROL CARD PARSE MODULE

                    THIS MODULE SIMPLY VERIFIES EACH CONTROL CARD
                    PARAMETER AND RESETS PRINTER DEFAULTS AS DEFINED
                    BY THE CONTROL CARD.

 7 JRP200           JES2 PROCESSED SYSOUT INTERFACE

                    THIS MODULE EVERY 10 SECONDS SETS PRINTER OUTPUT
                    REQUIREMENTS IN JES2 SSOB(SUB SYSTEM OPTION BLOCK),
                    CALLS JRP210 WHICH PRESENTS THE REQUEST FOR OUTPUT
                    TO JES2. IF JES2 PASSES CONFIRMATION THAT THE
                    OUTPUT CRITERIA SPECIFIED IN THE JRP PRINTER CONTOL
                    BLOCK HAS BEEN MET THEN JRP220(DYNAMIC ALLOCATE/
                    DEALLOCATE) IS CALLED. UPON SUCCESSFUL RETURN FROM
                    JRP220 A SUBTASK IS CREATED AS JRP300(PRINTER I/O).

 7 JRP210           JES2 PROCESSED SYSOUT SECONDARY INTERFACE

                    THIS MODULE PRESENTS THE SSOB CREATED BY JRP200
                    TO JES2 AND PASSES A RETURN CODE BASED ON THE
                    RESULTS OF THAT PRESENTATION BACK TO JRP200.

 7 JRP220           DYNAMIC ALLOCATE/DEALLOCATE MODULE

                    THIS MODULE DYNAMICALLY ALLOCATES OR DEALLOCATES
                    BASED ON A REQUEST FROM JRP200 A SPOOL DATA-SET
                    AND SETS THE DATA-SET DISPOSITION AS DIRECTED
                    BY THE JRP PRINTER CONTROL BLOCK.

17 JRP300           PRINTER I/O MODULE                    PAGE 17

                    THIS MODULE BUILDS AND INITIALIZES THE PRINTERS
                    VTAM CONTROL BLOCKS. OPENS THE SPOOL DATA-SET
                    PREVIOUSLY CONFIRMED BY JRP200 AND ALLOCATED BY
                    JRP220. BEGINS A SESSION WITH THE DESIGNATED
                    PRINTER, CALLS JRP310 TO NOTIFY JRP CONTROL TERMINAL
                    OPERATOR(WHO HAS REQUESTED UNSOLICITED OUTPUT) THAT
                    OUTPUT IS ABOUT TO BEGIN ON THIS PRINTER, QSAM READS
                    THE SPOOL DATA-SET UNTIL THE PRINTER BUFFER IS FULL,
                    THE SENDS THE DATA TO THE PRINTER VIA 3270 VTAM
                    PROTOCOL. UPON NEGATIVE RESPONSE FROM VTAM THE
                    PRINTER STATUS CONTROL BLOCK FIELDS ARE SET AS
                    FOLLOWS. STATUS='RETRYING',  RTNCD, FDBK2 AND
                    SENSE= LAST RPL FIELD SETTINGS, RETRY COUNTER IS
                    INCREMENTED. THE OPERATION IS RETRIED UNTIL THE
                    RETRY LIMIT OF 100(IN MOST CASES) HAS BEEN EXAUSTED.
                    THE READ AND WRITE PROCEDURE IS REPEATED UNTIL
                    1. END OF FILE  2. $C OR $E FROM JRP OPERATOR
                    3. NOTIFICATION OF CLOSEDOWN.
                    PRINTER IS FREED AND CONTROL IS RETURNED TO JRP200

 7 JRP310           JRP UNSOLICITED MESSAGE PROCESSOR.

                    THIS MODULE UPON REQUEST FROM JRP300 SEND PRINTER
                    STATUS  MESSAGES TO JRP TERMINAL OPERATORS WHO HAVE
                    REQUESTED UNSOLICITED OUTPUT.

 7 JRP120           JRP CONTROL TERMINAL DRIVER

                    THIS MODULE ACCEPTS LOGONS FROM 3270 TYPE TERMINALS
                    CALLS JRP122(LOGON VERIFICATION PROCESSOR) AND
                    ROUTES JRP COMMANDS FROM EACH CONTROL TERMINAL TO
                    JRP121 FOR PROCESSING.
                    COMMANDS "ICLOSE", "CLOSE", "LOGON", "LOGOFF" ARE
                    PROCESSED DIRECTLY BY JRP120 AND ARE NOT ROUTED TO
                    JRP121.

 7 JRP121           JRP CONTROL TERMINAL COMMAND PROCESSOR

                    THIS MODULE PARSES ALL COMMANDS ROUTED TO IT BY
                    JRP120 AND MODIFIES THE PRINTER CONTROL BLOCK AS
                    REQUESTED, FORMATS MAJOR PRINTER CONTROL BLOCK
                    FIELDS AND DISPLAYS TO JRP TERMINAL OPERATOR.


 7 JRP122           JRP LOGON VERIFICATION PROCESSOR

                    THIS MODULE REQUESTS LOGON USERID AND PASSWORD
                    VERIFYING THAT THE FIELDS HAVE BEEN FILLED IN,
                    CALLS JRP123(JRP SECURITY EXIT) THEN ACCEPTS THE
                    SESSION, REQUESTS ADDITIONAL INFORMATION OR REJECTS
                    THE SESSION BASED ON RETURN CODE FROM JRP123.

 7 JRP123           JRP USER SECURITY EXIT.

                    THIS MODULE IS A DUMMY MODULE TO BE CODED BY USER.
                    ACCORDING TO STANDARDS OUTLINED IN SOURCE CODE.
1
```

## $$DOC.txt
```
1











           JJJJJJJJJJJJJ      RRRRRRRRRRRRR            PPPPPPPPPPPP
          JJJJJJJJJJJJJ      RRRRRRRRRRRRRRR          PPPPPRPPPPPPPP
              JJJJJ         RRRRRR    RRRRRR         PPPPP    PPPPPP
             JJJJJ         RRRRRR     RRRRRR        PPPPP     PPPPPP
            JJJJJ         RRRRRRRRRRRRRRRR         PPPPPPPPPPPPPPP
           JJJJJES2      RRRRRRRRRRRRRRRR         PPPPPPPPPPPPPP
  JJJJJ   JJJJJ         RRRRR        REMOTE      PPPPP
  JJJJJ  JJJJJ         RRRRR         RRRR       PPPPPRINT
   JJJJJJJJJJ         RRRRR          RRRR      PPPPP
    JJJJJJJ          RRRRR           RRRRR    PPPPP
1 TABLE OF CONTENTS
    CONTENT                                 Page

    INTRODUCTION............................1
    "JRP" INSTALLATION......................2
    "JRP" STARTUP...........................3
    "JRP" SHUTDOWN..........................3
    "JRP" CONTROL TERMINALS.................4
    "JRP" COMMANDS..........................5
    "JRP" ATTRIBUTE SPECIFICATION...........7
    "JRP" PRINTER STATUS....................8
    "JRP" USE OF............................9
    "JRP" SNA FEATURES......................10
    "JRP" MESSAGES..........................11
    "JRP" USER ABEND CODES..................14
    "JRP" MODULE FLOW ......................15
    "JRP" MODULE DESCRIPTIONS...............16
    "JRP" IMPROVEMENTS......................18
    "JRP" NEW ATTRIBUTES....................19
1 Introducing JRP(JES2 remote printers)                       Page 1
0       This product was designed and written with the intent of
    increasing user as well as programmer productivity. It("JRP")
    makes use of 3270 printer devices to print spooled JES2 output.
    Output devices are defined to "JRP" via a sequential data set.
    Each control card in this data set describes the attributes
    of one printer.
       After "JRP" initialization,a subsystem request is issued to
    JES2 based on each printers description. If JES2 confirms that
    output is available for the printer described,a subtask is created,
    using the attributes defined for that particular device.
    The spool dataset is read, buffered, then written to the printer
    via "VTAM".

    ******* IMPORTANT NOTE *******
    JRP will print a maximum of 256 characters per record
    ******* IMPORTANT NOTE *******
1 Installation Page 2

    1.  Unload file 1 (one) to 80/3120 data pds:

        //STEP1   EXEC PGM=IEBCOPY
        //SYSUT1    DD DSN=JRPTP,UNIT=6250,LABEL=(1,NL),
        //             DISP=(OLD,KEEP),VOL=SER=JRP
        //SYSUT2    DD DSN="JRP.DATA",DISP=(,CATLG),VOL=SER="VOLSER",
        //          UNIT="DEVTYP",SPACE=(TRK,(20,2,5))
        //SYSPRINT  DD SYSOUT=A
        //SYSIN     DD *
          COPY INDD=SYSUT1,OUTDD=SYSUT2
        /*

    2. Tailor proc JRP from JRP.data lib for your apf authorized
         steplib or remove steplib and let linklist do it.

    3. Edit JRPINST member to specify your library names for
        syslib, syslmod... For JRPRINT be sure to specify a
        linklist library for accessibility from TSO.

    4. Submit JRPINST to batch for assembly and link.
        NOTE** reassemble JRP 200,210,220 for JES2 upgrade.

    5. Copy member JRPRINTH to SYS1.HELP changing name to JRPRINT

    6. Edit and format the "JRP" initialization data-set to
        define the remote printers in your environment:

         col 1-8    :    Printer name(1-8 characters)
         col 10-72  :    Printer attributes as described in section,
                         'attribute specification'. The operands
                         are specified with keywords, and may be
                         entered in any order.
                   *NOTE Control information for each printer
                    may be contained in continuation cards
                    including ,(comma) after last parameter
                    on card "x" in column 72 and continuation
                    must begin in column 10.

          ex.:
  col:    1        10                                                72
          RMT001   R=RMT001,SCS=N,LGMD=NSNAPRT,LU=LU0A0,S=N,         X
                   MLIN=0,F=A100,C=A,LPP=068,
          R002     R=RMT002,LGMD=SCSPRT,C=A,LU=SNA05B

      7. Add the VTAM node's for JRP and "JRP" control terminals
           as follows;

          JRPV     APPL   AUTH=ACQ
          CJRP     APPL   AUTH=PASS

         In January 2001 it was found that ACBNAME should not be used
         for cross domain printing.

1 JRP startup                                                 Page 3

    After all updates have been made to JRPDATA, JRP may be
    initiated from the operators console:

      ENTER:  S JRP
      RESP:   JRPI101 INITIALIZATION COMPLETE

  JRP shutdown

    To halt and requeue all current printing activity and
    terminate JRP from MVS operator console enter:

       ENTER:  P JRP
       RESP:   JRPI102 ICLOSE IN PROGRESS
               JRPI104 SHUTDOWN COMPLETE, ENDING



1 JRP control terminals                                     Page 4

        "JRP" supports VTAM SNA and nonSNA terminals as "JRP"
    control terminals. A maximum of 25(twenty five) terminals are
    support simultaneously. All functions required to support "JRPs"
    printer devices are available from a "JRP" control terminal.
    Use of these control terminals is described below although
    printer control commands are described in section "JRP commands"

     1. Logon to JRP control terminal(uss table logon is preferable).
        or  'logon applid(CJRPA)'
     2. Enter userid and password.(This is only meaningfull to "JRP"
        if JRP123 security exit is coded although at least on charecter
        in userid and password field is required.)
     3. After userid and password acceptance the command screen is
        displayed. LUid in upper left command line on lower left.
        "JRP" control terminal or printer commands may be entered now.
1 JRP commands                                                Page 5

   the following commands are are issued from a "JRP" control terminal


   PRISCN            Set terminal to 3278 mod2 screen size (default).

   ALTSCN            Set terminal to alternate screen size as defined
                     in bind.
                     ** Care must be taken to ensure terminal
                     will support the alternate screen size as defined.
                     INACT/ACT of LU will be required if incompatible
                     size requested.

   WRAP               Set terminal in auto wrap mode.    (default)

   NOWRAP            "JRP" will send one screen of requested informtion,
                     'MORE DATA....' will appear in lower left of
                     terminal then wait for further intervention from
                     "JRP" operator(enter). No "JRP" commands will be
                     accepted before the 'MORE DATA....' condition is
                     cleared.

   NOUNSOL           No "JRP" unsolicited information will be sent to
                     this terminal.           (default)

   UNSOL             "JRP" will send any unsolicited printer status
                     information to this terminal.
                  **NOTE: UNSOL and NOWRAP are mutually exclusive.
                     One must be reversed before the other is accepted.

   LOGON aaaaaaaa     This command will allow direct logon from "JRP"
                     control terminal to aaaaaaaa(any valid VTAM applid
                     as specified in label of VTAM appl defination).

   LOGOFF             Terminate this "JRP" control terminal session.

   CLOSE              Requests that "JRP" close after completing all
                     current print activity.(This may take a while and
                     all control terminal support is terminated at this
                     point). CLOSE and ICLOSE commands are irreversible
                 *NOTE: If JRP is canceled by MVS operator output
                        currently printing or retrying on a "JRP"
                        printer will be lost!!!!!!!

   ICLOSE             Requests that "JRP" reque current print activity
                     to JES2,  terminate all printer sessions and
                     complete normal close-down. This is the recommended
                     close procedure because it takes a relatively short
                     period of time to complete(normally up to 5 minutes
                     with 50 printers defined). All "JRP" control
                     terminal sessions are terminated after close or
                     ICLOSE commands are issued.
                     CLOSE and ICLOSE commands are irreversible.
                 *NOTE: If JRP is canceled by MVS operator, output
                        currently printing or retrying on a "JRP"
                        printer will be lost!!!!!!!

   CANCEL llllllll    This command will terminate a "JRP" control
                     terminal for specified VTAM LUid.
                     llllllll = VTAM LUid of "JRP" control terminal.

   RESET              This command will terminate all "JRP"
                     control terminal sessions, reset control terminal
                     acb and reallow logons to "JRP" control terminals.

1                                                            Page 6

  $Dxxxxxxxx         Display the status of printer xxxxxxxx

  $DU                Display the status of all printers

  $Sxxxxxxxx         Resume printer xxxxxxxx's eligibility to
                     receive output after a JRP $P command or error
                     condition has made it ineligible

  $SU                Resume all printers eligibility to receive
                     output after a JRP $PU command or error condition
                     have made them ineligible

  $Pxxxxxxxx         Remove eligibility of printer xxxxxxxx to receive
                     output after the current print activity has
                     completed on that device

  $PU                Remove eligiblity of all printers to receive
                     output after current activity on each device
                     has completed

  $Exxxxxxxx         Restart activity on printer xxxxxxxx

  $Cxxxxxxxx         Cancel the output on printer xxxx
                     The same * result may be obtained on an 'SCS'
                     equipped printer by pushing:
                        1. Hold print
                        2. Cancel print
                        3. Enable print
                            * The printer status code, 59, must be
                              displayed on the printer before cancel
                              will be accepted by JRP

  $Txxxxxxxx         Change the initial attributes for printer xxxxxxxx.
                     See 'attribute specification' for the list of
                     attributes that may be modified with the JRP
                     '$T' command.


1 Attribute Specification                                     Page 7

   Control Card Rules.
   1. Printer name(1-8 characters) must begin in column 1 and
     in column 1 card 1 of a continuation series(if continuation is
      used).

   2. Keyword parameters(to include continuation card if used) must
     begin in column 10.

   3. Continuation character must be in column 72 and a blank must
     precede continuation character if continuation is used.

   The following keywords are valid to define printer attributes
   in the JRPdata file for start-up or as modifies after
   initialization using the "JRP" $T command . *See "JRP commands"

      LPP=          Specify the number of Lines Per Page for
                    'SCS=N' printers only. The default is 68
                    lines per Page for 12 inch paper at 8 LPI
           default: LPP=68

      LU=           The VTAM logical unit name for the printer
                    having a maximum of 8 characters. The LU
                    name must be specified at initialization;
           default: None. *Required at initialization

       R=           Specifies the RJE destination id. If RJE
                    names are to be used, they must be specified at
                    initialization time.
           default: LOCAL.

       LGMD=        The logmode entry name applicable for this printer,
                    a maximum of eight characters may be used.
           default: VTAM default on VTAM LBUILD, or first in mode
                    table if not defined on printer LBUILD definition.
                  *NOTE; If LGMD is specified RELRQ exits will not
                         be invoked.

       MLIN=        The maximum number of lines to be printed on this
                    device for any one job or TSO spinnoff output.
                    When this limit is reached output will be
                    terminated and output will be purged from queue.
           default: 9999 lines

       SCS=         Set to 'Y' or 'N' to specify if a printer is
                    SCS or DSC equipped.
           default: SCS=Y

                    Note: If SCS equipped, printer must be a SNA device
                    and can not be a local device. If 'SCS=Y' is
                    specified, the logmode must also be for a SNA
                    printer. If 'SCS=N' is specified, the logmode
                    must be for a non-SNA device. SCS=N will work for
                    either SNA or non-SNA, but SNA features will
                    not be available (JRP cancel key and bracket
                    protocol). See JRP SNA features for more details.

       F=           Specify a four character form number. This
                    option is not required, and is not recommended.
           default: None.

       C=           Specify the output class destination. A maximum
                    of 8 one character output class search arguments
                    may be defined with no deliminating comma's.
           default: None.


1 Printer Status                                              Page 8


      The JRP '$Dxxxx' or the '$DU' command will display the printer
      status to the operator console. The meaning of each of these
      is as follows:

   ACTIVE       The printer is currently active; the jobname and
                jobnumber will also be displayed.

   INACTIVE     The printer is currently idle and is available to
                other VTAM applications.

   DRAINED      The printer is not eligible to receive work due to
                a previous JRP '$P' command.  The JRP '$S' command
                would restore eligiblity.

   DRAINING     The printer will be ineligible to receive work after
                the current activity has completed on the specified
                device.The JRP '$S' command would restore eligibility.

   RETRYING     This printer is in retry status. Attempts at contacting
                this device have been unsuccessful thus far, though
                it"s retry limit has not been reached.

   RETRYLM      The 'retry limit' has been met due to I/O errors on
                that device, and the device is now in an ineligible
                status.Issue the JRP '$S' command after correcting the
                hardware problem (power off, hold, cable connection,
                etc.) to restore the eligible status.

   ABENDtccc    This printer subtask at some point encountered
                a problem leading to an abend. This status is
                posted as such. JRP '$S' command must be issued for
                this printer to restore output eligibility.
       t   ==>  Abend type S(System) U(User)
       ccc ==>  Abend code(i.e. 0C4)


1 JRP Use of                                                  Page 9
   there are a number of ways to utilize JRP"s ability to interface
   with JES2. One is to specify output class and special form number,
   and use those as the specification on output DD statement.
          Below is the specification for JRPDATA and output DD.

       EX JRP;PRT1      LU=VTS05A,SCS=N,LGMD=DSILGMOD,F=PRT1,C=A
       EX DD  ;//SYSPRINT DD SYSOUT=(A,,PRT1)

   Another use, also the recommended use is via JES nonSNA RJE id"s.
   this technique leaves room for the greatest flexibility and
   effective utilization. Below is an example of JRP initialization
   control card and uses of RJE destination.

       EX JRP;  R001      LU=VTS05A,SCS=N,LGMD=DSILGMD,R=RMT001
       EX JCL; */ ROUTE RMT001  (ROUTES ALL JOB OUTPUT TO RMT001)
       EX DD ; //SYSPRINT DD SYSOUT=*,DEST=RMT001
       ex TSO;  alloc sysout(a) dest(rmt001) dd(sysprint)

   It is recommended, only to avoid confusion, that the printer name
   be chosen based on it"s Remote id(or form number if that is the
   method of use). For example if the form number is PRT1 then the
   printer name might be PRT1. If the destid is RMT001 then the
   printer name might be RMT001 or R001.

    ******* IMPORTANT NOTE *******
    JRP will print a maximum of 256 characters per record
    ******* IMPORTANT NOTE *******


1 JRP SNA features                                            Page 10


   1.  Bracket Protocol

       Bracket protocol will prevent the interleaving of
       unsolicited output, requested with the local print key,
       and JRP output.

   2. Cancel key

       a. Push hold print
               cancel print
               enable print

          If the printer code, 59, is not displayed when the
          cancel print key is pushed, complete sequence and retry.

   3.   Lines Per Page

        The number of print lines per Page may be controlled with
        the line count indicator on the printer.
1 JRP messages                                                Page 11



             "messages issued by JRP100"

   JRPI101 INITIALIZATION COMPLETE
             All initialization of subtask dynamic area's by data
             in initialization data-set has successfully completed
             and JRP200 subtask has been created.

   JRPI102 ICLOSE IN PROGRESS
             All subtasks are notified that "f JRP,ICLOSE" has
             been issued. Close will complete after all active print
             has been requeued and subtasks terminated.

   JRPI103 close in progress
             All subtasks are notified that "f JRP,close" has
             been issued. Close will complete after all active print
             has completed and subtasks terminated.

   JRPI104 SHUTDOWN COMPLETE, ENDING.
             "CLOSE" , "ICLOSE" or abend processing has completed and
             all subtasks have terminated. JRP is terminating.

   JRPE100 ACB NOT AVAILABLE.
             JRP"s ACB is in use, not active, or not defined
             abend u001 will follow.

   JRPE101 JRP200 ERROR ENCOUNTERED
             JRP200 and or JRP210 encountered some problem
             accessing JES2 based on subsystem control block defination.
1            "messages issued by JRP110-JRP121"              Page 12

   JRPI110 OK / INVALID
             This message is issued in response to any display
             command OK ==> command accepted as entered,
             INVALID ==> command in error(syntactically , misspelled ,
             or invalid printer name) Consult user guide and or
             JRP administrator for assistance.

   JRPI111 xxxx ssssssssss jjjjjjjj(nnnnnnnn) F=ffff,C=cccccccc,
   CONT'D      R=rrrrrrrr,S=Y/N,LPP=lll,MLIN=mmmm,LU=LUident ,SCS=Y/N,
   CONT'D      LGMD=modentT,RTCD=aa,FDB2=bb,SENSE=qqqqqqqq

             This status message is issued in response to any JRP
             command to display or change a printer status.
             xxxx     ==>  Printer name
             ssssssss ==>  Printer status
             jjjjjjjj ==>  Name of job active on this printer
             nnnnnnnn ==>  Number of job active on this printer
             ffff     ==>  Form number(SSOB search argument)
             cccccccc ==>  Output class number(SSOB search argument)
             rrrrrrrr ==>  Remote destination(SSOB search argument)
        s=   y/n      ==>  Seperator Pages requested(yes(Y) or no(N))
             lll      ==>  Lines per Page(valid only for SCS=Y)
             mmmm     ==>  Maximum lines to be printed per job
             LUident  ==>  VTAM symbolic name for this device
      SCS=   Y/N      ==>  SCS equiped SNA printer(yes(Y) or no(N))
             modeent  ==>  Modeent from logmode table if not default
             aa       ==>  Last indicator from RPLRTNCD field
             bb       ==>  Last indicator from RPLFDBK2 field
             qqqqqqqq ==>  Last indicator from RPL sense field

1             "Messages Issued by JRP300"                     Page 13

   JRPI300 jjjjjjjj nnnnnnnn BEGINNING ON xxxx(LUident)
             this message is issued when when the printer subtask
             has been created is about to acquire the device for
             output. where:
             jjjjjjjj ==>  Name of job active on this printer
             nnnnnnnn ==>  Number of job active on this printer
             xxxx     ==>  Printer name
             LUident  ==>  VTAM symbolic device identification

   JRPI301 xxxx(LUident) output terminated by wwwwwww
             this message is issued when when the output currently
             active on printer is terminated(deleted from spool)
             where:
             xxxx     ==>  printer name
             LUident  ==>  VTAM symbolic device identification
             wwwwwww  ==>  he who takes responsibility for termination

   JRPI302 xxxx(LUident) output restarted by wwwwwww
             this message is issued when when the output currently
             active on printer is restarted(stopped and requeued)
             where:
             xxxx     ==>  printer name
             LUident  ==>  VTAM symbolic device identification
             wwwwwww  ==>  he who takes responsibility for restart

   JRPI305 xxxx output requeued , rtncd=rr ,fdbk2=ff sense=ssss
             twenty consecutive VTAM error have been encountered
             attempting to open or write to this printer.
             the output is requeued. Check codes in VTAM programmers gd.
             correct problem if required.JRP $S must be issued to mark
             printer with "retrylm" status eligible for processing.
             where:
             xxxx     ==>  printer name
             rr       ==>  value from VTAM rpl rtncd field
             ff       ==>  value from VTAM rpl fdbk2 field
             ssss     ==>  sense information from VTAM rpl
             xx       ==> gencb return code
             *  JRP $Sxxxxxxxx must be issued to mark printer in
                         "retrylm" status eligible for processing.

   JRPe300   nib gencb failed r15=xx
             nib control block generation failed register 15 contains
             return code which is documented in acf VTAM programmers gd.
             where:
             xx       ==> gencb return code
                      * user abend code 4 acompanies this message

   JRPE301   RPL GENCB FAILED R15=XX
             rpl control block generation failed register 15 contains
             return code which is documented in acf VTAM programmers gd.
             where:
             xx       ==> gencb return code
                      * user abend code 4 acompanies this message

1             "JRP User ABEND Codes"                          Page 14

  U200        JRP200 has recognized a failure by JRP210
             consult JRP messages for reason.
  U220        JRP220 has failed in dynamic allocation
             consult JRP system programmer.
  U300        JRP300 has failed for a device. This device will
             not be useable by JRP until JRP restart.
1             "JRP Module Flow"                               Page 15

                            --------
                           | JRP100 |
                            --------
                   _____________|______________
                 |                              |
              --------                       --------
             | JRP120 |                     | JRP200 |
              --------                       --------
         ________|_______               _________|___________
        |                |             |         |           |
     --------        --------      --------   --------   --------
    | JRP122 |      | JRP121 |    | JRP210 | | JRP220 | | JRP300 |
     --------        --------      --------   --------   --------
        |                                                   |
    ---------                                            --------
   | JRP123  |                                          | JRP310 |
    ---------                                            --------
1  JRP Module Descriptions                               Page 16

   JRP100           Main driver module

                    This module first reads the JRP initialization
                    control cards, getmains a dynamic region for the
                    printer task defined by the control card, sets
                    all printer defaults, calls JRP110 to verify
                    control card parameters and resets printer defaults
                    as defined by the control cards. It then builds
                    and opens VTAM printer ACB. Next subtasks JRP200
                    (JES2 processed output interface) and JRP120(JRP
                    control terminal supervisor). At this point JRP100
                    issues the 'JRP initialization complete' message.
                    Now the only function of JRP100 is to
                    wait and supervise orderly shutdown
                    on request from MVS console operator(P JRP)
                    an operator of JRP's control terminal,
                    or in case of any problems with the JES2 processed
                    output interface.

   JRP110           Control card parse module

                    This module simply verifies each control card
                    parameter and resets printer defaults as defined
                    by the control card.

   JRP200           JES2 processed sysout interface

                    This module every 10 seconds sets printer output
                    requirements in JES2 SSOB(sub system option block),
                    calls JRP210 which presents the request for output
                    to JES2. If JES2 passes confirmation that the
                    output criteria specified in the JRP printer contol
                    block has been met then JRP220(dynamic allocate/
                    deallocate) is called. Upon successful return from
                    JRP220 a subtask is created as JRP300(printer i/o).

   JRP210           JES2 processed sysout secondary interface

                    This module presents the SSOB created by JRP200
                    to JES2 and passes a return code based on the
                    results of that presentation back to JRP200.

   JRP220           Dynamic allocate/deallocate module

                    This module dynamically allocates or deallocates
                    based on a request from JRP200 a spool data-set
                    and sets the data-set disposition as directed
                    by the JRP printer control block.

1  JRP300           Printer I/O module                    Page 17

                    This module builds and initializes the printers
                    VTAM control blocks. Opens the spool data-set
                    previously confirmed by JRP200 and allocated by
                    JRP220. Begins a session with the designated
                    printer, calls JRP310 to notify JRP control terminal
                    operator(who has requested unsolicited output) that
                    output is about to begin on this printer, QSAM reads
                    the spool data-set until the printer buffer is full,
                    the sends the data to the printer via 3270 VTAM
                    protocol. Upon negative response from VTAM the
                    printer status control block fields are set as
                    follows. Status='retrying',  rtncd, fdbk2 and
                    sense= last RPL field settings, retry counter is
                    incremented. The operation is retried until the
                    retry limit of 100(in most cases) has been exausted.
                    The read and write procedure is repeated until
                    1. End of file  2. $C or $E from JRP operator
                    3. Notification of closedown.
                    Printer is freed and control is returned to JRP200

   JRP310           JRP unsolicited message processor.

                    This module upon request from JRP300 send printer
                    status  messages to JRP terminal operators who have
                    requested unsolicited output.

   JRP120           JRP control terminal driver

                    This module accepts logons from 3270 type terminals
                    calls JRP122(logon verification processor) and
                    routes JRP commands from each control terminal to
                    JRP121 for processing.
                    Commands "ICLOSE", "CLOSE", "LOGON", "LOGOFF" are
                    processed directly by JRP120 and are not routed to
                    JRP121.

   JRP121           JRP control terminal command processor

                    This module parses all commands routed to it by
                    JRP120 and modifies the printer control block as
                    requested, formats major printer control block
                    fields and displays to JRP terminal operator.


   JRP122           JRP logon verification processor

                    This module requests logon userid and password
                    verifying that the fields have been filled in,
                    calls JRP123(JRP security exit) then accepts the
                    session, requests additional information or rejects
                    the session based on return code from JRP123.

   JRP123           JRP user security exit.

                    This module is a dummy module to be coded by user.
                    according to standards outlined in source code.
1 Improvements to JES2 remote printers (JRP)                  Page 18
0   This product was enhanced in 1993 by Ronald Tansky of Webcraft Inc..
    In 1999 it was further improved by David Cartwright of AGCO Ltd.  at
    Desford in Leicestershire, England.
    In each case the original source member was given a suffix of "OL".
0   The main thrust of the AGCO improvements was to allow printer
    formatting statements to be sent at the start and end of each
    print file.  This allows IDATA protocol converters to be
    programmed to print listings in Landscape mode on A4 paper.
    Although some changes were made in the original source members
    (flagged *DHC* at the end of the statement) the bulk of the
    additional code is included via COPY statements.  The members to
    be included are prefixed "DHC".  Macros from file 172 of the CBT
    tape are required to assemble "JRP" with these mods.
    AGCO were running OS/390 2.6 in 1999.
- STOP/MODIFY processing
0  AGCO eliminated the WTOR which was used to terminate JRP. Instead
   the Operator may issue a normal MVS stoP command;   P  JRP
   This will trigger ICLOSE processing.  ICLOSE may still be issued
   from a JRP Control Terminal.
- JRPHEAD DD Statement
0  The AGCO modifications require an additional DDcard in the JRP proc.
   The JRPHEAD DDcard defines a pds which holds the header and trailer
   members as specified in JRPDATA initialisation statements. The
   records must be variable length and the first character must be a
   Machine print control character (VBM format).
   If the first character is an asterisk ("*") instead of a valid
   Machine control character then the record is ignored. This allows
   comments to document the contents of each member.
0  AGCO further enhanced the program in January 2001 to use Cross Domain
   printers. The updates turned out to be unnecessary, the problem was
   solved by simply using the resource name, not ACBNAME.
1 New Attributes                                              Page 19
0  The following keywords are valid to define printer attributes
   in the JRPDATA file for start-up or as modifies after
   initialization using the "JRP" $T command . *See "JRP commands"
0     *             Statements in JRPDATA beginning with an
                    asterisk ("*") are ignored.  This allows comments
                    to be used to document the contents of JRPDATA.
           default: None
0     NETID=        Specifies the Network Name for a cross-domain printer
      N=            Normal VTAM searching should find the cevice, but
                    this keyword is provided for special cases.
           default: None
0     HEAD=         Specifies the name of a member of the pds allocated
      H=            to the DDname JRPHEAD which is to be output at the
                    start of a print dataset. JRPHEAD must be VBM format
                    If this parameter is blank or "NONE", no extra data
                    is sent to the printer.
           default: None
0     TAIL=         Specifies the name of a member of the pds allocated
      T=            to the DDname JRPHEAD which is to be output at the
                    end of a print dataset. JRPHEAD must be VBM format
                    If this parameter is blank or "NONE", no extra data
                    is sent to the printer.
           default: None
0     TRAN=         If this is specified as "N" then no translation of
                    output is performed.  This allows non-printable
                    control characters to be output, but it is the
                    responsibility of the User to ensure that no control
                    data is sent that will corrupt VTAM or the printer.
                    In future it is hoped to use the code added to
                    JRP300 to allow members of a pds to be loaded as
                    translation tables if desired.
           default: None
```

