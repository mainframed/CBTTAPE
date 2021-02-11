
## $README.txt
```
This is the CBT Usermod Collection for ISPF (CUCI).  Each usermod is packaged
for SMP/E installation in your environment.

Installation Instructions
-------------------------

For SMP/E installation, modify and run these members:

UMBPXISJ - RECEIVE/APPLY UMBPXIS usermod for ISHELL reset UID(0)
UMISCLMJ - RECEIVE/APPLY UMISCLM usermod for SISPLPA VSCR for SCLM modules
UMISPCMJ - RECEIVE/APPLY UMISPCM usermod for ISPCMDS abbreviations
UMISRHIJ - RECEIVE/APPLY UMISRHI usermod for CUCI HIGHLITE
UMISRPDJ - RECEIVE/APPLY UMISRHI usermod for PDSE allocate bug
UMISRPXJ - RECEIVE/APPLY UMISRPX usermod for SAMPLIB keyword hilighting
UMISRUDJ - RECEIVE/APPLY UMISRUD usermod for ISRUDSL0 VSAM block deletes
UMISRUUJ - RECEIVE/APPLY UMISRUU usermod for UDLIST reset UID(0)
UMUSRCFJ - RECEIVE/APPLY UMUSRCF usermod for USRCCONF configuration dialog.
           Be sure to modify USR@KYWD for your keyword member file, and your
           ISR@PRIM menu to set the defaults.

For the SMP/E-averse among you, read member $MANHACK for manually hacking in
these usermods.

Specific usermods are also documented in these members:

$HIGHLIT - Notes on EDIT highlighting for unsupported languages
$ISPCMDS - Notes on ISPF command table abbreviations
$USRCONF - Notes for USRCCONF dialog for ISPF settings not in ISPCCONF
$34DELET - Notes on ISPF 3.4 block deletes not stopping for VSAM
```

