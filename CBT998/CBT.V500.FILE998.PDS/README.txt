Execute the $INSTALL member of this PDS to perform a TSO RECEIVE of the
TSO Transmit (XMIT) members. This will create the RACFROD execution time
libraries.

Then copy the EXEC library member STUB into a library in your SYSEXEC,
or SYSPROC, allocation and tailor it to reference the RACFROD libraries.
It is suggested that the member name of STUB be changed to RACFROD.

Then to start the application from any ISPF panel issue TSO RACFROD.
