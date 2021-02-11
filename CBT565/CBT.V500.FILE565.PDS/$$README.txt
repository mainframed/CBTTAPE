************************************************************************
* File 565 is a set of three libraries containing classes on the c     *
* programming language, COBOL, and Abend-Aid dump reading. The classes *
* are not intended for self study, although it may be possible for a   *
* person to learn from the materials without an instructor. The classes*
* are intended for use by the presenter of the class, who would review *
* and modify the materials for his environment and needs.              *
*                                                                      *
* All members in each of the three libraries are described below.      *
************************************************************************
************************************************************************
* CCLASS: the C Language class library. This class is intended for use *
*         with a C Language compiler/editor/development environment on *
*         a PC, and specifically uses the Borland Turbo-C product,     *
*         which was inexpensive, powerful, and easy to use when the    *
*         course was developed.                                        *
************************************************************************
BINSRCH   Sample C subroutine for searching a sequential file binarily.
CIRCLE    Sample C main program to compute diameter, area given radius.
CONGRATS  Text for a congratulations letter to students on completion.
CONTENTS  Text for the table of contents for the course.
CRITIQUE  Text for a course critique to be filled out by students.
DUMPHEX   Sample C main program to print a file in hex and character.
GENLDAT2  Sample C subroutine to perform date reformatting.
HANDBOOK  Text of the primary handout for the students for the course.
HELLO2    Sample C main program: the traditional "Hello World!" program.
KEYVALU   Sample C program to display the hex value for a keypress.
LOADSTRG  Sample C main program to read/display strings.
MENU10    Sample C main program to display a menu and obtain a request.
SKELETON  Sample C program that can be used to develop a new program.
STRUCT9   Sample C code to demonstrate use os structures and unions.
SYLLABUS  Text for a course syllabus.
TEMPCONV  Sample C main program to convert temperatures F to/from C.
VER2EDIT  Text describing Turbo-C Version 2 Editor commands.
VER2LSN1  Text for first lesson using Turbo-C version 2 on the PC.
VER3EDIT  Text describing Turbo-C++ Version 3 Editor commands.
VER3LSN1  Text for the first lesson using Turbo-C version 3 on the PC.

