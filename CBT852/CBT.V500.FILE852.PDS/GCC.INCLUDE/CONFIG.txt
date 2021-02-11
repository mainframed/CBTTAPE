#ifndef MAIN_CONFIG_INCLUDED
#define MAIN_CONFIG_INCLUDED

/* config.h.  Manually generated for use on MVS 3.8  */

/* The defines required for the generator files are too
   numerous for the 100-character parameter limit on MVS,
   so we activate them here instead. */
#ifdef GENFILES
#define NO_DETAB 1
#define GENERATOR_FILE 1
#define IN_GCC 1
#define PUREISO 1
#endif

#if defined(S390) || defined(I386)
#define SINGLE_EXECUTABLE 1
#define ANSI_PROTOTYPES 1
#define PARAMS(ARGS) ARGS
#define PTR void *

#ifndef RTX_FORWARD
#define RTX_FORWARD 1
struct rtx_def;
typedef struct rtx_def *rtx;
struct rtvec_def;
typedef struct rtvec_def *rtvec;
union tree_node;
typedef union tree_node *tree;
#endif

#include "unixio.h"
#if defined(S390)
#include "s390.h"
#include "linux.h"
#include "defaults.h"
#define ASM_APP_OFF ""
#define ASM_APP_ON ""
#elif defined(I386)
#include "i386.h"
/* #include "uwin.h" */ /* for Windows PE */
#include "pdos386.h" /* for a.out */
#include "defaults.h"
#endif
#define DEFAULT_TARGET_VERSION "1.1"
#if defined(S390)
#define DEFAULT_TARGET_MACHINE "s390"
#elif defined(I386)
#define DEFAULT_TARGET_MACHINE "i386"
#endif
#ifndef GENERATOR_FILE
# include "insn-constants.h"
# include "insn-flags.h"
#endif
#define PREFIX ""
#if defined(S390)
#define TARGET_NAME "mvs"
#elif defined(I386)
#define TARGET_NAME "pdos386"
#endif
#define ATTRIBUTE_NORETURN
#define getpwd() ""
#define make_temp_file(a) tmpnam(NULL)

#if defined(S390)
#define ASM_GENERATE_INTERNAL_LABEL(LABEL, PREFIX, NUM)			\
  sprintf (LABEL, "*@@%s%d", PREFIX, NUM)
#define ASM_OUTPUT_INTERNAL_LABEL(FILE, PREFIX, NUM) 			\
  fprintf (FILE, "@@%s%d\tEQU\t*\n", PREFIX, NUM);
#define ASM_OUTPUT_LOCAL(FILE, NAME, SIZE, ROUNDED) 			\
{									\
  ASM_OUTPUT_LABEL (FILE,NAME);						\
  ASM_OUTPUT_SKIP (FILE,SIZE);						\
}
#define ASM_OUTPUT_COMMON(FILE, NAME, SIZE, ROUNDED) 			\
{									\
  ASM_OUTPUT_LABEL (FILE,NAME);						\
  ASM_OUTPUT_SKIP (FILE,SIZE);						\
}
#endif

#endif


/* Define if using alloca.c.  */
#undef C_ALLOCA

/* Define to empty if the keyword does not work.  */
#undef const

/* Define to one of _getb67, GETB67, getb67 for Cray-2 and Cray-YMP systems.
   This function is required for alloca.c support on those systems.  */
#undef CRAY_STACKSEG_END

/* Define to the type of elements in the array set by `getgroups'.
   Usually this is either `int' or `gid_t'.  */
#undef GETGROUPS_T

/* Define to `int' if <sys/types.h> doesn't define.  */
#undef gid_t

/* Define if you have alloca, as a function or macro.  */
#undef HAVE_ALLOCA

/* Define if you have <alloca.h> and it should be used (not on Ultrix).  */
#undef HAVE_ALLOCA_H

