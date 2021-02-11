```
//***FILE 264 is from Guy Albertelli in Akron, Ohio, and contains   *   FILE 264
//*           several TSO command processors.  A load module for    *   FILE 264
//*           LOOK is on File 035 of the CBT Tape, and several      *   FILE 264
//*           of them are included in the LOADLIB member in this    *   FILE 264
//*           pds, which is in TSO XMIT format.  LOOKN, which is    *   FILE 264
//*           our 64-bit version of LOOK, is finally out, and is    *   FILE 264
//*           included here.  Much worth "look"ing at.              *   FILE 264
//*                                                                 *   FILE 264
//*       Please send inquiries and questions to Sam Golob.         *   FILE 264
//*                                                                 *   FILE 264
//*       email:  sbgolob@cbttape.org                               *   FILE 264
//*                                                                 *   FILE 264
//*       Please read the $$NOTExx members before assembling the    *   FILE 264
//*       LOOK command with anything other than the defaults.       *   FILE 264
//*       An example for coding your own macro definitions can      *   FILE 264
//*       be found by looking at members CBMACSE and LOOK$$$.       *   FILE 264
//*                                                                 *   FILE 264
//*       LOOK or LOOKN is the "driver program" for CBMACS, which   *   FILE 264
//*       formats macro layouts.  Any version of LOOK can drive     *   FILE 264
//*       any version of CBMACS (I think).  They are put together   *   FILE 264
//*       at assembly time.  So look carefully at the assembly JCL. *   FILE 264
//*                                                                 *   FILE 264
//*           The command processors are:                           *   FILE 264
//*                                                                 *   FILE 264
//*             A  LOOKN   -  The 64-bit version of LOOK. 10 years  *   FILE 264
//*                           in coming out.  Must run authorized.  *   FILE 264
//*                           Details are almost the same as in     *   FILE 264
//*                           LOOKJ below. Indirect addressing for  *   FILE 264
//*                           8-byte (64-bit) addresses, is done    *   FILE 264
//*                           with a "G" command instead of "J".    *   FILE 264
//*                           (Much of the work was done by         *   FILE 264
//*                            Joe Reichman.  Thanks, Joe.)         *   FILE 264
//*                                                                 *   FILE 264
//*             1  LOOKJ   -  LOOK is a TSO command processor that  *   FILE 264
//*                           allows full screen display of real    *   FILE 264
//*                           time memory, in any address space.    *   FILE 264
//*                           The LOOK command has been enhanced    *   FILE 264
//*                           to make it easy to add new control    *   FILE 264
//*                           block maps, usually in 3 or 4         *   FILE 264
//*                           statements.                           *   FILE 264
//*                                                                 *   FILE 264
//*                           This is a new version of LOOK,        *   FILE 264
//*                           designed to eliminate the S0C4        *   FILE 264
//*                           abends which LOOK gets on z/OS 2.x    *   FILE 264
//*                           if a bad address is entered.          *   FILE 264
//*                           (Fixed by Joe Reichman)               *   FILE 264
//*                                                                 *   FILE 264
//*                           Very importantly, this version of     *   FILE 264
//*                           LOOK can be run without getting       *   FILE 264
//*                           user key CSA.                         *   FILE 264
//*                                                                 *   FILE 264
//*                           Downside is that this version must    *   FILE 264
//*                           be run APF-authorized always.         *   FILE 264
//*                                                                 *   FILE 264
//*                           But importantly, you do not need      *   FILE 264
//*                           to set in PARMLIB DIAGxx member:      *   FILE 264
//*                           VSM ALLOWUSERKEYCSA(NO) , because     *   FILE 264
//*                           this version of LOOKJ does not        *   FILE 264
//*                           obtain user key CSA.  It now gets     *   FILE 264
//*                           its working storage in Key 0.         *   FILE 264
//*                                                                 *   FILE 264
//*                LOOK0x  -  Earlier versions of LOOK (source)     *   FILE 264
//*                                                                 *   FILE 264
//*                The LOADLIB contains a version of LOOK which     *   FILE 264
//*                was assembled against modified IBM macros that   *   FILE 264
//*                I could not include here, and it formats the     *   FILE 264
//*                TPVT control block, off the TSVT control block.  *   FILE 264
//*                It also cleans up the display of macro IKJEFLWA  *   FILE 264
//*                so that most fields display clearly.             *   FILE 264
//*                                                                 *   FILE 264
//*                Members in the LOADLIB XMIT file:                *   FILE 264
//*                                                                 *   FILE 264
//*                LOOK    - Assembled with member LOOK$$$          *   FILE 264
//*                          (current version)                      *   FILE 264
//*                LOOKX   - Assembled with member LOOK$$           *   FILE 264
//*                          (current version)                      *   FILE 264
//*                LOOK1   - Old version of LOOK, before Joe's      *   FILE 264
//*                          fixes. Subject to S0C4 abends          *   FILE 264
//*                          in z/OS 2.x                            *   FILE 264
//*                UKEYCSA - TSO command to flip the bits that      *   FILE 264
//*                          allow/disallow user key CSA.           *   FILE 264
//*                          Program only good from z/OS 1.8        *   FILE 264
//*                          thru z/OS 2.3.  Won't work in 2.4.     *   FILE 264
//*                                                                 *   FILE 264
//*            (The LOOK command is a "MUST" to know about - SG)    *   FILE 264
//*                                                                 *   FILE 264
//*            Important note, for the LOOK command to work:        *   FILE 264
//*            --------- ----  --- --- ---- ------- -- ----         *   FILE 264
//*               The newest version of LOOKJ does not obtain       *   FILE 264
//*               CSA storage in a user key, so it does not         *   FILE 264
//*               depend on the PARMLIB setting, mentioned          *   FILE 264
//*               below, which will go away anyway, in z/OS         *   FILE 264
//*               2.4.                                              *   FILE 264
//*                                                                 *   FILE 264
//*               However, for earlier versions of LOOK, which      *   FILE 264
//*               obtained user key CSA, there is a dependency      *   FILE 264
//*               on a PARMLIB setting to allow user key CSA.       *   FILE 264
//*                                                                 *   FILE 264
//*               This issue only starts with z/OS 1.8. !!!!!       *   FILE 264
//*               The PARMLIB setting is in the DIAGxx member:      *   FILE 264
//*                                             ****                *   FILE 264
//*               >>>>>>>>  VSM ALLOWUSERKEYCSA(YES)   <<<<<<<<     *   FILE 264
//*                                                                 *   FILE 264
//*               This was the default at z/OS 1.8, but in          *   FILE 264
//*               z/OS 1.9, VSM ALLOWUSERKEYCSA(NO) became the      *   FILE 264
//*               default.  It now has to be specifically set to    *   FILE 264
//*               VSM ALLOWUSERKEYCSA(YES), or LOOK will abend      *   FILE 264
//*               with a SB0A, reason code 5C.                      *   FILE 264
//*            -------------------------------------------------    *   FILE 264
//*            For commercial installations, it is probably         *   FILE 264
//*            unsafe to set VSM ALLOWUSERKEYCSA(YES) in the        *   FILE 264
//*            active DIAGxx member of PARMLIB.  It leaves a bit    *   FILE 264
//*            too much of a security hole.  So you should set      *   FILE 264
//*            VSM ALLOWUSERKEYCSA(NO).  But in a pinch, if         *   FILE 264
//*            you just HAVE to use the LOOK command, there is      *   FILE 264
//*            an APF-authorized TSO command called UKEYCSA that    *   FILE 264
//*            has been supplied, which can flip the controlling    *   FILE 264
//*            bits temporarily, to temporarily allow (globally)    *   FILE 264
//*            CSA to be allocated in a User Storage Key, just so   *   FILE 264
//*            you can use LOOK, and then you can set it back       *   FILE 264
//*            so the system will no longer allow User Key storage  *   FILE 264
//*            allocation in CSA.  UKEYCSA Y and then UKEYCSA N.    *   FILE 264
//*                                                                 *   FILE 264
//*            UKEYCSA will only work in z/OS versions from 1.8     *   FILE 264
//*            thru 2.3.  It will stop working in z/OS 2.4.         *   FILE 264
//*            -------------------------------------------------    *   FILE 264
//*    NOTE:   THE NEW SOURCE FOR LOOKJ DOES NOT GET USER KEY CSA,  *   FILE 264
//*            SO IT DOES NOT DEPEND ON THE ABOVE PARMLIB SETTING.  *   FILE 264
//*            -------------------------------------------------    *   FILE 264
//*            See member $$NOTE02 for assembling fields present    *   FILE 264
//*              in IBM macros, but which are not shown by the      *   FILE 264
//*              formatting program CBMACS.  What to do?            *   FILE 264
//*            See member called LOADLIB for load modules.          *   FILE 264
//*            -------------------------------------------------    *   FILE 264
//*                                                                 *   FILE 264
//*             2 DUDASD      AN UPDATED VERSION FROM FILE 300 OF   *   FILE 264
//*                           THIS TAPE THAT HAS BEEN CONVERTED     *   FILE 264
//*                           TO FUNCTION UNDER EITHER SP OR XA.    *   FILE 264
//*                                                                 *   FILE 264
//*                           (Fixed by Albert Cheng (CBT File 612) *   FILE 264
//*                           for 4-digit unit addresses and other  *   FILE 264
//*                           matters.  DUDASD00 is the original    *   FILE 264
//*                           version.  JVD***** macros copied here *   FILE 264
//*                           for completeness, even if not used by *   FILE 264
//*                           the newer version of the program.)    *   FILE 264
//*                                                                 *   FILE 264
//*             3 JLOG        A PROGRAM TO PRINT OUT THE JES JOBLOG *   FILE 264
//*                           AND OR ANY OTHER JES DATASETS, EVEN   *   FILE 264
//*                           IF THEY ARE QUEUED TO A DUMMY CLASS.  *   FILE 264
//*                           USEFUL IN OBTAINING THE JOBLOG OF     *   FILE 264
//*                           ABENDING STARTED TASKS.               *   FILE 264
//*                                                                 *   FILE 264

```
