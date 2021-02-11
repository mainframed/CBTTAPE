         MACRO
&NAME    FREE  &UNALC,&DSN=,&DDN=,&MEMBER=,&DISP=,&SYSOUT=,            X
               &ERROR=,&MF=AUTO,&PREFIX=,&FILE=,&F=,&DA=,&HOLD=
         GBLA  &RCPDYN            COUNTER FOR NO ENTRIES TO MACRO
         GBLA  &DTUO              OFFSET TO TEXT UNITS
         GBLA  &DTUPO             OFFSET TO TEXT UNIT POINTERS
         GBLB  &RCPS99(2)         TELL RCPDSECT NEED DSECTS
         GBLC  &DYNP              PREFIX FOR LABELS FOR THIS CALL
         GBLC  &DYNSP         NAME FOR AUTOMATIC STORAGE ALLOC
         LCLB  &DSECT             DSECT NEEDED FOR STORAGE, MF=E
         LCLC  &C,&T,&PAR
&RCPS99(1)     SETB           1
&RCPDYN  SETA  &RCPDYN+1          INCEREMENT COUNTER
&DYNP    SETC  'DYN&RCPDYN' SET DEFAULT PREFIX
&NAME    DS    0H
         AIF   ('&PREFIX' EQ '').TMF
         AIF   (K'&PREFIX LT 4).POK
         MNOTE 4,'PREFIX TOO LONG, 1ST 4 CHARS USED'
&DYNP    SETC  '&PREFIX'(1,4)
         AGO   .TMF
.POK     ANOP
&DYNP    SETC  '&PREFIX'
.TMF     AIF   ('&MF(1)' EQ 'G').GEN
         AIF   ('&MF' NE 'AUTO').TMFE
NAME     DYNSPACE             GET NAME FOR SPACE
         LA    R1,&DYNSP               LOAD ADDRESS OF PARAM LIST
         USING &DYNP.DS,R1             USE GENERATED DSECT
&T       SETC  'A'
&PAR     SETC  '&DYNSP+4'
&DSECT   SETB  1
         AGO   .START
.TMFE    AIF   ('&MF(2)' NE '').E2OK
         MNOTE 4,'PLIST ADDRESS OMITTED, MF=G USED'
         AGO   .GEN
.E2OK    ANOP
&DSECT   SETB  1
         AIF   ('&MF(2)' EQ '(').RMFE
         LA    R1,&MF(2)               LOAD PARAM LIST ADDRESS
&T       SETC  'A'
&PAR     SETC  '&MF(2)+4'
         USING &DYNP.DS,R1             USE GENERATED DSECT
         AGO   .START
.RMFE    AIF   ('&MF(2)' EQ '(R1)' OR '&MF(2)' EQ '(1)').START
&PAR     SETC  '&MF(2)'(2,K'&MF(2)-2)
&T       SETC  'R'
         LR    R1,&PAR                 LOAD S99 PARAM LIST ADDRESS
&PAR     SETC  '4&MF(2)'
         USING &DYNP.DS,R1             USE GENERATED DSECT
         AGO   .START
.GEN     LA    R1,&DYNP.RBP            LOAD ADDRESS OF S99 RBP
&T       SETC  'A'
&PAR     SETC  '&DYNP.RB'
.START   LA    R15,&DYNP.RB            LOAD ADDRESS OF S99 RB
         USING S99RB,R15
         ST    R15,0(R1)               AND STORE IN RB POINTER
         XC    4(&DYNP.LEN-4,R1),4(R1) ZERO PARAMETER LIST
         MVI   S99RBLN,20              MOVE IN LIST LENGTH
         MVI   S99VERB,S99VRBUN        MOVE IN VERB CODE
         LA    R14,&DYNP.TUP           LOAD ADDRESS OF TU POINTERS
         ST    R14,S99TXTPP            STORE ADDRESS IN S99 RB
         LA    R15,&DYNP.TU            POINT TO SPACE FOR TEXT UNITS
         USING S99TUNIT,R15
&DTUO    SETA  0
&DTUPO   SETA  0
         AIF   ('&DSN&DA' NE '').DSN
         AIF   ('&SYSOUT' NE '').SYSOUT
.TDDN    AIF   ('&DDN&FILE&F' NE '').DDN
.TDISP   AIF   ('&DISP' NE '').DISP
.TUNALC  AIF   ('&UNALC' NE '').PERM
.THOLD   AIF   ('&HOLD' NE '').HOLD
         AGO   .SVC99
.DSN     RCPFDSN &DSN&DA,&MEMBER
         AGO   .TDDN
.SYSOUT  RCPFSYS &SYSOUT
         AGO   .TDDN
.DDN     RCPFDDN &DDN&F&FILE
         AGO   .TDISP
.DISP RCPFDISP &DISP
         AGO   .TUNALC
.PERM    RCPUNALC
         AGO   .THOLD
.HOLD    RCPFHOLD &HOLD
.SVC99   ANOP
&DTUPO   SETA  &DTUPO-4
         SPACE
         MVI   &DYNP.TUP+&DTUPO,X'80'  SET HIGH ORDER BIT ON TEXT PTRS
         MVI   &DYNP.RBP,X'80'         SET HIGH ORDER BIT ON RB PTR
         RCPSR2 UNSAVE
&DTUPO   SETA  &DTUPO+4
         AIF   (NOT &DSECT).DYNA
         DROP  R1,R15                  DEACTIVATE ADDRESSABILITY
.DYNA    DYNALLOC
         AIF   ('&ERROR' EQ '').RESERVE
         AIF   ('&PAR' EQ '').LTR
         L&T   R14,&PAR                 LOAD REG 14 WITH ADDRESS OF RB
         AIF   (NOT &DSECT).LTR
         USING &DYNP.RB,R14            SET UP ADDRESSABILITY
.LTR     LTR   R15,R15                 TEST RETURN CODE
         BNZ   &ERROR                  BRANCH IF NON ZERO
**       NOTE.  R14 POINTS TO REQUEST BLOCK, R15 HAS RETURN CODE     **
.RESERVE AIF   (&DSECT).RESDS
         SPACE
***********************************************************************
**       RESERVE SPACE FOR DYNALLOC DATA                             **
***********************************************************************
         RCPDS
.SSP     ANOP
&DYNP.RBP DS   F                       SVC 99 REQ BLOCK POINTER
&DYNP.RB  DS   5F                      SVC 99 REQUEST BLOCK
&DYNP.TUP DS   CL&DTUPO                SPACE FOR TEXT POINTERS
         AIF   (&DTUO EQ 0).DTU11
&DYNP.TU  DS   CL&DTUO                 SPACE FOR TEXT UNITS
         AGO   .DTU10
.DTU11   ANOP
&DYNP.TU  DS   0C                      NO SPACE NEEDED FOR TEXT UNITS
.DTU10   ANOP
&DYNP.LEN EQU  *-&DYNP.RBP             LENGTH OF SPACE USED
         AIF   (&DSECT).DSP
         RCPDS
         SPACE 3
         AGO   .EXIT
.RESDS   ANOP
         AIF   ('&DYNSP' EQ '').SP3
         DYNSPACE ADD
.SP3     SPACE
&DYNP.DS DSECT                         DSECT TO MAP SVC 99 DATA
         AGO   .SSP
.DSP     AIF   ('&MF(3)' EQ '').END1
&MF(3)   EQU   &DYNP.LEN               LENGTH OF AREA
.END1    ANOP
&SYSECT  CSECT
         SPACE 3
.EXIT    MEND
