```
//***FILE 965 is from John McKown and is a port of SQLITE 3.21.0    *   FILE 965
//*           to z/OS.  The current state of this package is        *   FILE 965
//*           described below.  This is version 3.21.0 of SQLITE.   *   FILE 965
//*           Older versions of this port can be found on:          *   FILE 965
//*                                                                 *   FILE 965
//*           CBT File 897  -  Version 3.8                          *   FILE 965
//*           CBT File 923  -  Version 3.8.7                        *   FILE 965
//*           CBT File 935  -  Version 3.8.11                       *   FILE 965
//*                                                                 *   FILE 965
//*           email:  john.archie.mckown@gmail.com                  *   FILE 965
//*                                                                 *   FILE 965
//*           Please look at the description below:                 *   FILE 965
//*                                                                 *   FILE 965
//*                    SQLITE 3.21.0 for z/OS                       *   FILE 965
//*                    =====================                        *   FILE 965
//*                                                                 *   FILE 965
//*     Sqlite is a self-contained, server-less,                    *   FILE 965
//*     zero-configuration, transactional SQL database engine.      *   FILE 965
//*     This is the standard sqlite library which is available      *   FILE 965
//*     on many UNIX and Linux systems. The code was compiled       *   FILE 965
//*     with almost no changes. The code is dependent on z/OS       *   FILE 965
//*     UNIX System Services.  The original code supports EBCDIC    *   FILE 965
//*     in addition to the normal ASCII. This distribution has      *   FILE 965
//*     been compiled to support EBCDIC characters and IEEE         *   FILE 965
//*     (BFP) floating point numbers. This latter is important      *   FILE 965
//*     because most other z/OS languages use the historical HFP    *   FILE 965
//*     floating point.                                             *   FILE 965
//*                                                                 *   FILE 965
//*     At present, the code only has C language bindings on        *   FILE 965
//*     z/OS.  There is a "shim" or "stub" HLASM interface          *   FILE 965
//*     program which can be called from COBOL or PL/I to access    *   FILE 965
//*     the C subroutines. It is named SQLITE3A.  The parameters    *   FILE 965
//*     passed into this routine are the same ones as documented    *   FILE 965
//*     in the sqlite C API, except that the first parameter is a   *   FILE 965
//*     C style null-delimited character string which is the name   *   FILE 965
//*     of the C subroutine to be invoked. In COBOL, this is a      *   FILE 965
//*     Z'...' character string. The COBSQLTE and PLISQLTE          *   FILE 965
//*     members are the COBOL COPY book and PL/I %INCLUDE members   *   FILE 965
//*     which define COBOL or PL/I variables which contain these    *   FILE 965
//*     strings. In the case of COBOL, the underscore characters    *   FILE 965
//*     shown in the C API names are replace by a dash because an   *   FILE 965
//*     underscore is not valid in a COBOL data name. The           *   FILE 965
//*     variable names are in upper case, but the values are in     *   FILE 965
//*     lower case, due to the fact that the C subroutine names     *   FILE 965
//*     are in lower case.                                          *   FILE 965
//*                                                                 *   FILE 965
//*     Sqlite 3.21.0 is documented at http://sqlite.org, and       *   FILE 965
//*     this code runs as described there. Therefore, no futher     *   FILE 965
//*     documentation is supplied at present.  When the COBOL and   *   FILE 965
//*     PL/I bindings are done, those will be documented here.      *   FILE 965
//*                                                                 *   FILE 965
//*     This document does _not_ attempt to teach you how to use    *   FILE 965
//*     sqlite. It assumes you already know how to use it, or can   *   FILE 965
//*     learn it yourself. It does attempt to explain how to use    *   FILE 965
//*     it on z/OS by showing some COBOL and PL/I examples. If      *   FILE 965
//*     you have a C license, I strongly suggest writing your       *   FILE 965
//*     code in C. It will be more understandable to most.          *   FILE 965
//*                                                                 *   FILE 965
//*     Wish list items.                                            *   FILE 965
//*     ----------------                                            *   FILE 965
//*     1. At present, the file which contains the sqlite           *   FILE 965
//*        database must reside in a UNIX subdirectory. This        *   FILE 965
//*        means that the user of sqlite must have an z/OS UNIX     *   FILE 965
//*        identity.  I would like to be able to use a VSAM         *   FILE 965
//*        Linear Dataset for storing the sqlite data at some       *   FILE 965
//*        time. Mainly due to the number of shops which have       *   FILE 965
//*        not really embraced z/OS UNIX.  This may be possible     *   FILE 965
//*        using a "shim" sqlite VFS as documented here:            *   FILE 965
//*                                                                 *   FILE 965
//*        http://sqlite.org/vfs.html which would use a VSAM LDS    *   FILE 965
//*        as the backing store for a sqlite in-memory data         *   FILE 965
//*        base.                                                    *   FILE 965
//*                                                                 *   FILE 965
//*     2. Write a REXX interface.                                  *   FILE 965
//*                                                                 *   FILE 965
//*     3. Write a batch program based on the sqlite3 UNIX          *   FILE 965
//*        command. This would allow SQL commands to be run in a    *   FILE 965
//*        step in a batch job.                                     *   FILE 965
//*                                                                 *   FILE 965
//*     4. JDBC for Java access.                                    *   FILE 965
//*                                                                 *   FILE 965
//*     Members in this library:                                    *   FILE 965
//*     ------------------------                                    *   FILE 965
//*     - $README  - This member. The README in markdown format.    *   FILE 965
//*                                                                 *   FILE 965
//*     - ASMACL   - The JCL to compile and link the SQLITE3A       *   FILE 965
//*                  assembler program.  It would be wise to run    *   FILE 965
//*                  this to recompile SQLITE3A on your system,     *   FILE 965
//*                  if at all possible.                            *   FILE 965
//*                                                                 *   FILE 965
//*     - COBSQLTE - The COBOL copy book which defines various      *   FILE 965
//*                  SQLITE3 related variables and initializes      *   FILE 965
//*                  them.  The member contains a fair number of    *   FILE 965
//*                  comments on how to use SQLITE3A in a COBOL     *   FILE 965
//*                  program to invoke each of the 204(!)           *   FILE 965
//*                  different sqlite subroutines.                  *   FILE 965
//*                                                                 *   FILE 965
//*     - COBTEST1 - The JCL to run the TESTCOB1 program.           *   FILE 965
//*                  Unless you are running z/OS 2.1, you need      *   FILE 965
//*                  to recompile the program before running        *   FILE 965
//*                  this test job. There are LE dependencies.      *   FILE 965
//*                                                                 *   FILE 965
//*     - COBTEST2 - The JCL to run the TESTCOB2 program.           *   FILE 965
//*                  Unless you are running z/OS 2.1, you need      *   FILE 965
//*                  to recompile the program before running        *   FILE 965
//*                  this test job. There are LE dependencies.      *   FILE 965
//*                                                                 *   FILE 965
//*     - IGYWCL   - The JCL to compile and link the TESTCOB1       *   FILE 965
//*                  and TESTCOB2 program. You really need to       *   FILE 965
//*                  recompile these program on your system due     *   FILE 965
//*                  to possible LE dependencies.                   *   FILE 965
//*                                                                 *   FILE 965
//*     - LINK     - The JCL to link the SQLITE3 object code        *   FILE 965
//*                  into a LINKLIB.  This composite links in       *   FILE 965
//*                  the C and LE library subroutines.              *   FILE 965
//*                                                                 *   FILE 965
//*     - LINKLIB  - XMIT copy of the SQL3210.LINKLIB library       *   FILE 965
//*                  containing the z/OS batch executable           *   FILE 965
//*                  programs: SQLITE3A, TESTCOB1, and TESTCOB2.    *   FILE 965
//*                  However, these program will likely only run    *   FILE 965
//*                  on a z/OS 2.1 system due to COBOL              *   FILE 965
//*                  dependencies on LE.                            *   FILE 965
//*                                                                 *   FILE 965
//*     - PAXFULL  - This is a compressed pax archive for the       *   FILE 965
//*                  entire SQLITE3 application, including all      *   FILE 965
//*                  source code and executables.                   *   FILE 965
//*                                                                 *   FILE 965
//*     - PLICB    - The JCL to compile a PL/I program.             *   FILE 965
//*                                                                 *   FILE 965
//*     - PLISQLTE - The PL/I %INCLUDE member to define and         *   FILE 965
//*                  initialize a number of variables to ease       *   FILE 965
//*                  the use of SQLITE3A.                           *   FILE 965
//*                                                                 *   FILE 965
//*     - SQLITE3A - LE enabled HLASM subroutine which presents     *   FILE 965
//*                  an API to the SQLITE3 C subroutines which      *   FILE 965
//*                  is designed for use by COBOL or PL/I code.     *   FILE 965
//*                  It is composite (statically) bound with the    *   FILE 965
//*                  C object code.  This code has not been         *   FILE 965
//*                  fully tested yet and may contain errors.       *   FILE 965
//*                                                                 *   FILE 965
//*     - SQLITE3O - The object code for SQLITE to be bound into    *   FILE 965
//*                  the application.  This was compiled on z/OS    *   FILE 965
//*                  1.13, but the C compiler options were for      *   FILE 965
//*                  compatibility with z/OS 1.11 or higher.        *   FILE 965
//*                                                                 *   FILE 965
//*     - TESTCOB1 - Example Enterprise COBOL program. It is        *   FILE 965
//*                  very basic.  It uses the SQLITE3A stub to      *   FILE 965
//*                  invoke SQLITE3 operations.  If you look at     *   FILE 965
//*                  this, you will realize that I am very          *   FILE 965
//*                  "wordy" and am definitely not an advanced      *   FILE 965
//*                  COBOL programmer.                              *   FILE 965
//*                                                                 *   FILE 965
//*     - TESTCOB2 - Example Enterprise COBOL program. It is        *   FILE 965
//*                  very basic.  It's main example is of how to    *   FILE 965
//*                  retrieve a double precision floating point     *   FILE 965
//*                  number, COMP-2, from an sqlite data base,      *   FILE 965
//*                  converting it from BFP to HFP format.  The     *   FILE 965
//*                  table is defined like:  CREATE TABLE xz        *   FILE 965
//*                  (int INTEGER, fd DOUBLE); This table can be    *   FILE 965
//*                  created and loaded from a z/OS UNIX shell      *   FILE 965
//*                  prompt using the "sqlite3" UNIX command.       *   FILE 965
//*                                                                 *   FILE 965
//*                  From my testing, it appears that sqlite,       *   FILE 965
//*                  unlike most other RDMS systems is case         *   FILE 965
//*                  sensitive for the names of objects such as     *   FILE 965
//*                  columns and tables.                            *   FILE 965
//*                                                                 *   FILE 965
//*     - TSTDBPAX - A pax archive which contains the               *   FILE 965
//*                  testdb.sqlite3 UNIX file used by the           *   FILE 965
//*                  TESTCOB2 program. This needs to be restored    *   FILE 965
//*                  to a subdirectory (/tmp in the example         *   FILE 965
//*                  code). This can be done with a UNIX command    *   FILE 965
//*                  sequence such as:                              *   FILE 965
//*                                                                 *   FILE 965
//*                  cd /tmp                                        *   FILE 965
//*                  pax -rzf "//sql3210.cntl(testdb)"              *   FILE 965
//*                                                                 *   FILE 965
//*     - TSTPLI1  - Example Enterprise PL/I program. It is very    *   FILE 965
//*                  basic.  It is functionally equivalent to       *   FILE 965
//*                  TESTCOB1.  This is not working at present.     *   FILE 965
//*                  I don't normally program in PL/I because I     *   FILE 965
//*                  have never worked in a shop which used it.     *   FILE 965
//*                                                                 *   FILE 965
//*     - UNPAX    - The JCL needed to unwind either the PAXFULL    *   FILE 965
//*                  member into a z/OS UNIX subdirectory.          *   FILE 965
//*                                                                 *   FILE 965
//*     Notes on the SQLITE3A interface program.                    *   FILE 965
//*     ----------------------------------------                    *   FILE 965
//*                                                                 *   FILE 965
//*     Notes on how to use SQLITE3A with COBOL.                    *   FILE 965
//*     ----------------------------------------                    *   FILE 965
//*     1. One major oddity which can be quite confusing is that    *   FILE 965
//*        the C language calling sequence is quite different       *   FILE 965
//*        from the normal COBOL calling sequence. This             *   FILE 965
//*        difference is why many of the parameters being passed    *   FILE 965
//*        to sqlite3 _must_ be BY VALUE instead of BY REFERENCE.   *   FILE 965
//*        In particular things such as integers (COMP-?) and       *   FILE 965
//*        doubles must be passed BY VALUE.  Character strings      *   FILE 965
//*        are passed BY REFERENCE, but generally require that      *   FILE 965
//*        they be terminated with by LOW-VALUES byte. In modern    *   FILE 965
//*        COBOLs, this type of string can be initialized using     *   FILE 965
//*        the Z'value' construct.                                  *   FILE 965
//*                                                                 *   FILE 965
//*     2. When reading the C API documentation, the main thing     *   FILE 965
//*        to remember is that when you see a varible prefixed      *   FILE 965
//*        with an ampersand, you need to pass it BY REFERENCE.     *   FILE 965
//*        If you see a variable suffixed with an asterisk, this    *   FILE 965
//*        indicates that the variable name in COBOL needs to be    *   FILE 965
//*        defined as USAGE POINTER. This is also passed BY         *   FILE 965
//*        VALUE.                                                   *   FILE 965
//*                                                                 *   FILE 965
//*     3. Another critical point is that when you see a function   *   FILE 965
//*        return an "int", which is a 32 bit integer, or a name    *   FILE 965
//*        prefixed by an asterisk, you receive these into a        *   FILE 965
//*        COBOL variable by using the phrase RETURNING             *   FILE 965
//*        cobol-var-name.  All other types of returned             *   FILE 965
//*        variables, such as double floating point, are received   *   FILE 965
//*        by inserting a BY REFERENCE phrase as the second         *   FILE 965
//*        parameter in the CALL verb's USING clause.  Please       *   FILE 965
//*        review TESTCOB2 for an example.                          *   FILE 965
//*                                                                 *   FILE 965
//*     4. Unlike most z/OS languages, sqlite stores floating       *   FILE 965
//*        point numbers in IEEE 754 format. On the z, this is      *   FILE 965
//*        called a BFP or Binary Floating Point number. After      *   FILE 965
//*        retrieving a BFP number from sqlite, you will likely     *   FILE 965
//*        need to call the function "CONVERT-BFP-TO-HFP".          *   FILE 965
//*        Likewise, before sending a value to sqlite, you need     *   FILE 965
//*        to convert it to BFP by calling the                      *   FILE 965
//*        "CONVERT-HFP-TO-BFP" function.  The former is shown      *   FILE 965
//*        in the TESTCOB2 example.  My suggestion is to define     *   FILE 965
//*        BFP number in your COBOL as COMP-2 variables, perhaps    *   FILE 965
//*        suffixed with -BFP. Use COMP-2 for your COBOL            *   FILE 965
//*        floating point number also, not COMP-1. Both of these    *   FILE 965
//*        formats use an 8 bytes for storage.                      *   FILE 965
//*                                                                 *   FILE 965
//*     Notes on how to use SQLITE3A with PL/I.                     *   FILE 965
//*     ---------------------------------------                     *   FILE 965
//*     No notes at present. Mainly due to my lack of PL/I          *   FILE 965
//*     skills.                                                     *   FILE 965
//*                                                                 *   FILE 965
//*     Note: This member is in "markdown" compatible format.       *   FILE 965
//*     For more information on markdown, go to                     *   FILE 965
//*                                                                 *   FILE 965
//*     http://daringfireball.net/projects/markdown/                *   FILE 965
//*                                                                 *   FILE 965

```
