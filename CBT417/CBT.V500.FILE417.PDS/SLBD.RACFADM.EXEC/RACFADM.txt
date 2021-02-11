/*%NOCOMMENT====================* REXX *==============================*/
/*  PURPOSE:  RACFADM - Display Menu - LIBDEF and ALTLIB datasets     */
/*--------------------------------------------------------------------*/
/*  NOTES:    1) There are two subroutines to allow defining repeat   */
/*               find (RFIND):                                        */
/*               - SETUP_RFIND1 allocates a ISPF table and            */
/*                 defines/adds the RFIND command                     */
/*               - SETUP_RFIND2 updates the currently used table      */
/*                 and modifies the RFIND command                     */
/*               - Currently this program is using SETUP_RFIND1,      */
/*                 due to SETUP_RFIND2 was leaving entry in table     */
/*                 after exiting                                      */
/*                                                                    */
/*            2) For all users, this REXX program will call RACFSETD  */
/*               to define default Settings (Option 0)                */
/*--------------------------------------------------------------------*/
/* FLG  YYMMDD  USERID   DESCRIPTION                                  */
/* ---  ------  -------  -------------------------------------------- */
/* @A2  200622  LBD      Support a passed option                      */
/* @AC  200619  RACFA    Initialize the variable NULL                 */
/* @AB  200619  LBD      Fixed datasets w/ last qual. as 'SKEL'       */
/* @AA  200610  RACFA    Added skeleton dataset                       */
/* @A9  200520  RACFA    Fixed RFIND, LIBDEF and TBCLOSE using $STUB  */
/* @A8  200519  TRIDJK   Check user cmd table before site cmd table   */
/* @A7  200519  RACFA    Use SETUP_RFIND1, RFIND2 left entry in table */
/* @A6  200514  LBD      Add parmeter of NA to bypass allocations     */
/* @A5  200514  LBD      Added different way to setup/define RFIND    */
/* @A4  200501  RACFA    If 1st time used, get site default settings  */
/* @A3  200501  LBD      Add dynamic command table                    */
/* @A2  200124  RACFA    Place panels at top of REXX in variables     */
/* @A1  200120  LBD      Added code for sites using qual. PLIB/MLIB   */
/* @A0  200120  LBD      Created REXX                                 */
/*====================================================================*/
PANEL01     = "RACFMENU"  /* RACF Main Menu                */ /* @A2 */
REXXPGM1    = "RACFSETD"  /* Obtain settings for new user  */ /* @A4 */
NULL        = ""                                              /* @AC */
Arg RAOPT                 /* Invoked using $STUB mbr       */ /* @A6 */

if pos('NA',RAOPT) > 0 then do                                /* @A2 */
   rw = wordpos('NA',RAOPT)                                   /* @A2 */
   radmopt = delword(raopt,rw,1)                              /* @A2 */
   raopt = 'NA'                                               /* @A2 */
end                                                           /* @A2 */
else                                                          /* @A2 */
   radmopt = raopt                                            /* @A2 */

ADDRESS ISPEXEC
  call Setup
  'Select cmd('REXXPGM1')  NewAppl(RADM) PassLib'             /* @A4 */

  if radmopt /= null then 'control nondispl enter'            /* @A2 */

  'Select Panel('PANEL01') Opt('radmopt')' ,                  /* @A2 */
         'NewAppl(RADM) PassLib'                              /* @A2 */
  if (RAOPT <> "NA") THEN DO                                  /* @A9 */
     'libdef ispmlib'
     'libdef ispplib'
     'libdef ispslib'                                         /* @AA */
     Address TSO 'altlib deact app(exec)'
  END                                                         /* @A9 */
  'tbclose radmcmds'                                          /* @A7 */
