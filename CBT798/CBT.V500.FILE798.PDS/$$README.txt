//**********************************************************************
//*                   Notice.                                          *
//*    The JCS include to part, one for Master Scheduler System,other  *
//* for AP Scheduler System.                                           *
//*    Master Scheduler System mainly use for automaticly triggering   *
//* a JOB at specified time as you set in Master scheduler file.       *
//* You CAN'T define dependency with Master scheduler system.          *
//*    AP Scheduler System mainly use for running appplication         *
//* batch JOB.You CAN define dependency within AP Scheduler System.    *
//* AP Scheduler System can't run a set of bath job as you defined.    *
//*                      /============\                                *
//*                      |  RBS00007  |                                *
//*                      \============/                                *
//*                      ||         ||                                 *
//*                      ||         ||                                 *
//*                      ||         ||                                 *
//*              /============\ /============\                         *
//*              |  RBS00008  | |  RBS00009  |                         *
//*              \============/ \============/                         *
//*                      ||         ||                                 *
//*                      =============                                 *
//*                            ||                                      *
//*                      /============\                                *
//*                      |  RBS00011  |                                *
//*                      \============/                                *
//*   As above dependency you can run RBS00008 only if finished the    *
//* RBS00007, and can RBS00011 only after finished the RBS00008 and    *
//* RBS00009.                                                          *
//*==================================================================== KDS08257
//*||Member   || Desc                                                || KDS08257
//*||================================================================|| KDS08257
//*||$$README || ME!!                                                || KDS08257
//*||$CRTRACF || Create JCS special user                             || KDS08257
//*||$DEFRES  || Define JCS special started class                    || KDS08257
//*||$JCSRERA || Re run AP batch                                     || KDS08257
//*||$JOBFLOW || Sample Job flow                                     || KDS08257
//*||$RUNAPSB || Run AP batch                                        || KDS08257
//*||$RUNCKAP || Run Checking AP system file                         || KDS08257
//*||$RUNMAST || Run Master Schudler System                          || KDS08257
//*||$RUNRERM || Re run Master Schudler System                       || KDS08257
//*||$SRTQSAM || Sort all vsam to QSAM(bakup)                        || KDS08257
//*||CHKSTEP  || Check job return code                               || KDS08257
//*||DTCCNTL  || Copybook for date control file(QSAM)                || KDS08257
//*||JCSBABDA || Process after AP system abend                       || KDS08257
//*||JCSBABDM || Process after Mastrer system abend                  || KDS08257
//*||JCSBAPNM || Process after AP system return with acceptable rc   || KDS08257
//*||JCSBAPSB || AP system start batch                               ||    KDS08
//*||JCSBBEGN || Place time stamp in ap control file                 ||    KDS08
//*||JCSBCKAP || Check AP system file                                ||    KDS08
//*||JCSBMAST || Master scheduler main program                       ||    KDS08
//*||JCSBRERM || Successive processing if abend for Master scheduler ||    KDS08
//*||JCSBWELM || Successive processing if normal for Master scheduler||    KDS08
//*||JCSPABDA || JOB PROC for AP system abend                        ||    KDS08
//*||JCSPABDM || JOB PROC for Mastrer system abend                   ||    KDS08
//*||JCSPBEGN || JOB PROC for placing time stamp in ap control file  ||    KDS08
//*||JCSPBGAP || JOB PROC for starting beginning ap batch            ||    KDS08
//*||JCSPCHK  || JOB PROC for checking return code                   ||    KDS08
//*||JCSPDELT || JOB PROC for delete QSAM files                      ||    KDS08
//*||JCSPVSAM || JOB PROC for Verifing VSAM files                    ||    KDS08
//*||JCSPWARA || JOB PROC for AP System warning                      ||    KDS08
//*||JCSPWARM || JOB PROC for master System warning                  ||    KDS08
//*||JCSPWELA || JOB PROC for AP System normal                       ||    KDS08
//*||JCSCWK00 || Copybook                                            ||    KDS08
//*||JCSCWK01 || Copybook                                            ||    KDS08
//*||JCSCWK02 || Copybook                                            || KDS08257
//*||JCSCWK03 || Copybook                                            || KDS08257
//*||JCSCWK04 || Copybook                                            || KDS08257
//*||JCSCWK05 || Copybook                                            || KDS08257
//*||JCSCWK06 || Copybook                                            || KDS08257
//*||JCSCWK07 || Copybook                                            || KDS08257
//*||JCSCWK08 || Copybook                                            || KDS08257
//*||JCSCWK09 || Copybook                                            || KDS08257
//*||JCSCWK10 || Copybook                                            || KDS08257
//*||JCSCWK11 || Copybook                                            || KDS08257
//*||JCSCWK12 || Copybook                                            || KDS08257
//*||JCSCWK13 || Copybook                                            || KDS08257
//*||JCSCWK14 || Copybook                                            || KDS08257
//*||JCSCWK15 || Copybook                                            || KDS08257
//*||JCSCWK16 || Copybook                                            || KDS08257
//*||JCSCMAST || Copybook                                            || KDS08257
//*||JCSCCHCK || Copybook                                            || KDS08257
//*||JCSCFRAM || Copybook                                            || KDS08257
//*||JCSCJBST || Copybook                                            || KDS08257
//*||JCSCJOBH || Copybook                                            || KDS08257
//*||$CRTVSAM || Create VSAM files JOB                               || KDS08257
//*||$RUNAPSB || AP start JOB                                        || KDS08257
//*||$RUNCKAP || Check AP system file                                || KDS08257
//*||$RUNMAST || Master start JOB                                    || KDS08257
//*||$RUNRERA || JOB rerun JOB-AP                                    || KDS08257
//*||$RUNRERM || JOB rerun JOB-Master                                || KDS08257
//*||JCSFAPSB || Sample AP Scheduler file(XMIT format)               || KDS08257
//*||JCSFJOBH || Job Head file(XMIT format)                          || KDS08257
//*||JCSFMAST || Sample Master Scheduler file(XMIT format)           || KDS08257
//*||JCSFSTEP || Sample Job step filer(XMIT format)                  || KDS08257
//*||LOADXMIT || Loadmodule file(XMIT format)                        || KDS08257
========================================================================KDS08257
