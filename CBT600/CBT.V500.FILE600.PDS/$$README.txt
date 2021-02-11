
                          CBT Tape File 600

                 (userid).CBTxxx.FILE600.PDS($$README)

------------------------------------------------------------------------

The contents of this CBT tape submission are categorised as follows.

 1) FTPC118 and FTPC119
 2) Assembler stuff
 3) REXX stuff


FTPC118 and FTPC119
-------------------
The two programs (FTPC118 and FTPC119) are written in
the C language to process SMF type 118/119 records from the FTP
component of TCPIP on IBM's OS/390 and z/OS operating systems.

The programs operate in two modes: SMF exit mode and TEST mode.

In SMF exit mode the programs are installed as operating system SMF
exits and invoked by the system each time an SMF record is written. In
this mode the programs select FTP SMF records and issue formatted WTO
(Write to Operator) messages for each FTP related record.

In TEST mode the programs run in batch against an input file of SMF data
and print FTP related records to a file.

The primary motivation for the creation of these programs was to enable
an installation to log FTP activity in real-time for tracking, audit and
automation purposes and also to report on historical FTP activity. The
secondary motivation was to show how the C language could be used for
operating system exits on OS/390. The documentation (in PDF format)
includes some tips on using Systems Programming C (SPC) for system
exits.

A minimum operating system level of OS/390 2.5 is required for these
programs.


Assembler Stuff
---------------

A couple of additional assembler programs are included. These are
summarised as follows.

       ANFUXMSG - An message exit for IBM's Infoprint Server Software.
                  The exit writes all messages out to WTO but does
                  so in way which takes into account the message
                  content, so as to avoid splitting long strings
                  over multiple lines of an MLWTO.
       HPNSTST  - An assembler HPNS socket program which makes
                  various TCPIP socket calls and reports the results
                  to verify that the TCPIP HPNS socket interface
                  is alive and well.

REXX Stuff
----------

REXX programs as follows.

       RXMAILER - A REXX bulk emailer which opens a socket connection
                  to an SMTP server and transmits SMTP format input
                  data. This is similar in many ways to UDSMTP.


------------------------------------------------------------------------


Quick Review
------------
For a quick review of the source materials, execute the
RECV member of this PDS to receive the 4 constituent PDSes. i.e.

         (userid).CBTxxx.FILE600.ASM.PDS
         (userid).CBTxxx.FILE600.C.PDS
         (userid).CBTxxx.FILE600.OBJ.PDS
         (userid).CBTxxx.FILE600.REXX.PDS

Installation
------------

The 'assembler stuff' is contained in (userid).CBTxxx.FILE600.ASM.PDS
and can be assembled and link edited individually as required.
Documentation for these programs is contained in the program source.
The same comment applies to the 'REXX stuff' in
(userid).CBTxxx.FILE600.REXX.PDS.

To install the FTPC118/119 C programs, obtain the full installation
instructions by downloading the $DOCFTPC member of this
PDS to a workstation. e.g. using an FTP command line client
on your workstation:-

    C:\> ftp hostname
    User (hostname): userid
    Password: ********
    ftp> bin
    ftp> get 'userid.CBTxxx.FILE600.PDS($DOCFTPC)' FTPCSMF.pdf
    ftp> qui

The documentation is in PDF format and readable via the free Adobe
Acrobat Reader at http://www.adobe.com/products/acrobat/alternate.html

Installation PDS Contents
-------------------------
$DOCFTPC - Comprehensive documentation of C language FTP C SMF exit
           and print programs. Also includes some tips on usage
           of SPC for system exits.
RECV     - REXX EXEC to reload all 3 datasets via TSO RECEIVE command.
XMITPDSA - XMIT unload of the ASM PDS (FB80). Contents as follows:-
           ANFUXMSG - Improved WTO message exit for IBM
                      Infoprint Server.
           EDCXFGS  - Assembler source for storage
                      allocation routines in SPC.
           FTPCTST  - Assembler source for FTPCTST - an assembler
                      program to invoke FTPC118/FTPC119 directly to
                      simulate the SMF exit mode of operation
                      for these programs.
           HPNSTST  - Assembler source for HPNSTST - A program to 'IVP'
                      the TCPIP HPNS API.
           MLWTO    - Assembler source for MLWTO - a C
                      function to issue WTOs (single or multi-line).
           SPRNTLL  - Assembler source for SPRNTLL - a C
                      function to format a 64 bit signed integer.
XMITPDSC - XMIT unload of the C PDS (VB255). Contents as follows:-
           CSQ      - An edit macro to switch between the different
                      forms of square brackets used in C code.
           FTPC118  - C program source for SMF type 118 (FTP)
                      batch print and SMF exit WTO program.
           FTPC119  - C program source for SMF type 119 (FTP)
                      batch print and SMF exit WTO program.
           NICKNC   - C program source for NICKNC -
                      an English nicknames generating program.
           SPRNTLLT - C program source which tests
                      and demonstrates the function
                      of the sprntll assembler function.
           WTOT     - C program source which tests
                      and demonstrates the function
                      of the mlwto assembler function.
XMITPDSO - XMIT unload of the object PDS.
XMITPDSR - XMIT unload of the REXX PDS (FB80). Contents as follows:-
           RXMAILER - A REXX bulk emailer which opens a socket connection
                      to an SMTP server and transmits SMTP format input
                      data. This is similar in many ways to UDSMTP.

Boring Stuff
------------
Use of this material is subject to the standard CBT Tape
disclaimer viewable at http://www.cbttape.org/disclaimer.htm

This material may be copied, distributed, modified and executed freely.
However in doing so, headers and comments indicating the source
of the material should not be removed. In addition, this material
must not be sold on for profit, either in part or as a whole, without
the consent of the author.

The author appreciates feedback as to good uses to which this material
is being put, and would give due consideration to any suggestions for
corrections, clarifications or enhancements. The author can be contacted
as follows.

Name:         Paul Wells
Address:      Saudi Aramco Box 12959
              Dhahran 31311
              Saudi Arabia
Telephone:    +966 3 873 3155 (Work - direct line)
Fax:          +966 3 873 8958 (Work)
Email:        Paul.Wells@aramco.com
Y! Messenger: PaulWells_technogold

