```
//***FILE 966 is from Steve Myers and contains a TSO command        *   FILE 966
//*           called HLASM which is a full prompter for the High    *   FILE 966
//*           Level Assembler (ASMA90).                             *   FILE 966
//*                                                                 *   FILE 966
//*           email:  Steve Myers <mvsprog@yahoo.com>               *   FILE 966
//*                                                                 *   FILE 966
//*     Members in this pds:                                        *   FILE 966
//*                                                                 *   FILE 966
//*     Member   Purpose                                            *   FILE 966
//*     ------   -------                                            *   FILE 966
//*     $DOC     This member                                        *   FILE 966
//*     HLASM    Help member for SYS1.HELP                          *   FILE 966
//*     INSTALL  Install HLASM.  The install is to a temporary      *   FILE 966
//*              library to test the program.  It will have to      *   FILE 966
//*              be rerun to install it into a "permanent"          *   FILE 966
//*              library.                                           *   FILE 966
//*     OBJECT   The object "deck" of the HLASM program.            *   FILE 966
//*     ODT      A user document in Open Document format.  This     *   FILE 966
//*              member requires additional processing to           *   FILE 966
//*              prepare it for use on a work station.  See the     *   FILE 966
//*              discussion later in this member.                   *   FILE 966
//*     SOURCE   The source code of the program.                    *   FILE 966
//*     USING    A brief discussion about using the HLASM           *   FILE 966
//*              command.                                           *   FILE 966
//*                                                                 *   FILE 966
//*     The HLASM program is a TSO command processor to run the     *   FILE 966
//*     High Level Assembler in a TSO session.                      *   FILE 966
//*                                                                 *   FILE 966
//*     This HLASM command is a complete and incompatible           *   FILE 966
//*     replacement of the HLASM command in the CBTTAPE "file"      *   FILE 966
//*     300 collection.  It uses the IKJPARS TSO service to         *   FILE 966
//*     examine the contents of the command line, uses MVS          *   FILE 966
//*     dynamic allocation to allocate all the datasets required    *   FILE 966
//*     for the assembly, and uses the TSO PUTLINE service to       *   FILE 966
//*     communicate with the terminal operator or the SYSTSPRT DD   *   FILE 966
//*     statement if run in TSO in batch.  It will run directly     *   FILE 966
//*     from the TSO READY prompt; it does not require a CLIST or   *   FILE 966
//*     REXX exec to pre-allocate the datasets required for the     *   FILE 966
//*     assembly.                                                   *   FILE 966
//*                                                                 *   FILE 966
//*     The command syntax is                                       *   FILE 966
//*                                                                 *   FILE 966
//*     HLASM  dataset   NOADATA/ADATA(dataset)   NOALIGN/ALIGN     *   FILE 966
//*            NOASMAOPTS/ ASMAOPTS(dataset)   NOBATCH/BATCH        *   FILE 966
//*            NODBCS/DBCS  NODXREF/ DXREF  NOESD/ESD NOFOLD/FOLD   *   FILE 966
//*            NOGOFF/GOFF(NOADATA.ADATA) LIB(dataset dataset)      *   FILE 966
//*            NOLIBMAC/LIBMAC NOLIST/LIST(121/133)                 *   FILE 966
//*            NOMXREF/MXREF(FULL/ SOURCE/XREF)                     *   FILE 966
//*            NOOBJECT/OBJECT(dataset) NOPRINT/PRINT(dataset)      *   FILE 966
//*            NORC/RC  NORLD/RLD NORXREF/RXREF                     *   FILE 966
//*            NOTERM/TERM(dataset)   NOTEST/TEST NOTHREAD/THREAD   *   FILE 966
//*            VERSION NOXOBJ/XOBJ(NOADATA/ADATA)                   *   FILE 966
//*            NOXREF/XREF(FULL/SHORT UNREFS)                       *   FILE 966
//*                                                                 *   FILE 966
//*      Required - dataset                                         *   FILE 966
//*                                                                 *   FILE 966
//*      Default - OBJECT TERM(*) LIB('SYS1.MODGEN' 'SYS1.MACLIB')  *   FILE 966
//*                PRINT                                            *   FILE 966
//*                                                                 *   FILE 966
//*                If the source dataset is not fully qualified,    *   FILE 966
//*                the full dataset name is formed by using the     *   FILE 966
//*                dataset prefix appended to the start of the      *   FILE 966
//*                name and .ASM appended to the dataset name.      *   FILE 966
//*                                                                 *   FILE 966
//*                If the TERM dataset name is not specified, and   *   FILE 966
//*                the source data dataset name is not fully        *   FILE 966
//*                qualified, HLASM for the name as                 *   FILE 966
//*                prefix.dsn.TERMLIST.                             *   FILE 966
//*                                                                 *   FILE 966
//*                If the OBJECT dataset name is not specified,     *   FILE 966
//*                and the source data dataset name is not fully    *   FILE 966
//*                qualified, HLASM forms name as prefix.dsn.OBJ.   *   FILE 966
//*                                                                 *   FILE 966
//*                If the PRINT dataset name is not specified,      *   FILE 966
//*                and the source data dataset name is not fully    *   FILE 966
//*                qualified, HLASM forms name as                   *   FILE 966
//*                prefix.dsn.ASMLIST.                              *   FILE 966
//*                                                                 *   FILE 966
//*                If the ADATA dataset name is not specified,      *   FILE 966
//*                and the source data dataset name is not fully    *   FILE 966
//*                qualified, HLASM forms name as                   *   FILE 966
//*                prefix.dsn.ADATA.                                *   FILE 966
//*                                                                 *   FILE 966
//*                If the source dataset is fully qualified or it   *   FILE 966
//*                is specified with a member, the command will     *   FILE 966
//*                prompt the terminal operator for the remainder   *   FILE 966
//*                of the datasets.                                 *   FILE 966
//*                                                                 *   FILE 966
//*                HLASM will allocate the OBJ, TERMLIST, ASMLIST   *   FILE 966
//*                and ADATA datasets if they are not already       *   FILE 966
//*                allocated.                                       *   FILE 966
//*                                                                 *   FILE 966
//*                If TSO "file" ASMAOPTS is allocated and no       *   FILE 966
//*                ASMAOPTS dataset is specified in the command     *   FILE 966
//*                line, the High Level Assembler will use the      *   FILE 966
//*                TSO "file."                                      *   FILE 966
//*                                                                 *   FILE 966

```
