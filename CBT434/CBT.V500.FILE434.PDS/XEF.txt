/* REXX */
/* Invoke XEF .. if APPLID is not ISR, reinvoke it */
Address ISPEXEC
"VGET ZAPPLID PROFILE SHARED"
If zapplid <> 'ISR' then "SELECT CMD(%XEF) NEWAPPL(ISR)"
Else
"SELECT PANEL(XEFMENU)"
