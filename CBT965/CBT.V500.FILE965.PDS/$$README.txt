SQLite 3.21.0 for z/OS UNIX
==========================
This is a port of the SQLite for use on z/OS.  The files in the UNIX
directory were generated on Linux from the SQLite amalgamation site.
I got this on the z/OS system using the UNIX command:
curl https://www.sqlite.org/2017/sqlite-amalgamation-3210000.zip \
   >|sqlite-amalgamation-3210000.zip
I downloaded this file on 2017-10-30. I "unzipped" the file with
the command:
jar -xf sqlite-amalgamation-3210000.zip

This port was very simple due to the dilligence of the original author,
Dr. Richard Hipp, who had already implemented the EBCDIC logic. All that
I did was a bit of packaging and verification on z/OS UNIX.

Member in this library:
-----------------------
$$README - You're reading it.
$README  - The generic README for SQLite
ASMACL   - Compile and link SQLITE3A
COBSQLTE - COBOL copy book for SQLite functions
COBTEST1 - JCL to run TESTCOB1 program
COBTEST2 - JCL to run TESTCOB2 program
IGYWCL   - JCL to compile and link the TESTCOB1 and TESTCOB2 programs
LINK     - General template JCL for linking SQLite into a program.
LINKLIB  - TSO XMIT of the LINKLIB for SQLite 3.21.0
PAXFULL  - Compressed PAX archive of the source & compiled programs.
PLICB    - JCL to compile the PL/I test program.
PLISQLTE - PL/I %INCLUDE member for SQLite 3.21.0
SQLITE3A - Assembler source for the "normal" CALL interface to SQLite.
SQLITE3O - Object code from compiling the sqlite3.c program under UNIX.
TESTCOB1 - COBOL source code for a test.
TESTCOB2 - COBOL source code for a test.
TSTDBPAX - Binary PAX of a test SQLite for z/OS data base file.
TSTPLI1  - PL/I source code for a test.
UNPAX    - JCL to unwind one of the PAX archives in this library.

Contents of PAXFULL file:
------------------------
$$README.txt
$README.txt
ASMACL.jcl
COBSQLTE.cpy
COBTEST1.jcl
COBTEST2.jcl
IGYWCL.jcl
LINK.jcl
MKFUNC.s
PLICB.jcl
PLISQLTE.pli
SQLITE3A.s
TESTCOB1.cbl
TESTCOB2.cbl
TSTPLI1.pli
UNPAX.jcl
cobtest-files.sqlite3.pax
do_compile.jcl
shell.c
sqlite3
sqlite3.c
sqlite3.h
sqlite3.o
sqlite3ext.h
