Notes on the ISPF interface to Roland Schiradin's Cobanal Program
 by Fritz Alber.  This ISPF interface consists of four libraries,
 which are condensed into members of this pds.  Each member can be
 expanded into a full pds by the PDSLOAD program (from File 093 of
 the CBT Tape, load module on File 035), or by IEBUPDTE.

The four members are:   SISPEXEC, SISPMENU, SISPPENU, SISPTENU.

The job to create separate pds'es is #PDSLOAD.


     ----------------------- ISPF application --------------------------

     supplement to CBT File 321

     COBA      This Application analyse the output from the
               Cobol analyse program developed by Roland Schiradin
               This application requires ISPF Version 4
               The application consist of 4 datasets.
               Rexx library
               Panel Library
               Message and skeleton Library
               Table Libary

               You have to change member $COBA in the Rexx library
               See section/label Coba_Parms thru End_Coba_Parms.
               Please change the following variables to your standards

               ACCOUNT
               CLASS
               MSGCLASS
               STEPLIB
               ISPFHLQ
               COBAAPPL
               COBAHLQ
               LLQCLIB
               LLQPLIB
               LLQMLIB
               LLQSLIB
               LLQTLIB
               LLQTABL

               After these changes you can execute procedure $COBA
               First you'll see a selection panel to display
               or create analyse tables.

               If you have any problems, comments or improvements
               please contact
               Alber(at)alber-edv.de

