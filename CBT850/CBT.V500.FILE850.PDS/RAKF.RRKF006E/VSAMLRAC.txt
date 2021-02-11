//VSAMLRAC JOB (RACIND),
//             'Set RACF Indicator',
//             CLASS=A,REGION=4M,
//             MSGCLASS=X,
//             MSGLEVEL=(0,0)
//********************************************************************
//*
//* Name: VSAMLRAC
//*
//* Desc: List RACF Indicator Status of all VSAM Objects
//*
//********************************************************************
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
//* list all entries in all catalogs
//*
//LISTCAT  EXEC PGM=IDCAMS
//SYSIN    DD DSN=&&CAT,DISP=(OLD,DELETE)
//SYSPRINT DD DSN=&&LIST,DISP=(,PASS),UNIT=VIO,SPACE=(TRK,(5,5))
//*
//* print all VSAM entries with their RACF indicator status
//*
//LISTRACF EXEC PGM=MAWK,PARM='-f SCRIPT'
//SCRIPT   DD DSN=&&LSTAWK,DISP=(OLD,DELETE)
//STDIN    DD DSN=&&LIST,DISP=(OLD,DELETE)
//STDOUT   DD SYSOUT=*
//STDERR   DD SYSOUT=*
//
