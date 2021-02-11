//RAKFRMV  JOB (RAKF),
//             'RAKF Removal',
//             CLASS=A,
//             MSGCLASS=X,
//             REGION=8192K,
//             MSGLEVEL=(1,1)
//* ------------------------------------------------------------------*
//* Remove RAKF 1.2.0                                                 *
//*                                                                   *
//*   /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/     *
//*   Danger!!! Danger!!! Danger!!! Danger!!! Danger!!! Danger!!!     *
//*   \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\     *
//*                                                                   *
//*  This job is to be used for RAKF removal only if RAKF is in       *
//*  ACCEPTed state. If RAKF is APPLIed but not ACCEPTed use the      *
//*  the SMP command "RESTORE S(TRKF120)" instead of this job         *
//*  to remove it.                                                    *
//*                                                                   *
//*  After RAKF removal the system is NOT IPLable until the original  *
//*  MVS stub modules have been reinstated. Refer to job RAKF2MVS     *
//*  for reinstating these modules                                    *
//*                                                                   *
//*   /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/     *
//*   Danger!!! Danger!!! Danger!!! Danger!!! Danger!!! Danger!!!     *
//*   \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\     *
//*                                                                   *
//*                                                                   *
//* Expected return codes: Step UCLIN:    00                          *
//* Expected return codes: Step SCRATCH:  00                          *
//* ------------------------------------------------------------------*
//*
//* ------------------------------------------------------------------*
//* Remove RAKF elements from SMP                                     *
//* ------------------------------------------------------------------*
//UCLIN   EXEC SMPAPP
//SMPCNTL  DD  *
 UCLIN CDS .
  DEL LMOD(ICHRIN00) .
  DEL LMOD(ICHSEC00) .
  DEL LMOD(ICHSFR00) .
  DEL LMOD(RACIND)   .
  DEL LMOD(RAKFPROF) .
  DEL LMOD(RAKFPWUP) .
  DEL LMOD(RAKFUSER) .
  DEL  MOD(CJYRCVT)  .
  DEL  MOD(ICHRIN00) .
  DEL  MOD(ICHSEC00) .
  DEL  MOD(ICHSFR00) .
  DEL  MOD(IGC0013A) .
  DEL  MOD(IGC0013C) .
  DEL  MOD(IGC00130) .
  DEL  MOD(RACIND)   .
  DEL  MOD(RAKFPROF) .
  DEL  MOD(RAKFPSAV) .
  DEL  MOD(RAKFPWUP) .
  DEL  MOD(RAKFUSER) .
  DEL  SRC(CJYRCVT)  .
  DEL  SRC(ICHRIN00) .
  DEL  SRC(ICHSEC00) .
  DEL  SRC(ICHSFR00) .
  DEL  SRC(IGC0013A) .
  DEL  SRC(IGC0013C) .
  DEL  SRC(IGC00130) .
  DEL  SRC(RACIND)   .
  DEL  SRC(RAKFPROF) .
  DEL  SRC(RAKFPSAV) .
  DEL  SRC(RAKFPWUP) .
  DEL  SRC(RAKFUSER) .
  DEL  MAC($$$$$DOC) .
  DEL  MAC($$$$INFO) .
  DEL  MAC($$COPYRT) .
  DEL  MAC($$NOTICE) .
  DEL  MAC($DOC$ZIP) .
  DEL  MAC(A@PREP)   .
  DEL  MAC(AUXINST)  .
  DEL  MAC(AUXUTILS) .
  DEL  MAC(B@RECV)   .
  DEL  MAC(C@APPLY)  .
  DEL  MAC(D@ACCPT)  .
  DEL  MAC(LPABACK)  .
  DEL  MAC(LPAREST)  .
  DEL  MAC(MINPRF)   .
  DEL  MAC(MINUSR)   .
  DEL  MAC(RACIND)   .
  DEL  MAC(RAKFRMV)  .
  DEL  MAC(RAKF2MVS) .
  DEL  MAC(TK3USR)   .
  DEL  MAC(ZAPMVS38) .
  DEL  MAC(ZJW0003)  .
  DEL  MAC(CJYPCBLK) .
  DEL  MAC(CJYRCVTD) .
  DEL  MAC(CJYUCBLK) .
  DEL  MAC(IEZCTGFL) .
  DEL  MAC(INITPWUP) .
  DEL  MAC(INITTBLS) .
  DEL  MAC(YREGS)    .
  DEL  MAC(RAKF)     .
  DEL  MAC(RAKFPROF) .
  DEL  MAC(RAKFPWUP) .
  DEL  MAC(RAKFUSER) .
  DEL  MAC(RAKFINIT) .
  DEL  MAC(VSAMLRAC) .
  DEL  MAC(VSAMSRAC) .
  DEL  MAC(VTOCLRAC) .
  DEL  MAC(VTOCSRAC) .
  DEL  SYSMOD(RRKF001) .
  DEL  SYSMOD(RRKF002) .
  DEL  SYSMOD(RRKF003) .
  DEL  SYSMOD(RRKF004) .
  DEL  SYSMOD(RRKF005) .
  DEL  SYSMOD(RRKF006) .
  DEL  SYSMOD(TRKF120) .
 ENDUCL .
 UCLIN ACDS .
  DEL  SRC(CJYRCVT)  .
  DEL  SRC(ICHRIN00) .
  DEL  SRC(ICHSEC00) .
  DEL  SRC(ICHSFR00) .
  DEL  SRC(IGC0013A) .
  DEL  SRC(IGC0013C) .
  DEL  SRC(IGC00130) .
  DEL  SRC(RACIND)   .
  DEL  SRC(RAKFPROF) .
  DEL  SRC(RAKFPSAV) .
  DEL  SRC(RAKFPWUP) .
  DEL  SRC(RAKFUSER) .
  DEL  MAC($$$$$DOC) .
  DEL  MAC($$$$INFO) .
  DEL  MAC($$COPYRT) .
  DEL  MAC($$NOTICE) .
  DEL  MAC($DOC$ZIP) .
  DEL  MAC(A@PREP)   .
  DEL  MAC(AUXINST)  .
  DEL  MAC(AUXUTILS) .
  DEL  MAC(B@RECV)   .
  DEL  MAC(C@APPLY)  .
  DEL  MAC(D@ACCPT)  .
  DEL  MAC(LPABACK)  .
  DEL  MAC(LPAREST)  .
  DEL  MAC(MINPRF)   .
  DEL  MAC(MINUSR)   .
  DEL  MAC(RACIND)   .
  DEL  MAC(RAKFRMV)  .
  DEL  MAC(RAKF2MVS) .
  DEL  MAC(TK3USR)   .
  DEL  MAC(ZAPMVS38) .
  DEL  MAC(ZJW0003)  .
  DEL  MAC(CJYPCBLK) .
  DEL  MAC(CJYRCVTD) .
  DEL  MAC(CJYUCBLK) .
  DEL  MAC(IEZCTGFL) .
  DEL  MAC(INITPWUP) .
  DEL  MAC(INITTBLS) .
  DEL  MAC(YREGS)    .
  DEL  MAC(RAKF)     .
  DEL  MAC(RAKFPROF) .
  DEL  MAC(RAKFPWUP) .
  DEL  MAC(RAKFUSER) .
  DEL  MAC(RAKFINIT) .
  DEL  MAC(VSAMLRAC) .
  DEL  MAC(VSAMSRAC) .
  DEL  MAC(VTOCLRAC) .
  DEL  MAC(VTOCSRAC) .
  DEL  SYSMOD(RRKF001) .
  DEL  SYSMOD(RRKF002) .
  DEL  SYSMOD(RRKF003) .
  DEL  SYSMOD(RRKF004) .
  DEL  SYSMOD(RRKF005) .
  DEL  SYSMOD(RRKF006) .
  DEL  SYSMOD(TRKF120) .
 ENDUCL .
