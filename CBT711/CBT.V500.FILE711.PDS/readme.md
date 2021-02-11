
## @FILE711.txt
```
//***FILE 711 is a very useful LIBRARIAN program package, and which *   FILE 711
//*           is completely new at this time (Mar/06). The package  *   FILE 711
//*           is being contributed semi-anonymously.  Problems and  *   FILE 711
//*           fixes will be fielded by Sam Golob.                   *   FILE 711
//*                                                                 *   FILE 711
//*   >>> --------------------------------------------------------  *   FILE 711
//*   >>> This LIBRARIAN is a free package, unrelated to any other  *   FILE 711
//*   >>> package having the same or a similar name......           *   FILE 711
//*   >>> --------------------------------------------------------  *   FILE 711
//*                                                                 *   FILE 711
//*           email:  sbgolob@cbttape.org                           *   FILE 711
//*                   sbgolob@attglobal.net                         *   FILE 711
//*                                                                 *   FILE 711
//*   People who are using this utility are encouraged to send in   *   FILE 711
//*   their suggestions for improvement to Sam Golob, who will      *   FILE 711
//*   forward them to the package's author.                         *   FILE 711
//*                                                                 *   FILE 711
//*   Some documentation for this utility follows:                  *   FILE 711
//*                                                                 *   FILE 711
//*     The LIBRARIAN is a VTAM LU 6.2 client-server type           *   FILE 711
//*     application.                                                *   FILE 711
//*                                                                 *   FILE 711
//*     My idea for using an LU 6.2 interface was to allow          *   FILE 711
//*     users to access a library without having to log-in to       *   FILE 711
//*     the system where the library actually lives.  You could     *   FILE 711
//*     have a system at a central location serving remote          *   FILE 711
//*     offices.  If you have multiple LPARs, users can access      *   FILE 711
//*     libraries on any of the LPARs while logged in to only       *   FILE 711
//*     one of the LPARs.                                           *   FILE 711
//*                                                                 *   FILE 711
//*     Since you have PDSs (libraries) on MVS already, what do     *   FILE 711
//*     I need a librarian for?  The LIBRARIAN prevents             *   FILE 711
//*     multiple users from updating a member at the same time.     *   FILE 711
//*     When a user wants to update a member of a library, they     *   FILE 711
//*     "CHECK OUT" the member.  The LIBRARIAN updates the          *   FILE 711
//*     status to reflect the status is "CHECKED OUT" and           *   FILE 711
//*     records the time, date, and user id of who CHECKED OUT      *   FILE 711
//*     the member.  While the member is in CHECKED OUT state,      *   FILE 711
//*     others will not be allowed to CHECK OUT the same            *   FILE 711
//*     member.  Only the user that CHECKED out the member may      *   FILE 711
//*     CHECK IN that member.  When the member is CHECKED IN,       *   FILE 711
//*     the LIBRARIAN will change the status to CHECKED IN and      *   FILE 711
//*     record the time, date, and user id of the user that         *   FILE 711
//*     performed the CHECK IN.  A member may be VIEWed at any      *   FILE 711
//*     time.  VIEWing a member does not change the STATUS or       *   FILE 711
//*     the CHECK IN or CHECK OUT time stamps.                      *   FILE 711
//*                                                                 *   FILE 711
//*     Access to members is controlled via a user exit             *   FILE 711
//*     (LIBUX02).  You may over-ride standard access controls.     *   FILE 711
//*     For example, it may be that a user that has a member        *   FILE 711
//*     CHECKED OUT is on vacation or no long working for your      *   FILE 711
//*     company.  You may want to allow a manager to CHECK IN       *   FILE 711
//*     the member.                                                 *   FILE 711
//*                                                                 *   FILE 711
//*     The server or back-end can be run as a JOB or started       *   FILE 711
//*     task (STC).  Users may interface with the LIBRARIAN         *   FILE 711
//*     either though batch or an SPF dialog.                       *   FILE 711
//*                                                                 *   FILE 711
//*     The LIBRARIAN can manage multiple libraries.  This          *   FILE 711
//*     allows one LIBRARIAN to manage SOURCE, MACRO, JCL, etc      *   FILE 711
//*     libraries.                                                  *   FILE 711
//*                                                                 *   FILE 711
//*     Libraries are KSDS VSAM clusters.                           *   FILE 711
//*                                                                 *   FILE 711
//*     Members in the library may be stored in a compressed        *   FILE 711
//*     form.  User exit LIBUX01 allows you to use the              *   FILE 711
//*     LIBRARIAN supplied compression, use a compression           *   FILE 711
//*     method of your own, or turn compression off.  The           *   FILE 711
//*     librarian compression mechanism averages about a 4-to-1     *   FILE 711
//*     compression ratio.                                          *   FILE 711
//*                                                                 *   FILE 711
//*     This version of the LIBRARIAN allows you to add up to 5     *   FILE 711
//*     lines of comments about a member for documentation.         *   FILE 711
//*     These comments are not considered a part of the member      *   FILE 711
//*     itself.                                                     *   FILE 711
//*                                                                 *   FILE 711
//*     The LIBRARIAN allows for up to 32,767 versions of a         *   FILE 711
//*     given member.                                               *   FILE 711
//*                                                                 *   FILE 711
//*     The VSAM key used in the KSDSs allow approximately 2        *   FILE 711
//*     billion (a 4 byte binary field) blocks of source data.      *   FILE 711
//*     Each block is up to 8K in size.  If data compression is     *   FILE 711
//*     used, the blocks contain compressed data.  The amount       *   FILE 711
//*     of data that can be stored in a library is usually          *   FILE 711
//*     limited only by the amount of disk space available.         *   FILE 711
//*                                                                 *   FILE 711
//*     Several supporting utilities are also supplied.             *   FILE 711
//*       .  LIBINIT     Initializes a new library.                 *   FILE 711
//*       .  UTIL0001    Loads members to a library "offline"       *   FILE 711
//*       .  UTIL0002    Unloads a library to a sequential file     *   FILE 711
//*       .  UTIL0003    Converts a source file to compressed form  *   FILE 711
//*       .  UTIL0004    Detail library status report.              *   FILE 711
//*       .  UTIL0005    Unloads members to a sequential file in    *   FILE 711
//*                      LIBRARIAN "export" format                  *   FILE 711
//*       .  UTIL0006    Imports members from a sequential file     *   FILE 711
//*                      in LIBRARIAN "export" format               *   FILE 711
//*                                                                 *   FILE 711
```