************************************************************************
* CLASS: the COBOL Language class library. This is an incomplete course*
*        that may be of use to someone wishing to develop an elementary*
*        class in COBOL. I had a request to develop the class from a   *
*        non-programmer who had to deal with COBOL programmers, and    *
*        hoped to be able to communicate better with them after the    *
*        class. I presented an initial class in commonly used computer *
*        and programming terminology, however work schedules interfered*
*        and the students were never able to wangle time to take the   *
*        follow-on, so I never finished the course.                    *
************************************************************************
$$README  Text: this file
CALC100C  Sample tax calculation program in COBOL.
CALC100X  Execution JCL for the CALC100C program.
CHAR100C  Sample COBOL program to get number from user, display edited.
CHAR200C  Sample COBOL program gets name from user, displays converted.
CHAR300C  Sample COBOL program gets ZIP-code, displays with hyphen.
COBLKEDJ  JCL to compile and linkedit a COBOL program.
DATE100C  Sample COBOL program to calculate elapsed days between dates.
DATE200C  Sample COBOL program to display age, given birth date.
DELDEFNJ  JCL using IDCAMS to delete, define a VSAM dataset.
IND1000C  Sample COBOL program showing VSAM READs and WRITEs.
IND2000C  Sample COBOL program shows Add/Change/Delete for a VSAM file.
IND4000C  Sample COBOL program reads, displays record from VSAM file.
JOBCARDJ  JCL job card sample.
LISTMODC  Sample COBOL program reads source program, prints statistics.
PAYMNTC   Sample COBOL program creates, maintains VSAM payroll file.
PAYRECF   Sample COBOL COPY book describing a record.
REL4000C  Sample COBOL program processes a relative record VSAM file.
RPT1000C  Sample COBOL report program.
RPT2000C  Sample COBOL report program.
RPT3000C  Sample COBOL report program.
RPT5000C  Sample COBOL report program.
SEQ1000C  Sample COBOL program using sequential and VSAM datasets.
SEQ2000C  Sample COBOL program using sequential and VSAM datasets.
SKELETNC  Sample COBOL program that can be used to develop new programs.
SRT1000C  Sample COBOL program showing code for an internal sort.
************************************************************************
* DUMPREAD: A class in reading Abend-Aid dumps for COBOL programers.   *
*           It is fairly non-technical, and takes two days to present  *
*           as given here. The materials I hand out are a textbook, a  *
*           set of program compile and linkedit listings, and 10-12    *
*           dumps. The $instruc member describes how to prepare the    *
*           handout materials.                                         *
*          .The first day, I teach from the textbook using a blackboard*
*           and at the end of the day I go through the first dump to   *
*           model the process of locating the abending instruction, and*
*           then locating and evaluating every data field in the       *
*           failing instruction.                                       *
*          .The second day I have each student (or a pair of students  *
*           if there are more than 10) go through a dump. They first   *
*           locate the failing instruction, then find each data field  *
*           referenced in the instruction, and evaluate the data found.*
*          .The dumps are primarily S0C7, and all use the same main    *
*           COBOL program. Each dump abends on a different instruction,*
*           however, and most of the failing instructions contain an   *
*           indexed data field and a subscripted data field, giving 4  *
*           fields to be found and evaluated for validity. Data types  *
*           vary among data fields to give practice in validating data.*
*           I have each student locate all four data elements, even if *
*           it is obvious that the first or second caused the failure. *
************************************************************************
$INSTRUC  Text file describing how to create the handout materials.
ABNDCOB   COBOL main program in which most of the abends occur.
COBABEND  A COBOL subroutine called by the main program.
COPYDUMP  A COBOL program that is run when creating the handout stuff.
COPYNUM   A COBOL program that is run when creating the handout stuff.
CRSDESC   Text file that describes the course objectives.
CVTDATE   An assembler language subroutine called by COBABEND.
JOB001    JCL to create the handout materials: Job #1
JOB002A   JCL to create dump 10: Job #2
JOB002B   JCL to create dump 11: Job #3
JOB0021   JCL to create dump 1: Job #4
JOB0022   JCL to create dump 2: Job #5
JOB0023   JCL to create dump 3: Job #6
JOB0024   JCL to create dump 4: Job #7
JOB0025   JCL to create dump 5: Job #8
JOB0026   JCL to create dump 6: Job #9
JOB0027   JCL to create dump 7: Job #10
JOB0028   JCL to create dump 8: Job #11
JOB0029   JCL to create dump 9: Job #12
. A manual process is required between 0029 and JOB003. See $INSTRUC.
JOB003    JCL to create the handouts: Job #13
JOB004    JCL to create the handouts: Job #14
PROCNUM   A COBOL subroutine called by the ABDUMP program.
SYSADD    An assembler subroutine called by the ABDUMP program.
SYSAD2    An assembler subroutine called by the ABDUMP program.
SYSDATE   A COBOL subroutine called by the ABDUMP program.
TABLE     A table of data used by JOB002A-JOB0029 in creating dumps.
TABLE0A   A table of data used by JOB002A
TABLE0B   A table of data used by JOB002B
TABLE01   A table of data used by JOB0021
TABLE02   A table of data used by JOB0022
TABLE03   A table of data used by JOB0023
TABLE04   A table of data used by JOB0024
TABLE05   A table of data used by JOB0025
TABLE06   A table of data used by JOB0026
TABLE07   A table of data used by JOB0027
TABLE08   A table of data used by JOB0028
TABLE09   A table of data used by JOB0029
TABLE1    ? No longer used
TABLE2    ? No longer used
TABLE3    ? No longer used
TABLE4    ? No longer used
TEXTBOOK  The textbook for the course in XMIT unload format.
TRANFILA  A transaction file used by JOB002A
TRANFILB  A transaction file used by JOB002B
TRANFIL1  A transaction file used by JOB0021
TRANFIL2  A transaction file used by JOB0022
TRANFIL3  A transaction file used by JOB0023
TRANFIL4  A transaction file used by JOB0024
TRANFIL5  A transaction file used by JOB0025
TRANFIL6  A transaction file used by JOB0026
TRANFIL7  A transaction file used by JOB0027
TRANFIL8  A transaction file used by JOB0028
TRANFIL9  A transaction file used by JOB0029
