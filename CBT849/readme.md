```
//***FILE 849 is from Scott Vetter and contains a TSO command to    *   FILE 849
//*           display the TSO users currently logged on.  The       *   FILE 849
//*           original command was for MVS 3.8 (still included as   *   FILE 849
//*           member DT38).  Fixed to work on z/OS 1.12 by Sam      *   FILE 849
//*           Golob (you can compare to see the necessary changes). *   FILE 849
//*           The name of the command is DT.                        *   FILE 849
//*                                                                 *   FILE 849
//*           Member DTP (source code) created to convert terminal  *   FILE 849
//*           output of the DT program from TPUT to PUTLINE, so it  *   FILE 849
//*           can be captured and displayed in full screen mode.    *   FILE 849
//*                                                                 *   FILE 849
//*           Additional command from Scott Vetter:                 *   FILE 849
//*           DA - Display Active Address Spaces.                   *   FILE 849
//*                                                                 *   FILE 849
//*           Similar treatment to DT command:  DAP is PUTLINE      *   FILE 849
//*           adaptation of the terminal output.  DA38 is Scott's   *   FILE 849
//*           original version for MVS 3.8.  DA$ is assembly JCL.   *   FILE 849
//*                                                                 *   FILE 849
//*           REXX execs from Mark Zelden:  TSOV, TSOB, TSOE, TSOR  *   FILE 849
//*           were included here so you can have tools to capture   *   FILE 849
//*           the outputs of the DT program which was assembled     *   FILE 849
//*           from the DTP source (JCL member DT$).  Or to capture  *   FILE 849
//*           the outputs from the DAP source prpgram.  To capture  *   FILE 849
//*           output, say:  TSO TSOx DT , where x is V, B, E, R,    *   FILE 849
//*           for VIEW, BROWSE, EDIT, or REVIEW (CBT File 134)      *   FILE 849
//*           of the captured output of DT.  REVIEW will do full    *   FILE 849
//*           screen browsing (or editing) of the output while      *   FILE 849
//*           you are in TSO READY mode, even without ISPF.  (Use   *   FILE 849
//*           the UPDATE subcommand of REVIEW for ISPF-like edit.)  *   FILE 849
//*                                                                 *   FILE 849
//*           email:  svetter@ameritech.net                         *   FILE 849
//*                                                                 *   FILE 849
//*           email:  sbgolob@cbttape.org   or                      *   FILE 849
//*                   sbgolob@attglobal.net                         *   FILE 849
//*                                                                 *   FILE 849

```
