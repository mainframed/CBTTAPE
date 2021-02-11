
## $$$DOC.txt
```
ADDITIONAL DOC FOR FILE 011.                                  08/92 SBG
                                                              08/92 SBG
   MSG2USER AND AMSG2USR HAVE BEEN REVISED BY MORRIS KARLIN   08/92 SBG
   OF THE HUMAN RESOURCES ADMINISTRATION OF NEW YORK CITY,    08/92 SBG
   TO WORK ON MVS/ESA 3.1.0E  (AND HOPEFULLY BEYOND).         08/92 SBG
                                                              08/92 SBG
            MORRIS KARLIN                                     08/92 SBG
            HRAMIS                                            08/92 SBG
            111 8TH AVENUE - 6TH FLOOR                        08/92 SBG
            NEW YORK, NY 10011                                08/92 SBG
            (212) 206-3799                                    08/92 SBG
                                                              08/92 SBG
                                                              08/92 SBG
   MILTON SOONG'S OLDER VERSION OF MSG2USER HAS BEEN KEPT     08/92 SBG
   IN THE FILE, AND HIS CORRESPONDING TWO MEMBERS ARE CALLED  08/92 SBG
   MSG2USEO AND AMSG2USO, RESPECTIVELY.                       08/92 SBG
                                                              08/92 SBG
                                                              08/92 SBG
```

## $$DOC.txt
```
$$DOC.....THIS MEMBER
ADEBE.....JCL TO ASSEMBLE AND LINK DEBE
AMSG2USO..JCL TO ASSEMBLE AND LINK MSG2USER  (FROM MILTON SOONG)
AMSG2USR..JCL TO ASSEMBLE AND LINK MSG2USER  (FROM MORRIS KARLIN)
ATSO051...JCL TO ASSEMBLE AND LINK TSO051
DEBE......THIS VERSION WAS MODIFIED TO RUN UNDER MVS/XA AND
          WILL NOWT SUPPORT BOTH 3420 AND 3480 TAPE DRIVES
DEBEJCL...PROC TO START DEBE
MSG2USEO..THIS IS A WTO EXIT. THIS EXIT WILL SEND A MESSAGE TO A TSO
          USER WHO IS ENQUEUED ON A DATASET NEEDED BY A BATCH JOB.
          THE FORMAT OF THE MESSAGE IS :
               NTL861I THE FOLLOWING RESERVED DATASET NAMES
                       UNAVAILABLE TO JJJJ
               NTL863I DSN=DSN
MSG2USER..THIS IS A WTO EXIT. THIS EXIT WILL SEND A MESSAGE TO A TSO
 (ESA)    USER WHO IS ENQUEUED ON A DATASET NEEDED BY A BATCH JOB.
          THE FORMAT OF THE MESSAGE IS :
               HRA861I THE FOLLOWING RESERVED DATASET NAMES
                       UNAVAILABLE TO JJJJ
               HRA863I DSN=DSN
OLDDOC....SOME OLD DEBE DOCUMENTATION
TSO051....THIS PROGRAM WILL GET INFORMATION FROM JCT AND WILL
          FILL IN VARIOUS CLIST VARIABLES.
```

