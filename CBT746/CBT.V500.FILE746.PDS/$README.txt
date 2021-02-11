***********************************************************************
*                                                                     *
*   MVS README                                                        *
*                                                                     *
*   CBT: Parsing, Syntax Checking and Interpreting                    *
*                                                                     *
*   rtsujimoto@nyc.rr.com                                             *
*                                                                     *
***********************************************************************

Note:  All the other platforms, which are supported with C language
       code, have their materials included in a zipped file, which
       has been included here as member $PLATFMS.  To use this file,
       FTP it in BINARY to a PC and unzip it there.  Then, all the
       stuff which is supported with C code, instead of Assembler,
       will be found.

Description
-----------
The README document describes how to install the executables,
object modules, and other files required to build and execute the
tools, and sample programs.

NOTE: No compilations of the tools or sample programs are
      required to run the sample executables, or to incorporate
      the tools into your applications

 Detailed documentation is found in the $$DOC member, which is
 in Microsoft WORD format.  To read this document, you must FTP
 it, or otherwise "file transfer" it in BINARY to a PC or other
 machine that can read Microsoft WORD.  Then you must read the
 document on that machine.

Installation
------------
01. FTP the following data sets to MVS:

    ftp your.mvs.dns or IP address
    binary
    prompt off
    quote site fixrecfm 80
    put rti.jcl.xmi
    put rti.loadlib.xmi
    put rti.maclib.xmi
    put rti.source.xmi

02. Use TSO RECEIVE to restore the data sets:

    (See sample job $TSORECV to do all of this at once.)

    RECEIVE USERID(your.userid) INDS(RTI.JCL.XMI)

    When prompted for the restore parameters, enter:

    DSN('whatever you want to call it')

03. Repeat Step 02 for the remaining data sets
     (or use the $TSORECV sample job).

Running the sample programs
---------------------------
01. Edit the JCL library using ISPF
02. Select a member and modify the JCL accordingly
03. Submit the job


Build Instructions
------------------
01. Edit the JCL library using ISPF
02. To build the tools:

    a. Select member BLDTOOLS and modify the JCL accordingly
    b. Submit the job

03. To build the sample programs:

    a. Select member BLDSAMPL and modify the JCL accordingly
    b. Submit the job

    NOTE:
    1. T@SYNTBL and T@UEXITS MUST BE BUILT BEFORE T@SYNTXC
    2. T@SYNTBL MUST BE LINKED WITH NCAL
    3. The sample code shows how the syntax table and user exits
       can be built separate from each other, and the main
       program.  In the simplest case, the syntax table and user
       exits can be coded in the main program.
