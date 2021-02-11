```
//***FILE 406 is from Ed Molnar of Computer Data Systems and        *   FILE 406
//*           contains two TSO command processors.  This file was   *   FILE 406
//*           originally on the CBT Tape many years ago, before     *   FILE 406
//*           Arnie Casinghino started doing his wholesale          *   FILE 406
//*           deletions.  I put it back because the programs,       *   FILE 406
//*           although old, are very useful.  The two CPs are:      *   FILE 406
//*           CQ (I call it CQX), and FIND.                         *   FILE 406
//*                                                                 *   FILE 406
//*           email:  sbgolob@cbttape.org                           *   FILE 406
//*                                                                 *   FILE 406
//*       Descriptions:                                             *   FILE 406
//*                                                                 *   FILE 406
//*           A. CQX  (renamed from CQ)                             *   FILE 406
//*                                                                 *   FILE 406
//*              (Modified by S.Golob to increase GETMAIN sizes.)   *   FILE 406
//*                                                                 *   FILE 406
//*              This CP is used to cancel and delete all jobs      *   FILE 406
//*              with a given jobname, off the input and output     *   FILE 406
//*              queues.  This command only authorizes itself       *   FILE 406
//*              when calling the subsystem interface.  This        *   FILE 406
//*              command, as coded, uses an "authorizing SVC",      *   FILE 406
//*              but if you authorize it during linkedit, and       *   FILE 406
//*              run it from an APF authorized library, you don't   *   FILE 406
//*              need the SVC.  The SVC number must be changed for  *   FILE 406
//*              the authorizing of this function to what ever      *   FILE 406
//*              number is used for your installation.  This        *   FILE 406
//*              should be the only installation dependent item     *   FILE 406
//*              in this code.  The format for this command is:     *   FILE 406
//*              "CQ jobname", which will purge all jobs having     *   FILE 406
//*              the given jobname (even running ones), or          *   FILE 406
//*                                                                 *   FILE 406
//*              "CQ (jobname(jobid),jobname(jobid)....jobname)"    *   FILE 406
//*                                                                 *   FILE 406
//*              which will only kill the jobs having the given     *   FILE 406
//*              job numbers.                                       *   FILE 406
//*                                                                 *   FILE 406
//*              Be very careful.                                   *   FILE 406
//*                                                                 *   FILE 406
//*              (Tested on z/OS 2.2 and it seems to purge          *   FILE 406
//*              running jobs, but when RC=28 from SSOBRETN is      *   FILE 406
//*              nullified, it purges STC's and TSU's in the        *   FILE 406
//*              print queue, but not those that are running.)      *   FILE 406
//*              See the code to find out how to nullify RC=28      *   FILE 406
//*              from the SSOBRETN call.  The code is not being     *   FILE 406
//*              shipped to do that.  (Safer.)                      *   FILE 406
//*                                                                 *   FILE 406
//*           B. FIND                                               *   FILE 406
//*                                                                 *   FILE 406
//*              Fixed for z/OS 2.2.  UCB routines, DASD types      *   FILE 406
//*              updated.  (Original program, written in 1978, is   *   FILE 406
//*              still included as member FIND01.)                  *   FILE 406
//*                                                                 *   FILE 406
//*              This is a data set search routine.  The idea is    *   FILE 406
//*              to find cataloged and all uncataloged copies of    *   FILE 406
//*              the data set name.                          .      *   FILE 406
//*                                                                 *   FILE 406
//*              The CP prompts for the dataset name, and does      *   FILE 406
//*              some standard ckecking.  It the searches the       *   FILE 406
//*              catalog to find the entry.  After the catalog is   *   FILE 406
//*              searched it then searches the UCB entries and      *   FILE 406
//*              compares them with our DASD types.  This list is   *   FILE 406
//*              incorprated within the code and may be added to    *   FILE 406
//*              easily.  It obtains the volume name and ckecks     *   FILE 406
//*              the VTOC for the Format 1 DSCB.  Also, if there    *   FILE 406
//*              is a alternate path there is a second address in   *   FILE 406
//*              the tabel pointing to the device.  Therfore a      *   FILE 406
//*              second search is done and if a 'hit' is made a     *   FILE 406
//*              second message is produced.  A second character    *   FILE 406
//*              table is put in for the convenience of others.     *   FILE 406
//*                                                                 *   FILE 406
//*                                                                 *   FILE 406
//*              Sample output of FIND:                             *   FILE 406
//*                                                                 *   FILE 406
//*              SYS1.W$$.LINKLIB                                   *   FILE 406
//*              DATASET CATALOGED ON VOL: VPWRKA                   *   FILE 406
//*              DEV ADDRESS: D30 VOL: VPWRKA TYPE: 3390            *   FILE 406
//*              DEV ADDRESS: D32 VOL: VPWRKC TYPE: 3390            *   FILE 406
//*                                                                 *   FILE 406
//*              (lower report also shows uncataloged copies)       *   FILE 406
//*                                                                 *   FILE 406

```
