/* REXX --------- Check if tast/job is active: -------------
|                       TSO environment
|
| 08/08/03 SVM Added bypass tso status if under SUB=MSTR
| 06/06/03 SVM Added TSO STATUS for old SYSACTV
|          that extracted info from CSCBs.
|
| Called by SYSGETL exec (and others) to check if taskname is running
|        Uses TSO STATUS jobname command output.
|
| Input parm:
|        taskname - name to look for in the active task list
|
| Output:
|        '0'   - task/job not found
|        '1'   - task/job is executing, but JOBID not available
|        jobid - task/job found executing
|
| System control blocks fields (ref: MVS Data Areas):
|  cvtptr   = 16  addr of CVT pointer
|  cvtmser  = 148 CVT offset of MASTER SCHEDULER RESIDENT DATA AREA
|                 ptr). AREA starts with the pointer to CSCB chain
|  chkey    = 8   offset of JOBNAME or STC Id or TSO User in CSCB
|  chcls    = 16  offset of JOBNAME or STC or TSO proc name in CSCB
|  chasid   = 30  offset of ASID of JOB/STC in CSCB
|  chprocsn = 32  offset of PROCSTEP in CSCB
|  chstep   = 64  offset of STEPNAME in CSCB, batch JOB only
|  chcscbid = 216 offset of 'CSCB' acronym in CSCB
|
*/
#p = 'SYSACTV:'
Arg taskname
taskname = "LEFT"(taskname,8,' ')

/* Get and return JES jobid using TSO STATUS:                        */
/* Check if this task runs under JES (or MSTR)                       */
 ascb = ptr(548)                             /* X'224'               */
 jsab = ptr(ptr(ascb + 336) + 168)           /* ASCB -> ASSB -> JSAB */
 If stg(jsab,4) = 'JSAB' Then Do
    Call outtrap 'STEM.'
    Address 'TSO' 'STATUS' taskname
    Call outtrap 'OFF'
    num = ''
    Do a = stem.0 By -1 to 1 Until(num <> '')
       Parse Var stem.a . 'JOB ' id '('num')' ex .
       End
    If num <> '' Then Do
       Say #p "LEFT"(id,8) "LEFT"(num,8) ex
       Return(num)
       End
    Else Do
       Say #p "LEFT"(taskname,8) '- TSO STATUS returned no jobid'
       Do a = stem.0 By -1 to 1
          Say #p stem.a
          End
       End
    End

 /* If not found, search CSCB chain */
 cscbptr=ptr(ptr(148+ptr(16)))               /* CVT -> CSCB chain    */
 Do WHILE(cscbptr <> 0)
    nextptr = ptr(cscbptr)
    /* Say "D2X"(cscbptr,8) "D2X"(nextptr,8) STG(cscbptr+8,224) */
    If stg(cscbptr+216,4) <> 'CSCB' Then Leave
    jobname = stg(cscbptr+16,8)
    If jobname = taskname Then Do
       /* If taskname = 'SDSF' Then Say STG(cscbptr,100) */
       Say #p "LEFT"(taskname,8) '- CSCB found'
       Return(1)
       End
    cscbptr = nextptr
    End

 /* No jobs found: Exit. Message (if any) will be removed by system */
 Return(0)

/*-------------------------------------------------------------------*/
PTR:
Return c2d(storage(d2x(Arg(1)),4))     /* Return decimal pointer     */
/*-------------------------------------------------------------------*/
STG:
Return storage(d2x(Arg(1)),Arg(2))     /* Return storage pointed     */
