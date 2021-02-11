
## $DOC.txt
```
SETCLIP

SetClip consists of 3 REXX Exec's and 2 ISPF Panels.

   Members: $DOC     - this member
            $USERDOC - doc to help the end user
            LICENSE  - GPL License
            SETCLIP  - primary rexx exec
            SETCLIPM - rexx ispf edit macro
            SETCLIPP - ispf panel
            SETCLIPH - ispf tutorial panel
            SETCLIPX - rexx exec for testing SETCLIP
                       Thanks to John Kalinich
            SETZSTRT - rexx called by SETCLIP when the SET command is used
                       - Updates the ZSTART ISPF Profile Variable
            SUPPORT  - Statement of Support

SetClip will perform two functions depending on how it is invoked.

Syntax:  %setclip option

Where option is:   blank     invokes the ISPF Dialog to define and setup
                             the user clipboards
                   non-blank to just setup the clipboards

When the option is blank an ISPF panel (setclipp) is displayed that
allows the user to define up to 10 (the IBM limit) Edit clipboards.

The panel requests both a clipboard name and the dataset, or dataset(member),
that contains the text that will be copied into the clipboard. If the start
and/or ending row numbers are not specified then all records will be copied
into the clipboard.

When ENTER is pressed the clipboard definitions will be saved and the user
clipboards will be updated or created.

The CANCEL command can be used to exit without saving updates.

PF3 exits the dialog and will create, or update, the clipboards if
changes have been made.

When the option is non-blank then the ISPF profile variables are read
and the clipboards created. This is to enable the ability to
automatically create the clipboards when ISPF Starts using the ZSTART
ISPF variable.  Use the SET command within this dialog to set, or update,
the ZSTART variable.

          To have the clipboards created every time ISPF
          starts update the ISPF Profile variable ZSTART to
          add:  tso %setclip x

Recommendation: Use the EDSET ISPF Edit command to verify that the CUT
operation defaults to REPLACE and PASTE defaults to KEEP.

Then exit ISPF and restart ISPF. Open ISPF Edit on a dataset and use the
CUT DISplay command to view the created clipboards.
```

## $USERDOC.txt
```
SETCLIP is an ISPF dialog that makes it easy for a user to create from
one to ten (the ISPF max) ISPF Edit Clipboards from existing datasets
for use during the ISPF session.

The dialog has two modes that are determined by how the command is
called.

Mode 1:  Define, or update, user clipboards

This mode is enabled when the SETCLIP command is invoked without any
parameters and will display an ISPF panel on which the user enters:

   - Clipboard Name
   - Dataset Name where the clipboard data resides
   - Optional Starting and/or Ending records to be copied into the
     clipboard

The row option is either B (Browse), E (Edit), or D (Delete).

The Clipboard name is a 1 to 8 character name that must follow the
standard PDS member naming convention.

The Dataset name is the dataset, or dataset member, where the data is
located to be copied into the clipboard.

The starting and ending record numbers are optional. If not specified
then all records are copied into the clipboard.

Usage note:  By using the starting and ending record numbers the user
can have one dataset with data for multiple clipboards in it.

When the clipboards are defined the ENTER key will create, or update,
the active clipboards. PF3 will update and then exit if changes have
been make, while CANCEL will exit without making any updates.

Mode 2: Create clipboards only

This mode is enabled when the SETCLIP command is invoked with any
non-blank parameter and will process the defined clipboard information
to create the clipboards.

This mode is designed to be used out of the ISPF ZSTART process that
runs when ISPF starts so that the clipboards are available for any
ISPF Edit session during the current ISPF session. Use the SET command
within this dialog for a simple way to create or update the ZSTART
variable.

```