/* Define if you have the ANSI # stringizing operator in cpp. */
#undef HAVE_STRINGIZE

/* Define if you have <sys/wait.h> that is POSIX.1 compatible.  */
#undef HAVE_SYS_WAIT_H

/* Define if you have <vfork.h>.  */
#undef HAVE_VFORK_H

/* Define as __inline if that's what the C compiler calls it.  */
#undef inline

/* Define if your C compiler doesn't accept -c and -o together.  */
#undef NO_MINUS_C_MINUS_O

/* Define to `long' if <sys/types.h> doesn't define.  */
#define off_t long

/* Define to `int' if <sys/types.h> doesn't define.  */
#define pid_t int

/* Define to `unsigned' if <sys/types.h> doesn't define.  */
#undef size_t

/* If using the C implementation of alloca, define if you know the
   direction of stack growth for your system; otherwise it will be
   automatically deduced at run-time.
 STACK_DIRECTION > 0 => grows toward higher addresses
 STACK_DIRECTION < 0 => grows toward lower addresses
 STACK_DIRECTION = 0 => direction of growth unknown
 */
#undef STACK_DIRECTION

/* Define if you have the ANSI C header files.  */
#define STDC_HEADERS 1

/* Define if you can safely include both <sys/time.h> and <time.h>.  */
#undef TIME_WITH_SYS_TIME

/* Define to `int' if <sys/types.h> doesn't define.  */
#define uid_t int

/* Define vfork as fork if vfork does not work.  */
#undef vfork

/* Define if your assembler supports specifying the maximum number
   of bytes to skip when using the GAS .p2align command.  */
#undef HAVE_GAS_MAX_SKIP_P2ALIGN

/* Define if your assembler supports .balign and .p2align.  */
#undef HAVE_GAS_BALIGN_AND_P2ALIGN

/* Define if your assembler uses the old HImode fild and fist notation.  */
#undef HAVE_GAS_FILDS_FISTS

/* Define to `int' if <sys/types.h> doesn't define.  */
#define ssize_t unsigned int

/* Define if cpp should also search $prefix/include.  */
#undef PREFIX_INCLUDE_DIR

/* Define if you have the __argz_count function.  */
#undef HAVE___ARGZ_COUNT

/* Define if you have the __argz_next function.  */
#undef HAVE___ARGZ_NEXT

/* Define if you have the __argz_stringify function.  */
#undef HAVE___ARGZ_STRINGIFY

/* Define if you have the atoll function.  */
#undef HAVE_ATOLL

/* Define if you have the atoq function.  */
#undef HAVE_ATOQ

/* Define if you have the clock function.  */
#undef HAVE_CLOCK
#define HAVE_CLOCK 1

/* Define if you have the dcgettext function.  */
#undef HAVE_DCGETTEXT

/* Define if you have the dup2 function.  */
#undef HAVE_DUP2

/* Define if you have the feof_unlocked function.  */
#undef HAVE_FEOF_UNLOCKED

/* Define if you have the fgets_unlocked function.  */
#undef HAVE_FGETS_UNLOCKED

/* Define if you have the fprintf_unlocked function.  */
#undef HAVE_FPRINTF_UNLOCKED

/* Define if you have the fputc_unlocked function.  */
#undef HAVE_FPUTC_UNLOCKED

/* Define if you have the fputs_unlocked function.  */
#undef HAVE_FPUTS_UNLOCKED

/* Define if you have the fwrite_unlocked function.  */
#undef HAVE_FWRITE_UNLOCKED

/* Define if you have the getcwd function.  */
#undef HAVE_GETCWD

/* Define if you have the getegid function.  */
#undef HAVE_GETEGID

/* Define if you have the geteuid function.  */
#undef HAVE_GETEUID

/* Define if you have the getgid function.  */
#undef HAVE_GETGID

/* Define if you have the getpagesize function.  */
#undef HAVE_GETPAGESIZE

