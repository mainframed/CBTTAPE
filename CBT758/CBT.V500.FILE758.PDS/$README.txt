Documentation for each module is contained within its source code.

You will need to assemble each module and bind it into a load
library.  The necessary macros are provided.

Sample execution JCL for LOADWRD1 is contained within its source
code.  LOADBTCH is called by LOADWRD1, it is not executable on its own.

The author can be contacted at cschneid_loadword@yahoo.com, please
include the text LOADWORD in the subject line.

When executed, LOADWRD1 will LOAD (via LOADBTCH) the members listed on
the SYSUT1 DD from the load library specified on the LOADLIB DD and
search it for the strings specified on the SYSUT2 DD.

SYSUT3 will have 80 byte output records written to it, one for each
module and string found within it.

SYSPRINT will have 80 byte records written to it, one for each module
as it is processed.  It's like a progress indicator.

 SYSUT1 format is
 MMMMMMMM
 where
 MMMMMMMM is the module name

 SYSUT2 format is
 LLLL SSSSSSSS
 where
 LLLL     is the string length left padded with zeroes
 SSSSSSSS is the string to be searched for (up to 75 bytes long)

 SYSUT3 format is
 MMMMMMMMOOOOOOOOSSSSSSSS
 where
 MMMMMMMM is module name
 OOOOOOOO is offset in module where string was found
 SSSSSSSS is the string that was found

 //LOADWRD1 EXEC PGM=LOADWRD1
 //STEPLIB  DD  DISP=SHR,DSN=YOUR.LOADLIB.HERE
 //LOADLIB  DD  DISP=SHR,DSN=LOADLIB.TO.SEARCH.HERE
 //SYSUT1   DD  *
 MEMNAME1
 MEMNAME2
 MEMNAME3
 MEMNAME4
 MEMNAME5
 //SYSUT2   DD  *
 0030 SOME STRING TO SEARCH FOR HERE
 0036 SOME OTHER STRING TO SEARCH FOR HERE
 //SYSUT3   DD  SYSOUT=*,LRECL=80,BLKSIZE=8000
 //SYSPRINT DD  SYSOUT=*
 //*

