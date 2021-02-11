BACKDIR is a OMVS application, written in REXX, that will backup a
directory, with all files and subdirectories, to a target location.

It is intended to be run as a scheduled task via cron.

The processing parameters are defined in a parmfile that the application
reads.  This PDS contains the following members

   $DOC     Documentation for the Backup Process
   BACKDIR  REXX program to be installed into a USS directory
   BACKPARM Sample parm file to be installed into a USS directory

No warranty, guarantee, or promise is provided that this will work at
your installation. It does work where the author has it installed and
has been tested on z/OS 2.2.
