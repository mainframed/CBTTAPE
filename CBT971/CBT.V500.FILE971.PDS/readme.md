
## @FILE971.txt
```
//***FILE 971 is a batch program called EMPTYTST, which is          *   FILE 971
//*           designed to find out if a sequential dataset          *   FILE 971
//*           (DSORG=PS) or a PDS member is empty.  This may        *   FILE 971
//*           be needed for JCL jobstreams to find out the outcome  *   FILE 971
//*           of a job step (if it produced any data) and to        *   FILE 971
//*           then proceed with the jobstream, depending on the     *   FILE 971
//*           return code.                                          *   FILE 971
//*                                                                 *   FILE 971
//*           Support:  email to  sbgolob@cbttape.org               *   FILE 971
//*                                                                 *   FILE 971
//*                     email:    gerhardp@charter.net              *   FILE 971
//*                                                                 *   FILE 971
//*     The EMPTYTST program is reentrant.                          *   FILE 971
//*                                                                 *   FILE 971
//*     Improvements to the original source of EMPTYTST, were       *   FILE 971
//*     made by Gerhard Postpischil, and bugs were corrected        *   FILE 971
//*     through the collaboration of Gerhard and the original       *   FILE 971
//*     author.                                                     *   FILE 971
//*                                                                 *   FILE 971
//*     Enhanced the SYSPRINT report with job and time information  *   FILE 971
//*     that was already available in the JESMSGLG and JESYSMSG     *   FILE 971
//*     reports.  You might be following the progress of your       *   FILE 971
//*     jobs using the SYSPRINT reports only, so that information   *   FILE 971
//*     detail is needed there.                                     *   FILE 971
//*                                                                 *   FILE 971
//*     Help documentation is in member EMPTYTS#.                   *   FILE 971
//*                                                                 *   FILE 971
//*     Sample JCL to Run - Needs SYSUT1 DDname for input dataset   *   FILE 971
//*                   SYSPRINT is optional. PARM=Q suppresses it.   *   FILE 971
//*                   WTO output is available with PARM=W.          *   FILE 971
//*                                                                 *   FILE 971
//*     //  jobcard                                                 *   FILE 971
//*     //*                                                         *   FILE 971
//*     //CHKEMPTY EXEC PGM=EMPTYTST,PARM=W                         *   FILE 971
//*     //STEPLIB  DD DISP=SHR,DSN=your.steplib                     *   FILE 971
//*     //SYSUT1   DD DISP=SHR,DSN=dataset(member)                  *   FILE 971
//*     //SYSPRINT DD SYSOUT=*                                      *   FILE 971
//*                                                                 *   FILE 971
//*     Program Action:                                             *   FILE 971
//*                                                                 *   FILE 971
//*     RETURNS CODE = 0 IF DATASET IS NOT EMPTY.                   *   FILE 971
//*     RETURNS CODE = 4 IF DATASET IS EMPTY.                       *   FILE 971
//*     JCL ERROR IF A SEQUENTIAL DATASET (DSORG=PS)                *   FILE 971
//*       DOES NOT EXIST.                                           *   FILE 971
//*     RETURNS CODE = 8 IF PDS MEMBER DOES NOT EXIST.              *   FILE 971
//*     RETURNS CODE = 12 IF SYSUT1 DDNAME IS MISSING.              *   FILE 971
//*     RETURNS CODE = 16 IF SYSUT1 POINTS TO A CONCATENATION.      *   FILE 971
//*                                                                 *   FILE 971
//*     Codes 0, 4, and 8 return the dataset name and volume,       *   FILE 971
//*     in the messages.  (WTO if PARM=W, SYSPRINT if it is         *   FILE 971
//*     present as a DDname and PARM=Q was not coded.)              *   FILE 971
//*                                                                 *   FILE 971
//*     We hope that you'll find this to be a useful tool.          *   FILE 971
//*                                                                 *   FILE 971
```

