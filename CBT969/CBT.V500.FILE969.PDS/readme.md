
## $$$DOC.txt
```
The PDSEGEN ISPF Dialog found in this package will present the user with
a list of all members of their PDSE, including all generations.  There
are many commands including Copy and Compare, and many line selection
options available, including Browse, Edit, View, Compare, Delete, J
(submit), Promote, Rename and Recover.  The list of members will be
updated appropriately as members are edited, added, deleted, recovered,
or promoted. This application will also work with non generation enabled
PDSE's and PDS's.

In addition the PDSEGBAK and PDSEGRST applications are packaged with
PDSEGEN - see the doc in @BACKUP

* -------------------------- REQUIREMENTS ------------------------------ *
*  This application requires z/OS 2.1 or newer to support access via     *
*  ISPF to generations and does NOT support load libraries or aliases    *
*  at this time.                                                         *
*                                                                        *
*  APAR OA43951 and OA43952 are pre-reqs as it adds the system           *
*  maximum generation limit to the data facilities area (DFA)            *
*  control block which is used by this application. This closed          *
*  in December 2013 so most shops should have this.                      *
* ---------------------------------------------------------------------- *

Installation of this dialog is documented in the $INSTALL member. It
does involve:

   - Copy the ISPF Panels into your ISPF Panel library
   - Copy the REXX Execs into your SYSEXEC library
   - Copy the LOAD modules into your ISPLLIB library
   - Optional assemble the source code provided
     - see member ASMJCL

For testing and validation purposes you can use the PDSEGENX exec which
will Altlib the exec library and Libdef the panels and load library and
then invoke PDSEGEN. PDSEGENX will accept an optional pdse-library as
the only parameter but if omitted then the user will be prompted for the
PDSE to work with.

MVS/QuickRef - if you have MVS/QuickRef installed then consider installing
member PDSEGQW into a MVS/QuickRef database (see QWLOAD for sample JCL).

USAGE.

Entry to the dialog is via the PDSEGEN exec. If called with no parameters
then a prompting panel is displayed.

    Syntax is:  %PDSEGEN dsname filter set

    Where dsname is the dataset name for a PDSE with generations.

    If dsname is * then a display of the last 15 referenced datasets
    will be presented to select from.

    If dsname is ? then the ISPF tutorial will be presented.

    The dsname may also contain a filter - 'sys1.parmlib(ieasys*)'

    Where filter is any valid filter.

       Filter are:  ABC*, ABC: ,ABC, ABC/, /ABC, or ABC
                    TODAY, WEEK, MONTH, YEAR, SINCE YY/MM/DD, SINCE -nn

       The date filters are toggles.

    Where SET is SET=x where x is B, E, V, or / to define the
    default select. This over-rides anything the user may have
    set in the entry panel or using the SET command and is
    saved in the ISPF profile.

PDSEGEN may also be entered on a DSLIST or ISPF 3.4 dataset list in
the command field with a / to indicate to use the dataset on that row
as the PDSE to work with.

To simplify entering PDSEGEN on DSLIST or 3.4 you can create this
simple exec that I call PG, but you can all it whatever is easy for you:

        /* rexx */
        arg options
        '%pdsegen' options

        *** This is provided in the EXEC PDS as member PG ***

Within the application there are commands available on the ISPF Command
line and Line selection commands for each member. See the ISPF Tutorial
for all commands and options available.

Command line options are:

       Backup                    to invoke the Backup dialog
       Browse                    to browse a member or members from the
                                 command line: B member or B *, or B A%
       C                         to change to a previous dsn using *
                                 to change to the copy target dsn using >
                                 to display a selection list of previous
                                 dsns using ?
                                 to jump directly to a dsn use #
       Compare member from to    to Compare the 2 generations
                                 e.g. Compare ABC -4 -1
                                 if no member specified then a
                                 prompting panel will popup
       Copy                      Copy from current PDSE to new or existing
                                 PDSE - will allocate new PDSE based
                                 on the current PDSE if create specified
                                 With Copy the space and maxgen can
                                 be changed.
       Edit member               to edit an existing or new member
                                 e.g. E abc or E *, or E A%
       Filter member-pattern     to Filter by member mask
                                 abc* for members starting with abc
                                 *abc for members ending with abc
                                 abc/ for members with abc anywhere
                                 Today for updated today
                                 Week for updated last 7 days
                                 Month for updated last 30 days
                                 Year for updated this year
                                 Since yy/mm/dd
                                 Since -nn
                                 OFF to turn off filtering
       Find string               to find a string in all members/gens
       HIGen                     Display the High Generation members
                                 - known as dummy members
       ID xxx                    Display members with xxx in userid
       Locate member or member*  to scroll to the member
                                 e.g. L abc
                                  or  L ab*
       MINE                      Display members with active userid
       MODel                     to allocate a new dataset based on the
                                 attributes of the current dataset
                                 - after Model the Change > command may
                                   be used to change to the newly created
                                   dataset
       Options                   Display a Primary Command prompting panel
       Output                    to create a report of the active member list
       Prune                     to delete obsolete generations
       Refresh <filter>          to rebuild the member list
                                 with optional filter
       Restore                   to invoke the Restore dialog
       Set                       popup to change the line selection S
                                 action (B, E, V)
       SetMacro (SM)             Set an Initial Edit Macro by dataet suffix
       Sort                      Sort by Name, Creation, Changed, or User
                                 - point/shoot for these column headers
                                 Sort Field-name Order where order is A or D
       Submit                    Submit a member, member generation or *
                                 e.g. SUB ABC, or SUB *, or SUB A%C
       Validate                  Validate the PDSE using IEBPDSE
                                 - if clean is enabled in PDSEGENS then the
                                   validate will also force a clean for all
                                   pending deletes.
       View                      To View a member, or members, from the
                                 command line:  V member or V * or V A%
       Quit and Exit             Commands to end the dialog (F3 always works)

Line selection options are (short and long forms):

       A to change attributes (ver/mod/userid)
         - Attrib
       B to browse the member
         - Browse
    ** C or COPy to copy a member to a different dataset
         - May only be used on base members but all generations
           for the selected member will also be copied
       D to delete the member, or a generation
        - Delete
    *  E to edit the member
         - Edit
    ** G Recover a generation to a new member based on the
         name provided via a prompting popup panel
         - RECover
       H hide the member/generation from the table
         to exclude the member/generation from command line
         B *, E *, V *
         - Hide
       I display ISPF statistics for the member or generation
         - Info
       J to submit the member (JCL) to the internal reader
         - Submit
       K to clone a member (generation 0 only)
         - no generations are cloned
         - Klone or Clone
       M to eMail the member (using XMITIP)
         - Mail
       O to display the tutorial for options
    ** P Promote a generation to generation 0
         Copies a non-0 generation into generation 0
         and leaves the user in Edit.  If you save then
         generation 0 is replaced.
         - Promote
     * Q to Rename and swap the member and all generations
         - RENSwap
     * R to Rename a member and all generations
         - REName
       S to use the default option as defined on the entry panel
         - default is B
         - Select
       U to invoke a user command on the dataset(member)
         - including generations
         - User
       V to view the member
         - View
       X to eXecute the member (REXX or CLIST)
         - EXecute
   **  Z to compare the base (gen 0) non-0 generation
         - COMpare
       / to display the tutorial for options

       Placing the cursor on the row and hitting ENTER will also
       select the row.

    * - ONLY allowed for generation 0 members
   ** - ONLY work with non-0 generation members

Notes:
   - All line selection options can be used in block form - BB/BB or B99
   - Expanded commands may also be blocked by doubling the 1st character,
     e.g. KKlone, but expanded commands may not have a count
   - When using the expanded selection panel then any TSO command, clist,
     or exec can be used along with any valid line selections. The User
     command dialog will be presented to allow the user to enter other
     parameters.

Why use, or consider, PDSEGEN:

   1. To see the generations easily
   2. To be able to compare current generation to prior generations to
      see what changed (broke)
   3. To easily recover a prior generation using recover to a new member
      or promote to replace the current base member
   4. To easily clean up obsolete, no longer needed, generations (prune)
   5. To safely copy the base member and all generations
   6. To easily backup and restore without loss of generations
   7. Protection from accidentally editing a non-0 generation
   8. Easily search members and generations
   9. Easy access to up to 15 datasets
   10. Info on which generation is being browsed/edited/viewed
   11. All the above and more

Customization options are all found in the PDSEGENS exec:

   1. Change the mail variable to 1 to enable e-mailing the selected
      member or 0 to disable the e-mail option.
   2. Enable or disable the elapsed time display after building the
      member list - change etime variable to 0 to disable and 1 to
      enable it.
   3. Enable or disable processing of dummy members by changing the
      higen variable. 0 = off and 1 = on.
   4. Added base_color and sort_color for the columns that can be sorted
      to allow changing those colors if desired. Default is blue for
      unsorted and turq for sorted.
   5. Enable or disable the IEBPDSE Clean option
      - Requires IBM Apar OA47755 or OA50214 for this support
   6. Update the help panels that document sample JCL for batch Backup
      and Copy to conform to your installation standards and datasets,
      PDSEGHBJ for Backup and PDSEGHC for Copy.
   7. If your installation has a Edit Line Command Table defined in your
      ISPF configuration *AND* it isn't in the ISPF Table dataset
      defined in the sample batch JCL for Backup and Copy then those
      samples need to be updated to concatenate that dataset.

Notes:

1.  Browse works as you would expect it to

2.  Using Edit or View you can use all normal edit commands,
    including edit macros. However commands that reference other
    members can only reference the base, or generation 0, member.

3.  Multiple members may be selected for Browse or View but Edit
    will only work if the member IS NOT saved or updated.  If a
    member is saved or updated then all rows for that member are
    deleted and re-added to include the updated generation info.

4.  It shouldn't have to be stated but generations are only
    supported for PDSE Version 2 datasets where generations have
    been enabled.

5.  Edit will be converted to View for non-0 generation members.

6.  The Compare command only accepts relative generation numbers.

7.  The Compare line option will compare the base member to the
    selected generation.

8.  It is possible to allow Edit to edit a generation BUT when that
    happens only the generation is updated and the base member is
    NOT updated. Thus the generation with the update could be lost
    and/or hidden since it is not possible to access a generation
    using dynamic allocation or JCL.

    This application has been configured to prevent editing non-0
    generations.

9.  The ISPF Edit compare command has been extended using an edit
    macro. The new capabilities include the ability while in Edit to
    compare to another generation of that member (e.g. compare -2)
    or to compare to another member generation (e.g. compare xx -3).
    When in view it is possible to compare to the base (e.g. compare 0)
    or to another member or generation (e.g. compare xxx -1). If the
    compare options do not include a generation then the normal ISPF
    compare will be invoked.

10. The e-mail option utilizes XMITIP using the XMITIPFE (front end)
    exec. This option is only available if the mail variable is
    customized to 1.

11. Aliases are NOT supported by the PDSEGENI Rexx Function so this
    application does not support aliases (at this time)

12. Rename will rename the base member and all generations by doing a
    copy of the generations so they are retained.

13. Find can be faster if Filter is used prior to the find

14. Prune operates on only the members in the display list so
    using Filter before Prune is a good way to limit the members
    that Prune will clean up.

15. Before using Prune a Backup is recommended (CYA).

16. PDSEGEN supports extended statistics. If a member has more than 64K
    (65535) records then the only way to display the actual record count
    is to turn on extended statistics using the ISPF Edit command STATS
    EXT.

17. When Hide is active, Delete, Prune, and Rename are not available.

18. The Member list display defaults to a 2 digit year display. Using the
    Left or Right keys (F10 or F11) will shift to use the 4 digit year
    display by removing the Initial size field from the table. This view
    is remembered across sessions.

19. If you see a member with a -1 generation and there is no 0 generation
    that indicates that the member was deleted outside of PDSEGEN. The
    normal ISPF member delete will delete the base member but leave the
    generations and the base member will become the -1 generation.

Acknowledgements:  Thanks are due to Thomas Reed of IBM who presented at
                   the 2015 SHARE in Seattle on PDSE V2 Member
                   Generations and provided sample code for finding the
                   generations which I've used as a starting place for
                   my dialog.

                   Thanks also to the following for testing, commenting,
                   trouble shooting, and making suggestions to improve
                   this tool:

                   * Bill Smith        * Sam Golob
                   * Bruce Koss        * Tom Conley
                   * John Kalinich     * Greg Price
                   * Salvador Carrasco

Members of this PDS are:

    $CHANGES - summary of changes
    $$$DOC   - what you are reading
    $INSTALL - Short installation instructions
    $MODULES - Info on the source/load modules
    $RECV    - TSO Command to RECEIVE EXEC and PANELS into
               usable datasets
             - Updates PDSEGENX in the exec library with the
               dataset names of the restored datasets
             - Updates the ASMJCL member of this PDS with the
               dataset name of the restored source and load
               libraries
    @BACKUP  - Doc on using PDSEGBAK to backup/restore a PDSE V2
    @CLS     - Assembler source for a TSO clear screen command
    ASM      - Assembler source for the PDSEGENI code
    ASMJCL   - JCL to assemble and link PDSEGENI, PDSEGDEL and
               PDSEGMAT if you want to reassemble for any reason
    CLS      - Object Deck of the CLS assembler module to
               clear the screen during the $RECV process
    EXEC     - TSO Transmit of the REXX Library
    FIXPDSEG - edit macro used by $RECV to update key members
               during the receive process
    LICENSE  - the GPL V3 License
    LOAD     - Load module of PDSEGENI (put into ISPLLIB or STEPLIB)
    PANELS   - TSO Transmit of the ISPF Panel Library
    SAMPBR   - sample JCL to run PDSEGBAK in batch
    SAMPCOPY - sample JCL to run PDSEGENC in batch
    SAMPLE   - TSO transmit of sample PDSEGEN backup will be
               restored to PDS by $RECV and can then be processed by
               PDSEGEN RESTORE command to recreate a PDSE with
               members and generations
    SUPPORT  - information about the lack of official support or
               warranty.
    WISHLIST - Enhancement requests that are queued (maybe)

Disclaimer: This software is provide for your use without any warranty or
recourse should it not perform or cause problems. The author and others
who have contributed are not responsible for issues that arise, nor are
their employers. Use this software at your own risk. Test and test again
before using in any productive capacity.

Restrictions of PDSE V2 Generations:

1. The MAXGENS option defines the number of generations plus 1 for the
   base or generation 0 member.  Thus a MAXGENS of 10 yields 11 members.
2. You can delete an individual generation and that will leave a gap
   in the generations. This will result in this application stopping its
   member search at the 1st gap.
   * this option is not available with this application
3. Use of TSO DELETE will delete the base member BUT will NOT Delete
   any generations. The ISPF LMMDEL service will delete the base
   member and ALL generations. This application uses the LMMDEL
   service.
   - If you delete a member and all generations and then create a new
     member with the same name. All generations for the new member
     will start with the previous members generation next high
     generation number.
   - Some ISPF applications do not use LMMDEL to delete members but
     use the equivalent of the TSO DELETE, with the same results.
4. The use of ISPF copy services, including 3.3, will NOT copy any
   generations. Nor will IEBCOPY. The only tool to copy generations
   is DFDSS (a full dataset dump/restore/copy). This application does
   not support copying at this time.
5. If you Edit a generation other than 0 and save it then no new generation
   is generated. That only happens when editing generation 0.
6. You CANNOT access any generations using JCL or dynamic allocation.
7. You can force a new generation, when editing generation 0, by using
   the Edit command SAVE NEWGEN.
8. You can prevent the creation of a new generation by using the Edit
   command SAVE NOGEN
9. To find what PDSEGBAK member maps to what real name use Edit (or View)
   on the backup member and use the ISPF Edit command GNAME
10. See the Tutorial option U for a list of vendor products that have no
    or partial support for member generations

See Thomas Reed's SHARE Presentation at:
    https://share.confex.com/share/124/webprogram/Session16957.html
```

## $UNDOC.txt
```
There are some undocumented primary and line commands:

Primary Commands:

ACHmed - used to allow the display in the member list of dummy members
       - the absolute generation for these dummy members is the high
         water mark of absolute generations for that member and where
         the generation count will resume if/when the member is
         recreated.
       - Entering Achmed ? will bring up a short tutorial about Achmed
       - Aliases are Casper and Zombie

Line Commands:

W      - Allows editing generations directly as PDSEGEN
         automatically converts an Edit to View
```

