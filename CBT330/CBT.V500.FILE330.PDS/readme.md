
## $$README.txt
```

Hi Sam,

During my last contract, i've migrated CICS/ESA to CICS/TS 1.3
During the migration i've developed a little ISPF tool to analyze the
CICS CSD File and the CICS Logger SMF 88 records.

I thought I'd polish these bits of code up and submit them to the CBT-Tape.
I hope they may be of use.

Standard CBT procedure is used.
Save it to your PC.
upload it to your mainframe in binary form without
EBCDIC conversion or CRLF.
Do a TSO RECEIVE on it.


The xmitted file contains :

CCSDFILE - A xmitted file with several xmitted PDS datasets
           Transmit this file to OS/390
           Receive the file
           After that you can see the following members:
           CCSDEXEC
           CCSDLOAD
           CCSDPENU
           CCSDSENU
           CCSDTENU
           Do an additional receive for every member to your
	          target dataset or use the supplied sample job $RECVALL
           Follow member $INSTALL.

Disclaimer
==========

These stuff is supplid on an as is basis.

No Guarantee is given or should be assumed.

It's the users responsibility to check the value and correctness of
this tool.

Therefor the usual disclaimer: Use at your own risk, blah,
blah, blah, didle, dadle, didle, dadle.


Error correction will be supplid from time to time

Language Problems
=================

I've tried to put all comments in english (bad english),
but there are still some procedures or places where you can see
a german comment.
If you are interested in these comments then you can do a little exercise
and try to translate it to english.


Suggestions and improvements are welcome.


Enjoy it  ...... Fritz :-)


***********************************************************************
* For further information, please contact me under following address: *
*                                                                     *
* Fritz Alber                                                         *
*                                                                     *
* phone: ++49 (0)1717224572 (mobile)  facsimile: ++49 (0)7022959236   *
*          e-mail: alber@alber-edv.de                                 *
*                                                                     *
* Regards and cheers                                                  *
***********************************************************************

```

