
## @FILE918.txt
```
//***FILE 918 is from John McKown and contains the executables for  *   FILE 918
//*           a port of BASH 4.2 to z/OS.  This code was compiled   *   FILE 918
//*           and tested on z/OS 2.1.                               *   FILE 918
//*                                                                 *   FILE 918
//*           The patch level of the code is at patch level 53.     *   FILE 918
//*                                                                 *   FILE 918
//*           This software is licensed under the GPL. If you want  *   FILE 918
//*           the source, it is available on this site in File 919. *   FILE 918
//*                                                                 *   FILE 918
//*           Included in this file are the executables only.       *   FILE 918
//*                                                                 *   FILE 918
//*           email:  john.archie.mckown@gmail.com                  *   FILE 918
//*                                                                 *   FILE 918
//*     Description of Release Level 4.2.53.                        *   FILE 918
//*                                                                 *   FILE 918
//*     This is a port of BASH 4.2, patch level 53, to the z/OS     *   FILE 918
//*     UNIX environment. It should work substantially like it      *   FILE 918
//*     does on other platforms. This includes all of the           *   FILE 918
//*     current patches, including the one for the SHELLSHOCK       *   FILE 918
//*     exploit. Of course, this functionality only applies to      *   FILE 918
//*     the BASH shell, and does not supply other GNU utilities     *   FILE 918
//*     such as GNU grep, sed, gawk, and so on. This port was       *   FILE 918
//*     developed on z/OS 2.1 and has been successfully tested      *   FILE 918
//*     on both z/OS 2.1 and 1.12. It may, or may not, work on      *   FILE 918
//*     z/OS releases prior to 1.12. It does not have any           *   FILE 918
//*     release dependent code it in, but it may have implicit      *   FILE 918
//*     dependencies in Language Environment levels due to it       *   FILE 918
//*     being written in C. This port does _NOT_ implement the      *   FILE 918
//*     "local spawn" functionality which the standard /bin/sh      *   FILE 918
//*     shell for z/OS UNIX does. This means that the               *   FILE 918
//*     _BPX_SHAREAS environment variable has no effect and         *   FILE 918
//*     there is no way to share an address space with the          *   FILE 918
//*     shell process. This could have an impact on performance     *   FILE 918
//*     and functionality of some UNIX commands and shell           *   FILE 918
//*     scripts. This lack does not stop the sharing of an          *   FILE 918
//*     address space by UNIX commands run under BASH. That is,     *   FILE 918
//*     the command can share its (not BASH's) address space by     *   FILE 918
//*     use of the _BPX_SHAREAS and the spawn() functionality.      *   FILE 918
//*     Assuming that said command is set up to do so. BASH         *   FILE 918
//*     neither enables nor disables another command's ability      *   FILE 918
//*     in this respect. One other possible "gotcha" is that        *   FILE 918
//*     many shell scripts start with a line like: "#!/bin/sh".     *   FILE 918
//*     This is supported by BASH, but results in the script        *   FILE 918
//*     running under the IBM supplied /bin/sh instead of under     *   FILE 918
//*     BASH.                                                       *   FILE 918
//*                                                                 *   FILE 918
```