/* Define if you have the getrlimit function.  */
#undef HAVE_GETRLIMIT

/* Define if you have the getrusage function.  */
#undef HAVE_GETRUSAGE

/* Define if you have the getuid function.  */
#undef HAVE_GETUID

/* Define if you have the kill function.  */
#undef HAVE_KILL

/* Define if you have the lstat function.  */
#undef HAVE_LSTAT

/* Define if you have the mempcpy function.  */
#undef HAVE_MEMPCPY

/* Define if you have the munmap function.  */
#undef HAVE_MUNMAP

/* Define if you have the nl_langinfo function.  */
#undef HAVE_NL_LANGINFO

/* Define if you have the putc_unlocked function.  */
#undef HAVE_PUTC_UNLOCKED

/* Define if you have the putenv function.  */
#undef HAVE_PUTENV

/* Define if you have the setenv function.  */
#undef HAVE_SETENV

/* Define if you have the setlocale function.  */
#define HAVE_SETLOCALE 1

/* Define if you have the setrlimit function.  */
#undef HAVE_SETRLIMIT

/* Define if you have the stpcpy function.  */
#undef HAVE_STPCPY

/* Define if you have the strcasecmp function.  */
#undef HAVE_STRCASECMP

/* Define if you have the strchr function.  */
#define HAVE_STRCHR 1

/* Define if you have the strdup function.  */
#undef HAVE_STRDUP

/* Define if you have the strsignal function.  */
#undef HAVE_STRSIGNAL

/* Define if you have the strtoul function.  */
#define HAVE_STRTOUL 1

/* Define if you have the sysconf function.  */
#undef HAVE_SYSCONF

/* Define if you have the times function.  */
#undef HAVE_TIMES

/* Define if you have the tsearch function.  */
#undef HAVE_TSEARCH

/* Define if you have the <argz.h> header file.  */
#undef HAVE_ARGZ_H

/* Define if you have the <direct.h> header file.  */
#undef HAVE_DIRECT_H

/* Define if you have the <fcntl.h> header file.  */
#undef HAVE_FCNTL_H

/* Define if you have the <langinfo.h> header file.  */
#undef HAVE_LANGINFO_H

/* Define if you have the <limits.h> header file.  */
#define HAVE_LIMITS_H 1

/* Define if you have the <locale.h> header file.  */
#define HAVE_LOCALE_H 1

/* Define if you have the <malloc.h> header file.  */
#undef HAVE_MALLOC_H

/* Define if you have the <nl_types.h> header file.  */
#undef HAVE_NL_TYPES_H

/* Define if you have the <stddef.h> header file.  */
#define HAVE_STDDEF_H 1

/* Define if you have the <stdlib.h> header file.  */
#define HAVE_STDLIB_H 1

/* Define if you have the <string.h> header file.  */
#define HAVE_STRING_H 1

/* Define if you have the <strings.h> header file.  */
#undef HAVE_STRINGS_H

/* Define if you have the <sys/file.h> header file.  */
#undef HAVE_SYS_FILE_H

/* Define if you have the <sys/param.h> header file.  */
#undef HAVE_SYS_PARAM_H

/* Define if you have the <sys/resource.h> header file.  */
#undef HAVE_SYS_RESOURCE_H

/* Define if you have the <sys/stat.h> header file.  */
#undef HAVE_SYS_STAT_H

/* Define if you have the <sys/time.h> header file.  */
#undef HAVE_SYS_TIME_H

/* Define if you have the <sys/times.h> header file.  */
#undef HAVE_SYS_TIMES_H

/* Define if you have the <time.h> header file.  */
#define HAVE_TIME_H 1

/* Define if you have the <unistd.h> header file.  */
#undef HAVE_UNISTD_H

/* Define to enable the use of a default linker. */
#undef DEFAULT_LINKER

/* Define to enable the use of a default assembler. */
#undef DEFAULT_ASSEMBLER

