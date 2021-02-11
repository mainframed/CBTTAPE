```
//***FILE 398 is from the contributor of File 171, which was        *   FILE 398
//*           contributed semi-anonymously.  All correspondence     *   FILE 398
//*           concerning this file should go through Sam Golob,     *   FILE 398
//*           and the support questions will be facilitated that    *   FILE 398
//*           way.                                                  *   FILE 398
//*                                                                 *   FILE 398
//*           This file contains a macro called IBMMAC.  This       *   FILE 398
//*           macro calls other control block mapping macros,       *   FILE 398
//*           but you don't have to remember their names.           *   FILE 398
//*           That's the idea.                                      *   FILE 398
//*                                                                 *   FILE 398
//*           For example, if you want to map a VTOC DSCB, you      *   FILE 398
//*           don't have to remember that IBM's mapping macro       *   FILE 398
//*           name is IECSDSL1, and that you have to code a 1,      *   FILE 398
//*           2, 3, 4, 5, or 6 afterward, depending on the format   *   FILE 398
//*           type you want mapped.  With this macro, you only      *   FILE 398
//*           have to code:    IBMMAC VTOC=4 , or something         *   FILE 398
//*           similar, depending on the format type you want.       *   FILE 398
//*                                                                 *   FILE 398
//*           The original contributor's macro has been improved    *   FILE 398
//*           by Robert Rosenberg.  Bob Rosenberg's macro is now    *   FILE 398
//*           included here as member IBMMAC, and the original      *   FILE 398
//*           contributor's macro is also included, as member       *   FILE 398
//*           IBMMACO.                                              *   FILE 398
//*                                                                 *   FILE 398
//*           There are also two ISPF edit macros called IMAC       *   FILE 398
//*           and IMACBLD from Dave Alcock included here, which     *   FILE 398
//*           perform approximately the same function as the        *   FILE 398
//*           assembler macro IBMMAC--that is, they allow you to    *   FILE 398
//*           properly generate the coding of IBM macros,           *   FILE 398
//*           without your having to know all the particulars.      *   FILE 398
//*           IMACBLD uses the member HANDBOOK (from Gilbert        *   FILE 398
//*           Saint-flour) to generate IMAC, which is the edit      *   FILE 398
//*           macro that generates the IBM assembler macro coding.  *   FILE 398
//*                                                                 *   FILE 398
//*           Sam Golob                                             *   FILE 398
//*           P.O. Box 906                                          *   FILE 398
//*           Tallman, NY  10982-0906                               *   FILE 398
//*                                                                 *   FILE 398
//*                                                                 *   FILE 398
//*           email:  sbgolob@attglobal.net and/or sbgolob@aol.com  *   FILE 398
//*                                                                 *   FILE 398
//*           "Robert A. Rosenberg" <bob.rosenberg@digitscorp.com>  *   FILE 398
//*                                                                 *   FILE 398
//*           Dave Alcock can be reached at his email               *   FILE 398
//*           addresses:   David Alcock <davea@ticnet.com> (home)   *   FILE 398
//*                        dalcock@csw.com   (work)                 *   FILE 398
//*                                                                 *   FILE 398
//*           The author and I both request that others make an     *   FILE 398
//*           attempt to expand the IBMMAC macro to include a       *   FILE 398
//*           larger number of control blocks, and then send the    *   FILE 398
//*           result back to me, for inclusion in this file.        *   FILE 398
//*           Thanks in advance, from everybody, for your help.     *   FILE 398
//*                                                                 *   FILE 398

```
