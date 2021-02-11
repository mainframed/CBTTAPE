*PROCESS ALIGN,NOCOMPAT
*PROCESS DXREF,FLAG(ALIGN,CONT,RECORD)
*PROCESS NOFOLD,NOINFO,PC(DATA,GEN,MCALL)
*PROCESS RA2,NORLD,MXREF,RXREF,USING(MAP,WARN(13))
*WARNING - THIS PROGRAM REQUIRES THE HIGH-LEVEL ASSEMBLER
*          AS WELL AS LE/370
*          THIS PROGRAM IS RE-ENTRANT.
         PUSH  PRINT
         MACRO
&LBL     MKFUNC &NAME
         LCLC   &SUFFIX,&IGNORE
&LBL     DS     0F
         DC     A(__$&SYSNDX)
         LCLA   &K
&K       SETA   K'&NAME
         DC     A(&K)
         DC     V(###&SYSNDX)
         DC     C'&NAME',X'00'
         DS     0F
         EXTRN  ###&SYSNDX
###&SYSNDX ALIAS C'&NAME'
__$&SYSNDX EQU  *
         MEND
         PRINT OFF,NOGEN
         IEABRCX DEFINE
         IEABRCX DISABLE
         POP   PRINT
         YREGS
BASE     LOCTR
MKFUNC   LOCTR
LOCAL    LOCTR
BASE     LOCTR
         GBLC  &LABEL
SQLITE3A CEEENTRY PPA=SQLITE3A_PPA,                                    X
               MAIN=NO,                                                X
               AUTO=DSASIZE,                                           X
               BASE=R11
         DROP  R11
         USING CEECAA,R12
         USING CEEDSA,R13
         LARL  R10,LTORG
         USING LTORG,R10
         J     GO
GOBACK   DS    0H
         CEETERM RC=RETURN_CODE
*              MODIFIER=MODIFIER
*              MF=(E,CEETERM_BLOCK)
GO       DS    0H
         LHI   R15,21             SQLITE_MISUSE
         ST    R15,RETURN_CODE    SAVE
         LTR   R9,R1              ANY PARM
         JZ    GOBACK             NO - ABORT
         LA    R1,CALLX
         LARL  R15,CEE3INF
         L     R15,0(,R15)
         CALL  (15),(SYS,ENV,MEMBER,GPID,FC),VL,                       X
               MF=(E,(1))
         TM    ENV+1,X'40'        POSIX(ON)?
         JO    POSIX_ON
         LHI   R15,21             SQLITE_MISUSE
         ST    R15,RETURN_CODE    SAVE
         J     GOBACK
POSIX_ON DS    0H
         L     R8,0(,R9)          PICK UP POINTER TO FUNCTION NAME
         LARL  R7,FUNCTION
         LHI   R15,21             SQLITE_MISUSE
         ST    R15,RETURN_CODE    SAVE
         SLR   R6,R6
FINDFUNC DS    0H
         ICM   R6,B'0011',6(R7)   PICK UP LENGTH
         JM    GOBACK
         EX    R6,CLC_FUNC
         JE    FND_FUNC
         L     R7,0(,R7)
         J     FINDFUNC
*        J     GOBACK
FND_FUNC DS    0H
         L     R15,8(,R7)         VECTOR TO ROUTINE
         LA    R1,4(,R9)          POINT PAST FIRST PARM
         TM    0(R7),X'80'        INT64?
         JNO   DO_CALL
         LA    R1,8(,R9)
DO_CALL  DS    0H
         CEEPCALL (15),MF=(E,)    CALL ROUTINE
         ST    R15,RETURN_CODE
         AGO   .NEWCOD2
         CLI   0(R7),0
         JZ    GOBACK
         L     R1,4(,R9)          POINT TO SECOND PARM
         TM    0(R7),X'80'        INT64
         JO    INT64
         TM    0(R7),X'40'        DOUBLE
         JO    DOUBLE
         J     GOBACK
DOUBLE   DS    0H
         LD    0,0(,R1)           GET ALREADY STORED RESULT
         THDR 0,0                 CONVERT LONG BFP TO LONG HFP
         STD   0,0(,R1)           PUT IT BACK WHERE i GOT IT
         J     GOBACK
INT64    DS    0H
         STM   R15,R0,0(R1)       STORE VALUE
.NEWCOD2 ANOP
         J     GOBACK
LTORG    DS    0D
         LTORG *
CLC_FUNC CLC   0(0,R8),12(R7)
MKFUNC   LOCTR
FUNCTION DS    0F
*        MKFUNC sqlite3_activate_cerod
*        MKFUNC sqlite3_activate_see
         MKFUNC sqlite3_aggregate_context
         MKFUNC sqlite3_aggregate_count
         MKFUNC sqlite3_auto_extension
         MKFUNC sqlite3_backup_finish
         MKFUNC sqlite3_backup_init
         MKFUNC sqlite3_backup_pagecount
         MKFUNC sqlite3_backup_remaining
         MKFUNC sqlite3_backup_step
         MKFUNC sqlite3_bind_blob
         MKFUNC sqlite3_bind_double
         MKFUNC sqlite3_bind_int
         MKFUNC sqlite3_bind_int64
         MKFUNC sqlite3_bind_null
         MKFUNC sqlite3_bind_parameter_count
         MKFUNC sqlite3_bind_parameter_index
         MKFUNC sqlite3_bind_parameter_name
         MKFUNC sqlite3_bind_text
         MKFUNC sqlite3_bind_text16
         MKFUNC sqlite3_bind_value
         MKFUNC sqlite3_bind_zeroblob
         MKFUNC sqlite3_blob_bytes
         MKFUNC sqlite3_blob_close
         MKFUNC sqlite3_blob_open
         MKFUNC sqlite3_blob_read
         MKFUNC sqlite3_blob_reopen
         MKFUNC sqlite3_blob_write
         MKFUNC sqlite3_busy_handler
         MKFUNC sqlite3_busy_timeout
         MKFUNC sqlite3_cancel_auto_extension
         MKFUNC sqlite3_changes
         MKFUNC sqlite3_clear_bindings
         MKFUNC sqlite3_close
         MKFUNC sqlite3_close_v2
         MKFUNC sqlite3_collation_needed
         MKFUNC sqlite3_collation_needed16
         MKFUNC sqlite3_column_blob
         MKFUNC sqlite3_column_bytes
         MKFUNC sqlite3_column_bytes16
         MKFUNC sqlite3_column_count
         MKFUNC sqlite3_column_database_name
         MKFUNC sqlite3_column_database_name16
         MKFUNC sqlite3_column_decltype
         MKFUNC sqlite3_column_decltype16
         MKFUNC sqlite3_column_double,DOUBLE
         MKFUNC sqlite3_column_int
         MKFUNC sqlite3_column_int64,INT64
         MKFUNC sqlite3_column_name
         MKFUNC sqlite3_column_name16
         MKFUNC sqlite3_column_origin_name
         MKFUNC sqlite3_column_origin_name16
         MKFUNC sqlite3_column_table_name
         MKFUNC sqlite3_column_table_name16
         MKFUNC sqlite3_column_text
         MKFUNC sqlite3_column_text16
         MKFUNC sqlite3_column_type
         MKFUNC sqlite3_column_value
         MKFUNC sqlite3_commit_hook
         MKFUNC sqlite3_compileoption_get
         MKFUNC sqlite3_compileoption_used
         MKFUNC sqlite3_complete
         MKFUNC sqlite3_complete16
         MKFUNC sqlite3_config
         MKFUNC sqlite3_context_db_handle
         MKFUNC sqlite3_create_collation
         MKFUNC sqlite3_create_collation_v2
         MKFUNC sqlite3_create_collation16
         MKFUNC sqlite3_create_function
         MKFUNC sqlite3_create_function_v2
         MKFUNC sqlite3_create_function16
         MKFUNC sqlite3_create_module
         MKFUNC sqlite3_create_module_v2
         MKFUNC sqlite3_data_count
*        MKFUNC sqlite3_data_directory
         MKFUNC sqlite3_db_config
         MKFUNC sqlite3_db_filename
         MKFUNC sqlite3_db_handle
         MKFUNC sqlite3_db_mutex
         MKFUNC sqlite3_db_readonly
         MKFUNC sqlite3_db_release_memory
         MKFUNC sqlite3_db_status
         MKFUNC sqlite3_declare_vtab
         MKFUNC sqlite3_enable_load_extension
         MKFUNC sqlite3_enable_shared_cache
         MKFUNC sqlite3_errcode
         MKFUNC sqlite3_errmsg
         MKFUNC sqlite3_errmsg16
         MKFUNC sqlite3_errstr
         MKFUNC sqlite3_exec
         MKFUNC sqlite3_expired
         MKFUNC sqlite3_extended_errcode
         MKFUNC sqlite3_extended_result_codes
         MKFUNC sqlite3_file_control
         MKFUNC sqlite3_finalize
         MKFUNC sqlite3_free
         MKFUNC sqlite3_free_table
         MKFUNC sqlite3_get_autocommit
         MKFUNC sqlite3_get_auxdata
         MKFUNC sqlite3_get_table
         MKFUNC sqlite3_global_recover
         MKFUNC sqlite3_initialize
         MKFUNC sqlite3_interrupt
*        MKFUNC sqlite3_key
         MKFUNC sqlite3_last_insert_rowid,INT64
         MKFUNC sqlite3_libversion
         MKFUNC sqlite3_libversion_number
         MKFUNC sqlite3_limit
         MKFUNC sqlite3_load_extension
         MKFUNC sqlite3_log
         MKFUNC sqlite3_malloc
         MKFUNC sqlite3_memory_alarm
         MKFUNC sqlite3_memory_highwater,INT64
         MKFUNC sqlite3_memory_used,INT64
         MKFUNC sqlite3_mprintf
         MKFUNC sqlite3_mutex_alloc
         MKFUNC sqlite3_mutex_enter
         MKFUNC sqlite3_mutex_free
*        MKFUNC sqlite3_mutex_held
         MKFUNC sqlite3_mutex_leave
*        MKFUNC sqlite3_mutex_notheld
         MKFUNC sqlite3_mutex_try
         MKFUNC sqlite3_next_stmt
         MKFUNC sqlite3_open
         MKFUNC sqlite3_open_v2
         MKFUNC sqlite3_open16
         MKFUNC sqlite3_os_end
         MKFUNC sqlite3_os_init
         MKFUNC sqlite3_overload_function
         MKFUNC sqlite3_prepare
         MKFUNC sqlite3_prepare_v2
         MKFUNC sqlite3_prepare16
         MKFUNC sqlite3_prepare16_v2
         MKFUNC sqlite3_profile
         MKFUNC sqlite3_progress_handler
         MKFUNC sqlite3_randomness
         MKFUNC sqlite3_realloc
*        MKFUNC sqlite3_rekey
         MKFUNC sqlite3_release_memory
         MKFUNC sqlite3_reset
         MKFUNC sqlite3_reset_auto_extension
         MKFUNC sqlite3_result_blob
         MKFUNC sqlite3_result_double
         MKFUNC sqlite3_result_error
         MKFUNC sqlite3_result_error_code
         MKFUNC sqlite3_result_error_nomem
         MKFUNC sqlite3_result_error_toobig
         MKFUNC sqlite3_result_error16
         MKFUNC sqlite3_result_int
         MKFUNC sqlite3_result_int64
         MKFUNC sqlite3_result_null
         MKFUNC sqlite3_result_text
         MKFUNC sqlite3_result_text16
         MKFUNC sqlite3_result_text16be
         MKFUNC sqlite3_result_text16le
         MKFUNC sqlite3_result_value
         MKFUNC sqlite3_result_zeroblob
         MKFUNC sqlite3_rollback_hook
         MKFUNC sqlite3_rtree_geometry_callback
         MKFUNC sqlite3_set_authorizer
         MKFUNC sqlite3_set_auxdata
         MKFUNC sqlite3_shutdown
         MKFUNC sqlite3_sleep
         MKFUNC sqlite3_snprintf
         MKFUNC sqlite3_soft_heap_limit
         MKFUNC sqlite3_soft_heap_limit64,INT64
         MKFUNC sqlite3_sourceid
         MKFUNC sqlite3_sql
         MKFUNC sqlite3_status
         MKFUNC sqlite3_step
         MKFUNC sqlite3_stmt_busy
         MKFUNC sqlite3_stmt_readonly
         MKFUNC sqlite3_stmt_status
         MKFUNC sqlite3_strglob
         MKFUNC sqlite3_stricmp
         MKFUNC sqlite3_strnicmp
         MKFUNC sqlite3_table_column_metadata
*        MKFUNC sqlite3_temp_directory
         MKFUNC sqlite3_test_control
         MKFUNC sqlite3_thread_cleanup
         MKFUNC sqlite3_threadsafe
         MKFUNC sqlite3_total_changes
         MKFUNC sqlite3_trace
         MKFUNC sqlite3_transfer_bindings
*        MKFUNC sqlite3_unlock_notify
         MKFUNC sqlite3_update_hook
         MKFUNC sqlite3_uri_boolean
         MKFUNC sqlite3_uri_int64,INT64
         MKFUNC sqlite3_uri_parameter
         MKFUNC sqlite3_user_data
         MKFUNC sqlite3_value_blob
         MKFUNC sqlite3_value_bytes
         MKFUNC sqlite3_value_bytes16
         MKFUNC sqlite3_value_double,DOUBLE
         MKFUNC sqlite3_value_int
         MKFUNC sqlite3_value_int64,INT64
         MKFUNC sqlite3_value_numeric_type
         MKFUNC sqlite3_value_text
         MKFUNC sqlite3_value_text16
         MKFUNC sqlite3_value_text16be
         MKFUNC sqlite3_value_text16le
         MKFUNC sqlite3_value_type
*        MKFUNC sqlite3_version
         MKFUNC sqlite3_vfs_find
         MKFUNC sqlite3_vfs_register
         MKFUNC sqlite3_vfs_unregister
         MKFUNC sqlite3_vmprintf
         MKFUNC sqlite3_vsnprintf
         MKFUNC sqlite3_vtab_config
         MKFUNC sqlite3_vtab_on_conflict
         MKFUNC sqlite3_wal_autocheckpoint
         MKFUNC sqlite3_wal_checkpoint
         MKFUNC sqlite3_wal_checkpoint_v2
         MKFUNC sqlite3_wal_hook
*
* Emulate the function of the MKFUNC macro for two
* routines written in HLASM and not C.
*
*        MKFUNC convert_bfp_to_hfp
         DC     A(CHTB)           Next entry
         DC     A(L'CBTHS)        Length of name
         DC     V(CBTHR)          addr of routine
CBTHS    DC     C'convert_bfp_to_hfp',X'00'
CHTB     DS     0F
*
*        MKFUNC convert_hfp_to_bfp
         DC     A(EOL)            Next entry
         DC     A(L'CHTBS)        Length of name
         DC     V(CHTBR)          addr of routine
CHTBS    DC     C'convert_hfp_to_bfp',X'00'
EOL      DS     0F
         DC    3F'-1'             END OF LIST INDICATOR
BASE     LOCTR
CEE3INF  DC    V(CEE3INF)
SQLITE3A_PPA CEEPPA LIBRARY=NO,                                        X
               PPA2=YES,                                               X
               EXTPROC=YES,                                            X
               TSTAMP=YES,                                             X
               PEP=YES,                                                X
               INSTOP=NO,                                              X
               EXITDSA=NO,                                             X
               OWNEXM=YES,                                             X
               EPNAME=SQLITE3A,                                        X
               VER=1,                                                  X
               REL=1,                                                  X
               MOD=0,                                                  X
               DSA=YES
BASE     LOCTR
         CEEDSA
* DYNAMIC AREA IS DEFINED HERE.
* THIS IS WITHIN A DSECT, SO NO DATA IS REALLY INITIALIZED
CALLX    DS    30A
SYS      DS    F
* BIT MEANING
*    0
*    CURRENTLY EXECUTING IN THE CICS ENVIRONMENT
*    1
*    CURRENTLY EXECUTING IN A CICS_PIPI ENVIRONMENT
*    2-3
*    RESERVED FOR OTHER SPECIFIC CICS ENVIRONMENTS
*    4
*    CURRENTLY EXECUTING IN A TSO ENVIRONMENT
*    5
*    CURRENTLY EXECUTING IN A BATCH ENVIRONMENT
*    6
*    CURRENTLY EXECUTING IN A Z/OS UNIX ENVIRONMENT
*    7-28
*    RESERVED FOR FUTURE USE
*    29
*    CURRENTLY EXECUTING ON Z/VSE(TM)
*    30
*    CURRENTLY EXECUTING ON Z/OS
*    31
*    PREVIOUSLY INDICATED AS EXECUTING ON Z/OS.E
*
ENV      DS    F
*
MEMBER   DS    F
*
GPID     DS    F
FC       DS    F
RETURN_CODE DS F
MODIFIER DS    F
*EETERM_BLOCK CEETERM MF=L
DSASIZE  EQU   *-CEEDSA
         CEECAA
         END   SQLITE3A
*PROCESS ALIGN,NOCOMPAT
*PROCESS DXREF,FLAG(ALIGN,CONT,RECORD)
*PROCESS NOFOLD,NOINFO,PC(DATA,GEN,MCALL)
*PROCESS RA2,NORLD,MXREF,RXREF,USING(MAP,WARN(13))
*WARNING - THIS PROGRAM REQUIRES THE HIGH-LEVEL ASSEMBLER
*          AS WELL AS LE/370
*          THIS PROGRAM IS RE-ENTRANT.
*CBTHR Convert BFP to HFP subroutine
* R1 points to a C-like calling sequence.
* R1 +0(8) contains an 8 byte BFP number
* R1 +8(4) contains a pointer to where to store the HFP
*
* This may look a bit strange. Well, it does to me. But
* the LD loads a bit pattern into a floating point register
* at this point, the hardware doesn't know if it loaded a
* BFP or HFP value. The programmer must know that and use
* the appropriate BFP or HFP opcodes to manipulate the value
* in the floating register. The same is true of the STD
* instruction.
*
* The other strangeness is likely the calling sequence. I decided
* to use the C language calling sequence instead of the normal
* OS calling sequence simply to be consistent with the sqlite3_
* subroutines. Hope that's not too confusing.
*
         PUSH  PRINT
         PRINT OFF,NOGEN
         IEABRCX DEFINE
         IEABRCX DISABLE
         POP   PRINT
         YREGS
CBTHR    CEEENTRY PPA=CBTHR_PPA,                                       X
               MAIN=NO,                                                X
               AUTO=DSASIZE,                                           X
               BASE=R11
         DROP  R11
         LR    R9,R1                     Save R1 at entry
         LD    0,0(,R1)                  Load BFP value
         THDR  2,0                       Convert to HFP
         L     R2,8(,R1)                 Point to return area
         STD   2,0(,R2)
         SLR   R15,R15
         SLR   R0,R0
         CEETERM RC=(15),MODIFIER=(0)
CBTHR_PPA CEEPPA LIBRARY=NO,                                           X
               PPA2=YES,                                               X
               EXTPROC=YES,                                            X
               TSTAMP=YES,                                             X
               PEP=YES,                                                X
               INSTOP=NO,                                              X
               EXITDSA=NO,                                             X
               OWNEXM=YES,                                             X
               EPNAME=CBTHR,                                           X
               VER=1,                                                  X
               REL=1,                                                  X
               MOD=0,                                                  X
               DSA=YES
         CEEDSA
* DYNAMIC AREA IS DEFINED HERE.
* THIS IS WITHIN A DSECT, SO NO DATA IS REALLY INITIALIZED
RETURN_CODE DS F
MODIFIER DS    F
DSASIZE  EQU   *-CEEDSA
         CEECAA
         END   CBTHR
*PROCESS ALIGN,NOCOMPAT
*PROCESS DXREF,FLAG(ALIGN,CONT,RECORD)
*PROCESS NOFOLD,NOINFO,PC(DATA,GEN,MCALL)
*PROCESS RA2,NORLD,MXREF,RXREF,USING(MAP,WARN(13))
*WARNING - THIS PROGRAM REQUIRES THE HIGH-LEVEL ASSEMBLER
*          AS WELL AS LE/370
*          THIS PROGRAM IS RE-ENTRANT.
*CHTBR Convert HFP to BFP subroutine
* R1 points to a C-like calling sequence.
* R1 +0(8) contains an 8 byte HFP number
* R1 +8(4) contains a pointer to where to store the BFP
*
* This may look a bit strange. Well, it does to me. But
* the LD loads a bit pattern into a floating point register
* at this point, the hardware doesn't know if it loaded a
* BFP or HFP value. The programmer must know that and use
* the appropriate BFP or HFP opcodes to manipulate the value
* in the floating register. The same is true of the STD
* instruction.
*
* The other strangeness is likely the calling sequence. I decided
* to use the C language calling sequence instead of the normal
* OS calling sequence simply to be consistent with the sqlite3_
* subroutines. Hope that's not too confusing.
*
         PUSH  PRINT
         PRINT OFF,NOGEN
         IEABRCX DEFINE
         IEABRCX DISABLE
         POP   PRINT
         YREGS
CHTBR    CEEENTRY PPA=CHTBR_PPA,                                       X
               MAIN=NO,                                                X
               AUTO=DSASIZE,                                           X
               BASE=R11
         DROP  R11
         LR    R9,R1                     Save R1 at entry
         LD    0,0(,R1)                  Load BFP value
         TBDR  2,0,0                     Convert to BFP, round to 0
         L     R2,8(,R1)                 Point to return area
         STD   2,0(,R2)
         SLR   R15,R15
         SLR   R0,R0
         CEETERM RC=(15),MODIFIER=(0)
CHTBR_PPA CEEPPA LIBRARY=NO,                                           X
               PPA2=YES,                                               X
               EXTPROC=YES,                                            X
               TSTAMP=YES,                                             X
               PEP=YES,                                                X
               INSTOP=NO,                                              X
               EXITDSA=NO,                                             X
               OWNEXM=YES,                                             X
               EPNAME=CHTBR,                                           X
               VER=1,                                                  X
               REL=1,                                                  X
               MOD=0,                                                  X
               DSA=YES
         CEEDSA
* DYNAMIC AREA IS DEFINED HERE.
* THIS IS WITHIN A DSECT, SO NO DATA IS REALLY INITIALIZED
RETURN_CODE DS F
MODIFIER DS    F
DSASIZE  EQU   *-CEEDSA
         CEECAA
         END   CHTBR
