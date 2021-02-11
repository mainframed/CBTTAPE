```
//***FILE 958 is from Sam Golob and contains programs which         *   FILE 958
//*           deal with the TSO RELOGON BUFFER, or which execute    *   FILE 958
//*           a TSO command and then force a LOGOFF.  This class    *   FILE 958
//*           of programs is very interesting, and is worth some    *   FILE 958
//*           study.                                                *   FILE 958
//*                                                                 *   FILE 958
//*           email:  sbgolob@cbttape.org    or                     *   FILE 958
//*                   sbgolob@att.net                               *   FILE 958
//*                                                                 *   FILE 958
//*       Some of these programs use the TSO RELOGON BUFFER,        *   FILE 958
//*       which is similar to the TSO COMMAND BUFFER, but which     *   FILE 958
//*       is only used for LOGON/LOGOFF processing, in certain      *   FILE 958
//*       cases.  The TSO RELOGON BUFFER has the restriction that   *   FILE 958
//*       the offset of the command, in the second halfword of      *   FILE 958
//*       the buffer, has to be zero.  In other words, the command  *   FILE 958
//*       must start at the very beginning of (the command part of) *   FILE 958
//*       the buffer.                                               *   FILE 958
//*                                                                 *   FILE 958
//*       Mark Zelden's TSO* execs are included here, so you can    *   FILE 958
//*       trap the output of the SHOWRLGB command in full screen.   *   FILE 958
//*                                                                 *   FILE 958
//*           TSO TSOx SHOWRLGB      where x is E - edit            *   FILE 958
//*                                             V - view            *   FILE 958
//*                                             B - browse          *   FILE 958
//*           TSOR works in READY mode.         R - TSO REVIEW      *   FILE 958
//*                                                                 *   FILE 958
//*           REVIEW is found in CBT File 134 (source) and          *   FILE 958
//*                              CBT File 135 (load)                *   FILE 958
//*                                                                 *   FILE 958
//*       Below is a description of the programs contained here:    *   FILE 958
//*                                                                 *   FILE 958
//*       BYE       - TSO command to fill the Relogon Buffer        *   FILE 958
//*                   with any character string, set the ECTLOGF    *   FILE 958
//*                   bit on, and exit.  This is your main tool     *   FILE 958
//*                   to manipulate the TSO Relogon Buffer.         *   FILE 958
//*                   (BYE was written by "CBT Updater")            *   FILE 958
//*                                                                 *   FILE 958
//*                   Using BYE without operands will initialize    *   FILE 958
//*                   the Relogon Buffer and turn the ECTLOGF       *   FILE 958
//*                   bit off, so you can start over.               *   FILE 958
//*                                                                 *   FILE 958
//*       RELOGON   - Generate the string: LOGON userid, and put    *   FILE 958
//*                   it into the Relogon Buffer.  Set the          *   FILE 958
//*                   ECTLOGF bit on.  If the userid was defined    *   FILE 958
//*                   from SYS1.UADS, then extract the password     *   FILE 958
//*                   and generate LOGON userid/password in         *   FILE 958
//*                   the Relogon Buffer.  Needs APF authorization  *   FILE 958
//*                   to extract the password from the TSB, if      *   FILE 958
//*                   it is there.                                  *   FILE 958
//*                                                                 *   FILE 958
//*       SHOWRLGB  - TSO command to display all relevant data      *   FILE 958
//*                   concerning the Relogon Buffer.  Output can    *   FILE 958
//*                   be trapped and displayed fullscreen.          *   FILE 958
//*                                                                 *   FILE 958
//*       CMDLOFF   - TSO command to execute another TSO command    *   FILE 958
//*                   and then LOGOFF the session.                  *   FILE 958
//*                                                                 *   FILE 958
//*       NOLOGOF   - TSO command to set the ECTLOGF bit OFF, and   *   FILE 958
//*                   prevent the automatic LOGOFF in READY mode.   *   FILE 958
//*                                                                 *   FILE 958
//*       YESLOGOF  - TSO command to set the ECTLOGF bit ON, and    *   FILE 958
//*                   force the automatic LOGOFF if in READY mode.  *   FILE 958
//*                                                                 *   FILE 958

```
