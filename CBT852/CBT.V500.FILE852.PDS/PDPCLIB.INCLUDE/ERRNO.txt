/*********************************************************************/
/*                                                                   */
/*  This Program Written by Paul Edwards.                            */
/*  Released to the Public Domain                                    */
/*                                                                   */
/*********************************************************************/
/*********************************************************************/
/*                                                                   */
/*  errno.h - errno header file.                                     */
/*                                                                   */
/*********************************************************************/

#ifndef __ERRNO_INCLUDED
#define __ERRNO_INCLUDED

#define EDOM 1
#define ERANGE 2

/* extern int errno; */

#define errno (*(__get_errno()))

int *__get_errno(void);

#endif
