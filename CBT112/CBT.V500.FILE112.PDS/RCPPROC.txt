         MACRO
         RCPPROC &WKCSECT=,&WKDSECT=,                                  X
               &REG1=,&REG0=,&ISA=,&SAVEPRE=,                          X
               &SAVESUF=,&SP=
         GBLA  &RCPSWS(10)
         GBLC  &RCPPRE,&RCPWKCS,&RCPWKDS
         GBLC  &RCPSPN
         LCLC  &P,&C
         RCPDEBUG
&P       SETC  '&RCPPRE'
         AIF   ('&WKCSECT' EQ '').TDS
         SPACE
         MNOTE 4,'WKCSECT= OPTION INVALID WITH PROC OPTION, '
         MNOTE *,'    WKDSECT=  USED INSTEAD'
&RCPWKDS SETC  '&WKCSECT'
         AGO   .SETCS
.TDS     AIF   ('&WKDSECT' EQ '').SYSECT
&RCPWKDS SETC  '&WKDSECT'
         AGO   .SETCS
.SYSECT  ANOP
&RCPWKDS SETC  '&SYSECT'
.SET1    AIF   (K'&RCPWKDS LT 8).LOK
&RCPWKDS SETC  '&RCPWKDS'(1,4)'&RCPWKDS'(6,3)'1'
         AGO   .SETCS
.LOK     ANOP
&RCPWKDS SETC  '&RCPWKDS.1'
.SETCS   ANOP
&RCPWKCS SETC  ''
&RCPSWS(4) SETA &RCPSWS(2)-1 SET W/A TO BE FREED OPT IF PROC(MAIN)
         AIF   ('&ISA' EQ '').NISA
&RCPSWS(3) SETA 1                      SET LIFO FLAG IF ISA SPEC
.NISA    ANOP
         SPACE 2
         RCPDS
         DS    9D                      SAVE AREA
&P.RCODE DS    F                       RETURN CODE
         RCPMCA
         RCPDS
         SPACE 2
         AIF   ('&REG1' EQ '').TR0
         LR    &REG1,R1                SAVE CONTENTS OF REG 1
.TR0     AIF   ('&REG0' EQ '').TP
         LR    &REG0,R0                SAVE CONTENTS OF REG 0
.TP      AIF   (&RCPSWS(2) EQ 2).PROCMN   PROCMAIN OPTION
         AIF   (&RCPSWS(3) EQ 1).PL    LIFO OPTION
         L     R15,0(R13)              R15 -> MODULE COMMUNIC. AREA
         L     R15,&P.XDS-&P.MCA(R15)  LOAD EXTERNAL DUMMY SECT ADDR
         AL    R15,&P.QCON             GET OFFSET TO WORK AREA
         ST    R15,8(R13)              CHAIN SAVE
         ST    R13,4(R15)               AREAS TOGETHER
         MVC   0(4,R15),0(R13)         COPY POINTER TO COMM AREA
         LR    R13,R15                 LOAD WORK AREA ADDRESS
         USING &RCPWKDS,R13              ESTABLISH ADDRESSABLITY TO IT
         MEXIT
.PL      ANOP
***********************************************************************
*        GET WORKAREA FROM LIFO STACK                                 *
***********************************************************************
         #GET  LV=&P.WKLEN
         ST    R1,8(R13)               CHAIN SAVE
         ST    R13,4(R1)                AREAS TOGETHER
         MVC   0(4,R1),0(R13)          PROPAGATE MODULE COMM. AREA ADDR
         LR    R13,R1                  LOAD WORK AREA ADDRESS
         USING &RCPWKDS,R13             ESTABLISH ADDRESSABILITY TO IT
         MEXIT
.PROCMN  L     R0,&P.CXD               LOAD WORK AREA LENGTH
         AIF   ('&SYSPARM' EQ 'MVT').MVT
 MNOTE *,'      GETMAIN RU,LV=(0),SP=&SP,BNDRY=PAGE'
         GETMAIN RU,LV=(0),SP=&SP,BNDRY=PAGE
         AGO   .CONT
.MVT     AIF   ('&SP' EQ '').NOSP
         ICM   R0,8,=AL1(&SP)          INSERT SUBPOOL NUMBER
.NOSP    ANOP
*        GETMAIN R,LV=(0)              OBTAIN A WORK AREA
.CONT    ANOP
&RCPSPN  SETC  '&SP'
         LR    R15,R13                 SAVE CALLER'S SAVE AREA ADDR
         LR    R13,R1                  LOAD EXT DUMMY SECTION ADDR
         AL    R13,&P.QCON              ADD OFFSET TO WORK AREA
         ST    R13,8(R15)              CHAIN SAVE
         ST    R15,4(R13)               AREAS TOGETHER
         USING &RCPWKDS,R13            GET WORKAREA ADDRESSABILITY
         ST    R1,&P.XDS               STORE DUMMY SECTION ADDR IN     X
                                         MODULE COMMUNICATIONS AREA
         LA    R15,&P.MCA              STORE COMMUNICATIONS AREA ADDR
         ST    R15,0(R13)               IN WORD 1 OF SAVE AREA
         AIF   (&RCPSWS(3) EQ 0 AND '&ISA' EQ '').EXIT
&RCPSWS(3) SETA 1                      SET LIFO IN CASE ONLY ISA SPEC
&C       SETC  '&ISA'
         AIF   ('&ISA' NE '').TK
&C       SETC  '8192'
         AGO   .NK
.TK      AIF   ('&C'(K'&C,1) NE 'K').NK
&C       SETC  '&C'(1,K'&C-1)'*1024'
.NK      EJECT
***********************************************************************
**       INITIALIZE MODULE COMMUNICATIONS AREA WITH POINTERS         **
**       TO LIFO STACK AND LIFO GET/FREE ROUTINES                    **
***********************************************************************
         SPACE 1
         MVC   &P.A#GET,=V(#####GET)   MOVE LIFO GET AND FREE
         MVC   &P.A#FRE,=V(####FREE)    ROUTINE ADDRESSES TO MCA
         L     R15,=Q(#####ISA)        COMPUTE LIFO STACK
         AL    R15,&P.XDS               PSEUDO REGISTER OFFSET
         ST    R15,&P.#S                 AND INITIALIZE POINTERS
         ST    R15,&P.#N                  IN MODULE COMMUNICATIONS AREA
         L     R14,=A(&C)              LOAD SIZE OF INITIAL STACK AREA
         ST    R14,&P.#L               STORE THIS IN MCA
         ALR   R15,R14                  THEN COMPUTE STACK END ADDRESS
         ST    R15,&P.#E                 AND STORE THIS INTO MCA
         EJECT
***********************************************************************
**       LIFO STACK GET/FREE ROUTINES                                **
***********************************************************************
         SPACE 1
#####ISA DXD   CL(&C)                  DEFINE PSEUDO REGISTER FOR ISA
         SPACE 1
#####GET CSECT                         LIFO GET ROUTINE
         USING *,R15
         USING &P.MCA,R1
         A     R0,&P.F7                ROUND LENGTH UP TO
         N     R0,&P.F8                 A MULTIPLE OF 8
         AL    R0,&P.#N                COMPUTE NEXT FREE LIFO SLOT ADDR
         CL    R0,&P.#E                COMPARE TO STACK END ADDRESS
         BH    &P.GA                    AND IF TOO BIG, BRANCH
         LR    R15,R1                  PRESERVE MCA ADDRESS
         USING &P.MCA,R15              NEW BASE
         L     R1,&P.#N                LOAD ADDRESS OF SLOT
         ST    R0,&P.#N                 AND STORE ADDRESS OF NEXT SLOT
         BR    R14                     RETURN TO CALLER
         SPACE 1
&P.GA    EQU   *                       IF CURRENT SLOT TOO SMALL
*        ABEND 1000,DUMP                ABEND FOR NOW
         ABEND 1000,DUMP
         SPACE 2
####FREE DS    0H                      LIFO FREE ROUTINE
         ENTRY ####FREE
         USING *,R15                   BASE ADDRESS
         USING &P.MCA,R1               MCA ADDRESS
         CL    R0,&P.#S                CHECK THAT
         BL    &P.FA                    ADDRESS TO BE
         CL    R0,&P.#E                  FREED IS WITHIN
         BH    &P.FA                      BOUND OF CURRENT STACK
         AL    R0,&P.F7                GET UPPER DOUBLE
         N     R0,&P.F8                 WORD BOUNDARY
         ST    R0,&P.#N                  AND UPDATE MCA
         BR    R14                     RETURN TO CALLER
         SPACE 1
&P.FA    EQU   *                       IF ADDRESS NOT WITHIN THIS STACK
*        ABEND 1001,DUMP               ABEND
         ABEND 1001,DUMP
         SPACE 2
&P.F7    DC    F'7'                    CONSTANTS
&P.F8    DC    F'-8'                    TO ROUND UP TO DOUBLEWORD SIZE
         DROP  R1,R15                  KILL ADDRESSABILITY
&SYSECT  CSECT                         RESUME MAIN PROGRAM CSECT
.EXIT    MEND
