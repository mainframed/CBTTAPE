ISPF general table handler
--------------------------

Provided by Roy Gardiner    version 1.0 May 2002

Please e-mail comments and questions to roy at-sign roygardiner.com

Summary
-------

This package will enable you to maintain any ISPF table which has
one or two key fields. You only need to code, by copying the examples
given here, (1) a scrollable display for the whole table (2) a display
panel for full details of a single row.  The benefit of the package
is that it enables you to create in a few minutes a table update
utility using your own panels.

Basic features provided
-----------------------

Just by cloning the sample panels you will be able to:

  - see a scrollable display of your table
  - use the Locate command to find rows
  - sort the table display
  - display extra information which will not fit on a single display
      line
  - update the table (multiple users)
  - protect against concurrent update
  - edit any number of extension variables to any row, without
      knowing the names of the variables
  - provide simple data dictionary (along the lines of: this is a
      variable name, this is what it means)

(Note that this package does NOT handle non-keyed tables)

The benefit of using the package is development speed; all you need to
do is to modify the example panels to match your table layout - a few
minutes work.

The package is not designed to handle large volumes of data; for tables
larger than 1000 rows which need to be updated by more than about a
dozen people, consider DB2 or another proper database. Large tables
combined with many users create unacceptable performance and
especially update contention issues.

Demonstrations
--------------

Setting up the demonstrations
-----------------------------


1. Edit the member DEM#1. Change the assignments to the Rexx variables
   q1 q2 q3  so that the ALLOC which follows them points to the library
   you where RECEIVED the package and where you are now reading this
   Run it (you may need to copy it to a command library).

       TSO DEM#1      on an ISPF command line

   This will make available all the Rexx and ISPF comonents of the
   demonstration. Note that this need be run only once in an ISPF
   session, but once run you can then run the demos any number of times.
   The demos won't work in another session.

2. Run the exec DEM#2

   This will create the table FANDF (Friends AND Family) on this library
   The table will have just 2 rows.


Demonstration A: Basic features
---------------

   Run the exec DEM#3.

   This invokes the general table handler for the table you have just
   created.  Make sure you run in the same session in which you ran
   DEM#1, so that its LIBDEFs are in effect.

   You should now get a panel headed

            Friends and Family demonstration

   If not, you may need to re-run the DEM#1 exec to re-establish the
   library allocations.

   The command-line and prefix-aread commands available are documented
   separately in member #CMDS. Please try them; note that the SORT
   command will not work for this demo; please go to demonstration 2
   to show how it works.


Demonstration B: Basic + Column Sort
---------------

   To see slightly larger volumes and demo of the sorting feature,
   please run exec DEM#2A which will recreate the table then run
   exec DEM#4.  This exec also demonstrates the column sorting feature;
   you can type SORT FIRST to sort by first name, and so on

                      - - - - - - - - - -


   Now you've looked through the demonstrations, you should be able to
   make the utility work on one of your own tables. Don't forget, your
   table must have either one or two keys.  You can see how to invoke
   the utility by example in DEM#3 and see the full documentation for
   the interface in #INVOKE.

                      - - - - - - - - - -

Demonstration 3: Column sort + extension variables + data dictionary.
---------------

   The exec will also deal with tables where rows have any number of
   different extension variables; you don't have to know the names
   of any of the variables when defining the table.

   Now run the exec DEM#5.  The display will look similar to demo 2;
   the E and B prefix commands will give a new display. What you will
   see is a list of the variable names for the row, each one being
   followed by an N (for a named variable) or an X (for an extension
   variable). You can use In Rn to insert and repeat lines to create
   new extension variables, D to delete them. You can't repeat variable
   names and you can't create new Named variables, only new Extension
   variables.

   There are two rows for each variable; its name, type (N or X) and
   value, plus a second line giving an explanation of what the name
   means.  This utility implements an (optional) data dictionary
   feature, where every variable name can have a description linked
   with it.

   To see how this works, use I to insert an new line for a row, then
   add a variable name and a value. Your new variable name will not
   have any description associated with it;

                      - - - - - - - - - -

Demonstration 4: Maintaining a data dictionary
---------------

   A data dictionary for the Friends and Family demonstration is
   supplied. Run exec DEM#6 to see it. Note that you can update, ADD
   and DELETE data dictionary entries, and the Friends and Family
   demonstration will reflect those changes when next it's invoked.

   With Friends and Family and the Data Dictionary you now can see
   that (a) the look and feel of table updates are very similar and
   (b) you need very little customisation.


                      - - - - - - - - - -

   You can now customise the package by reading the #CUSTOM member