/* Define if you want more run-time sanity checks.  This one gets a grab
   bag of miscellaneous but relatively cheap checks. */
#undef ENABLE_CHECKING

/* Define if you want all operations on trees (the basic data
   structure of the front ends) to be checked for dynamic type safety
   at runtime.  This is moderately expensive. */
#undef ENABLE_TREE_CHECKING

/* Define if you want all operations on RTL (the basic data structure
   of the optimizer and back end) to be checked for dynamic type safety
   at runtime.  This is quite expensive. */
#undef ENABLE_RTL_CHECKING

/* Define if you want the garbage collector to do object poisoning and
   other memory allocation checks.  This is quite expensive. */
#undef ENABLE_GC_CHECKING

/* Define if you want the garbage collector to operate in maximally
   paranoid mode, validating the entire heap and collecting garbage at
   every opportunity.  This is extremely expensive. */
#undef ENABLE_GC_ALWAYS_COLLECT

/* Define if you want to use __cxa_atexit, rather than atexit, to
   register C++ destructors for local statics and global objects.
   This is essential for fully standards-compliant handling of
   destructors, but requires __cxa_atexit in libc. */
#undef DEFAULT_USE_CXA_ATEXIT

/* Define if you want the C and C++ compilers to support multibyte
   character sets for source code. */
#undef MULTIBYTE_CHARS

/* Define if your compiler understands volatile. */
#undef HAVE_VOLATILE

/* Define if your compiler supports the `long double' type. */
#undef HAVE_LONG_DOUBLE

/* Define if your compiler supports the `long long' type. */
#undef HAVE_LONG_LONG

/* Define if your compiler supports the `__int64' type. */
#undef HAVE___INT64

/* Define if the `_Bool' type is built-in. */
#undef HAVE__BOOL
#define HAVE__BOOL 0
#if (__GNUC__ >= 3)
#undef HAVE__BOOL
#define HAVE__BOOL 1
#endif

/* The number of bytes in type short */
#define SIZEOF_SHORT 2

/* The number of bytes in type int */
#define SIZEOF_INT 4

/* The number of bytes in type long */
#define SIZEOF_LONG 4

/* The number of bytes in type long long */
#undef SIZEOF_LONG_LONG

/* The number of bytes in type __int64 */
#undef SIZEOF___INT64

/* Define if the host execution character set is EBCDIC. */
#if defined(__MVS__) || defined(__CMS__) || defined(__VSE__)
#define HOST_EBCDIC 1
#endif

/* Always define this when using the GNU C Library */
#undef _GNU_SOURCE

/* Define if you have a working <stdbool.h> header file. */
#undef HAVE_STDBOOL_H

/* Define if you can safely include both <string.h> and <strings.h>. */
#undef STRING_WITH_STRINGS

/* Define as the number of bits in a byte, if `limits.h' doesn't. */
#undef CHAR_BIT

/* Define if the host machine stores words of multi-word integers in
   big-endian order. */
#define HOST_WORDS_BIG_ENDIAN 1

/* Define to the floating point format of the host machine, if not IEEE. */
#undef HOST_FLOAT_FORMAT

/* Define to 1 if the host machine stores floating point numbers in
   memory with the word containing the sign bit at the lowest address,
   or to 0 if it does it the other way around.

   This macro should not be defined if the ordering is the same as for
   multi-word integers. */
#undef HOST_FLOAT_WORDS_BIG_ENDIAN

/* Define if you have a working <inttypes.h> header file. */
#undef HAVE_INTTYPES_H

/* Define if printf supports %p. */
#define HAVE_PRINTF_PTR 1

/* Define if mmap can get us zeroed pages from /dev/zero. */
#undef HAVE_MMAP_DEV_ZERO

/* Define if mmap can get us zeroed pages using MAP_ANON(YMOUS). */
#undef HAVE_MMAP_ANON

