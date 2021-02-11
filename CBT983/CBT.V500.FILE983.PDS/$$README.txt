
       Mainframe Software Installation Customizer (MSIC)

This FreeWare Tool is a generalized and extensible ISPF Dialog
that aids in installing and customizing the type of FreeWare you
might develop and contribute to the CBTTape.Org respository.

- You build #1TASKS that the user should execute in the proper sequence.
- You build #2VARS for any variable replacement needed in members.
- You build #3EDIT to identify which members are eligible for variable
  replacement.
- You do the TRANSMIT on your PDS data sets and then copy the IDTF
  into your install PDS.
- You identify those members in #2VARS and MSIC can do the RECEIVE
  for the installer.

The basic tasks used to extract IDTF and replace variables are built into
MSIC. If you have a need for more than that then either provide a sample
JOB or build your own external routine.

