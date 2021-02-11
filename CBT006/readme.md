```
//***FILE 006 CONTAINS SEVERAL PROGRAMS USED FOR MANIPULATION OF    *   FILE 006
//*           THE CBT TAPE AND CBT OVERFLOW TAPE DOCUMENTATION.     *   FILE 006
//*                                                                 *   FILE 006
//*           The program called CBTUPD is for the purpose of       *   FILE 006
//*           introducing appropriately named ./ ADD NAME= cards    *   FILE 006
//*           into strategic places of the CBT Tape Documentation.  *   FILE 006
//*           The CBT Tape doc can then be conveniently broken      *   FILE 006
//*           up into a pds.  The member names of the pds are       *   FILE 006
//*           in collating sequence order (EBCDIC), so that the     *   FILE 006
//*           members can be put back together as a sequential      *   FILE 006
//*           file, in their proper order.                          *   FILE 006
//*                                                                 *   FILE 006
//*           The program called DOCFILE is from Arnold Casinghino  *   FILE 006
//*           and it puts the indicators in columns 73-80 of the    *   FILE 006
//*           CBT Tape documentation, to indicate your current      *   FILE 006
//*           position within the documentation.                    *   FILE 006
//*                                                                 *   FILE 006
//*           The original idea of the DOCFILE program is from      *   FILE 006
//*           a COBOL program written by Sam Barr of Northrop.      *   FILE 006
//*                                                                 *   FILE 006
//*           DOCFILE has been updated by Sam Golob (03/99) to      *   FILE 006
//*           take into account the fact that there may be lower    *   FILE 006
//*           case characters in the CBT Tape Documentation         *   FILE 006
//*           nowadays.                                             *   FILE 006
//*                                                                 *   FILE 006
//*           To more easily run DOCFILE, so as to make sure that   *   FILE 006
//*           columns 73-80 in the File 001 documentation are       *   FILE 006
//*           correct, I have added 3 clists:  DOCFIL, DOCFILA,     *   FILE 006
//*           and DOCFILN.  DOCFIL checks columns 73-80 in          *   FILE 006
//*           the @FILEnnn member that is in the staging pds,       *   FILE 006
//*           which is named 'userid.CBTver.FILEnnn'.  DOCFILN      *   FILE 006
//*           does the same for the @FILEnnn member of the          *   FILE 006
//*           'userid.CBTDOC.PDS' dataset.  DOCFILA reads an        *   FILE 006
//*           arbitrary FILE001-format pds member, and writes       *   FILE 006
//*           an arbitrary FILE001-format member which has been     *   FILE 006
//*           fixed in columns 73-80.  I now use DOCFILX which      *   FILE 006
//*           was converted to REXX from the CLIST called DOCFILN.  *   FILE 006
//*                                                                 *   FILE 006
//*           This file was moved from File 130 and the former      *   FILE 006
//*           File 006 was moved to File 130.  The reason for       *   FILE 006
//*           that, was that this file should be near the           *   FILE 006
//*           beginning of the CBT Tape, since it is used to        *   FILE 006
//*           process the CBT Tape Documentation File.              *   FILE 006
//*                                                                 *   FILE 006
//*           (Actually both of them are.  I just put this file     *   FILE 006
//*           more "forward", because I think more people are       *   FILE 006
//*           going to use it.  File 130 is for loading the         *   FILE 006
//*           CBT documentation into an INFO/MVS database.          *   FILE 006
//*           I don't know how many people use the INFO/MVS         *   FILE 006
//*           anymore.)                                             *   FILE 006
//*                                                                 *   FILE 006
//*           I've included the OSTARXMT package in this file       *   FILE 006
//*           to make it more available.  Documentation for         *   FILE 006
//*           running this package is in File 365.  The load        *   FILE 006
//*           module for the OSTAREDC assembler program to          *   FILE 006
//*           speed up error checking, is in File 035.  If you      *   FILE 006
//*           get CBT Tape files in OSTARXMT format (LRECL=88),     *   FILE 006
//*           the presence of the OSTARREC exec here, will make     *   FILE 006
//*           it easier for you to handle this format.  Just        *   FILE 006
//*           copy OSTARREC into your SYSPROC or SYSEXEC library    *   FILE 006
//*           and invoke it, against your .XMT files.               *   FILE 006
//*                                                                 *   FILE 006
//*    Note:  This file also contains copies of the ISPF Edit       *   FILE 006
//*           Macros  CBTUPDTE  and  COVUPDTE, which are used       *   FILE 006
//*           to introduce ./ ADD NAME= cards into the CBT Tape     *   FILE 006
//*           and CBT Overflow Tape documentation files.  That      *   FILE 006
//*           will allow them to be converted into partitioned      *   FILE 006
//*           datasets, using IEBUPDTE ,PARM=NEW , or PDSLOAD       *   FILE 006
//*           programs.                                             *   FILE 006
//*                                                                 *   FILE 006
//*           However, the CBTUPD assembler program supersedes      *   FILE 006
//*           these two edit macros, because it is more accurate    *   FILE 006
//*           in checking where to insert the ./ ADD cards,         *   FILE 006
//*           and is less prone to some other errors.               *   FILE 006
//*                                                                 *   FILE 006
//*           As of CBTUPD Version 1.3 (or higher), the changes     *   FILE 006
//*           for each version of the tape are separated out as     *   FILE 006
//*           distinct members, sorted in reverse order.  None of   *   FILE 006
//*           the edit macros did that job, so CBTUPD is distinctly *   FILE 006
//*           better than the CBTUPDTE edit macro.                  *   FILE 006
//*                                                                 *   FILE 006
//*           Version 1.3 of the CBTUPD program was developed and   *   FILE 006
//*           tested on the IBM PC using the Tachyon Cross          *   FILE 006
//*           Assembler and the Tachyon Operating System.  This     *   FILE 006
//*           is a vendor product from Tachyon Software, Denver     *   FILE 006
//*           Colorado, 1-303-722-1341.                             *   FILE 006
//*                www.tachyonsoft.com/tachyon                      *   FILE 006
//*           This product allows you to develop MVS assembler      *   FILE 006
//*           programs on an IBM PC, test them on the PC, and       *   FILE 006
//*           port them to MVS.  The object deck produced by        *   FILE 006
//*           the Tachyon Assembler is compatible with HLASM.       *   FILE 006
//*                                                                 *   FILE 006
//*           Added GENDAT and GENDATE clists to place a time and   *   FILE 006
//*           date stamp into each CBT Tape File pds, before it     *   FILE 006
//*           is shipped.  GENCOV does the same, for files on the   *   FILE 006
//*           CBT Overflow Tape.                                    *   FILE 006
//*                                                                 *   FILE 006
//*           Add Ron Tansky's program CBTCOPY which copies CBT     *   FILE 006
//*           File 001 into a VB dataset in order to save space.    *   FILE 006
//*           Nowadays it's debatable if this program is really     *   FILE 006
//*           needed.  But it's there for the coding example, and   *   FILE 006
//*           maybe it might be useful for someone.  This program   *   FILE 006
//*           occupied CBT File 013, which has now been freed up.   *   FILE 006
//*                                                                 *   FILE 006
//*           Gabriel Gargiulo converted the GENDAT clist to REXX.  *   FILE 006
//*           It is a little better, in that it finds the PDS117    *   FILE 006
//*           message even if it is "in the wrong place".  Thanks,  *   FILE 006
//*           Gabe.  The new REXX is called GENDATR.  GENDATR is    *   FILE 006
//*           what I personally use now, as well as DOCFILX.        *   FILE 006
//*                                                                 *   FILE 006
//*  Note.    Since we are pushing 1000 files on this tape, I am    *   FILE 006
//*           trying to consolidate files which took up file slots  *   FILE 006
//*           in the past.  I don't like to delete anything, so     *   FILE 006
//*           I put the contents of File 042 and File 043 into      *   FILE 006
//*           this file, as members KEYWORDS and KEYWORDH,          *   FILE 006
//*           respectively.                                         *   FILE 006
//*                                                                 *   FILE 006

```