/* Define if read-only mmap of a plain file works. */
#undef HAVE_MMAP_FILE

/* Define if you have the iconv() function. */
#undef HAVE_ICONV

/* Define as const if the declaration of iconv() needs const. */
#undef ICONV_CONST

/* Define to 1 if we found this declaration otherwise define to 0. */
#define HAVE_DECL_GETENV 1

/* Define to 1 if we found this declaration otherwise define to 0. */
#define HAVE_DECL_ATOL 1

/* Define to 1 if we found this declaration otherwise define to 0. */
#define HAVE_DECL_SBRK 0

/* Define to 1 if we found this declaration otherwise define to 0. */
#define HAVE_DECL_ABORT 1

/* Define to 1 if we found this declaration otherwise define to 0. */
#define HAVE_DECL_ATOF 1

/* Define to 1 if we found this declaration otherwise define to 0. */
#define HAVE_DECL_GETCWD 0

/* Define to 1 if we found this declaration otherwise define to 0. */
#define HAVE_DECL_GETWD 0

/* Define to 1 if we found this declaration otherwise define to 0. */
#define HAVE_DECL_STRSIGNAL 0

/* Define to 1 if we found this declaration otherwise define to 0. */
#define HAVE_DECL_PUTC_UNLOCKED 0

/* Define to 1 if we found this declaration otherwise define to 0. */
#define HAVE_DECL_FPUTS_UNLOCKED 0

/* Define to 1 if we found this declaration otherwise define to 0. */
#define HAVE_DECL_FWRITE_UNLOCKED 0

/* Define to 1 if we found this declaration otherwise define to 0. */
#define HAVE_DECL_FPRINTF_UNLOCKED 0

/* Define to 1 if we found this declaration otherwise define to 0. */
#define HAVE_DECL_STRSTR 1

/* Define to 1 if we found this declaration otherwise define to 0. */
#define HAVE_DECL_ERRNO 1

/* Define to 1 if we found this declaration otherwise define to 0. */
#define HAVE_DECL_MALLOC 1

/* Define to 1 if we found this declaration otherwise define to 0. */
#define HAVE_DECL_REALLOC 1

/* Define to 1 if we found this declaration otherwise define to 0. */
#define HAVE_DECL_CALLOC 1

/* Define to 1 if we found this declaration otherwise define to 0. */
#define HAVE_DECL_FREE 1

/* Define to 1 if we found this declaration otherwise define to 0. */
#define HAVE_DECL_BASENAME 0

/* Define to 1 if we found this declaration otherwise define to 0. */
#define HAVE_DECL_GETOPT 0

/* Define to 1 if we found this declaration otherwise define to 0. */
#define HAVE_DECL_CLOCK 0

/* Define to 1 if we found this declaration otherwise define to 0. */
#define HAVE_DECL_GETRLIMIT 0

/* Define to 1 if we found this declaration otherwise define to 0. */
#define HAVE_DECL_SETRLIMIT 0

/* Define to 1 if we found this declaration otherwise define to 0. */
#define HAVE_DECL_GETRUSAGE 1

/* Define to 1 if we found this declaration otherwise define to 0. */
#define HAVE_DECL_TIMES 1

/* Define if <sys/times.h> defines struct tms. */
#define HAVE_STRUCT_TMS 1

/* Define if <time.h> defines clock_t. */
#undef HAVE_CLOCK_T
#define HAVE_CLOCK_T

/* Define if host mkdir takes a single argument. */
#undef MKDIR_TAKES_ONE_ARG

/* Define if you have the iconv() function. */
#undef HAVE_ICONV

/* Define as const if the declaration of iconv() needs const. */
#undef ICONV_CONST

/* Define if you have <langinfo.h> and nl_langinfo(CODESET). */
#undef HAVE_LANGINFO_CODESET

/* Define if your <locale.h> file defines LC_MESSAGES. */
#undef HAVE_LC_MESSAGES

