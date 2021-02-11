```
//***FILE 504 is a Software Inventory system to attempt to keep     *   FILE 504
//*           track of source modules and load modules in an        *   FILE 504
//*           environment where the "execution setup" is not        *   FILE 504
//*           similar to IBM's design.  This system might be        *   FILE 504
//*           helpful for data centers which combine execution      *   FILE 504
//*           libraries, keeping them separate from the SMP/E-fed   *   FILE 504
//*           IBM and program product libraries.  You want to       *   FILE 504
//*           know if the modules you're executing, are different   *   FILE 504
//*           from the ones which are IBM, or ISV supplied.         *   FILE 504
//*                                                                 *   FILE 504
//*           You might also want to keep careful track of          *   FILE 504
//*           multiple occurrences of the same module in            *   FILE 504
//*           different libraries.                                  *   FILE 504
//*                                                                 *   FILE 504
//*           This system consists of 2 distinct parts:             *   FILE 504
//*                                                                 *   FILE 504
//*           1.  A data gathering part written in Assembler,       *   FILE 504
//*               which goes against disk volumes that contain      *   FILE 504
//*               system software libraries (source and load).      *   FILE 504
//*                                                                 *   FILE 504
//*           2.  An analysis part written in SAS, which you        *   FILE 504
//*               must customize.  We have something that works     *   FILE 504
//*               for us.                                           *   FILE 504
//*                                                                 *   FILE 504
//*           The data gathering part of this system does a         *   FILE 504
//*           direct read and capture of the FORMAT 1 VTOC          *   FILE 504
//*           entries of the disk packs containing the software.    *   FILE 504
//*           This is Stage 1.                                      *   FILE 504
//*                                                                 *   FILE 504
//*           Then a member-level gathering is done, on every       *   FILE 504
//*           dataset from these packs, which is eligible to        *   FILE 504
//*           contain software.  After that is done, the SAS        *   FILE 504
//*           reporting mechanisms can be put into effect.          *   FILE 504
//*           This is Stage 2.                                      *   FILE 504
//*                                                                 *   FILE 504
//*           The data gathering part of this system is self-       *   FILE 504
//*           contained, and you might consider adapting it for     *   FILE 504
//*           other purposes, but the reporting part of this        *   FILE 504
//*           system requires SAS.  It is recommended that this     *   FILE 504
//*           system be administered by an experienced SAS          *   FILE 504
//*           programmer, if one is available.  The administrator   *   FILE 504
//*           should know Assembler coding, too.                    *   FILE 504
//*                                                                 *   FILE 504
//*           Contributors' Note:                                   *   FILE 504
//*                                                                 *   FILE 504
//*           The contributor cannot vouch for the absolute         *   FILE 504
//*           accuracy of the reports, as they currently stand.     *   FILE 504
//*           At the site where this is running, this system        *   FILE 504
//*           can detect all occurrences of modules on system       *   FILE 504
//*           libraries, and it can tell whether one version of     *   FILE 504
//*           a module is different from another.  However, you     *   FILE 504
//*           need a good SAS programmer to go over the code        *   FILE 504
//*           "with a fine-toothed comb" to make sure that it       *   FILE 504
//*           runs correctly and reports information correctly.     *   FILE 504
//*                                                                 *   FILE 504
//*           The reporting part of this system was developed,      *   FILE 504
//*           and runs, under SAS Release 6.09.  We can't tell      *   FILE 504
//*           how it will run under other SAS releases, or how      *   FILE 504
//*           it might run if different SAS options are in          *   FILE 504
//*           effect.  See member SASOPTS, which shows global       *   FILE 504
//*           SAS options in effect where this system is running.   *   FILE 504
//*                                                                 *   FILE 504
//*     Questions, please email Sam Golob: sbgolob@attglobal.net    *   FILE 504
//*                                                                 *   FILE 504

```
