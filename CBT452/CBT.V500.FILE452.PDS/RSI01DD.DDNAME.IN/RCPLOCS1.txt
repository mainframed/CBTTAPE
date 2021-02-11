*23456789*12345*78921234567893123456789*
         MACRO
         RCPLOCSW &SW
.********************************************************************
.*                                                                  *
.*       INNER MACRO USED BY GOIF, SET, RESET AND FLIP.             *
.*       THE PARM PASSED IS THE SWITCH OR LIST OF SWITCHES.         *
.*       RCPLOCSW SCANS THE ARRAYS SET UP BY DCLSW TO SEE IF THE    *
.*       SWITCH BIT NAMES WERE DECLARED, AND IF A LIST WAS PASSED,  *
.*       WHETHER ALL THE SWITCH BITS BELONG TO THE SAME BYTE.       *
.*       RCPLOCSW PASSES BACH THE SWITCH BYTE NAME IN GLOBAL SETC   *
.*       VARIABLE &RCPDSW1 AND THE SWITCH BIT NAME IN GLOBAL SETC   *
.*       &RCPDSW2. IF A LIST OF SWITCHES WAS PASSED, &RCPDSW2       *
.*       CONTAINS THE SWITCH NAMES SEPARATED BY PLUS SIGNS.         *
.*       IF THE FIRST OR ONLY SWITCH WAS NOT FOUND, &RCPDSW1 IS SET *
.*       TO NULL. IF A LIST OF SWITCHES IS PASSED AND ANY SWITCH IS *
.*       NOT DECLARED IN THE SAME SWITCH BYTE AS THE FIRST, AN MNOTE*
.*       IS ISSUED WARNING OF POSSIBLE ERROR, BUT &RCPDSW1 IS SET   *
.*       TO THE NAME OF THE SWITCH BYTE CONTAINING THE FIRST SWITCH *
.*       BIT IN THE LIST.                                           *
.*                                                                  *
.********************************************************************
         GBLA  &RCPDSW#,&RCPGSW#       COUNTER FOR DECLARED SWITCHES
         GBLA  &RCPDSW0                NO OF SWS FOUND BY RCPLOCSW
         GBLB  &RCPDSWD(99)            DEFER DECLARE INDICATORS
         GBLC  &RCPDSWN(99)            SWITCH BYTE NAMES
         GBLC  &RCPDSWB(800)           SWITCH BIT NAMES
         GBLC  &RCPGSWN(99)            GENERIC SWITCH BYTE NAMES
         GBLC  &RCPGSWB(99)            GENERIC SWITCH BIT PREFIXES
         GBLC  &RCPDSW1(20)            SWITCH BYTE NAMES
         GBLC  &RCPDSW2(20)            SWITCH BIT NAME(S)
         LCLA  &I,&J,&K,&L,&M,&N       LOCAL COUNTERS
         LCLC  &C,&SW1,&SW2
&RCPDSW0 SETA  0                       INITIALIZE
&N       SETA  N'&SW                   NO OF SWITCHES ENTERED
&J       SETA  &RCPDSW#*8              INDEX TO LAST DECLARED SW BIT
.LOOP1   AIF   (&M GE &N).EXIT        LOOP FOR EACH SW
&M       SETA  &M+1
&SW2     SETC  '&SW(&M)'               SWITCH TO SEARCH FOR
         AIF   ('&SW2' EQ '').LOOP1    SKIP IF NULL
&I       SETA  8                       INDEX TO FIRST DECLARED SW - 1
.LOOP1A  AIF   (&I GE &J).TGEN         SEARCH NAME ARRAY
&I       SETA  &I+1
         AIF   ('&RCPDSWB(&I)' NE '&SW2').LOOP1A
.*
.*   WE FOUND IT
.*
&L       SETA  (&I-1)/8                INDEX TO BYTE NAME
&SW1     SETC  '&RCPDSWN(&L)'          GET BYTE NAME
.FOUNDSW ANOP                          HAVE WE HAD IT BEFORE?
&K       SETA  0
.SWL1    AIF   (&K GE &RCPDSW0).NEWSW1
&K       SETA  &K+1
         AIF   ('&RCPDSW1(&K)' NE '&SW1').SWL1
.*
.* WE FOUND IT
.*
&RCPDSW2(&K) SETC '&RCPDSW2(&K)+&SW2'  CONCATENATE CURRENT SW
         AGO   .LOOP1                  GO DO NEXT
.NENSW1  ANOP
&RCPDSW0 SETA  &K+1                    NEXT SW BYTE INDEX
&RCPDSW1(&RCPDSW0) SETC '&SW1'         BYTE NAME
&RCPDSW2(&RCPDSW0) SETC '&SW2'         BIT NAME
         AGO   .LOOP1                  GO DO NEXT
.TGEN    ANOP  SEARCH GENERIC NAME ARRAY
&I       SETA  0
&L       SETA  K'&SW2
.LOOP2   ANOP
&I       SETA  &I+1
         AIF   (&I GT &RCPGSW#).NOTFND
&SW1     SETC  '&RCPGSWN(&I)'
         AIF   (&L LT K'&SW1).LOOP2
         AIF   ('&SW1'(1,&L) NE '&SW2').LOOP2
         AGO   .FOUNDSW                EUREKA
.NOTFND  MNOTE 4,'SWITCH ''&SW2'' NOT DECLARED'
         AGO   .LOOP1
.EXIT    MEND
