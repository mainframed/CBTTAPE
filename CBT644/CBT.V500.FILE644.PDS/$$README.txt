Installation Guide

FUSION is available on the CBT tape.  It is file 644 and can be
referenced with the following URL:
ftp://ftp.cbttape.org/pub/cbt/CBT644.zip
Once the Zip file is downloaded, unzip it to a known PC directory.  To
upload the XMI file to the mainframe, first use =6 on the TSO command
line to go to the TSO Command Shell screen.  Then select the ACTIONS tab
of the session and select SEND FILE TO HOST.   This is assuming that you
are using a Windows 3270 emulator.   Other emulators may differ from the
one used in my environment.  Enter the PC FILE name that holds the
unzipped XMI file, such as
\\wbmpfil01\data$\jfcaugh\download\cbt644.xmi.  This was the data set
used when I downloaded file 644.   Click on ADD TO LIST to add the
request to the transfer list.

Under OPTIONS, select the MVS/TSO tab.  Select TRANSFER TYPE as Binary,
RECORD FORMAT as Fixed, and enter 80 as LOGICAL RECORD LENGTH. This
format is needed to unload an XMI file.  Enter 1 for primary cylinder
allocation and 1 for secondary cylinder allocation.   Click on SAVE to
save the new binary protocol.   Click on OK to return to the transfer
panel.   Click on SEND to start the transfer.  This creates a TSO data
set that uses your TSO account id as the high level qualifier followed
by CBT644.XMIBIN.  In my case, it is APRGJFC.CBT644.XMIBIN.   Next use
the TSO RECEIVE command to create the FUSION files.  The command is as
follows:
RECEIVE INDS('dataset') where 'dataset' is the name of the sequential
file, such as RECEIVE INDS('APRGJFC.CBT644.XMIBIN').   This will create
partitioned data set named APRGJFC.CBT462.FILE644.PDS.   The high level
qualifier depends on the TSO account id.  If there is any question about
the data set name, check it when running the RECEIVE command.   It
appears in a text screen as 'Dataset CBT.CBT462.FILE644.PDS from CSSJK
on JES2MVS'.  The CBT qualifier will be replaced with your TSO account
id.  The installation JCL is called $PDSLOAD.  Edit the JCL.   Change
the account information to your shop standards.   Change all occurrences
of USERID to your primary TSO user account id.  USERID will be in lower
case.  Your account id must be in upper case.   This affects the SYSUT1
allocations.  Be sure that the PDS name follows the one created when the
RECEIVE command was run.  The SYSUT2 file allocations begin with FUSION.
It is important to have RACF allow the allocation to occur.  If other
names must be used, then be sure that the LIBDEF references in the CNTL
file are changed, too.  Also, change the REGDSN line in the Fusion exec
to point to the data set name used for the CNTL file.  This should
reflect the SYSUT2 name used in $PDSLOAD for CNTL.  The allocation for
the SYSEXEC needs to follow the shop standard for the installation of
REXX Execs.  Change the SYSUT2 to point to the library where the Execs
reside.   If this is not possible due to restrictions, then utilize the
following TSO command.  It can be stored as a PF key command:
ALTLIB ACTIVATE APPLICATION(CLIST) DATASET ('FUSION.SYSEXEC')
Modify FUSION.SYSEXEC to the alternative SYSEXEC if it was modified.
Type TSO FUSION to start the utility.

User Guide
BASE DSN is the data set containing production source.
UPDATED DSN is the data set containing the third-party vendor software
or the data set that holds tested changes.
DESTINATION DSN is the data set that will hold the result of the FUSION
operation.
MODULE NAME is the name of the module to be updated.   If the name of
the BASE and UPDATED modules are different, then the name of the BASE
module and UPDATED module can be specified in MODULE NAME, separated by
a space.   The DESTINATION module name is then referred to by the BASE
module name. An alternate DESTINATION name can be specified by adding a
third name to the MODULE NAME.
APPLICATION FUNCTION specifies the type of merge operation to be
performed.  Normally, it is MIGRATE.  There are four migration options
available which control how code is moved from one program version to
another.  They are MIGRATE, MOVE, MASSMIG and MANSEL.  They are user
selected in the APPLICATION FUNCTION field of the main FUSION screen.

MIGRATE is used when third-party vendor software needs to be applied to
the base system or when a program fix involving concurrent development
needs to be moved to production.   When code is applied to a module, the
code should always be identified by a fix identifier in columns 1-6 of a
COBOL program and the first and last fields of an Assembler program.
Obsolete code should be commented out and identified with the fix
identifier in columns 1-6 of the COBOL module.  This provides FUSION a
reference when updating the DESTINATION.
MOVE will migrate program code without performing associated deletes on
obsolete code.   This is a true 'cut and paste' operation.  The
programmer is responsible for deleting the code.    This mode is useful
when migrating code to a highly modified member.
MASSMIG will merge all code changes from the old source to the new
source.  The function is similar to MOVE, except that all code found in
the old version will be moved to the new version.  This is useful when a
customer needs to update their base system to the latest release of the
vendor system.  Once again, the user is responsible for performing the
associated deletes on obsolete code.

MANSEL allows user-selected migration of code from one program version
to another.  The UPDATED copy is edited in an 82-byte format, allowing
the user to select lines of code by entering an S in the first column.
This is useful when only a portion of a program needs to be updated or
if the desired code is not identified by a fix identifier.
There are 5 PROCESS OPTIONS that control how FUSION handles the merge
results.  They are DISPLAY, COMPAREA, COMPAREB, PCOMPAREA, and
NORMALIZE. The commands can be entered in PROCESS OPTIONS in any order.
DISPLAY--Displays the DESTINATION module with the merge results.  It is
recommended that this feature always be set.

COMPAREA--Performs a comparison between the updated DESTINATION source
and the BASE source and displays the results.   It is recommended that
this feature always be set.
COMPAREB--Performs a comparison between the updated DESTINATION source
and the UPDATED source.  The results of the compare are displayed.
This feature is useful to verify if all selected lines of code were
merged into the DESTINATION source.  Ideally, the selected lines should
not appear in this comparison.
PCOMPAREA--Prints the results of the COMPAREA comparison.
NORMALIZE--Normalizes numeric data when attempting to update a highly
modified source member.  This helps to prevent merge problems that may
occur in Working Storage.  This option should normally not be used.

FUSION automatically determines the language of the program being
updated.   The current supported languages are COBOL and Assembler
formats.  The Assembler formats include macro and command level,
including online maps.
For result integrity, a two-level comparison process is performed after
a FUSION merge request, if it is requested by the COMPAREA command.
This compares the DESTINATION, or updated program, to the BASE source
program.  This allows inspection of the compare process to ensure that
the lines of code were applied correctly.
Considering that program updates are identified by a fix identifier in
columns 1-6 of a COBOL program and the rightmost field of an Assembler
program, FUSION can selectively migrate code by this identifier.  If the
number is inaccurate or missing then FUSION will not be able to apply
that line of code.  The MANSEL option will allow the programmer to
manually select the desired lines of code if the documentation is
inaccurate or missing.  The effectiveness of FUSION depends in a large
part on the accuracy of the documentation of the changes.  Since FUSION
is not a code analyzer, it is up to the programmer to resolve conflicts
and collisions.  But, there is a high probability that the code will be
merged correctly.  The comparison between the production and DESTINATION
version of the module allows the programmer to verify the merge results.
Another consideration is with code dependencies.  Before applying a
program fix, it is necessary to determine if there are other program
fixes that it is dependent on.

