/* REXX  ....  #GETJOB - Return my JOBNAME and JOBNUM  ...........
|                 runs in MVS and TSO environment
|
|  FUNCTION      Look for current JOB name and JES JOB id
|                in system control blocks and return to caller
|
|  INPUT:        n/a
|
|  OUTPUT:       'JOBNAME JOBNUM USERID'
|
| -------------------------------------------------------------------
|  Hystory of changes (first comes last):
|
|  08-08-2003 SVM Added check if JSAB exists
|  08-09-2002 SVM Added Ownerid
|  07-29-2002 SVM Created
| -------------------------------------------------------------------
*/
 tcb  = ptr(540)                             /* X'21C'               */
 ascb = ptr(548)                             /* X'224'               */
 jobname = "STRIP"(stg(ptr(tcb+12),8))       /* TCB -> TIOT          */
 jobnum  = stg(ptr(ptr(tcb+180)+316)+12,8)   /* TCB -> JSCB -> SSIB  */
 jsab = ptr(ptr(ascb+336)+168)               /* ASCB -> JSAB         */
 If jsab <> 0 Then
    usid = "STRIP"(stg(jsab+44,8))
 Else usid = ''
 Return(jobname jobnum usid)
/*-------------------------------------------------------------------*/
PTR:
Return c2d(storage(d2x(Arg(1)),4))     /* Return decimal pointer     */
/*-------------------------------------------------------------------*/
STG:
Return storage(d2x(Arg(1)),Arg(2))     /* Return storage pointed     */
/*--------------------  End of #GETJOB program  -------------------*/
