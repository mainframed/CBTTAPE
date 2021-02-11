```
//***FILE 629 contains an SNTP server from Andrew Armstrong.        *   FILE 629
//*                                                                 *   FILE 629
//*           Andrew Armstrong                                      *   FILE 629
//*           Systems Programmer                                    *   FILE 629
//*           email: a.armstrong@optusnet.com.au                    *   FILE 629
//*           or: aarmstrong@mail.fairfax.com.au                    *   FILE 629
//*           or: arms1and@police.nsw.gov.au                        *   FILE 629
//*                                                                 *   FILE 629
//*     NAME     - SNTPD                                            *   FILE 629
//*                                                                 *   FILE 629
//*     TITLE    - SIMPLE NETWORK TIME DAEMON (SNTPD)               *   FILE 629
//*                                                                 *   FILE 629
//*     VERSION  - 1.0                                              *   FILE 629
//*                                                                 *   FILE 629
//*     FUNCTION - This is a Simple Network Time Protocol           *   FILE 629
//*                (SNTPv3) server as defined by RFC2030 (which     *   FILE 629
//*                defines SNTPv4, but this server does not         *   FILE 629
//*                implement any of the SNTPv4 optional             *   FILE 629
//*                extensions).                                     *   FILE 629
//*                                                                 *   FILE 629
//*                This SNTP server listens for UDP packets on      *   FILE 629
//*                port 123 and responds the current TOD clock      *   FILE 629
//*                time to any NTP v1, v2, v3, or v4 client to      *   FILE 629
//*                a precision of 2 microseconds.                   *   FILE 629
//*                                                                 *   FILE 629
//*     MEMBERS  - The list of members in the distribution PDS      *   FILE 629
//*                are:                                             *   FILE 629
//*                                                                 *   FILE 629
//*                $$$DOC   - This file.                            *   FILE 629
//*                ASM      - JCL to assemble/link the SNTP         *   FILE 629
//*                           server.                               *   FILE 629
//*                C2X      - Macro to convert binary to            *   FILE 629
//*                           displayable hex.                      *   FILE 629
//*                DEBUG    - Macro to assemble debug code.         *   FILE 629
//*                EYECATCH - Macro to assemble an eye-catcher.     *   FILE 629
//*                GETCMD   - Source code to obtain the next        *   FILE 629
//*                           operator command.                     *   FILE 629
//*                GPL      - The GNU General Public License.       *   FILE 629
//*                LOG      - Macro to conditionally print a        *   FILE 629
//*                           log message.                          *   FILE 629
//*                RFC2030  - The SNTPv4 Request For Comments.      *   FILE 629
//*                RUNJOB   - JCL to run the SNTP server as a       *   FILE 629
//*                           job.                                  *   FILE 629
//*                RUNPROC  - JCL to run the SNTP server as a       *   FILE 629
//*                           proc (TCPSNTP).                       *   FILE 629
//*                SAY      - Macro to print a formatted log        *   FILE 629
//*                           message.                              *   FILE 629
//*                SNTPD    - Source code for the SNTP server.      *   FILE 629
//*                TCPSNTP  - JCL for the SNTP server proc.         *   FILE 629
//*                                                                 *   FILE 629

```
