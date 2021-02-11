```
//***FILE 480 is a collection of utilities from Baldomero Castilla  *   FILE 480
//*           of Madrid, Spain.  Baldomero can understand spoken    *   FILE 480
//*           English and written English, so he can support these  *   FILE 480
//*           programs.  But he can't write English, so all of the  *   FILE 480
//*           programs and utilities found here, are commented in   *   FILE 480
//*           Spanish.  I have translated Baldomero's general       *   FILE 480
//*           documentation into English, and if anyone needs a     *   FILE 480
//*           program translated, I guess I can try, without        *   FILE 480
//*           promising.  There's some very good code here, so if   *   FILE 480
//*           you think you can negotiate the Spanish, please give  *   FILE 480
//*           it a shot.  A translation of Baldomero's              *   FILE 480
//*           documentation follows:                                *   FILE 480
//*                                                                 *   FILE 480
//*      Translator's email:  Sam Golob <sbgolob@cbttape.org>       *   FILE 480
//*                                                                 *   FILE 480
//*                Baldomero Castilla Roldan                        *   FILE 480
//*                Programador de Sistemas                          *   FILE 480
//*                Madrid (Espana)                                  *   FILE 480
//*                bcastill@ceca.es                                 *   FILE 480
//*                bcastill@cajaactiva.es                           *   FILE 480
//*                                                                 *   FILE 480
//*     I have attempted to translate this documentation into       *   FILE 480
//*     English.  Please excuse my poor Spanish.   (S.Golob)        *   FILE 480
//*                                                                 *   FILE 480
//*     This contains a collection of utilities, which include      *   FILE 480
//*     the full program, and a JCL example.  There are REXX,       *   FILE 480
//*     CLIST, EDIT MACROS, etc.                                    *   FILE 480
//*                                                                 *   FILE 480
//*     All of the information is in 2 libraries:                   *   FILE 480
//*                                                                 *   FILE 480
//*      FILE 480 Source   (includes everything, except             *   FILE 480
//*                         executable modules)                     *   FILE 480
//*                                                                 *   FILE 480
//*      Member   LOADLIB  (includes the executables, some of       *   FILE 480
//*                         which need APF authorization.)          *   FILE 480
//*                        This member is in TSO XMIT format,       *   FILE 480
//*                        and it replaces the former File 481.     *   FILE 480
//*                                                                 *   FILE 480
//*     I think that the most interesting things are:               *   FILE 480
//*                                                                 *   FILE 480
//*        VERDSN, Used to find a file among all the disk           *   FILE 480
//*                packs in an installation                         *   FILE 480
//*                                                                 *   FILE 480
//*      CKLOCMEM, Used to find a member of a pds, among all        *   FILE 480
//*                the pds'es in the entire installation            *   FILE 480
//*                                                                 *   FILE 480
//*        CKDATE, This is a method of controling the steps of      *   FILE 480
//*                a JCL stream, depending on the date and the      *   FILE 480
//*                hour                                             *   FILE 480
//*                                                                 *   FILE 480
//*      Contents or the Library:                                   *   FILE 480
//*                                                                 *   FILE 480
//*        CALCUL   (REXX)                                          *   FILE 480
//*        CALCULP  (PANEL)                                         *   FILE 480
//*           Description => This is a calculator                   *   FILE 480
//*                                                                 *   FILE 480
//*        CKDATEJ  (JCL)                                           *   FILE 480
//*        CKDATEP  (Cataloged Procedure)                           *   FILE 480
//*        CKDATEX  (REXX)                                          *   FILE 480
//*           Description => Utility to know what year, month,      *   FILE 480
//*                       => day...etc.  in a JCL, depending        *   FILE 480
//*                       => on Return Code.                        *   FILE 480
//*                                                                 *   FILE 480
//*        CKDELMEJ (JCL)                                           *   FILE 480
//*        CKDELMEM (Source Program in Assembler)                   *   FILE 480
//*           Description => Delete a member of a partitioned       *   FILE 480
//*                       => dataset in a Batch Job (JCL), the      *   FILE 480
//*                       => advantage is to be able to refer       *   FILE 480
//*                       => to the library as DISP=SHR             *   FILE 480
//*                                                                 *   FILE 480
//*        CKFINAL  (MACRO)                                         *   FILE 480
//*           Description => Assembler macro                        *   FILE 480
//*                                                                 *   FILE 480
//*        CKIEBGEJ (JCL)                                           *   FILE 480
//*        CKIEBGEN (Source Program in Assembler)                   *   FILE 480
//*           Description => Program to make a copy between         *   FILE 480
//*                       => SYSUT1 and SYSUT2, the same as         *   FILE 480
//*                       => IEBGENER, but with files of            *   FILE 480
//*                       => arbitrary length.                      *   FILE 480
//*                                                                 *   FILE 480
//*                 (Improved enormously by Sam Golob and           *   FILE 480
//*                  Warren Whitford, to report record counts,      *   FILE 480
//*                  and to select some records to copy.)           *   FILE 480
//*                 Original CKIEBGEN program is called member      *   FILE 480
//*                 CKIEBGEO here.  Use the new one.                *   FILE 480
//*                                                                 *   FILE 480
//*        CKINICIO (MACRO)                                         *   FILE 480
//*           Description => Assembler macro                        *   FILE 480
//*                                                                 *   FILE 480
//*        CKLEVEL  (Source Program in Assembler)                   *   FILE 480
//*        CKLEVELJ (JCL)                                           *   FILE 480
//*           Description => Utility to list the contents of a      *   FILE 480
//*                       => group of sequential files,             *   FILE 480
//*                       => without giving the complete name,      *   FILE 480
//*                       => only a partial name, using LEVEL.      *   FILE 480
//*                                                                 *   FILE 480
//*        CKLOCMEJ (JCL)                                           *   FILE 480
//*        CKLOCMEM (Source Program in Assembler)                   *   FILE 480
//*           Description => Utility.  Given a member name,         *   FILE 480
//*                       => find all of the PDS or PDSE            *   FILE 480
//*                       => datasets of an installation where      *   FILE 480
//*                       => that module has to be APF              *   FILE 480
//*                       => authorized.                            *   FILE 480
//*                                                                 *   FILE 480
//*        CKRENMEJ (JCL)                                           *   FILE 480
//*        CKRENMEM (Source Program in Assembler)                   *   FILE 480
//*           Description => Rename a member of a pds in a          *   FILE 480
//*                       => Batch process i.e. with JCL.  The      *   FILE 480
//*                       => advantage is that you only have        *   FILE 480
//*                       => to allocate the library,               *   FILE 480
//*                       => DISP=SHR.                              *   FILE 480
//*                                                                 *   FILE 480
//*        CKSTJOBM (Source Program in Assembler)                   *   FILE 480
//*        CKSTJOBJ (JCL)                                           *   FILE 480
//*           Description => Utility to detect if a JOB or and      *   FILE 480
//*                       => STC is executing in the system.        *   FILE 480
//*                                                                 *   FILE 480
//*        CKSYMB   (EDIT MACRO)                                    *   FILE 480
//*        CKSYMBOL (Source Program in Assembler)                   *   FILE 480
//*        CKSYMBP  (Cataloged Procedure)                           *   FILE 480
//*           Description => Utility to submit a job (CKSYMB)       *   FILE 480
//*                       => but sustituting the global             *   FILE 480
//*                       => symbols defined to the system.         *   FILE 480
//*                       => Also, you can use an INTRDR            *   FILE 480
//*                       => (CKSYMBP) to execute such a job        *   FILE 480
//*                       => before substituting the system         *   FILE 480
//*                       => symbols.                               *   FILE 480
//*                                                                 *   FILE 480
//*        CKUSOJ   (JCL)                                           *   FILE 480
//*        CKUSOP   (Cataloged Procedure)                           *   FILE 480
//*        CKUSOX   (REXX)                                          *   FILE 480
//*           Description => Utility to use in JCL and to           *   FILE 480
//*                       => control what percentage of             *   FILE 480
//*                       => utilization a dataset has.             *   FILE 480
//*                                                                 *   FILE 480
//*        CKYAESTA (Source Program in Assembler)                   *   FILE 480
//*        CKYAESTJ (JCL)                                           *   FILE 480
//*           Description => Utility to detect if an STC is         *   FILE 480
//*                       => already executing in the system.       *   FILE 480
//*                                                                 *   FILE 480
//*        LLENAR   (EDIT MACRO)                                    *   FILE 480
//*           Description => Edit Macro to fill up a series of      *   FILE 480
//*                       => line numbers.  It has its own          *   FILE 480
//*                       => HELP incorporated in it.               *   FILE 480
//*                                                                 *   FILE 480
//*        MENSAJE  (Source Program in Assembler)                   *   FILE 480
//*           Description => Programs to invoke a WTO macro         *   FILE 480
//*                       => and transmit a message to the          *   FILE 480
//*                       => master console.                        *   FILE 480
//*                                                                 *   FILE 480
//*        MESES    (CLIST)                                         *   FILE 480
//*        MESP1    (PANEL)                                         *   FILE 480
//*        MESP2    (PANEL)                                         *   FILE 480
//*        MESP3    (PANEL)                                         *   FILE 480
//*           Description => This is a calendar, using PFK7 in      *   FILE 480
//*                       => order to display ahead, PFK8 to        *   FILE 480
//*                       => display backward, and PFK3 to          *   FILE 480
//*                       => exit.                                  *   FILE 480
//*                                                                 *   FILE 480
//*        PRESTAMO (CLIST)                                         *   FILE 480
//*        PRESTA   (PANEL)                                         *   FILE 480
//*        PRESTA4  (Source Program in COBOL)                       *   FILE 480
//*           Description => Utility to calculate lends             *   FILE 480
//*                                                                 *   FILE 480
//*                                                                 *   FILE 480
//*        SUMAR    (EDIT MACRO)                                    *   FILE 480
//*           Description => Edit Macro to total a series           *   FILE 480
//*                       => of numbers.  Has its own               *   FILE 480
//*                       => incorporated HELP.                     *   FILE 480
//*                                                                 *   FILE 480
//*        VERDSN   (REXX)                                          *   FILE 480
//*        VERDSNP  (PANEL)                                         *   FILE 480
//*        VERDSNS  (Source Program in Assembler)                   *   FILE 480
//*        VER00    (MESSAGES)                                      *   FILE 480
//*           Description => Utility to find a dataset on all       *   FILE 480
//*                       => of the disks in an installation        *   FILE 480
//*                                                                 *   FILE 480

```
