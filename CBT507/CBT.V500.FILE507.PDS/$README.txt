The zip file contains 4 datasets in TSO XMIT format:

LOADLIB
LOADLIB2 (copied using IEBCOPY/COPYMOD to change blocksize to fit on a 3350)
OBJLIB
PROCLIB

The other 2 datasets TPL.V6.DEFAULT.PROFILE and TPL.V6.LOCK.FILE are referenced
in some of the PROCLIBs but are empty datasets.  In order to run the software,
the user should allocate empty datasets of the same name.

 ------------------------------------------------------------------------------
 DSLIST - Data Sets Matching TPL.V6                                 Row 1 of 11
 -------------------------------------------------------------------------------
          TPL.V6.DEFAULT.PROFILE                                         xxx060
          TPL.V6.LOADLIB                                                 xxx060
          TPL.V6.LOCK.FILE                                               xxx060
          TPL.V6.OBJLIB                                                  xxx060
          TPL.V6.PROCLIB                                                 xxx060
 ***************************** End of Data Set list ****************************

Data Set Information

 Data Set Name  . . . : TPL.V6.DEFAULT.PROFILE

 General Data                          Current Allocation
  Volume serial . . . : xxx060          Allocated tracks  . : 1
  Device type . . . . : 3390            Allocated extents . : 1
  Organization  . . . : PS
  Record format . . . : FB
  Record length . . . : 80
  Block size  . . . . : 32720          Current Utilization
  1st extent tracks . : 1               Used tracks . . . . : 1
  Secondary tracks  . : 1               Used extents  . . . : 1

  Creation date . . . : 2000/03/05
  Referenced date . . : 2001/02/13
  Expiration date . . : ***None***


Data Set Information

 Data Set Name  . . . : TPL.V6.LOADLIB

 General Data                          Current Allocation
  Volume serial . . . : xxx060          Allocated tracks  . : 1
  Device type . . . . : 3390            Allocated extents . : 1
  Organization  . . . : PO
  Record format . . . : U
  Record length . . . : 0
  Block size  . . . . : 32760          Current Utilization
  1st extent tracks . : 1               Used tracks . . . . : 1
  Secondary tracks  . : 20              Used extents  . . . : 1

  Creation date . . . : 2000/03/05
  Referenced date . . : 2001/02/13
  Expiration date . . : ***None***

 Data Set Information

 Data Set Name  . . . : TPL.V6.LOCK.FILE

 General Data                          Current Allocation
  Volume serial . . . : xxx060          Allocated tracks  . : 5
  Device type . . . . : 3390            Allocated extents . : 1
  Organization  . . . : PS
  Record format . . . : F
  Record length . . . : 28
  Block size  . . . . : 28             Current Utilization
  1st extent tracks . : 5               Used tracks . . . . : 4
  Secondary tracks  . : 1               Used extents  . . . : 1

  Creation date . . . : 2000/03/05
  Referenced date . . : 2000/12/04
  Expiration date . . : ***None***


Data Set Information

 Data Set Name  . . . : TPL.V6.OBJLIB

 General Data                          Current Allocation
  Volume serial . . . : xxx060          Allocated tracks  . : 36
  Device type . . . . : 3390            Allocated extents . : 1
  Organization  . . . : PO
  Record format . . . : F
  Record length . . . : 3100
  Block size  . . . . : 3100           Current Utilization
  1st extent tracks . : 36              Used tracks . . . . : 34
  Secondary tracks  . : 7               Used extents  . . . : 1

  Creation date . . . : 2000/03/05
  Referenced date . . : 2001/02/13
  Expiration date . . : ***None***

 Data Set Information

 Data Set Name  . . . : TPL.V6.PROCLIB

 General Data                          Current Allocation
  Volume serial . . . : xxx060          Allocated tracks  . : 8
  Device type . . . . : 3390            Allocated extents . : 1
  Organization  . . . : PO
  Record format . . . : FB
  Record length . . . : 80
  Block size  . . . . : 2960           Current Utilization
  1st extent tracks . : 8               Used tracks . . . . : 7
  Secondary tracks  . : 7               Used extents  . . . : 1

  Creation date . . . : 2000/03/05
  Referenced date . . : 2000/12/04
  Expiration date . . : ***None***


Data Set Information

 Data Set Name  . . . : TPL.V6.TYPE.STYLES

 General Data                          Current Allocation
  Volume serial . . . : xxx060          Allocated tracks  . : 1
  Device type . . . . : 3390            Allocated extents . : 1
  Organization  . . . : PO
  Record format . . . : FB
  Record length . . . : 256
  Block size  . . . . : 2560           Current Utilization
  1st extent tracks . : 1               Used tracks . . . . : 1
  Secondary tracks  . : 1               Used extents  . . . : 1

  Creation date . . . : 2000/03/05
  Referenced date . . : 2001/02/13
  Expiration date . . : ***None***

