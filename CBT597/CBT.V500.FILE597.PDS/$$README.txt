==================================
INTRODUCTION TO MPFCMDS PROCESSING
==================================

This file is from Hans Westheim of Essent Energy Netherlands.

   email: hans.westheim@essent.nl

The file created at 17 oct 2002
Current Operating Systems at Essent OS/390 2.10

MPFCMDS is an alternative for MPFXTALL at file 345. MPFXTALL (on my
configuration abends A37-08). MPFCMDS is also a better alternative
because it is more of a building block principle. By using this
building block principle it is easier to maintain and enhance.
MPFCMDS makes use of all the fancy things off "COMMAND (FILE 088)".
By using COMMAND it can also issue reply's. (This was one of the
limitations of MPFXTALL.)

MPFCMDS is a very simple tool which can be invoked through MPFLST
members of your PARMLIB(s) in order to respond automatically to the
appearance of any message on the operator's console.


OPERATION

For any message to be automated, it must appear in an
MPFLSTxx member with an entry such as the following:

IST123I,USEREXIT(MPFCMDS)

When message IST123I occurs, standard MVS MPF processing will invoke the
MPFCMDS exit. MPFCMDS extracts the message id from the first 8 bytes
of the message text and then executes the procedure MPFCMDS with the
parameter MEMBER=IST123I. This procedure executes COMMAND (found at CBT
file 088) and uses as input the member IST123I from YOUR.CMDS.PDS.
Having found this member, COMMAND reads each line and, if it is not a
comment (an asterisk in column 1), issues the command as supplied.

LIMITATIONS

Message numbers are restricted to a maximum of 8 bytes (length of a PDS
member name).  No code has been implemented to handle longer messages.
The commands than can be used in the input member is limited by the
program "COMMAND". For details, have a look at member $COMMAND.
This program could also be substituted with an other command-processor.
(Just update procedure MPFCMDS for this).
