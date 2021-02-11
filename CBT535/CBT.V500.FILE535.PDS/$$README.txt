
This is my contribution, a program as text in zip file.  The zip
consist of:

DERCCT.ASM   -  program source code (text) in assembly
ASSEMBLE.JCL -  JCL procedure for assembling and linkediting
JCCAT.JCL    -  JCL to generate CCAT command processor (TSO) from
                DERCCT.ASM

CCAT command is a TSO command processor to do:
(1)  Allocate a file (DD) from a dataset
(2)  Concatenate a dataset to an existing file (DD)
(3)  Display datasets list (concatenation) of a file (DD)
(4)  Move a dataset to the top of concatenation
(5)  Deconcatenate a dataset from a file (DD)
(6)  Deallocate a file (DD) of a single dataset

Hope can help someone.

With regards,
Deru Sudibyo
OS/390 Tech Consultant
