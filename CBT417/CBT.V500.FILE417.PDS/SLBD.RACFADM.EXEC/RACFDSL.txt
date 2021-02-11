/*%NOCOMMENT====================* REXX *==============================*/
/*  PURPOSE:  RACFADM - Dataset List - Menu option D                  */
/*--------------------------------------------------------------------*/
/*  NOTES:    1) This utility will obtain the LIBDEF/ALTLIB dataset   */
/*               names and if the high level qualifiers are identical */
/*               in all three datasets (panel, message and REXX), it  */
/*               it will invoke ISPF 3.4 Dataset list, displaying the */
/*               datasets                                             */
/*--------------------------------------------------------------------*/
/* FLG  YYMMDD  USERID   DESCRIPTION                                  */
/* ---  ------  -------  -------------------------------------------- */
/* @A5  200504  RACFA    Missing continuation (comma) in long msg     */
/* @A4  200423  RACFA    Move PARSE REXXPGM name up above IF SETMTRAC */
/* @A3  200423  RACFA    Ensure REXX program name is 8 chars long     */
/* @A2  200420  RACFA    Verify last level qualifier is not blank/null*/
/* @A1  200420  RACFA    Removed single quote of REXX/CLIST dsname    */
/* @A0  200419  RACFA    Created REXX                                 */
/*====================================================================*/
parse source . . REXXPGM .         /* Obtain REXX pgm name */ /* @A4 */
REXXPGM     = LEFT(REXXPGM,8)                                 /* @A4 */

ADDRESS ISPEXEC
  "VGET (SETMTRAC) PROFILE"
  If (SETMTRAC <> 'NO') then do
     Say "*"COPIES("-",70)"*"
     Say "*"Center("Begin Program = "REXXPGM,70)"*"
     Say "*"COPIES("-",70)"*"
     if (SETMTRAC <> 'PROGRAMS') THEN
        interpret "Trace "SUBSTR(SETMTRAC,1,1)
  end

  call Get_clist_dsn
  "QLIBDEF ISPPLIB TYPE(DATASET) ID(DSNPAN)"
  "QLIBDEF ISPMLIB TYPE(DATASET) ID(DSNMSG)"

  DSNREX = STRIP(DSNREX,,"'")                                 /* @A1 */
  DSNPAN = STRIP(DSNPAN,,"'")
  DSNMSG = STRIP(DSNMSG,,"'")
  PARSE VAR DSNREX R1 "." R2 "." R3 "." R4 "." R5 "." .
  PARSE VAR DSNPAN P1 "." P2 "." P3 "." P4 "." P5 "." .
  PARSE VAR DSNMSG M1 "." M2 "." M3 "." M4 "." M4 "." .

  SELECT
     WHEN (R5 <> '') & (R5 = P5) & (R5 = M5) THEN             /* @A2 */
          DSNAME = R1"."R2"."R3"."R4"."R5
     WHEN (R4 <> '') & (R4 = P4) & (R4 = M4) THEN             /* @A2 */
          DSNAME = R1"."R2"."R3"."R4
     WHEN (R3 <> '') & (R3 = P3) & (R3 = M3) THEN             /* @A2 */
          DSNAME = R1"."R2"."R3
     WHEN (R2 <> '') & (R2 = P2) & (R2 = M2) THEN             /* @A2 */
          DSNAME = R1"."R2
     WHEN (R1 <> '') & (R1 = P1) & (R1 = M1) THEN             /* @A2 */
          DSNAME = R1
     OTHERWISE
          DSNAME = ""
  END

  IF (DSNAME = "") THEN DO
     racfsmsg = "Error - No DSNs"
     racflmsg = "Unable to determine RACFADM's",
                "LIBDEF/ALTLIB dataset names,",               /* @A5 */
                "due to the HLQ name is different",
                "on the panel, message or REXX",
                "dataset"
     "SETMSG MSG(RACF011)"
  END
  ELSE
     "SELECT PGM(ISRDSLST) PARM(DSL '"DSNAME"')",
             "SUSPEND SCRNAME(RACFADM)"

  If (SETMTRAC <> 'NO') then do
     Say "*"COPIES("-",70)"*"
     Say "*"Center("End Program = "REXXPGM,70)"*"
     Say "*"COPIES("-",70)"*"
  end
EXIT
/*--------------------------------------------------------------------*/
/*  Get CLIST dataset name                                            */
/*--------------------------------------------------------------------*/
/*  1) The 'ALTLIB DISPLAY' statement, will look for                  */
/*     'Application-level' in the display in order to obtain          */
/*     the DDname of the ALTLIBed dataset                             */
/*       Current search order (by DDNAME) is:                         */
/*       Application-level CLIST DDNAME=SYS00529                      */
/*       System-level EXEC       DDNAME=SYSEXEC                       */
/*       System-level CLIST      DDNAME=SYSPROC                       */
/*  2) The 'LISTA STATUS' will display all the DDnames and datasets   */
/*     allocated, allowing the capability to obtain the dataset name  */
/*     allocated to the 'Application-level CLIST' ddname (SYS#####)   */
/*--------------------------------------------------------------------*/
GET_CLIST_DSN:
  X = OUTTRAP("REC.")
  ADDRESS TSO "ALTLIB DISPLAY"
  X = OUTTRAP("OFF")

  IF (SUBSTR(REC.2,1,3) = "IKJ") THEN
     PARSE VAR REC.2 . W1 W2 "DDNAME="DDALTLIB
  ELSE
     PARSE VAR REC.2 W1 W2 "DDNAME="DDALTLIB
  DROP REC.
  RC = 0
  IF (W1 <> "Application-level") THEN DO
     RC = 8
     return
  END

  X = OUTTRAP("REC.")
  ADDRESS TSO "LISTA STATUS"
  X = OUTTRAP("OFF")
  do J = 1 TO REC.0
     PARSE VAR REC.J W1 .
     IF (W1 = DDALTLIB) THEN DO
        K = J - 1
        DSNREX = REC.K
        LEAVE
     END
  end
  DROP REC. W1 DDALTLIB
RETURN
