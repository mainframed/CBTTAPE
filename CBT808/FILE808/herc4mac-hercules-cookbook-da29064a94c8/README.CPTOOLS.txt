Readme for the codepage tool

CPtool is a rexx script that will build the translate tables
between different codepages

the naming conventions and format used to describe the input codepages
are the one used by IBM here
"ftp://ftp.software.ibm.com/software/globalization/gcoc/attachments/"

if the input codepages are not available
the script will wget them for the IBM ftp url

the script support table creation for Rexx and c

for REXX the table definition must be hand copied into the <proper> script

for C language a header file is created with the proper syntax

the general format of the command is

cptool  -F nnnnn -T nnnnn

where   :
        -F defines the from codepage

        -T defines the to codepage

additional optional parameters

        --wget  if the codepage definition is not found, it will be wgetED

        --lang  rexx/c

        --repo  the path where the <sources> of the codepages is/will be found

inside the script the PATH where to find the definitions is hardcoded as "."
in the variable CPrepo

[enrico@enrico-mbp xmitools]$cptool.rex -F 1047 -T 367
cptool   - this work is     "Copyright (c) 2012-2013 Enrico Sorichetti"
cptool   - licensed under a "Creative Commons Attribution-ShareAlike 3.0 Unported License"
cptool   - human readable   "http://creativecommons.org/licenses/by-sa/3.0/deed.en_US"
cptool   - Legalese         "http://creativecommons.org/licenses/by-sa/3.0/legalcode"

cptool   - Started : 23:49:04
cptool   - Language not specified defaulting to  'rexx'
cptool   - Building translate table  'CP01047_to_CP00367' for 'rexx'
cptool   - To table 'CP00367' contains '95' chars
cptool   - From table 'CP01047' contains '191' chars
cptool   - table 'CP01047_to_CP00367' created in 'cp01047_to_cp00367.rex.cls'
cptool   - Ended   : 23:49:04
[enrico@enrico-mbp xmitools]$

to produce

CP01047_to_CP00367  = "20202020202020202020202020202020" || ,
                      "20202020202020202020202020202020" || ,
                      "20202020202020202020202020202020" || ,
                      "20202020202020202020202020202020" || ,
                      "20202020202020202020202E3C282B7C" || ,
                      "2620202020202020202021242A293B5E" || ,
                      "2D2F2020202020202020202C255F3E3F" || ,
                      "202020202020202020603A2340273D22" || ,
                      "20616263646566676869202020202020" || ,
                      "206A6B6C6D6E6F707172202020202020" || ,
                      "207E737475767778797A2020205B2020" || ,
                      "202020202020202020202020205D2020" || ,
                      "7B414243444546474849202020202020" || ,
                      "7D4A4B4C4D4E4F505152202020202020" || ,
                      "5C20535455565758595A202020202020" || ,
                      "30313233343536373839202020202020"

and
[enrico@enrico-mbp xmitools]$cptool.rex -F 1047 -T 367 -L c
cptool   - this work is     "Copyright (c) 2012-2013 Enrico Sorichetti"
cptool   - licensed under a "Creative Commons Attribution-ShareAlike 3.0 Unported License"
cptool   - human readable   "http://creativecommons.org/licenses/by-sa/3.0/deed.en_US"
cptool   - Legalese         "http://creativecommons.org/licenses/by-sa/3.0/legalcode"

cptool   - Started : 23:49:49
cptool   - Building translate table  'cp01047_to_cp00367' for 'c'
cptool   - To table 'CP00367' contains '95' chars
cptool   - From table 'CP01047' contains '191' chars
cptool   - table 'cp01047_to_cp00367' created in 'cp01047_to_cp00367.h'
cptool   - Ended   : 23:49:49
[enrico@enrico-mbp xmitools]$

to produce

#ifndef _CP01047_TO_CP00367_H_
#define _CP01047_TO_CP00367_H_
cp01047_to_cp00367[] = {
    "\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20"
    "\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20"
    "\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20"
    "\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20"
    "\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x2E\x3C\x28\x2B\x7C"
    "\x26\x20\x20\x20\x20\x20\x20\x20\x20\x20\x21\x24\x2A\x29\x3B\x5E"
    "\x2D\x2F\x20\x20\x20\x20\x20\x20\x20\x20\x20\x2C\x25\x5F\x3E\x3F"
    "\x20\x20\x20\x20\x20\x20\x20\x20\x20\x60\x3A\x23\x40\x27\x3D\x22"
    "\x20\x61\x62\x63\x64\x65\x66\x67\x68\x69\x20\x20\x20\x20\x20\x20"
    "\x20\x6A\x6B\x6C\x6D\x6E\x6F\x70\x71\x72\x20\x20\x20\x20\x20\x20"
    "\x20\x7E\x73\x74\x75\x76\x77\x78\x79\x7A\x20\x20\x20\x5B\x20\x20"
    "\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x5D\x20\x20"
    "\x7B\x41\x42\x43\x44\x45\x46\x47\x48\x49\x20\x20\x20\x20\x20\x20"
    "\x7D\x4A\x4B\x4C\x4D\x4E\x4F\x50\x51\x52\x20\x20\x20\x20\x20\x20"
    "\x5C\x20\x53\x54\x55\x56\x57\x58\x59\x5A\x20\x20\x20\x20\x20\x20"
    "\x30\x31\x32\x33\x34\x35\x36\x37\x38\x39\x20\x20\x20\x20\x20\x20"
    }
#endif

if the codepages are not found
[enrico@enrico-mbp xmitools]$cptool.rex -F 1047 -T 367
cptool   - this work is     "Copyright (c) 2012-2013 Enrico Sorichetti"
cptool   - licensed under a "Creative Commons Attribution-ShareAlike 3.0 Unported License"
cptool   - human readable   "http://creativecommons.org/licenses/by-sa/3.0/deed.en_US"
cptool   - Legalese         "http://creativecommons.org/licenses/by-sa/3.0/legalcode"

cptool   - Started : 23:53:48
cptool   - Language not specified defaulting to  'rexx'
cptool   - From CodePage not found 'CP01047'
cptool   - Ended   : 23:53:48
[enrico@enrico-mbp xmitools]$

but if the --wget parameter is specified ...

[enrico@enrico-mbp xmitools]$cptool.rex -F 1047 -T 367  --wget
cptool   - this work is     "Copyright (c) 2012-2013 Enrico Sorichetti"
cptool   - licensed under a "Creative Commons Attribution-ShareAlike 3.0 Unported License"
cptool   - human readable   "http://creativecommons.org/licenses/by-sa/3.0/deed.en_US"
cptool   - Legalese         "http://creativecommons.org/licenses/by-sa/3.0/legalcode"

cptool   - Started : 23:55:02
cptool   - Language not specified defaulting to  'rexx'
cptool   - Downloading 'CP01047' from  ftp://ftp.software.ibm.com/software/globalization/gcoc/attachments/
cptool   - Downloading 'CP00367' from  ftp://ftp.software.ibm.com/software/globalization/gcoc/attachments/
cptool   - Building translate table  'CP01047_to_CP00367' for 'rexx'
cptool   - To table 'CP00367' contains '95' chars
cptool   - From table 'CP01047' contains '191' chars
cptool   - table 'CP01047_to_CP00367' created in 'cp01047_to_cp00367.rex.cls'
cptool   - Ended   : 23:55:09
[enrico@enrico-mbp xmitools]$

P.S.

the whole copyright and license text display can be disabled by ...
.local~?cpyr.0 = 0

there is an alternative formatting of the c coding
just comment/uncomment as needed
