                               OSTARXMT
                               ========

  Author  : Ron MacRae.

  Address : ObjectStar Support, Amdahl UK Ltd, Cromwell House,
               Bartley Way, Hook, Hampshire, RG27 9XA, UK.

    Email :  Ron_MacRae@amdahl.com.

    Phone : +44-1252-346379.

  The purpose of this package of 2 REXX and 1 assembler programs is to
provide a simple method for packaging and unpackaging multiple MVS
datasets for transmission over the internet in a reliable way.

  These programs have grown over the years as our, and our customers',
requirements have changed.  There are better ways to do this and if I
was starting from scratch I would do this a different way, but it works
and I don't have time to fix it.

  If you want to try it out copy the OSTARXMT & OSTARREC REXX progs to a
dataset in your SYSPROC/SYSEXEC concatenation and type "OSTARXMT ?" and
"OSTARREC ?" at the TSO command prompt.  This is all you need for the
basic functions.

 The assembler program OSTAREDC is not required as all its functions
are duplicated in the REXX progs but it improves performance by over
90%.  Also if you have IBM's TRSMAIN compression utility available,
which is available from IBM via the www, you can plug this in to add
data compression.  If you want to use either of these then edit both the
REXX programs, find OSTAREDC or TRSMAIN in column 1 and update the
dataset name(s) to point to where the programs reside.

-----------------------------------------------------------------------

How it works
============

  OSTARXMT takes as input the name of 1 output file, which must not
exist, and the names of 1 or more input files, which must exist.

  Each input file is run through TSO TRANSMIT to convert it to a FB80
file.

  Each FB80 file is then processed to add error detection codes to the
end of each line and each file to give 2 dimensional checks in the data
and all the files are concatenated into the output 'XMT' file.  If
OSTAREDC is available this is done in assembler instead of REXX.  On a
CPU constrained system this can reduce the elapsed time by over 95%.

  If TRSMAIN is available this XMT file is compressed into an XM1 file.

  The XMT/XM1 file is then transmitted in binary to it's destination

  OSTARREC is run on the target system against the uploaded file,
probably using ISPF 3.4, and it reverses the steps taken by OSTARXMT.
If the AUTONAME option is not used the user is prompted by TSO
RECEIVE for dataset name(s).

Some History
============

  Over the last 3-4 years Amdahl have been using the internet to
distribute MVS PTFs, documentation, e.t.c. to customers. We initially
sent text files as ASCII and PTFs as binary but we had all sorts of
problems because the files were uploaded incorrectly into files with
with the wrong DCB info or with ascii/binary wrong.

  We then standardised that all files would be in TSO transmit format
which the customers could upload to MVS and then use TSO receive to
reconstruct. We still had occasional problems with corrupt data which
were normally resolved by redoing the FTP or IND$FILE command.  We also
had problems because we often had to ship multiple MVS datasets and
these got mixed up, duplicated, lost by the time the datasets made their
way to the customers' MVS systems.

  OSTARXMT & OSTARREC were written to enable us to package multiple MVS
files into a single dataset that was easy to FTP and would have checking
ON THE TARGET SYSTEM to ensure no data had been corrupted during the
multiple FTP processes used to get the data from our MVS system to the
customers'.

  Over time customers started to send us diagnostics over the internet.
These diagnostics could be SVC dumps of up to 1GB in size. We also
wanted to send out complete put levels of software via the internet.
The REXX programs were taking too long to run and the output was beyond
the scope of many internet connections. I therefore modified the REXX
programs to do most of the work in an assembler subroutine, OSTAREDC,
and allow the use of the TRSMAIN compression utility if the customer had
it.

  We've made the use of OSTARXMT & OSTARREC for internet transmission
mandatory and also set up REXX programs to drive the FTP process at our
end between our MVS systems and our FTP server. These two actions, for
customers who use OSTARXMT and OSTARREC, have reduced our failure rates
to almost 0.  When we do get problems it is usually easy to spot the
error. Normally either ASCII transmission or a real bit error in
transmission.

  This is where we're at today but I have plans to use hardware
compression to replace TRSMAIN, when time permits.
