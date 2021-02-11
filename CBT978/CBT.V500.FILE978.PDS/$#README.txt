
       Genuine Every Noteworthy Itemized Examplizer (GENIE)

This FreeWare Tool is an ISPF Edit macro that mimics the MODEL
command, while being robustly extensible in the number of WISH items
GENIE can grant.

The author has a large list of manuals to be turned into WISH items. Feel
free to contact Kenneth Tomiak if you want to help build WISH members or
have your own TOPIC you would like to have included.


$$README:
========================================================================
This collection is best used by placing the two REXX programs
in your //SYSEXEC concatenation.

GENIE can be made available to all types of developers. However, the breadth of
content may overwhelm all but the System Programmer this was written for. For
that reason you might want to create tailored WISHLIST data sets for different
roles (SYSPROG, PGMR, SCHEDOPS). You would create more than one WISHLIST data
set if you are keen on limiting what the user has access to. There are sample
statements in the GENIE code on how to use more than one WISH data set assigned
by your logic.

GENIEBLD is meant solely for the administrator (System Programmer)
that manages the WISHLIST data set. It must be run against a WISHLIST data set
that has been updated.


INSTALLATION
========================================================================
This FreeWare Tool is installed by executing the $INSTALL REXX program. You will
be shown a list of tasks, some optional, that are to be executed in sequence.
The result will be one WISHLIST data set holding all of the topics you selected
for inclusion. You can redrive the installation process and choose alternate
WISHLIST data sets if you are providing tailored topics for different roles.


CONFIGURATION
========================================================================
Anytime you modify the WISHLIST data set you will need to rebuild
the $$$$0501 member by running GENIEBLD. I prefer using ISPF
3.4 to pull up a list of WISHLIST data sets and then using line command
%GENIEBLD /
to run the REXX code on the data set. It validates the syntax,
not the content, of WISH members and either displays an error
report or overlays the existing $$$$0501 member.


USAGE
========================================================================
While in EDIT or VIEW you can invoke the GENIE EDIT macro using the command
field.

Syntax:

  %genie {wish} | {?}

  The percent sign is used to speed up searching //SYSPROC
  and //SYSEXEC, ignoring load modules from system libraries.

  Optional {wish} asks for a known item. If it is not found then
  the normal panel display of topics will be presented.

  Optional {?} asks to see the GENIE primary commands help
  prompt at startup.

  Expand any TOPIC to see CHAPTERS and expand CHAPTERS to see ITEMS.


EXTENSIBILITY
========================================================================
Carefully choose a TOPIC prefix and add your own WISH members.
See GENIE TOPIC $$$$ Chapter 4 for more details.

Use an existing WISH member as a template.
Pay attention to how column one is used.
Create your TOPIC, CHAPTER(s), and WISH(es).
Execute GENIEBLD to update the $$$$0501 member.

