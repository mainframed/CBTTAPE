
## @FILE889.txt
```
//***FILE 889 is the Microsoft install version of the Hercules      *   FILE 889
//*           emulator, 64-bit version.  Just download in BINARY    *   FILE 889
//*           to a PC, and unzip into a directory on the PC.        *   FILE 889
//*           The Hercules version 3.08 should run, as is, on       *   FILE 889
//*           Windows 7 (and probably on the other recent Windows   *   FILE 889
//*           versions as well).  This is the 64-bit version.       *   FILE 889
//*                                                                 *   FILE 889
//*           Version 3.12 of the Hercules emulator, for Windows,   *   FILE 889
//*           is now included here, as members H312W32 (32-bit)     *   FILE 889
//*           and H32W64 (64-bit).  Fish's DLLs are not included    *   FILE 889
//*           in these 2 members, but they are included in member   *   FILE 889
//*           HERC308.  If you want them in 3.12 you will have to   *   FILE 889
//*           transplant them from 3.08.                            *   FILE 889
//*                                                                 *   FILE 889
//*           An alternative version of Hercules, Version 4.x.x,    *   FILE 889
//*           is available at the following site:                   *   FILE 889
//*                                                                 *   FILE 889
//*                 https://hercules-390.github.io/html/            *   FILE 889
//*                                                                 *   FILE 889
//*           If you have the proper version of REVIEW installed    *   FILE 889
//*           (including MINIZIP and MINIUNZ) (CBT Files 134 and    *   FILE 889
//*           865, load modules on File 135), then you can REVIEW   *   FILE 889
//*           member HERC308 in this file, and see the zipped       *   FILE 889
//*           files within it.                                      *   FILE 889
//*                                                                 *   FILE 889
//*           Other compiles of Hercules for different platforms    *   FILE 889
//*           and for 32-bit machines, may be found on the          *   FILE 889
//*           Hercules web site.  See below.                        *   FILE 889
//*                                                                 *   FILE 889
//*           You are responsible for supplying operating system    *   FILE 889
//*           DASD as PC files in AWS format, and you are           *   FILE 889
//*           responsible for creating a valid Hercules config      *   FILE 889
//*           file for the Hercules program to point to.            *   FILE 889
//*                                                                 *   FILE 889
//*           Remember that IBM will not license its proprietary    *   FILE 889
//*           operating systems for use on Hercules under most      *   FILE 889
//*           circumstances.  MVS 3.8J may be run under Hercules    *   FILE 889
//*           without any licensing problems.                       *   FILE 889
//*                                                                 *   FILE 889
//*           A suggestion would be for you to Google search for    *   FILE 889
//*           "Hercules emulator" to get to the current web site    *   FILE 889
//*           where instructions for using this version of          *   FILE 889
//*           Hercules may be obtained.  As of this writing, one    *   FILE 889
//*           of them is:                                           *   FILE 889
//*                                                                 *   FILE 889
//*           www.hercules-390.eu      (You need to say www. )      *   FILE 889
//*                                                                 *   FILE 889
//*           From a DOS shell on a Windows machine, the start      *   FILE 889
//*           command to get Hercules going, is:                    *   FILE 889
//*                                                                 *   FILE 889
//*           C:\directory>hercules -f full.path.of.config.file     *   FILE 889
//*                                                                 *   FILE 889
//*           where c:\directory is the directory that you unzipped *   FILE 889
//*           the HERC308 file into.  Of course, it may be on       *   FILE 889
//*           a disk other than c: and it will probably have a      *   FILE 889
//*           different name.                                       *   FILE 889
//*                                                                 *   FILE 889
//*           If this command is successful, your DOS shell screen  *   FILE 889
//*           will become your Hercules console.  You can then      *   FILE 889
//*           enter IPL nnn to IPL your IPL-able disk pack, as per  *   FILE 889
//*           how your config file was set up.                      *   FILE 889
//*                                                                 *   FILE 889
//*           If your TN3270 emulator was properly set up, you      *   FILE 889
//*           will get a Hercules introductory screen on it, as     *   FILE 889
//*           follows:  This will later become your MVS console,    *   FILE 889
//*           after you issue the ipl nnn instruction. See below.   *   FILE 889
//*                                                                 *   FILE 889
//*   Hercules Version  : 3.08                                      *   FILE 889
//*   Host name         : MY-PC                                     *   FILE 889
//*   Host OS           : Windows_NT-6 1                            *   FILE 889
//*   Host Architecture : AMD64                                     *   FILE 889
//*   Processors        : MP=4                                      *   FILE 889
//*   Chanl Subsys      : 0                                         *   FILE 889
//*   Device number     : 0700                                      *   FILE 889
//*   Subchannel        : 001A                                      *   FILE 889
//*                                                                 *   FILE 889
//*       HHH          HHH   The S/370, ESA/390 and z/Architecture  *   FILE 889
//*       HHH          HHH                 Emulator                 *   FILE 889
//*       HHH          HHH                                          *   FILE 889
//*       HHH          HHH  EEEE RRR   CCC U  U L    EEEE  SSS      *   FILE 889
//*       HHHHHHHHHHHHHHHH  E    R  R C    U  U L    E    S         *   FILE 889
//*       HHHHHHHHHHHHHHHH  EEE  RRR  C    U  U L    EEE   SS       *   FILE 889
//*       HHHHHHHHHHHHHHHH  E    R R  C    U  U L    E       S      *   FILE 889
//*       HHH          HHH  EEEE R  R  CCC  UU  LLLL EEEE SSS       *   FILE 889
//*       HHH          HHH                                          *   FILE 889
//*       HHH          HHH                                          *   FILE 889
//*       HHH          HHH     My PC thinks it's a MAINFRAME        *   FILE 889
//*                                                                 *   FILE 889
//*   Copyright (c) 1999-2009 Roger Bowler, Jan Jaeger, and others  *   FILE 889
//*                                                                 *   FILE 889
//*           If you want to run FTP to/from Hercules, you need     *   FILE 889
//*           to install Win-P-Cap (a binary is on File 659) on     *   FILE 889
//*           your PC.  The "Fish DLL's" are all here on this       *   FILE 889
//*           file, and they should work as packaged, without a     *   FILE 889
//*           separate install procedure.  These have been          *   FILE 889
//*           included here with the kind permission of their       *   FILE 889
//*           author, David Trout (aka "Fish").                     *   FILE 889
//*                                                                 *   FILE 889
//*           You also need a TN3270 emulator (a recommended one    *   FILE 889
//*           is VISTA from www.tombrennansoftware.com).  The       *   FILE 889
//*           TN3270 emulator needs to point to the IP address      *   FILE 889
//*           (in the PC) of the network card (use the              *   FILE 889
//*           ipconfig/all command from a DOS shell and look at     *   FILE 889
//*           the IP4 address on the active card you want to use).  *   FILE 889
//*           You can also see the MAC address of this card, which  *   FILE 889
//*           you will later need on the config file, to run FTP.   *   FILE 889
//*                                                                 *   FILE 889
//*           Alternatively, you can use the IP address 127.0.0.1   *   FILE 889
//*           to point to localhost on the PC.  And in either       *   FILE 889
//*           case, you have to specify port 3270 (NOT PORT 23)     *   FILE 889
//*           in the TN3270 emulator.  Once Hercules starts, it     *   FILE 889
//*           should grab the TN3270 terminal emulator as the       *   FILE 889
//*           operator console if the TN3270 emulator was set up    *   FILE 889
//*           properly.                                             *   FILE 889
//*                                                                 *   FILE 889
//*           Then from the DOS shell, which has now become the     *   FILE 889
//*           Hercules console, you now say:  ipl nnnn    where     *   FILE 889
//*           nnnn is the address of the system residence pack      *   FILE 889
//*           which is specified in the config file.  The further   *   FILE 889
//*           particulars are operating system dependent.           *   FILE 889
//*                                                                 *   FILE 889
```

