  Small notes from Sam Golob:       In this dataset:

    I think that the most "customized" version of the COMPILE
    and LINKEDIT JCL for the GZIP load module is member
    #CLNKSBG.  You have to merely change my userid to yours,
    and change the COPTS member in File 333 from 'prefix' to
    your high level qualifier for File 334.

    MAKE_*** members have been changed to #***, because of
    MVS file naming conventions.  Periods have been changed to
    @ (at signs) and Underlines _ have been changed to #.
    These are JCL members for compiling and linkediting various
    modules.

    GO.*** members have been changed to GO@*** for the same reason.
    These are sample JCL members for running GZIP.

    Member #CLNKJCL is from Roland Schiradin, and is sample
    compile and linkedit JCL for GZIP/MVS.  I'd start with
    member #CLNKSBG, if I were you.

    Member CCMPOPTS is the C-compiler options set for GZIP in member
    #CLNKJCL.
    Member COPTS is the C-compiler options set for GZIP in member
    #CLNKSBG.

    Member XMITLOAD is an executable load module library in
    TSO XMIT format.  If you do RECEIVE INDATASET(this.libr(XMITLOAD))
    or copy it to a sequential file and do a RECEIVE under TSO,
    you'll get executable (already compiled and linkedited) load
    modules.

  -------------------------------------------------------------------

This is a small 'readme' for all those guys trying to port gzip to an
IBM mainframe running under MVS or VM/CMS and using the IBM C/370
compiler.

The first thing is to get (a little bit) familiar with your C/370.
Get the manuals "IBM C/370 User's Guide" and the "Common Programming
Interface C Reference".

Please check if your TSO-session accepts the C/370 code point
mappings, that is: do the chars (especially { } ¢ | \...) typed in by
TSO-edit have the same hex-values as expected by the 'code point
mappings' (App. E in the Users' Guide' If not please use the scanner.c
source provided in this folder to get the changes done, of course
accustom the source if necessary.

Contents:
- readme:    this file

- c370.h and c370.c: this is a small interface for the C/370-library
    providing some Unix-like header-files, in this case there are
    stat.h, dirent.h (for partitioned datasets), io.h,...  feel free
    to complete this stuff - and let me know what you've done.
    generally replace #include-statements in sources like #include
    <sys/stat> by #include "c370.h" or something like that.

- hdcc: that's a JES-procedure for compiling C-sources. As you can see
    the 'scanner' is invoked. Please omit if you don't need that.

- #gzp: that is a JES-Job containing a complete make of all
    sources needed for gzip. As far as you know there is no unix-like
    'make' available for C/370...  :-(  But the C/370 compiler is VERY
    fast (cause of the FAST hardware...) it doesn't matter if you
    compile the whole stuff again (or not).  Of course you have to
    adapt the DSNames of this job, eg: replace my userid (IE23218)
    with yours and check them very closely.

- scanner.c: that's a small C-source used for replacements for
    hex-values of C-sources as I described some lines before. It is
    easy to adapt to other (TSO-environments) but at least I don't
    hope that you'll need this stuff

- go: you can start C370-Programs as a JES-batch Job. Please see the
    file 'go' for further information. And you can start C-programs as
    TSO foreground applications, please enter  call
    'userid.loadmod(member)' as a TSO command. see the User's guide
    for more info

General remarks for porting C-sources:
of course you can try to port other sources to the IBM mainframe.
Things to check are

- ASCII-EBCDIC stuff: replace char-comparisons like (ch < ' ') or ('A'
    <= ch && ch <= 'Z') by functions provided with  <ctype.h> like
    tolower(), toupper(), isprint(), isdigit(),....  that's vital!!!!
    also check for constant hex-chars like \007, \012,... and replace
    with \a, \n, \b,... and so on.

- check #include's: hint: make a global compiler-define  #define C370
    and replace #inlcude <abc.h> by
    #ifndef C370
    # include <abc.h>
    #endif
    or provide some dummy-file abc.h in the dataset containing the
    system-include's like <stdio.h>


I've already ported several sources to IBM mainframes: gzip, pgp, des,
gnuchess, popeye. All work proper, but the speed now is incredible!  :-)

If you have problems or more questions feel free to contact me!
<hd@ms.maus.de>           daily, mails < 16KBytes, no uuencoded
<harry@hal.westfalen.de>  daily, no limits

regards,
Harald
