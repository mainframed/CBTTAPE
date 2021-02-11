

                 MVS Recovery Routines Sample Programs          Page 1


Overview
________

    This directory  contains the  sample programs  and  macros  first
presented in:

    Session O318 - Recovery Routines in MVS: How to Write Them
    Share 79
    August 1992
    Atlanta, Georgia

    Also presented at Share 80 in San Francisco, California.

    Also include  in this  directory are  the  control  statments  to
upload the  files to  mainframe DASD using FTTSO, IND$FILE or XCOM6.2
as well as the JCL to compile and execute the sample programs.

Files in This Directory
_______________________

    READ.ME        - This file
    SENDASM.BAT    - FTTSO statements to upload assembly source
    SENDJCL.BAT    - FTTSO statements to upload JCL files
    SENDMAC.BAT    - FTTSO statements to upload macros
    SYSIN01B.XCM   - XCOM6.2 statements to upload JCL
    SYSIN01C.XCM   - XCOM6.2 statements to upload source and macros
    ALLOC.JCL      - JCL to allocate libraries
    ASMLKD.JCL     - JCL to assemble and link sample programs
    EXEC.JCL       - JCL to execute sample programs
    CARR.ASM       - Code fragment: establish an ARR
    CESTAE.ASM     - Program: establish an ESTAEX routine
    CFRR.ASM       - Code fragment: establish an FRR
    GRECOV.ASM     - Program: Generalized recovery routine
    ENDMOD.MAC     - Exit logic macro
    EQUATES.MAC    - Inner macro for MODULE
    ESTPARM.MAC    - DSECT that maps recovery routine parmlist
    INNERMM.MAC    - Inner macro for MODULE
    MODULE.MAC     - Entry logic macro


                 MVS Recovery Routines Sample Programs          Page 2


Uploading Programs To MVS Using FTTSO or IND$FILE
_________________________________________________

    1) On  the MVS  system: Allocate  a JCL library using ISPF 3.2 or
       IEFBR14.       The   library   should   have   the   following
       characteristics:
                    BLKSIZE=3120, LRECL=80, RECFM=FB,
                    DSORG=PO, SPACE=(TRK,(15,1,10))

    2) On  the PC:  Execute the file SENDJCL.BAT to transfer assembly
       and link-edit  JCL to  the library  allocated in  the previous
       step.   SENDJCL.BAT, as  well as  the other .BAT files on this
       diskette,  contains   IND$FILE  control  statements  for  file
       transfer.   If you are using FTTSO or some other file transfer
       utility, edit  these files  so that  they contain  the correct
       control statements.
       Specify the host library as the operand of SENDJCL.BAT:
                    SENDJCL host.jcl.library

    3) On  the MVS  system:   Edit the JOB in member ALLOC in the JCL
       library.   This JOB, which allocates a macro library, assembly
       source library, object library and load library, contains edit
       instructions.  Submit the JOB and check the return codes.

    4) On the PC:  Execute the file SENDMAC.BAT to transfer macros to
       the macro library allocated in the previous step.  Specify the
       macro library as the operand of SENDMAC.BAT:
                    SENDMAC host.macro.library

    5) On  the PC:  Execute the file SENDASM.BAT to transfer assembly
       source files  to the  source library  allocated in step 4.  If
       you do  not want  to transfer all the source files to the host
       system (the  transfer may  take some  time), add 'REM ' before
       each SEND statement that is to be ignored.  Specify the source
       library as the operand of SENDASM.BAT:
                    SENDASM host.source.library


                 MVS Recovery Routines Sample Programs          Page 3


Uploading Programs To MVS Using XCOM 6.2
________________________________________

    1) On  the MVS  system: Allocate  a JCL library using ISPF 3.2 or
       IEFBR14.       The   library   should   have   the   following
       characteristics:
                    BLKSIZE=3120, LRECL=80, RECFM=FB,
                    DSORG=PO, SPACE=(TRK,(15,1,10))

    2) On MVS: Execute XCOM6.2 with the following SYSIN01 file:
                    TYPE=RECEIVE
                    LU=xcom-on-pc
                    FILETYPE=FILE
                    FILEOPT=REPLACE
                    LFILE=host-jcl-library(SYSIN01B)
                    FILE=A:\SYSIN01B.XCM
                    NEWXFER
                    LFILE=host-jcl-library(SYSIN01C)
                    FILE=A:\SYSIN01C.XCM

    3) On  MVS: edit  the member  SYSIN01B which was transferred from
       the PC:

       . Change LU= to PC XCOM's LU.
       . Change all strings "@JCL@" to the host JCL library name.

       Execute XCOM6.2 on MVS using this SYSIN01 file to.

    4) On  the MVS  system:   Edit the JOB in member ALLOC in the JCL
       library.   This JOB, which allocates a macro library, assembly
       source library, object library and load library, contains edit
       instructions.  Submit the JOB and check the return codes.

    5) On MVS: edit the member SYSIN01C transferred from the PC:

       . Change LU= to PC XCOM's LU
       . Change  all strings  "@SOURCE@" to the host assembler source
         library name.
       . Change  all strings  "@MACLIB@" to  the host  macro  library
         name.

       Execute XCOM6.2 on MVS using this SYSIN01 file.


                 MVS Recovery Routines Sample Programs          Page 4


Assembling, Linking and Executing Programs
__________________________________________

    1) On  the MVS  system: Edit  the JOB in member ASMLKD in the JCL
       library.   This JOB,  which contains  steps  to  assemble  and
       linkedut the  programs in  the source  library, contains  edit
       instructions.

    2) The member EXEC in the JCL library contains JCL to execute the
       sample program as a batch job.


Questions
_________

    If you  have any questions about any of the programs or macros in
this directory you can write or telephone:

    Mitchell Marx
    MD-Paladin Inc
    Suite 169
    163 Amsterdam Ave.
    New York, NY 10023
    (212) 787-9532

