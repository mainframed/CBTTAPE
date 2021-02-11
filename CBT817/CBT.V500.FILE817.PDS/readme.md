
## @FILE817.txt
```
//***FILE 817 is from Mike Wojtukiewicz and contains his program    *   FILE 817
//*           called FIXCATLG to generate JCL that recatalogs       *   FILE 817
//*           (without scratching) all datasets on certain volumes  *   FILE 817
//*           in a new catalog.  This program also contains a       *   FILE 817
//*           second output to create input to SMP/E that makes     *   FILE 817
//*           DDDEF entries for all the mentioned datasets.         *   FILE 817
//*                                                                 *   FILE 817
//*           This program is meant to run as an assembly, link,    *   FILE 817
//*           and go.  But it can be run as a load module.  The     *   FILE 817
//*           requisite source for both methods of operation is     *   FILE 817
//*           included in this file.                                *   FILE 817
//*                                                                 *   FILE 817
//*           Some more programs from Mike Wojtukiewicz are being   *   FILE 817
//*           included here:                                        *   FILE 817
//*                                                                 *   FILE 817
//*       Q390TIOT - Program to determine if a DDname is present    *   FILE 817
//*                  in a job step.                                 *   FILE 817
//*                                                                 *   FILE 817
//*  email:  Michael Wojtukiewicz <mwojtukiewicz@infinite-blue.com> *   FILE 817
//*                                                                 *   FILE 817
//*  Copyright by Mike Wojtukiewicz.                                *   FILE 817
//*                                                                 *   FILE 817
//*  Function of this code:                                         *   FILE 817
//*                                                                 *   FILE 817
//*  You supply 2 items:                                            *   FILE 817
//*                                                                 *   FILE 817
//*  1 - MASTERCatalog you wish to catalog datasets in (it is your) *   FILE 817
//*      responsibility to IMPORT it if it doesn't exist on your    *   FILE 817
//*      present system.                                            *   FILE 817
//*                                                                 *   FILE 817
//*  2 - A list volsers and symbols to use.                         *   FILE 817
//*                                                                 *   FILE 817
//*  What this program then does is list the datasets on all the    *   FILE 817
//*  volumes and then deletes without scratching and defining the   *   FILE 817
//*  datasets on those volumes with their corresponding symbolic    *   FILE 817
//*  value using IDCAMS                                             *   FILE 817
//*                                                                 *   FILE 817
//*      and                                                        *   FILE 817
//*                                                                 *   FILE 817
//*  Creates DDDEF statements for UCLIN processing to connect a     *   FILE 817
//*  Target/DLIB ddname to a dataset on a specific VOLSER.          *   FILE 817
//*                                                                 *   FILE 817
//*  2 datasets will be defined to run in their respective IDCAMS   *   FILE 817
//*  and SMP/E batch jobs. See <<<=== at the bottom of what to      *   FILE 817
//*  modify for your job to run.                                    *   FILE 817
//*                                                                 *   FILE 817
//*  Example of output:                                             *   FILE 817
//*                                                                 *   FILE 817
//*    CATALOG.DATA                                                 *   FILE 817
//*                                                                 *   FILE 817
//*   DELETE ADCD.ISPPLIB                        NVSAM NSCR -       *   FILE 817
//*          CATALOG(CATALOG.ZOS10.MASTER              )            *   FILE 817
//*   DEF    NVSAM(NAME(ADCD.ISPPLIB                     ) -        *   FILE 817
//*          DEVT(0000) VOLUMES(******   )) -                       *   FILE 817
//*          CATALOG(CATALOG.ZOS10.MASTER              )            *   FILE 817
//*      * * * * *                                                  *   FILE 817
//*                                                                 *   FILE 817
//*    DDDEF.DATA                                                   *   FILE 817
//*                                                                 *   FILE 817
//*   REP DDDEF(ISPPLIB ) DATASET(ADCD.ISPPLIB     )                *   FILE 817
//*       UNIT(3390)      VOLUME(ZOSRS1) SHR .                      *   FILE 817
//*      * * * * *                                                  *   FILE 817
//*                                                                 *   FILE 817
```