EXIT 0
/*--------------------------------------------------------------------*/
/*  Obtain dataset names and LIBDEF/ALTLIB them                       */
/*--------------------------------------------------------------------*/
SETUP:
  parse source src                                            /* @A6 */
  parse value src with TSO Type Name DDName DSName,           /* @A6 */
                       NameO Env Addr Token                   /* @A6 */
  cmd = name                                                  /* @A6 */

  call setup_rfind1                                           /* @A9 */
  if (raopt = 'NA') then return                               /* @A9 */
  if (DSName /= '?') then exec = "'"dsname"'"
  else do
     x      = listdsi(DDName 'FILE')
     exec   = "'"sysdsname"'"
     dsname = sysdsname
  end
  dsname = translate(dsname,' ','.')
  panels = "'"subword(dsname,1,words(dsname)-1)" PANELS'"
  skels  = "'"subword(dsname,1,words(dsname)-1)" SKELS'"      /* @AB */
  msgs   = "'"subword(dsname,1,words(dsname)-1)" MSGS'"
  plib   = "'"subword(dsname,1,words(dsname)-1)" ISPPLIB'"    /* @A1 */
  slib   = "'"subword(dsname,1,words(dsname)-1)" ISPSLIB'"    /* @AA */
  mlib   = "'"subword(dsname,1,words(dsname)-1)" ISPMLIB'"    /* @A1 */
  panels = translate(panels,'.',' ')
  msgs   = translate(msgs,'.',' ')
  skels  = translate(skels,'.',' ')                            /*@AB */
  plib   = translate(plib,'.',' ')                            /* @A1 */
  slib   = translate(slib,'.',' ')                            /* @AA */
  mlib   = translate(mlib,'.',' ')                            /* @A1 */
  x = listdsi(plib)                                           /* @A1 */
  if (x = 0) then panels = plib                               /* @A1 */
  x = listdsi(slib)                                           /* @AA */
  if (x = 0) then skels = slib                                /* @AB */
  x = listdsi(mlib)                                           /* @A1 */
  if (x = 0) then msgs = mlib                                 /* @A1 */
  Address TSO 'Altlib Act app(Exec) Dataset('exec')'
  'Libdef ISPMLIB dataset id('msgs') Stack'
  'Libdef ISPPLIB dataset id('panels') Stack'
  'Libdef ISPSLIB dataset id('skels') Stack'                  /* @AB */
RETURN
/*--------------------------------------------------------------------*/
/*  Define the ISPF Command Table to enable RFIND                @A3  */
/*--------------------------------------------------------------------*/
/*  This approach requires creating an ISPF table for the        @A3  */
/*  applications commands (RFIND).                               @A3  */
/*--------------------------------------------------------------------*/
SETUP_RFIND1:                                                 /* @A3 */
  'control errors return'                                     /* @A3 */
  'tbquery radmcmds'                                          /* @A3 */
  if (rc = 0) then return                                     /* @A3 */
  "TBCreate radmcmds names(zctverb zcttrunc zctact" ,         /* @A3 */
                     "zctdesc) replace share nowrite"         /* @A3 */
  zctverb  = "RFIND"                                          /* @A3 */
  zcttrunc = 0                                                /* @A3 */
  zctact   = "&RADMRFND"                                      /* @A3 */
  zctdesc  = "RADM User controlled Repeat Find (RFIND)"       /* @A3 */
  "TBAdd radmcmds"                                            /* @A3 */
RETURN                                                        /* @A3 */
/*--------------------------------------------------------------------*/
/*  Define the ISPF Command Table to enable RFIND                @A3  */
/*--------------------------------------------------------------------*/
/*  This approach does not require recursion or creating an      @A5  */
/*  ISPF table for the applications commands. This approach      @A5  */
/*  updates the active site command table in memory.             @A5  */
/*                                                               @A5  */
/*  This does:                                                   @A5  */
/*    1) Define the commmand table entry                         @A5  */
/*    2) vget the variable with the prefix for the site ISPF     @A5  */
/*       command table.                                          @A5  */
/*    3) Define a varable with the command table name            @A5  */
/*    4) Move to the top of the command table                    @A5  */
/*    5) Establish the table search                              @A5  */
/*    6) If the entry is found then add it                       @A5  */
/*    7) Prime the variable to null                              @A5  */
/*--------------------------------------------------------------------*/
SETUP_RFIND2:                                                 /* @A5 */
  zctverb  = "RFIND"                                          /* @A5 */
  zcttrunc = 0                                                /* @A5 */
  zctact   = "&RADMRFND"                                      /* @A5 */
  zctdesc  = "RACFADM User controlled Repeat Find (RFIND)"    /* @A5 */
  'vget (zsctpref zuctpref)'                                  /* @A8 */
  select                                                      /* @A8 */
     when (zuctpref <> '') then                               /* @A8 */
          ctab = zuctpref'cmds'                               /* @A8 */
     when (zsctpref <> '') then                               /* @A8 */
          ctab = zsctpref'cmds'                               /* @A8 */
     otherwise                                                /* @A8 */
          ctab = 'ISPcmds'                                    /* @A8 */
  end                                                         /* @A8 */
  'vget (zsctpref)'                                           /* @A5 */
  if (zsctpref = '') then zsctpref = 'ISP'                    /* @A5 */
  ctab = zsctpref'cmds'                                       /* @A5 */
  'tbtop'  ctab                                               /* @A5 */
  'tbscan' ctab 'arglist(zctact) condlist(EQ) Next'           /* @A5 */
  if (rc > 0) then 'tbadd' ctab                               /* @A5 */
  radmrfnd = null                                             /* @A5 */
  'vput (radmrfnd)'                                           /* @A5 */
RETURN                                                        /* @A5 */
