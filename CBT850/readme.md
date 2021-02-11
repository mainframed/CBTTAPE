```
//***FILE 850 is from Juergen Winkelmann, based on the pioneering   *   FILE 850
//*           and expert work of Craig Yasuna.  This is Craig's     *   FILE 850
//*           ESG security system adapted for MVS 3.8J that is run  *   FILE 850
//*           under Hercules, and is called RAKF.                   *   FILE 850
//*                                                                 *   FILE 850
//*           Credit for the modifications goes to Phil Dickinson,  *   FILE 850
//*           Phil Roberts, Juergen Winkelmann, and Scott Vetter.   *   FILE 850
//*           See member $CREDITS in this file for details.         *   FILE 850
//*                                                                 *   FILE 850
//*           For the record, to see the modifications from the ESG *   FILE 850
//*           security system thru (some level of) this source code *   FILE 850
//*           please see member ESG2RAKF.                           *   FILE 850
//*                                                                 *   FILE 850
//*           The product is packaged as an SMP install for MVS 3.8 *   FILE 850
//*           as a "tape" file in AWS format.  This "tape" has been *   FILE 850
//*           folded into FB-80 and is included in this file as     *   FILE 850
//*           member AWSTAPE.  A "real tape" can be made from this  *   FILE 850
//*           member, using the VTT2TAPE program from CBT File 533  *   FILE 850
//*           whose source (in RECV370 format) is in member VASM.   *   FILE 850
//*                                                                 *   FILE 850
//*           However, if you already have a Hercules system, you   *   FILE 850
//*           can just FTP the AWSTAPE member to a PC file, or      *   FILE 850
//*           download it to there using the IND$FILE program, and  *   FILE 850
//*           mount it as a tape under Hercules using the devinit   *   FILE 850
//*           command on the Hercules console.                      *   FILE 850
//*                                                                 *   FILE 850
//*           PTFs are listed here under their sysmod name.         *   FILE 850
//*                                                                 *   FILE 850
//*           Example:  RRKF001                                     *   FILE 850
//*                                                                 *   FILE 850
//*           However, for those who do not want to use the "tape"  *   FILE 850
//*           to install RAKF, each relfile has been expanded into  *   FILE 850
//*           a member of this file, that can be made into a pds    *   FILE 850
//*           using the PDSLOAD program (whose source code is also  *   FILE 850
//*           packaged in the VASM member).  To my knowledge, both  *   FILE 850
//*           programs (PDSLOAD and this version of VTT2TAPE) can   *   FILE 850
//*           be run on MVS 3.8.                                    *   FILE 850
//*                                                                 *   FILE 850
//*       PTFs were added to this package, and will be added as     *   FILE 850
//*       needed:                                                   *   FILE 850
//*                                                                 *   FILE 850
//*       RRKF001  Introduce change history                         *   FILE 850
//*                Enable comment lines in UDATA and PDATA          *   FILE 850
//*                                                                 *   FILE 850
//*       RRKF002  Allow users to make permanent changes to         *   FILE 850
//*                their passwords                                  *   FILE 850
//*                                                                 *   FILE 850
//*       RRKF003  Prevent unauthorized user from accessing         *   FILE 850
//*                incore tables                                    *   FILE 850
//*                                                                 *   FILE 850
//*       RRKF004  Fix and unify RAKF documentation                 *   FILE 850
//*                                                                 *   FILE 850
//*       RRKF005  RACIND Utility to control VSAM RACF Indicators   *   FILE 850
//*                                                                 *   FILE 850
//*       RRKF006  + Sample jobs to RACF indicate or unindicate     *   FILE 850
//*                  the whole system                               *   FILE 850
//*                + OCO distribution of RAKF-external utilities    *   FILE 850
//*                + Sample jobs for creation of SYS1.SECURE.CNTL   *   FILE 850
//*                  and SYS1.SECURE.PWUP                           *   FILE 850
//*                + Add missing //RAKFPWUP DD statement to the     *   FILE 850
//*                  RAKF cataloged procedure                       *   FILE 850
//*                + Update the RAKF User's Guide with changes      *   FILE 850
//*                  introduced since RRKF004                       *   FILE 850
//*                                                                 *   FILE 850
//*       Documentation for this system is in text form, in member  *   FILE 850
//*       RAKFDOC.  However, the more up-to-date documentation is   *   FILE 850
//*       in the two other members RAKFDOC# (PDF format) and        *   FILE 850
//*       RAKFDOC@ (MSWORD format).  These latter members were      *   FILE 850
//*       Juergen's original doc, and RAKFDOC was converted from    *   FILE 850
//*       these, at a previous level, by Sam Golob.  The MSWORD     *   FILE 850
//*       and PDF documentation reflect the latest PTF level,       *   FILE 850
//*       RRKF006.                                                  *   FILE 850
//*                                                                 *   FILE 850
//*       email:   winkelmann@id.ethz.ch                            *   FILE 850
//*                                                                 *   FILE 850
//*       email:   svetter@ameritech.net                            *   FILE 850
//*                                                                 *   FILE 850
//*       email:   sbgolob@cbttape.org  or sbgolob@attglobal.net    *   FILE 850
//*                                                                 *   FILE 850

```
