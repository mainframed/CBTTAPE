Notice! This code __requires__ and will only run on a z9 or above.  It uses
Relative, Immediate, and Long Displacement instructions.  Use on a lower level
machine will result in a S0C1 abend.

This is an alpha version of my UNIX tools. Many of the files are simply
skeletons at present. Only a few work completely. The man pages
(documentation) are definitely a work in progress.

Note that the assembler source is not formatted properly to be read using only
ASMA90. It requires that you have FLOWASM installed in either a library in the
link list, or in a library assigned to the UNIX STEPLIB environment variable.
The system is set up to do compiles in a UNIX shell by using the make command,
which references the makefile file.

You start by changing the UNPAX job to point to an existant UNIX subdirectory
in which a new subdirectory called utilities-1 will be created. The files in
the pax archive, member UTILPAXZ, will be extracted into this directory.

Once you have extracted the files, you may run the job in the member MAKEALL
to compile and link all the programs. You need to change this job to point to
the same subdirectory as in the UNPAX job.  The output will be placed in this
same subdirectory.  This is not really necessary because the executable
programs are already in the subdirectory.

There are many extraneous files in this subdirectory because I haven't cleaned
it up yet. The ones which actually work are:

ams -
      Invokes the IDCAMS batch program, redirecting SYSIN from the
      UNIX "stdin" and the SYSPRINT to "stdout". The source is in ams.s.

isgquery -
      is a DLL used by lsenq which does the ISGQUERY macro. The source is in
      isgquery.s.

lsdasd -
      Lists the volume serials for on-line DASD volumes.  The command
      will accept parameters. It will accept any number of patterns
      for the volume serials upon which to report. If a volume matches
      more than one pattern, it will only be reported on once.  The
      program accepts only two wild cards. This is very similar to
      standard UNIX shell file name expansion called "globbing".  The
      * matches zero or more characters.  The ?  matches any single
      character. Since a volume serial is exactly 6 characters in
      length; (1) any volume parameter greater than 6 characters will
      be reported as an error; (2) any volume parameter less than 6
      characters will be assumed to have a trailing asterisk, unless
      it already has a trailing asterisk.

      CRITICAL!! Please realize that the shell uses these same
      characters for its wild card expansion as well. This means that
      you really should either "escape" any wild cards in the pattern
      by prefixing all * and ? characters with a backslash \.  Or,
      more easily, stop shell expansion by surrounding any pattern
      with a wild card with a single or double quote character: ' or
      ". E.g lsdasd tx\?5 or lsdasd 'tx?5'.

      The -d option will enable a line for each on-line volume about
      the result results of each of the specified patterns tested.
      This means that the debugging for the pattern matching for a
      volume serial stops on the first successful pattern match for
      that volume seria.

      The -n option causes the program to output two fields per line.
      The first is the volume serial. The second is the device number.
      They are separated by a tab character.

      The -l option does an LSPACE (List Space) on each of the
      matching volumes and writes that information on the same line as
      the volume serial number and device number. The first line is a
      header line which labels what the value in each field is.

      The -c option returns a single line of output. This contains two
      numbers, separated with a tab.  The first number is the number
      of on line volumes whose serial matches the given pattern(s). The second
      number is the total number of online DASD volumes.

      I hope, some day, to include the storage group name for SMS managed
      volumes in the output.

      Syntax: lsdasd ÝOPTION¨... ÝVOLUME¨...

finducbs -
      This is a subroutine, which is packaged as a z/OS UNIX DLL.  It
      is named finducbs.dll. I made it a DLL so that it can be called
      dynamically. There is also a finducbs.o which can be statically
      bound into the application.

      The on-line DASD volumes are found by using the UCBSCAN macro.

      If the program encounters no critical errors, it will return
      with a return code of zero in the 32 bit GPR15 and two unsigned
      halfwords concatenated into the 32 bit GPR0. The code in the 32
      bit GPR0 has the number of DASD volumes which matched the given
      pattern(s) in the high order halfword (bits 32..47 of the 64 bit
      register) and the total number of online DASD volumes in the low
      order halfword (bits 48..63 of the 64 bit register).  The high
      word of the 64 bit GPR0 (bits 0..31) are not disturbed.  The
      program calls a user-supplied address of an LE enable subroutine
      for each UCB which matches any of the supplied volsers or volser
      pattern. This subroutine is passed three parameters. The first is
      the address of the UCB. The second is the address of the DCE.
      The third is a 32 bit fullword which was passed to the finducbs
      function as the second fullword in the input parameter list.
      This is invoked using the CALL macro using standard z/OS linkage
      conventions.

      However, if the exit address is zero (which it will be unless
      specifically set to some other value as shown below) , it is a
      special case and the code will not attempt to do the CALL.

      If the program does encounter some error, the value in the 32
      bit GPR15 will conain a return code and the contents of GPR0 as
      described above will contain information as of the time of the
      error.

      Return Codes:
      0 means that one or more DASD volumes matched the pattern(s)
      given to the routine.
      1 means that no volumes matched the pattern(s) given.

      The parameter list is very unusual, mainly due to my laziness.
      The first two fullwords are: (1) the address of a subroutine
      which is given control for each matching UCB and (2) a fullword
      containing an arbitrary value which is simply passed to the
      subroutine. The remainder is similar to the parameter list
      format which z/OS UNIX uses when it gives control to z/OS UNIX
      command.  The actual values, addressed via the @ARGV array,
      below, contain either volser or volser patterns.  The volser
      patterns will have one or more "wild card" characters. The
      asterisk (*) indicates zero or more characters.  The question
      mark (?) indicates any one character.  The mattern matching is
      done by the ASAXWC macro. This macro is not formally
      documentated.  It resides in SYS1.MODGEN.  The only place that I
      have found information on it is in the macro itself and in a
      article from Xephon in file mvs0305.pdf from
      www.cbttape.org/xephon/xephonm/mvs0305.pdf The pattern matching
      is only done until the first match.

      It looks like:

