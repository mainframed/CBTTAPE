```
//***FILE 990 is from Lionel Dyck, and contains a guide,            *   FILE 990
//*           hopefully an expanding one, to help ISPF              *   FILE 990
//*           developers with tricks and coding examples.           *   FILE 990
//*                                                                 *   FILE 990
//*           Version 1.7   -  May 13, 2020                         *   FILE 990
//*                                                                 *   FILE 990
//*           email:  lbdyck@gmail.com                              *   FILE 990
//*                                                                 *   FILE 990
//*           All of the documentation and this data can be         *   FILE 990
//*           found and downloaded from www.lbdsoftware.com.        *   FILE 990
//*                                                                 *   FILE 990
//*           To help you out, we have RECEIVEd all the coding      *   FILE 990
//*           examples into this pds, and we also uploaded          *   FILE 990
//*           the .docx and .pdf formatted documents to here.       *   FILE 990
//*                                                                 *   FILE 990
//*           The documents in this pds are:                        *   FILE 990
//*                                                                 *   FILE 990
//*           DEVTIPS#  -  document in PDF format                   *   FILE 990
//*           DEVTIPS@  -  document in MSWORD format                *   FILE 990
//*                                                                 *   FILE 990
//*           Enjoy......                                           *   FILE 990
//*                                                                 *   FILE 990
//*       NAME       VER.MOD   LAST MODIFIED     SIZE   ID          *   FILE 990
//*       $$$#DATE    04.99   2020/05/14 11:10     12 CBT-499       *   FILE 990
//*       $$$VER      01.07   2020/01/31 09:34      1 VER           *   FILE 990
//*       $$README    01.13   2020/04/12 12:55    125 README        *   FILE 990
//*       $$XMIT      01.02   2020/01/26 18:23     13 README        *   FILE 990
//*       $DEVCPY     01.01   2019/04/18 14:03    122 REXX          *   FILE 990
//*       $DEVCPYP    01.01   2019/04/10 08:00     50 PANEL         *   FILE 990
//*       $DEVISPF    01.04   2019/06/05 06:08    258 $RUNME$       *   FILE 990
//*       $DEVPH      01.01   2019/04/02 13:15     31 PANEL         *   FILE 990
//*       $DEVPP      01.01   2019/04/02 13:14     23 PANEL         *   FILE 990
//*       $DEVPX      01.01   2019/03/29 10:35     29 PANEL         *   FILE 990
//*       #RXFORM     01.01   2019/03/29 06:46    515 XMIT          *   FILE 990
//*       #TRYIT      03.04   2019/07/22 06:25   1354 XMIT          *   FILE 990
//*       @FILE990    01.06   2020/01/28 16:24    106 CBT           *   FILE 990
//*       CMT         01.01   2019/03/29 06:58   1287 REXX          *   FILE 990
//*       DEVTIPS#    01.02   2020/05/13 09:47     21 PDF           *   FILE 990
//*       DEVTIPS@    01.02   2020/05/13 09:47     12 DOCX          *   FILE 990
//*       JCBAT1      01.01   2019/03/29 10:36     22 JCL           *   FILE 990
//*       JCBAT2      01.01   2019/03/29 10:37     21 JCL           *   FILE 990
//*       LOADISPF    01.01   2019/01/25 10:32    324 REXX          *   FILE 990
//*       PNABC       01.01   2019/03/29 10:37     23 PANEL         *   FILE 990
//*       PNAREA      01.01   2019/04/02 09:51    250 PANEL         *   FILE 990
//*       PNDYN       01.01   2019/03/27 13:32     23 PANEL         *   FILE 990
//*       PNDYNTBL    01.01   2020/04/11 08:47     16 PANEL         *   FILE 990
//*       PNDYNTP     01.04   2020/04/12 12:53     21 PANEL         *   FILE 990
//*       PNEDITHL    01.03   2019/12/26 13:41    137 PANEL         *   FILE 990
//*       PNFLDH      01.01   2019/03/29 10:38     21 PANEL         *   FILE 990
//*       PNFLDH1     01.01   2019/03/29 10:38     10 PANEL         *   FILE 990
//*       PNFLDH2     01.01   2019/03/29 10:38     10 PANEL         *   FILE 990
//*       PNNUMC      01.00   2019/10/07 10:05     17 PANEL         *   FILE 990
//*       PNPNS       01.01   2019/03/29 10:38     38 PANEL         *   FILE 990
//*       PNPOP       01.01   2019/03/29 10:38     16 PANEL         *   FILE 990
//*       PNPOPV      01.02   2019/10/22 10:34     13 PANEL         *   FILE 990
//*       PNPREXX     01.06   2020/01/31 09:33     47 PANEL         *   FILE 990
//*       PNPROG1     01.01   2019/03/29 10:39     12 PANEL         *   FILE 990
//*       PNPROG2     01.01   2019/03/29 10:39     11 PANEL         *   FILE 990
//*       PNSCRL      01.01   2019/03/29 10:39     22 PANEL         *   FILE 990
//*       PNTAB       01.02   2019/11/04 07:13     37 PANEL         *   FILE 990
//*       PNVDSN      01.05   2020/04/12 14:50     30 PANEL         *   FILE 990
//*       RXABC       01.01   2019/04/01 14:25     12 REXX          *   FILE 990
//*       RXAREA      01.01   2019/03/29 10:41      9 REXX          *   FILE 990
//*       RXCENTER    01.01   2019/03/29 10:42     49 REXX          *   FILE 990
//*       RXCMDS      01.01   2019/04/10 07:15     13 REXX          *   FILE 990
//*       RXDOALL     01.02   2019/07/22 10:27     55 REXX          *   FILE 990
//*       RXDYN       01.01   2019/04/01 12:47     51 REXX          *   FILE 990
//*       RXDYNTBL    01.14   2020/04/12 12:59    191 REXX          *   FILE 990
//*       RXEDITHL    01.03   2019/12/26 13:20     10 REXX          *   FILE 990
//*       RXEM        01.01   2019/04/17 09:13     29 MACRO         *   FILE 990
//*       RXEMAC      01.01   2019/03/29 10:43     18 REXX          *   FILE 990
//*       RXEMACE     01.01   2019/03/29 10:43     41 REXX          *   FILE 990
//*       RXEME       01.01   2019/04/08 12:01     24 MACRO         *   FILE 990
//*       RXEMS       01.01   2019/04/08 12:00     22 MACRO         *   FILE 990
//*       RXEMTRY     01.01   2019/04/08 12:03     12 REXX          *   FILE 990
//*       RXFLD       01.01   2019/03/29 10:43     10 REXX          *   FILE 990
//*       RXIVAR      01.00   2019/05/06 07:15     10 REXX          *   FILE 990
//*       RXLISPF     01.01   2019/10/23 06:29    433 REXX          *   FILE 990
//*       RXLMD       01.01   2019/03/29 10:43     58 REXX          *   FILE 990
//*       RXLMM       01.01   2019/03/29 10:44     72 REXX          *   FILE 990
//*       RXMEDHL     01.00   2019/12/26 10:59     17 REXX          *   FILE 990
//*       RXMSG       01.01   2019/03/29 10:45     15 REXX          *   FILE 990
//*       RXNOTEPD    01.01   2020/04/13 09:54     82 REXX          *   FILE 990
//*       RXNUMC      01.00   2019/10/07 09:34     18 REXX          *   FILE 990
//*       RXNUMCE     01.02   2019/10/07 10:10     13 REXX          *   FILE 990
//*       RXPNS       01.01   2019/03/29 10:45     30 REXX          *   FILE 990
//*       RXPNSL      01.01   2019/03/29 10:46    402 REXX          *   FILE 990
//*       RXPOP       01.02   2019/04/23 06:18      9 REXX          *   FILE 990
//*       RXPOPDO     01.01   2019/04/03 07:11     82 REXX          *   FILE 990
//*       RXPOPKEY    01.07   2019/10/22 10:40     37 REXX          *   FILE 990
//*       RXPOPM      01.01   2019/04/03 07:06     72 MACRO         *   FILE 990
//*       RXPREXX     01.01   2019/03/29 10:46     26 REXX          *   FILE 990
//*       RXPROG1     01.01   2019/03/29 10:47     15 REXX          *   FILE 990
//*       RXPROG2     01.01   2019/03/29 10:47     46 REXX          *   FILE 990
//*       RXRAND      01.02   2019/05/03 08:17     26 REXX          *   FILE 990
//*       RXRVAR      01.00   2019/05/06 07:16      6 REXX          *   FILE 990
//*       RXSCRL      01.01   2019/03/29 10:47     13 REXX          *   FILE 990
//*       RXSKLCMD    01.01   2019/04/16 10:03     11 REXX          *   FILE 990
//*       RXSKLRX     01.02   2019/04/23 09:37      9 REXX          *   FILE 990
//*       RXSKLRXE    01.03   2019/05/02 08:45      9 REXX          *   FILE 990
//*       RXSKLRXV    01.05   2019/09/27 16:48     10 REXX          *   FILE 990
//*       RXSTEM      01.01   2019/03/29 10:48     36 REXX          *   FILE 990
//*       RXSTEME     01.01   2019/03/29 10:48     12 REXX          *   FILE 990
//*       RXSTEMS     01.00   2019/05/07 09:39     22 REXX          *   FILE 990
//*       RXTAB       01.13   2020/01/25 10:39    427 REXX          *   FILE 990
//*       RXTABLE     01.08   2020/05/04 07:27    434 REXX          *   FILE 990
//*       RXTM        01.05   2020/04/01 09:33     21 REXX          *   FILE 990
//*       RXTSOMAC    01.12   2020/04/02 04:27     26 REXX          *   FILE 990
//*       RXVDSN      01.01   2019/03/29 10:49     15 REXX          *   FILE 990
//*       SAMPGIT     01.03   2019/12/26 13:44     39 SAMPLE        *   FILE 990
//*       SKCMDS      01.01   2019/04/16 09:54     12 SKEL          *   FILE 990
//*       SKREXX      01.00   2019/04/23 09:36     28 SKEL          *   FILE 990
//*       SKREXXE     01.01   2019/05/02 08:46     25 SKEL          *   FILE 990
//*       SKREXXV     01.00   2019/09/27 16:42     18 SKEL          *   FILE 990
//*                                                                 *   FILE 990

```
