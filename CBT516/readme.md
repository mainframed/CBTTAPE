```
//***FILE 516 is from Sam Golob and contains a program that is      *   FILE 516
//*           useful if you have CA-1 Tape Management System (TMS). *   FILE 516
//*           This program will call the CA-1 inquiry program       *   FILE 516
//*           called CTSQSTS for a given VOLSER and will return     *   FILE 516
//*           a code as follows (the way CTSQSTS is coded now):     *   FILE 516
//*                                                                 *   FILE 516
//*           Return Code      Interpretation                       *   FILE 516
//*                                                                 *   FILE 516
//*            0               Scratch Tape                         *   FILE 516
//*            4               Tape is not full - can be mod'ed to  *   FILE 516
//*            8               Tape is full - you can't mod to it   *   FILE 516
//*           12               Tape is Out of Service, bad or DEL   *   FILE 516
//*           16               Foreign Tape                         *   FILE 516
//*           20               CA-1 is not active                   *   FILE 516
//*                                                                 *   FILE 516
//*           You run this program (called CBRTST) against a list   *   FILE 516
//*           of VOLSERs in SYSIN, and the report tells you each    *   FILE 516
//*           volume's status, as reported by CA's program CTSQSTS. *   FILE 516
//*                                                                 *   FILE 516
//*    >>>    This program provides a quick way of testing the      *   FILE 516
//*    >>>    TMC status of a list of tape volumes.  Admittedly     *   FILE 516
//*    >>>    TMSBINQ is more thorough, but this program provides   *   FILE 516
//*    >>>    a really quick summary.  Under some circumstances,    *   FILE 516
//*    >>>    it's more useful than TMSBINQ.                        *   FILE 516
//*                                                                 *   FILE 516
//*           You can even run this program against every volume    *   FILE 516
//*           defined in your TMC.  Just copy the TMC to an FB-340  *   FILE 516
//*           dataset, copy it again to an FB-80 dataset,           *   FILE 516
//*           truncating the tails, and edit out the DSNB records   *   FILE 516
//*           at the end.  The resulting file will contain volsers  *   FILE 516
//*           in columns 1-6, and is suitable input for the CBRTST  *   FILE 516
//*           program.                                              *   FILE 516
//*                                                                 *   FILE 516
//*    The following is sample program output (squeezed together):  *   FILE 516
//*                                                                 *   FILE 516
//*    CTSQSTS - RETURN CODE TEST PROGRAM          PAGE      1      *   FILE 516
//*                                                                 *   FILE 516
//*     INPUT VOLSER = M00000   RETCODE WAS  =  12  OUT OF SERVICE  *   FILE 516
//*     INPUT VOLSER = M10000   RETCODE WAS  =   4  TAPE NOT FULL   *   FILE 516
//*     INPUT VOLSER = M10001   RETCODE WAS  =   4  TAPE NOT FULL   *   FILE 516
//*     INPUT VOLSER = M10002   RETCODE WAS  =   4  TAPE NOT FULL   *   FILE 516
//*     INPUT VOLSER = M10003   RETCODE WAS  =   8  FULL TAPE       *   FILE 516
//*     INPUT VOLSER = M10004   RETCODE WAS  =   4  TAPE NOT FULL   *   FILE 516
//*     INPUT VOLSER = M10005   RETCODE WAS  =   4  TAPE NOT FULL   *   FILE 516
//*     INPUT VOLSER = M10006   RETCODE WAS  =   0  SCRATCH TAPE    *   FILE 516
//*     INPUT VOLSER = M10007   RETCODE WAS  =   8  FULL TAPE       *   FILE 516
//*     INPUT VOLSER = M10008   RETCODE WAS  =   4  TAPE NOT FULL   *   FILE 516
//*     INPUT VOLSER = M10009   RETCODE WAS  =   4  TAPE NOT FULL   *   FILE 516
//*     INPUT VOLSER = M10010   RETCODE WAS  =   4  TAPE NOT FULL   *   FILE 516
//*     INPUT VOLSER = M10011   RETCODE WAS  =   8  FULL TAPE       *   FILE 516
//*     INPUT VOLSER = M10012   RETCODE WAS  =   8  FULL TAPE       *   FILE 516
//*     INPUT VOLSER = M10013   RETCODE WAS  =   4  TAPE NOT FULL   *   FILE 516
//*     INPUT VOLSER = M10014   RETCODE WAS  =   8  FULL TAPE       *   FILE 516
//*     INPUT VOLSER = M10015   RETCODE WAS  =   8  FULL TAPE       *   FILE 516
//*     INPUT VOLSER = CBT434   RETCODE WAS  =  16  FOREIGN TAPE    *   FILE 516
//*     INPUT VOLSER = V00000   RETCODE WAS  =  16  FOREIGN TAPE    *   FILE 516
//*     INPUT VOLSER = V00011   RETCODE WAS  =  16  FOREIGN TAPE    *   FILE 516
//*     INPUT VOLSER = V00033   RETCODE WAS  =  16  FOREIGN TAPE    *   FILE 516
//*                                                                 *   FILE 516
//* --------------------------------------------------------------- *   FILE 516
//*                                                                 *   FILE 516
//*   The TMCVLIST program will read your TMC and produce a         *   FILE 516
//*   volume list of all volumes defined in it.  The output of      *   FILE 516
//*   this TMCVLIST program is suitable input to the CBRTST         *   FILE 516
//*   program.  Member TMCVL001 is sample JCL to run TMCVLIST.      *   FILE 516
//*                                                                 *   FILE 516
//* --------------------------------------------------------------- *   FILE 516
//*                                                                 *   FILE 516
//*   Questions, contact Sam Golob:     sbgolob@attglobal.net       *   FILE 516
//*                                                                 *   FILE 516

```
