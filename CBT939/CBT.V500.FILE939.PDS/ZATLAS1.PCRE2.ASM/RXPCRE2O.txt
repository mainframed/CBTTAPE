 TITLE 'RXPCRE2O - REXX FUNCTION FOR PERL COMPATIBLE REGEX'
 PRINT GEN
RXPCRE2O PRGDEF FSEG=MAIN_BIT,REXX=Y
*______________________________________________________________________
*
* This program is used to create an option word (unsigned integer)
* containing the bit patterns which match the specified options.
*
* Version 0.1
* Contributed by:   John Gateley  January 2020.
* Copyright (c) 2020, John Gateley.
* All rights reserved.
*______________________________________________________________________
*
* Redistribution and use in source and binary forms, with or
* without modification, are permitted provided that the following
* conditions are met:
*
*  1. Redistributions of source code must retain the above
*  copyright notice, this list of conditions and the following
*  disclaimer.
*
*  2. Redistributions in binary form must reproduce the above
*  copyright notice, this list of conditions and the following
*  disclaimer in the documentation and/or other materials
*  provided with the distribution.
*
*  3. Neither the name of the University of Cambridge nor the
*  names of its contributors may be used to endorse or promote
*  products derived from this software without specific prior
*  written permission.
*
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
* CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
* INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
* MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
* DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
* CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
* SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
* NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
* LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
* HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
* CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
* OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
* EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*______________________________________________________________________
*
* This program acts as a REXX function and is designed to be used
* with the z/OS port of 'PCRE2 - Perl Compatible Regular Expressions'
* which was created by Ze'ev Atlas.
*
* This program was written by John Gateley in January 2020.
*
* To assemble these programs you will need to supplied macros and will
* also need to assemble modules STRINGIT which is used in STRING macro
* and TRIMIT which is used by the TRIM macro.
*______________________________________________________________________
*
* How it works.
*
* This program RXPCRE2O is a rexx function and is used to create
* option integers for the processing in RXPCRE2.
*
*
* There is one call to the function
*
*      r_c     = RXPCRE2O('OP_T','VAR_NAM')
*
*    OP_T      the name of a stem variable which contains the options
*              to be used.
*    VAR_NAME  the name of a rexx variable which will contain the
*              resulting option bit values.
*              This will be 8 bytes of hexadecimal display
*
*    op_t.1 = 'PCRE2_DOLLAR_ENDONLY'
*    op_t.2 = 'PCRE2_DOTALL'
*    op_t.3 = 'PCRE2_DUPNAMES'
*    op_t.0 = '3'
*
*    Returns 0 if OK
*            8 if failed - an error message will be writen using IRXSAY
*______________________________________________________________________
*
*  REENTRANT STORAGE
*
TABLE_CNT            DS    F
TABLE_LEN            DS    F
TABLE_ADR            DS    A
VAR_NAME_ADR         DS    F
VAR_NAME_LEN         DS    F
VAR_NAME             DS    CL20
VAR_CONTENT          DS    CL8
SET_THE_OPTIONS      DS    F
INPUT_VAR_TEXT       DS    CL(L'PCRE_OPTION)
ERR_NO               DS    CL1
*
*                    the parameter area used to call irxexcom
IX_PARM              DS    4F
PARM_AREA            DS    (SHVBLEN)XL1
*
        PRGEDEF
*
        USING PCRE_OPTIONS,R4
        USING SHVBLOCK,R6
*______________________________________________________________________
*
 SEGS MAIN_BIT
*
   XC    THE_STEM_AREA(THE_STEM_BLOCK_LEN),THE_STEM_AREA
*
   SEGDO GET_THE_ARGUMENTS             read both arguments
*
   XC    SET_THE_OPTIONS,SET_THE_OPTIONS
*
   LA    R1,INPUT_VAR_TEXT             point to variable area
   ST    R1,THE_STEM_TEXT_ADR          save address
   LA    R1,L'INPUT_VAR_TEXT           length of variable area
   ST    R1,THE_STEM_MAX_LEN           save length
*
   MVI   THE_STEM_TRIM_VAR,C'N'        do not strip spaces
*
   SEGDO COPY_STEM_TO_MEMORY
*
   PUSH  USING
THIS     USING PCRE_OPTIONS,R8         map DSECT with prefix
*
   L     R5,TABLE_CNT                  reload table count
   L     R8,TABLE_ADR                  point to table
   BCTR  R5,0                          count - 1
   IF (LTR,R5,R5,P)                    at least 2 for compare ?
     DO FROM=(R5)                      for each input option
       LA    R4,THIS.PCRE_NEXT         point at next in table
       LR    R3,R5                     copy loop count
       DO FROM=(R3)
*        if mixing compile and none compile options
         IF (CLI,THIS.PCRE_COMPILE,EQ,C'C'),AND,                       /
               (CLI,PCRE_COMPILE,NE,C'C')
*          it is not valid
*          unless they are these types in which case
           IF (CLC,=C'CMD',EQ,THIS.PCRE_COMPILE),AND,                  /
               (CLC,=C' MD',EQ,PCRE_COMPILE)
*            oh! actually it is valid
           ELSE
             MVC   MESS_TXT(L'PCRE_OPTION),THIS.PCRE_OPTION
             MVC   MESS_TXT+40(L'PCRE_OPTION),PCRE_OPTION
             SEGDO CALL_IRXSAY
             MVI   ERR_NO,10           dont mix compile/match with sub
             SEGDO NOT_VALID           quits program
           ENDIF
*        if mixing compile and none compile options
         ELSEIF (CLI,THIS.PCRE_COMPILE,NE,C'C'),AND,                   /
               (CLI,PCRE_COMPILE,EQ,C'C')
*          it is not valid
*          unless they are these types in which case
           IF (CLC,=C' MD',EQ,THIS.PCRE_COMPILE),AND,                  /
               (CLC,=C'CMD',EQ,PCRE_COMPILE)
*            oh! actually it is valid
           ELSE
             MVC   MESS_TXT(L'PCRE_OPTION),THIS.PCRE_OPTION
             MVC   MESS_TXT+40(L'PCRE_OPTION),PCRE_OPTION
             SEGDO CALL_IRXSAY
             MVI   ERR_NO,10           dont mix compile/match with sub
             SEGDO NOT_VALID           quits program
           ENDIF
         ENDIF
         LA    R4,PCRE_NEXT            next in inner loop
       ENDDO
       LA    R8,THIS.PCRE_NEXT         next in outer loop
     ENDDO
   ENDIF
*
   L     R5,TABLE_CNT                  reload table count
   L     R8,TABLE_ADR                  point to table
   DO FROM=(R5)                        for each input option
     OC    SET_THE_OPTIONS,THIS.PCRE_BITS or in this bit setting
     LA    R8,THIS.PCRE_NEXT           next in loop
   ENDDO
*
   POP   USING
*
   XUNPK SET_THE_OPTIONS,4,VAR_CONTENT
   SEGDO OUTPUT_A_VARIABLE
*
   L     R3,TABLE_ADR                  load table address
   L     R2,TABLE_LEN                  load table total length
   STORAGE RELEASE,LENGTH=(R2),ADDR=(R3)
*
 SEGE MAIN_BIT
*______________________________________________________________________
*
 SEGS COPY_STEM_TO_MEMORY
*
   MVHHI THE_STEM_FUNCTION,21          get STEM max length + count
   SEGDO CALL_PROCSTEM
*
   ZAP   DOUB_WORD,THE_STEM_ZERO_COUNT get number of stems
   CVB   R5,DOUB_WORD
   ST    R5,TABLE_CNT                  save table count
   LR    R2,R5                         count
   MHI   R2,PCRE_LEN                   muliply by length of DSECT
   ST    R2,TABLE_LEN                  save total length of table
   STORAGE OBTAIN,LENGTH=(R2),LOC=BELOW
   ST    R1,TABLE_ADR                  save table address
   LR    R8,R1                         point to table
*
   PUSH  USING
THIS     USING PCRE_OPTIONS,R8         map DSECT with prefix
*
   ZAP   THE_STEM_ZERO_COUNT,=P'0'     tell PROCSTEM to start at first
   DO FROM=(R5)
     MVI   INPUT_VAR_TEXT,C' '         clear input variable area
     MVC   INPUT_VAR_TEXT+1(L'INPUT_VAR_TEXT-1),INPUT_VAR_TEXT
     MVHHI THE_STEM_FUNCTION,5         get stem.? next
     SEGDO CALL_PROCSTEM
*
     LA    R4,PCRE_ALL_OPTIONS         point to all valid options
     LA    R3,PCRE_ALL_OPTION_COUNT    get count of options
     DO FROM=(R3)
     DOEXIT (CLC,PCRE_OPTION,EQ,INPUT_VAR_TEXT)  option matched
       LA    R4,PCRE_NEXT
     ENDDO
     IF (LTR,R3,R3,NP)                 did not find the option
       MVI   ERR_NO,8                  not a valid option
       SEGDO NOT_VALID                 quits program
     ENDIF
     IF (CLI,PCRE_ZOS,NE,C'Z')         not available on z/OS
       MVI   ERR_NO,9                  not available of z/OS
       SEGDO NOT_VALID                 quits program
     ENDIF
     MVC   THIS.PCRE_OPTION,INPUT_VAR_TEXT
     MVC   THIS.PCRE_BITS,PCRE_BITS
     MVC   THIS.PCRE_FLAGS,PCRE_FLAGS
     LA    R8,THIS.PCRE_NEXT           point to next available slot
   ENDDO
*
   POP   USING
*
 SEGE COPY_STEM_TO_MEMORY
*______________________________________________________________________
*
 SEGS GET_THE_ARGUMENTS
*
*  first argument should be the stem name
*
   IF (CLC,ARGTABLE_ARGSTRING_PTR,EQ,=8X'FF')
     MVI   ERR_NO,1
     SEGDO NOT_VALID
   ELSEIF (CLC,ARGTABLE_ARGSTRING_LENGTH,EQ,=F'0')
     MVI   ERR_NO,2
     SEGDO NOT_VALID
   ELSEIF (CLC,ARGTABLE_ARGSTRING_LENGTH,GT,=F'20')
     MVI   ERR_NO,3                    arbitary max length
     SEGDO NOT_VALID
   ENDIF
   MVC   THE_STEM_NAME_ADR,ARGTABLE_ARGSTRING_PTR
   MVC   THE_STEM_NAME_LEN,ARGTABLE_ARGSTRING_LENGTH
*
*  see if input was 'help' in which case output all options and quit
*                    HELP
   IF (CLC,THE_STEM_NAME_LEN,EQ,=F'4')
     L     R1,THE_STEM_NAME_ADR
     MVC   INPUT_VAR_TEXT(4),0(R1)     copy parameter
     OC    INPUT_VAR_TEXT(4),SPACES    ensure uppercase
     IF (CLC,=C'HELP',EQ,INPUT_VAR_TEXT)
       SEGDO OUTPUT_ALL_VALID          output all valid
       PRGQUIT RC=0                    and quit
     ENDIF
   ENDIF
*
*  second argument should be the output variable name
*
   LA    ARG_POINT,ARGTABLE_NEXT       check for environment
   IF (CLC,ARGTABLE_ARGSTRING_PTR,EQ,=8X'FF')
     MVI   ERR_NO,4
     SEGDO NOT_VALID
   ELSEIF (CLC,ARGTABLE_ARGSTRING_LENGTH,EQ,=F'0')
     MVI   ERR_NO,5
     SEGDO NOT_VALID
   ELSEIF (CLC,ARGTABLE_ARGSTRING_LENGTH,GT,=F'20')
     MVI   ERR_NO,6                    arbitary max length
     SEGDO NOT_VALID
   ENDIF
   MVC   VAR_NAME_ADR,ARGTABLE_ARGSTRING_PTR
   MVC   VAR_NAME_LEN,ARGTABLE_ARGSTRING_LENGTH
*
   L     R14,VAR_NAME_ADR
   L     R15,VAR_NAME_LEN
   BCTR  R15,0
   MVC   VAR_NAME,SPACES
   EX    R15,COPY_VAR_NAME
   OC    VAR_NAME,SPACES               make uppercase
*
 SEGE GET_THE_ARGUMENTS
*______________________________________________________________________
*
 SEGS OUTPUT_A_VARIABLE
*
   LA    R1,=CL8'IRXEXCOM'
   ST    R1,IX_PARM
   LA    R6,PARM_AREA
   USING SHVBLOCK,R6
   MVC   SHVNEXT,=F'0'
   MVC   SHVUSER,=F'0'
   MVI   SHVCODE,SHVSTORE              store a variable
   MVC   SHVBUFL,=F'0'
   LA    R1,VAR_NAME                   name of variable
   ST    R1,SHVNAMA
   MVC   SHVNAML,VAR_NAME_LEN          variable length
*
   LA    R1,VAR_CONTENT
   ST    R1,SHVVALA                    value address
   MVC   SHVVALL,=F'8'                 value length
   LA    R1,PARM_AREA
   ST    R1,IX_PARM+12
   OI    IX_PARM+12,X'80'

   LR    R0,R10                        copy rexx environment addr
   LA    R1,IX_PARM
   USING IRXEXTE,15
   L     15,ENVBLOCK_IRXEXTE
   L     15,IRXEXCOM                   get addr of variable access
   DROP  15
   BASR  14,15                         go set the variable
*
   IF (LTR,R15,R15,NZ)
     MVC   EVALBLOCK_EVDATA(20),=CL20'Error in SET_VAR RC='
     XUNPK (R15),,EVALBLOCK_EVDATA+20
     LA    R1,30                       length of error message
     ST    R1,EVALBLOCK_EVLEN
     IF (CLC,TABLE_CNT,NE,=F'0')
       L     R3,TABLE_ADR              load table address
       L     R2,TABLE_LEN              load table total length
       STORAGE RELEASE,LENGTH=(R2),ADDR=(R3)
     ENDIF
     PRGQUIT
*
   ENDIF
*
 SEGE OUTPUT_A_VARIABLE
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
 SEGS CALL_PROCSTEM
*
   LA    R1,THE_STEM_AREA              point to PRGSTEM area INPUT
   ST    R1,MY_P_1                     save as first parm
   LA    R1,MY_PARM                    point to parameter list
   L     R15,=V(PROCSTEM)              get program address
   BASR  R14,R15                       go and set stem value
   IF (LTR,R15,R15,NZ)                 error ?
     ST    R15,R_C                     set return code
     IF (CLC,TABLE_CNT,NE,=F'0')
       L     R3,TABLE_ADR              load table address
       L     R2,TABLE_LEN              load table total length
       STORAGE RELEASE,LENGTH=(R2),ADDR=(R3)
     ENDIF
     PRGQUIT                           QUIT
   ENDIF
*
 SEGE CALL_PROCSTEM
*______________________________________________________________________
*
 SEGS NOT_VALID
*
*  an error occured so set error message as output from REXX function
*
   IF (CLI,ERR_NO,EQ,1)
     MVC   MESS_TXT(L'MESS_1),MESS_1
   ELSEIF (CLI,ERR_NO,EQ,2)
     MVC   MESS_TXT(L'MESS_2),MESS_2
   ELSEIF (CLI,ERR_NO,EQ,3)
     MVC   MESS_TXT(L'MESS_3),MESS_3
   ELSEIF (CLI,ERR_NO,EQ,4)
     MVC   MESS_TXT(L'MESS_4),MESS_4
   ELSEIF (CLI,ERR_NO,EQ,5)
     MVC   MESS_TXT(L'MESS_5),MESS_5
   ELSEIF (CLI,ERR_NO,EQ,6)
     MVC   MESS_TXT(L'MESS_6),MESS_6
   ELSEIF (CLI,ERR_NO,EQ,8)
     MVC   MESS_TXT(L'MESS_8),MESS_8
     MVC   MESS_TXT+L'MESS_8(L'INPUT_VAR_TEXT),INPUT_VAR_TEXT
   ELSEIF (CLI,ERR_NO,EQ,9)
     MVC   MESS_TXT(L'MESS_9),MESS_9
     MVC   MESS_TXT+L'MESS_9(L'INPUT_VAR_TEXT),INPUT_VAR_TEXT
   ELSEIF (CLI,ERR_NO,EQ,10)
     MVC   MESS_TXT(L'MESS_10),MESS_10
*
   ELSE    this should never happen
     MVC   MESS_TXT(L'UN_KNOWN),UN_KNOWN
     XUNPK ERR_NO,1,MESS_TXT+L'UN_KNOWN
   ENDIF
   SEGDO CALL_IRXSAY
*
   IF (CLC,TABLE_CNT,NE,=F'0')
     L     R3,TABLE_ADR                load table address
     L     R2,TABLE_LEN                load table total length
     STORAGE RELEASE,LENGTH=(R2),ADDR=(R3)
   ENDIF
   PRGQUIT RC=8
*
 SEGE NOT_VALID
*______________________________________________________________________
*
 SEGS OUTPUT_ALL_VALID
*
*  this outputs all valid options
*
   MVC   MESS_TXT(L'VAL_ID),VAL_ID
   SEGDO CALL_IRXSAY
   LA    R4,PCRE_ALL_OPTIONS
   LA    R3,PCRE_ALL_OPTION_COUNT
   DO FROM=(R3)
     IF (CLI,PCRE_ZOS,EQ,C'Z')       available on z/OS
       MVC   MESS_TXT(L'PCRE_OPTION),PCRE_OPTION
       MVC   MESS_TXT+L'PCRE_OPTION+1(L'PCRE_FLAGS),PCRE_FLAGS
       SEGDO CALL_IRXSAY
     ENDIF
     LA    R4,PCRE_NEXT
   ENDDO
*
 SEGE OUTPUT_ALL_VALID
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
     SEGDO WRITE_LOG                   write original message
     MVC   MESS_TXT(L'SAY_ERR),SAY_ERR
     XUNPK R_C,4,MESS_TXT+19
     SEGDO WRITE_LOG                   then this error message
   ENDIF
   MVI   MESS_TXT,C' '
   MVC   MESS_TXT+1(L'MESS_TXT-1),MESS_TXT
*
 SEGE CALL_IRXSAY
*______________________________________________________________________
*
 SEGS WRITE_LOG
*
*  this does WTO from MESS_TXT and then clears it to spaces
*
   WTOX
*
 SEGE WRITE_LOG
*______________________________________________________________________
*
               PRGSTAT
*
COPY_VAR_NAME  MVC   VAR_NAME(0),0(R14)
*
               PRGSTEM PREF=THE_STEM
*
SPACES   DC CL20' '
MESS_1   DC C'RXPCRE2O-001 - stem name not specified'
MESS_2   DC C'RXPCRE2O-002 - stem name length was 0'
MESS_3   DC C'RXPCRE2O-003 - stem name greater than 20 bytes'
MESS_4   DC C'RXPCRE2O-004 - variable name not specified'
MESS_5   DC C'RXPCRE2O-005 - variable name length was 0'
MESS_6   DC C'RXPCRE2O-006 - variable name greater than 20 bytes'
SAY_ERR  DC C'RXPCRE2O-007 - Return code on SAY='
MESS_8   DC C'RXPCRE2O-008 - option not valid - '
MESS_9   DC C'RXPCRE2O-009 - option not valid on z/OS - '
MESS_10  DC C'RXPCRE2O-010 - do not mix compile options with run time'
UN_KNOWN DC C'RXPCRE2O-nnn - unknown error, RC='
*
VAL_ID   DC C'Valid options are :-'
*
               LTORG
*______________________________________________________________________
*
*  the following copybook contains all possible options that can be
*  set when using PCRE2 and a DSECT which maps them.
*
         COPY  RXPC2CPY
*______________________________________________________________________
*
               PRGESTAT
               PRGEND
               END
