```
//***FILE 344 is a REXX EXEC from Joerg Berning to list the VTOC    *   FILE 344
//*           of a disk pack, and display it under ISPF EDIT.  It   *   FILE 344
//*           is a handy dandy, quick method of displaying disk     *   FILE 344
//*           extents.   (NEW IMPROVED VERSION AS OF V-423.)        *   FILE 344
//*                                                                 *   FILE 344
//*   Updated 03-25-02.  See below (what's new?) for information.   *   FILE 344
//*                                                                 *   FILE 344
//*   >>>>    This file has now been expanded to included    <<<<   *   FILE 344
//*   >>>>    various other utilities from Joerg Berning,    <<<<   *   FILE 344
//*   >>>>    which are described below.                     <<<<   *   FILE 344
//*                                                                 *   FILE 344
//*           Private:                                              *   FILE 344
//*           joerg.berning@gmx.net                                 *   FILE 344
//*           (+49)6172/941525(-6 automatic answering machine)      *   FILE 344
//*           D-61352 Bad Homburg                                   *   FILE 344
//*                                                                 *   FILE 344
//*           Duty:                                                 *   FILE 344
//*           joerg_berning@de.sonymusic.com                        *   FILE 344
//*           (+49)69/13888-432                                     *   FILE 344
//*           D-60313 Frankfurt am Main                             *   FILE 344
//*                                                                 *   FILE 344
//*       POSTAL:     JOERG BERNING                                 *   FILE 344
//*                   IN DEN LICHGAERTEN 3                          *   FILE 344
//*                   D-61352 BAD HOMBURG                           *   FILE 344
//*                   GERMANY(HESSEN)                               *   FILE 344
//*                                                                 *   FILE 344
//*   -----------------------------------------------------------   *   FILE 344
//*                                                                 *   FILE 344
//*     Thanks to Gilbert Saint-flour for letting me use his        *   FILE 344
//*     disclaimer:                                                 *   FILE 344
//*                                                                 *   FILE 344
//*     Joerg Berning neither expresses nor implies any             *   FILE 344
//*     warranty as to the fitness of these computer programs       *   FILE 344
//*     for any function.  The use of these programs or the         *   FILE 344
//*     results therefrom is entirely at the risk of the user.      *   FILE 344
//*     Consequently, the user may modify these programs in         *   FILE 344
//*     any way he/she thinks fit.                                  *   FILE 344
//*                                                                 *   FILE 344
//*     These programs are Freeware and may be freely copied.       *   FILE 344
//*     They may be freely distributed to any other party on        *   FILE 344
//*     condition that no inducement beyond reasonable              *   FILE 344
//*     handling costs is offered or accepted by either side        *   FILE 344
//*     for such distribution.                                      *   FILE 344
//*                                                                 *   FILE 344
//*     I would be interested to hear of comments and/or            *   FILE 344
//*     proposed enhancements.  Please write to                     *   FILE 344
//*     joerg.berning(at)gmx.net.                                   *   FILE 344
//*                                                                 *   FILE 344
//*   -----------------------------------------------------------   *   FILE 344
//*                                                                 *   FILE 344
//*     What's new?                                                 *   FILE 344
//*                                                                 *   FILE 344
//*     25.03.2002:                                                 *   FILE 344
//*     3.4Command Tracks                                           *   FILE 344
//*       Works for: + volumes                                      *   FILE 344
//*                  + DSLevel without volume                       *   FILE 344
//*                                                                 *   FILE 344
//*       Does not work for: - DSLevel with volume                  *   FILE 344
//*       Because I'm unable to get the DSLevel and volume          *   FILE 344
//*       from 3.4(panel ISRUDLP)(I tried ZALVOL, ZDLDSNLV,         *   FILE 344
//*       ZDLPVL and some other 4282 variables) I have to grab      *   FILE 344
//*       the DSLevel or volume from the screen.                    *   FILE 344
//*                                                                 *   FILE 344
//*     TSOCommand VGet                                             *   FILE 344
//*       Lists all variables from the member VGETTAB.              *   FILE 344
//*                                                                 *   FILE 344
//*     EditMacro MacroRes                                          *   FILE 344
//*       Added isredit preserve on.                                *   FILE 344
//*                                                                 *   FILE 344
//*     - - - - - - - - - - - - - - - - - - - - - - - - - - - -     *   FILE 344
//*                                                                 *   FILE 344
//*     The fun starts here:                                        *   FILE 344
//*                                                                 *   FILE 344
//*     EditMacro Add (<FromCol ToCol>)                             *   FILE 344
//*        Adds the numbers in the selected rows. Display at        *   FILE 344
//*        the bottom line.  Easily saveable with the               *   FILE 344
//*        MD(MakeData)-LineCommand.                                *   FILE 344
//*                                                                 *   FILE 344
//*     3.4 Command DelNoEnq                                        *   FILE 344
//*        Frontend for the BYPASSNQ-Program (Gilbert               *   FILE 344
//*        Saint-flour).  Scratches the dataset under 3.4 with      *   FILE 344
//*        IEHPROGM, no uncatalog is done.                          *   FILE 344
//*                                                                 *   FILE 344
//*     TSO-Batch Command HLQInfo                                   *   FILE 344
//*        Produces a listing containing all HLQs and some          *   FILE 344
//*        RACF-Information.                                        *   FILE 344
//*                                                                 *   FILE 344
//*     TSO Command LDDDef <dddef-entry>                            *   FILE 344
//*        LIST ALLZONES DDDEF(...). Says it all.                   *   FILE 344
//*                                                                 *   FILE 344
//*     TSO Command ListVTOC <volser>                               *   FILE 344
//*        This REXX works to display the contents of a volume      *   FILE 344
//*        and EDIF the result.  The resulting dataset display      *   FILE 344
//*        is very handy.  Just load the 2 members into a           *   FILE 344
//*        SYSPROC or SYSEXEC library and enter LISTVTOC            *   FILE 344
//*        volser.                                                  *   FILE 344
//*                                                                 *   FILE 344
//*     3.4 Command LZ                                              *   FILE 344
//*        Requires Target4-PKZIP-Utility.                          *   FILE 344
//*        Displays the contents of a ZIP-Archive.                  *   FILE 344
//*                                                                 *   FILE 344
//*     3.4 Command LZD                                             *   FILE 344
//*        Requires Target4-PKZIP-Utility.                          *   FILE 344
//*        Displays the contents of a ZIP-Archive more              *   FILE 344
//*        detailed.                                                *   FILE 344
//*                                                                 *   FILE 344
//*     Edit Macro MacroRes                                         *   FILE 344
//*        ISREDIT RESET                                            *   FILE 344
//*                                                                 *   FILE 344
//*     Job MAN                                                     *   FILE 344
//*        For those OMVS-Commands...                               *   FILE 344
//*                                                                 *   FILE 344
//*     TSO Command OMVSSEG                                         *   FILE 344
//*        Output is a listing of all UserIDs & groups and          *   FILE 344
//*        their OMVS-Segment-information. Could take a while.      *   FILE 344
//*                                                                 *   FILE 344
//*     TSO Command ShowDP                                          *   FILE 344
//*        Produces a listing of all active address spaces          *   FILE 344
//*        sortet by dispatching priority.  Helps if your system    *   FILE 344
//*        is in compatibility mode.                                *   FILE 344
//*                                                                 *   FILE 344
//*     TSO Command SMPEWarn                                        *   FILE 344
//*        Produces a listing of the (cataloged) datasets           *   FILE 344
//*        with dataset- information (like how many free            *   FILE 344
//*        directory-blocks are available).                         *   FILE 344
//*                                                                 *   FILE 344
//*     TB Disp                                                     *   FILE 344
//*        Produces a formatted listing of the table. Handy for     *   FILE 344
//*        ISMF-saved tables. May take some time.                   *   FILE 344
//*                                                                 *   FILE 344
//*     Edit Macro Y99                                              *   FILE 344
//*        Sets the member statistics to a specific date.  Handy    *   FILE 344
//*        for resetting Y2K-touched members.                       *   FILE 344
//*                                                                 *   FILE 344

```
