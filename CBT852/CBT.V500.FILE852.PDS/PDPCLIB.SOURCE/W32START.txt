/*********************************************************************/
/*                                                                   */
/*  This Program Written by Paul Edwards.                            */
/*  Released to the Public Domain                                    */
/*                                                                   */
/*********************************************************************/
/*********************************************************************/
/*                                                                   */
/*  w32start - startup code for WIN32                                */
/*                                                                   */
/*********************************************************************/

/* This is the main entry point of a console mode executable */

#include <stdio.h>
#include <stdlib.h>
#include <stddef.h>

int main(int argc, char **argv);

void mainCRTStartup(void)
{
#ifdef __STATIC__
    __start(0);
    return;
#else
    int argc;
    char **argv;
    char **environ;
    int startinfo = 0;
    int status;

    __getmainargs(&argc, &argv, &environ, 1, &startinfo);

    status = main(argc, argv);

    exit(status);
#endif
}

void __main(void)
{
    return;
}
