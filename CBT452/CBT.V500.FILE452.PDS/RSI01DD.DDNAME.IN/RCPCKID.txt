         MACRO
&NAME    RCPCKID              &CHECKID
         GBLB  &RCPECT(2),&RCPPSCB(2)
         GBLC  &RCPPRE
         LCLC  &CHARVAR,&P
         LCLA  &COUNTR,&L
&P       SETC  '&RCPPRE'
&RCPPSCB(1) SETB  1
&RCPECT(1)  SETB  1
         EJECT
         SPACE 4
***********************************************************************
***  THE USERID OF THE USER IS CHECKED. IF IT IS NOT VALID, THE    ****
***   COMMAND PRETENDS IT DOES NOT EXIST BY LINKING TO EXEC IN     ****
***   THE SAME WAY THE TMP DOES IF IT CANNOT FIND THE COMMAND.     ****
***********************************************************************
         SPACE 3
         L     R1,CPPLPSCB             LOAD ADDRESS OF PSCB
         USING PSCB,R1                 PSCB ADDRESSABILITY
.NID     ANOP
&COUNTR  SETA  &COUNTR+1
         AIF   ('&CHECKID(&COUNTR)' EQ '').ENDID
&CHARVAR SETC  '&CHECKID(&COUNTR)'
&L       SETA  K'&CHARVAR
         AIF   ('&CHARVAR'(1,1) EQ '''').QCID
         CLC   PSCBUSER(&L),=C'&CHARVAR'  IS THE USERID VALID?
         BE    &P.IDOK                     YES, BRANCH OUT
         AGO   .NID
.QCID    ANOP
&L       SETA  &L-2
         CLC   PSCBUSER(&L),=C&CHARVAR    IS THE USERID VALID?
         BE    &P.IDOK                     YES, BRANCH OUT
         AGO   .NID
.ENDID   L     R1,CPPLECT              LOAD ECT ADDRESS
         SPACE 2
         USING ECT,R1
         MVC   ECTPCMD,&P.EXECN        MOVE IN COMMAND NAME
         DROP  R1                      KILL ECT ADDRESSABILITY
         L     R1,CPPLCBUF             LOAD CBUF ADDRESS
         XC    2(2,R1),2(R1)           ZERO OFFSET FIELD
         L     R1,&P.CPPL              RELOAD CPPL ADDRESS
         XCTL  EPLOC=&P.EXECN
&P.EXECN DC    CL8'EXEC'               NAME OF EXEC PROCESSOR
&P.IDOK  DS    0H
         MEND
