                    ISPF Client Server Toolbox Release 4 - Corrections

 This library contains components that facilitate viewing and emailing mainframe
 files and reports with Microsoft programs (Notepad, WordPad, Word, Outlook) and
 moving mainframe files and reports quickly between mainframe systems and
 folders on PC Workstations and network drives at speeds typically twenty times
 faster than provided by IND$FILE file transfer. These tools use the services
 provided by and supplement the features of standard ISPF Client Server.

 These tools are intended for non-productional use and may not be suitable for
 or function in your environment.  Communication between a mainframe ISPF
 session and an ISPF Workstation Agent through an IP connection is required but
 can be prevented by network (e.g. firewall and communication port) settings.
 Contact a member of your network support team if a connection between your ISPF
 session and a Workstation Agent cannot be established.

 Those using thick email products other than Microsoft Outlook may be able to
 adapt components to work with their email products.

 This Toolbox was designed for and has been successfully used by people with a
 wide range of technical knowledge ... from experienced system and application
 programmers to people in clerical roles who are just beginning to learn how to
 use ISPF.

 Changes in Corrections to Release 4.
   The EDNLD and EEMAIL modules have been modified to pass the correct
   temporary file names to CDNLD and CEMAIL in environments where the USERID is
   used as the TSO PREFIX and default high level qualifier for the names of
   temporary files.  This issue caused the DOWNLOAD, DNLD and EMAIL commands to
   fail when used as edit macros in Edit and View sessions.

 Changes in "Release 4":

   The EMAIL dialog replaces the OUTLOOK dialog for the purpose of having a more
   meaningful command name that is not tied to a particular email product.

   The new OPENWITH dialog downloads a file to the same working directory used
   by the EMAIL dialog, opens an Explorer window containing the downloaded file,
   and prompts the user to right-click the file and to use "Open with" to open
   the file with the program of his choice.  OPENWITH can be also be used
   instead of the EMAIL dialog and allows the user to change the file name,
   right click and then "Send to Main Recipient".  OPENWITH can be used both
   as a line command on DSLIST and as an edit macro on the command line of a
   View or Edit session.

   Editing for invalid characters in Microsoft Windows file names has been
   restored to the EMAIL (formerly OUTLOOK) dialog.  The version of the FILEXFER
   REXX that can download z/OS Unix files is included.  These features were
   inadvertently omitted from the previous release.

   The edit macros have been simplified and no longer use logic lifted directly
   from Lional Dyck's SDSFPAGE.  Occasional abends when there are no carriage
   control characters or no characters that can pass as carriage control have
   been eliminated. ISREDIT REPLACE is now used to populate the temporary data
   set for ISPF Edit/View and SDSF Edit which cuts execution time by an average
   of 50%.  Slower stem logic is still used when the macros are invoked from CA
   Librarian ELIPS due to CA Librarian ELIPS incompatibility with ISREDIT
   REPLACE.  If you have other non-standard applications that have an Edit-like
   feature that is not compatible with ISREDIT REPLACE, try adding their panel
   names or prefixes to the edit macro logic used to identify ELIPS.

 Changes in "Release 3":

  "Routing dialogs" have been introduced to allow six dialog names to be used
   both as line commands on DSLIST and as edit macros in View and Edit sessions.

   The WORD dialog now alerts a user that a document previously downloaded into
   Microsoft Word may still be open and preventing the download of another
   document into Microsoft Word.

   The introduction of the routing dialogs made it feasible to introduce two new
   commands.  DOWNLOAD and UPLOAD are essentially clones of DNLD and UPLD and
   may be easier for some users to remember.

   Some dialog, panel and message members have been renamed with accompanying
   modifications to panel, REXX and CLIST logic.

   There have been numerous documentation improvements including much needed
   corrections.

 The Microsoft Word document contained in member WORDDOC1 is designed to
 function as an instructional document for end users.  The first page is useful
 as a Quick Reference.  Reviewing this Word document before proceeding further
 with implementation is recommended.  Instructions for downloading and unzipping
 WORDDOC1 are provided towards the end of this member.

 -------------------------------------------------------------------------------

 The IBM ISPF Workstation Agent

 The ISPF Workstation Agent "Windows 2000/NT" install executable prior to z/OS
 2.1 is not compatible with Microsoft Windows 7 unless z/OS APAR OA39571 has
 been implemented:  http://www-01.ibm.com/support/docview.wss?uid=isg1OA39571

 To use ISPF Client Server with Windows 7 if your z/OS version is below 2.1 and
 APAR OA39571 has not been applied:

   *  Upgrade z/OS to Version 2.1
   *  or Apply APAR OA39571
   *  or obtain the Windows 7 compatible install executable for the Workstation
      Agent from IBM.
   *  or copy the five critical WSA components from a workstation running
      Windows XP or below.  (The least acceptable option.)
   *  or download member ISPFINST from this library and unzip the content which
      is the Workstation Agent install file that came with APAR OA39571.

 Constraints of copying the five WSA components from a WinXP to a Win7 PC:

   *  Older versons of the WSA sometimes cannot find or use Windows Socket
      Library components even when the path is manually entered in the WSA "Set
      Winsock Path" dialog.
   *  The older WSA had issues that were resolved by APAR 0A39571
      including abending after tranferring 1.5 GB of a large text file.

 The WSA supplied by APAR OA39571 has been successfully tested on a z/OS 1.19
 system on which APAR 0A39571 has not implemented.

 -------------------------------------------------------------------------------

 An overview of the contents of this library:

 This library contains a variety of module types: CLIST, REXX; ISPF panel,
 skeleton and message; MVS procedure and JCL, Microsoft Word, zipped Microsoft
 Windows executable.  There is no particular reason why a few of the dialogs are
 CLIST instead of REXX.

 This $README member describes the type and purpose of each member in this
 library to assist in moving members to libraries of the appropriate types.

 The three "MVS batch" batch components must be renamed when moved to the
 libraries from which they will be used.  Components associated with ISPF
 dialogs can be used as named.

 -------------------------------------------------------------------------------

 How to "test drive" the online components from this library.

  Normally the online components would be moved to appropriate libraries before
  use.  To facilitate trying out the components, all library allocation (LIBDEF)
  statements currently point to the same library name -
  'KCTSHARE.TECH.ISPFCS.DISTLIB' - regardless of module type.

  1) Install and configure the ISPF Workstation Agent (WSA) per the instructions
     in member DOWNHLP1 or after downloading member WIN7ZIP per instructions
     below.

  2) Configure the mainframe ISPF session per the instructions in member
     DOWNHLP1.

  3) Change all occurances of 'KCTSHARE.TECH.ISPFCS.DISTLIB' in this library to
     the name of the library containing this $README and all other components:
     The members to modify are:  ALLOC CDNLD CEMAIL MFEDIT UPLD UPLOAD

     Henceforth, "library_name" will be used to refer to the name of the library
     containing this $README and the other components.

  4) Exit to the TSO READY prompt and type (or copy and paste) the following:
     EX 'library_name(ALLOC)'
     Note:  The CONCATX REXX executed by the above ALLOC is included in this
            library to faciliate allocating this library to SYSPROC.

  5) Use the CLISTs and Edit Macros documented below.
 -------------------------------------------------------------------------------

 Workstation Agent (WSA):

  ISPFINST  - DO NOT EDIT this member!  It is a ZIP achive of the Workstation
               Agent (WSA) install file (ISPFINST.EXE) provided by APAR OA39571.

               Use member ISPFINST only if your environment is at z/OS version
               1.19 or below and APAR OA39571 has not been implemented.

               If you use ISPFINST, download it in binary mode as ISPFINST.ZIP
               to a PC workstation.  Unzip the contents and then run
               ISPFINST.EXE to install the Workstation Agent.

               Hint:  To make future WSA upgrades possible via the update
               feature of ISPF 3.7.1, install the WSA in a folder whose name and
               path do not include spaces and which has a total path/folder name
               length of 60 characters or less.


 Mainframe components:

  CLIST and REXX:

   The following seven "routing dialogs" function as both line commands on
   DSLIST and as edit macros in Edit and View sessions:

   DNLD     - Command that determines if the user is in an EDIT/VIEW session.
               If yes, EDNLD is invoked.  If no, CDNLD is invoked
   DOWNLOAD - A clone of DNLD provided for those who prefer using a meaningful
               word as a command.
   EMAIL    - Command that determines if the user is in an EDIT/VIEW session.
               If yes, EEMAIL is invoked.  If no, CEMAIL is invoked
   NOTEPAD  - Command that determines if the user is in an EDIT/VIEW session.
               If yes, ENOTEPAD is invoked.  If no, CNOTEPAD is invoked
   OPENWITH - Command that determines if the user is in an EDIT/VIEW session.
               If yes, EOPENWTH is invoked.  If no, COPENWTH is invoked
   WORD     - Command that determines if the user is in an EDIT/VIEW session.
               If yes, EWORD is invoked.  If no, CWORD is invoked
   WORDPAD  - Command that determines if the user is in an EDIT/VIEW session.
               If yes, EWORDPAD is invoked.  If no, CWORDPAD is invoked

   The following four dialogs function only as commands - either as line
   commands on DSLIST or executed like a clist (e.g. TSO UPLD) on a command
   line:

   MFEDIT   - Initiates the ISPF Edit of a PC Workstation file.  Displays panel
               MFEDITP on which the user supplies or chooses the source folder
               and supplies the file name.
   UPLD     - Initiate upload of a PC workstation file to mainframe.  Displays
               panel UPLDPANL on which the user supplies or chooses the source
               folder and supplies the file name.
   UPLOAD   - This is a clone of UPLD provided for those who prefer using a
               meaningful word as a command.
   GOOGLE   - A just-for-fun command.  Useful for demonstrating ISPF Client
               server and to highlight that almost any PC workstation program
               can be invoked from mainframe ISPF.
              Invokes Google in Microsoft Internet Explorer to perform a web
               search, e.g. TSO GOOGLE "Things to do in Kansas City"
              The user can also type TSO GOOGLE and then place the cursor
               anywhere on a word (e.g. an error message code) and then press
               the Enter key.
              Invokes ISPF WSCON if a workstation connection does not already
               exist.

   The following five command dialogs are invoked from the previously mentioned
   "routing dialogs". Although they can be directly invoked, it is recommended
   that their existance not be disclosed to users.

   CDNLD    - Initiates a mainframe file download process.
              CDNLD is invoked by DNLD when it is determined that the user is
               not in an Edit or View session.
              CDNLD is invoked by EDNLD when a user is in an Edit or View
               session.
              Displays panel DOWNLOAD from which the user chooses the target
               folder.
   CNOTEPAD - Downloads a file to the WSA working directory and then invokes
               Microsoft Notepad to view the downloaded file.
              CNOTEPAD is invoked by NOTEPAD when it is determined that the
               user is not in an Edit or View session.
              CNOTEPAD is invoked by ENOTEPAD when a user is in an Edit or View
               session.
              Invokes WSCON if a workstation connection does not already exist.
               CNOTEPAD can be but is not normally directly invoked by the user.
   COPENWTH - Command that downloads a file to a working directory specified
               on the EMAILP panel.
              COPENWTH is invoked by OPENWITH when it is determined that the
               user is not in an Edit or View session.
              COPENWTH is invoked by EOPENWTH when a user is in an Edit or View
               session.
              Invokes WSCON if a workstation connection does not already exist.
   CEMAIL   - Command that downloads a file to a working directory specified
               on the EMAILP panel which it displays.
              CEMAIL is invoked by EMAIL when it is determined that the
               user is not in an Edit or View session.
              CEMAIL is invoked by EEMAIL when a user is in an Edit or View
               session.
   CWORD    - Downloads a mainframe file to the directory where the WSA is
               installed and then invoke Microsoft Word to view it.
              CWORD is invoked from WORD when it is determined that the user is
               not in an Edit or View session.
              CWORD is invoked from EWORD when a user is in an Edit or View
               session.
              Invokes WSCON if a workstation connection does not already exist.
               CWORD can be but is not normally directly invoked by the user.
   CWORDPAD - Downloads a file to the WSA working directory and then invokes
               Microsoft WordPad to view the downloaded file.
              CWORDPAD is invoked from WORDPAD when it is determined that the
               user is not in an Edit or View session.
              CWORDPAD is invoked from EWORDPAD when a user is in an Edit or
               View session.
              Invokes WSCON if a workstation connection does not already exist.
               CWORDPAD can be but is not normally directly invoked by the user.

   The following five edit macros are invoked from the previously mentioned
   "routing dialogs". Although they can be directly invoked, it is recommended
   that their existance not be disclosed to users.

   EDNLD    - Edit macro that stores the contents of a displayed mainframe file
               or report in a temporary file when in an Edit or View session.
              Invokes CDNLD.
              This edit macro can be invoked directly but is normally invoked by
               DNLD.
   ENOTEPAD - Edit macro that stores the contents of a displayed mainframe file
               or report in a temporary file when in an Edit or View session.
              Invokes CNOTEPAD.
              This edit macro can be invoked directly but is normally invoked by
               NOTEPAD.
   EOPENWTH - Edit macro that stores the contents of a displayed mainframe file
               or report in a temporary file when in an Edit or View session.
              Invokes COPENWTH.
              This edit macro can be invoked directly but is normally invoked by
               OPENWITH.
   EEMAIL   - Edit macro that stores the contents of a displayed mainframe file
               or report in a temporary file when in an Edit or View session.
              Invokes CEMAIL.
              This edit macro can be invoked directly but is normally invoked by
               EMAIL.
   EWORD    - Edit macro that stores the contents of a displayed mainframe file
               or report in a temporary file when in an Edit or View session.
              Invokes CWORD.
              This edit macro can be invoked directly but is normally invoked by
               WORD.
   EWORDPAD - Edit macro that stores the contents of a displayed mainframe file
               or report in a temporary file when in an Edit or View session.
              This edit macro can be invoked directly but is normally invoked by
               WORDPAD.

   The following six dialogs are invoked only from panels or other dialogs.
   NEVER INVOKE THEM DIRECTLY!  (Seriously ... don't do it.)

   DNLDACTV - Invokes ISPF FILEXFER command to download a mainframe file
               interactively.
              Invokes ISPF WSCON if a workstation connection does not already
               exist.
              This command is invoked only by panel DNLDPANL and never directly
               by the user.
   DNLDBTCH - Constructs batch JCL and a REXX exec to download a mainframe
               file.  Runs the ISPF FILEXFER command in an ISPF batch session.
              Displays execution JCL based on skeleton FILEXFER for manual
               submission or submits automatically depending on DOWNLOAD panel
               setting.
              The batch job establishes its own workstation connection.
              This command is invoked only from panel DNLDPANL and never
               directly by the user.
   MFEDIT$$ - Invokes ISPF Edit of workstation file.  Changes made in ISPF
               are saved to the workstation file.
              Invokes ISPF WSCON if a workstation connection does not already
               exist.
              This command is invoked only by panel MFEDITP and never directly
               by the user.
   EMAIL$   - Command executed by panel EMAILP to download the file specified
               in the "Attachment name" field and then to invoke a Windows email
               program with the downloaded file as an attachment.
              This command is invoked only by panel EMAILP and never
               directly by the user.
   UPLDACTV - Invokes ISPF FILEXFER command to upload a mainframe file
               interactively.
              Invokes ISPF WSCON if a workstation connection does not already
               exist.
              Displays the ISPF Data Set Utility panel to facilitate allocation
               of the mainframe file if it does not already exist.
              This command is invoked only by panel UPLDPANL and never directly
               by the user.
   UPLDBTCH - Constructs batch JCL and a REXX exec to upload a mainframe file.
               Runs the ISPF FILEXFER command in an ISPF batch session.
              Displays the ISPF Data Set Utility panel to facilitate allocation
               of the mainframe file if it does not already exit.
              Displays execution JCL based on skeleton FILEXFER for manual
               submission or submits automatically depending on UPLDPANL panel
               setting.
              The batch job establishes its own workstation connection.
              This command is invoked only by panel UPLDPANL and never directly
               by the user.

  ISPF Panel (ISPPLIB):

   DNLDPANL - Receives user entry of Workstation file name, directory paths,
               options and specifications.
               If selected mode is Interactive, invokes DNLDACTV.
               If selected mode is Batch, invokes DNLDBTCH.
   DNLDHLP1 - Displays Help for all panels in this suite.
              Provides instructions on installing and configuring the ISPF
               Workstation Agent.
              Provides mainframe system information necessary for automating the
               workstation connection.  May be customized for your installation.
   MFEDITP  - Receives user entry of Workstation file name and directory paths.
              Invokes REXX MFEDIT$$.
   UPLDPANL - Receives user entry of Workstation file name, mainframe file name,
               directory paths, options and specifications.
               If selected mode is Interactive, invokes UPLDACTV.
               If selected mode is Batch, invokes UPLDBTCH.
   EMAILP   - Displays a panel on which the user specifies a working directory
               that will receive a file download before it is attached to a new
               Microsoft Outlook email.

  ISPF Skeleton (ISPSLIB):

   FILEXFER - A JCL skeleton used by REXX execs DNLDBTCH and UPLDBTCH to
               build a manually or automatically submitted file transfer job.
               Customize the skeleton's JOB card with accounting information
               appropriate for your organization.

  ISPF Message (ISPMLIB):

   DNLD00   - An ISPF message library member


  MVS Batch components:

   XFERJCL  - Sample execution JCL.  Copy it to a JCL or documentation library
               renaming it FILEXFER or a name of your choice.
   XFERPROC - Batch procedure for transferring files between mainframe and PC
               workstation in TEXT or BINARY. Runs ISPF in batch mode.
              Suitable for building jobstreams in which there are multiple file
               transfer steps.
              Refer to sample execution JCL in distribution library member
               XFERJCL
              Copy this MVS procedure to a PROCLIB and rename it FILEXFER.
              Modify the SYSEXEC DSN= parameter to reference the library where
              REXX exec FILEXFER resides.
   XFERREXX - REXX exec which accepts control card input containing file
               transfer specifications.  Executed as "FILEXFER" by the batch
               procedure stored in member XFERPROC of this distribution library.
              Copy this REXX exec to a CLIST, REXX or control card library
               and rename it FILEXFER.

  Microsoft Word (Do not Edit this member!):

   WORDDOC1 - A zip archive containing an instructional document for end users
              in Microsoft Word format.

              Download WORDDOC1 in binary to file_name_of_your_choice.zip .
              Then upzip the contents to file_name_of_your_choice.doc and
              customize for your users.

 Implementing the ISPF components:

  Store Edit macros in a SYSPROC library allocated to the ISPF session.

  Panel (ISPPLIB), Skeleton (ISPSLIB) and Message (ISPMLIB) libraries are
   allocated dynamically using LIBDEF statements in CLIST or REXX modules CDNLD,
   MFEDIT, CEMAIL, UPLD and UPLOAD and need not be placed in libraries
   allocated in the TSO logon procedure.  It is, however, necessary to modify
   the LIBDEF statements to point to the libraries in which you store the panel,
   skeleton and message modules.  The above named CLIST and REXX modules
   currently have "commented" allocation statements for libraries in the authors
   mainframe environment - these statements can, of course, be removed.

  As provided, all CLIST modules and the non-edit macro REXX modules must also
   reside in SYSPROC libraries allocated to the ISPF session.  Adding additional
   LIBDEF statements to CDNLD, MFEDIT, UPLD and UPLOAD to dynamically allocate
   CLIST/REXX libraries may allow the remaining CLIST and REXX modules to be
   stored in libraries not allocated in the TSO logon procedure.

  Remove or "comment" existing LIBDEF statements if you store the panel,
   skeleton and message library components in libraries allocated by your TSO
   logon procedure.
