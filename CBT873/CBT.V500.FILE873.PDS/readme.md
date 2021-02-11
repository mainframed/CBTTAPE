
## @FILE873.txt
```
//***FILE 873 is from Sam Golob, and contains programs and macros   *   FILE 873
//*           to help you do non-APF-authorized UCB scans of real   *   FILE 873
//*           UCB's, using the ULUT (UCB Lookup Table), an          *   FILE 873
//*           undocumented IBM interface that was researched by     *   FILE 873
//*           Gilbert Saint-flour.                                  *   FILE 873
//*                                                                 *   FILE 873
//*       If the UCB's are not going to be changed, there is        *   FILE 873
//*       negligible harm in obtaining them this way.  I think      *   FILE 873
//*       that you don't have to PIN what you are not going to      *   FILE 873
//*       change.                                                   *   FILE 873
//*                                                                 *   FILE 873
//*       Several macros:  ULUINIT and ULUSCAN, were created        *   FILE 873
//*        to simplify the coding of programs that use this         *   FILE 873
//*        UCB lookup method.  ULUDSECT describes the work          *   FILE 873
//*        area used by ULUINIT and ULUSCAN.                        *   FILE 873
//*                                                                 *   FILE 873
//*       The 31-bit versions of these programs were tested         *   FILE 873
//*       to work on MVS systems ranging from ESA 5.2.2 thru        *   FILE 873
//*       z/OS 2.1 (before the PTFs described below).               *   FILE 873
//*                                                                 *   FILE 873
//*       For ULUT Type 3 (and later), the ULUT is now located      *   FILE 873
//*       in 64-bit storage.  This is for z/OS 2.2, and for         *   FILE 873
//*       PTF levels in z/OS 2.1 and 1.13.  (UA90741 - PUT 1412)    *   FILE 873
//*                                                                 *   FILE 873
//*          UA90741 - HBB7790 - z/OS 2.1                           *   FILE 873
//*          UA90740 - HBB7780 - z/OS 1.13                          *   FILE 873
//*          UA90742 - JBB778H - z/OS 1.13 - on top of UA90740      *   FILE 873
//*                                                                 *   FILE 873
//*       The 64-bit ULUT load modules of our programs were         *   FILE 873
//*       tested on systems ranging from z/OS 1.2 thru z/OS 2.2.    *   FILE 873
//*                                                                 *   FILE 873
//*       To assemble these programs, the assembler needs to        *   FILE 873
//*       recognize 64-bit instructions:  SAM64, SAM31, LLGTF,      *   FILE 873
//*       LG, STG, and so forth.  The operating system level        *   FILE 873
//*       needs to recognize the new opcodes.  (X'01' for SAM64     *   FILE 873
//*       and SAM31, and so forth.)                                 *   FILE 873
//*                                                                 *   FILE 873
//*       For a thorough explanation, please see the pds            *   FILE 873
//*       member $ULUNOTE, and look at the new code in the          *   FILE 873
//*       ULUINIT, ULUSCAN, and ULUDSECT macros.                    *   FILE 873
//*                                                                 *   FILE 873
//*       Included also: IOSDULUT (ULUT type 1) and                 *   FILE 873
//*                      IOSDULU2 (ULUT type 2)                     *   FILE 873
//*                      IOSDULU3 (ULUT type 3) macros              *   FILE 873
//*                      IOSDIOVT (IOVT after UA90741 applied)      *   FILE 873
//*                                                                 *   FILE 873
//*       from the SHOWzOS macro library (CBT File 492),            *   FILE 873
//*       which describe the formats of the ULUT, and the           *   FILE 873
//*       new format of the IOVT.                                   *   FILE 873
//*                                                                 *   FILE 873
//*       From Mark Zelden:                                         *   FILE 873
//*                                                                 *   FILE 873
//*       TSOB  -  REXX exec to capture TSO output and BROWSE       *   FILE 873
//*       TSOE  -  REXX exec to capture TSO output and EDIT         *   FILE 873
//*       TSOR  -  REXX exec to capture TSO output and REVIEW       *   FILE 873
//*                 this works in READY mode if you install         *   FILE 873
//*                 the REVIEW TSO command from File 134, 135.      *   FILE 873
//*       TSOV  -  REXX exec to capture TSO output and VIEW         *   FILE 873
//*                                                                 *   FILE 873
//*       To distinguish between a 31-bit ULUT and a 64-bit ULUT:   *   FILE 873
//*                                                                 *   FILE 873
//*       If IOVT + X'8' (a fullword) is zero, then the ULUT        *   FILE 873
//*       will be 64-bit, and pointed to by IOVT + X'1B8', which    *   FILE 873
//*       is a doubleword address of the ULUT in 64-bit storage.    *   FILE 873
//*       If IOVT + X'8' is not zero, then it points to the ULUT    *   FILE 873
//*       in 31-bit storage, and IOVT + X'1B8' will be zeroes.      *   FILE 873
//*                                                                 *   FILE 873
//*       Also included are some sample images of a ULUT            *   FILE 873
//*       control block, both for Type 1 and Type 2, from           *   FILE 873
//*       actual systems, so you can see how they really            *   FILE 873
//*       look.  These were not updated for ULUT Type 3, but        *   FILE 873
//*       their appearance is similar for Type 3.                   *   FILE 873
//*                                                                 *   FILE 873
//*       email:  sbgolob@cbttape.org    or                         *   FILE 873
//*               sbgolob@attglobal.net                             *   FILE 873
//*                                                                 *   FILE 873
//*       Description of new macros and DSECT:                      *   FILE 873
//*                                                                 *   FILE 873
//*       ULUDSECT - This is a macro describing a control block     *   FILE 873
//*                  which contains all necessary information to    *   FILE 873
//*                  extract what has been gotten from a UCB.       *   FILE 873
//*                  The ULUDSECT "pre-digests" each UCB defined    *   FILE 873
//*                  by a ULUT table entry.  You place a work       *   FILE 873
//*                  area in your program (currently 88 bytes)      *   FILE 873
//*                  to contain this information.                   *   FILE 873
//*                                                                 *   FILE 873
//*       ULUINIT  - Macro to get access to the ULUT table and      *   FILE 873
//*                  its entries.  Then it fills some of the        *   FILE 873
//*                  fields in the ULUDSECT--the ones which         *   FILE 873
//*                  have to do with the ULUT in general, and       *   FILE 873
//*                  not the ones having to do with each table      *   FILE 873
//*                  entry (i.e. the ones relevant to each UCB).    *   FILE 873
//*                                                                 *   FILE 873
//*       ULUSCAN  - Macro to fill in all the UCB-specific fields   *   FILE 873
//*                  in the ULUDSECT.  If you want to do a scan     *   FILE 873
//*                  of all UCB's defined, you loop through the     *   FILE 873
//*                  ULUSCAN macro repeatedly, with the work area   *   FILE 873
//*                  data changed for each invocation.              *   FILE 873
//*                                                                 *   FILE 873
//*       Some sample programs have been included, to show the      *   FILE 873
//*       power of the ULUINIT and ULUSCAN macros, which simplify   *   FILE 873
//*       coding of programs when using the ULUT method of UCB      *   FILE 873
//*       scanning.                                                 *   FILE 873
//*                                                                 *   FILE 873
//*       ULUDIAG  - Display the relevant contents of the ULUDSECT  *   FILE 873
//*                  fields for all defined devices.  It is         *   FILE 873
//*                  instructive to run this program on your own    *   FILE 873
//*                  system, while you are coding other programs    *   FILE 873
//*                  using this method.                             *   FILE 873
//*                                                                 *   FILE 873
//*       ULUDASD  - Adaptation of the UCBDASD program from File    *   FILE 873
//*                  731 to use the ULUINIT and ULUSCAN macros.     *   FILE 873
//*                  (Fixed by George Pavlik to indicate SMS.)      *   FILE 873
//*                                                                 *   FILE 873
//*       ULUTAPE  - Adaptation of the UCBTAPE program from File    *   FILE 873
//*                  731 to use the ULUINIT and ULUSCAN macros.     *   FILE 873
//*                                                                 *   FILE 873
//*       ULUTYPE  - TSO command to list defined devices by type.   *   FILE 873
//*                                                                 *   FILE 873
//*       ULUVOLS  - A much simplified version of ULUDASD.          *   FILE 873
//*                                                                 *   FILE 873
//*       When converting these programs to 64-bit ULUTs, as        *   FILE 873
//*       opposed to the 31-bit ones that were previously used,     *   FILE 873
//*       it is the author's experience that once the ULUINIT,      *   FILE 873
//*       ULUSCAN, and ULUDSECT macros were changed to              *   FILE 873
//*       accommodate ULUT Type 3, the ULUDASD and ULUTAPE          *   FILE 873
//*       programs needed almost no modification.  The only         *   FILE 873
//*       problem encountered was that the base register in         *   FILE 873
//*       31-bit mode had the high-order bit set to one, so that    *   FILE 873
//*       before 64-bit mode was entered, that bit had to be        *   FILE 873
//*       zeroed first.  The LLGTF Rx,Rx instruction had to be      *   FILE 873
//*       used against any register which would locate a            *   FILE 873
//*       quantity via base-displacement while running in 64-bit    *   FILE 873
//*       addressing mode.  Therefore you will see in the           *   FILE 873
//*       programs:   LLGTF R10,R10  directly befoe the ULUINIT     *   FILE 873
//*       macro invocaton.                                          *   FILE 873
//*                                                                 *   FILE 873
//*       If anyone out there writes programs using this method     *   FILE 873
//*       of UCB scanning, it would be appreciated if you notify    *   FILE 873
//*       us about them, so that (with your permission) they may    *   FILE 873
//*       be included in this tape.                                 *   FILE 873
//*                                                                 *   FILE 873
//*           email:   sbgolob@cbttape.org                          *   FILE 873
//*                                                                 *   FILE 873
```

