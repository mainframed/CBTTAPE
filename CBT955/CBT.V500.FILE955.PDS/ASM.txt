//Z90008A JOB (0),JMILLER,CLASS=A,NOTIFY=&SYSUID,MSGCLASS=T,REGION=64M
/*JOBPARM L=999999
//*-------------------------------------------------------------------
//* COMPILE AND LINK RMTLOG
//*-------------------------------------------------------------------
//* 12/09/2010 John C. Miller
//*-------------------------------------------------------------------
//* RMTLOG Remote logging program copyright 2010-2017 John C. Miller.
//*-------------------------------------------------------------------
//* Fix the jobcard as appropriate.  Then set the following values to
//* something appropriate for your site, and run this job.
//*-------------------------------------------------------------------
// JCLLIB ORDER=USER03.RMTLOG.V01B      <-- Name of this install PDS.
// SET  INSTLIB=USER03.RMTLOG.V01B      <-- Name of this install PDS.
// SET  LINKLIB=SYS2.LINKLIB            <-- Name of target loadlib.
// SET  SEZACMAC=TCPIP.SEZACMAC         <-- Your TCPIP SEZACMAC.
// SET  SEZATCP=TCPIP.SEZATCP           <-- Your TCPIP SEZATCP.
//*-------------------------------------------------------------------
//IPADDR   EXEC ASM$,M=IPADDR
//JULIAN   EXEC ASM$,M=JULIAN
//RECON    EXEC ASM$,M=RECON
//RLCLOS   EXEC ASM$,M=RLCLOS
//RLINIT1  EXEC ASM$,M=RLINIT1
//RLINIT2  EXEC ASM$,M=RLINIT2
//RLWRITE  EXEC ASM$,M=RLWRITE
//RMTLOG   EXEC ASM$,M=RMTLOG
/*
