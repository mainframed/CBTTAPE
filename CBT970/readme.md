```
//***FILE 970 is from Kenneth Tomiak and contains a variant of the  *   FILE 970
//*           RCNVTCAT REXX EXEC from CBT File 542, which generates *   FILE 970
//*           DEFINE statements to recatalog entries from an old    *   FILE 970
//*           catalog into a new catalog (usually for a new z/OS    *   FILE 970
//*           system).                                              *   FILE 970
//*                                                                 *   FILE 970
//*           The RCNVTCA$ on File 542 JCL has been reported to     *   FILE 970
//*           fail on current systems. Changing PGM=IRXJCL to       *   FILE 970
//*           PGM=IKJEFT1B was part of the fix. Running as a batch  *   FILE 970
//*           job still had issues, and so Kenneth embarked on      *   FILE 970
//*           simplifying the REXX code and then added some user    *   FILE 970
//*           interface enhancements.                               *   FILE 970
//*                                                                 *   FILE 970
//*           RCNVTCAT has been traditionally used to create a new  *   FILE 970
//*           master catalog from the old master catalog on the     *   FILE 970
//*           old system, recataloging the old entries in the       *   FILE 970
//*           new catalog, after editing them (when necessary).     *   FILE 970
//*                                                                 *   FILE 970
//*           Kenneth has fixed the format of the TCNVTCA$ JCL      *   FILE 970
//*           and the TCNVTCAT REXX exec so that it runs as both    *   FILE 970
//*           a batch job and under TSO. In addition, if you have   *   FILE 970
//*           launched under ISPF then a PROGRESS panel will be     *   FILE 970
//*           displayed to keep you occupied as it runs.            *   FILE 970
//*                                                                 *   FILE 970
//*           It can still be used as a replacement for IBM's       *   FILE 970
//*           MCNVTCAT program, which IBM no longer supports.       *   FILE 970
//*                                                                 *   FILE 970
//*           2018-02-27 Update                                     *   FILE 970
//*           Included a missing Find_Hostdsn routine.              *   FILE 970
//*                                                                 *   FILE 970
//*           email:  sbgolob@cbttape.org                           *   FILE 970
//*                                                                 *   FILE 970

```
