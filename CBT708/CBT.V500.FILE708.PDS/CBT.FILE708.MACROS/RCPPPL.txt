         MACRO
&NAME    RCPPPL &PCL=,&NOPARM=,&PARSERR=,&PDLREG=R11,                  X
               &PDLNAME=,&PARSEP=,&PARSWKA=
         GBLB  &RCPPPL(2),&RCPECT(2)
         GBLC  &RCPPRE,&RCPPREP
         LCLC  &P
&P       SETC  '&RCPPRE'
         AIF   (&RCPPPL(2)).BPPL
         EJECT
         IKJPPL
L#PPL    EQU   *-PPL                   LENGTH OF PPL
&SYSECT  CSECT
         SPACE 1
&RCPPPL(2) SETB 1
.BPPL    RCPDS
&P.PPL   DS    CL(L#PPL)               RESERVE SPACE FOR PPL
&P.PDLP  DS    F                       POINTER TO PDL
         RCPDS
         SPACE 6
***********************************************************************
***   THIS CODE GENERATES A PARSE PARAMETER LIST                    ***
***********************************************************************
         XC    &P.PDLP,&P.PDLP         ZERO PDL POINTER
         AIF   ('&NOPARM(1)' EQ '' OR '&NOPARM(2)' NE '').PB2
         L     R1,CPPLECT              LOAD ECT ADDRESS
&RCPECT(1) SETB 1
         USING ECT,R1                  ECT ADDRESSABLE
         TM    ECTSWS,ECTNOPD          WERE ANY OPERANDS SUPPLIED?
         BO    &NOPARM(1)              NO, BRANCH OUT
         SPACE
.PB2     LA    R1,&P.PPL               LOAD PPL ADDRESS
         USING PPL,R1
         MVC   PPLUPT,CPPLUPT          MOVE IN UPT ADDRESS
         MVC   PPLECT,CPPLECT          MOVE IN ECT ADDRESS
         MVC   PPLCBUF,CPPLCBUF        MOVE IN CBUF ADDRESS
         LA    R15,&P.ECB              LOAD ATTN ECB ADDRESS
         ST    R15,PPLECB              AND STORE IN PPL
         LA    R15,&P.PDLP             LOAD PDL POINTER ADDRESS
         ST    R15,PPLANS               AND STORE IN PPL
         AIF   ('&PARSWKA' EQ '').PB3
         AIF   ('&PARSWKA'(1,1) EQ '').PB4
         LA    R15,&PARSWKA            LOAD ADDRESS OF WORK AREA
         ST    R15,PPLUWA               AND STORE IN PPL
         AGO   .PB3
.PB4     ST    &PARSWKA(1),PPLUWA      STORE ADDRESS OF WORKAREA
.PB3     AIF   ('&PCL' EQ '').EXIT
         L     R15,=V(&PCL)            LOAD PCL ADDRESS
         ST    R15,PPLPCL              AND STORE IN PPL
         SPACE 2
         AIF   ('&NOPARM(1)' EQ '' OR '&NOPARM(2)' EQ '').PB5
         L     R1,CPPLECT              LOAD ECT ADDRESS
&RCPECT(1) SETB 1
         USING ECT,R1
         TM    ECTSWS,ECTNOPD          WERE ANY OPERANDS SUPPLIED?
         BO    &NOPARM(1)               NO, BRANCH OUT
         SPACE
.PB5     AIF   ('&SYSPARM' EQ 'MVT').MVTBYP
         AIF   ('&RCPPREP' EQ '').NOPREP
         L     R15,&RCPPREP            LOAD EP OF IKJPARS
         BALR  R14,R15                  AND ENTER IT
         AGO   .PRET
.NOPREP  ANOP
         L     R15,16                  LOAD CVT ADDRESS
         TM    524(R15),X'80'          IS IKJPARS LOADED?
         AIF   ('&PARSEP' EQ '').PBL1
         BZ    &P.LOAD                  NO, BRANCH TO LOAD SVC
         L     R15,524(15)             LOAD EP OF IKJPARS
         ST    R15,&PARSEP             SAVE ITS ADDRESS
         BALR  R14,R15                 THEN BALR TO IT
         B     &P.PLNKB                BYPASS LOAD SVC
&P.LOAD  LOAD  EP=IKJPARS
         LR    R15,R0                  LOAD EP OF IKJPARS
         ST    R15,&PARSEP             SAVE IT
         BALR  R14,R15                 THEN BALR TO IT
&P.PLNKB DS    0H
         AGO   .PRET
.PBL1    BZ    &P.PLINK                 NO, BRANCH TO LINK SVC
         L     R15,524(R15)            ELSE LOAD ITS ADDRESS
         BALR  R14,R15                  AND BALR TO IT
         B     &P.PLNKB                BYPASS LINK SVC
.MVTBYP  ANOP
&P.PLINK LINK  EP=IKJPARS
&P.PLNKB DS    0H
.PRET    AIF   ('&PARSERR' EQ '').EXIT
         SPACE
         LTR   R15,R15                 TEST RETURN CODE
         BNZ   &PARSERR                 AND BRANCH ON NON-ZERO
         SPACE
         AIF   ('&PDLREG' EQ '' OR '&PDLNAME' EQ '').EXIT
         L     &PDLREG,&P.PDLP         LOAD PDL ADDRESS
         USING &PDLNAME,&PDLREG        PDL DSECT ADDRESSABLE
.EXIT    MEND
