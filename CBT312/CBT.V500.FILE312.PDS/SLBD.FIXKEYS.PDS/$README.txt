This package will allow the user to change the ISPF Key defaults
for up to 8 PFKeys across ALL ISPF Profiles (except ISPSPROF which
is reserved).

Syntax:  TSO %FIXKEYS

Both the FIXKEYS and FIXKEYST exec's need to be in the users SYSPROC
or SYSEXEC library.

The dialog will:

1. Prompt the user for up to 8 PF Keys to change
2. Make a backup of the users ISPF Profile data set
3. Change the PF Keys for all Profiles found in the users
   ISPF Profile data set
4. In support of SDSF, which just likes to be different,
   RETRIEVE will be changed to CRETRIEV and RFIND will be
   changed to IFIND.

Copyleft (c) 2019
