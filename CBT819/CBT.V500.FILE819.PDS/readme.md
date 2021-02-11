
## $$DOC.txt
```
 LAST UPDATE: 01/21/2010  Version 01.01.01
                          Terry Miller
                          ConocoPhillips
                          tkmille@ConocoPhillips.com

 MODIFICATION LEVEL: V01.01.01

 This PDS contains the Rexx code for the 'ICH' RACF exit update
 facility.  It is used to update a RACF exit without having
 to perform an IPL.  It is, in essence, a RACF Exit
 UPDATE/DELETE/REMOVE/REPOINT 'ICH' facility.

 This program was written to provide the capability to
 dynamically UPDATE, DELETE, REMOVE and REPOINT RACF Exits
 without having to IPL a system.  It also updates the RCVT
 pointer (RACF Communication Vector Table) for the exit to
 point RACF (Communications Server) to use the updated exit in
 dynamic LPA (CSA) storage.

 It has four Functions: UPDATE, DELETE, REMOVE, and REPOINT.

 Exec 'ICH' calls program ICHLOADR to UPDATE the module in dynamic
 LPA (CSA) storage and to repoint the RCVT to the new exit entry
 point.
 This is the same function as the SETPROG LPA,ADD MVS command
 except that it also updates the RACF RCVT pointer to point
 to the update version of the module.

 It can also be used to DELETE a dynamically loaded RACF Exit
 from CSA storage and uppoint (zero) the RCVT pointer to it to
 indicate to RACF that the current dynamically-installed exit is
 not in service anymore.
 (This is the same function as the SETPROG LPA,DELETE MVS command
 except that it also unpoints (zeros) the RACF RCVT pointer.)
 Therefore, since the RCVT pointer is zeroed, it must repointed
 by issuing a subsequent UPDATE function to put it back into
 service.

 It can also be used to REMOVE (unpoint) a RACF exit to take the
 exit out of RACF service without touching the exit in LPA
 storage. The exit will remain out of RACF service until the
 next IPL or until the next dynamic update, or until the next
 REPOINT function is issued.

 It can also be used to REPOINT a RACF exit to put the exit back
 into RACF service without affecting the exit in LPA storage.
 storage.  This function is the opposite of the REMOVE function
 and can be used subsequent to issuing the REMOVE function
 to put an exit back into service.


 ASSUMPTIONS:
 ------------

 This exec only provides the RACF RCVT pointer address for the
 following RACF exits:

 ICHAUTAB
 ICHCNX00
 ICHDEX01
 ICHDEX11
 ICHNCV00
 ICHPWX01
 ICHPWX11
 ICHRCX01
 ICHRCX02
 ICHRDX01
 ICHRDX02
 ICHRFX01
 ICHRFX02
 ICHRFX03
 ICHRFX04
 ICHRIN03
 ICHRIX01
 ICHRIX02
 ICHRLX01
 ICHRLX02


 Please report any bugs to Terry Miller at tkmille@ConocoPhillips.com

 DESCRIPTION OF PDS MEMBERS:
 ---------------------------

   $CHANGES - Change Log of the 'ICH' facility                 ADR'
   $$DOC    - 'ICH' facility 'README' file
   $INSTALL - Installation steps to install the 'ICH' facility
   ICH      - Rexx exec to invoke the 'ICH' facility
              (this exec calls program 'ICHLOADR')
   ICHLOADR - Program to update a RACF module in LPA.
   ASSEM    - JCL to assemble program 'ICHLOADR'.
   HELPICH  - Help documentation for exec 'ICH'
              (this is the SYSHELP member for the 'ICH' exec)
   $OBJECT  - Object deck of program 'ICHLOADR'
   LINKEDIT - JCL to link-edit program 'ICHLOADR' from the
              object deck (member $OBJECT).
   COPYHELP - Help member install jcl to copy to SYSHELP file.
   PROGCNTL - JCL to program-control security-protect
              program 'ICHLOADR'.
   HELPICH  - Help documentation member for exec 'ICH'
   SAMPDISP - Sample displays from the 'ICH' exec.


 DISCLAIMER OF LIABILITY:
 ------------------------

                     DISCLAIMER

 Terry Miller and ConocoPhillips neither expresses nor implies
 any warranty as to the fitness of this ICH facility.
 The use of this facility and the results therefrom is entirely
 at the risk of the user.  Consequently, the user may modify
 these programs in any way he/she thinks fit.

 All disclaimers that apply to CBT programs as described in
 the "Disclaimer Section" of File 001 of the CBT Tape Doc
 and on www.cbttape.org also apply to this package.
 (SBG - 01/2010)

 INSTALLATION TAILORING/CUSTOMIZATION:
 -------------------------------------

 Installation change to Rexx exec 'ICH':

 You must change the loadlib name which contains the ICHLOADR
 program in the CALL command.  Edit exec 'ICH' and then
 issue a FIND for the eyecatcher text "<= CHANGE LOADLIB".


 AUTHORIZATION:
 --------------

 Program ICHLOADR must reside in an APF-Authorized libary
 and must be linked as an authorized module.

 The Load Library containing the RACF Exit to fetch for the
 LPA Update must also be in the APF List.  Normally, this
 Loadlib would be SYS1.LPALIB (this is the default load
 library if not specified when the ICH REXX exec is invoked),
 but it can be overridden with the DA(dsname) parm when ICH
 is invoked.

 Program ICHLOADR must reside in the IKJTSOxx 'Authorized
 program names' table.

 Program ICHLOADR should only be called by Rexx Exec 'ICH'
 to guarantee that an accurate RCVT offset value is being
 processed.  Therefore, a token is passed from Exec 'ICH'
 as a parameter to prevent and unauthorzied call to program
 ICHLOADR.

 It is therefore incumbent upon users to carefully guard and
 security-protect the 'ICH' exec which has the RCVT table
 offsets hard-coded within it.

 It is HIGHLY recommended that program ICHLOADR be
 program-control protectsd to prevent unauthorized users
 from executing it.  This might be helpful for auditors
 checking this program as well.

 Program 'ICHLOADR' was named with the 'ICH' prefix to show
 that it is related to RACF activity.
 The author realizes that someday IBM may release a version
 of RACF (or SECURITY SERVER product) which contains a
 program called 'ICHLOADR', but I will cross that
 maintenance bridge when it happens.

 CERTIFICATION
 -------------

 Program ICHLOADR is certified for Z/oS 1.1 and higher.

 PROBLEM REPORTING
 -----------------

 Please report any bugs or suggestions for improvement to:
        Terry Miller at email: Tkmille@ConocoPhillips.com


 ICH EXEC SYNTAX
 ---------------

    INVOCATION SYNTAX:

       ICH ?
       ICH membername [ UPDATE | DELETE | REMOVE | REPOINT ]
                      [ DA(dsname)               ]
                      [ TEST | SIMULATE          ]
                      [ DEBUG                    ]

       Where membername is one of the following RACF User Exits:

        ICHAUTAB
        ICHCNX00
        ICHDEX01
        ICHDEX11
        ICHNCV00
        ICHPWX01
        ICHPWX11
        ICHRCX01
        ICHRCX02
        ICHRDX01
        ICHRDX02
        ICHRFX01
        ICHRFX02
        ICHRFX03
        ICHRFX04
        ICHRIN03
        ICHRIX01
        ICHRIX02
        ICHRLX01
        ICHRLX02


 SAMPLE INVOCATIONS OF EXEC ICH:
 -------------------------------

       ICH ?
       ICH membername                    (Prompts for Function)
       ICH membername UPDATE
       ICH membername DA(dsname)
       ICH membername DA(dsname) UPDATE
       ICH membername UPDATE DA(dsname)
       ICH membername UPDATE TEST
       ICH membername UPDATE SIMULATE
       ICH membername UPDATE DA(dsname) TEST
       ICH membername UPDATE DA(dsname) SIMULATE (same as previous)
       ICH membername DELETE
       ICH membername DELETE TEST
       ICH membername DELETE SIMULATE
       ICH membername REMOVE
       ICH membername REMOVE TEST
       ICH membername REMOVE SIMULATE
       ICH membername REPOINT
       ICH membername REPOINT TEST
       ICH membername REPOINT SIMULATE

 RETURN CODES:
 -------------

         0  - Successful Call to ICHLOADR
         8  - Program ICHLOADR is not APF-Authorized
         9  - CSVQUERY for Exit Module failed prior to CSVDYLPA call
        10  - CSVQUERY for Exit Module failed after CSVDYLPA call
        11  - Entry Point Address did not change after CSVDYLPA call
        12  - Miscellaneous Errors


 EXAMPLE INVOCATION DISPLAY FROM EXEC 'ICH'
 ------------------------------------------

 %ICH  ICHRCX02 UPDATE

 **************************** Top of Data ******************************

    2010.015         III   CCCC H   H     DYNAMIC RACF          Friday
    14:40:00          I   C     H   H     EXIT UPDATE         January 15
                      I   C     HHHHH     ASSISTANCE FOR           SYT
    IPL Date:         I   C     H   H      MODULE               AD81/SYT
  01/15/2010.015     III   CCCC H   H     ICHRCX02


 ICH      - Module      = ICHRCX02
 ICH      - Dsname      = SYS1.LPALIB
 ICH      - Function    = UPDATE
 ICH      - RCVT Offset = 000000A4
 ICH      - Test Parm   =

 ICHLOADR - V01.01.01 2010.015 14:40:00

 ICHLOADR - UPDATE   FUNCTION IS BEING PROCESSED.

 ICHLOADR - RACF EXIT MODULE IS ICHRCX02

 ICHLOADR - LOADLIB DATASET IS SYS1.LPALIB

 ICHLOADR - LPA UPDATE SUCCESSFUL FOR MODULE ICHRCX02

 ICHLOADR - OLD EP ADDRESS: 8589C8B8  NEW EP ADDRESS: BA4DE000

 ICHLOADR - EXIT ICHRCX02 RCVT POINTER ADDRESS: 00FB779C

 ICHLOADR - EXIT ICHRCX02 RCVT POINTER OFFSET:  000000A4

 ICHLOADR - EXIT ICHRCX02 WAS UPDATED AND REPOINTED SUCCESSFULLY.

 ICHLOADR - RETURN CODE = 0


 **************************** Bottom of Data ***************************

```

