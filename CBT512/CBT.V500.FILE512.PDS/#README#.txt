

Yet Another "CUT" and "PASTE" Implementation.
---------------------------------------------


Author:

   Luc Van Rompaey, Telepolis Antwerpen, Belgium.
   e-mail: luc.vanrompaey@telepolis.antwerpen.be


Date:
   February 2001.


Inspiration:

   This code is based on similar developments by Stan Adriaensen,  who
   is a former colleague of mine at AXA Bank Belgium, and on code that
   I downloaded from the  "Mark's MVS Utilities"  page on the internet
   (and that was originally taken from  file  182  of  the  CBT  tape,
   according to the description).
   I wrote it after I took  a  new  job,  which gets me back into  the
   mainframe world  (after some eight or nine years of exposure to the
   PC and LAN world).  I considered it a nice way to get re-acquainted
   with the mainframe.


Installation:

   o  Copy the following members to your CLIST or REXX library:
         CUT
         PASTE

   o  Copy the following members to your ISPF MESSAGE library:
         CUT00

   o  Copy the following members to your ISPF PANEL library:
         CUTDFNEW
         CUTDFPRM
         CUTHELP
         CUTHELP0
         CUTHLPC
         CUTHLPCD
         CUTHLPCH
         CUTHLPC0
         CUTHLPC1
         CUTHLPC2
         CUTHLPC3
         CUTHLPC4
         CUTHLPC5
         CUTHLPD
         CUTHLPD0
         CUTHLPD1
         CUTHLPD2
         CUTHLPD3
         CUTHLPD4
         CUTHLPP
         CUTHLPPD
         CUTHLPPH
         CUTHLPP0
         CUTHLPP1
         CUTHLPP2
         CUTHLPP3
         CUTHLPP4
         CUTPRMPT
         CUTPRPST

   o  That's it|


Usage Information:

   CUT and PASTE are ISPF Edit Macros,  and can be used only while you
   are editing a dataset.
   The first time that you use either the CUT  or  PASTE command,  you
   will be prompted for the default argument values  that you want  to
   use with the commands.  You may issue the  HELP  command  for  more
   information.

   Basically, the CUT command will transfer a range of lines from your
   current dataset into a temporary ISPF table.  It will either APPEND
   the lines to the ISPF table,  or REPLACE the table  (throwing  away
   any data that the table contained prior to your CUT command).
   To specify the range of lines that must be transferred, you use the
   familiar  "copy"  (C, CC, Cnnnnn)  or "move"  (M, MM, Mnnnnn)  line
   commands.

   The PASTE command will transfer the contents of  a  temporary  ISPF
   table into your current edit dataset.  It  will  either  CLEAR  the
   table once the data is transferred,  or KEEP the  contents  of  the
   table for further PASTE (or CUT APPEND) commands.
   To specify the location where the data must be  inserted,  you  use
   the familiar "after" (A) or "before" (B) line commands.

   The CUT PROMPT command will execute the CUT command, but prompt you
   for the argument  values  first;  the  PASTE PROMPT  command  works
   similarly for a PASTE operation.

   CUT DEFAULTS  or  PASTE DEFAULTS  will  allow you  to  review  your
   defaults argument settings for the commands.

   CUT HELP  or  PASTE HELP  will display  the  help  panels  for  the
   commands, under the control of the ISPF TUTORIAL program.

   The CUT or PASTE action argument  (APPEND,  REPLACE,  CLEAR,  KEEP,
   DEFAULTS or HELP) may be abbreviated to one character.
   So,  for  example,  "CUT A"  is  equivalent  to  "CUT APPEND",  and
   "PASTE D" is equivalent to "PASTE DEFAULTS".

   CUT and PASTE can manage  multiple  tables  (multiple  clipboards);
   each table is identified by a  "table name"  that consists  of  two
   alphanumeric character positions.
   Special cases:  table names  "00" through "09" may  be  abbreviated
   to "0" through "9" at all times.

   The CUT command imposes a line limit on the tables, to prevent them
   from growing indefinitely;  you may set the line limit to any value
   from 100 through 9999.

   The CUT and PASTE commands will honour the current BOUNDS settings;
   CUT will only transfer the columns that are within the bounds,  and
   PASTE will insert its data into the columns within the bounds.