/*
//* ------------------------------------------------------------------*
//* Remove RAKF elements from LINKLIB, LPALIB, PARMLIB and PROCLIB    *
//* ------------------------------------------------------------------*
//SCRATCH EXEC PGM=IEHPROGM
//SYSPRINT DD  SYSOUT=*
//DD1      DD  VOL=SER=rrrrrr,DISP=OLD,UNIT=tttt
//SYSIN    DD  *
   SCRATCH VOL=tttt=rrrrrr,DSNAME=SYS1.LPALIB,MEMBER=ICHSFR00
   SCRATCH VOL=tttt=rrrrrr,DSNAME=SYS1.LPALIB,MEMBER=IGC0013A
   SCRATCH VOL=tttt=rrrrrr,DSNAME=SYS1.LPALIB,MEMBER=IGC0013B
   SCRATCH VOL=tttt=rrrrrr,DSNAME=SYS1.LPALIB,MEMBER=IGC0013C
   SCRATCH VOL=tttt=rrrrrr,DSNAME=SYS1.LPALIB,MEMBER=IGC0013{
   SCRATCH VOL=tttt=rrrrrr,DSNAME=SYS1.LPALIB,MEMBER=ICHRIN00
   SCRATCH VOL=tttt=rrrrrr,DSNAME=SYS1.LINKLIB,MEMBER=ICHSEC00
   SCRATCH VOL=tttt=rrrrrr,DSNAME=SYS1.LINKLIB,MEMBER=RACIND
   SCRATCH VOL=tttt=rrrrrr,DSNAME=SYS1.LINKLIB,MEMBER=RAKFPROF
   SCRATCH VOL=tttt=rrrrrr,DSNAME=SYS1.LINKLIB,MEMBER=RAKFUSER
   SCRATCH VOL=tttt=rrrrrr,DSNAME=SYS1.LINKLIB,MEMBER=RAKFPWUP
   SCRATCH VOL=tttt=rrrrrr,DSNAME=SYS1.PROCLIB,MEMBER=RAKF
   SCRATCH VOL=tttt=rrrrrr,DSNAME=SYS1.PROCLIB,MEMBER=RAKFPROF
   SCRATCH VOL=tttt=rrrrrr,DSNAME=SYS1.PROCLIB,MEMBER=RAKFPWUP
   SCRATCH VOL=tttt=rrrrrr,DSNAME=SYS1.PROCLIB,MEMBER=RAKFUSER
   SCRATCH VOL=tttt=rrrrrr,DSNAME=SYS1.PARMLIB,MEMBER=RAKFINIT
/*
//
