     ----------------------- ISPF application --------------------------

     supplement to CBT File 419

     COBA      This Application analyse the output from the
               Cobol analyse program developed by Roland Schiradin
               Roland(at)Schiradin.de
               To simlify the procedure, the program COBANAL is
               included in this library
               This application requires ISPF Version 4
               The application consist of 4 datasets.
               Rexx library
               Panel Library
               Message and Skeleton Library
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
               If case of a problem please send the output from
               the COBANAL program and the edited output file.

