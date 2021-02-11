```
//***FILE 819 is from Terry Miller, and contains the REXX code      *   FILE 819
//*         for the "ICH" RACF exit update facility.  The package   *   FILE 819
//*         is used to update a RACF exit without having to         *   FILE 819
//*         perform an IPL.  Authorized functions are performed     *   FILE 819
//*         by the authorized Assembler program called ICHLOADR     *   FILE 819
//*         which has to be in your IKJEFTE8 (authpgm) table.       *   FILE 819
//*                                                                 *   FILE 819
//*         It is, in essence, a RACF exit UPDATE/DELETE/REMOVE/    *   FILE 819
//*         REPOINT Facility.                                       *   FILE 819
//*                                                                 *   FILE 819
//*           email:  tkmille@conocophillips.com                    *   FILE 819
//*                                                                 *   FILE 819
//*  LAST UPDATE: 01/21/2010  Version 01.01.01                      *   FILE 819
//*                           Terry Miller                          *   FILE 819
//*                           ConocoPhillips                        *   FILE 819
//*                           tkmille@ConocoPhillips.com            *   FILE 819
//*                                                                 *   FILE 819
//*  MODIFICATION LEVEL: V01.01.01                                  *   FILE 819
//*                                                                 *   FILE 819
//*  * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  *   FILE 819
//*                                                                 *   FILE 819
//*  This program was written to provide the capability to          *   FILE 819
//*  dynamically UPDATE, DELETE, REMOVE, and REPOINT RACF Exits     *   FILE 819
//*  without having to IPL.  It also updates the RCVT pointer (RACF *   FILE 819
//*  Communication Vector Table) for the exit to repoint RACF       *   FILE 819
//*  (Security Server) to use the updated exit in dynamic           *   FILE 819
//*  LPA (CSA) storage.                                             *   FILE 819
//*                                                                 *   FILE 819
//*  It has four Functions: UPDATE, DELETE, REMOVE, and REPOINT.    *   FILE 819
//*                                                                 *   FILE 819
//*  Exec 'ICH' calls program ICHLOADR to UPDATE the module in      *   FILE 819
//*  dynamic LPA (CSA) storage and to repoint the RCVT to the new   *   FILE 819
//*  exit entry point.                                              *   FILE 819
//*  (Does the same function as the SETPROG LPA,ADD MVS command     *   FILE 819
//*  except that it also updates the RACF RCVT pointer which        *   FILE 819
//*  points to the updated version of the exit in LPA (CSA)         *   FILE 819
//*  storage.)                                                      *   FILE 819
//*                                                                 *   FILE 819
//*  It can also be used to DELETE a dynamically loaded RACF Exit   *   FILE 819
//*  from dynamic LPA (CSA) storage and to unpoint (zero) the       *   FILE 819
//*  RACF RCVT pointer to it to indicate to RACF that the current   *   FILE 819
//*  exit is no longer in RACF service.                             *   FILE 819
//*  (Does the same function as the SETPROG LPA,DELETE MVS command  *   FILE 819
//*  except that it also unpoints the exit from RACF.)              *   FILE 819
//*  Therefore, since the RCVT pointer is zeroed, it must be        *   FILE 819
//*  repointed by issuing a subsequent UPDATE or REPOINT function   *   FILE 819
//*  to put it back into service.)                                  *   FILE 819
//*                                                                 *   FILE 819
//*  It can also be used to REMOVE (unpoint) a RACF exit to take    *   FILE 819
//*  the exit out of RACF service without affecting the exit in     *   FILE 819
//*  LPA storage.  The exit will remain out of service for RACF     *   FILE 819
//*  until the next IPL or until the next dynamic update or         *   FILE 819
//*  until the next REPOINT function is issued.                     *   FILE 819
//*                                                                 *   FILE 819
//*  It can also be used to REPOINT a RACF exit to put the latest   *   FILE 819
//*  version of a RACF Exit back into RACF service without          *   FILE 819
//*  affecting the exit in LPA storage.                             *   FILE 819
//*  This function is the opposite of the REMOVE function and       *   FILE 819
//*  can be used subsequent to issuing the REMOVE function to       *   FILE 819
//*  put an exit back into service.                                 *   FILE 819
//*                                                                 *   FILE 819
//*                                                                 *   FILE 819
//*  ASSUMPTIONS:                                                   *   FILE 819
//*  ------------                                                   *   FILE 819
//*                                                                 *   FILE 819
//*  This exec only provides the RCVT pointer address for the       *   FILE 819
//*  following RACF exits:                                          *   FILE 819
//*                                                                 *   FILE 819
//*  ICHAUTAB                                                       *   FILE 819
//*  ICHCNX00                                                       *   FILE 819
//*  ICHDEX01                                                       *   FILE 819
//*  ICHDEX11                                                       *   FILE 819
//*  ICHNCV00                                                       *   FILE 819
//*  ICHPWX01                                                       *   FILE 819
//*  ICHPWX11                                                       *   FILE 819
//*  ICHRCX01                                                       *   FILE 819
//*  ICHRCX02                                                       *   FILE 819
//*  ICHRDX01                                                       *   FILE 819
//*  ICHRDX02                                                       *   FILE 819
//*  ICHRFX01                                                       *   FILE 819
//*  ICHRFX02                                                       *   FILE 819
//*  ICHRFX03                                                       *   FILE 819
//*  ICHRFX04                                                       *   FILE 819
//*  ICHRIN03                                                       *   FILE 819
//*  ICHRIX01                                                       *   FILE 819
//*  ICHRIX02                                                       *   FILE 819
//*  ICHRLX01                                                       *   FILE 819
//*  ICHRLX02                                                       *   FILE 819
//*                                                                 *   FILE 819
//*  Please report any bugs to Terry Miller at ConocoPhillips.      *   FILE 819
//*  Email: tkmille@ConocoPhillips.com                              *   FILE 819
//*                                                                 *   FILE 819
//*  DESCRIPTION OF PDS MEMBERS:                                    *   FILE 819
//*  ---------------------------                                    *   FILE 819
//*                                                                 *   FILE 819
//*    $CHANGES - Change Log of the 'ICH' facility                  *   FILE 819
//*    $$DOC    - 'ICH' facility 'README' file                      *   FILE 819
//*    $INSTALL - Installation steps to install the 'ICH' facility  *   FILE 819
//*    ICH      - Rexx exec to invoke the 'ICH' facility            *   FILE 819
//*               (this exec calls program 'ICHLOADR')              *   FILE 819
//*    ICHLOADR - Program to update a RACF module in LPA.           *   FILE 819
//*    ASSEM    - JCL to assemble program 'ICHLOADR'.               *   FILE 819
//*    HELPICH  - Help documentation for exec 'ICH'                 *   FILE 819
//*               (this is the SYSHELP member for the 'ICH' exec)   *   FILE 819
//*    $OBJECT  - Object deck of program 'ICHLOADR'                 *   FILE 819
//*    LINKEDIT - JCL to link-edit program 'ICHLOADR' from the      *   FILE 819
//*               object deck (member $OBJECT).                     *   FILE 819
//*    COPYHELP - Help member install jcl to copy to SYSHELP file.  *   FILE 819
//*    PROGCNTL - JCL to program-control security-protect           *   FILE 819
//*               program 'ICHLOADR'.                               *   FILE 819
//*    HELPICH  - Help documentation member for exec 'ICH'          *   FILE 819
//*    SAMPDISP - Sample displays from the 'ICH' exec.              *   FILE 819
//*                                                                 *   FILE 819
//*                                                                 *   FILE 819
//*  DISCLAIMER OF LIABILITY:                                       *   FILE 819
//*  ------------------------                                       *   FILE 819
//*                                                                 *   FILE 819
//*                      DISCLAIMER                                 *   FILE 819
//*                                                                 *   FILE 819
//*  Terry Miller and ConocoPhillips neither expresses nor implies  *   FILE 819
//*  any warranty as to the fitness of this ICH facility.           *   FILE 819
//*  The use of this facility and the results therefrom is entirely *   FILE 819
//*  at the risk of the user.  Consequently, the user may modify    *   FILE 819
//*  these programs in any way he/she thinks fit.                   *   FILE 819
//*                                                                 *   FILE 819
//*  All disclaimers that apply to CBT programs as described in     *   FILE 819
//*  the "Disclaimer Section" of File 001 of the CBT Tape Doc       *   FILE 819
//*  and on www.cbttape.org also apply to this package.             *   FILE 819
//*  (SBG - 01/2010)                                                *   FILE 819
//*                                                                 *   FILE 819
//*  INSTALLATION TAILORING/CUSTOMIZATION:                          *   FILE 819
//*  -------------------------------------                          *   FILE 819
//*                                                                 *   FILE 819
//*  Installation change to REXX exec 'ICH':                        *   FILE 819
//*                                                                 *   FILE 819
//*  You must change the loadlib name which contains the ICHLOADR   *   FILE 819
//*  program in the CALL command.  Edit exec 'ICH' and then         *   FILE 819
//*  issue a FIND for the eyecatcher text "<= CHANGE LOADLIB".      *   FILE 819
//*                                                                 *   FILE 819
//*  AUTHORIZATION:                                                 *   FILE 819
//*  --------------                                                 *   FILE 819
//*                                                                 *   FILE 819
//*  Program ICHLOADR must reside in an APF-Authorized libary       *   FILE 819
//*  and be linked as an authorized module.                         *   FILE 819
//*                                                                 *   FILE 819
//*  The Load Library containing the RACF Exit to fetch for the     *   FILE 819
//*  LPA Update must also be in the APF List.  Normally, this       *   FILE 819
//*  Loadlib would be SYS1.LPALIB (this is the default load         *   FILE 819
//*  library if not specified when the ICH REXX exec is invoked),   *   FILE 819
//*  but it can be overridden with the DA(dsname) parm when ICH     *   FILE 819
//*  is invoked.                                                    *   FILE 819
//*                                                                 *   FILE 819
//*  Program ICHLOADR must reside in the IKJTSOxx 'Authorized       *   FILE 819
//*  program names' table.                                          *   FILE 819
//*                                                                 *   FILE 819
//*  Program ICHLOADR should only be called by REXX Exec 'ICH'      *   FILE 819
//*  to guarantee that an accurate RCVT offset value is being       *   FILE 819
//*  processed.  Therefore, a token is passed from Exec 'ICH'       *   FILE 819
//*  as a parameter to prevent an unauthorzied call to program      *   FILE 819
//*  ICHLOADR.                                                      *   FILE 819
//*                                                                 *   FILE 819
//*  It is therefore incumbent upon users to carefully maintain     *   FILE 819
//*  and security-protect the RCVT offset table which is            *   FILE 819
//*  hard-coded in Exec 'ICH'.                                      *   FILE 819
//*                                                                 *   FILE 819
//*  It is HIGHLY recommended that program ICHLOADR be              *   FILE 819
//*  program-control protectsd to prevent unauthorized users        *   FILE 819
//*  from executing it.  This might be helpful for auditors         *   FILE 819
//*  checking this program as well.                                 *   FILE 819
//*                                                                 *   FILE 819
//*  Program 'ICHLOADR' was named with the 'ICH' prefix to show     *   FILE 819
//*  that it is related to RACF activity.                           *   FILE 819
//*  The author realizes that someday IBM may release a version     *   FILE 819
//*  of RACF (or SECURITY SERVER product) which contains a          *   FILE 819
//*  program called 'ICHLOADR', but I will cross that               *   FILE 819
//*  maintenance bridge when it happens.                            *   FILE 819
//*                                                                 *   FILE 819
//*  CERTIFICATION                                                  *   FILE 819
//*  -------------                                                  *   FILE 819
//*                                                                 *   FILE 819
//*  Program ICHLOADR is certified for Z/OS 1.1 and higher.         *   FILE 819
//*                                                                 *   FILE 819
//*  PROBLEM REPORTING                                              *   FILE 819
//*  -----------------                                              *   FILE 819
//*                                                                 *   FILE 819
//*  Please report any bugs or suggestions for improvement to:      *   FILE 819
//*         Terry Miller at email: Tkmille@ConocoPhillips.com       *   FILE 819
//*                                                                 *   FILE 819
//* ICH EXEC SYNTAX                                                 *   FILE 819
//* ---------------                                                 *   FILE 819
//*                                                                 *   FILE 819
//* INVOCATION SYNTAX:                                              *   FILE 819
//*                                                                 *   FILE 819
//*    ICH ?                                                        *   FILE 819
//*    ICH membername Ý UPDATE | DELETE | REMOVE | REPOINT ¨        *   FILE 819
//*                   Ý DA(dsname)               ¨                  *   FILE 819
//*                   Ý TEST | SIMULATE          ¨                  *   FILE 819
//*                   Ý DEBUG                    ¨                  *   FILE 819
//*                                                                 *   FILE 819
//*                                                                 *   FILE 819
//* EXAMPLE INVOCATION DISPLAY FROM EXEC 'ICH'                      *   FILE 819
//* ------------------------------------------                      *   FILE 819
//*                                                                 *   FILE 819
//* %ICH  ICHRCX02 UPDATE                                           *   FILE 819
//*                                                                 *   FILE 819
//* ************************* Top of Data ************************* *   FILE 819
//*                                                                 *   FILE 819
//* 2010.015         III   CCCC H   H     DYNAMIC RACF      Friday  *   FILE 819
//* 14:40:00          I   C     H   H     EXIT UPDATE    January 15 *   FILE 819
//*                   I   C     HHHHH     ASSISTANCE FOR      SYT   *   FILE 819
//* IPL Date:         I   C     H   H      MODULE          AD81/SYT *   FILE 819
//* 01/15/2010.015   III   CCCC H   H     ICHRCX02                  *   FILE 819
//*                                                                 *   FILE 819
//*                                                                 *   FILE 819
//* ICH      - Module      = ICHRCX02                               *   FILE 819
//* ICH      - Dsname      = SYS1.LPALIB                            *   FILE 819
//* ICH      - Function    = UPDATE                                 *   FILE 819
//* ICH      - RCVT Offset = 000000A4                               *   FILE 819
//* ICH      - Test Parm   =                                        *   FILE 819
//*                                                                 *   FILE 819
//* ICHLOADR - V01.01.01 2010.015 14:40:00                          *   FILE 819
//*                                                                 *   FILE 819
//* ICHLOADR - UPDATE   FUNCTION IS BEING PROCESSED.                *   FILE 819
//*                                                                 *   FILE 819
//* ICHLOADR - RACF EXIT MODULE IS ICHRCX02                         *   FILE 819
//*                                                                 *   FILE 819
//* ICHLOADR - LOADLIB DATASET IS SYS1.LPALIB                       *   FILE 819
//*                                                                 *   FILE 819
//* ICHLOADR - LPA UPDATE SUCCESSFUL FOR MODULE ICHRCX02            *   FILE 819
//*                                                                 *   FILE 819
//* ICHLOADR - OLD EP ADDRESS: 8589C8B8  NEW EP ADDRESS: BA4DE000   *   FILE 819
//*                                                                 *   FILE 819
//* ICHLOADR - EXIT ICHRCX02 RCVT POINTER ADDRESS: 00FB779C         *   FILE 819
//*                                                                 *   FILE 819
//* ICHLOADR - EXIT ICHRCX02 RCVT POINTER OFFSET:  000000A4         *   FILE 819
//*                                                                 *   FILE 819
//* ICHLOADR - EXIT ICHRCX02 WAS UPDATED AND REPOINTED SUCCESSFULLY.*   FILE 819
//*                                                                 *   FILE 819
//* ICHLOADR - RETURN CODE = 0                                      *   FILE 819
//*                                                                 *   FILE 819
//*                                                                 *   FILE 819
//* **************************** Bottom of Data ******************* *   FILE 819
//*                                                                 *   FILE 819

```
