         MACRO
         RCPDFPL
         GBLC  &RCPPRE
         GBLB  &RCPDFPL(2)
         GBLB  &RCPDFPB(2)
         LCLC  &P,&L,&L1
&P       SETC  '&RCPPRE'
         EJECT
         AIF   (&RCPDFPL(2)).BYPDFPL
&RCPDFPL(2) SETB 1
         IKJDFPL
L#DFPL   EQU   *-DFPL                  LENGTH OF DEFAULT PARAM LIST
         IKJDFPB
L#DFPB   EQU   *-DFPB                  LENGTH OF DEFAULT PARAM BLOCK
&SYSECT  CSECT                         RESUME PROGRAM CSECT
         SPACE 3
.BYPDFPL RCPDS
&P.DFPL  DS    CL(L#DFPL)              RESERVE SPACE FOR DFPL
&P.DFPB  DS    CL(L#DFPB)              RESERVE SPACE FOR DFPB
&P.DSNB  DS    CL48                    RESERVE SPACE FOR DSNAME BUFFER
         RCPDS
         EJECT
***********************************************************************
***   THIS CODE GENERATES AN DEFAULT SERVICE ROUTINE PARAMETER LIST ***
***       AND PARAMETER BLOCK                                       ***
***********************************************************************
         LA    R1,&P.DFPL              LOAD DFPL ADDRESS
         USING DFPL,R1                 DFPL ADDRESSABLE
         MVC   DFPLUPT,CPPLUPT         MOVE IN ADDRESS OF UPT
         MVC   DFPLECT,CPPLECT         MOVE IN ADDRESS OF ECT
         LA    R15,&P.ECB              LOAD ADDRESS OF ATTN ECB
         ST    R15,DFPLECB             AND STORE IN DFPL
         LA    R15,&P.DFPB             LOAD DFBP ADDRESS
         ST    R15,DFPLDFPB             AND STORE IT IN DFPB
         DROP  R1
         USING DFPB,R15                ADDRESS DFPB DSECT
         XC    DFPB(L#DFPB),DFPB       CLEAR DEFAULT PARAMETER BLOCK
         MVC   DFPBPSCB,CPPLPSCB       MOVE IN ADDRESS OF PSCB
         LA    R1,&P.DSNB              LOAD DSNAME BUFFER ADDRESS
         ST    R1,DFPBDSN               AND STORE IT INTO DFPB
         MVI   DFPBCODE,DFPB04          SET ENTRY CODE
         DROP  R15                     DFPB NO LONGER ADDRESSABLE
         EJECT
         MEND
