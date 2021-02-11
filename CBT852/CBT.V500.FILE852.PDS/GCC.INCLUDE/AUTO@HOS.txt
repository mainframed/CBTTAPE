/* auto-host.h.  Generated automatically by configure.  */
/* config.in.  Generated automatically from configure.in by autoheader.  */

/* Define if using alloca.c.  */
/* #undef C_ALLOCA */

/* Define to empty if the keyword does not work.  */
/* #undef const */

/* Define to one of _getb67, GETB67, getb67 for Cray-2 and Cray-YMP systems.
   This function is required for alloca.c support on those systems.  */
/* #undef CRAY_STACKSEG_END */

/* Define to the type of elements in the array set by `getgroups'.
   Usually this is either `int' or `gid_t'.  */
#define GETGROUPS_T gid_t

/* Define to `int' if <sys/types.h> doesn't define.  */
/* #undef gid_t */

/* Define if you have alloca, as a function or macro.  */
/*#define HAVE_ALLOCA 1*/

/* Define if you have <alloca.h> and it should be used (not on Ultrix).  */
/*#define HAVE_ALLOCA_H 1*/

/* Define if you have the ANSI # stringizing operator in cpp. */
#define HAVE_STRINGIZE 1

/* Define if you have <sys/wait.h> that is POSIX.1 compatible.  */
/* #define HAVE_SYS_WAIT_H 1 */

/* Define if you have <vfork.h>.  */
/* #undef HAVE_VFORK_H */

/* Define as __inline if that's what the C compiler calls it.  */
/* #undef inline */

/* Define if your C compiler doesn't accept -c and -o together.  */
/* #undef NO_MINUS_C_MINUS_O */

/* Define to `long' if <sys/types.h> doesn't define.  */
/* #undef off_t */

/* Define to `int' if <sys/types.h> doesn't define.  */
/* #undef pid_t */

/* Define to `unsigned' if <sys/types.h> doesn't define.  */
/* #undef size_t */

/* If using the C implementation of alloca, define if you know the
   direction of stack growth for your system; otherwise it will be
   automatically deduced at run-time.
 STACK_DIRECTION > 0 => grows toward higher addresses
 STACK_DIRECTION < 0 => grows toward lower addresses
 STACK_DIRECTION = 0 => direction of growth unknown
 */
/* #undef STACK_DIRECTION */

/* Define if you have the ANSI C header files.  */
#define STDC_HEADERS 1

/* Define if you can safely include both <sys/time.h> and <time.h>.  */
/* #define TIME_WITH_SYS_TIME 1 */

/* Define to `int' if <sys/types.h> doesn't define.  */
/* #undef uid_t */

/* Define vfork as fork if vfork does not work.  */
/* #undef vfork */

/* Define if your assembler supports specifying the maximum number
   of bytes to skip when using the GAS .p2align command.  */
/* #undef HAVE_GAS_MAX_SKIP_P2ALIGN */

/* Define if your assembler supports .balign and .p2align.  */
/* #undef HAVE_GAS_BALIGN_AND_P2ALIGN */

/* Define if your assembler uses the old HImode fild and fist notation.  */
/* #undef HAVE_GAS_FILDS_FISTS */

/* Define to `int' if <sys/types.h> doesn't define.  */
/* #undef ssize_t */

/* Define if cpp should also search $prefix/include.  */
/* #define PREFIX_INCLUDE_DIR "/phil/include" */

/* Define if you have the __argz_count function.  */
/* #undef HAVE___ARGZ_COUNT */

/* Define if you have the __argz_next function.  */
/* #undef HAVE___ARGZ_NEXT */

/* Define if you have the __argz_stringify function.  */
/* #undef HAVE___ARGZ_STRINGIFY */

/* Define if you have the atoll function.  */
/* #undef HAVE_ATOLL */

/* Define if you have the atoq function.  */
/* #undef HAVE_ATOQ */

/* Define if you have the clock function.  */
/* #define HAVE_CLOCK 1 */

/* Define if you have the dcgettext function.  */
/* #define HAVE_DCGETTEXT 1 */

/* Define if you have the dup2 function.  */
/* #define HAVE_DUP2 1 */

/* Define if you have the feof_unlocked function.  */
/* #undef HAVE_FEOF_UNLOCKED */

/* Define if you have the fgets_unlocked function.  */
/* #undef HAVE_FGETS_UNLOCKED */

/* Define if you have the fprintf_unlocked function.  */
/* #undef HAVE_FPRINTF_UNLOCKED */

/* Define if you have the fputc_unlocked function.  */
/* #undef HAVE_FPUTC_UNLOCKED */

/* Define if you have the fputs_unlocked function.  */
/* #undef HAVE_FPUTS_UNLOCKED */

/* Define if you have the fwrite_unlocked function.  */
/* #undef HAVE_FWRITE_UNLOCKED */

/* Define to enable the use of a default linker. */
/* #undef DEFAULT_LINKER */

/* Define to enable the use of a default assembler. */
/* #undef DEFAULT_ASSEMBLER */

/* Define if you want more run-time sanity checks.  This one gets a grab
   bag of miscellaneous but relatively cheap checks. */
/* #undef ENABLE_CHECKING */

/* Define if you want all operations on trees (the basic data
   structure of the front ends) to be checked for dynamic type safety
   at runtime.  This is moderately expensive. */
/* #undef ENABLE_TREE_CHECKING */

/* Define if you want all operations on RTL (the basic data structure
   of the optimizer and back end) to be checked for dynamic type safety
   at runtime.  This is quite expensive. */
/* #undef ENABLE_RTL_CHECKING */

/* Define if you want the garbage collector to do object poisoning and
   other memory allocation checks.  This is quite expensive. */
