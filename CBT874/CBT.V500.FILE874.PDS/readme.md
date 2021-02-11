
## @FILE874.txt
```
//***FILE 874 is from Sam Golob, and contains HELP members for      *   FILE 874
//*           many utilities on the CBT Tape which he, himself,     *   FILE 874
//*           finds useful.                                         *   FILE 874
//*                                                                 *   FILE 874
//*           Included is a member called $HEL, which is an XMIT    *   FILE 874
//*           of a load library containing the REVIEW TSO command   *   FILE 874
//*           from Greg Price (File 134, 135) whose aliases called  *   FILE 874
//*           HEL and FSH and FSHELP (full screen help) can be      *   FILE 874
//*           used to browse these members in full screen mode.     *   FILE 874
//*           (You can scroll inside them, up and down, even from   *   FILE 874
//*           TSO READY mode.)                                      *   FILE 874
//*                                                                 *   FILE 874
//*           Concatenate this file (the pds for CBT File 874)      *   FILE 874
//*           into the SYSHELP concatenation for your TSO session.  *   FILE 874
//*                                                                 *   FILE 874
//*           You can also use this file to decide which new tools  *   FILE 874
//*           from the CBT Tape that you might like to install and  *   FILE 874
//*           use for yourself.  The HELP members can show you      *   FILE 874
//*           what each tool does, and you might want to have that  *   FILE 874
//*           capability available if needed.                       *   FILE 874
//*                                                                 *   FILE 874
//*           When this pds is concatenated with your SYSHELP       *   FILE 874
//*           DD name, you can simply say HELP member, and you      *   FILE 874
//*           will get the help.  If the load modules for REVIEW,   *   FILE 874
//*           FSH, FSHELP, and HEL are installed, you can say       *   FILE 874
//*           (for example)   HEL member   or   FSH member          *   FILE 874
//*           and you will see the help member in full screen mode, *   FILE 874
//*           scrollable up and down.                               *   FILE 874
//*                                                                 *   FILE 874
//*           The ISPF statistics for each member of this pds       *   FILE 874
//*           will tell you which CBT Tape file, that program       *   FILE 874
//*           (described by the HELP member) came from.             *   FILE 874
//*                                                                 *   FILE 874
//*           email:   sbgolob@cbttape.org                          *   FILE 874
//*                                                                 *   FILE 874
//*        Some members of this PDS:                                *   FILE 874
//*                                                                 *   FILE 874
//*      NAME     VER.MOD     LAST MODIFIED    SIZE   ID            *   FILE 874
//*      ----     -------   -----------------  ----   --            *   FILE 874
//*      $$$#DATE  04.98  2019/06/20 11:16:41    12  CBT-498        *   FILE 874
//*      $$INDEX   01.09  2019/04/30 20:23:37    67  SBGOLOB        *   FILE 874
//*      $HEL      46.01  2016/01/14 17:00:21  5849  LOADLIB        *   FILE 874
//*      @FILE874  04.98  2019/06/20 11:16:34   107  CBT-498        *   FILE 874
//*      ABEND     05.00  1993/02/17 14:30:00  2307  FILE134        *   FILE 874
//*      ADDTO     01.00  2000/02/27 15:37:03    32  FILE452        *   FILE 874
//*      ADIS      01.02  2008/05/15  1:53:00    26  FILE185        *   FILE 874
//*      APFLIST   01.04  2019/06/02 11:46:13    44  FILE566        *   FILE 874
//*      BLKDISK   01.02  2012/07/26 14:31:04   334  FILE296        *   FILE 874
//*      BLKSPTRK  01.00  1999/05/06  8:32:34   195  FILE199        *   FILE 874
//*      BURN      01.02  2012/11/01 12:54:48    96  FILE878        *   FILE 874
//*      CATL      01.00  2000/02/27 15:37:05    36  FILE452        *   FILE 874
//*      CCAT      01.03  2019/01/27 17:41:47   129  FILE535        *   FILE 874
//*      CDSCB     01.01  1999/07/13  0:19:00    58  FILE134        *   FILE 874
//*      CINMX     01.05  2006/01/02 14:00:53    61  FILE731        *   FILE 874
//*      CNCLPG    01.10  2019/05/21  0:00:46   350  FILE826        *   FILE 874
//*      COPYFILE  01.17  2005/11/20 10:39:41   289  FILE229        *   FILE 874
//*      COPYMODS  00.87  2012/06/10 17:06:01   487  FILE229        *   FILE 874
//*      CPSCB     01.03  2005/04/19 10:53:33    49  FILE300        *   FILE 874
//*      DSAT      01.00  2012/07/26 14:25:00   278  FILE296        *   FILE 874
//*      DSMF      01.00  2019/04/23 16:32:30    15  FILE300        *   FILE 874
//*      DSPACE    01.01  2003/05/27 10:49:00    36  FILE633        *   FILE 874
//*      DTEST     01.03  2019/04/24  2:23:43    38  FILE731        *   FILE 874
//*      DVAT      01.04  2019/04/24  2:39:21    35  FILE731        *   FILE 874
//*      DVOL      01.00  2003/06/29 10:24:39    56  FILE296        *   FILE 874
//*      EESCB     01.03  2006/01/02 14:03:11    24  FILE731        *   FILE 874
//*      FSH       ALIAS                                            *   FILE 874
//*      FSHELP    48.03  2018/08/19 17:34:50   920  FILE134        *   FILE 874
//*      HEL       ALIAS                                            *   FILE 874
//*      ICH       01.55  2010/01/16 16:46:10   327  FILE819        *   FILE 874
//*      IEBANTP   01.00  1989/04/12 11:59:00   238  FILE455        *   FILE 874
//*      IKJEEPTR  01.12  2016/01/15  1:51:57    71  FILE731        *   FILE 874
//*      INMXD     01.06  2019/04/24  9:17:48    46  FILE731        *   FILE 874
//*      JCLSET    01.01  2009/07/06 10:33:42    81  FILE452        *   FILE 874
//*      KMBAPFLB  01.00  2019/04/30 20:06:59    23  FILE566        *   FILE 874
//*      KONCAT    01.00  1998/05/22 13:15:00    44  FILE355        *   FILE 874
//*      LDS       01.00  2000/02/27 15:37:35    19  FILE452        *   FILE 874
//*      LOADTEST  01.06  2019/06/20 11:14:50   250  FILE731        *   FILE 874
//*      LOCATE    01.12  2015/01/05 15:27:06    27  FILE612        *   FILE 874
//*      LOGOPTS   01.09  2016/05/02 11:49:35   110  FILE731        *   FILE 874
//*      LPSCB     01.04  2005/04/19 11:00:00    17  FILE300        *   FILE 874
//*      LWATMGR   01.00  2008/11/21 21:10:59    63  FILE797        *   FILE 874
//*      PDS86     86.17  2019/04/05 14:21:09 10078  FILE182        *   FILE 874
//*      PGLITE    01.26  2019/07/22 14:23:56    73  FILE182        *   FILE 874
//*      RELEASE   01.00  2007/04/04 23:20:14    23  FILE296        *   FILE 874
//*      REV       ALIAS                                            *   FILE 874
//*      REVED     ALIAS                                            *   FILE 874
//*      REVEDIT   48.03  2018/08/19 17:33:43  1834  FILE134        *   FILE 874
//*      REVIEW    48.03  2018/08/19 17:35:32  2228  FILE134        *   FILE 874
//*      REVLEV    48.05  2019/01/27 23:32:38   767  FILE134        *   FILE 874
//*      REVOUT    48.03  2018/08/19 17:28:03   454  FILE134        *   FILE 874
//*      REVPDS    48.05  2019/01/27 23:12:38   806  FILE134        *   FILE 874
//*      REVPDSE   48.05  2019/01/27 23:13:40   558  FILE134        *   FILE 874
//*      REVTSO    48.03  2018/08/19 17:26:30   312  FILE134        *   FILE 874
//*      REVUNIX   48.05  2019/01/27 23:15:03   577  FILE134        *   FILE 874
//*      REVVSAM   ALIAS                                            *   FILE 874
//*      RFE       48.03  2018/08/19 17:32:35   436  FILE134        *   FILE 874
//*      RGENR     01.02  2019/04/23 21:02:16    35  FILE836        *   FILE 874
//*      RPFHELP   01.71  2019/04/23 15:14:57   808  FILE415        *   FILE 874
//*      RXJCL     01.00  2007/03/15 15:34:06   348  FILE756        *   FILE 874
//*      STEPLIB   01.03  2016/05/02 11:35:45   118  FILE452        *   FILE 874
//*      TSUB      01.01  2019/04/24  9:40:26   368  FILE797        *   FILE 874
//*      TSUBQUIK  01.38  2019/04/24  9:52:30    27  FILE797        *   FILE 874
//*      UCBDASD   01.03  2019/05/20 21:35:25    43  FILE731        *   FILE 874
//*      UKEYCSA   01.01  2019/04/24  9:54:44    26  FILE264        *   FILE 874
//*      ULUDASD   01.04  2019/05/20 21:33:29    46  FILE797        *   FILE 874
//*      ULUTAPE   01.07  2012/12/16 12:34:27    78  FILE873        *   FILE 874
//*      USERINFO  01.02  2012/08/01 13:44:03    59  FILE452        *   FILE 874
//*      VSAMANAL  00.88  2019/05/21  2:06:37   269  FILE294        *   FILE 874
//*      WHEREIS   01.00  2019/04/23 15:50:51    10  FILE836        *   FILE 874
//*      WHOSGOT   01.00  2000/02/27 15:37:00    17  FILE452        *   FILE 874
//*      XEQ       01.00  2007/04/04 23:26:23    35  FILE296        *   FILE 874
//*                                                                 *   FILE 874
```

