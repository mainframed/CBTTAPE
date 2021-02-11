/*%NOCOMMENT====================* REXX *==============================*/
/*  PURPOSE:  RACFADM - Edit Macro - VIEW/EDIT turn off highlighting  */
/*--------------------------------------------------------------------*/
/*  NOTES:    1) This edit macro is used by all REXX programs         */
/*--------------------------------------------------------------------*/
/* FLG  YYMMDD  USERID   DESCRIPTION                                  */
/* ---  ------  -------  -------------------------------------------- */
/* @A3  200303  RACFA    Renamed member to RACFDSPE, was RACFCHGE     */
/* @A2  200221  RACFA    Make 'ADDRESS ISREDIT' defualt, reduce code  */
/* @A1  200220  RACFA    Added RESET, to remove messages (==MSG>)     */
/* @A0  200218  RACFA    Created REXX                                 */
/*====================================================================*/
ADDRESS ISREDIT                                               /* @A2 */
  "MACRO (PARM) NOPROCESS"
  "HI OFF"
  "RESET"                                                     /* @A1 */
