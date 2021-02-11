/*********************************************************************/
/*                                                                   */
/*  This Program Written By Paul Edwards.                            */
/*  Released to the public domain.                                   */
/*                                                                   */
/*********************************************************************/

#if 0

Example usage:

MEMMGR memmgr; /* define an instance of the object */
char *ptr; /* scratch pointer */


memmgrDefaults(&memmgr); /* always called to set up object defaults */
memmgrInit(&memmgr); /* Initialize object */
memmgrSupply(&memmmgr, (void *)0x04100000, 32 * 1024 * 1024);
  /* Supply the object with a buffer that starts at the 65 MB location
     and is 32 MB in size. This can be called multiple times to give
     memmgr multiple blocks of memory to manage */
ptr = memmgrAllocate(&memmgr, 500, 0);
  /* allocate 500 bytes of memory. 0 is an "optional" ID if you want
     to group memory blocks. ptr will be NULL if memory couldn't be
     obtained */
memmgrFree(&memmgr, ptr); /* free memory associated with this
                             pointer */
memmgrTerm(&memmgr); /* Terminate object */


Other functions:

memmgrFreeID(&memmgr, 5); /* free all memory with an ID of 5 */
printf("largest block of memory available is %d\n",
       memmgrMaxSize(&memmgr));
printf("total amount of available memory is %d\n",
       memmgrTotSize(&memmgr));
memmgrIntegrity(&memmgr); /* check any memory chain corruption */
memmgrRealloc(&memmgr, ptr, 1000); /* resize the object to be 1000
  bytes. Returns 0 if successful, negative if the request failed for
  any reason. */

#endif


#ifndef MEMMGR_INCLUDED
#define MEMMGR_INCLUDED

#include <stddef.h>

/* Do you want memmgr to perform lots of integrity checks? */
/* Note that this will slow down the system, but it doesn't
   print out anything or change the functionality of your
   application. */
/* #define __MEMMGR_INTEGRITY 1 */

/* Do you want lots of debugging output? */
/* Note that you still need to set the memmgrDebug variable to 1
   before it is actually activated */
/* #define __MEMMGR_DEBUG 1 */

typedef struct memmgrn {
#ifdef __MEMMGR_INTEGRITY
    int eyecheck1;
#endif
    struct memmgrn *next;
    struct memmgrn *prev;
    struct memmgrn *nextf;
    struct memmgrn *prevf;
    int fixed;
    size_t size; /* size of memory available to user */
    int allocated;
    int id;
#ifdef __MEMMGR_INTEGRITY
    int eyecheck2;
#endif
    size_t filler; /* we add this so that *(p - size_t) is writable */
} MEMMGRN;

typedef struct {
    MEMMGRN *start;
    MEMMGRN *startf;
} MEMMGR;

/* What boundary we want the memmgr control block to be a multiple of */
#define MEMMGR_ALIGN 8

#define MEMMGRN_SZ \
  ((sizeof(MEMMGRN) % MEMMGR_ALIGN == 0) ? \
   sizeof(MEMMGRN) : \
   ((sizeof(MEMMGRN) / MEMMGR_ALIGN + 1) * MEMMGR_ALIGN))

/* Let's make sure that the minimum free data area is at least
   as big as the node itself, so that we don't have more than
   50% of the available memory used up by control blocks due
   to fragmentation */
#define MEMMGR_MINFREE MEMMGRN_SZ

/* total size of the minimum free area, including room for the
   control block */
#define MEMMGR_MINFRTOT (MEMMGRN_SZ + MEMMGR_MINFREE)

/* do you want to crash whenever an integrity problem arises? */
#ifndef MEMMGR_CRASH
#define MEMMGR_CRASH 1
#endif

#ifdef NICEASM
#define memmgrDefaults mmDef
#define memmgrInit mmInit
#define memmgrTerm mmTerm
#define memmgrSupply mmSupply
#define memmgrAllocate mmAlloc
#define memmgrFree mmFree
#define memmgrFreeId mmFreeId
#define memmgrMaxSize mmMaxSiz
#define memmgrTotSize mmTotSiz
#define memmgrIntegrity mmInteg
#define memmgrRealloc mmRealoc
#define memmgrDebug mmDebug
#define memmgrDebug2 mmDbg2
#else
#define memmgrDefaults __mmDef
#define memmgrInit __mmInit
#define memmgrTerm __mmTerm
#define memmgrSupply __mmSupply
#define memmgrAllocate __mmAlloc
#define memmgrFree __mmFree
#define memmgrFreeId __mmFId
#define memmgrMaxSize __mmMaxSize
#define memmgrTotSize __mmTotSize
#define memmgrIntegrity __mmIntegrity
#define memmgrRealloc __mmRealloc
#define memmgrDebug __mmDebug
#define memmgrDebug2 __mmDbg2
#endif

void memmgrDefaults(MEMMGR *memmgr);
void memmgrInit(MEMMGR *memmgr);
void memmgrTerm(MEMMGR *memmgr);
void memmgrSupply(MEMMGR *memmgr, void *buffer, size_t szbuf);
void *memmgrAllocate(MEMMGR *memmgr, size_t bytes, int id);
void memmgrFree(MEMMGR *memmgr, void *ptr);
void memmgrFreeId(MEMMGR *memmgr, int id);
size_t memmgrMaxSize(MEMMGR *memmgr);
size_t memmgrTotSize(MEMMGR *memmgr);
void memmgrIntegrity(MEMMGR *memmgr);
int memmgrRealloc(MEMMGR *memmgr, void *ptr, size_t newsize);

extern int memmgrDebug;
extern int memmgrDebug2;

extern MEMMGR __memmgr;

#endif
