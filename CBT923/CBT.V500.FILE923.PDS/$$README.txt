SQLite 3.8.7 for z/OS UNIX
==========================
This is a port of the SQLite for use on z/OS.  The files in the UNIX
directory were originally downloaded from
http://www.sqlite.org/download.html on 2104-10-18T20:47:00Z (18 Oct 2014
at 10:47 p.m. GMT time).  The files in the directory are the files from
both the sqlite-autoconf-3080700.tar.gz and the
sqlite-amalgamation-3080700.zip .  They were orinally downloaded to my
Linux/Intel machine at home. I combined them there and created a tar
file from the combined directory contents. I then uploaded the tar file
to z/OS. I unwound the tar file into a UNIX directory using the command:

pax -ofrom=iso8859-1,to=ibm-1047 -rf "//sqlite.v3r8m7.tar"

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
LINKLIB  - TSO XMIT of the LINKLIB for SQLite 3.8.7
PAXFULL  - Compressed PAX archive of the source & compiled programs.
PAXRUN   - Compressed PAX archive of the "run time" compiled programs.
PLICB    - JCL to compile the PL/I test program.
PLISQLTE - PL/I %INCLUDE member for SQLite 3.8.7
SQLITE3A - Assembler source for the "normal" CALL interface to SQLite.
SQLITE3O - Object code from compiling the sqlite3.c program under UNIX.
TESTCOB1 - COBOL source code for a test.
TESTCOB2 - COBOL source code for a test.
TESTDB   - Binary copy of a test SQLite for z/OS data base file.
TSTPLI1  - PL/I source code for a test.
UNPAX    - JCL to unwind one of the PAX archives in this library.

Contents of PAXRUN file:
------------------------
./
./lib/
./lib/pkgconfig/
./lib/pkgconfig/sqlite3.pc
./lib/libsqlite3.la
./lib/libsqlite3.a
./bin/
./bin/sqlite3
./include/
./include/sqlite3.h
./include/sqlite3ext.h
./share/
./share/man/
./share/man/man1/
./share/man/man1/sqlite3.1

Contents of PAXFULL file:
-------------------------
sqlite-v3r8m7/
sqlite-v3r8m7/Makefile.am
sqlite-v3r8m7/config.sub
sqlite-v3r8m7/aclocal.m4
sqlite-v3r8m7/depcomp
sqlite-v3r8m7/sqlite3.1
sqlite-v3r8m7/configure.ac
sqlite-v3r8m7/README
sqlite-v3r8m7/shell.c
sqlite-v3r8m7/INSTALL
sqlite-v3r8m7/config.guess
sqlite-v3r8m7/missing
sqlite-v3r8m7/tea/
sqlite-v3r8m7/tea/pkgIndex.tcl.in
sqlite-v3r8m7/tea/generic/
sqlite-v3r8m7/tea/generic/tclsqlite3.c
sqlite-v3r8m7/tea/aclocal.m4
sqlite-v3r8m7/tea/configure.in
sqlite-v3r8m7/tea/README
sqlite-v3r8m7/tea/win/
sqlite-v3r8m7/tea/win/nmakehlp.c
sqlite-v3r8m7/tea/win/rules.vc
sqlite-v3r8m7/tea/win/makefile.vc
sqlite-v3r8m7/tea/tclconfig/
sqlite-v3r8m7/tea/tclconfig/tcl.m4
sqlite-v3r8m7/tea/tclconfig/install-sh
sqlite-v3r8m7/tea/Makefile.in
sqlite-v3r8m7/tea/license.terms
sqlite-v3r8m7/tea/configure
sqlite-v3r8m7/tea/doc/
sqlite-v3r8m7/tea/doc/sqlite3.n
sqlite-v3r8m7/sqlite3.c
sqlite-v3r8m7/sqlite3.pc.in
sqlite-v3r8m7/ltmain.sh
sqlite-v3r8m7/install-sh
sqlite-v3r8m7/sqlite3.h
sqlite-v3r8m7/Makefile.in
sqlite-v3r8m7/sqlite3ext.h
sqlite-v3r8m7/configure
sqlite-v3r8m7/do_config.jcl
sqlite-v3r8m7/do_config.sh
sqlite-v3r8m7/do_make.jcl
sqlite-v3r8m7/sqlite-run/
sqlite-v3r8m7/sqlite-run/lib/
sqlite-v3r8m7/sqlite-run/lib/pkgconfig/
sqlite-v3r8m7/sqlite-run/lib/pkgconfig/sqlite3.pc
sqlite-v3r8m7/sqlite-run/lib/libsqlite3.la
sqlite-v3r8m7/sqlite-run/lib/libsqlite3.a
sqlite-v3r8m7/sqlite-run/bin/
sqlite-v3r8m7/sqlite-run/bin/sqlite3
sqlite-v3r8m7/sqlite-run/include/
sqlite-v3r8m7/sqlite-run/include/sqlite3.h
sqlite-v3r8m7/sqlite-run/include/sqlite3ext.h
sqlite-v3r8m7/sqlite-run/share/
sqlite-v3r8m7/sqlite-run/share/man/
sqlite-v3r8m7/sqlite-run/share/man/man1/
sqlite-v3r8m7/sqlite-run/share/man/man1/sqlite3.1
sqlite-v3r8m7/config.log
sqlite-v3r8m7/config.status
sqlite-v3r8m7/.libs/
sqlite-v3r8m7/.libs/libsqlite3.lai
sqlite-v3r8m7/.libs/libsqlite3.a
sqlite-v3r8m7/.libs/libsqlite3.la -> ../libsqlite3.la
sqlite-v3r8m7/Makefile
sqlite-v3r8m7/sqlite3.pc
sqlite-v3r8m7/sqlite3
sqlite-v3r8m7/.deps/
sqlite-v3r8m7/.deps/shell.Po
sqlite-v3r8m7/.deps/sqlite3.Plo
sqlite-v3r8m7/sqlite3.o
sqlite-v3r8m7/libtool
sqlite-v3r8m7/libsqlite3.la
sqlite-v3r8m7/$UPDATES
sqlite-v3r8m7/shell.o
sqlite-v3r8m7/$$README.txt
sqlite-v3r8m7/$README.txt
sqlite-v3r8m7/ASMACL.jcl
sqlite-v3r8m7/COBSQLTE.cpy
sqlite-v3r8m7/COBTEST1.jcl
sqlite-v3r8m7/COBTEST2.jcl
sqlite-v3r8m7/IGYWCL.jcl
sqlite-v3r8m7/LINK.jcl
sqlite-v3r8m7/PLICB.jcl
sqlite-v3r8m7/PLISQLTE.pli
sqlite-v3r8m7/SQLITE3A.s
sqlite-v3r8m7/TESTCOB1.cbl
sqlite-v3r8m7/TESTCOB2.cbl
sqlite-v3r8m7/TSTPLI1.pli
sqlite-v3r8m7/UNPAX.jcl
sqlite-v3r8m7/cobtest2-db.pax.Z
sqlite-v3r8m7/sqlite3.lo
