```
//***FILE 330 is from Fritz Alber, and contains an ISPF interface   *   FILE 330
//*           to the COBANAL program from Roland Schiradin that     *   FILE 330
//*           is on File 321.  In addition:                         *   FILE 330
//*                                                                 *   FILE 330
//*           This file also contains an ISPF application to        *   FILE 330
//*           analyze the output from the CICS CSD extract          *   FILE 330
//*           program, DFH$FORA.                                    *   FILE 330
//*                                                                 *   FILE 330
//*           For more information about the CICS CSD extract       *   FILE 330
//*           program, please see the CICS Customization Guide,     *   FILE 330
//*           chapter "User programs for the system definition      *   FILE 330
//*           utility".  This application requires ISPF Version     *   FILE 330
//*           4.                                                    *   FILE 330
//*                                                                 *   FILE 330
//*           Members having to do with the COBANAL interface       *   FILE 330
//*           are prefixed COBA.  Members having to do with the     *   FILE 330
//*           CICS CSD extract interface are prefixed CCSD.         *   FILE 330
//*                                                                 *   FILE 330
//*           The COBA application consist of 5 datasets.           *   FILE 330
//*           Rexx Library                                          *   FILE 330
//*           Panel Library                                         *   FILE 330
//*           Message and Skeleton Library                          *   FILE 330
//*           Table Library                                         *   FILE 330
//*           Load Library                                          *   FILE 330
//*                                                                 *   FILE 330
//*           The CCSD application consist of 5 datasets.           *   FILE 330
//*           Rexx library                                          *   FILE 330
//*           Panel Library                                         *   FILE 330
//*           Message Library                                       *   FILE 330
//*           Skeleton Library                                      *   FILE 330
//*           Table Libary                                          *   FILE 330
//*                                                                 *   FILE 330
//*  -------------------- ISPF application COBA ------------------  *   FILE 330
//*                                                                 *   FILE 330
//*  supplement to CBT File 321                                     *   FILE 330
//*                                                                 *   FILE 330
//*  COBA      This Application analyzes the output from the        *   FILE 330
//*            Cobol analysis program developed by Roland           *   FILE 330
//*              Schiradin.                                         *   FILE 330
//*            This application requires ISPF Version 4.            *   FILE 330
//*                                                                 *   FILE 330
//*            The application consists of 4 datasets:              *   FILE 330
//*            REXX library                                         *   FILE 330
//*            Panel Library                                        *   FILE 330
//*            Message and Skeleton Library                         *   FILE 330
//*            Table Libary                                         *   FILE 330
//*                                                                 *   FILE 330
//*            You have to change member $COBA in the               *   FILE 330
//*            REXX library                                         *   FILE 330
//*                                                                 *   FILE 330
//*            See section/label Coba_Parms thru End_Coba_Parms.    *   FILE 330
//*                                                                 *   FILE 330
//*            Please change the following variables to             *   FILE 330
//*            your standards:                                      *   FILE 330
//*                                                                 *   FILE 330
//*            ACCOUNT                                              *   FILE 330
//*            CLASS                                                *   FILE 330
//*            MSGCLASS                                             *   FILE 330
//*            STEPLIB                                              *   FILE 330
//*            ISPFHLQ                                              *   FILE 330
//*            COBAAPPL                                             *   FILE 330
//*            COBAHLQ                                              *   FILE 330
//*            LLQCLIB                                              *   FILE 330
//*            LLQPLIB                                              *   FILE 330
//*            LLQMLIB                                              *   FILE 330
//*            LLQSLIB                                              *   FILE 330
//*            LLQTLIB                                              *   FILE 330
//*            LLQTABL                                              *   FILE 330
//*                                                                 *   FILE 330
//*            After these changes you can execute                  *   FILE 330
//*            procedure $COBA.                                     *   FILE 330
//*                                                                 *   FILE 330
//*            First you'll see a selection panel to display        *   FILE 330
//*            or create analysis tables.                           *   FILE 330
//*                                                                 *   FILE 330
//*            If you have any problems, comments or improvements   *   FILE 330
//*            please contact     Alber@alber-edv.de                *   FILE 330
//*                                                                 *   FILE 330
//*       email:    Fritz Alber <Alber@alber-edv.de>                *   FILE 330
//*                                                                 *   FILE 330
//*  -------------------- ISPF application CCSD ------------------  *   FILE 330
//*                                                                 *   FILE 330
//*  CCSD      This Application analyzes the output from the        *   FILE 330
//*            CICS CSD extract program DFH$FORA.                   *   FILE 330
//*            For more information about the extract program,      *   FILE 330
//*            please see CICS customization guide chapter:         *   FILE 330
//*            "User programs for the system definition utility"    *   FILE 330
//*            This application requires ISPF Version 4.            *   FILE 330
//*            The application consist of 5 datasets.               *   FILE 330
//*                                                                 *   FILE 330
//*            Rexx library                                         *   FILE 330
//*            Panel Library                                        *   FILE 330
//*            Message Library                                      *   FILE 330
//*            Skeleton Library                                     *   FILE 330
//*            Table Libary                                         *   FILE 330
//*                                                                 *   FILE 330
//*            You have to change member $CICCSD in the Rexx        *   FILE 330
//*            library See section/label Ciccsd_Parms thru          *   FILE 330
//*            End_Ciccsd_Parms.  Please change the following       *   FILE 330
//*            variables to your standards                          *   FILE 330
//*                                                                 *   FILE 330
//*            ACCOUNT                                              *   FILE 330
//*            CLASS                                                *   FILE 330
//*            MSGCLASS                                             *   FILE 330
//*            STEPLIB                                              *   FILE 330
//*            ISPFHLQ                                              *   FILE 330
//*            CCSDAPPL                                             *   FILE 330
//*            CCSDHLQ                                              *   FILE 330
//*            LLQCLIB                                              *   FILE 330
//*            LLQPLIB                                              *   FILE 330
//*            LLQMLIB                                              *   FILE 330
//*            LLQSLIB                                              *   FILE 330
//*            LLQTLIB                                              *   FILE 330
//*            LLQTABL                                              *   FILE 330
//*                                                                 *   FILE 330
//*            After these changes you can execute procedure        *   FILE 330
//*            $CICCSD First you'll see a selection panel to        *   FILE 330
//*            display or create analyse tables.                    *   FILE 330
//*                                                                 *   FILE 330
//*            If you have any problems, comments or improvements   *   FILE 330
//*            please contact                                       *   FILE 330
//*            Alber(at)alber-edv.de                                *   FILE 330
//*                                                                 *   FILE 330

```
