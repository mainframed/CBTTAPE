 The purpose of this file is to enable the user to create a CKD_P370 PC
  DASD emulated file from a mainframe DASD volume, for use on the
  following mainframe emulators P/390, Flex-ES and Hercules.  It is your
  responsibility to be licensed for any products discussed in these
  documents.

 Included in this file are the following freeware software programs
  GZIP for the PC Version 1.2.4, GZIP for the Mainframe Version 1.2.3,
  AWSTAPE source code, XmitManager Version 3, Hercules Version 2.16.5
  and all the necessary CYGWIN dll's.

 I've packaged this so that you can use GZIP or not.
 GZIP    - Depending upon the size of the volume your going to create
           and your CPU size you may want to use GZIP.  The mainframe
           version of GZIP is very CPU intensive.  The PC version is
           very fast.
 No GZIP - The file can be rather large depending upon the file type and
           density of the DASD volume being backed up.  The file size
           you can expect for a 3390-3 can be up to and over 2 Gig, the
           ratio is about 1.25 cylinders per meg.

 Members included
  $$README     This document.
  $INSTRUC     Instructions for creating a CKD_P370 PC file.
  AWSTAPE      Program AWSTAPE and JCL to create a AWSTAPE DASD file.
  DFDSSBK      JCL to create a DFDSS backup DASD file.
  DFDSSSAR     JCL to create a DFDSS stand alone restore card DASD file.
  DISCLAIM     Legal stuff.
  GZIP         GZIP Version 1.2.4 PC exe file.
  GZIPFILE     JCL to create a GZIP DASD file.
  GZIPXMIT     XMIT format mainframe GZIP Version 1.2.3 loadlib.
  HERC216      Hercules Version 2.16.5 PC zipped file.
  QUICKINS     Quick instructions for the brave.
  XMITFILE     JCL to create a XMIT DASD file.
  XMITMAN      XmitManager Version 3 PC install zipped file.

 Author: Glenn Siegel
         S.S.C. Corp.
         Glenn54@aol.com
         631-444-5339
         516-607-4005 Cell
