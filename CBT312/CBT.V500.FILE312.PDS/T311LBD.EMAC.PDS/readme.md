
## $DOC.txt
```
EMAC is an ISPF Edit macro that will present the ISPF Edit user with a
list of available Edit Macros in an ISPF Table. The user can then select
(S) a macro to execute or display the help (H) information for the
macro.

Members in this dataset:

     $DOC    - what you are reading
     $USERDOC- short doc for your users
     $RECV   - execute this to do a TSO RECEIVE on the EXEC member
     EXEC    - TSO Transmit format of the distribution EXEC library
             - EMAC  - the ISPF Edit macro
                       ** Customize the reference to the
                       ** EMACD control file
             - EMACD - the control file with information on the
                       ISPF Edit macros you plan to make available
                       to your users.  Edit/tailor using info included
                       in the sample data provided.

Site customization:

The EMACD sample must be used as a model and placed into a sequential
dataset, or a PDS member, and then the EMAC Exec updated (find *custom*)
to point to it.

Note:

That EMAC includes 5 ISPF panels that are imbedded within the EMAC code
and dynamically loaded as needed when executed.

```

## $USERDOC.txt
```
Short documentation on EMAC

An ISPF Edit macro (command) that will:

Reads a control file which is a sequential file, or pds member, which
can be FB or VB and contains the information about all supported ISPF
Edit macros. These are added to a temporary ISPF Table which is then
displayed to the user.

A new ISPF Edit macro (command) has been implemented at the AITC called
EMAC.  EMAC is used under ISPF Edit (or View) by entering EMAC on the
Command line.

A ISPF table will then be presented from which the user may search for,
and select, a command to be executed on the active Edit data.

There are several commands that may be used when viewing the table:

   Find xxx     Find the string xxx in the macro name or description
                and position that as the top row in the table.
                Repeat find is supported.

   Locate xxx   Positions the table on the first macro name that is
                a full, or partial, match to xxx.

   Only xxx     Removes all rows with commands and/or macro names that
                do not contain the string xxx.

   Refresh      Used to rebuild the table after Only use.

   macro-name   If the macro name is entered, if found, then it
                will be selected and executed.

If entered outside of ISPF Edit, or View, then the list of edit macros
will be presented to the user with the Select option disabled.

The user may enter S to select an edit macro and it will be invoked at
that point. The ISPF table is closed before calling the user selected
macro and upon that macro's completion the user is back in ISPF Edit.
When a macro is selected a ISPF popup panel will be presented to let
the user enter any parameters for the macro.

   The popup panel allows the user to enter any optional or required
   parameters for the selected macro. The entry field is a scrollable
   field that allows up to 1,023 characters. Scrolling is by using the
   PF Keys for Right and Left or by using the ZEXPand command (or
   PF Key).

The user may enter H to display a ISPF tutorial panel that is documented
in the control file. If there is no tutorial panel then a generic panel
indicating no tutorial panel is available is displayed.

Any row selection(s) or cursor placements will be passed to the selected
macro when it is executed.

See the ISPF Tutorial for all available commands.

If EMAC is called outside of ISPF Edit or View then a popup panel
will be displayed informing the user that EMAC is only to be used
within ISPF Edit or View.

Warranty - none. No person or organization associated with developing,
deploying, posting, sharing, or any other involvement may be held liable
in any way, shape, or form for misuse, abuse, or issues resulting from
the use of this tool. Test this before deploying to anyone.

This code has been tested on z/OS 2.1 and z/OS 2.2 and works reasonably
well.
```

