
## $$$DOC.txt
```

Disclaimer:

         This software is in the public domain.  You are free to
         use it on an 'as is' basis.  Although the software
         performed to specifications when written, it is not
         guaranteed to work on your system, nor to continue to
         work on your system.  No warrantee or commitment of
         support is stated, intended or implied in supplying
         this software, and no liability of any kind is assumed
         by the supplier(s).

--------------------------------------------------------------------------------

This dataset contains a collection of TSO command processors and
macros created by Chuck Hoffman.  The following command
processors are contained in this dataset:

   BULLETIN - A command for putting up nicely formatted bulletin
              messages into the system broadcast dataset.  The
              command has the ability to add and drop bulletin
              messages on selected dates.


   DSNCHECK - A command to check for the existence of a cataloged
              dataset name, and, optionally, to check for the
              existence of a member within a PDS.  Sets &LASTCC
              for CLIST writers.

   FREEALL  - A completely new FREEALL, with lots of nice
              options, like the EXCEPT operand.  Uses SVC-99, and
              can be maintained by more junior systems
              programmers.  Compatible with J/TIP.

   INSTREAM - The INSTREAM command is used to create 80-byte
              control card images in a temporary file.  This
              command can be run under CLIST control, with
              symbolic substitution of variables allowed.
              INSTREAM uses VIO instead of datasets, and uses
              system generated names instead of cataloging.

   ISPFPROF - This is an alias of the PDF command processor (see
              description, below).  When using this alias, the
              profile dataset will be allocated, but the program
              will not enter ISPF/PDF.

   LIBCALL  - LIBCALL transfers control to modules with a 'CALL'
              type of parameter list, with a 'STEPLIB' option.
              LIBCALL also can accept program parameters in lower
              case.

   NEWSPACE - A command for easily creating new, moderately
              sized, datasets and libraries.  It was written with
              beginners in mind.  Can be executed from the
              ISPF/PDF command line (for allocating that dataset
              you suddenly need).

   PDF      - The PDF Command is used to preallocate the ISPF
              profile dataset, then bring the user into ISPF/PDF.
              PDF is a frontend which uses the ISRPCP entrypoint
              of ISPF/PDF, enabling the user to select optional
              panel numbers when invoking the product.

   SAFECOPY - This program is a copy command which enables
              several users to update the same dataset
              simultaneously, without conflicting with each other
              or with users who are reading the dataset.
              SAFECOPY is especially useful in CLISTs which write
              to a common dataset.

   SYSDSN   - A command to list the names of everyone who has a
              dataset allocated, or is waiting for allocation.
              Very useful after 'DATASET IN USE' and 'WAITING FOR
              DATASETS' messages.

   XPRINT   - A front-end command processor for a user-written
              hexidecimal listing utility program.  Allocates the
              input and output files, then executes the utility.
              Loads the utility if it is not already linked in.


Additionally, this PDS contains the following macros used by
several of the command processors:

   EQ$R     - Register equates.
   GTEDAALC - Executes dynamic allocation and DAIRFAIL.
   GTEDADAT - Creates SVC99/IKJEFF18 control blocks.
   GTEDADOC - Documentation for GTEDAxxx macros.
   GTEDASET - Links SVC99/IKJEFF18 control blocks together.
   LINKSAVE - Linkage conventions upon entry to a module.
   LINKBACK - Linkage conventions upon exit from a module.

For each command processor 'AAAAAAA', with alias 'BB' the
following pattern of names is in use:

   BBDOC    - Documentation for that command processor.
   BBJCL    - JCL for non-SMP install.
   #AAAAAAA - HELP entry for that command processor.
              (Last letter will be truncated for 8-byte names.)
   #BB      - Alias for HELP entry, used in non-SMP install.
   BBCPY    - IEBCOPY control cards used in non-SMP install.
   BBLNK    - LKED control cards used in non-SMP install.

```

