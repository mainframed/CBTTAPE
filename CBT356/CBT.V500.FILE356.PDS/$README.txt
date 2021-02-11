NETSOL is a public domain VTAM session manager.  It is
based on (Network Solicitor), the original version written in 1981.

See the PDS member DOC for more information.

It is supplied by "David F. Juraschek" <davej@GMU.EDU>

There is also a copy of NETSOL on the GMU web server at:
   http://syscdj1.gmu.edu/netsol
or anonymous ftp at:
   ftp://syscdj1.gmu.edu
   and go to the NETSOL directory.

Here are some comments from Dave on his use of NETSOL.

I make this the default APPLID for various LU's especially all our
TCP/IP terminals (our primary connection methodology).  It presents
the users with a menu of application options (which matches a
USSTAB menu I use for our local terminals), and also includes a number
of "hidden" menu options/choices.  In addition, users can view
installation NEWS and HELP or EXIT (which closes their session - very
useful for IP connected LU's).

As a PD product, full source code is here.  You can enhance or
restrict to your heart's desire.  NETSOL effectively passes the LU
to the desired APPLID associated with your defined options.  You can
also pass appropriate parameters as needed.  NETSOL runs as an STC
on your system and represents almost no load whatsoever.  I run mine
swappable and so it only comes in when a new user attaches to my
system via TCP/IP as it is defined as the default APPLID for all
TN3270 (TELNET) sessions.

From: "David F. Juraschek" <davej@gmu.edu>

David Juraschek
MS 1B5 - UCIS
George Mason University
4400 University Drive
Fairfax, Va.  22030
(703) 993-3353
davej@gmu.edu

