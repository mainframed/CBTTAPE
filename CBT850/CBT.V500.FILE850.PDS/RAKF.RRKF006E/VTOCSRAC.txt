//VTOCSRAC JOB (RACIND),
//             'Set RACF Indicator',
//             CLASS=A,REGION=4M,
//             MSGCLASS=X,
//             MSGLEVEL=(0,0)
//********************************************************************
//*
//* Name: VTOCSRAC
//*
//* Desc: Set RACF Indicator in VTOC ON or OFF for all datasets
//*       on all online DASDs except:
//*       - all VSAM dataspaces
//*       - all temporary datasets SYSnnnnn.Tnnnnnn.RAnnn
//*       - the PASSWORD dataset
//*
//* Note: If DASD volumes are present in your system that should not
//* ----- be modified (i.e. IPL and SPOOL volumes for other systems
//*       like START1 and SPOOL0 in TK3 systems), these should be
//*       varied offline before submitting this job.
//*
//********************************************************************
//*
//* load set awk script
//*
//LOADSET  EXEC PGM=IEBGENER
//SYSPRINT DD DUMMY
//SYSIN    DD DUMMY
//SYSUT2   DD DSN=&&SETAWK,DISP=(,PASS),UNIT=VIO,SPACE=(TRK,(5,5)),
//            DCB=(LRECL=80,BLKSIZE=800,RECFM=FB)
//SYSUT1   DD *
BEGIN {
#
### ==> BEGIN of standard customization section   <==
#
# the setracf parameter determines the action to be taken:
#   OFF --> turn all RACF indicators off
#   ON  --> turn all RACF indicators on
#
 setracf = "OFF"
#setracf = "ON"
#
### ==> END of standard customization section     <==
#
# initialize
#
 racf = "NORACF"
 if (setracf == "ON") {racf = "RACF"}
}
#
### ==> BEGIN of extended customization section   <==
#
### ==> The following patterns define the         <==
### ==> datasets to be excluded by name and would <==
### ==> not normally need any customization.      <==
#
### ==> In case any need to change the exclude    <==
### ==> list arises nonetheless, these patterns   <==
### ==> can be amended as needed.                 <==
#
#
# ignore the PASSWORD dataset AND ..
#
!/¬PASSWORD / && \
#
# .. ignore temporary datasets SYSnnnnn.Tnnnnnn.RAnnn
#
!/¬SYSÝ0-9¨Ý0-9¨Ý0-9¨Ý0-9¨Ý0-9¨\.\
TÝ0-9¨Ý0-9¨Ý0-9¨Ý0-9¨Ý0-9¨Ý0-9¨\.RAÝ0-9¨Ý0-9¨Ý0-9¨\./ \
{
#
### ==> END of extended customization section     <==
### ==> DON'T make any changes beyond this point  <==
#
#
# create CDSCB commands
#
 print "CDSCB '" $1 "' VOL(" $2 ") UNIT(SYSALLDA) SHR " racf
}
/*
//*
//* print RACF status of all none VSAM datasets on all volumes
//*
//PRTVTOC EXEC PGM=IKJEFT01,DYNAMNBR=20
//VTOCOUT  DD SYSOUT=*
//SYSTSPRT DD DUMMY
//SYSTSIN  DD *
VTOC ALL LIM(DSO NE VS) P(NEW (DSN V RA)) S(RA,D,DSN,A) -
  LIN(66) H('1RACF STATUS BEFORE CHANGE')
/*
//*
//* list all none VSAM datasets on all volumes for processing
//*
//LSTVTOC EXEC PGM=IKJEFT01,DYNAMNBR=20
//SYSTSPRT DD DSN=&&LISTCC,DISP=(,PASS),UNIT=VIO,SPACE=(TRK,(5,5))
//SYSTSIN  DD *
VTOC ALL LIM(DSO NE VS) P(NEW (DSN V)) S(DSN A) NOH
/*
//*
//* remove carriage control characters
//*
//REMOVECC EXEC PGM=MAWK,PARM='-f SCRIPT'
//SCRIPT   DD *
BEGIN         {header = 1; trailer = 0}
/¬  TOTALS -/ {trailer = 1}
              {if ((!header) && (!trailer)) print substr($0,2,80)}
/¬1VTOC ALL / {header = 0}
/*
//STDIN    DD DSN=&&LISTCC,DISP=(OLD,DELETE)
//STDOUT   DD DSN=&&LIST,DISP=(,PASS),UNIT=VIO,SPACE=(TRK,(5,5)),
//            DCB=(LRECL=80,BLKSIZE=800,RECFM=FB)
//STDERR   DD SYSOUT=*
//*
//* generate CDSCB commands
//*
//GENCDSCB EXEC PGM=MAWK,PARM='-f SCRIPT'
//SCRIPT   DD DSN=&&SETAWK,DISP=(OLD,DELETE)
//STDIN    DD DSN=&&LIST,DISP=(OLD,DELETE)
//STDOUT   DD DSN=&&CDSCB,DISP=(,PASS),UNIT=VIO,SPACE=(TRK,(5,5)),
//            DCB=(LRECL=80,BLKSIZE=800,RECFM=FB)
//STDERR   DD SYSOUT=*
//*
//* execute CDSCB commands to change RACF indicator
//*
//RACIND  EXEC PGM=IKJEFT01,DYNAMNBR=20
//SYSTSPRT DD SYSOUT=*
//SYSTSIN  DD DSN=&&CDSCB,DISP=(OLD,DELETE)
//*
//* print RACF status of all none VSAM datasets on all volumes
//*
//PRTVTOC EXEC PGM=IKJEFT01,DYNAMNBR=20
//VTOCOUT  DD SYSOUT=*
//SYSTSPRT DD DUMMY
//SYSTSIN  DD *
VTOC ALL LIM(DSO NE VS) P(NEW (DSN V RA)) S(RA,D,DSN,A) -
  LIN(66) H('1RACF STATUS AFTER CHANGE')
/*
//
