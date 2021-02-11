```
//***FILE 497 is from Antonio Colombo who works for Amdahl in       *   FILE 497
//*           Italy.  This file contains a working example of       *   FILE 497
//*           the LLA Fetch exit CSVLLIX1.                          *   FILE 497
//*                                                                 *   FILE 497
//*                       ANTONIO COLOMBO                           *   FILE 497
//*                       AMDAHL ITALIA S.P.A.                      *   FILE 497
//*                       VIALE BRENTA, 16/18                       *   FILE 497
//*                       I-20139 MILANO                            *   FILE 497
//*                       ITALY                                     *   FILE 497
//*                       +39(0332)786022                           *   FILE 497
//*                 OR    +39(02)574741   AMDAHL OFFICE             *   FILE 497
//*                 EMAIL ANTONIO.COLOMBO@JRC.ORG                   *   FILE 497
//*                 EMAIL AZC10@AMDAHL.COM                          *   FILE 497
//*                                                                 *   FILE 497
//*      This library contains a sample CSVLLIX1 LLA EXIT, which    *   FILE 497
//*      is used to build a table in memory to reflect usage of     *   FILE 497
//*      selected LLA modules (list contained in CSVLPGMS) by       *   FILE 497
//*      selected MVS JOBs (list contained in CSVLJOBS)             *   FILE 497
//*                                                                 *   FILE 497
//*      As seen from LLA, the EXIT always returns the same 0/0     *   FILE 497
//*      return code, so it is "transparent" to it.                 *   FILE 497
//*                                                                 *   FILE 497
//*      In case of errors in the EXIT, LLA just disables it and    *   FILE 497
//*      goes on (no harm done to anybody).                         *   FILE 497
//*                                                                 *   FILE 497
//*      The table resides in ECSA                                  *   FILE 497
//*      (no problems with virtual storage constraint)              *   FILE 497
//*      and the address of the used table is given to the user     *   FILE 497
//*      in a message to the log when the table is created.         *   FILE 497
//*                                                                 *   FILE 497
//*      A couple of programs (CSVLLLST and CSVLL1X1) can be used   *   FILE 497
//*      to list the table in memory, having its address as a       *   FILE 497
//*      PARM.  While the activation of the EXIT depends on usual   *   FILE 497
//*      LLA processing, the creation/deletion of the table is      *   FILE 497
//*      triggered by a user program, so that monitoring can be     *   FILE 497
//*      done in different periods of time, as decided by the       *   FILE 497
//*      end-users.  CSVLLACT / CSVLLDEA  do this.                  *   FILE 497
//*                                                                 *   FILE 497
//*      Member list                                                *   FILE 497
//*                                                                 *   FILE 497
//*        $$$$$DOC  the module you are reading now,                *   FILE 497
//*                  documentation                                  *   FILE 497
//*        CSVLJOBS  example of a list of jobnames to be            *   FILE 497
//*                  monitored by the EXIT                          *   FILE 497
//*        CSVLLACC  compilation   of CSVLLACT                      *   FILE 497
//*        CSVLLACJ  execution JCL of CSVLLACT                      *   FILE 497
//*        CSVLLACT  source of the USER module for activation of    *   FILE 497
//*                  the EXIT                                       *   FILE 497
//*        CSVLLAL1  sys1.parmlib member to refresh    the EXIT     *   FILE 497
//*        CSVLLAOF  sys1.parmlib member to deactiveta the EXIT     *   FILE 497
//*        CSVLLAON  sys1.parmlib member to activate   the EXIT     *   FILE 497
//*        CSVLLDEA  source of the USER module for deactivation     *   FILE 497
//*                  of the EXIT                                    *   FILE 497
//*        CSVLLDEC  compilation   of CSVLLDEA                      *   FILE 497
//*        CSVLLDEJ  execution JCL of CSVLLDEA                      *   FILE 497
//*        CSVLLIXC  compilation   of CSVLLIX1                      *   FILE 497
//*        CSVLLIX1  source of the user EXIT                        *   FILE 497
//*                  it does not need any macro (except the         *   FILE 497
//*                  system ones), and it includes (via COPY)       *   FILE 497
//*                  CSVLJOBS and CSVLPGMS                          *   FILE 497
//*        CSVLLLSC  compilation   of CSVLLLST                      *   FILE 497
//*        CSVLLLSJ  execution JCL of CSVLLLST                      *   FILE 497
//*        CSVLLLST  sample program to list usage table, in         *   FILE 497
//*                  printable form                                 *   FILE 497
//*        CSVLL1XC  compilation   of CSVLL1X1                      *   FILE 497
//*        CSVLL1XJ  execution JCL of CSVLL1X1                      *   FILE 497
//*        CSVLL1X1  sample program to list usage table, output     *   FILE 497
//*                  length 80, one result per line (useful for     *   FILE 497
//*                  later sorting via ISPF or for putting into     *   FILE 497
//*                  some EXCEL file)                               *   FILE 497
//*        CSVLPGMS  example of a list of pgms (routines) to        *   FILE 497
//*                  monitor                                        *   FILE 497
//*        CSVOUT    example of OUTPUT from CSVLL1X1                *   FILE 497
//*        J         a JOB card, used just to avoid retyping it     *   FILE 497
//*        _other_   macros needed for compilation of CSVLLLST,     *   FILE 497
//*                  CSVLL1X1                                       *   FILE 497
//*                                                                 *   FILE 497

```