FINDUCBP DSECT
@CALLBACK DS   A                  ADDRESS OF SUBROUTINE
USERWORD DS    F                  ARBITRARY FULLWORD PASSED TO
*                                 THE SUBROUTINE AS ITS 3RD PARAMETER
@ARGC    DS    A                  ADDRESS OF NUMBER OF ARGUMENTS
@ARGVL   DS    A                  ADDRESS OF VECTOR OF LENGTH OF ARGS
@ARGV    DS    A                  ADDRESS OF VECTOR OF ARGS

      Please look at the source code to lsdasd for an example. Or use
      the z/OS UNIX man command: man 3 finducbs to see an example.

lsenq -
      Lists enqueue information. You can specify a resource name, with
      wildcarding. You may also specify an queue name. If a queue name
      is not specified, it defaults to SYSDSN. The queue name can also
      be wild carded.  Also, if (and only if) the queue name is
      defaulted, the resource name is assumed to be a dataset name and
      is upper cased. The program uses the ISGQUERY routine in the
      isgquery.dll to scan the ENQ chain for the given parameter(s). If
      no parameters are given, or an invalid parameter is given, a
      message is written to stderr and a non-zero status code is
      returned.

      Syntax: lsenq ÝÝqname¨ rname¨.

      You may specify 0, 1, or 2 parameters. If you specify no
      parameters, a short help is written. If you specify a single
      parameter, it is assumed to be the rname with an implied qname
      of SYSDSN. Also, in this case, the name is automatically upper
      cased. If you specify 2 parameters, they are assumed to be the
      qname and the rname, in that order. They are not upper cased.

mkjcl -
      is a shell script, not a compiled program. It reads a "template"
      file, which is specified on the command line, and modifies it by
      replacing embedded UNIX-style variables with their values. It
      writes its output to "stdout" so that it may be piped to a
      subsequent command, such as "submit". The variables are passed
      to the command as shell environment variables, via the export
      command, or on the command line itself. This is the normal way
      that named variables are done in UNIX.  An example of a template
      jcl is supplied in the "iefbr14.jcl" file.

All files which have file name of SKELETON are just that, my SKELETON which I
files use as the basis for the actual program code. The suffix specifies
es the language.

".a" for "library archive" files (which contain object code for subroutines
which are "statically linked").

".awk" for awk source files.

".cat?" for "compiled" man files. These files are actually symlinks to the
actual files in the man/cat? subdirectory. The files in the man/cat?
subdirectory have a ".?" extention instead of ".cat?". The "?" is a number from
1 to 9. These files are created from the corresponding ".man?" file, which is
kept in the man/man? subdirectory. Unfortunately, this cannot be done on z/OS
using any integrated command(s). You would need to get a version of groff from
the "z/OS Tools and Toys" web site.

".dll" for Dynamic Link Libraries. These are like DLLs in MS-Windows, or .so
files in Linux and some UNIX system. They are files which contain 1 or more
subroutines and/or data areas, which are "shared" and dynamically loaded.  Each
".dll" should have a corresponding ".x" file.

".man?" for man source files. These files are actually symlinks to the actual
files in the man/man? subdirectory. The files in the man/man? subdirectory have
a ".?" extention instead of ".man?". The "?" is a number from 1 to 9.

".o" for compiled object files.

".pl" for Perl source files.

".rexx" for rexx programs.

".s" for HLASM source files.

".sh" for shell script files

".x" are DLL side files. They contain binder control information which tell the
binder the name of the DLL to use and the exported names in that DLL. They are
used like a ".o" file by the binder.

Some of the other ".s" files are for things I am still planning for.

"ftee" will be like the UNIX "tee" command, but will support sending
output to a z/OS dataset or a UNIX file, unlike the "tee" command which
can only write to a UNIX file.

"lsvtoc" will display the VTOC of the specified volume(s) in a format
similar to the ISPF 3.4 display.

"mcsoper" will create a "line mode" z/OS operator console, reminiscent
of the old "3215" type printer/keyboard consoles. This will be based on
the "mcsoper" macro. This is low priority since I use SMCS consoles for
remote operations. The main use of this would be for primitive automated
operations. Since this command will write the console traffic to the
"stdout", that would allow it to be piped to another command, such as a
Perl or awk program, which would use the mgcre command to issue z/OS
operator commands. Given the existance of TSSO, and System REXX, this
is likely unneeded.

"mgcre" will be a way to issue z/OS operator commands, using the "mgcre"
macro.

"rmjes" will be a way to purge entries from the SPOOL. This command is
actually to complete the facilities available from Dovetailed
Technologies in their Data Set Pipes set of utilities, which can list
SPOOL entries and read data from the SPOOL (such as job output) and send
it to "stdout".

"s0c1" is simply a program which generates an S0C1 abend so that I could
look at an LE dump for learning purposes.

"uaudit" is a terror command to turn the UAUDIT bit in the user's ACEE
on and off. I am not really likely to implement this.

