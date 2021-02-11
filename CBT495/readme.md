```
/* rexx */
/* trace i */
/*********************************************************************/
/* This exec invokes Compuware's FILEAID dialog.  It is provided     */
/* courtesy of Phil Knight at AIG and Jim Kay at CenturyTel.         */
/*********************************************************************/
parse arg ztrail
if ztrail = '' then
   ztrail = 'MENU'
address tso "ALLOC FI(FALLIB) DA('filepref.LOAD') SHR REUSE"
address tso "ALTLIB ACT APPL(CLIST) DA('filepref.CLIST')"
address ispexec "LIBDEF ISPLLIB DATASET ID('filepref.LOAD') STACK"
address ispexec "LIBDEF ISPMLIB DATASET ID('filepref.ISPMLIB') STACK"
address ispexec "LIBDEF ISPPLIB DATASET ID('filepref.ISPPLIB') STACK"
address ispexec "LIBDEF ISPSLIB DATASET ID('filepref.ISPSLIB') STACK"
address ispexec "LIBDEF ISPTLIB DATASET ID('filepref.ISPTLIB') STACK"
address ispexec "SELECT CMD(%FAEXEC" ztrail "DSN(GO)) NEWAPPL(FAXE)",
                "PASSLIB NOCHECK SCRNAME(FILEAID)"
address ispexec "LIBDEF ISPLLIB"
address ispexec "LIBDEF ISPMLIB"
address ispexec "LIBDEF ISPPLIB"
address ispexec "LIBDEF ISPSLIB"
address ispexec "LIBDEF ISPTLIB"
address tso "ALTLIB DEACT APPL(CLIST)"
address tso "FREE FI(FALLIB)"

/* rexx */
/* trace i */
/*********************************************************************/
/* This exec invokes Compuware's FILEAID/IMS dialog.  It is provided */
/* courtesy of Jim Kay at CenturyTel.                                */
/*********************************************************************/
parse arg ztrail
address tso "ALLOC FI(IXPLLIB) DA('fimspref.LOAD') SHR REUSE"
address tso "ALLOC FI(CTRANS)  DA('fimspref.LOAD') SHR REUSE"
address ispexec "LIBDEF ISPLLIB DATASET ID('fimspref.LOAD') STACK"
address ispexec "LIBDEF ISPMLIB DATASET ID('fimspref.ISPMLIB') STACK"
address ispexec "LIBDEF ISPPLIB DATASET ID('fimspref.ISPPLIB') STACK"
address ispexec "LIBDEF ISPSLIB DATASET ID('fimspref.ISPSLIB') STACK"
address ispexec "LIBDEF ISPTLIB DATASET ID('fimspref.ISPTLIB') STACK"
address ispexec "SELECT PGM(IXPMAIN) NEWAPPL(IXP) PARM(//"ztrail")",
                "NOCHECK PASSLIB SCRNAME(FILEIMS)"
address ispexec "LIBDEF ISPLLIB"
address ispexec "LIBDEF ISPMLIB"
address ispexec "LIBDEF ISPPLIB"
address ispexec "LIBDEF ISPSLIB"
address ispexec "LIBDEF ISPTLIB"
address tso "FREE FI(IXPLLIB CTRANS)"

```
