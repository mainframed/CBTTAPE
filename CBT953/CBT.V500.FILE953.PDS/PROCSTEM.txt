 TITLE 'PROCSTEM - REXX Inner program for STEM manipulation'
*
PROCSTEM PRGDEF FSEG=MAIN_BIT,INREX=Y
*______________________________________________________________________
*
* Written by John Gateley - use at your own risk
*
* This program handles STEM variable manipulation for an outer
* REXX function. All modules in the assembler calling chain should
* have INREX=Y except the top level which should have REXX=Y.
*
*   STEM_FUNCTION   =   1   drop variable then set stem.0 to 0
*                       2   set a stem variable with the number in
*                           STEM_ZERO_COUNT, this is automatically
*                           incremented so if you want to reset a
*                           previous value set this to the count-1
*                       3   set STEM.0 to STEM_ZERO_COUNT
*                       4   get STEM.0 value
*                       5   get next STEM.? value
*                      21   scan stem to get max var length and count
*                      31   drop all vars > STEM_ZERO_COUNT and
*                           then set STEM.0 to input STEM_ZERO_COUNT
*
* If you have multiple stems in your program then use the PRGSTEM
* macro with PREF=???? to generate seperate storage for each one.
*
* If you want multi-part stem names you can have them,
* use STEM_MID_NAME for the middle part.
* Do not include a '.' in STEM_MID_NAME.
* This is because the DROP processing can get confused.
*
* If you have this
*              WANG.0
*              WANG_NAME.?
*              WANG_POS.?
* then WANG_NAME.0 and WANG_POS.0 will also be maintained and
*
* The following should be set before function 1
*     STEM_NAME_ADR
*     STEM_NAME_LEN
*     STEM_MID_NAME                    if required
*     Do not initialise STEM_ZERO_COUNT it needs to be invalid packed
*     on the first call as the code checks for this.
*
* The following should be set before function 2
*     STEM_TEXT_ADR
*     STEM_TEXT_LEN
*     STEM_TRIM_VAR                    Y if spaces should be removed
*
*                    the parameter area used to call irxexcom
IX_PARM              DS    4F
SAVE_R14             DS    F
*
VAR_TEXT             DS    CL8
*
                     DS    0D
ORIGINAL_COUNT       DS    PL8
*
ERR_NO               DS    CL1
JUST_LOOKING         DS    CL1
*
PARM_AREA            DS    (SHVBLEN)XL1
*
        PRGEDEF
*
                     USING STEM_AREA,R5
                     USING SHVBLOCK,R6
*______________________________________________________________________
*
 SEGS MAIN_BIT
*
   L     R5,0(R1)
   XC    IX_PARM(4*4),IX_PARM
   LA    R1,=CL8'IRXEXCOM'
   ST    R1,IX_PARM
   LA    R6,PARM_AREA
