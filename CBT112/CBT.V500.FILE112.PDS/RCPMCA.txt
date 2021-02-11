         MACRO
         RCPMCA &DSECT=YES
         GBLC  &RCPPRE
         GBLA  &RCPSWS(10)
         LCLC  &P
     RCPDEBUG
&P       SETC  '&RCPPRE'
         AIF   (&RCPSWS(2) NE 2).DSECT
&P.MCA   DS    0F                      MODULE COMMUNICATIONS AREA
         AGO   .MCA2
.DSECT   ANOP
&P.MCA   DSECT                         MODULE COMMUNICATIONS AREA
.MCA2    ANOP
&P.XDS   DS    F                       ADDR OF EXTERNAL DUMMY SECTION
         AIF   (&RCPSWS(3) LT 1).EXIT
&P.A#GET DS    F                       ADDRESS OF LIFO GET ROUTINE
&P.A#FRE DS    F                       ADDRESS OF LIFO FREE ROUTINE
&P.#S    DS    F                       ADDRESS OF CURRENT LIFO STACK
&P.#E    DS    F                       ADDRESS OF END OF LIFO STACK
&P.#N    DS    F                       ADDRESS OF NEXT FREE AREA
&P.#C    DS    F                       ADDRESS OF NEXT LIFO STACK
&P.#L    DS    F                       LENGTH OF CURRENT LIFO STACK
.EXIT    MEND
