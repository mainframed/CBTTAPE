```
//***FILE 955 is from John C. Miller and contains his remote        *   FILE 955
//*           logging facility.  A more detailsd description        *   FILE 955
//*           follows, and you should look at member $$$DOC         *   FILE 955
//*           for more information                                  *   FILE 955
//*                                                                 *   FILE 955
//*     RMTLOG                                                      *   FILE 955
//*                                                                 *   FILE 955
//*     z/OS Remote Logging Facility v1.1                           *   FILE 955
//*     ---------------------------------                           *   FILE 955
//*                                                                 *   FILE 955
//*     09/12/2016                                                  *   FILE 955
//*     John C. Miller                                              *   FILE 955
//*     john@jmit.com                                               *   FILE 955
//*                                                                 *   FILE 955
//*     I - Overview                                                *   FILE 955
//*     ------------                                                *   FILE 955
//*                                                                 *   FILE 955
//*     RMTLOG is a z/OS started task that transmits z/OS           *   FILE 955
//*     console hardcopy messages to an external RFC 3164/5424      *   FILE 955
//*     compliant Syslog appliance or server.  Its purpose is to    *   FILE 955
//*     enhance z/OS security and auditability by establishing      *   FILE 955
//*     near real time logging to an external syslog server.        *   FILE 955
//*     Such a remote syslog appliance/server can be any device     *   FILE 955
//*     that is compliant with RFC 3164 and/or RFC 5424.  Unix      *   FILE 955
//*     and Linux servers are typically packaged with syslogd or    *   FILE 955
//*     syslog-ng, both of which are RFC compliant.                 *   FILE 955
//*                                                                 *   FILE 955
//*     RMTLOG also demonstrates useful assembler and z/OS          *   FILE 955
//*     programming techniques including:                           *   FILE 955
//*                                                                 *   FILE 955
//*     - Access Register programming;                              *   FILE 955
//*     - Extended MCS consoles, including the MCSOPER and          *   FILE 955
//*       MCSOPMSG macros for managing consoles and console         *   FILE 955
//*       message units;                                            *   FILE 955
//*     - TCPIP sockets programming;                                *   FILE 955
//*     - MVS start/stop interface (Handle START and STOP           *   FILE 955
//*       operator cmds.)                                           *   FILE 955
//*                                                                 *   FILE 955
//*     The two principal components required for z/OS remote       *   FILE 955
//*     logging are the RMTLOG z/OS started task running on         *   FILE 955
//*     z/OS, and the remote Syslog server compliant with RFC       *   FILE 955
//*     3164 and/or 5424.                                           *   FILE 955
//*                                                                 *   FILE 955
//*     COPYRIGHT, LICENSE AND WARRANTY:  This program is           *   FILE 955
//*     Copyright 2010-2017, John C. Miller.  This program is       *   FILE 955
//*     free software: you can redistribute it and/or modify it     *   FILE 955
//*     under the terms of the GNU General Public License           *   FILE 955
//*     version 3 as published by the Free Software Foundation.     *   FILE 955
//*     (See Appendix E.)                                           *   FILE 955
//*                                                                 *   FILE 955
//*     This program is distributed in the hope that it will be     *   FILE 955
//*     useful, but WITHOUT ANY WARRANTY; without even the          *   FILE 955
//*     implied warranty of MERCHANTABILITY or FITNESS FOR A        *   FILE 955
//*     PARTICULAR PURPOSE.  See the GNU General Public License     *   FILE 955
//*     for more details.                                           *   FILE 955
//*                                                                 *   FILE 955
//*     SUPPORT:                                                    *   FILE 955
//*     No support is provided for this software.  This software    *   FILE 955
//*     is a beta version, which means that it may have bugs,       *   FILE 955
//*     and has not been fully tested with all possible             *   FILE 955
//*     configurations and conditions.  While not required, it      *   FILE 955
//*     would be greatly appreciated if you sent your feedback      *   FILE 955
//*     to me.  email:  john@jmit.com                               *   FILE 955
//*                                                                 *   FILE 955

```
