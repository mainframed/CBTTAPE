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
         GBLB  &RCPDSWD(99)            DEFER DECLARE INDICATORS
         GBLC  &RCPDSWN(99)            SWITCH BYTE NAMES
         GBLC  &RCPDSWB(800)           SWITCH BIT NAMES
         GBLC  &RCPGSWN(99)            GENERIC SWITCH BYTE NAMES
         GBLC  &RCPGSWB(99)            GENERIC SWITCH BIT PREFIXES
         GBLC  &RCPDSW1                SWITCH BYTE NAME
         GBLC  &RCPDSW2                SWITCH BIT NAME(S)
         LCLA  &I,&J,&K,&L,&M,&N       LOCAL COUNTERS
         LCLC  &C
&RCPDSW2 SETC  '&SW(1)'                EXTRACT 1ST SWITCH BIT
&J       SETA  &RCPDSW#*8+8            ARRAY POS OF LAST SW BIT
&I       SETA  8                       ARRAY POS-1 OF 1ST SW BIT
.LOOP1   AIF   (&I GE &J).TGEN         IF SW NOT FOUND IN 1ST ARRAY,
.*                                      GO SEARCH GENERIC NAME ARRAY
&I       SETA  &I+1
         AIF   ('&RCPDSWB(&I)' NE '&RCPDSW2').LOOP1  LOOK FOR MATCH
.*
.*       OK, WE'VE FOUND A MATCH.
.*
&I       SETA  (&I-1)/8               GET POS OF SWITCH BYTE
&RCPDSW1 SETC  '&RCPDSWN(&I)'         MOVE IT TO EXIT PARM VAR
&I       SETA  &I*8+1                 POINT TO 1ST SW BIT IN IT
&J       SETA  &I+8                   POINT TO LAST SW BIT IN IT
&M       SETA  N'&SW                  GET NO OF SWITCHES
&L       SETA  1
.*
.*       NOW WE PROCESS SUBSEQUENT SWITCHES IN THE LIST
.*
.LOOP2   AIF   (&L GE &M).EXIT        EXIT WHEN FINISHED
&L       SETA  &L+1                   POINT TO NEXT SW IN LIST
&C       SETC  '&SW(&L)'               EXTRACT IT
&RCPDSW2 SETC  '&RCPDSW2.+&C'           THEN APPEND TO PREVIOUS
.*
.*       NOW WE CHECK THAT THE SWITCH IS DECLARED IN THE SAME
.*       BYTE AS THE FIRST.
.*
&N       SETA  &I-1                     POINT TO 1ST BIT POS MINUS 1
.LOOP3   AIF   (&N GE &J).NM            IF SW NOT FOUND, ISSUE MNOTE
&N       SETA  &N+1                     POINT TO NEXT
         AIF   ('&C' NE '&RCPDSWB(&N)').LOOP3  SEARCH FOR MATCH
         AGO   .LOOP2                   IF FOUND, GO PROCESS NEXT
.NM      MNOTE 4,'WARNING: SWITCH ''&C'' NOT DECLARED IN SAME BYTE AS  X
               SWITCH ''&SW(1)'' - LOGIC ERROR MAY OCCUR'
         AGO   .LOOP2            CONTINUE FOR NEXT SWITCH BIT
.*
.*       IF THE SWITCH WAS NOT LOCATED IN THE EXPLICIT NAME ARRAY,
.*       THE GENERIC NAME ARRAY IS SEARCHED.
.*
.TGEN    ANOP
&I       SETA  0
&RCPDSW2 SETC  '&SW(1)'                EXTRACT 1ST SWITCH
&L       SETA  K'&RCPDSW2              GET LENGTH OF 1ST SW
.LOOP4   AIF   (&I GE &RCPGSW#).ERROR  IF NOT SW NOT DECLARED, ERROR
&I       SETA  &I+1
&C       SETC  '&RCPGSWB(&I)'          GET GENERIC PREFIX
&K       SETA  K'&C                    GET LENGTH OF GENERIC PREFIX
         AIF   (&L LT &K).LOOP4         AND SKIP IF LEN OF SWITCH NAME
.*                                          < LEN OF GENERIC PREFIX
         AIF   ('&RCPDSW2'(1,&K) NE '&C').LOOP4  ALSO SKIP IF NO MATCH
&RCPDSW1 SETC  '&RCPGSWN(&I)'          SAVE SWITCH BYTE NAME
&I       SETA   1
&J       SETA   N'&SW
.LOOP5   AIF   (&I GE &J).EXIT         EXIT WHEN FINISHED
&I       SETA   &I+1
&RCPDSW2 SETC   '&RCPDSW2.+&SW(&I)'     APPEND THIS SWITCH
         AIF    ('&SW(&I)    '(1,&K) EQ '&C').LOOP5 CHECK PREFIX
         MNOTE 4,'WARNING: SWITCH ''&SW(&I)'' NOT GENERICALLY EQUAL TO X
               SWITCH ''&SW(1)'''
         AGO   .LOOP5
.ERROR   MNOTE 8,'SWITCH ''&SW(1)'' NOT DECLARED'
&RCPDSW1 SETC  ''             INDICATE ERROR
.EXIT    MEND
