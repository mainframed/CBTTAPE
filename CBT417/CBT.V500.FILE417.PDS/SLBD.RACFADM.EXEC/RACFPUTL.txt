/*%NOCOMMENT====================* REXX *==============================*/
/*  PURPOSE:  RACFADM - Called by RACFCMDS, display command at top    */
/*--------------------------------------------------------------------*/
/* FLG  YYMMDD  USERID   DESCRIPTION                                  */
/* ---  ------  -------  -------------------------------------------- */
/* @A0  200913  LBD      Created REXX                                 */
/*====================================================================*/
parse arg  prose
prose = strip(prose,'B',"'")
prose = strip(prose,'B','"')
say prose
return
