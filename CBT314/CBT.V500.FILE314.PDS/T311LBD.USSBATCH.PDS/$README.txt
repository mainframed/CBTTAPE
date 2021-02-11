USSBATCH is a REXX utility that is designed to be executed using the
batch TSO Monitor Program (TMP), typically IKJEFT01. It is a simple
replacement for BPXBATCH with additional capabilities.

See member JCL for a sample of how to use the utility.

All OMVS commands are entered after the STDIN DD statement using the
following rules:

1. Multiple commands may be on the same record separated by a ;
2. su will change the effective uid
3. directory references should be fully qualified
4. cd (change directory) works but is reset to the users home directory
    with each command (including stacked commands)
5. comments start with * or # in column 1
6. Do *NOT* enable ISPF Edit sequence numbers
7. Add a + to the end of a record to continue the command to the next
    record
