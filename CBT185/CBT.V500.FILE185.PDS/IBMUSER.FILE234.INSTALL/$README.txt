This is a new disassembler that can be used to disassemble load modules
in PDSE's as well as those in traditional PDS's. It also can disassemble
the more recent instructions that have been added to the IBM mainframe
instruction set since my earlier disassembler that was written in 1977
and is now in file 217 of the CBT tape, I believe.

I did not include DSECT statements in this version partly because I have
not found them very useful, and partly due to time pressure, as I plan
to retire June 30, 2002.

Installation and use notes:
1. This PDS contains the source code and JCL needed to install and test
   the RESOURCE/REBUILD/READLMOD disassembler.
2. Details of coding for the control statements are given in comment
   statements at the beginning of the RESOURCE program.
3. Once this PDS is in place, installation is as follows:
   A. Create a load lobrary (PDS or PDSE) to contain the load modules.
      Edit all the ASMLKED members and change the SYSLMOD DD state-
      ments to point to this library. Also change the STEPLIB DD
      statements in the EXECJCL members to point to it.
   B. Change the JCL JOB statements for your installation as needed
      in all the ASMLKED and EXECJCL members.
   C. Execute ASMLKED1 to assemble and linkedit the READLMOD subroutine
      into your load library. This subroutine is used to access the
      load module being disassembled. It uses the IEWBIND and IEWBUFF
      macros, which provide a much cleaner approach to load module
      handling. This load module will be statically linked into the
      RESOURCE program load module in the next step.
   D. Execute ASMLKED2 to assemble and linkedit the RESOURCE program
      into your load library. As written, this job expects the READLMOD
      subroutine's load module to be in your load library. RESOURCE is
      the initialization program for the disassembler. It processes
      its EXEC statement PARM field, the control statements in the
      SYSIN file, and accesses the load module to be disassembled from
      the SYSLIB file. When initialization is complete, the REBUILD
      program is LOADed and called dynamically to complete the
      disassembly and produce the output. Because of this, the load
      modules for RESOURCE and REBUILD must both live in the same
      load library at execution time.
   E. Execute ASMLKED3 to assemble and linkedit the REBUILD program
      into your load library. It must be in the same library with
      the RESOURCE program at execution time, as it is dynamically
      LOADed and executed by RESOURCE.
   F. Execute ASMLKED4 to create the load module for the RESCHECK
      program. This program is used to check the result of a
      disassembly, if desired.
   G. Execute ASMLKED5 to create the DISTEST load module in your load
      library. This is a test program that contains a variety of
      instructions, including floating point and privileged instructions
      so that all features can be seen.
   H. Execute EXECJCL6 to disassemble the DISTEST load module created in
      the step above. Check this JCL before use to insure correct
      usage for your shop. The SYSPRINT from this run will show the
      control statements. The disassembled source code is written to
      a DSORG=PS,RECFM=FB,LRECL=80 dataset. Each statement contains
      a comment field that shows the CSECT offset and original text
      at the right. If disassembly was correct, when this source
      program is assembled, the result should be identical to the
      original.
   I. Execute ASMLKED7 to assemble the disassembled output from the
      RESOURCE program. Input to this program is the disassembled
      output from RESOURCE. Note that the SYSPRINT output from the
      assembly step is written to a DSORG=PS,RECFM=FB,LRECL=121
      dataset that will be read into the RESCHECK program below.
   J. Execute EXECJCL8 to test the disassembly using the RESCHECK
      program. This program reads the SYSPRINT from the assembly above
      and compares the offsets and text given by the assembler to
      the offset and text included in the source statements by the
      REBUILD program. This should result in a single line of
      output stating that the "Comparison found no differences."
