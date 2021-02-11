This utility is able to get a interactve report from a LOGREC
from MVS on-line file or archived, without to submit job jcl.
It'll verify the coherent of paramiters before to execute pgm.

It was tested with OS/390 rel. 2.6 and as far as
z/OS rel. 1.10

The EREP package is a mix of 1 Rexx pgms and 6 ISPF panels,
plus, not mandatory, a file/library for defaults list archive.
It is possible to customize a default in "Standard default  ..."
section without use external list.

 EREP        : Main rexx program to call interactive IFCEREP1 pgm
 EREPP@00-05 : ISPF panels for interactive use under ISPF
 EREPHLQ     : Eg. list default systems with owned archive files
 LIBDEF      : Eg. for dynamic allocation library

I put all in one library: REXX pgm, ISPF panels and examples.
You can split into more if you'd like.

The REXX pgms expect a static allocation of ISPF libraries.
To do dynamic allocation or to test the use of LIBDEF for a pds.

To install, receive on your z/OS system with "BIN" options and
then unpack into a library with :

  RECEIVE INDSN(--------.EREPRPT.XMI)
  Dataset DB00988.REXX.EREPRPT from DB00988 on NJEMVS0
  Enter restore parameters or 'DELETE' or 'END' +
  DSN(in-your-lib-name)

Pay attention to Prerequisite sections described in EREP, if
you do not obey, you might get a "SYSTEM COMPLETION CODE=047".
There is DOCUMENTATION in WORD format to explain how this works,
but in the Italian language.
I was lazy to translate, but it may be useful to look at the
images inside to see examples.

*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.
