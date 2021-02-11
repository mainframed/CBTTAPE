This zip includes the IND$FILE free (use at your own risk) software.

Submit the ind$file.jcl and load the ind$file.het on the tape drive.

The jcl will install a the following load modules to SYS2.CMDLIB:
   IND$FILE CUT mode file transfer program
   CDPG1047 IBM code page 1047 to ISO-Latin-1 (aka 8859-1)
   CDPG037  IBM code page 037 to ISO-Latin-1 (aka 8859-1)
   CODEPAGE This is a copy of the CDPG1047 module.

Then it will execute the DBSTOP and DBSTART procedures to refresh
the linklist bldl's.

This software was constructed using the Dignus Systems/C software,
http://www.dignus.com/ .

Currently IND$FILE only supports CUT mode file transfers which
limits the buffer size to that of the screen (24x80=~1900).

Please see the codepage.txt file if you need additional codepage
support or simply wish to alter the default code page supplied
for use with ind$file.

Tested emulators    Upload     Download   Notes
TN3270 Plus          Yes        Yes
QWS3270              No         Yes       Downloads only
QWS3270 Plus         Yes        Yes
Attachmate Extra 6.4 Yes        Yes
IBM PCOMM 5.0        No         No        No CUT support


