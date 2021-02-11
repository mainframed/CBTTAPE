
## $$$DOC.txt
```
1   07.12.94                                            DOC - Page 1/2.

          ***************************************************
          ***     P R E L I M I N A R Y     N O T E S     ***
          ***************************************************

 Files author : MOINIL P.A.
 -------------- Computing Centre (TP361)
                J.R.C. - Ispra establishment
                21020 ISPRA (VA), Italy

 Products installation requirement :
 -----------------------------------
     Data-set "->.SOURCE.FILE0" is a pre-requisite.

 Data-set members structure :
 ----------------------------
     The members names ending by a dollar sign ($) are the JCL to
     install (assembly + link-edit) the modules, and the members
     names ending by a paragraph sign (@) are the corresponding
     modules documentation.

                   *********************************
                   ***     INFORMATION NOTES     ***
                   *********************************

     Assuming the LISTNO program in "->.SOURCE.FILE0" installed, you may
 SUBMIT the job below to obtain a copy of this document :
         //...      JOB ...
         //DOC     EXEC PGM=LISTNO,PARM='M=DOC'
         //SYSPDS    DD DSN=->.SOURCE.FILE5,DISP=SHR
         //SYSPRINT  DD SYSOUT=A
     A complete information notes list (about 1500 lines) may be also
 obtained by this job if you specify M=INFO as parameter.
1   16.12.94                                            DOC - Page 2/2.

  *******************************************************************
  ***     D A T A - S E T ->.SOURCE.FILE5     C O N T E N T S     ***
  *******************************************************************

 DYLO       DYLON/DYLOFF TSO command (Session libraries Dynamic
            allocation).
 SHADOW     SHADOW/SHADUP ISPF application (Encrypt/Decrypt data-sets
            facility).
 SHORT      System Sector Short Communication (ISPF).
 TOPSEC     Display Top Secret short-write-up TSO command.
```

## DYLO$DOC.txt
```
//DYLODOC  JOB (........),'DYLON/DYLOFF DOC.',
//             MSGLEVEL=(1,1),MSGCLASS=X,REGION=1M,TIME=1
/*JOBPARM L=4
//* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - *
//*      LIST DYLON-DYLOFF TSO COMMAND INSTALL MEMBER                 *
//* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - *
//LISTI   EXEC PGM=IEBGENER
//SYSUT1    DD DSN=->.SOURCE.FILE5(DYLO#),DISP=SHR
//SYSUT2    DD SYSOUT=*,DCB=(RECFM=FA,BLKSIZE=80,LRECL=80)
//SYSPRINT  DD SYSOUT=*
//SYSIN     DD *
  GENERATE  MAXFLDS=99
  RECORD    FIELD=(1,1,,1),FIELD=(71,2,,10)
/*
//* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - *
//*      LIST DYLON-DYLOFF TSO COMMAND DOCUMENT MEMBER                *
//* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - *
//LISTD   EXEC PGM=IEBGENER
//SYSUT1    DD DSN=->.SOURCE.FILE5(DYLO@),DISP=SHR
//SYSUT2    DD SYSOUT=*,DCB=(RECFM=FA,BLKSIZE=80,LRECL=80)
//SYSPRINT  DD SYSOUT=*
//SYSIN     DD *
  GENERATE  MAXFLDS=99
  RECORD    FIELD=(1,1,,1),FIELD=(71,2,,10)
/*
```

