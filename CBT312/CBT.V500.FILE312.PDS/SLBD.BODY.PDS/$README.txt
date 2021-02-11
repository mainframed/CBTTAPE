BODY is an ISPF Edit macro (aka command) that will read the ISPF Panel
while in edit and report back via notelines a suggested )BODY statement
with the WINDOW keyword showing the width and depth of the panel.

This information can be used if the panel is going to be used as a POPUP
panel or just to determine if the panel is too wide or too deep for the
ISPF user. For example if a panel is 35 lines deep and the user has a
3270 Mod 2 display, which is 24 lines deep by 80 characters wide, then
the user will never see the bottom of the panel.

BODY will also recommended the Row and Column parameters for an ADDPOP
command if the panel is a POPUP panel.

Installation: Copy the BODY member of this PDS into a library in your
SYSPROC or SYSEXEC allocations.

Usage:  While in ISPF Edit on an ISPF panel enter BODY in the Edit
Command line.

