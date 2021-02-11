     This is my contribution to CBT. I like the idea behind CBT and
     like to say a big "Thank you" to Sam Golob for his support and
     Gilbert Saint-Flour for giving me access to his P/390.

     A big "Thank you" to Tom Ross from IBM helping in order to
     get the Enterprise Cobol stuff working or other questions.

     It is distributed on an as is, where is basis, without expressed
     or implied warranty of any kind. It is distributed in hope that
     it may save other members of the project some wheel re-inventing.

     A big "Thank you" to Steve Stocker from CSC for his
     enhancements.

     Regards
     Roland Schiradin (November 2007)
     home: Roland@schiradin.de


     ------------------- Index           ---------------------

     COBANAL   Frozen version, only bug-fixes
               This version support pre OS/390 R10

               Last Change: April 2002

     COBANALJ  A sample JCL to assemble CobAnal or CobAnalZ

               Last Change: November 2002

     COBANALZ  This Program analyze your Cobol-Load-Modules.
               There is no need for the source. Support
               for single programs also for a complete load-lib.
               This program require the STRING macro from FILE183.
               I have include the current versions of STRING
               Thanks to Gilbert Saint-Flour

               Full support for Enterprise Cobol V3
               Full support for COBOL for OS/390 & VM V2
               Full support for COBOL for OS/390 & VM V1
               Full support for COBOL for MVS and VM formally called
               COBOL/370 or ADCYLE COBOl/370.
               Full support for COBOL-II every version.
               Few support for COBOL-1.

               If you have old or newer Cobol-Programs please
               send me the Load to Roland(at)Schiradin.de. I'll
               add some code to support these Cobol-Versions.

               If you like to get the newest Version please contact
               Roland(at)Schiradin.de

               You can find a nice ISPF interface for CobAnal on
               CBT File 330

               Last Change: Apr 2016

     COBJCL    A sample JCL for COBANAL

               Last Change: November 2006

     EXCIJCL   Sample JCL to invoke the CICS-Batch-Interface

               Last Change: March 1999

     EXCIRDO   CSD for CICS 4.1 and higher

               Last Change: March 1999

     EXCI      The CEMT-Batch-Interface written in Cobol
               Note: You need the EXCI-Stub (DFHEXLI) in your
               BIND-Job !!!! Please specify EXCI and COBOL3 as
               the precompiler option.

               Last Change: March 1999

     EXCISE    The CICS-Server-Program written in Assembler.
               Please expand the program to your needs.

               Last Change: March 1999

     PIDTABLE  Copybook for COBANALZ

               Last Change: July 2008

     STCCHECK  This program check if a started Task is allready
               active. This avoid abend U1800 if a operator
               start the same CICS again. Please note this works
               only on the same MVS-image, I'll add somtimes
               code to check the SYSPLEX.

               //*******************  EXECUTE CICS
               //*****************************************
               //STCCHECK EXEC PGM=STCCHECK,PARM='DCCA201'
               //SYSPRINT  DD SYSOUT=*
               //SYSUDUMP  DD SYSOUT=D
               //*****************************************
               //DCCSTRT IF (STCCHECK.RC = 0) THEN
               //DCCA201 EXEC PROC=DCICSA
               //EDCCSTRT ENDIF

               rc = 0   DCCA201 is not active
               rc not 0 DCCA201 is active

               Last Change: March 1998

     STRING    Provides functions similar to PL/I's
               PUT EDIT or COBOL's STRING.

               Taken from FILE183.

     STRING64  Provides functions similar to PL/I's
               PUT EDIT or COBOL's STRING.
               Partial 64bit support

     SYEXCIC   Cobol-Source to invoke the CEDA INSTALL from Batch

               Last Change: March 1996

     SYEXCIS   Assembler-Source to invoke the CEDA INSTALL

               Last Change: March 1996
     --------------------------------------------------------

