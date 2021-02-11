*--$$README-----------------------------------------------------------*

   HOTRDR documentation:

   The HOTRDR routine was written to submit JCL members for batch
   processing to the internal reader from multiple PDS libaraies.
   I have use it as a started task to submit batch jobs during IPL time
   and through the daily workload processing by the operations staff.

   Mulitple symbolic PDS libaraies (LRECL=80) may be concatenated on
   the PDS DD statement.  PDS libraries with a large block sizes work
   best and reduce the I/O activity (BLKSIZE=27920).  I have 6 large
   PDS libraries concatenated in our HOTRDR procedure currently and
   have no idea what the limit would be, we are currently at z/OS V1.6

   The JCL member name to be submitted is passed to the HOTRDR routine
   through the PARM field.  The first occurance of the JCL member name
   found in the PDS concatenation is the member submitted.  To avoid
   multiple JCL member names in the concatenation list we use a member
   naming convention based on the task to be performed, the first 3
   characters of the member name, i.e. SYS for a systems task, BKU for
   a backup job, ADP for an application job, etc.

   The HOTRDR routine is written in IBM assembler (ASMA90) and uses
   the BSAM access method and macros FIND, READ, and CHECK.  See the
   source code comments for additional information on macro usage.

   The source library contains the following:

   $$README - this member.
   $CLEAR - a macro to clear fields to a specified fill character. If
            LONG is specified a MVCL instruction is generated.
   $EX    - a macro used to generate EX instructions on the fly.
   ASMARDR - the JCL procedure to assemble and link the HOTDRDR source.
   CONVERT - a macro to convert HEX fields to printable characters. I
            use this macro to print return and reason codes.
   ESAENTRY - a macro for conventional assembly routine entry and
            obtaining a save/work area.  Handy for rentrant code.
   ESAEXIT - a macro used in conjunction with the ESAENTRY macro to do
            save/work area clean-up and assembly routine exiting.
   HOTRDR - the assembly source code for the HOTRDR routine.
   PARMS  - a macro to handle the passing of parm fields.
   WTOL   - a macro to issue WTO messages with variable fields within
          the message.

   Note:  Some of these macros are old and have not been revised over
          the years I've used them.  Most of them are downward
          compatable with earlier version of OS/390 (MVS).

   Author:
   Peter McFarland
   ADP Tax & Financial Services
   San Diego, CA. 92127
   (858) 385-2718
   peter_mcfarland@adp.com

*--$$README-----------------------------------------------------------*