*
   IF (TP,STEM_ZERO_COUNT,NZ)          first time in ?
     ZAP   STEM_ZERO_COUNT,=P'0'       initialise count
     MVI   STEM_NAME,C' '
     MVC   STEM_NAME+1(L'STEM_NAME-1),STEM_NAME
     L     R15,STEM_NAME_ADR           address of name
     L     R14,STEM_NAME_LEN           length of name
     BCTR  R14,0                       minus 1 for execute
     LA    R1,0(R14,R15)               POINT TO LAST BYTE
     IF (CLI,0(R1),EQ,C'.')
       ST    R14,STEM_NAME_LEN         save new length
       BCTR  R14,0                     minus 1 for execute
     ENDIF
     LA    R1,STEM_NAME                point to stem name
     EX    R14,COPY_STEM_NAME          copy input name to working
     LA    R1,1(R14,R1)                point after copied name
     MVI   0(R1),C'.'                  add a period
     LA    R1,1(,R1)                   point after
     ST    R1,STEM_AFT_DOT             store addr of this byte
     L     R2,STEM_NAME_LEN            get length of name
     IF (CLC,STEM_MID_NAME,GT,SPACES)  is there a middle part ?
       LR    R15,R1                    point at current end
       BCTR  R15,0                     back one
       MVI   0(R15),C'_'               replace dot with underscore
       LA    R14,STEM_MID_NAME         point at it
       LA    R15,L'STEM_MID_NAME       get length of field
       DO FROM=(R15)
       DOEXIT (CLI,0(R14),LE,C' ')     quit when <= blank
         MVC   0(1,R1),0(R14)          copy one byte
         LA    R1,1(,R1)               next output byte
         LA    R2,1(,R2)               add to length
         LA    R14,1(,R14)             next input byte
       ENDDO
       MVI   0(R1),C'.'                add a period
       LA    R1,1(,R1)                 point after period
       LA    R2,1(,R2)                 add to length
       ST    R1,STEM_AFT_DOT           store addr of this byte
     ENDIF
     LA    R2,2(,R2)                   add 2 for .0
     ST    R2,STEM_NAME_LEN            save actual length
   ENDIF
*
   LA    R15,STEM_NAME+L'STEM_NAME
   L     R14,STEM_AFT_DOT
   SR    R15,R14                       calc length remaining
   DO FROM=(R15)
     MVI   0(R14),C' '                 blank out rest of name
     LA    R14,1(,R14)
   ENDDO
   OC    STEM_NAME,SPACES
*
   MVC   SHVNEXT,=F'0'
   MVC   SHVUSER,=F'0'
   MVC   SHVBUFL,=F'0'
   MVI   SHVCODE,SHVSYSET              command is set variable
   LA    R1,STEM_NAME                  point to stem name
   ST    R1,SHVNAMA                    store in function call
*
   IF (CLHHSI,STEM_FUNCTION,EQ,1)
     SEGDO DROP_ENTIRE_STEM            drop the stem.
     MVI   SHVCODE,SHVSTORE            reset command to store variable
     SEGDO INIT_STEM_ZERO              initialise stem.0
   ELSEIF (CLHHSI,STEM_FUNCTION,EQ,2)
     SEGDO SET_STEM_LINE               create new variable
   ELSEIF (CLHHSI,STEM_FUNCTION,EQ,3)
     SEGDO SET_STEM_ZERO               set stem.0 with the total
   ELSEIF (CLHHSI,STEM_FUNCTION,EQ,4)
     SEGDO GET_STEM_ZERO               get stem.0 value
   ELSEIF (CLHHSI,STEM_FUNCTION,EQ,5)
     SEGDO GET_STEM_LINE               get next stem.? value
   ELSEIF (CLHHSI,STEM_FUNCTION,EQ,21)
     SEGDO GET_STEM_TOTALS             get max var length and count
   ELSEIF (CLHHSI,STEM_FUNCTION,EQ,31)
     SEGDO DROP_EXCESS_VARS            drop unused stem members
   ELSE
     MVC   MESS_TXT(22),=CL22'PROCSTEM invalid call'
     SEGDO CALL_IRXSAY
     PRGQUIT RC=8                      invalid function so quit
   ENDIF
*
 SEGE MAIN_BIT
*______________________________________________________________________
*
 SEGS GET_STEM_TOTALS
*
   SEGDO GET_STEM_ZERO
*
   L     R1,STEM_TEXT_LEN              length of variable returned
   L     R14,STEM_TEXT_ADR
   BCTR  R1,0
   EX    R1,PACK_STEM_0                save number of items
   ZAP   DOUB_WORD,STEM_ZERO_COUNT
   CVB   R14,DOUB_WORD
   XR    R4,R4
   ZAP   STEM_ZERO_COUNT,=P'0'         initialise count
   MVI   JUST_LOOKING,C'Y'
   DO FROM=(R14)
     ST    R14,SAVE_R14
     LA    R15,STEM_NAME+L'STEM_NAME
     L     R14,STEM_AFT_DOT
     SR    R15,R14                       calc length remaining
     DO FROM=(R15)
       MVI   0(R14),C' '                 blank out rest of name
       LA    R14,1(,R14)
     ENDDO
     SEGDO GET_STEM_LINE
     IF (C,R4,LT,STEM_TEXT_LEN)
       L     R4,STEM_TEXT_LEN
     ENDIF
     L     R14,SAVE_R14
   ENDDO
   NI    JUST_LOOKING,0
   ST    R4,STEM_MAX_LEN
*
 SEGE GET_STEM_TOTALS
*______________________________________________________________________
*
 SEGS DROP_EXCESS_VARS
*
*  After a sort with a sum statement there can be redundant stem
*  variables, this routine removes them.
*
   ZAP   ORIGINAL_COUNT,STEM_ZERO_COUNT  original count
*
   SEGDO GET_STEM_ZERO                 get current count
*
   L     R1,STEM_TEXT_LEN              length of variable returned
   L     R14,STEM_TEXT_ADR
   BCTR  R1,0
   EX    R1,PACK_STEM_0                copy current value
   SP    ORIGINAL_COUNT,STEM_ZERO_COUNT
   CVB   R4,ORIGINAL_COUNT             now has difference in value
*
   DO FROM=(R4)
     AP    STEM_ZERO_COUNT,=P'1'       increment variable number
     LA    R15,STEM_NAME+L'STEM_NAME
     L     R14,STEM_AFT_DOT
     SR    R15,R14                     calc length remaining
     DO FROM=(R15)
       MVI   0(R14),C' '               blank out rest of name
       LA    R14,1(,R14)
     ENDDO
     SEGDO DROP_STEM_VARIABLE
   ENDDO
*
 SEGE DROP_EXCESS_VARS
*______________________________________________________________________
*
 SEGS DROP_ENTIRE_STEM
*
   MVC   SHVNEXT,=F'0'
   MVC   SHVUSER,=F'0'
   MVI   SHVCODE,SHVDROPV              command is drop variable
   MVC   SHVBUFL,=F'0'
   MVC   SHVVALA,=F'0'
   MVC   SHVVALL,=F'0'
   LA    R1,STEM_NAME                  point to stem name
   ST    R1,SHVNAMA                    store in function call
   L     R1,STEM_NAME_LEN              get length including .0
   BCTR  R1,0                          drop the 0
   ST    R1,SHVNAML                    use as length
*
   SEGDO CALL_IRXEXCOM
*
   IF (LTR,R15,R15,NZ)
     MVC   MESS_TXT(L'E_D_STEM_0),E_D_STEM_0
     XUNPK (R15),4,MESS_TXT+L'E_D_STEM_0
     SEGDO CALL_IRXSAY
     PRGQUIT RC=8
   ENDIF
*
 SEGE DROP_ENTIRE_STEM
*______________________________________________________________________
*
 SEGS DROP_STEM_VARIABLE
*
   MVC   SHVNEXT,=F'0'
   MVC   SHVUSER,=F'0'
   MVI   SHVCODE,SHVDROPV              command is drop variable
   MVC   SHVBUFL,=F'0'
   MVC   SHVVALA,=F'0'
   MVC   SHVVALL,=F'0'
   MVC   VAR_TEXT,=X'4020202020202120' copy edit pattern
   LA    R1,VAR_TEXT+L'VAR_TEXT-1      point to last digit
   EDMK  VAR_TEXT,STEM_ZERO_COUNT      edit number into mask
   LA    R2,VAR_TEXT+L'VAR_TEXT-1      point at last byte
   SR    R2,R1                         get length for execute
   L     R3,STEM_AFT_DOT
   EX    R2,COPY_VAR_NUMB              copy number after STEM.
   LA    R3,1(R2,R3)                   point past copied stuff
   LA    R1,STEM_NAME
   SR    R3,R1
   ST    R3,SHVNAML
*
   SEGDO CALL_IRXEXCOM
*
   IF (LTR,R15,R15,NZ)
     MVC   MESS_TXT(L'E_D_STEM_LINE),E_D_STEM_LINE
     XUNPK (R15),4,MESS_TXT+L'E_D_STEM_LINE
     SEGDO CALL_IRXSAY
     PRGQUIT RC=8
   ENDIF
*
 SEGE DROP_STEM_VARIABLE
*______________________________________________________________________
*
 SEGS INIT_STEM_ZERO
*
   L     R1,STEM_AFT_DOT
   MVI   0(R1),C'0'
   MVC   SHVNAML,STEM_NAME_LEN

   LA    R1,=C'0'                      set STEM.0 to '0'
   ST    R1,SHVVALA
   LA    R1,1                          length of 1
   ST    R1,SHVVALL
*
   SEGDO CALL_IRXEXCOM
*
   IF (LTR,R15,R15,NZ)
     MVC   MESS_TXT(L'E_I_STEM_0),E_I_STEM_0
     XUNPK (R15),4,MESS_TXT+L'E_I_STEM_0
     SEGDO CALL_IRXSAY
     PRGQUIT RC=8
   ENDIF
*
 SEGE INIT_STEM_ZERO
*______________________________________________________________________
*
 SEGS SET_STEM_LINE
*
   AP    STEM_ZERO_COUNT,=P'1'         increment count
   MVC   VAR_TEXT,=X'4020202020202120' copy edit pattern
   LA    R1,VAR_TEXT+L'VAR_TEXT-1      point to last digit
   EDMK  VAR_TEXT,STEM_ZERO_COUNT      edit number into mask
   LA    R2,VAR_TEXT+L'VAR_TEXT-1      point at last byte
   SR    R2,R1                         get length for execute
   L     R3,STEM_AFT_DOT
   EX    R2,COPY_VAR_NUMB              copy number after STEM.
   LA    R3,1(R2,R3)                   point past copied stuff
   LA    R1,STEM_NAME
   SR    R3,R1
   ST    R3,SHVNAML
   IF (CLI,STEM_TRIM_VAR,EQ,C'Y')      want to remove all blanks ?
     MVC   SHVVALA,STEM_TEXT_ADR       copy address of value
     L     R14,STEM_TEXT_ADR           point to value
     L     R15,STEM_TEXT_LEN           get length of value
     TRIM  (R14),(R15),ALL=Y           remove all blanks
     ST    R15,SHVVALL                 R15 has length of the result
   ELSE
     MVC   SHVVALA,STEM_TEXT_ADR       copy address
     MVC   SHVVALL,STEM_TEXT_LEN       copy length
   ENDIF
*
   SEGDO CALL_IRXEXCOM
*
   IF (LTR,R15,R15,NZ)
     MVC   MESS_TXT(L'E_S_STEM_LINE),E_S_STEM_LINE
     XUNPK (R15),4,MESS_TXT+L'E_S_STEM_LINE
*    MVC   MESS_TXT+L'E_S_STEM_LINE+10(1),SHVCODE
*    MVC   MESS_TXT+L'E_S_STEM_LINE+12(1),SHVRET
     SEGDO CALL_IRXSAY
     PRGQUIT RC=8
   ENDIF
*
 SEGE SET_STEM_LINE
*______________________________________________________________________
*
 SEGS SET_STEM_ZERO
*
   L     R1,STEM_AFT_DOT
   MVI   0(R1),C'0'                    STEM.0
   MVC   SHVNAML,STEM_NAME_LEN

   MVC   VAR_TEXT,=X'4020202020202120'
   LA    R1,VAR_TEXT+L'VAR_TEXT-1
   EDMK  VAR_TEXT,STEM_ZERO_COUNT
   LA    R2,VAR_TEXT+L'VAR_TEXT
   SR    R2,R1                         calc length of value
   ST    R1,SHVVALA                    store address of value
   ST    R2,SHVVALL                    store length of value
*
   SEGDO CALL_IRXEXCOM
*
   IF (LTR,R15,R15,NZ)
     MVC   MESS_TXT(L'E_S_STEM_ZERO),E_S_STEM_ZERO
     XUNPK (R15),4,MESS_TXT+L'E_S_STEM_ZERO
     SEGDO CALL_IRXSAY
     PRGQUIT RC=8
   ENDIF
*
 SEGE SET_STEM_ZERO
*______________________________________________________________________
*
 SEGS GET_STEM_ZERO
*
   LA    R1,STEM_NAME                  point to stem name
   ST    R1,SHVNAMA                    store in function call
   MVC   SHVNEXT,=F'0'
   MVC   SHVUSER,=F'0'
   MVI   SHVCODE,SHVFETCH              command is fetch variable
   MVC   SHVBUFL,STEM_MAX_LEN
   MVC   SHVVALL,=F'0'
   MVC   SHVVALA,STEM_TEXT_ADR
*
   L     R1,STEM_AFT_DOT
   MVI   0(R1),C'0'                    STEM.0
   MVC   SHVNAML,STEM_NAME_LEN
*
   SEGDO CALL_IRXEXCOM
*
   IF (LTR,R15,R15,NZ)
     MVC   MESS_TXT(L'E_G_STEM_ZERO),E_G_STEM_ZERO
     XUNPK (R15),4,MESS_TXT+L'E_G_STEM_ZERO
     SEGDO CALL_IRXSAY
     PRGQUIT RC=8
   ELSEIF (CLI,SHVRET,EQ,SHVNEWV)
     MVC   MESS_TXT(L'NEW_VARIABLE_3),NEW_VARIABLE_3
     SEGDO CALL_IRXSAY
     MVC   MESS_TXT(L'STEM_NAME),STEM_NAME
     SEGDO CALL_IRXSAY
   ENDIF
   MVC   STEM_TEXT_LEN,SHVVALL
*
 SEGE GET_STEM_ZERO
*______________________________________________________________________
*
 SEGS GET_STEM_LINE
*
   LA    R1,STEM_NAME                  point to stem name
   ST    R1,SHVNAMA                    store in function call
   MVC   SHVNEXT,=F'0'
   MVC   SHVUSER,=F'0'
   MVI   SHVCODE,SHVFETCH              command is fetch variable
   MVC   SHVBUFL,STEM_MAX_LEN          copy length
   MVC   SHVVALA,STEM_TEXT_ADR         copy address
   MVC   SHVVALL,=F'0'
*
   AP    STEM_ZERO_COUNT,=P'1'         increment count
   MVC   VAR_TEXT,=X'4020202020202120' copy edit pattern
   LA    R1,VAR_TEXT+L'VAR_TEXT-1      point to last digit
   EDMK  VAR_TEXT,STEM_ZERO_COUNT      edit number into mask
   LA    R2,VAR_TEXT+L'VAR_TEXT-1      point at last byte
   SR    R2,R1                         get length for execute
   L     R3,STEM_AFT_DOT
   EX    R2,COPY_VAR_NUMB              copy number after STEM.
   LA    R3,1(R2,R3)                   point past copied stuff
   LA    R1,STEM_NAME
   SR    R3,R1
   ST    R3,SHVNAML
*
   SEGDO CALL_IRXEXCOM
*
   IF (LTR,R15,R15,NZ)
     IF (CFI,R15,EQ,4),AND,(CLI,JUST_LOOKING,EQ,C'Y'),AND,             /
               (CLI,SHVRET,EQ,SHVTRUNC)
* do not mind truncation as we only want the variable length
     ELSE
       MVC   MESS_TXT(L'ERR_STEM_LINE),ERR_STEM_LINE
       XUNPK (R15),4,MESS_TXT+L'ERR_STEM_LINE
       MVC   MESS_TXT+L'ERR_STEM_LINE+9(7),=C'SHVRET='
       MVC   MESS_TXT+L'ERR_STEM_LINE+16(1),SHVRET
       SEGDO CALL_IRXSAY
       MVC   MESS_TXT(L'STEM_NAME),STEM_NAME
       SEGDO CALL_IRXSAY
       PRGQUIT RC=8
     ENDIF
   ELSEIF (CLI,SHVRET,EQ,SHVNEWV)
     MVC   MESS_TXT(L'NEW_VARIABLE_1),NEW_VARIABLE_1
     SEGDO CALL_IRXSAY
     MVC   MESS_TXT(L'NEW_VARIABLE_2),NEW_VARIABLE_2
     SEGDO CALL_IRXSAY
     MVC   MESS_TXT(L'STEM_NAME),STEM_NAME
     SEGDO CALL_IRXSAY
     PRGQUIT RC=8
   ENDIF
   MVC   STEM_TEXT_LEN,SHVVALL
*
 SEGE GET_STEM_LINE
*______________________________________________________________________
*
 SEGS CALL_IRXEXCOM
*
   LA    R1,PARM_AREA
   ST    R1,IX_PARM+12
   OI    IX_PARM+12,X'80'
   L     R0,#SAV_REX+12                rexx environment block addr
   LA    R1,IX_PARM
   USING IRXEXTE,15
   L     15,ENVBLOCK_IRXEXTE
   L     15,IRXEXCOM
   DROP  15
   BASR  14,15
*
 SEGE CALL_IRXEXCOM
*______________________________________________________________________
*
 SEGS CALL_IRXSAY
*
   LA    R1,=CL8'WRITE'
   ST    R1,MY_P_1
   LA    R1,MESS_TXT
   ST    R1,MY_P_8
   LA    R1,MY_P_8
   ST    R1,MY_P_2
   LA    R1,L'MESS_TXT
   ST    R1,MY_P_9
   LA    R1,MY_P_9
   ST    R1,MY_P_3
   OI    MY_P_3,X'80'
   L     R0,#SAV_REX+12                rexx environment block addr
   LA    R1,MY_PARM
   USING IRXEXTE,15
   L     15,ENVBLOCK_IRXEXTE
   L     15,IRXSAY
   DROP  15
   BASR  14,15
   IF (LTR,R15,R15,NZ)
     ST    R15,R_C
     SEGDO WRITE_LOG
     MVC   MESS_TXT(19),=C'Return code on SAY='
     XUNPK R_C,4,MESS_TXT+19
     SEGDO WRITE_LOG
   ENDIF
   MVI   MESS_TXT,C' '
   MVC   MESS_TXT+1(L'MESS_TXT-1),MESS_TXT
*
 SEGE CALL_IRXSAY
*______________________________________________________________________
*
*SEGS WRITE_LOG
*
*  WTOX
*
*SEGE WRITE_LOG
*______________________________________________________________________
*
               PRGSTAT
*
COPY_STEM_NAME MVC   0(1,R1),0(R15)
COPY_VAR_NUMB  MVC   0(1,R3),0(R1)
PACK_STEM_0    PACK  STEM_ZERO_COUNT,0(0,R14)
*
E_D_STEM_0     DC    C'Error in drop_stem_zero RC='
E_I_STEM_0     DC    C'Error in init_stem_zero RC='
E_D_STEM_LINE  DC    C'Error in drop_stem_line RC='
E_G_STEM_ZERO  DC    C'Error in get_stem_zero  RC='
E_S_STEM_LINE  DC    C'Error in set_stem_line  RC='
E_S_STEM_ZERO  DC    C'Error in set_stem_zero  RC='
ERR_STEM_LINE  DC    C'Error reading stem.? RC='
NEW_VARIABLE_1 DC    C'Warning - the fetched variable was created'
NEW_VARIABLE_2 DC    C'The STEM.0 count is probably incorrect'
NEW_VARIABLE_3 DC    C'Warning - the fetched variable was created'
SPACES         DC    80CL1' '
*
               LTORG
*
               PRGSTEM DSECT=Y
*
               PRGESTAT
               PRGEND
               END
