```
//***FILE 567 is from Clark Jennings, and contains some tools to    *   FILE 567
//*           monitor LLA performance and to report on SMF Type 41  *   FILE 567
//*           records.  This file also has a CSVLLIX2 exit to       *   FILE 567
//*           capture module fetch information.                     *   FILE 567
//*                                                                 *   FILE 567
//*           email:  clarkjennings@yahoo.com                       *   FILE 567
//*                                                                 *   FILE 567
//*   LLA Module Fetch Analysis Tools                               *   FILE 567
//*                                                                 *   FILE 567
//*   **DISCLAIMER**                                                *   FILE 567
//*   NO WARRANTY IS MADE TO THE ACCURACY OF THE PROGRAMS OR        *   FILE 567
//*   RELATED MATERIAL AND NO RESPONSIBILITY IS ASSUMED FOR         *   FILE 567
//*   ANY MODIFICATION DIRECTLY OR INDIRECTLY CAUSED BY THE         *   FILE 567
//*   USE OF THIS SOFTWARE.  IT IS THE USER'S RESPONSIBILITY        *   FILE 567
//*   TO EVALUATE THE USEFULNESS OF THE MATERIAL SUPPLIED.          *   FILE 567
//*                                                                 *   FILE 567
//*   This library contains the following members:                  *   FILE 567
//*                                                                 *   FILE 567
//*   $$DOC    - This member                                        *   FILE 567
//*                                                                 *   FILE 567
//*   CSVLLIX2 - LLA exit that collects module fetch information    *   FILE 567
//*              for LLA managed libraries.  The exit obtains       *   FILE 567
//*              storage in the LLA address space.  A WTO is        *   FILE 567
//*              issued with the address of this storage area.      *   FILE 567
//*              The usage information contained in the storage     *   FILE 567
//*              area can be viewed with any MVS monitor or tool    *   FILE 567
//*              that displays another task's storage.  The exit    *   FILE 567
//*              has been tested with OS/390 2.10.                  *   FILE 567
//*                                                                 *   FILE 567
//*   SMFLLA     SAS program that reports I/O activity in LLA.      *   FILE 567
//*              The program has been tested with OS/390 2.10.      *   FILE 567
//*                                                                 *   FILE 567
//*   SMF41S     SAS program that summarizes SMF type 41 records.   *   FILE 567
//*              The program has been tested with OS/390 2.10.      *   FILE 567
//*                                                                 *   FILE 567

```
