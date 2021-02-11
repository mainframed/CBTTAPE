/* REXX -----------  INSD - DD-to-program copy  --------------
|                 runs in both MVS and TSO environments
|
|  FUNCTION:
|                Read an input ddname and interprets
|                the records as a REXX program segment
|                Designed to be used for insertion of rexx
|                customization code from some PDS member
|                Use:     INTERPRET (INSD('REXXPARM'))
|
|  Sample use in rexx:
|                INTERPRET(INSD('REXXPARM'))
|
|  INPUT:
|                Parm containing input ddname
|
|  OUTPUT:
|                Returns #string of REXX code that can be interpreted
|
| -------------------------------------------------------------------
|  Hystory of changes (first comes last):
|
|  03/04/2003 SVM Revised
|  07/16/2002 SVM Created
| -------------------------------------------------------------------
*/
 SIGNAL ON NOVALUE
 #prefix = 'INSD: '
 Parse Arg #inddn

/*--------------------------------------------------------------------
|| Read from #inddn:
*/
   Arg #inddn
   Say #prefix'Including' #inddn
   "EXECIO * DISKR "#inddn" (STEM record. FINIS"
   #retc = RC
   #string = ''
   If record.0 > 0 Then
      #string = "STRIP"(record.1)
   Do i = 2 To record.0
      l = "LENGTH"(#string)
      Select
      When l = 0 Then Nop
      When "SUBSTR"(#string,l,1) = ',' Then
         #string = "SUBSTR"(#string,1,l-1) || ' '
      Otherwise
         #string = #string || ';'
      End
      #string = #string || "STRIP"(record.i)
      End
   Drop record.
   return(#string)

/*-------------------------------------------------------------------
|| Terminate application when Unitialized variable encountered
*/

  NOVALUE:
    SIGNAL OFF NOVALUE
    SAY #prefix" - Uninitialized variable used:"
    SAY "   "sigl":" Sourceline( sigl )
  EXIT 20
/*------------------  End of INSD program  ------------------------*/
