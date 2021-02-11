To use the DRDASD asm mod, you will need a couple of REXX execs.

First you need an exec that calls the assembly mod:

We will call this guy T2.  He is located in my PDS SYS0.DRDASD.TEXT(T2)
/*REXX*/
    call 'DRDASD'
    ReturnCode = RC
    return ReturnCode

That will do just fine.  Second, you need an exec that will call the
exec that calls the assembly mod.  In this example, it simply displays
the results returned and does not interpret them and format a nice
report, but that isn't too tough to do as the results are REXX
statements that can be interpreted:

We will call this guy T1.  He is located in my PDS TEST.REXX.CNTL(T1)
/*REXX*/
    x = outtrap('OutArray.',,'NOCONCAT')
    call 'T2'
    x = outtrap('OFF')
    do i = 1 to OutArray.0
       say OutArray.i
    end
exit


These two execs, in combination with the DRDASD asm mod, should report
on all of the DASD that is online to that LPAR.  Here is the JCL needed
to run it and some stuff back.  The DRDASD asm mod is in
SYS0.DRDASD.LOADLIB in my shop.  You will find this JCL in member JCL1
of this PDS.

//DRDASDTS JOB (PAOZ,,100,100),ROB,CLASS=D,MSGCLASS=X,
//  REGION=4M,NOTIFY=&SYSUID,COND=(4,LT) TYPRUN=HOLD
//*
//STEP10   EXEC PGM=IKJEFT01
//STEPLIB  DD  DSN=SYS0.DRDASD.LOADLIB,DISP=SHR
//SYSEXEC  DD  DSN=TEST.REXX.CNTL,DISP=SHR
//SYSTSPRT DD  SYSOUT=*
//SYSTSIN  DD *
    T1
//*

The output from this job should look something like this:

$ICONFIGURATION NEW DRDASD
$DV='DB2S01'; D='1001'
$DV='DB2S01'; FC=0000000000000615; FT=0000000000000345
$DV='DB2S01'; FE=0000000000000079
$DV='DB2S01'; LC=0000000000000097; LT=0000000000000006
$DV='DB2S01'; VIX='Y'; VIXS='E'; SMSM='N'
$DV='DB2S01'; SC=0000; ST=0003; EC=0002; ET=0002; VT=0030
$DV='HSM001'; D='1003'
$DV='HSM001'; FC=0000000000001017; FT=0000000000000056
$DV='HSM001'; FE=0000000000000015
$DV='HSM001'; LC=0000000000000712; LT=0000000000000000
$DV='HSM001'; VIX='Y'; VIXS='E'; SMSM='N'
$DV='HSM001'; SC=1300; ST=0000; EC=1306; ET=0014; VT=0105
$DV='DB2D04'; D='104B'
$DV='DB2D04'; FC=0000000000000488; FT=0000000000000020
$DV='DB2D04'; FE=0000000000000007
$DV='DB2D04'; LC=0000000000000261; LT=0000000000000000
$DV='DB2D04'; VIX='Y'; VIXS='E'; SMSM='Y'
$DV='DB2D04'; SC=0000; ST=0001; EC=0007; ET=0000; VT=0105
$DV='DB2D07'; D='104C'
$DV='DB2D07'; FC=0000000000001008; FT=0000000000000005
$DV='DB2D07'; FE=0000000000000003
$DV='DB2D07'; LC=0000000000000619; LT=0000000000000000
$DV='DB2D07'; VIX='Y'; VIXS='E'; SMSM='Y'
$DV='DB2D07'; SC=0000; ST=0001; EC=0004; ET=0000; VT=0060
$DV='MVSRS3'; D='2581'
$DV='MVSRS3'; FC=0000000000002470; FT=0000000000000016
$DV='MVSRS3'; FE=0000000000000006
$DV='MVSRS3'; LC=0000000000002470; LT=0000000000000000
$DV='MVSRS3'; VIX='N'; VIXS='E'; SMSM='N'
$DV='MVSRS3'; SC=0000; ST=0001; EC=0003; ET=0000; VT=0045
$DV='MQP001'; D='2582'
$DV='MQP001'; FC=0000000000007189; FT=0000000000000014
$DV='MQP001'; FE=0000000000000005
$DV='MQP001'; LC=0000000000006782; LT=0000000000000000
$DV='MQP001'; VIX='N'; VIXS='E'; SMSM='N'
$DV='MQP001'; SC=0000; ST=0001; EC=0005; ET=0014; VT=0089
$DV='PUBP02'; D='2583'
$DV='PUBP02'; FC=0000000000009971; FT=0000000000000009
$DV='PUBP02'; FE=0000000000000003
$DV='PUBP02'; LC=0000000000009971; LT=0000000000000000
$DV='PUBP02'; VIX='Y'; VIXS='E'; SMSM='N'
$DV='PUBP02'; SC=0000; ST=0001; EC=0006; ET=0000; VT=0090
$ISUCCESSFUL DRDASD

To interpret this stuff, first, any time you see
$ICONFIGURATION NEW DRDASD, start over.  At that point, there has been
a change in the configuration and the DRDASD mod started over reading
the dynamic UCBs from the top.  There are 3 types of message.
$I - informational, $W - Warning, $E - Error and $D - Data.
If you have a $D message, strip the first 2 characters off and
interpret the line to use the REXX variables.  The variables can
be interpreted as follows: V is volser, D is device, FC is free
cylinders, FT is free tracks, FE is free extents, LC is largest
contiguous free cylinders, LT is largest contiguous tracks (add
this to LC * 15 if you want total largest contiguous tracks), VIX
is VTOC index (yes or no), VIXS is VTOC index status (enabled or
disabled), SMSM is SMS managed (yes or no), SC is absolute starting
cylinder for the VTOC, ST is absolute starting track for the VTOC,
EC is absolute ending cylinder for the VTOC, ET is extra terrestrial,
kidding, absolute ending track for VTOC, and VT is the total VTOC
allocation in tracks.

JCL2 of this PDS executes exec R1 which calls T2 to get DRDASD to run.
The results are returned and interpreted into variables and a basic
formated report is created in and sent to DD OUTFILE.

You can email me with questions at rob.johns@anpac.com
Thanks Sam!


