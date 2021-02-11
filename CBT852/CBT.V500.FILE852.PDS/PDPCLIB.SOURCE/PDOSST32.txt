/* Startup code for PDOS */
/* written by Paul Edwards */
/* released to the public domain */

/* We can get away with a minimal startup code, plus make it
   a C program.  Do not put any string literals in here though,
   as the code needs to start immediately.  This is IT!  */

#ifdef __WATCOMC__
#define CTYP __cdecl
#else
#define CTYP
#endif

void CTYP __pdosst32(void)
{
    __start(0);
}
