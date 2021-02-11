         MACRO
&NAME    S99FAIL &RB=(R14),&RC=(R15),&CPPL=,&MF=G,&CP=
         GBLB  &RCPCPPL(2)             CP INDICATOR
         GBLC  &RCPPRE
         LCLB  &GEN
         LCLC  &C
&NAME    DS    0H
         AIF   ('&MF(1)' EQ 'G').GEN
         AIF   ('&MF(1)' EQ 'E').EXEC
         MNOTE 4,'&MF(1) IS AN INVALID MF, MF=G USED'
.GEN     LA    R1,FAIL&SYSNDX     LOAD PLIST ADDRESS
&GEN     SETB  1
         AGO   .L
.EXEC    AIF   ('&MF(2)' NE '').LISTOK
         MNOTE 8,'LIST ADDRESS NOT SPECIFIED'
         MEXIT
.LISTOK  AIF   ('&MF(3)' EQ '').TMF2
&MF(3)   EQU   24                      LENGTH OF PARAMETER LIST
.TMF2    AIF   ('&MF(2)' EQ '(R1)' OR '&MF(2)' EQ '(1)').L
         AIF   ('&MF(2)'(1,1) EQ '(').REG
         LA    R1,&MF(2)          LOAD DAIRFAIL PARAM LIST ADDRESS
         AGO   .L
.REG     ANOP
&C       SETC  '&MF(2)'(2,K'&MF(2)-2)
         LR    R1,&C              LOAD DAIRFAIL PARAM LIST ADDR
.L       AIF   ('&RB'(1,1) EQ '(').RBR
         AIF   ('&RB' NE '').RBA
         MNOTE 8,'REQ BLOCK ADDRESS NOT SPECIFIED'
         MEXIT
.RBR     ST    &RB(1),0(R1)       STORE S99 RB ADDRESS
         AGO   .RC
.RBA     LA    R14,&RB            LOAD ADDRESS OF REQ BLOCK
         ST    R14,0(R1)          AND STORE IN PLIST
.RC      AIF   ('&RC'(1,1) EQ '(').RCR
         LA    R14,&RC            LOAD ADDRESS OF RET CODE
         ST    R14,4(R1)          AND STORE IN PLIST
         AGO   .EFF02
.RCR     ANOP
.GRC     LA    R14,20(R1)         LOAD ADDR RET CODE FLD
         ST    &RC(1),0(R14)      STORE RET CODE
         ST    R14,4(R1)          AND STORE ITS ADDRESS
.EFF02   LA    R14,=A(0)          LOAD ADDR OF FULLWORD OF 0
         ST    R14,8(R1)          STORE IT.
         AIF   ('&CP' EQ 'YES' OR &RCPCPPL(1)).CPID
         LA    R14,=X'8032'       LOAD ADDRESS OF CALLERID
         ST    R14,12(R1)          AND STORE IT
         XC    16(4,R1),16(R1)    CLEAR CPPL POINTER
         AGO   .GO
.CPID    LA    R14,=Y(50)         LOAD ADDRESS OF CALLERID
         ST    R14,12(R1)         AND STORE IT
         AIF   ('&CPPL' EQ '').DCPPL
         AIF   ('&CPPL'(1,1) EQ '(').RCPPL
         LA    R14,&CPPL          LOAD CPPL ADDRESS
         ST    R14,16(R1)          AND STORE IT
         AGO   .GO
.DCPPL   MVC   16(4,R1),&RCPPRE.CPPL MOVE IN CPPL ADDRESS
         AGO   .GO
.RCPPL   ST    &CPPL(1),16(R1)    STORE ADDRESS OF CPPL
.GO      LINK  EP=IKJEFF18
         AIF   (NOT &GEN).EXIT
         SPACE 1
         RCPDS
&C SETC 'FAIL&SYSNDX'
&C       DS    6F             RESERVE SPACE FOR PARAM LIST
         RCPDS
.EXIT    MEND
