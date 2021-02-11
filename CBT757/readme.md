```
//***FILE 757 is from Kenneth Fitzgerald and contains source and    *   FILE 757
//*           doc for a system to teach Assembler Language to       *   FILE 757
//*           college students and other beginners.  This system    *   FILE 757
//*           is called LOGGRASM.  From the looks of it, it might   *   FILE 757
//*           be helpful for the rest of us, too.                   *   FILE 757
//*                                                                 *   FILE 757
//*           email:  khf00@sbcglobal.net                           *   FILE 757
//*                                                                 *   FILE 757
//*    (1)Description:                                              *   FILE 757
//*       ------------                                              *   FILE 757
//*                                                                 *   FILE 757
//*       LOGGRASM is a utility to perform basic source setup       *   FILE 757
//*       of an Assembler program, and to log basic information     *   FILE 757
//*       about an Assembler program during execution.  This        *   FILE 757
//*       utility provides a method to show program execution       *   FILE 757
//*       in Assembler language programs.  The log information      *   FILE 757
//*       is written to a data set using QSAM.  LOGGRASM is for     *   FILE 757
//*       use in an Assembler batch program.  It can run as         *   FILE 757
//*       authorized or as non-authorized, though it uses no        *   FILE 757
//*       authorized services.  LOGGRASM is a basic tool to         *   FILE 757
//*       assist students and new programmers learning              *   FILE 757
//*       Assembler on the mainframe.                               *   FILE 757
//*                                                                 *   FILE 757
//*    (2)Prerequisites:                                            *   FILE 757
//*       -------------                                             *   FILE 757
//*                                                                 *   FILE 757
//*       Students need a basic working knowledge of a z/OS         *   FILE 757
//*       environment, and a basic knowledge of TSO/ISPF            *   FILE 757
//*       Editor commands, and know some JCL (e.g., Job             *   FILE 757
//*       Control Language).  You should have some introductory     *   FILE 757
//*       programming skills in Assembler.  You need access to      *   FILE 757
//*       a z/OS system, and be able to logon under TSO.            *   FILE 757
//*                                                                 *   FILE 757
//*    (3)Input:                                                    *   FILE 757
//*       ------                                                    *   FILE 757
//*                                                                 *   FILE 757
//*       LOGGRASM uses input control cards from the //LGRSYSIN     *   FILE 757
//*       DD for directing the processing of Logger Services        *   FILE 757
//*       during execution of a user program.                       *   FILE 757
//*                                                                 *   FILE 757
//*    (4)Output:                                                   *   FILE 757
//*       -------                                                   *   FILE 757
//*                                                                 *   FILE 757
//*       LOGGRASM writes its output to a QSAM DCB with             *   FILE 757
//*       RECFM=FBA and LRECL=133 when a //LGRECOUT DD is           *   FILE 757
//*       present in the JCL.  LOGGRASM output is in mixed          *   FILE 757
//*       case.                                                     *   FILE 757
//*                                                                 *   FILE 757

```
