```
//***FILE 923 is from John McKown and is a port of SQLITE 3.8.7     *   FILE 923
//*           to z/OS.  The current state of this package is        *   FILE 923
//*           described below.  This is version 3.8.7 of SQLITE.    *   FILE 923
//*           An older version of this port can be found on CBT     *   FILE 923
//*           File 897.                                             *   FILE 923
//*                                                                 *   FILE 923
//*           email:  john.archie.mckown@gmail.com                  *   FILE 923
//*                                                                 *   FILE 923
//*           Please look at the description below:                 *   FILE 923
//*                                                                 *   FILE 923
//*     SQLITE 3.8.7 for z/OS                                       *   FILE 923
//*     =====================                                       *   FILE 923
//*                                                                 *   FILE 923
//*     Sqlite is a self-contained, server-less,                    *   FILE 923
//*     zero-configuration, transactional SQL database engine.      *   FILE 923
//*     This is the standard sqlite library which is available      *   FILE 923
//*     on many UNIX and Linux systems. The code was compiled       *   FILE 923
//*     with almost no changes. The code is dependent on z/OS       *   FILE 923
//*     UNIX System Services.  The original code supports EBCDIC    *   FILE 923
//*     in addition to the normal ASCII. This distribution has      *   FILE 923
//*     been compiled to support EBCDIC characters and IEEE         *   FILE 923
//*     (BFP) floating point numbers. This latter is important      *   FILE 923
//*     because most other z/OS languages use the historical HFP    *   FILE 923
//*     floating point.                                             *   FILE 923
//*                                                                 *   FILE 923
//*     At present, the code only has C language bindings on        *   FILE 923
//*     z/OS.  There is a "shim" or "stub" HLASM interface          *   FILE 923
//*     program which can be called from COBOL or PL/I to           *   FILE 923
//*     access the C subroutines. It is named SQLITE3A.  The        *   FILE 923
//*     parameters passed into this routine are the same ones       *   FILE 923
//*     as documented in the sqlite C API, except that the          *   FILE 923
//*     first parameter is a C style null-delimited character       *   FILE 923
//*     string which is the name of the C subroutine to be          *   FILE 923
//*     invoked. In COBOL, this is a Z'...' character string.       *   FILE 923
//*     The COBSQLTE and PLISQLTE members are the COBOL COPY        *   FILE 923
//*     book and PL/I %INCLUDE members which define COBOL or        *   FILE 923
//*     PL/I variables which contain these strings. In the case     *   FILE 923
//*     of COBOL, the underscore characters shown in the C API      *   FILE 923
//*     names are replace by a dash because an underscore is        *   FILE 923
//*     not valid in a COBOL data name. The variable names are      *   FILE 923
//*     in upper case, but the values are in lower case, due to     *   FILE 923
//*     the fact that the C subroutine names are in lower case.     *   FILE 923
//*                                                                 *   FILE 923
//*     Sqlite 3.8.7 is documented at http://sqlite.org, and        *   FILE 923
//*     this code runs as described there. Therefore, no futher     *   FILE 923
//*     documentation is supplied at present.  When the COBOL       *   FILE 923
//*     and PL/I bindings are done, those will be documented        *   FILE 923
//*     here.                                                       *   FILE 923
//*                                                                 *   FILE 923
//*     This document does _not_ attempt to teach you how to        *   FILE 923
//*     use sqlite. It assumes you already know how to use it,      *   FILE 923
//*     or can learn it yourself. It does attempt to explain        *   FILE 923
//*     how to use it on z/OS by showing some COBOL and PL/I        *   FILE 923
//*     examples. If you have a C license, I strongly suggest       *   FILE 923
//*     writing your code in C. It will be more understandable      *   FILE 923
//*     to most.                                                    *   FILE 923
//*                                                                 *   FILE 923
//*     Wish list items.                                            *   FILE 923
//*     ----------------                                            *   FILE 923
//*     1. At present, the file which contains the sqlite           *   FILE 923
//*        database must reside in a UNIX subdirectory. This        *   FILE 923
//*        means that the user of sqlite must have an z/OS UNIX     *   FILE 923
//*        identity.  I would like to be able to use a VSAM         *   FILE 923
//*        Linear Dataset for storing the sqlite data at some       *   FILE 923
//*        time. Mainly due to the number of shops which have       *   FILE 923
//*        not really embraced z/OS UNIX.  This may be possible     *   FILE 923
//*        using a "shim" sqlite VFS as documented here:            *   FILE 923
//*        http://sqlite.org/vfs.html which would use a VSAM        *   FILE 923
//*        LDS as the backing store for a sqlite in-memory data     *   FILE 923
//*        base.                                                    *   FILE 923
//*                                                                 *   FILE 923
//*     2. Write a REXX interface.                                  *   FILE 923
//*                                                                 *   FILE 923
//*     3. Write a batch program based on the sqlite3 UNIX          *   FILE 923
//*        command. This would allow SQL commands to be run in      *   FILE 923
//*        a step in a batch job.                                   *   FILE 923
//*                                                                 *   FILE 923
//*     4. JDBC for Java access.                                    *   FILE 923
//*                                                                 *   FILE 923
//*     Members in this library:                                    *   FILE 923
//*     ------------------------                                    *   FILE 923
//*     - $README  - This member. The README in markdown            *   FILE 923
//*                  format.                                        *   FILE 923
//*                                                                 *   FILE 923
//*     - ASMACL   - The JCL to compile and link the SQLITE3A       *   FILE 923
//*                  assembler program.  It would be wise to        *   FILE 923
//*                  run this to recompile SQLITE3A on your         *   FILE 923
//*                  system, if at all possible.                    *   FILE 923
//*                                                                 *   FILE 923
//*     - COBSQLTE - The COBOL copy book which defines various      *   FILE 923
//*                  SQLITE3 related variables and initializes      *   FILE 923
//*                  them.  The member contains a fair number       *   FILE 923
//*                  of comments on how to use SQLITE3A in a        *   FILE 923
//*                  COBOL program to invoke each of the 204(!)     *   FILE 923
//*                  different sqlite subroutines.                  *   FILE 923
//*                                                                 *   FILE 923
//*     - COBTEST1 - The JCL to run the TESTCOB1 program.           *   FILE 923
//*                  Unless you are running z/OS 2.1, you need      *   FILE 923
//*                  to recompile the program before running        *   FILE 923
//*                  this test job. There are LE dependencies.      *   FILE 923
//*                                                                 *   FILE 923
//*     - COBTEST2 - The JCL to run the TESTCOB2 program.           *   FILE 923
//*                  Unless you are running z/OS 2.1, you need      *   FILE 923
//*                  to recompile the program before running        *   FILE 923
//*                  this test job. There are LE dependencies.      *   FILE 923
//*                                                                 *   FILE 923
//*     - IGYWCL   - The JCL to compile and link the TESTCOB1       *   FILE 923
//*                  and TESTCOB2 program. You really need to       *   FILE 923
//*                  recompile these program on your system due     *   FILE 923
//*                  to possible LE dependencies.                   *   FILE 923
//*                                                                 *   FILE 923
//*     - LINK     - The JCL to link the SQLITE3 object code        *   FILE 923
//*                  into a LINKLIB.  This composite links in       *   FILE 923
//*                  the C and LE library subroutines.              *   FILE 923
//*                                                                 *   FILE 923
//*     - LINKLIB  - XMIT copy of the SQL387.LINKLIB library        *   FILE 923
//*                  containing the z/OS batch executable           *   FILE 923
//*                  programs: SQLITE3A, TESTCOB1, and              *   FILE 923
//*                  TESTCOB2. However, these program will          *   FILE 923
//*                  likely only run on a z/OS 2.1 system due       *   FILE 923
//*                  to COBOL dependencies on LE.                   *   FILE 923
//*                                                                 *   FILE 923
//*     - PAXFULL  - This is a compressed pax archive for the       *   FILE 923
//*                  entire SQLITE3 application, Including all      *   FILE 923
//*                  source code and make information.              *   FILE 923
//*                                                                 *   FILE 923
//*     - PAXRUN   - This is a compressed pax archive               *   FILE 923
//*                  containing only the files needed to use        *   FILE 923
//*                  SQLITE. This is really all you need if you     *   FILE 923
//*                  want to develop C language programs which      *   FILE 923
//*                  use SQLITE.  This is not needed for COBOL      *   FILE 923
//*                  or HLASM programs.                             *   FILE 923
//*                                                                 *   FILE 923
//*     - PLICB    - The JCL to compile a PL/I program.             *   FILE 923
//*                                                                 *   FILE 923
//*     - PLISQLTE - The PL/I %INCLUDE member to define and         *   FILE 923
//*                  initialize a number of variables to ease       *   FILE 923
//*                  the use of SQLITE3A.                           *   FILE 923
//*                                                                 *   FILE 923
//*     - SQLITE3A - LE enabled HLASM subroutine which presents     *   FILE 923
//*                  an API to the SQLITE3 C subroutines which      *   FILE 923
//*                  is designed for use by COBOL or PL/I code.     *   FILE 923
//*                  It is composite (statically) bound with        *   FILE 923
//*                  the C object code.  This code has not been     *   FILE 923
//*                  fully tested yet and may contain errors.       *   FILE 923
//*                                                                 *   FILE 923
//*     - SQLITE3O - The object code for SQLITE to be bound         *   FILE 923
//*                  into the application.  This was compiled       *   FILE 923
//*                  on z/OS 1.13, but the C compiler options       *   FILE 923
//*                  were for compatibility with z/OS 1.11 or       *   FILE 923
//*                  higher.                                        *   FILE 923
//*                                                                 *   FILE 923
//*     - TESTCOB1 - Example Enterprise COBOL program. It is        *   FILE 923
//*                  very basic.  It uses the SQLITE3A stub to      *   FILE 923
//*                  invoke SQLITE3 operations.  If you look at     *   FILE 923
//*                  this, you will realize that I am very          *   FILE 923
//*                  "wordy" and am definitely not an advanced      *   FILE 923
//*                  COBOL programmer.                              *   FILE 923
//*                                                                 *   FILE 923
//*     - TESTCOB2 - Example Enterprise COBOL program. It is        *   FILE 923
//*                  very basic.  It's main example is of how       *   FILE 923
//*                  to retrieve a double precision floating        *   FILE 923
//*                  point number, COMP-2, from an sqlite data      *   FILE 923
//*                  base, converting it from BFP to HFP            *   FILE 923
//*                  format.  The table is defined like:            *   FILE 923
//*                  CREATE TABLE xz (int INTEGER, fd DOUBLE);      *   FILE 923
//*                  This table can be created and loaded from      *   FILE 923
//*                  a z/OS UNIX shell prompt using the             *   FILE 923
//*                  "sqlite3" UNIX command.                        *   FILE 923
//*                                                                 *   FILE 923
//*                  From my testing, it appears that sqlite,       *   FILE 923
//*                  unlike most other RDMS systems is case         *   FILE 923
//*                  sensitive for the names of objects such as     *   FILE 923
//*                  columns and tables.                            *   FILE 923
//*                                                                 *   FILE 923
//*     - TESTDB   - A pax archive which contains the               *   FILE 923
//*                  testdb.sqlite3 UNIX file used by the           *   FILE 923
//*                  TESTCOB2 program. This needs to be             *   FILE 923
//*                  restored to a subdirectory (/tmp in the        *   FILE 923
//*                  example code). This can be done with a         *   FILE 923
//*                  UNIX command sequence such as:                 *   FILE 923
//*                                                                 *   FILE 923
//*                  cd /tmp                                        *   FILE 923
//*                  pax -rzf "//sql387.cntl(testdb)"               *   FILE 923
//*                                                                 *   FILE 923
//*     - TSTPLI1  - Example Enterprise PL/I program. It is         *   FILE 923
//*                  very basic.  It is functionally equivalent     *   FILE 923
//*                  to TESTCOB1.  This is not working at           *   FILE 923
//*                  present.  I don't normally program in PL/I     *   FILE 923
//*                  because I have never worked in a shop          *   FILE 923
//*                  which used it.                                 *   FILE 923
//*                                                                 *   FILE 923
//*     - UNPAX    - The JCL needed to unwind either the            *   FILE 923
//*                  PAXFULL or PAXRUN member into a z/OS UNIX      *   FILE 923
//*                  subdirectory.                                  *   FILE 923
//*                                                                 *   FILE 923

```