/* #undef ENABLE_GC_CHECKING */

/* Define if you want the garbage collector to operate in maximally
   paranoid mode, validating the entire heap and collecting garbage at
   every opportunity.  This is extremely expensive. */
/* #undef ENABLE_GC_ALWAYS_COLLECT */

/* Define if you want to use __cxa_atexit, rather than atexit, to
   register C++ destructors for local statics and global objects.
   This is essential for fully standards-compliant handling of
   destructors, but requires __cxa_atexit in libc. */
/* #undef DEFAULT_USE_CXA_ATEXIT */

/* Define if you want the C and C++ compilers to support multibyte
   character sets for source code. */
/* #undef MULTIBYTE_CHARS */

/* Define if your compiler understands volatile. */
#define HAVE_VOLATILE 1

/* Define if your compiler supports the `long double' type. */
#define HAVE_LONG_DOUBLE 1

/* Define if your compiler supports the `long long' type. */
/* #define HAVE_LONG_LONG 1 */

/* Define if your compiler supports the `__int64' type. */
/* #undef HAVE___INT64 */

/* Define if the `_Bool' type is built-in. */
/*#define HAVE__BOOL 1*/

/* The number of bytes in type short */
#define SIZEOF_SHORT 2

/* The number of bytes in type int */
#define SIZEOF_INT 4

/* The number of bytes in type long */
#define SIZEOF_LONG 4

/* The number of bytes in type long long */
#define SIZEOF_LONG_LONG 8

/* The number of bytes in type __int64 */
/* #undef SIZEOF___INT64 */

/* Define if the host execution character set is EBCDIC. */
/* #undef HOST_EBCDIC */

/* Always define this when using the GNU C Library */
/* #undef _GNU_SOURCE */

/* Define if you have a working <stdbool.h> header file. */
/*#define HAVE_STDBOOL_H 1*/

/* Define if you can safely include both <string.h> and <strings.h>. */
/* #define STRING_WITH_STRINGS 1*/

/* Define as the number of bits in a byte, if `limits.h' doesn't. */
/* #undef CHAR_BIT */

/* Define if the host machine stores words of multi-word integers in
   big-endian order. */
/* #undef HOST_WORDS_BIG_ENDIAN */

/* Define to the floating point format of the host machine, if not IEEE. */
/* #undef HOST_FLOAT_FORMAT */

/* Define to 1 if the host machine stores floating point numbers in
   memory with the word containing the sign bit at the lowest address,
   or to 0 if it does it the other way around.

   This macro should not be defined if the ordering is the same as for
   multi-word integers. */
/* #undef HOST_FLOAT_WORDS_BIG_ENDIAN */

/* Define if you have a working <inttypes.h> header file. */
/* #undef HAVE_INTTYPES_H */

/* Define if printf supports %p. */
#define HAVE_PRINTF_PTR 1

/* Define to be the last portion of registry key on windows hosts. */
#define WIN32_REGISTRY_KEY "3.2.3"

/* Define if your assembler supports .subsection and .subsection -1 starts
   emitting at the beginning of your section. */
/* #undef HAVE_GAS_SUBSECTION_ORDERING */

/* Define if your assembler supports .weak. */
/* #undef HAVE_GAS_WEAK */

/* Define if your assembler supports .hidden. */
/* #undef HAVE_GAS_HIDDEN */

/* Define if your assembler supports .uleb128. */
/* #undef HAVE_AS_LEB128 */

/* Define if your assembler mis-optimizes .eh_frame data. */
/* #undef USE_AS_TRADITIONAL_FORMAT */

/* Define if your assembler supports marking sections with SHF_MERGE flag. */
/* #undef HAVE_GAS_SHF_MERGE */

/* Define if your assembler supports explicit relocations. */
/* #undef HAVE_AS_EXPLICIT_RELOCS */

/* Define if your assembler supports .register. */
/* #undef HAVE_AS_REGISTER_PSEUDO_OP */

/* Define if your assembler supports -relax option. */
/* #undef HAVE_AS_RELAX_OPTION */

/* Define if your assembler and linker support unaligned PC relative relocs. */
/* #undef HAVE_AS_SPARC_UA_PCREL */

/* Define if your assembler and linker support unaligned PC relative relocs against hidden symbols. */
/* #undef HAVE_AS_SPARC_UA_PCREL_HIDDEN */

/* Define if your assembler supports offsetable %lo(). */
/* #undef HAVE_AS_OFFSETABLE_LO10 */

/* Define true if the assembler supports '.long foo@GOTOFF'. */
/* #undef HAVE_AS_GOTOFF_IN_DATA */

/* Define if your assembler supports dwarf2 .file/.loc directives,
   and preserves file table indices exactly as given. */
/* #undef HAVE_AS_DWARF2_DEBUG_LINE */

/* Define if your assembler supports the --gdwarf2 option. */
/* #undef HAVE_AS_GDWARF2_DEBUG_FLAG */

/* Define if your assembler supports the --gstabs option. */
/* #undef HAVE_AS_GSTABS_DEBUG_FLAG */

/* Define if your linker supports --eh-frame-hdr option. */
/* #undef HAVE_LD_EH_FRAME_HDR */

/* Define 0/1 to force the choice for exception handling model. */
/* #undef CONFIG_SJLJ_EXCEPTIONS */


/* Bison unconditionally undefines `const' if neither `__STDC__' nor
   __cplusplus are defined.  That's a problem since we use `const' in
   the GCC headers, and the resulting bison code is therefore type
   unsafe.  Thus, we must match the bison behavior here.  */

#ifndef __STDC__
#ifndef __cplusplus
/* #undef const */
#define const
#endif
#endif
