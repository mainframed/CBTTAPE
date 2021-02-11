//VSAMSRAC JOB (RACIND),
//             'Set RACF Indicator',
//             CLASS=A,REGION=4M,
//             MSGCLASS=X,
//             MSGLEVEL=(0,0)
//********************************************************************
//*
//* Name: VSAMSRAC
//*
//* Desc: Set RACF Indicator ON or OFF for all VSAM Objects
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
### ==> BEGIN of customization section           <==
#
# the setracf parameter determines the action to be taken:
#   OFF --> turn all RACF indicators off
#   ON  --> turn all RACF indicators on
#
 setracf = "OFF"
#setracf = "ON"
#
### ==> END of customization section             <==
### ==> DON'T make any changes beyond this point <==
#
#
# initialize
#
 catalog = "none"
}
#
# check page header for new catalog and
# generate CATALOG control statement if necessary
#
/LISTING FROM CATALOG --/ {
 if (catalog != $6) {
  catalog = $6
  printf("CATALOG   %-44s\n",catalog)
 }
}
#
# set entry name if VSAM object is found
# and is not catalog data or index
#
/CLUSTER /   {entry = $3}
/0   DATA /  {entry = $4}
/0   INDEX / {entry = $4}
/PAGESPACE / {entry = $3}
/PATH /      {entry = $3}
#
# generate RACxxx control statement if RACF indicator is found
#
/RACF/ {
 if ((entry != "VSAM.CATALOG.BASE.DATA.RECORD") &&
     (entry != "VSAM.CATALOG.BASE.INDEX.RECORD")) {
  printf("RAC%-7s%-44s\n",setracf,entry)
 }
}
/*
//*
//* load list awk script
//*
//LOADLST  EXEC PGM=IEBGENER
//SYSPRINT DD DUMMY
//SYSIN    DD DUMMY
//SYSUT2   DD DSN=&&LSTAWK,DISP=(,PASS),UNIT=VIO,SPACE=(TRK,(5,5)),
//            DCB=(LRECL=80,BLKSIZE=800,RECFM=FB)
//SYSUT1   DD *
#
# initialize
#
BEGIN {
 line = "+-----------+--------------------------------------------+----+"
 catalog = "none"
}
#
# check page header for new catalog and start new table if necessary
#
/LISTING FROM CATALOG --/ {
 if (catalog != $6) {
  if (catalog != "none") {print line}
  catalog = $6
  print " "
  print "Catalog: " catalog
  print " "
  print line
  printf("¦%-11s¦%-44s¦%-4s\n","Type","Name","RACF¦")
 }
}
#
# set entry type and name if VSAM object is found
#
/CLUSTER /   {type = "Cluster";   entry = $3}
/0   DATA /  {type = "Data";      entry = $4}
/0   INDEX / {type = "Index";     entry = $4}
/PAGESPACE / {type = "Pagespace"; entry = $3}
/PATH /      {type = "Path";      entry = $3}
#
# print table entry if RACF indicator is found
#
/RACF/ {
 racf = "yes"
 if (index(substr($0,index($0,"RACF")),"YES") == 0) {racf = "no"}
 print line
 printf("¦%-11s¦%-44s¦%-3s ¦\n",type,entry,racf)
}
#
# finish last table
#
END {print line}
/*
//*
//* list all usercatalogs
//*
//LISTUCAT EXEC PGM=IDCAMS
//SYSPRINT DD DSN=&&UCAT,DISP=(,PASS),UNIT=VIO,SPACE=(TRK,(1,1))
//SYSIN    DD *
 LISTCAT UCAT
/*
//*
//* create IDCAMS 'LISTCAT ALL' commands for all catalogs
//*
//AMSINPUT EXEC PGM=MAWK,PARM='-f SCRIPT'
//SCRIPT   DD *
BEGIN           {print " LISTCAT ALL"}
/0USERCATALOG / {print " LISTCAT ALL CAT(" $3 ")"}
/*
//STDIN    DD DSN=&&UCAT,DISP=(OLD,DELETE)
//STDOUT   DD DSN=&&CAT,DISP=(,PASS),UNIT=VIO,SPACE=(TRK,(5,5)),
//            DCB=(LRECL=80,BLKSIZE=800,RECFM=FB)
//STDERR   DD SYSOUT=*
//*
//* list all entries in all catalogs before RACIND
//*
//LSTBEFOR EXEC PGM=IDCAMS
//SYSIN    DD DSN=&&CAT,DISP=(OLD,PASS)
//SYSPRINT DD DSN=&&LIST,DISP=(,PASS),UNIT=VIO,SPACE=(TRK,(5,5))
//*
//* print all VSAM entries with their RACF indicator status
//*
//PRTBEFOR EXEC PGM=MAWK,PARM='-f SCRIPT'
//SCRIPT   DD DSN=&&LSTAWK,DISP=(OLD,PASS)
//STDIN    DD DSN=&&LIST,DISP=(OLD,PASS)
//STDOUT   DD SYSOUT=*
//STDERR   DD SYSOUT=*
//*
//* create RACIND control statements
//*
//MAKEIND  EXEC PGM=MAWK,PARM='-f SCRIPT'
//SCRIPT   DD DSN=&&SETAWK,DISP=(OLD,DELETE)
//STDIN    DD DSN=&&LIST,DISP=(OLD,PASS)
//STDOUT   DD DSN=&&RACIND,DISP=(,PASS),UNIT=VIO,SPACE=(TRK,(5,5)),
//            DCB=(LRECL=80,BLKSIZE=800,RECFM=FB)
//STDERR   DD SYSOUT=*
//*
//* print RACIND control statements
//*
//PRINTIND EXEC PGM=IEBGENER
//SYSPRINT DD DUMMY
//SYSIN    DD DUMMY
//SYSUT1   DD DSN=&&RACIND,DISP=(OLD,PASS)
//SYSUT2   DD SYSOUT=*
//*
//* execute RACIND utility to set or unset RACF indicators
//*
//RACIND  EXEC PGM=RACIND
//SYSPRINT DD  SYSOUT=*
//SYSIN    DD  DSN=&&RACIND,DISP=(OLD,DELETE)
//*
//* list all entries in all catalogs after RACIND
//*
//LSTAFTER EXEC PGM=IDCAMS
//SYSIN    DD DSN=&&CAT,DISP=(OLD,DELETE)
//SYSPRINT DD DSN=&&LIST,DISP=(OLD,PASS)
//*
//* print all VSAM entries with their RACF indicator status
//*
//PRTAFTER EXEC PGM=MAWK,PARM='-f SCRIPT'
//SCRIPT   DD DSN=&&LSTAWK,DISP=(OLD,DELETE)
//STDIN    DD DSN=&&LIST,DISP=(OLD,DELETE)
//STDOUT   DD SYSOUT=*
//STDERR   DD SYSOUT=*
//
