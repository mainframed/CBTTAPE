```
//***FILE 566 is from Sam Bass and contains a collection of his     *   FILE 566
//*           utilities.                                            *   FILE 566
//*                                                                 *   FILE 566
//*      (Remark from Sam Golob:  They are very good...!!!)         *   FILE 566
//*                                                                 *   FILE 566
//*           email   :  vendors@kmbass.com                         *   FILE 566
//*                                                                 *   FILE 566
//*           web site:  http://www.kmbass.com                      *   FILE 566
//*                                                                 *   FILE 566
//*   Added member DUMPLIB which is an XMIT-format load library     *   FILE 566
//*   containing the DUMP**** load modules, most of which were      *   FILE 566
//*   enabled for PUTLINE output.  This will make it easier to      *   FILE 566
//*   deploy the DUMP**** programs, by just copying the load        *   FILE 566
//*   to a library accessible to your TSO session.                  *   FILE 566
//*                                                                 *   FILE 566
//*   See member $$NOTE03 for further information about these       *   FILE 566
//*   programs.                                                     *   FILE 566
//*                                                                 *   FILE 566
//*   CLISTS member added.                                          *   FILE 566
//*                                                                 *   FILE 566
//*   A short description of the utilities follows:                 *   FILE 566
//*                                                                 *   FILE 566
//*      #ASMALL  JCL to assemble all source members                *   FILE 566
//*                                                                 *   FILE 566
//*      APFLIST  TSO command to list datasets in APF List          *   FILE 566
//*               (Converted to PUTLINE outpup - old version is     *   FILE 566
//*                kept here as member APFLIST0)                    *   FILE 566
//*                                                                 *   FILE 566
//*      CONSOLE  TSO console display program                       *   FILE 566
//*        (SPY)  Name for the new version of the CONSOLE program   *   FILE 566
//*                                                                 *   FILE 566
//*      COPYTPX, which is assembled with RTAPE2, is a tape copy    *   FILE 566
//*               utility that can copy tapes with blocksize up     *   FILE 566
//*               to 256K.  Use it with a parm of J, to force the   *   FILE 566
//*               output tape's volser to match the SYSUT2 volser   *   FILE 566
//*               in the JCL.  Otherwise, the program just makes    *   FILE 566
//*               a 'xerox copy' of the input tape, with the same   *   FILE 566
//*               volser.  RTAPE2 is a called routine that does     *   FILE 566
//*               the actual tape I/O.                              *   FILE 566
//*                                                                 *   FILE 566
//*      LNKLIST  TSO command to list datasets in the Link List     *   FILE 566
//*                                                                 *   FILE 566
//*      DSCATNAM Subroutine to return catalog name for an          *   FILE 566
//*               catalog alias                                     *   FILE 566
//*                                                                 *   FILE 566
//*      DSCPPL   Subroutine to build a CPPL if called as           *   FILE 566
//*               non-TSO command                                   *   FILE 566
//*                                                                 *   FILE 566
//*      DSDSM08  Scan catalog looking for dsns cataloged on        *   FILE 566
//*               wrong volume                                      *   FILE 566
//*                                                                 *   FILE 566
//*      DSUNARC  RECALL all migrated datasets for job when used    *   FILE 566
//*               as 1st step                                       *   FILE 566
//*                                                                 *   FILE 566
//*      DSWTO    Subroutine to issue WTO (COBOL callable)          *   FILE 566
//*                                                                 *   FILE 566
//*      DSWTOMSG Subroutine to issue WTOR (COBOL callable)         *   FILE 566
//*                                                                 *   FILE 566
//*      --------------------------------------------------------   *   FILE 566
//*                                                                 *   FILE 566
//*      Most of the DUMP**** commands were fixed to give PUTLINE   *   FILE 566
//*      output, so their output can be trapped and Browsed or      *   FILE 566
//*      Edited or Viewed or REVIEWed.  The execs TSOB, TSOE,       *   FILE 566
//*      TSOV and TSOR from Mark Zelden have been included here     *   FILE 566
//*      for this purpose, or you may use the SYSOUTTRAP-ing tool   *   FILE 566
//*      of your choice.                                            *   FILE 566
//*                                                                 *   FILE 566
//*      To assemble the modules fixed for PUTLINE, you must        *   FILE 566
//*      include in SYSLIB, a library containing the EPUTL member,  *   FILE 566
//*      the APUT member, and the modified PRTDUMP member.  To      *   FILE 566
//*      assemble the old modules, you should rename the PRTDUMPT   *   FILE 566
//*      member to PRTDUMP and assemble the old versions of the     *   FILE 566
//*      source.                                                    *   FILE 566
//*                                                                 *   FILE 566
//*      Sample assembly and linkedit jobs for the fixed modules    *   FILE 566
//*      have been included with $ in their names (obvious).        *   FILE 566
//*                                                                 *   FILE 566
//*      DUMPASCB TSO command to dump ASCB                          *   FILE 566
//*                                                                 *   FILE 566
//*      DUMPCSCB TSO command to dump CSCB                          *   FILE 566
//*                                                                 *   FILE 566
//*      DUMPJCT  TSO command to dump JCT (os)                      *   FILE 566
//*                                                                 *   FILE 566
//*      DUMPLWA  TSO command to dump LWA                           *   FILE 566
//*                                                                 *   FILE 566
//*      DUMPPCCB TSO command to dump PCCB                          *   FILE 566
//*                                                                 *   FILE 566
//*      DUMPPPT  TSO command to dump PPT entries to the console.   *   FILE 566
//*                                       (not fixed for PUTLINE)   *   FILE 566
//*                                                                 *   FILE 566
//*      DUMPPRB  TSO command to dump PRB (not fixed for PUTLINE)   *   FILE 566
//*                                                                 *   FILE 566
//*      DUMPSCT  TSO command to dump SCT                           *   FILE 566
//*                                                                 *   FILE 566
//*      DUMPTCT  TSO command to dump TCT                           *   FILE 566
//*                                                                 *   FILE 566
//*      DUMPTIOT TSO command to dump TIOT                          *   FILE 566
//*                                                                 *   FILE 566
//*      DUMPTSB  TSO command to dump TSB                           *   FILE 566
//*                                                                 *   FILE 566
//*      --------------------------------------------------------   *   FILE 566
//*                                                                 *   FILE 566
//*      DYNAM    Subroutine for SVC 99, COBOL callable, now is     *   FILE 566
//*               AMODE=31                                          *   FILE 566
//*                                                                 *   FILE 566
//*      DYNAMDOC DYNAM doc                                         *   FILE 566
//*                                                                 *   FILE 566
//*      FIXDSCB  Modifies, renames, scratch datasets that are      *   FILE 566
//*               allocated (authorized SVC required).              *   FILE 566
//*                                                                 *   FILE 566
//*      FIXDSCB2 Modifies, renames, scratch datasets that are      *   FILE 566
//*               allocated mvs 3.8 (must be APF authorized).       *   FILE 566
//*                                                                 *   FILE 566
//*      GENPARM  Takes PARM fields and writes to //PARM ddname     *   FILE 566
//*               RECMF=FB,80                                       *   FILE 566
//*                                                                 *   FILE 566
//*      KMBAPFLB Adds dataset to APFlist (authorized SVC           *   FILE 566
//*               required).                                        *   FILE 566
//*                                                                 *   FILE 566
//*      LNKLIST  TSO command to list lnklist datasets              *   FILE 566
//*                                                                 *   FILE 566
//*      LPALIST  TSO command to list lpalst  datasets              *   FILE 566
//*               (Fixed to display LPA-defined copy of dataset     *   FILE 566
//*               and compare to cataloged copy of the dataset.)    *   FILE 566
//*                                                                 *   FILE 566
//*      MVSAREAS MACRO for dump... members                         *   FILE 566
//*                                                                 *   FILE 566
//*      PRTDUMP  MACRO for dump... members                         *   FILE 566
//*                                                                 *   FILE 566
//*      SQAMON   Monitors CSA and SQA changes (req APF             *   FILE 566
//*               authorized).                                      *   FILE 566
//*                                                                 *   FILE 566
//*      STPCOND  Sends wto to job submittor about step cond        *   FILE 566
//*               codes, use as last step in job                    *   FILE 566
//*                                                                 *   FILE 566
//*      SWAREQ   Subroutine to convert SWA address to real         *   FILE 566
//*               addresses                                         *   FILE 566
//*                                                                 *   FILE 566
//*      WAITTIME Waits PARM='nnn' seconds                          *   FILE 566
//*                                                                 *   FILE 566
//*      WLMREXX  Reads WLM PDS and build SAS code that will load   *   FILE 566
//*               each ISPF table into a SAS database.  Now we need *   FILE 566
//*               someone to write some SAS reports for it.         *   FILE 566
//*                                                                 *   FILE 566
//*  >>>   The WLMREXX now needs someone to write some              *   FILE 566
//*  >>>   SAS reports to make WLM settings to easily be            *   FILE 566
//*  >>>   understood.                                              *   FILE 566
//*                                                                 *   FILE 566
//*  >>>   (We're soliciting volunteers - if you write reports      *   FILE 566
//*  >>>   for yourself, which use this material, please send       *   FILE 566
//*  >>>   the source code to Sam Golob  sbgolob@cbttape.org ,      *   FILE 566
//*  >>>   so I can add them to the contents of this file.          *   FILE 566
//*  >>>   Thanks in advance for your help.....)                    *   FILE 566
//*                                                                 *   FILE 566
//*      ZAPDSCB  TSO full screen dataset attribute zapper          *   FILE 566
//*               (authorized SVC eliminated. needs AUTHCMD         *   FILE 566
//*               entry in IKJTSOxx parmlib table instead)          *   FILE 566
//*                                                                 *   FILE 566
//*      ZAPDSCB# TSO HELP member for ZAPDSCB. IT IS IMPORTANT      *   FILE 566
//*               TO READ THIS....!!! (explanation of prefix)       *   FILE 566
//*                                                                 *   FILE 566
//*      ZAPDSCB2 TSO full screen dataset attribute zapper          *   FILE 566
//*               ESA 4.3 and below (authorized SVC required).      *   FILE 566
//*                                                                 *   FILE 566

```
