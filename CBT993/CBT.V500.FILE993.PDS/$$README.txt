This program started in 2011 as a concept program to determine if COBOL
could process SMF records.  It turns out that as of July 2019, the only
data that COBOL cannot handle is the extended STCKE format 16-byte time
used in the type 126 extended SMF record.  Conversion of STCKE values
is done by an Assembler program CONVETOD.  I could probably write COBOL
to handle this field, but why bother when STCKCONV is available?

There are comments in the code talking about which record types can be
processed.  The DB2 record types 100 and 101 have been placed into
working storage but 102 has not been into this program (yet).  I have
not been able to write or test the DISPLAY logic for these records as I
don't have access to any DB2 system on a mainframe.

If the CICS records are compressed, they need to be uncompressed with
DFH$MOLT before running them into this program as I don't have the
decompression algorithm implemented at this time.  My understanding is
that DB2 also compresses records, so they would also need to be
decompressed before processing by READSMF.

Also, please note that this program is based upon my understanding of
the SMF record types as presented in the System Management Facility
manual for the various releases of z/OS.  Any errors in interpretation
are mine.  And I haven't seen any examples of the relocation records in
any SMF records so far, so I cannot state that my interpretation of them
is correct.

To run this program, assemble CONVETOD into a load library (either PDS
or PDSE should work).  Job CONVEASM should work for this.  Then compile
READSMF using READSMFC job.  I route the compiler output to a data set
as it runs about 1,090,000 lines right now.  The execution JCL is in
READSMFR or READSMFX -- to show different options for displaying data.
Update the job to point to your unloaded SMF data (if you use log stream
use IFASMFDL to dump the SMF data into a VB,32756,32760 data set) and
change the parameters to display the desired record type.  When using
the display record type function, you may need to route SYSOUT to a data
set since the DISPLAY output can be very lengthy.  Some of the record
types can generate multiple thousands of lines of display for each input
record since one field is displayed per output line.  The load module
is X'3D5B5C' bytes or 4,021,084 in decimal.

Also, when you look through the source code you will find occasional
DEBUG DISPLAY statements, generally commented out.  When debugging I'll
put in extra DISPLAY statements and when the issue is resolved I'll
comment them out since it is entirely possible that I'll need to revisit
that section of code as testing proceeds.

