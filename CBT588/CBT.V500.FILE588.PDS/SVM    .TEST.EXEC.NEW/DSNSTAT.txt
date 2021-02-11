/* REXX  Show ISPF stats for selected datasets
|
|  INPUT:     dsnameÝ,vol¨
|             dsname can be a prefix
|
|  OUTPUT:    DSNs with statistics that matched parameters concatenated
|  cols:      via '|'. Each dsn record has the following words:
|  1-44         1. dsname
|  46-51        2. volser
|  53-56        3. dsorg
|  58-62        4. recfm
|  64-68        5. lrecl
|  70-74        6. blksize
|  76-81        7. trks allocated
|  83-85        8. % trks used
|  87-89        9. # of extents
|  91-94       10. unit type (e.g. 3390)
| 100-109      11. crtdate    '2003/06/23'
| 111-120      12. expdate or '***None***'
| 122-131      13. refdate    '2003/06/23'
|
|  Externals: ISPF LMDINIT, LMDLIST - TSO ISPF environment
|
*/
   #p = 'DSNSTAT:'
   #bl = ' '
   #sep = '|'
   Arg parm
   Select
   When arg() > 1 Then Do
      selcrit = "STRIP"(arg(1))
      vol     = "STRIP"(arg(2))
      end
   When "POS"(',',parm) > 0 Then Do
      Parse Var parm selcrit ',' vol
      selcrit = "STRIP"(selcrit)
      vol     = "STRIP"(vol)
      End
   Otherwise Do
      selcrit = "WORD"(parm,1)
      vol     = "WORD"(parm,2)
      End
   End
   Say #p 'Volume    = "'vol'"'
   Say #p 'Selection = "'selcrit'"'
   If selcrit = '' Then selcrit = ' '  /* select all */

   "SUBCOM ispexec"
   IF RC = 0 THEN
   ADDRESS ispexec
   ELSE Do
      Say #p 'ISPEXEC environment not available'
      Return(20)
      End

   If vol <> '' Then
      'LMDINIT' 'LISTID(ID)' 'LEVEL('selcrit')' 'VOLUME('vol')'
   Else
      'LMDINIT' 'LISTID(ID)' 'LEVEL('selcrit')'
   If rc <> 0 Then Say #p 'LMDINIT.rc='rc

/*  Get the list of datasets to file ID   */
   'LMDLIST' 'LISTID('ID')',
   'OPTION(SAVE)',                 /* save to dataset */
   'DATASET('#bl')',               /* blank - list from beginning */
   'STATS(Y)',                     /* with statistics */
   'GROUP('DSNSTAT')'              /* dsn=USERID.DSNSTAT.DATASETS */
   If rc <> 0 Then Say #p 'LMDLIST.rc ='rc
   SAVE_RC = RC

   'LMDFREE' 'LISTID('ID')'
   If rc <> 0 Then Say #p 'LMDFREE.rc ='rc

/* Read dsn stats from file ID            */
   If SAVE_RC <> 0 Then Do
      Say #p '- No datasets found'
      Return('8')
      End
   ADDRESS 'TSO'                  /* CHANGE ADDRESS */

/* Read member list & stats from ISPF output file: */
   DATASET = SYSVAR(SYSUID)||'.DSNSTAT.DATASETS'
   "ALLOC DA('"DATASET"') F(ID) OLD"  /* ALLOC OUTPUT DSN  */
   "EXECIO * DISKR ID (FINIS"    /* READ MEMBERS INTO STACK */
   "FREE FI(ID)"
   #num = QUEUED()
   Say #p 'File read, total records='#num ':'
   If #num = 0 Then #ret = 4
   Else #ret = 0
   Do #num
      Parse PULL line
      If SYSVAR('SYSENV') <> 'BACK' Then Say line
      Else #ret = #ret || #sep || "STRIP"(line)
      End
   RETURN(#ret)
