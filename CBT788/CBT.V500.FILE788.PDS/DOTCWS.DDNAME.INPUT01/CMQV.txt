/* REXX */
/*
Program: CMQV
Author:  Craig Schneiderwent
Date:    04-Sep-2001
Purpose:
Read a member consisting of the MQSeries Reason codes cut from the
hlq.SCSQCOBC(CMQV) member and output a COBOL copybook to be used
in a binary search.

Execute deck:
    //CMQV     EXEC PGM=IKJEFT01
    //SYSEXEC  DD  DISP=SHR,DSN=where.this.member.is
    //REASONS  DD  DISP=SHR,DSN=pds.with.copied.reason.codes(CMQV)
    //OUTPUT01 DD  DISP=SHR,DSN=copybook.pds(MQRSNCD1)
    //SYSTSIN  DD  *
    CMQV
    //SYSTSPRT DD  SYSOUT=*
    //SYSPRINT DD  SYSOUT=*
    //SYSUDUMP DD  SYSOUT=*
    //SYSABOUT DD  SYSOUT=*
    //SYSOUT   DD  SYSOUT=*
    //SYSABEND DD  SYSOUT=*
*/
gbl.myName = 'CMQV'
'EXECIO * DISKR REASONS ( STEM inLine. FINIS )'
If rc = 0 Then NOP
Else
  Do
    Say gbl.myName 'EXECIO for REASONS RC =' rc
    Exit 16
  End

Do i = 1 To inLine.0
  Parse Var inLine.i . txtVal . . . . binVal .
  val.i.txt = txtVal
  val.i.bin = binVal
  val.i.txtLn = Length( txtVal )
End

val.0 = inLine.0

j = 1
outLine.j = Copies( ' ', 7 )
outLine.j = outLine.j || '01  MQ-RSN-CD-VAL.'
ln = Length( outLine.j )
outLine.j = outLine.j || Copies( ' ', 80 - ln )

j = j + 1
outLine.j = Copies( ' ', 11 )
outLine.j = outLine.j || '05  MQ-RSN-CD-VAL-TBL.'
ln = Length( outLine.j )
outLine.j = outLine.j || Copies( ' ', 80 - ln )

Do i = 1 To val.0
  j = j + 1
  outLine.j = Copies( ' ', 15 )
  outLine.j = outLine.j || '10  PIC S9(009) Binary Value '
  outLine.j = outLine.j || val.i.bin
  ln = Length( outLine.j )
  outLine.j = outLine.j || Copies( ' ', 80 - ln )
  j = j + 1
  outLine.j = Copies( ' ', 15 )
  outLine.j = outLine.j || "10  PIC X(030) Value '"
  outLine.j = outLine.j || val.i.txt
  outLine.j = outLine.j || "'."
  ln = Length( outLine.j )
  outLine.j = outLine.j || Copies( ' ', 80 - ln )
End

j = j + 1
outLine.j = Copies( ' ', 11 )
outLine.j = outLine.j || '05  MQ-RSN-CD-TBL Redefines '
outLine.j = outLine.j || 'MQ-RSN-CD-VAL-TBL'
ln = Length( outLine.j )
outLine.j = outLine.j || Copies( ' ', 80 - ln )

j = j + 1
outLine.j = Copies( ' ', 15 )
outLine.j = outLine.j || 'Occurs ' val.0
ln = Length( outLine.j )
outLine.j = outLine.j || Copies( ' ', 80 - ln )

j = j + 1
outLine.j = Copies( ' ', 15 )
outLine.j = outLine.j || 'Ascending Key MQ-RSN-CD-NB'
ln = Length( outLine.j )
outLine.j = outLine.j || Copies( ' ', 80 - ln )

j = j + 1
outLine.j = Copies( ' ', 15 )
outLine.j = outLine.j || 'Indexed MQ-RSN-CD-INDX.'
ln = Length( outLine.j )
outLine.j = outLine.j || Copies( ' ', 80 - ln )

j = j + 1
outLine.j = Copies( ' ', 15 )
outLine.j = outLine.j || '10  MQ-RSN-CD-NB  PIC S9(009) Binary.'
ln = Length( outLine.j )
outLine.j = outLine.j || Copies( ' ', 80 - ln )

j = j + 1
outLine.j = Copies( ' ', 15 )
outLine.j = outLine.j || '10  MQ-RSN-CD-TXT PIC X(030).'
ln = Length( outLine.j )
outLine.j = outLine.j || Copies( ' ', 80 - ln )

outLine.0 = j

'EXECIO * DISKW OUTPUT01 ( STEM' outLine. 'FINIS )'
If rc = 0 Then NOP
Else
  Do
    Say gbl.myName 'EXECIO for OUTPUT01 RC =' rc
    Exit 16
  End


