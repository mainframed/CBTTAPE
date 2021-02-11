
## @FILE926.txt
```
//***FILE 926 is from Philip Polchinski and contains a COBOL        *   FILE 926
//*           program to figure out amoritization payments,         *   FILE 926
//*           such as mortgage payments and car payments.           *   FILE 926
//*                                                                 *   FILE 926
//*           Compile and execution JCL is included here, as        *   FILE 926
//*           are load libraries (PDS and PDSE) in XMIT format.     *   FILE 926
//*                                                                 *   FILE 926
//*           This program is of general personal value, or it      *   FILE 926
//*           may also be used by corporate management to figure    *   FILE 926
//*           estimates for their own use.                          *   FILE 926
//*                                                                 *   FILE 926
//*           email:  philmpolchinski@hotmail.com                   *   FILE 926
//*                                                                 *   FILE 926
//*           This program is not a system programmer tool per se,  *   FILE 926
//*           but it will help people with their personal lives,    *   FILE 926
//*           by helping to calculate how much you'll have to pay   *   FILE 926
//*           monthly, if you are borrowing a certain amount of     *   FILE 926
//*           money at a certain rate of interest.  And it runs     *   FILE 926
//*           on z/OS or earlier MVS systems.                       *   FILE 926
//*                                                                 *   FILE 926
//*           Program source is included, in COBOL, as member       *   FILE 926
//*           AMORT.                                                *   FILE 926
//*                                                                 *   FILE 926
//*           Included are three load libraries, PDS for COBOL 4.2  *   FILE 926
//*           and earlier, and a PDSE loadlib for COBOL 5.1 or      *   FILE 926
//*           later.  IBM has forced users of COBOL 5.1 to link     *   FILE 926
//*           its programs into a PDSE load library and not a       *   FILE 926
//*           PDS load library. ;-)  A load library has now been    *   FILE 926
//*           included which contains AMORT, compiled on COBOL 5.2. *   FILE 926
//*           Also, AMORT compiled on COBOL 6.1 and 6.2 and 6.3.    *   FILE 926
//*                                                                 *   FILE 926
//*   How to use the AMORT program.                                 *   FILE 926
//*                                                                 *   FILE 926
//*   This program creates a payment schedule (for mortgage         *   FILE 926
//*   or car payments or corporate loan payments or the             *   FILE 926
//*   like), based on the following factors:                        *   FILE 926
//*                                                                 *   FILE 926
//*   1-  The interest rate                                         *   FILE 926
//*   2-  The amount of the principal                               *   FILE 926
//*   3-  The amount of each payment                                *   FILE 926
//*   4-  The total number of (monthly) payments                    *   FILE 926
//*                                                                 *   FILE 926
//*   Required for each run:   the interest rate  (ALWAYS NEEDED)   *   FILE 926
//*                                                                 *   FILE 926
//*   For the other 3 factors, if you supply two of them, the       *   FILE 926
//*   program will produce a schedule showing the third             *   FILE 926
//*   factor.                                                       *   FILE 926
//*                                                                 *   FILE 926
//*   Thus, the type of run you want, is classified into three      *   FILE 926
//*   "job types".                                                  *   FILE 926
//*                                                                 *   FILE 926
//*   For example:  (Remember that the interest rate ALWAYS         *   FILE 926
//*                  has to be supplied)                            *   FILE 926
//*                                                                 *   FILE 926
//*   Job Type: 1-  Given monthly payment amount and number         *   FILE 926
//*                 of payments                                     *   FILE 926
//*                                                                 *   FILE 926
//*                 Program supplies:   - total principal paid      *   FILE 926
//*                                                                 *   FILE 926
//*   Job Type: 2-  Given total principal and number of             *   FILE 926
//*                 payments                                        *   FILE 926
//*                                                                 *   FILE 926
//*                 Program supplies:   - monthly payment amounts   *   FILE 926
//*                                                                 *   FILE 926
//*   Job Type: 3-  Given total principal and monthly payment       *   FILE 926
//*                 amount desired                                  *   FILE 926
//*                                                                 *   FILE 926
//*                 Program supplies:   - length of the loan        *   FILE 926
//*                 (number of payments)                            *   FILE 926
//*                                                                 *   FILE 926
//*   Values are entered in the PARM field of the EXEC              *   FILE 926
//*   statement as shown below.  In addition, you HAVE TO           *   FILE 926
//*   ENTER THE JOB TYPE as the first parameter (the format         *   FILE 926
//*   is also shown below, in detail).                              *   FILE 926
//*                                                                 *   FILE 926
//*   PARM='Z--PRINCIPAL-PAYMENTCC-YY-MM-INTER'  pattern of parms   *   FILE 926
//*   PARM='1--000000000-000060300-02-00-05999'                     *   FILE 926
//*   PARM='2--000013600-000000000-00-24-05999'                     *   FILE 926
//*   PARM='3--000013600-000060300-00-00-05999'                     *   FILE 926
//*   PARM='Z--MMMTTTDDD-MTTTDDDcc-YY-MM-INTER'  format of parms    *   FILE 926
//*                                                                 *   FILE 926
```

