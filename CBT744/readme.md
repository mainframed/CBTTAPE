```
//***FILE 744 is from Eugene Vogt and Alain Steffen and contains    *   FILE 744
//*           a very impressive set of RACF management tools.       *   FILE 744
//*           More detailed information about this package is       *   FILE 744
//*           described below.                                      *   FILE 744
//*                                                                 *   FILE 744
//*               RACF 'RULES' ENFORCER  -  RRE 3.40                *   FILE 744
//*                                                                 *   FILE 744
//*     This dataset contains RACF tools                            *   FILE 744
//*     that RACF installations may find useful.                    *   FILE 744
//*                                                                 *   FILE 744
//*     Note:                                                       *   FILE 744
//*                                                                 *   FILE 744
//*     .. The IBM API IRRSEQ00 processing has multiple errors.     *   FILE 744
//*        Make sure to obtain the latest IBM APARS.                *   FILE 744
//*                                                                 *   FILE 744
//*     .. None of the supplied RRE programs makes any changes      *   FILE 744
//*        to your RACF DB.                                         *   FILE 744
//*                                                                 *   FILE 744
//*     PURPOSE:                                                    *   FILE 744
//*                                                                 *   FILE 744
//*     - To verify all RACF profiles against a hr/cd/id system     *   FILE 744
//*       and vice versa.                                           *   FILE 744
//*     - To verify all RACF profiles against a set of user         *   FILE 744
//*       defined 'rules'.                                          *   FILE 744
//*     - To enforce naming conventions in a RACF environment       *   FILE 744
//*       without having to simplify future audits.                 *   FILE 744
//*     - To reduce the immense costs of any future RACF audits.    *   FILE 744
//*     - To keep hr/cd and RACF information in sync based on       *   FILE 744
//*       installation standards                                    *   FILE 744
//*     - To have a better control over all RACF profiles.          *   FILE 744
//*     - To be able to manage multiple clients.                    *   FILE 744
//*     - To verify SETROPTS settings.                              *   FILE 744
//*                                                                 *   FILE 744
//*     Most RACF installations do no longer know why certain       *   FILE 744
//*     user-ids are connected to various RACF group-ids.  Even     *   FILE 744
//*     when installations utilize a corporate directory (id or     *   FILE 744
//*     cd or hr) it never matches the RACF environment 100%.       *   FILE 744
//*     Ownership of profiles is not up-to-date.                    *   FILE 744
//*                                                                 *   FILE 744
//*     Especially, large corporations with many decentralized      *   FILE 744
//*     RACF administrators, face the immense problem to enforce    *   FILE 744
//*     standards.  Manually controlling such RACF environments     *   FILE 744
//*     is almost impossible.  Home-grown tools are in many         *   FILE 744
//*     cases no solution either to the well known problems.        *   FILE 744
//*                                                                 *   FILE 744
//*     RRE CONSISTS OF TWO PARTS:                                  *   FILE 744
//*     - CD/ID/HR VERIFICATION AGAINST RACF AND VICE VERSA         *   FILE 744
//*     - RULES CHECKING FOR RACF GROUP-, USER- (INCL.              *   FILE 744
//*       CONNECTS), DATASET- AND GENERAL RESOURCE PROFILES         *   FILE 744
//*                                                                 *   FILE 744
//*     Copyrights:                                                 *   FILE 744
//*     - Copyrights remain with Alain Steffen (ALS                 *   FILE 744
//*       Switzerland) and Eugene Vogt.                             *   FILE 744
//*                                                                 *   FILE 744
//*     Code:                                                       *   FILE 744
//*     - Only load modules are supplied plus the SAMPLIB and a     *   FILE 744
//*       COMMANDS lib.                                             *   FILE 744
//*                                                                 *   FILE 744
//*     Documentation:                                              *   FILE 744
//*     - Refer to the PDF document supplied with this pds as       *   FILE 744
//*       member $RREPDS.                                           *   FILE 744
//*                                                                 *   FILE 744
//*     Usage:                                                      *   FILE 744
//*     - The supplied programs can be freely utilized on an        *   FILE 744
//*       'asis' basis.                                             *   FILE 744
//*                                                                 *   FILE 744
//*     Bugs:                                                       *   FILE 744
//*     - Report them to racfra2@bluewin.ch - www.racf.ch           *   FILE 744
//*                                                                 *   FILE 744
//*     Disclaimer :                                                *   FILE 744
//*     ----------                                                  *   FILE 744
//*     There are no warranties, either expressed, or implied       *   FILE 744
//*     on any the programs contained within. The authors try       *   FILE 744
//*     to test as much as is reasonable, but it is ultimately      *   FILE 744
//*     the responsibility of the user to ensure that the           *   FILE 744
//*     programs will not compromise the integrity of their         *   FILE 744
//*     environment. In other words, these programs are 'Use at     *   FILE 744
//*     your own Risk'.                                             *   FILE 744
//*                                                                 *   FILE 744

```
