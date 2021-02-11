Sysplex Manager Version 1.0.0 (Beta)
===============

>>>  WARNING: This is a Beta version !!!     <<<
>>>  Do NOT use in a Production Sysplex !!!  <<<

Send comments, critics, suggestions, modifications to:

  marco.willemse@corner.ch

REXX:
-----
KSMMAIN - The main procedure
KSMCONS - To use the TSO REXX CONSOLE interface

Panels:
-------
KSMPRIM - The primary panel for Sysplex Manager
KSMTYPE - Couple dataset type input panel
KSMCDSN - Couple dataset name input panel
KSMPNAM - Policy name input panel
KSMPTYP - Policy type input panel
KSMSDKP - Structure duplexing keep input panel
KSMSSIZ - Structure size input panel

Skeletons:
----------
KSMDPOL - Policy Report Job
KSMNCDS - New Couple Dataset Job
KSMNPOL - New Policy Job

Tables:
-------
KSMKEYS - Keylist for the panels

Setup Instructions:
-------------------
Edit and Run the INSTALL exec

Put the REXX members in a SYSEXEC concatenated library.
Put the Panels members in a ISPPLIB concatenated library.
Put the Tables members in a ISPTLIB concatenated library.
Edit the REXX KSMMAIN, change skel_dsn="'SSY.SKELS'" to
   skel_dsn="<the datasetname where the Skeletons members are>"
Change the skeletons JOB card to reflect your installation standards

RACF (SAF) accesses needed:
---------------------------
TSOAUTH    CONSOLE           READ
OPERCMDS   MVS.SETXCF.** (G) CONTROL
Other accesses may be needed !


Short Help
----------

>>>  WARNING: This is a Beta version !!!     <<<
>>>  Do NOT use in a Production Sysplex !!!  <<<

Run the KSMMAIN exec (from the ISPF Command line: TSO KSMMAIN)
The following panel will appear

+---------------------------------------------------------------------+
I                             Sysplex Manager
I
I Type:   D   CDS Pol Cf Struc
I         -    -  -   -  -
I Action: L   List New Quit
I         -   -    -   -
I
+---------------------------------------------------------------------+

Using the Tab key and pressing the Send (Enter) key in the Type menu
you can choose the Sysplex Object Type you want to work with:
D - CDS   = Couple Datasets
P - Pol   = Policies
C - Cf    = Coupling Facilities
S - Struc = Structures

Using the Tab key and pressing the Send (Enter) key in the Action menu
you can choose the action you want to perform on the selected object
type:
L - List  = Show a list of the objects
N - New   = Create a new object (CoupleDS or Policy)
Q - Quit  = Quits the REXX exec

Tip: you can enter the underlined character to quickly select
a type or an action.

Pressing the Send (Enter) key another time will perform the selected
action. For example if you want to list the Structures you can
enter Type: S (Struc) and Action: L (List) and press a second time
the Send (Enter) key. The following panel will appear:

+---------------------------------------------------------------------+
I                             Sysplex Manager
I
I Type:   S   Struc CoNn
I         -   -       -
I Action: D   Display Alter RebuIld DupleX Unduplex Force List
I         -   -       -         -        - -        -     -
I Item:   1       More      Less
I         --      ----      ----
I         1   DB2S_GBP0            DUPLEXING REBUILD NEW
I         2   DB2S_GBP0            DUPLEXING REBUILD OLD
I         3   DB2S_GBP1            DUPLEXING REBUILD NEW
I         4   DB2S_GBP1            DUPLEXING REBUILD OLD
I         5   DB2S_GBP11           DUPLEXING REBUILD NEW
I         6   DB2S_GBP11           DUPLEXING REBUILD OLD
I         7   DB2S_GBP12           NOT ALLOCATED
I         8   DB2S_GBP13           NOT ALLOCATED
I         9   DB2S_GBP2            NOT ALLOCATED
I         10  DB2S_GBP3            NOT ALLOCATED
+---------------------------------------------------------------------+

A new menu (Item: ) will appear, followed by the list of the objects
selected.

Using the Return key and pressing the Send (Enter) key in the list of
objects you can select the object you want to work with.

As you can see also the Type and Action menus are changed.
Like before by changing Type and Action you can choose which action
to perform on the selected object.

For instance, in the Structures list, you could choose Type: N (CoNn)
and Action: L (List) to show a list of the Connections to that
Structure.

Note that if the list does not fit in the window the Point-and-Shoot
fields More and Less will appear next to the Item menu. Using the Tab
key you can move to More to go one Page Down and to Less to go one
Page Up. There is no PF Key equivalent (PF7 PF8 will not work).

Clearing the Type field character will reset the menu to the initial
status.

Reference:
----------
Actions:

A - Alter    = Alter the size of a structure
C - aCouple  = Add an Alternate CDS
D - Display  = Show the object details (D XCF)
F - Force    = Force a structure or a connection
I - Rebuild  = Rebuild a structure or a CF with LOCATION=OTHER
L - List     = List the objects
N - New      = Create a new object (CDS or Pol)
O - stOp     = Stop a policy
P - Populate = Perform a Rebuild with POPULATECF keyword
Q - Quit     = Quit the KSMMAIN Rexx Exec
R - Report   = Create a policy report
S - Start    = Start a policy
U - Unduplex = Stop Rebuild DUPLEX
W - PsWitch  = Use the Alternate CDS as Primary
X - DupleX   = Rebuild a structure with the DUPLEX keyword

Future plans:
-------------
- add support for xcf (PI,PO,TG,Cl)
- add support for system logger
- add pfkey for up and down
- provide an edit macro to cleanup policy reports
... and a lot of other ideas

(please help me if you know TSO/Rexx and ISPF !)
