
## @FILE792.txt
```
//***FILE 792 is from Keith Cowden and contains an updated copy of  *   FILE 792
//*           the DISKMAP program from File 260.  This version of   *   FILE 792
//*           DISKMAP contains the EAV enhancements from z/OS 1.10  *   FILE 792
//*           but it also runs on lower levels of z/OS and before.  *   FILE 792
//*                                                                 *   FILE 792
//*           Please address inquiries to Sam Golob:                *   FILE 792
//*           sbgolob@cbttape.org, or sbgolob@attglobal.net         *   FILE 792
//*                                                                 *   FILE 792
//*           Source code for DISKMAP is contained in this file,    *   FILE 792
//*           but it can only be assembled with the z/OS 1.10       *   FILE 792
//*           versions of the IECSDSL1 and TRKADDR macros.          *   FILE 792
//*           Therefore we have included an already assembled       *   FILE 792
//*           load library in XMIT format, as member LOADLIB.       *   FILE 792
//*           If you have z/OS 1.10, you can assemble DISKMAP       *   FILE 792
//*           for yourself.                                         *   FILE 792
//*                                                                 *   FILE 792
//*           All z/OS 1.10 macros needed for assembly (I think):   *   FILE 792
//*                                                                 *   FILE 792
//*           CVAFDSM DCBE IECSDSL1 OBTAIN TRKADDR                  *   FILE 792
//*                                                                 *   FILE 792
//*           To get the load module, issue a TSO RECEIVE command   *   FILE 792
//*           as follows:                                           *   FILE 792
//*                                                                 *   FILE 792
//*           RECEIVE INDS('this.pds(LOADLIB)')                     *   FILE 792
//*                                                                 *   FILE 792
//*           and copy the DISKMAP load module to an APF-authorized *   FILE 792
//*           load library.                                         *   FILE 792
//*                                                                 *   FILE 792
```

