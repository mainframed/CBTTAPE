```
//***FILE 438 is from Dan Snyder of Columbus, Ohio and contains     *   FILE 438
//*           his collection of structured assembler macros that    *   FILE 438
//*           he developed for himself, over many years of coding.  *   FILE 438
//*                                                                 *   FILE 438
//*          email:   dsnyder@elektro.cmhnet.org                    *   FILE 438
//*                   Dan_Snyder@stercomm.com                       *   FILE 438
//*                                                                 *   FILE 438
//*  -------------------------------------------------------------  *   FILE 438
//*                                                                 *   FILE 438
//*                       STRUCTURED MACROS                         *   FILE 438
//*                                                                 *   FILE 438
//*  >>> - - - - - - - - - - - - - - - - - - - - - - - - - - <<<    *   FILE 438
//*  >>>  For structured macros alone, see member $$$STRUC.  <<<    *   FILE 438
//*  >>> - - - - - - - - - - - - - - - - - - - - - - - - - - <<<    *   FILE 438
//*                                                                 *   FILE 438
//*      These macros can help you create new programs and          *   FILE 438
//*      modify existing code by supporting IF-THEN-ELSE logic      *   FILE 438
//*      while requiring only a small learning curve from what      *   FILE 438
//*      you already know about S/390 Assembler (assuming that      *   FILE 438
//*      you do know it already).  Each 'IF' statement can be       *   FILE 438
//*      arbitrarily complex, and the 'IF' statements can be        *   FILE 438
//*      nested as many levels as you might need. (Certainly,       *   FILE 438
//*      no one would need more than 255 levels of nesting,         *   FILE 438
//*      would he?)                                                 *   FILE 438
//*                                                                 *   FILE 438
//*      Each group of instructions that you want conditionally     *   FILE 438
//*      executed would be headed by an 'IF' macro, and             *   FILE 438
//*      terminated by an 'ENDIF' macro.                            *   FILE 438
//*                                                                 *   FILE 438
//*      In its simplest form, the operand of the 'IF' macro        *   FILE 438
//*      consists of an op-code, the first operand address,         *   FILE 438
//*      the second operand address, and a condition. These         *   FILE 438
//*      four values must be enclosed within parentheses, and       *   FILE 438
//*      following the operands must be a comma and the             *   FILE 438
//*      statement terminating term 'THENDO'.                       *   FILE 438
//*                                                                 *   FILE 438
//*      The op-code may be any valid S/390 op-code that sets       *   FILE 438
//*      the condition code. The first and second operands may      *   FILE 438
//*      be any values that are valid for the instruction           *   FILE 438
//*      being created. The condition, such as 'E' or 'NO', is      *   FILE 438
//*      any value that can be used in creating an extended         *   FILE 438
//*      mnemonic branch instruction (such as 'BE' or 'BNO').       *   FILE 438
//*                                                                 *   FILE 438
//*      If you choose 'E' as the condition, then the group of      *   FILE 438
//*      instructions between the 'IF' and the 'ENDIF' will be      *   FILE 438
//*      executed only if the condition code set by the             *   FILE 438
//*      op-code and operands specified is a zero.                  *   FILE 438
//*                                                                 *   FILE 438
//*      In the following examples, the heading will indicate       *   FILE 438
//*      the conditions in which the do-group will be               *   FILE 438
//*      executed. In each case, an 'IF' statement determines       *   FILE 438
//*      the conditions, and an 'ENDIF' statement terminates        *   FILE 438
//*      the do-group. Comments either in the heading or on         *   FILE 438
//*      the appropriate instructions will indicate the             *   FILE 438
//*      details.                                                   *   FILE 438
//*                                                                 *   FILE 438
//*           Here is an example:                                   *   FILE 438
//*                                                                 *   FILE 438
//*             IF    (CLC,A,B,NE),THENDO                           *   FILE 438
//*                                                                 *   FILE 438
//*      The instructions between this 'IF' and its matching        *   FILE 438
//*      'ENDIF' will be executed if the result of the 'CLC'        *   FILE 438
//*      is a 1 or 2 (the not-equal condition).                     *   FILE 438
//*                                                                 *   FILE 438
//*           To execute the do-group if either one of two          *   FILE 438
//*      conditions is true, the format is:                         *   FILE 438
//*                                                                 *   FILE 438
//*           IF    (CLC,A,B,NE),OR,(CLC,C,D,NE),THENDO             *   FILE 438
//*                                                                 *   FILE 438
//*           Alternate format:                                     *   FILE 438
//*                                                        72       *   FILE 438
//*           IF    (CLC,A,B,NE),OR,                        C       *   FILE 438
//*                 (CLC,C,D,NE),THENDO                             *   FILE 438
//*                                                                 *   FILE 438
//*      (This will give you a small idea of what these macros      *   FILE 438
//*      can do.  For information about the more complicated        *   FILE 438
//*      capabilities of the structured macros in this package,     *   FILE 438
//*      please see member $$ALTDOC.)                               *   FILE 438
//*                                                                 *   FILE 438
//* --------------------------------------------------------------- *   FILE 438
//*                                                                 *   FILE 438
//*      Dan initially submitted only the structured macros         *   FILE 438
//*      that he wrote, to this tape.  He has now submitted many    *   FILE 438
//*      more macros.  Below, we see the types of macros which      *   FILE 438
//*      perform other categories of function, as well as the       *   FILE 438
//*      ones which can be used to create structured assembler      *   FILE 438
//*      programs.                                                  *   FILE 438
//*                                                                 *   FILE 438
//* --------------------------------------------------------------- *   FILE 438
//*                                                                 *   FILE 438
//*      In the following list of macros, each one is assigned to   *   FILE 438
//*      a category according to its intended use.  Most of the     *   FILE 438
//*      testing on these macros has been done in an environment    *   FILE 438
//*      called 'Version 2', or '2nd Generation'.  This             *   FILE 438
//*      environment presents a programmer with a pseudo-COBOL      *   FILE 438
//*      way of coding, and was created in the early 1990's as an   *   FILE 438
//*      aid to getting programs going faster.  The 'Version 1'     *   FILE 438
//*      or '1st Generation' environment was created in the mid     *   FILE 438
//*      1970's, and is somewhat more oriented toward Systems       *   FILE 438
//*      Programming types of programming.                          *   FILE 438
//*                                                                 *   FILE 438
//*      If a macro is listed as being 'GENERAL', or general        *   FILE 438
//*      purpose, then it is not part of either Version 1 or 2,     *   FILE 438
//*      but it might not have been tested outside one of these     *   FILE 438
//*      environments.                                              *   FILE 438
//*                                                                 *   FILE 438
//*      What follows is a description of the categories that       *   FILE 438
//*      these macros have been classified into:                    *   FILE 438
//*                                                                 *   FILE 438
//*      DIAGNOSTIC - The macro may be used in either Version 1     *   FILE 438
//*      or 2 programs, and is intended primarily as a diagnostic   *   FILE 438
//*      aid in getting the program running correctly.  Hopefully   *   FILE 438
//*      the effort expended in using one or more of these          *   FILE 438
//*      diagnostic macros will pay off in diagnosing the           *   FILE 438
//*      progress of your program.                                  *   FILE 438
//*                                                                 *   FILE 438
//*      GENERAL - Various utility macros that should provide       *   FILE 438
//*      services required for typical programs.                    *   FILE 438
//*                                                                 *   FILE 438
//*      INTERNAL - These macros are typically used as common       *   FILE 438
//*      service routines by other macros within this library.      *   FILE 438
//*      They usually provide services that would not be useful     *   FILE 438
//*      for use as open code macros (those coded within the        *   FILE 438
//*      program itself).                                           *   FILE 438
//*                                                                 *   FILE 438
//*      RUN-TIME-TOTALS - A set of general purpose macros that     *   FILE 438
//*      might make it easier to create counters that can be        *   FILE 438
//*      incremented at each of several places within a program,    *   FILE 438
//*      and then at some point during program execution            *   FILE 438
//*      (presumably during the finalization step of the            *   FILE 438
//*      program), print out all of the accumulated counts with     *   FILE 438
//*      one easy statement.                                        *   FILE 438
//*                                                                 *   FILE 438
//*      STRUCTURED - Macros that control the conditional or        *   FILE 438
//*      repetitive execution of a group of instructions            *   FILE 438
//*      following the group-initiation macro and ending with a     *   FILE 438
//*      group-terminating macro.                                   *   FILE 438
//*                                                                 *   FILE 438
//*      1st Generation - A set of macros that provice standard     *   FILE 438
//*      MVS interface and subroutine linkage conventions.          *   FILE 438
//*                                                                 *   FILE 438
//*      2nd GENERATION - Another set of MVS interface and          *   FILE 438
//*      subroutine linkage macros.                                 *   FILE 438
//*                                                                 *   FILE 438
//*      What follows is an alphabetic listing of all of the        *   FILE 438
//*      macro definitions included in the package, with its        *   FILE 438
//*      identifying macro type:                                    *   FILE 438
//*                                                                 *   FILE 438
//*                $AGOTO    INTERNAL                               *   FILE 438
//*                $ASECT    INTERNAL                               *   FILE 438
//*                $IA       INTERNAL                               *   FILE 438
//*                $MENDDO1  INTERNAL                               *   FILE 438
//*                $MENDDO2  INTERNAL                               *   FILE 438
//*                $MGBLDEF  INTERNAL                               *   FILE 438
//*                $MGFNAME  INTERNAL                               *   FILE 438
//*                $MGPNAME  INTERNAL                               *   FILE 438
//*                $WA       INTERNAL                               *   FILE 438
//*                ADDR      GENERAL                                *   FILE 438
//*                AFTER     STRUCTURED                             *   FILE 438
//*                AN        GENERAL                                *   FILE 438
//*                BEGTEST   DIAGNOSTIC                             *   FILE 438
//*                BHE       GENERAL                                *   FILE 438
//*                BLE       GENERAL                                *   FILE 438
//*                COMBOX    GENERAL                                *   FILE 438
//*                CONTINUE  GENERAL                                *   FILE 438
//*                CPYPAR$E  INTERNAL                               *   FILE 438
//*                CTE       TEXT SEARCH                            *   FILE 438
//*                CTEB      TEXT SEARCH                            *   FILE 438
//*                CVN       GENERAL                                *   FILE 438
//*                CVXREGS   DIAGNOSTIC                             *   FILE 438
//*                CVXWORD   DIAGNOSTIC                             *   FILE 438
//*                DEFPGMID  INTERNAL                               *   FILE 438
//*                DIAGMSG   INTERNAL                               *   FILE 438
//*                DISPLAY   DIAGNOSTIC                             *   FILE 438
//*                DIVISION  2ND GENERATION                         *   FILE 438
//*                DO        STRUCTURED                             *   FILE 438
//*                DTM       INTERNAL                               *   FILE 438
//*                DUMPMAIN  DIAGNOSTIC                             *   FILE 438
//*                DUMPREGS  DIAGNOSTIC                             *   FILE 438
//*                EDIT      STRUCTURED                             *   FILE 438
//*                ELSE      STRUCTURED                             *   FILE 438
//*                ELSEDO    STRUCTURED                             *   FILE 438
//*                ELSEIF    STRUCTURED                             *   FILE 438
//*                EM        GENERAL                                *   FILE 438
//*                ENDAFTER  STRUCTURED                             *   FILE 438
//*                ENDELSE   STRUCTURED                             *   FILE 438
//*                ENDFIRST  STRUCTURED                             *   FILE 438
//*                ENDIF     STRUCTURED                             *   FILE 438
//*                ENDO      STRUCTURED                             *   FILE 438
//*                ENDP      1ST GENERATION                         *   FILE 438
//*                ENDSECT   2ND GENERATION                         *   FILE 438
//*                ENDTEST   DIAGNOSTIC                             *   FILE 438
//*                EPACK     GENERAL                                *   FILE 438
//*                EQUATE    GENERAL                                *   FILE 438
//*                EUNPK     GENERAL                                *   FILE 438
//*                EVERY     STRUCTURED                             *   FILE 438
//*                EXECUTE   GENERAL                                *   FILE 438
//*                EXIT      2ND GENERATION                         *   FILE 438
//*                FINAL     2ND GENERATION                         *   FILE 438
//*                FIRST     STRUCTURED                             *   FILE 438
//*                GO        1ST GENERATION                         *   FILE 438
//*                GOBACK    2ND GENERATION                         *   FILE 438
//*                GOTO      2ND GENERATION                         *   FILE 438
//*                HEXRTN    DIAGNOSTIC (1ST GENERATION VERSION)    *   FILE 438
//*                HROUTINE  DIAGNOSTIC (2ND GENERATION VERSION)    *   FILE 438
//*                I         GENERAL                                *   FILE 438
//*                IF        STRUCTURED                             *   FILE 438
//*                IP        GENERAL                                *   FILE 438
//*                LEVELMSG  INTERNAL                               *   FILE 438
//*                MACBOX    GENERAL                                *   FILE 438
//*                NEXT      STRUCTURED                             *   FILE 438
//*                PAR$E     INTERNAL                               *   FILE 438
//*                PCALL     1ST GENERATION                         *   FILE 438
//*                PERFORM   2ND GENERATION                         *   FILE 438
//*                PRDEF     GENERAL (1ST GENERATION VERSION)       *   FILE 438
//*                PRINTER   GENERAL (2ND GENERATION VERSION)       *   FILE 438
//*                PROC      1ST GENERATION                         *   FILE 438
//*                PRTTABLE  RUN-TIME-TOTALS                        *   FILE 438
//*                RETN      1ST OR 2ND GENERATION                  *   FILE 438
//*                RTTBEG    RUN-TIME-TOTALS                        *   FILE 438
//*                RTTEND    RUN-TIME-TOTALS                        *   FILE 438
//*                RTTENT    RUN-TIME-TOTALS                        *   FILE 438
//*                RTTINCR   RUN-TIME-TOTALS                        *   FILE 438
//*                RTTPRT    RUN-TIME-TOTALS                        *   FILE 438
//*                RTTRESET  RUN-TIME-TOTALS                        *   FILE 438
//*                SECONDEP  2ND GENERATION                         *   FILE 438
//*                SECTION   2ND GENERATION                         *   FILE 438
//*                SETCSECT  INTERNAL                               *   FILE 438
//*                SETDEF    INTERNAL                               *   FILE 438
//*                SETRC     GENERAL                                *   FILE 438
//*                SETUP     INTERNAL                               *   FILE 438
//*                STOP      1ST GENERATION                         *   FILE 438
//*                SYSUT1    1ST GENERATION                         *   FILE 438
//*                SYSUT2    1ST GENERATION                         *   FILE 438
//*                TAG       GENERAL                                *   FILE 438
//*                THENDO    STRUCTURED                             *   FILE 438
//*                TRACER    DIAGNOSTIC                             *   FILE 438
//*                TRACER2   INTERNAL                               *   FILE 438
//*                TRC       DIAGNOSTIC (1ST GENERATION ONLY)       *   FILE 438
//*                TRSP      GENERAL                                *   FILE 438
//*                VAL       INTERNAL                               *   FILE 438
//*                VERSION   INTERNAL                               *   FILE 438
//*                                                                 *   FILE 438

```
