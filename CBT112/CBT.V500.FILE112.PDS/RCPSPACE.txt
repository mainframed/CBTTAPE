         MACRO
         RCPSPACE &SPACE
         GBLA  &RCPSUB#                NO OF SUBLIST ELEMENTS
         GBLC  &RCPSUBL(100)           SUBLIST ELEMENTS
.**********************************************************************
.*    THIS IS AN ALLOC INNER MACRO TO BUILD THE ALLOCATION SPACE
.*    QUANTITY TEXT UNIT. IT SHOULD BE SPECIFIED AS:-
.*     SPACE=(TYPE,(PRIMARY,SECONDARY,DIRECTORY),RLSE,CONTIG,ROUND)
.*   WHERE TYPE IS 'TRK', 'CYL', 'ABSTR' OR A BLOCK QUANTITY
.*     'CYL' OR 'TRK' SHOULD NOT BE ENTERED IN QUOTES. THE BLOCK
.*     QUANTITY CAN BE A NUMBER, A REGISTER (IN BRACKETS), OR THE
.*     NAME OF A FULLWORD CONTAINING THE BLOCK SIZE.
.**********************************************************************
         AIF   ('&SPACE(1)' EQ '' OR '&SPACE(1)' EQ 'TRK').TRK
         AIF   ('&SPACE(1)' EQ 'CYL').CYL
***********************************************************************
**        SPACE UNIT IN BLOCKS                                       **
***********************************************************************
         RCPNTU DALBLKLN,3,&SPACE(1)  GENERATE BLOCK UNIT TU
         AGO   .TPRIME        GO TEST PRIME QUANTITY
.TRK     ANOP  TRACK SPEC REQ OR DEFAULTED
         SPACE
***********************************************************************
**       SPACE QUANTITY IN TRACKS                                    **
***********************************************************************
         MVI   S99TUKEY+1,DALTRK       SET TEXT UNIT KEY
         RCPDINC 4
         AGO   .TPRIME
.CYL     ANOP  CYL QUANTITY
         SPACE 1
***********************************************************************
**      SPACE UNIT IN CYLINDERS                                      **
***********************************************************************
         MVI   S99TUKEY+1,DALCYL       SET TEXT UNIT KEY
         RCPDINC 4                     STORE TEXT UNIT ADDR
.TPRIME  RCPSUBL &SPACE(2)             BREAK UP SUBLIST
         AIF   (&RCPSUB# EQ 0).TCONTIG
         AIF   ('&RCPSUBL(1)' EQ '').TSP2
         SPACE
***********************************************************************
**       PRIMARY SPACE QUANTITY                                      **
***********************************************************************
         RCPNTU DALPRIME,3,&RCPSUBL(1)
.TSP2    AIF   (&RCPSUB# LT 2).TCONTIG
         AIF   ('&RCPSUBL(2)' EQ '').TSP3
         SPACE
***********************************************************************
**       SECONDARY SPACE QUANTITY                                    **
***********************************************************************
         RCPNTU DALSECND,3,&RCPSUBL(2)
.TSP3    AIF   (&RCPSUB# LT 3).TCONTIG
         AIF   ('&RCPSUBL(3)' EQ '').TCONTIG
         SPACE
***********************************************************************
**       DIRECTORY BLOCK QUANTITY                                    **
***********************************************************************
         RCPNTU DALDIR,3,&RCPSUBL(3)
.TCONTIG AIF  ('&SPACE(3)' EQ 'CONTIG' OR '&SPACE(4)' EQ 'CONTIG').CON
         AIF   ('&SPACE(3)' EQ 'MXIG' OR '&SPACE(4)' EQ 'MXIG').MXIG
         AIF   ('&SPACE(3)' EQ 'ALX' OR '&SPACE(4)' EQ 'ALX').ALX
.TRLSE   AIF   ('&SPACE(3)' EQ 'RLSE' OR '&SPACE(4)' EQ 'RLSE').RLSE
.TROUND  AIF   ('&SPACE(4)'EQ'ROUND'OR'&SPACE(5)'EQ'ROUND').ROUND
         MEXIT
.CON     ANOP
***********************************************************************
**      CONTIGUOUS SPACE TEXT UNIT                                   **
***********************************************************************
         RCPNTU DALSPFRM,1,8
         AGO   .TRLSE
.MXIG    ANOP
***********************************************************************
**       MAXIMUM CONTIGUOUS SPACE TEXT UNIT                          **
***********************************************************************
         RCPNTU DALSPFRM,1,4
         AGO   .TRLSE
.ALX     ANOP
***********************************************************************
**       'ALX' SPACE TEXT UNIT                                       **
***********************************************************************
         RCPNTU DALSPFRM,1,2
         AGO   .TRLSE
.RLSE    ANOP
***********************************************************************
**      RELEASE UNUSED SPACE TEXT UNIT                               **
***********************************************************************
         MVI   S99TUKEY+1,DALRLSE      SET TEXT UNIT KEY
         RCPDINC 4
         AGO   .TROUND
.ROUND   ANOP
***********************************************************************
**      RELEASE UNUSED SPACE TEXT UNIT                               **
***********************************************************************
         MVI   S99TUKEY+1,DALROUND     MOVE IN TEXT UNIT KEY
         RCPDINC 4
         MEND
