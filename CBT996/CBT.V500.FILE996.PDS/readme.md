
## @FILE996.txt
```
//***FILE 996 is from Larry K. Slaten and contains several packages *   FILE 996
//*           of useful programs.  A fuller description is in the   *   FILE 996
//*           $INST member, which we will paraphrase below.         *   FILE 996
//*                                                                 *   FILE 996
//*           email:  larry.k.slaten@gmail.com                      *   FILE 996
//*                                                                 *   FILE 996
//*    The following members contain user documents (in MS Word     *   FILE 996
//*    fprmat) for the load library scanner, the REXX Toolkit,      *   FILE 996
//*    and the String handling package.                             *   FILE 996
//*                                                                 *   FILE 996
//*    @LIBSCAN - Document describing the load library scanner      *   FILE 996
//*    @REXTOOL - Document describing the REXX Toolkit              *   FILE 996
//*    @STRING  - Document describing the String Handling Package   *   FILE 996
//*                                                                 *   FILE 996
//*    (These members must be downloaded to a PC in BINARY and      *   FILE 996
//*    looked at, either with MS Word, or Open Office.)             *   FILE 996
//*                                                                 *   FILE 996
//*    The IEBUPDT1 member is set up to install everything.         *   FILE 996
//*                                                                 *   FILE 996
//*    The load library scanner is one assembler program            *   FILE 996
//*    (SSLEANAL) and can be found in the bundled member ASUASM,    *   FILE 996
//*    common assembly JCL (ASMBCL) can be found in the bundled     *   FILE 996
//*    member ASUCNTL.  First compile COBOL program ASUP2DSB        *   FILE 996
//*    with JCL (COBBCL).  This program is used in the assembly     *   FILE 996
//*    JCL to create the NAME Binder statement.                     *   FILE 996
//*                                                                 *   FILE 996
//*    The Rexx Toolkit can be found in the bundled member EXEC.    *   FILE 996
//*                                                                 *   FILE 996
//*    The String handling package along with a number of other     *   FILE 996
//*    utilities can be found in the bundled members ASUASM and     *   FILE 996
//*    ASUCOB.  The member ASUASM contains the assembler            *   FILE 996
//*    programs, macros, and copybooks.  There are numerous         *   FILE 996
//*    macros like label trace, numeric test, dope vector, table    *   FILE 996
//*    index calculator, register 14 stack, a couple versions of    *   FILE 996
//*    binary search, fibonaccian search, linear search, heap       *   FILE 996
//*    sort, some data conversion routines from Dr. John Ehrmam's   *   FILE 996
//*    book, and his bit handling "Micro-Compiler".  The member     *   FILE 996
//*    ASUCOB contains the COBOL programs and copybooks.            *   FILE 996
//*                                                                 *   FILE 996
//*    Member IEBUPDT1 can be used to un-bundle all of the          *   FILE 996
//*    bundled members (ASUASM, ASUCNTL, ASUCOB, EXEC, MODEL,       *   FILE 996
//*    REXXBJCL, and REXXBLIB) into separate source libraries.      *   FILE 996
//*    You can use the utility IEBUPDTE or PDSLOAD.                 *   FILE 996
//*                                                                 *   FILE 996
//*    Once you have created the separate source libraries you can  *   FILE 996
//*    view the $DIRSTR member(s) to determine assembly/compile     *   FILE 996
//*    JCL and IVP JCL.  Member @STRSVC names the programs          *   FILE 996
//*    associated with the String package.  Member @ASUMSG list     *   FILE 996
//*    all of the LE messages that can be issued by the String      *   FILE 996
//*    package, and the values of the variables.                    *   FILE 996
//*                                                                 *   FILE 996
//*    First compile COBOL program ASUP2DSB with JCL (COBBCL).      *   FILE 996
//*    This program is used in the assembly JCL to create the       *   FILE 996
//*    NAME Binder statement.                                       *   FILE 996
//*                                                                 *   FILE 996
//*    You have a few choices when installing the String package.   *   FILE 996
//*    As separate load modules and/or one single load module.      *   FILE 996
//*    Use JCL (ASMSTR) to create separate load modules for each    *   FILE 996
//*    service.  Use JCL (ASMPKG) to create a single load module    *   FILE 996
//*    for all services.                                            *   FILE 996
//*                                                                 *   FILE 996
//*    The $DIRSTR member(s) provide the program names, assembly/   *   FILE 996
//*    compile JCL to use and the IVP JCL to test the programs.     *   FILE 996
//*    The IVP programs should provide the necessary reference      *   FILE 996
//*    material on how to call and/or run everything provided.      *   FILE 996
//*                                                                 *   FILE 996
//*    The bundled member MODEL contains the IDCAMS control card    *   FILE 996
//*    models for the batch Rexx exec (BLDIDC).                     *   FILE 996
//*                                                                 *   FILE 996
//*    The bundled member REXXBJCL contains the JCL used to         *   FILE 996
//*    execute all of the batch Rexx libary members.                *   FILE 996
//*                                                                 *   FILE 996
//*    The bundled member REXXBLIB contains the batch Rexx execs.   *   FILE 996
//*                                                                 *   FILE 996
```

