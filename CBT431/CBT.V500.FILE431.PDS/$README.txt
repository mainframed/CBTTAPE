README for Distributions in This Directory

March 25, 1998

Contents:

BRACKETS - ISPF usermod and associated TSO facilities for
           displaying and editing square brackets on a 3270

BRACKET4 - ISPF Version 4 version of BRACKETS

TSOREXX  - utilities to emulate CLIST functions PROC and WRITENR
           in REXX execs

Instructions:

 FTP the appropriate distribution file to your MVS system first.

 Use something like the following:

 To FTP foo.distrib.cntl (source distribution):

  ftp this.ftp.site.com
  anonymous
  password@myhost.mydomain
  cd /this/ftp/directory
  get foo.distrib.cntl FOO.DISTRIB.CNTL
  quit

 To FTP foo.distobj.cntl (object distribution):

  ftp this.ftp.site.com
  anonymous
  password@myhost.mydomain
  cd /this/ftp/directory
  binary
  locsite recfm=fb lrecl=80 blksize=6160
  get foo.distobj.cntl FOO.DISTOBJ.CNTL
  quit

 Please note that the *source* distribution is probably stored as a
 RECFM=VB LRECL=259 file, to save space and speed up file transfer.
 The *object* distribution is stored as RECFM=FB LRECL=80 because
 there's no other way to store combination EBCDIC and object text
 in a binary file.

 Either of these is one large JCL stream that executes the IEBUPDTE
 utility to build several PDS's.  These PDS's are generally named
 with a convention like:

 FOO.INSTALL.CNTL    JCL to complete the build, readmes, miscellany
 FOO.INSTALL.CLIST   CLISTs and REXX execs
 FOO.INSTALL.PANEL
