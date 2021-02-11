
## @FILE415.txt
```
//***FILE 415 is from Rob Prins, and is his magnificent TSO full    *   FILE 415
//*           screen Editor and multi-utility programmer facility   *   FILE 415
//*           called RPF.  RPF runs under native TSO (or as a TSO   *   FILE 415
//*           command processor, even if ISPF is running too, and   *   FILE 415
//*           RPF has an ISPF-like editor, browser, and quite a     *   FILE 415
//*           few other utilities.                                  *   FILE 415
//*                                                                 *   FILE 415
//*       RPF is an excellent recovery tool for TSO allocation      *   FILE 415
//*       errors, and for other situations where ISPF will not      *   FILE 415
//*       come up, especially under OS/390 and z/OS.                *   FILE 415
//*                                                                 *   FILE 415
//*       Under free MVS 3.8, where ISPF is not available, the      *   FILE 415
//*       RPF editor is often used by many people, because          *   FILE 415
//*       it provides quite a few ISPF-like capabilities, and       *   FILE 415
//*       the RPF editor feels a lot like the ISPF editor.          *   FILE 415
//*                                                                 *   FILE 415
//*       RPF is a Hercules-tested tool. See member $$NOTE03.       *   FILE 415
//*                                                                 *   FILE 415
//*       This version of RPF (1.8.6) can be assembled either       *   FILE 415
//*       for use on z/OS or for use on MVS 3.8J.                   *   FILE 415
//*                                                                 *   FILE 415
//*       For OS/390 and z/OS:                                      *   FILE 415
//*       If you do a TSO RECEIVE of member LOADXMI, the            *   FILE 415
//*       LOADLIB has been created. Actually you don't need         *   FILE 415
//*       to assemble and link RPF, the loadmodules will            *   FILE 415
//*       run on an OS/390 or z/OS system.                          *   FILE 415
//*                                                                 *   FILE 415
//*       For MVS 3.8J and MVS380 systems:                          *   FILE 415
//*       If you do a TSO RECEIVE of member LOADXMIM, the           *   FILE 415
//*       LOADLIB has been created. Actually you don't need         *   FILE 415
//*       to assemble and link RPF, the loadmodules will            *   FILE 415
//*       run on a MVS 3.8 or MVS380 system.                        *   FILE 415
//*                                                                 *   FILE 415
//*       RPF contains a PANVALET, a LIBRARIAN and an ARCHIVER      *   FILE 415
//*       interface in addition to its plain EDIT capability.       *   FILE 415
//*                                                                 *   FILE 415
//*       Please see member $$INTRO, by Volker Bandke/Rob Prins     *   FILE 415
//*       Please see member $$INTRO2, by Rob Prins.                 *   FILE 415
//*                                                                 *   FILE 415
//*       The RPF editor comes with a full manual.                  *   FILE 415
//*       Three formats of the manual have been provided:           *   FILE 415
//*                                                                 *   FILE 415
//*          RPFUGUID -  In ASM library     - script format         *   FILE 415
//*          $MANUAL@ -  MS Word .doc format- download to a PC      *   FILE 415
//*          $MANUAL# -  PDF format         - download to a PC      *   FILE 415
//*                                                                 *   FILE 415
//*          email:  rob.prins@quicknet.nl                          *   FILE 415
//*                                                                 *   FILE 415
//*       Current version of RPF:  V1R8M6                           *   FILE 415
//*                                                                 *   FILE 415
//*      - - - - - - - - - - - - - - - - - - - - - - - - - - - -    *   FILE 415
//*                                                                 *   FILE 415
//*      RPF - Rob's Programming Facility.                          *   FILE 415
//*                                                                 *   FILE 415
//*      RPF is a command processor under TSO, developed by Rob     *   FILE 415
//*      Prins, member of the systems programming department of     *   FILE 415
//*      the ING Bank in Amsterdam.  For program development the    *   FILE 415
//*      ING Bank used ROSCOE, but when the systems programming     *   FILE 415
//*      group started using TSO for maintenance, the need arose    *   FILE 415
//*      for a full-screen editor under TSO.  At this point Rob     *   FILE 415
//*      decided to develop his own editor, not only because        *   FILE 415
//*      they needed an editor, but also for learning the           *   FILE 415
//*      internals of TSO.  This resulted in the 'RPF' package.     *   FILE 415
//*                                                                 *   FILE 415
//*      It is not only an editor, but it also includes             *   FILE 415
//*      functions like PDS maintenance (SCRATCH, RENAME EDIT,      *   FILE 415
//*      PRINT, BROWSE and assigning ALIAS), foreground assembly    *   FILE 415
//*      and binding, VTOC listing, dataset allocation and          *   FILE 415
//*      deletion and even a LIBRARIAN, PANVALET and ARCHIVE        *   FILE 415
//*      interface to read and write modules or items to a          *   FILE 415
//*      LIBRARIAN disk master, a PANVALET library or an ARCHIVER   *   FILE 415
//*      archive VSAM cluster and a TSO command processor           *   FILE 415
//*      to execute TSO commands in RPF.                            *   FILE 415
//*      ARCHIVER is written by Rick Fochtman and is available      *   FILE 415
//*      in file 147 on www.cbttape.org                             *   FILE 415
//*                                                                 *   FILE 415
//*      The main advantage of an inhouse developed package is,     *   FILE 415
//*      that the source is available, so that it can be tailored   *   FILE 415
//*      to the demands of the user.  As the package became         *   FILE 415
//*      available to the users (the systems programmers) they      *   FILE 415
//*      very soon stopped using ROSCOE for program development,    *   FILE 415
//*      which indicated that it is a very useful product.  RPF     *   FILE 415
//*      is using the MVS operating system.  Afterwards the RPF     *   FILE 415
//*      product became available for the members of the Hercules   *   FILE 415
//*      group.                                                     *   FILE 415
//*                                                                 *   FILE 415
//*      (C)-1979-2020 Skybird Systems                              *   FILE 415
//*                                                                 *   FILE 415
//*      1.2  How to start RPF.                                     *   FILE 415
//*                                                                 *   FILE 415
//*      RPF is a TSO command processor for full screen data        *   FILE 415
//*      editing and utility functions.  RPF can be activated       *   FILE 415
//*      by entering the command 'RPF' on your TSO terminal.        *   FILE 415
//*                                                                 *   FILE 415
//*      1.2.1 How to work with RPF.                                *   FILE 415
//*                                                                 *   FILE 415
//*      If you start RPF a database record with defaults for       *   FILE 415
//*      your userid will be read.  If the record is not present,   *   FILE 415
//*      that record will be created by RPF.                        *   FILE 415
//*                                                                 *   FILE 415
//*      If you enter the TSO command 'RPF FAST' the database       *   FILE 415
//*      will not be included. RPF will choose its own defaults.    *   FILE 415
//*      The main advantage of 'RPF FAST' is that RPF will start    *   FILE 415
//*      very quickly, but the database will not be searched.       *   FILE 415
//*                                                                 *   FILE 415
//*      After RPF has started, the main menu appears on the        *   FILE 415
//*      screen. you can select the following:                      *   FILE 415
//*                                                                 *   FILE 415
//*    ----------------------- RPF main menu --------------------   *   FILE 415
//*    Option  ===>                                                 *   FILE 415
//*                                                                 *   FILE 415
//*      0  DEFAULTS    - Alter / Display session defaults          *   FILE 415
//*      1  BROWSE      - View or browse data sets or members       *   FILE 415
//*      2  EDIT        - Update or create data sets or members     *   FILE 415
//*      3  UTILITY     - Enter UTILITY                             *   FILE 415
//*      4  ASSEMBLER   - Foreground ASSEMBLER and LINK edit        *   FILE 415
//*      5  USER        - Execute RPF user routine                  *   FILE 415
//*      6  TSO         - Execute TSO commands                      *   FILE 415
//*      7  TUTOTIAL    - Display HELP information                  *   FILE 415
//*      8  TEST        - Enter TEST mode (Authorized)              *   FILE 415
//*      9  OPERATOR    - Enter OPERATOR mode                       *   FILE 415
//*      X  EXIT        - Terminate RPF                             *   FILE 415
//*                                                                 *   FILE 415
//*    Hit PF03/15 to terminate RPF                                 *   FILE 415
//*                                                                 *   FILE 415
//*    RPF V1R8M6                  Property of Skybird              *   FILE 415
//*                                                                 *   FILE 415
//*    Use of RPF is free, modifications in consultation with me    *   FILE 415
//*    Information: email rob.prins@quicknet.nl                     *   FILE 415
//*                                                                 *   FILE 415
```