/* Define to 1 if translation of program messages to the user's native language
   is requested. */
#undef ENABLE_NLS

/* Define if you have the <libintl.h> header file. */
#undef HAVE_LIBINTL_H

/* Define if the GNU gettext() function is already present or preinstalled. */
#undef HAVE_GETTEXT

/* Define to use the libintl included with this package instead of any
   version in the system libraries. */
#undef USE_INCLUDED_LIBINTL

/* Define to 1 if installation paths should be looked up in Windows32
   Registry. Ignored on non windows32 hosts. */
#undef ENABLE_WIN32_REGISTRY

/* Define to be the last portion of registry key on windows hosts. */
#undef WIN32_REGISTRY_KEY

/* Define if your assembler supports .subsection and .subsection -1 starts
   emitting at the beginning of your section. */
#undef HAVE_GAS_SUBSECTION_ORDERING

/* Define if your assembler supports .weak. */
#undef HAVE_GAS_WEAK

/* Define if your assembler supports .hidden. */
#undef HAVE_GAS_HIDDEN

/* Define if your assembler supports .uleb128. */
#undef HAVE_AS_LEB128

/* Define if your assembler mis-optimizes .eh_frame data. */
#undef USE_AS_TRADITIONAL_FORMAT

/* Define if your assembler supports marking sections with SHF_MERGE flag. */
#undef HAVE_GAS_SHF_MERGE

/* Define if your assembler supports explicit relocations. */
#undef HAVE_AS_EXPLICIT_RELOCS

/* Define if your assembler supports .register. */
#undef HAVE_AS_REGISTER_PSEUDO_OP

/* Define if your assembler supports -relax option. */
#undef HAVE_AS_RELAX_OPTION

/* Define if your assembler and linker support unaligned PC relative relocs. */
#undef HAVE_AS_SPARC_UA_PCREL

/* Define if your assembler and linker support unaligned PC relative relocs against hidden symbols. */
#undef HAVE_AS_SPARC_UA_PCREL_HIDDEN

/* Define if your assembler supports offsetable %lo(). */
#undef HAVE_AS_OFFSETABLE_LO10

/* Define true if the assembler supports '.long foo@GOTOFF'. */
#if defined(I386)
#define HAVE_AS_GOTOFF_IN_DATA 0
#else
#undef HAVE_AS_GOTOFF_IN_DATA
#endif

/* Define if your assembler supports dwarf2 .file/.loc directives,
   and preserves file table indices exactly as given. */
#undef HAVE_AS_DWARF2_DEBUG_LINE

/* Define if your assembler supports the --gdwarf2 option. */
#undef HAVE_AS_GDWARF2_DEBUG_FLAG

/* Define if your assembler supports the --gstabs option. */
#undef HAVE_AS_GSTABS_DEBUG_FLAG

/* Define if your linker supports --eh-frame-hdr option. */
#undef HAVE_LD_EH_FRAME_HDR

/* Define 0/1 to force the choice for exception handling model. */
#undef CONFIG_SJLJ_EXCEPTIONS


/* Bison unconditionally undefines `const' if neither `__STDC__' nor
   __cplusplus are defined.  That's a problem since we use `const' in
   the GCC headers, and the resulting bison code is therefore type
   unsafe.  Thus, we must match the bison behavior here.  */

#ifndef __STDC__
#ifndef __cplusplus
#undef const
#define const
#endif
#endif

/* for some reason Cygwin uses this define as well,
   and we need to define it to stop strsignal
   gratuitously polluting our namespace */
#ifdef __CYGWIN32__
#ifndef _STRICT_ANSI
#define _STRICT_ANSI
#endif
#endif

#if defined(TARGET_CMS)
#include "cms.h"
#elif defined(TARGET_VSE)
#include "vse.h"
#else
#if !defined(S390) && !defined(I386)
#include "mvspdp.h"
#endif
#endif

#endif
