/* REXX  Show ISPF stats for selected members in PDS
|
|  INPUT:     dsnÝ,member¨
|             MEMBER = selection wildcard
|
|  OUTPUT:    DSN with the PDS member records matching the
|             member selection criteria with stats, concatenated
|  cols:      via '|'. Each member record contains the following words:
|  FB (source):
|    1-8         1. member
|   23-27        2. vv.mm
|   29-36        3. crtdate   '03/07/25'
|   38-45        4. chgdate   '03/07/25'
|   47-51        5. chgtime   'hh:mm'
|   53-57        6. size      (records)
|   59-63        7. init      (records)
|   65-69        8. mod
|   71-78        9. userid
|
|  U (load):     1. member
|                2. size       8 digits hexadecimal
|                3. TTR        6 digits hexadecimal
|                4. alias_of   name of main member or blank
|  col 47   4 or 5. AC         auth code, 00 or 01
|  col 51   5 or 6. amode      24 or 31
|  col 54   6 or 7. rmode      ANY or 24
|  col 58   others. attributes separated by blanks (RN RU TS OL etc.)
|
|  Externals: REXXTOOL MATCH function
|             and ISPF LMINIT, LMMLIST - TSO ISPF environment
*/
   #p = 'PDSSTAT:'
   #sep = '|'
   Arg parm
   Select
   When arg() > 1 Then Do
      dsname  = "STRIP"(arg(1))
      selcrit = "STRIP"(arg(2))
      end
   When "POS"(',',parm) > 0 Then Do
      Parse Var parm dsname ',' selcrit
      dsname  = "STRIP"(dsname)
      selcrit = "STRIP"(selcrit)
      End
   Otherwise Do
      dsname  = "WORD"(parm,1)
      selcrit = "WORD"(parm,2)
      End
   End

   Say #p 'Dsname    = "'dsname'"'
   Say #p 'Selection = "'selcrit'"'
   If selcrit = '' Then selcrit = '*'  /* select all */

   "SUBCOM ispexec"
   IF RC = 0 THEN
   ADDRESS ispexec
   ELSE Do
      Say #p 'ISPEXEC environment not available'
      Return(20)
      End

   'LMINIT' 'DATAID(ID)' 'DATASET('''dsname''')' 'ENQ(SHR)'

/* Get the list of members with stats to file ID */
   'LMOPEN' 'DATAID('ID')'
   'LMMLIST' 'DATAID('ID')' 'OPTION(SAVE)',  /* GET PDS MEMEMBER LIST */
      'STATS(YES)' 'GROUP('ZZMEMB')'         /* WITH THE LMMSTATS     */
   If rc <> 0 Then Say #p 'LMMLIST.rc ='rc
   SAVE_RC = RC

   'LMCLOSE' 'DATAID('ID')'
   If rc <> 0 Then Say #p 'LMCLOSE.rc ='rc
   'LMFREE' 'DATAID('ID')'
   If rc <> 0 Then Say #p 'LMFREE.rc  ='rc

/* Read member stats from file ID            */
   If SAVE_RC <> 0 Then Do        /* IF MEMBERS WERE FOUND */
      Say '- Dataset not found or no members'
      Return(8)
      End
   ADDRESS 'TSO'                  /* CHANGE ADDRESS */

/* Read member list & stats from ISPF output file: */
   DATASET = SYSVAR(SYSUID)||'.ZZMEMB.MEMBERS'
   "ALLOC DA('"DATASET"') F(ID) OLD"  /* ALLOC OUTPUT DSN  */
   "EXECIO * DISKR ID (FINIS"    /* READ MEMBERS INTO STACK */
   "FREE FI(ID)"
   #num = QUEUED()
   Say #p 'File read, total members='#num ':'
   If #num = 0 Then #ret = 4
   Else #ret = 0
   Do #num
      Parse PULL line
      If MATCH(selcrit,"WORD"(line,1)) Then
         If SYSVAR('SYSENV') <> 'BACK' Then Say line
         Else #ret = #ret || #sep || "STRIP"(line)
      End
   RETURN(#ret)
