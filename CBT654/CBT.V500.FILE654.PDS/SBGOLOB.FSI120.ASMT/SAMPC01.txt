       IDENTIFICATION DIVISION.
       PROGRAM-ID. 'SAMPC01'.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. IBM-360.
       OBJECT-COMPUTER. IBM-360.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       77  STOP-FLAG  PIC 9 VALUE 0.
       77  LOGIN-FLAG PIC 9 VALUE 0.
       77  ERRSTAT    PIC X VALUE SPACES.
       77  ERRSTAT1   PIC X VALUE SPACES.
       01  DISPLAY-PARMS.
           10 SCREEN-NAME  PIC X(8) VALUE 'SAMP01A'.
           10 MESSAGE-ID   PIC X(8) VALUE SPACES.
           10 CURSOR-FIELD PIC X(8) VALUE SPACES.
       01  SCREEN-VARS.
           10 PF01 PIC X(8) VALUE 'HELP'.
           10 PF13 PIC X(8) VALUE 'HELP'.
           10 PF03 PIC X(8) VALUE 'END'.
           10 PF15 PIC X(8) VALUE 'END'.
           10 PF04 PIC X(8) VALUE 'RETN'.
           10 PF16 PIC X(8) VALUE 'RETN'.
           10 ZSTAT PIC X(2) VALUE SPACES.
           10 USERID PIC X(8) VALUE SPACES.
           10 PASSWD PIC X(8) VALUE SPACES.
           10 ZCMD   PIC X(50) VALUE SPACES.
           10 HITS  PIC S9(5) COMP VALUE +0.
           10 LPF01 PIC X(8) VALUE 'PF01'.
           10 LPF13 PIC X(8) VALUE 'PF13'.
           10 LPF03 PIC X(8) VALUE 'PF03'.
           10 LPF15 PIC X(8) VALUE 'PF15'.
           10 LPF04 PIC X(8) VALUE 'PF04'.
           10 LPF16 PIC X(8) VALUE 'PF16'.
           10 LZSTAT  PIC X(8) VALUE 'ZSTAT'.
           10 LUSERID PIC X(8) VALUE 'USERID'.
           10 LPASSWD PIC X(8) VALUE 'PASSWD'.
           10 LZCMD   PIC X(8) VALUE 'ZCMD'.
           10 LHITS   PIC X(8) VALUE 'HITS'.
           10 VDEF-LEN  PIC S9(5) COMP VALUE +1.
           10 VDEF-TYPE PIC S9(5) COMP VALUE +2.
           10 VDEF-TYPE-NUM  PIC S9(5) COMP VALUE +1.
           10 VDEF-TYPE-CHAR PIC S9(5) COMP VALUE +2.
           10 VDEF-OPT  PIC S9(5) COMP VALUE +0.
       PROCEDURE DIVISION.
       000-START-RUN.
           PERFORM 000-DEFINE-VARS.
           PERFORM 000-LOGIN-LOOP THRU 000-LOGIN-LOOP-EXIT
                   UNTIL STOP-FLAG = 1 OR
                         LOGIN-FLAG = 1.
           IF STOP-FLAG = 1
              GO TO 999-END-RUN.
           MOVE 'SAMP01B' TO SCREEN-NAME.
           PERFORM 000-PROCESS-LOOP THRU 000-PROCESS-LOOP-EXIT
                   UNTIL STOP-FLAG = 1.
           GO TO 999-END-RUN.
       000-LOGIN-LOOP.
           MOVE ERRSTAT TO ERRSTAT1.
           MOVE SPACES  TO ERRSTAT.
           PERFORM 000-DISPLAY THRU 000-DISPLAY-EXIT.
           MOVE 'SAMP0105' TO MESSAGE-ID.
           IF USERID = SPACES
              PERFORM 000-VALIDATE-USERID THRU
                      000-VALIDATE-USERID-EXIT
              GO TO 000-LOGIN-LOOP-EXIT.
           IF PASSWD NOT = 'SECRET'
              PERFORM 000-VALIDATE-PASSWD THRU
                      000-VALIDATE-PASSWD-EXIT
              GO TO 000-LOGIN-LOOP-EXIT.
           MOVE 1 TO LOGIN-FLAG.
       000-LOGIN-LOOP-EXIT.
       000-PROCESS-LOOP.
           MOVE SPACES  TO ERRSTAT.
           PERFORM 000-DISPLAY THRU 000-DISPLAY-EXIT.
           MOVE 'SAMP0105' TO MESSAGE-ID.
       000-PROCESS-LOOP-EXIT.
       000-VALIDATE-USERID.
           MOVE 'USERID' TO CURSOR-FIELD.
           MOVE 'U' TO ERRSTAT.
           IF ERRSTAT1 = 'U'
              MOVE 'SAMP0102' TO MESSAGE-ID
           ELSE
              MOVE 'SAMP0101' TO MESSAGE-ID.
       000-VALIDATE-USERID-EXIT.
       000-VALIDATE-PASSWD.
           MOVE 'PASSWD' TO CURSOR-FIELD.
           MOVE SPACES TO PASSWD.
           MOVE 'P' TO ERRSTAT.
           IF ERRSTAT1 = 'P'
              MOVE 'SAMP0104' TO MESSAGE-ID
           ELSE
              MOVE 'SAMP0103' TO MESSAGE-ID.
       000-VALIDATE-PASSWD-EXIT.
       000-DISPLAY.
           MOVE SPACES TO ZCMD.
           CALL 'DISPLAY' USING SCREEN-NAME,
                                MESSAGE-ID,
                                CURSOR-FIELD.
           ADD +1 TO HITS.
           MOVE SPACES  TO MESSAGE-ID.
           MOVE SPACES  TO CURSOR-FIELD.
           IF ZCMD = 'END' MOVE 1 TO STOP-FLAG.
       000-DISPLAY-EXIT.
       000-DEFINE-VARS.
           MOVE 8 TO VDEF-LEN.
           CALL 'VDEFINE' USING LPF01, PF01,
                                 VDEF-TYPE, VDEF-LEN, VDEF-OPT.
           CALL 'VDEFINE' USING LPF03, PF03,
                                 VDEF-TYPE, VDEF-LEN, VDEF-OPT.
           CALL 'VDEFINE' USING LPF04, PF04,
                                 VDEF-TYPE, VDEF-LEN, VDEF-OPT.
           CALL 'VDEFINE' USING LPF13, PF13,
                                 VDEF-TYPE, VDEF-LEN, VDEF-OPT.
           CALL 'VDEFINE' USING LPF15, PF15,
                                 VDEF-TYPE, VDEF-LEN, VDEF-OPT.
           CALL 'VDEFINE' USING LPF16, PF16,
                                 VDEF-TYPE, VDEF-LEN, VDEF-OPT.
           CALL 'VDEFINE' USING LUSERID, USERID,
                                 VDEF-TYPE, VDEF-LEN, VDEF-OPT.
           CALL 'VDEFINE' USING LPASSWD, PASSWD,
                                 VDEF-TYPE, VDEF-LEN, VDEF-OPT.
           MOVE 2 TO VDEF-LEN.
           CALL 'VDEFINE' USING LZSTAT, ZSTAT,
                                 VDEF-TYPE, VDEF-LEN, VDEF-OPT.
           MOVE 50 TO VDEF-LEN.
           CALL 'VDEFINE' USING LZCMD, ZCMD,
                                 VDEF-TYPE, VDEF-LEN, VDEF-OPT.
           MOVE 4 TO VDEF-LEN.
           CALL 'VDEFINE' USING LHITS, HITS,
                                 VDEF-TYPE-NUM, VDEF-LEN, VDEF-OPT.
       999-END-RUN.
           STOP RUN.
