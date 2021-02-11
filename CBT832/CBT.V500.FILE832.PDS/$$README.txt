This utility is able to print a file or member of a library
from z/OS - OS/390 IBM systems on a TCPIP priter defined
on a LAN network.

It was tested with OS/390 rel. 2.6 and as far as
z/OS rel. 1.9

The PrtLan package is a mix of 2 Rexx pgms and 4 ISPF panels,
plus a file/library for printer definitions :

 PRTLAN     : Maint rexx program to manage printer
 PYPRINT    : Rexx pgm to format output in PostScript print
 PRTLANP1   : ISPF panel for on-line help
 PRTLANP1-3 : ISPF panels for interative use under ISPF
 PRTLSRIN   : Eg. definitions printers
 LIBDEF     : Eg. for dynamic allocation library

All this is included in the PRTLAN.XMI file.
I put all in one library: REXX pgm, ISPF panels and examples.
You can split into more if you'd like.

The REXX pgms expect a static allocation of ISPF libraries
but you can find commented instructions for "LIBDEF" on the side
to do dynamic allocation or to test the use of LIBDEF for a pds.

To install, receive on your z/OS system with "BIN" options and
then unpack into a library with :

  RECEIVE INDSN(--------.PRTLAN.XMI)
  Dataset DB00988.REXX.PRTLAN from DB00988 on NJEMVS0
  Enter restore parameters or 'DELETE' or 'END' +
  DSN(in-your-lib-name)

Pay attention to Prerequisite sections described in PRTLAN.
There is DOCUMENTATION in WORD format to explain how work.

I am supplying text members in IEBUPDTE SYSIN format, or
members in XMIT format.  Use whichever ones you like.
They are a little bit different from each other.

*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.
