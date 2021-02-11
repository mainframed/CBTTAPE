This package contains TWO VERSIONS of the SYSOUT Retrieval
Services (SRS) product:

** SRS V1.3.0 is for z/OS 1.9 and higher *ONLY*     **  (member SRS130)
** SRS V1.2.1 is for all supported releases of z/OS **  (member SRS121)

Load libraries for each of these versions, have been provided for
your convenience.

Executable code is in XMIT format.  To expand (under TSO):

   RECEIVE INDS(this.dataset(SRS121))
   RECEIVE INDS(this.dataset(SRS121L))

             or

   RECEIVE INDS(this.dataset(SRS130))
   RECEIVE INDS(this.dataset(SRS130L))

Please select the installation directory appropriate for your
release of z/OS and review the $INSTALL member in that directory
for installation instructions.

After restoring the SRS source library, you can review the $NEWS
member to see what's new in this SRS release.

The $ABOUT member in this pds contains a brief overview of
SRS and a list of supported options.

