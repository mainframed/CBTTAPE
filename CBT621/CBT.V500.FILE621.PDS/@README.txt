                   NPF Input Record Exit Package
---------------------------------------------------------------------
Package Name: NPF Input Record Exit Programs for IP network printers
Design      : Hunter Guanghui Zhou
              Phone: 1-(416)-602-9567
              E-mail: zhough2000@yahoo.com
Date        : September, 2003

Package Description
-------------------
 TCP/IP NPF(Network Print Facility) is a free feature of OS/390 and
 z/OS. It can print JES and VTAM data to network printers via
 TCP/IP printer servers(LPD servers).

 NPF provide three different exit interfaces. Here I created one
 of them: Input Record Exit. The Input Record Exit is used to
 insert a banner page, update the input record.

 Normallly, NPF uses LPR program to send data to remote printer
 servers. However, for those printer without Postscript support
 features, you cannot print your data sets in landscape via LPR.

 This package extends the capability of NPF with following features:
   .Pure TCP/IP, not require SNA gateway
   .Send data directly from Mainframe to network printers
   .Insert PCL commands to control the printer settings.
   .Support duplex print out (if the printers support).
   .Support following Carriage Control data:
      .ASA Carriage Control Commands
      .Printer Channel Commands (Machine Code)
   .Provide banner page to identify the printer out.

 The program support both PCL printers and TEXT printers (impact
 printers. You can use PCL forms for laser printers and non-PCL
 for impact printers.

Build the exit load modules via NPFIXJCL
========================================

 The exit load modules are built for different purposes, which are
 the conbination of the options for printing, such as banner page,
 translate carriage control byte, use PCL and forms and orientations.

The job NPFIXJCL builds the exit load module according to the input
in SYSIN DD.

Following information is required to specified in SYSIN DD:
  SOURCE        THE SOURCE ASSEMBLER PROGRAM MEMBER NAME
  SOURCELIB     THE PDS OF SOURCE PROGRAM
  TCPIPMACLIB   TCP/IP MACRO LIBRARY
  REFRESHLLA    WHETHER TO REFRESH LINKLST AFTER BUILD EXIT MODULES.
  LOADLIB       THE LOADLIB TO STORE THE EXIT PROGRAMS, MUST BE IN
                YOUR SYSTEM LINKLST
  JOBCARD       JOBCARD MEMBER
  LISTDETAIL    The compile and link list option.
  EXIT          Each EXIT statement is a load module to be built
  LOGO          THE LOGO OF THE BANNER PAGE
  E2ATABLE      THE EBCDIC TO ASCII TRANSLATION TABLE.


Syntax of SYSIN DD of job NPFIXJCL
==================================
Comments start with '#'

#######################################################################
#              INPUT FILE FOR NPF EXIT BUIULD PROGRAM
#              ======================================
# KEYWORD DESCRIPTIONS:
# SOURCE      : OPTIONAL, DEFAULT=NPFIXASM
#               THE SOURCE ASSEMBLER PROGRAM MEMBER NAME
# SOURCELIB   : OPTIONAL, DEFAULT=PDS of current REXX program.
#               THE PDS OF SOURCE PROGRAM
# TCPIPMACLIB : OPTIONAL, DEFAULT= TCPIP.SEZACMAC
#               TCP/IP MACRO LIBRARY
# REFRESHLLA  : OPTIONAL, DEFAULT= YES
#               WHETHER TO REFRESH LINKLST AFTER BUILD EXIT MODULES.
# LOADLIB     : MANDATORY, no DEFAULT
#               THE LOADLIB TO STORE THE EXIT PROGRAMS, MUST BE IN
#               YOUR SYSTEM LINKLST
# JOBCARD     : OPTIONAL, DEFAULT=Member NPFEXBJC of current REXX PDS.
#               The jobcard information to be extracted from.
# LISTDETAIL  : OPTIONAL, DEFAULT=NO
#               The compile and link LIST/NOLIST option in EXEC PARM.
# EXIT        : MANDATORY, No default
#               Each EXIT statement is a load module to be built
#               See the comments below for detail description.
#######################################################################
  LOADLIB     = SYS1.TEST.LINKLIB                # loadlib for exits
######################################################################
# Field Descriptions in EXIT statement
# ------------------------------------
# TITL   : The title for each exit load module, must be 'EXIT'.
# MODULE : The load module name which will be build into LOADLIB.
# BNR    : YES/NO to generate the banner page.
#          If no, the hostname is ignored.
# CC     : YES/NO to translate the carriage control characters.
# PCL    : YES/NO to insert PCL commands for printers support PCL.
#          Normally the laser printers will support PCL commands.
#          If no, the FORM field is ignored.
# FORM   : The predefined form for PCL commands.
#          The form will control the font-size, orientation, and
#          paper types.
#           FORM ORIENT    PAPER    Duplex SPACES PITCH
#           ==== ========= ======== ====== ====== =====
#           PT00 PORTRAIT  DEFATULT YES      5     17
#           PT01 PORTRAIT  DEFATULT YES      5     14
#           PT02 PORTRAIT  DEFATULT NO       5     17
#           LS00 LANDSCAPE DEFAULT  YES      4.5   14
#           LS01 LANDSCAPE DEFAULT  YES      5.7   13
#           LS02 LANDSCAPE DEFAULT  NO       4.5   14
#           LG00 LANDSCAPE LEGAL    YES      4.5   14
#           LG01 PORTRAIT  LEGAL    YES      5     17
#     * Duplex YES means use duplex if the printer supports it.
#     * SPACES 5 means 5/48 inch vertical motion index, or
#       spaces between lines.
#     * PITCH is the number of characters per inch, or pitch.
#       This reflects the size of the font.
# SKP      : YES/NO to skip the first form feed control character
#          This is for Carriage Control files.
# HOSTNAME : The TCP/IP Hostname of the mainframe to use the exit.
#          This hostname is only used in banner page for informational
#          purpose. Host name is ignored if BNR is NO.
######################################################################
#TITL MODULE   BNR CC  PCL FORM SKP HOSTNAME             NPF FORM/DEST
#==== ======== === === === ==== === ===================  =============
 EXIT=EXPCLLS0,YES,YES,YES,LS00,YES,maintest.agora.lan # LSCC
 EXIT=EXPCLLS1,YES,NO ,YES,LS00,YES,maintest.agora.lan # LSNC
 EXIT=EXPCLLS2,YES,YES,YES,LS01,YES,maintest.agora.lan # LSC1
 EXIT=EXPCLLS3,YES,YES,YES,LS02,YES,maintest.agora.lan # LSSC
 EXIT=EXPCLPT0,YES,YES,YES,PT00,YES,maintest.agora.lan # PTCC
 EXIT=EXPCLPT1,YES,NO ,YES,PT00,YES,maintest.agora.lan # PTNC
 EXIT=EXPCLPT2,YES,YES,YES,PT01,YES,maintest.agora.lan # PTC1
 EXIT=EXPCLPT3,YES,YES,YES,PT02,YES,maintest.agora.lan # PTSC
 EXIT=EXPCLLG0,YES,YES,YES,LG00,YES,maintest.agora.lan # LGCC
 EXIT=EXPCLLG1,YES,YES,YES,LG01,YES,maintest.agora.lan # LGSC
 EXIT=EXTEXT00,NO ,NO ,NO ,    ,YES,maintest.agora.lan # TXT0
 EXIT=EXTEXT01,NO ,YES,NO ,    ,YES,maintest.agora.lan # TXT1
 EXIT=EXTEXT02,YES,YES,NO ,    ,YES,maintest.agora.lan # TXT2
######################################################################
# LOGO OF THE BANNER PAGE
# =======================
#
# 1. MAXIMUM 17 RECORDS (lines)
# 2. EACH RECORD IS 80 BYTE LONG, program will pad with spaces
# 3. ANY RECORDS BEYOND 17th LINE WILL BE IGNORED.
# 4. If the total records less than 17, then the empty records will be
#    added to make up total 17 records.
# 5. No comments is allowed.
BANNER_LOGO_START
*  OS/390 V2.10                               TCP/IP Network Print Facility    *
*            ...                                                .::::.         *
*         .:::::       :::                                      ::::::         *
*        .:::'''       :::               ...      ...  ..       ::::::         *
*        :::  .:::::.  :::::::.   .:::::.'::.    .::'.:::  .::::'::::'::::.    *
*        ::: .:::::::. ::::::::. .:::::::.'::.  .::':::''  ::::::    ::::::    *
*        ::: :::   ::: :::   ::: :::  ::'' ':::.::  :::    ::::::    ::::::    *
*       .::: :::   ::: :::   ::: :::.:' .   ::::'  .:::    '::::.::::.::::'    *
*    ..::::' '::...::' '::...::' ':::. :::  :::' ::::'          ::::::         *
*    ::::''   ':::::'   ':::::'   ':::::'' .::'  :::'           ::::::         *
*    '''                                  .::'                  '::::'         *
*                                        .::'                                  *
*                     Sobeys Ontario Mainframe System                          *
*                                                                              *
*                          Network Print Service                               *
*                                                                              *
*     Information Technology, 6355 Viscount Road, Mississauga, ON L4V 1W2      *
BANNER_LOGO_STOP
######################################################################
# EBCDIC TO ASCII Translation table
# =================================
# 1. Any leading spaces and empty line will be ignored.
# 2. There must be 16 lines with 32 bytes each line
# 3. The bytes must be from 0-9 A-F.
# 4. Any trailing comments will be ignored.
EBCDIC_TO_ASCCII_TABLE_START
   00010203DC09C37FCAB2D50B0C0D0E0F  #00
   10111213DBDA08C11819C8F21C1D1E1F  #10
   C4B3C0D9BF0A171BB4C2C5B0B1050607  #20
   CDBA16BCBBC9CC04B9CBCEDF1415FE1A  #30
   20FF838485A0C68687A4BD2E3C282B7C  #40
   268288898AA18C8B8DE121242A293BAA  #50
   2D2FB68EB7B5C78F80A5DD2C255F3E3F  #60
   9B90D2D3D4D6D7D8DE603A2340273D22  #70
   9D616263646566676869AEAFD0ECE7F1  #80
   F86A6B6C6D6E6F707172A6A791F792CF  #90
   E67E737475767778797AADA8D1EDE8A9  #A0
   5E9CBEFAB8F5F4ACABF35B5DEEF9EF9E  #B0
   7B414243444546474849F0939495A2E4  #C0
   7D4A4B4C4D4E4F505152FB968197A398  #D0
   5CF6535455565758595AFDE299E3E0E5  #E0
   30313233343536373839FCEA9AEBE99F  #F0
EBCDIC_TO_ASCCII_TABLE_STOP
######################################################################
/*
#######################################################################
#              INPUT FILE FOR NPF EXIT BUIULD PROGRAM
#              ======================================
# KEYWORD DESCRIPTIONS:
# SOURCE      : OPTIONAL, DEFAULT=EXITNPFR
#               THE SOURCE ASSEMBLER PROGRAM MEMBER NAME
# SOURCELIB   : OPTIONAL, DEFAULT=PDS of current REXX program.
#               THE PDS OF SOURCE PROGRAM
# TCPIPMACLIB : OPTIONAL, DEFAULT= TCPIP.SEZACMAC
#               TCP/IP MACRO LIBRARY
# REFRESHLLA  : OPTIONAL, DEFAULT= YES
#               WHETHER TO REFRESH LINKLST AFTER BUILD EXIT MODULES.
# LOADLIB     : MANDATORY, no DEFAULT
#               THE LOADLIB TO STORE THE EXIT PROGRAMS, MUST BE IN
#               YOUR SYSTEM LINKLST
# JOBCARD     : OPTIONAL, DEFAULT=Member NPFEXBJC of current REXX PDS.
#               JOBCARD MEMBER
# LISTDETAIL  : OPTIONAL, DEFAULT=NO
#               The compile and link list option.
# EXIT        : MANDATORY, No default
#               Each EXIT statement is a load module to be built
#               See the comments below for detail description.
#######################################################################
  LOADLIB     = SYS1.TEST.LINKLIB                # loadlib for exits
######################################################################
# Field Descriptions in EXIT statement
# ------------------------------------
# TITL   : The title for each exit load module, must be 'EXIT'.
# MODULE : The load module name which will be build into LOADLIB.
# BNR    : YES/NO to generate the banner page.
#          If no, the hostname is ignored.
# CC     : YES/NO to translate the carriage control characters.
# PCL    : YES/NO to insert PCL commands for printers support PCL.
#          Normally the laser printers will support PCL commands.
#          If no, the FORM field is ignored.
# FORM   : The predefined form for PCL commands.
#          The form will control the font-size, orientation, and
#          paper types.
#           FORM ORIENT    PAPER    Duplex SPACES PITCH
#           ==== ========= ======== ====== ====== =====
#           PT00 PORTRAIT  DEFATULT YES      5     17
#           PT01 PORTRAIT  DEFATULT YES      5     14
#           PT02 PORTRAIT  DEFATULT NO       5     17
#           LS00 LANDSCAPE DEFAULT  YES      4.5   14
#           LS01 LANDSCAPE DEFAULT  YES      5.7   13
#           LS02 LANDSCAPE DEFAULT  NO       4.5   14
#           LG00 LANDSCAPE LEGAL    YES      4.5   14
#           LG01 PORTRAIT  LEGAL    YES      5     17
#     * Duplex YES means use duplex if the printer supports it.
#     * SPACES 5 means 5/48 inch vertical motion index, or
#       spaces between lines.
#     * PITCH is the number of characters per inch, or pitch.
#       This reflects the size of the font.
# SKP      : YES/NO to skip the first form feed control character
#          This is for Carriage Control files.
# HOSTNAME : The TCP/IP Hostname of the mainframe to use the exit.
#          This hostname is only used in banner page for informational
#          purpose. Host name is ignored if BNR is NO.
######################################################################
#TITL MODULE   BNR CC  PCL FORM SKP HOSTNAME  NPF FORM
#==== ======== === === === ==== === ========================= ========
 EXIT=EXPCLLS0,YES,YES,YES,LS00,YES,maintest.agora.lan
 EXIT=EXPCLLS1,YES,NO ,YES,LS00,YES,maintest.agora.lan
 EXIT=EXPCLLS2,YES,YES,YES,LS01,YES,maintest.agora.lan
 EXIT=EXPCLLS3,YES,YES,YES,LS02,YES,maintest.agora.lan
 EXIT=EXPCLPT0,YES,YES,YES,PT00,YES,maintest.agora.lan
 EXIT=EXPCLPT1,YES,NO ,YES,PT00,YES,maintest.agora.lan
 EXIT=EXPCLPT2,YES,YES,YES,PT01,YES,maintest.agora.lan
 EXIT=EXPCLPT3,YES,YES,YES,PT02,YES,maintest.agora.lan
 EXIT=EXPCLLG0,YES,YES,YES,LG00,YES,maintest.agora.lan
 EXIT=EXPCLLG1,YES,YES,YES,LG01,YES,maintest.agora.lan
 EXIT=EXTEXT00,NO ,NO ,NO ,    ,YES,maintest.agora.lan
 EXIT=EXTEXT01,NO ,YES,NO ,    ,YES,maintest.agora.lan
 EXIT=EXTEXT02,YES,YES,NO ,    ,YES,maintest.agora.lan
######################################################################
# LOGO OF THE BANNER PAGE
# =======================
#
# 1. MAXIMUM 17 RECORDS (lines)
# 2. EACH RECORD IS 80 BYTE LONG, program will pad with spaces
# 3. ANY RECORDS BEYOND 17th LINE WILL BE IGNORED.
# 4. If the total records less than 17, then the empty records will be
#    added to make up total 17 records.
BANNER_LOGO_START
*  OS/390 V2.10                               TCP/IP Network Print Facility    *
*            ...                                                .::::.         *
*         .:::::       :::                                      ::::::         *
*        .:::'''       :::               ...      ...  ..       ::::::         *
*        :::  .:::::.  :::::::.   .:::::.'::.    .::'.:::  .::::'::::'::::.    *
*        ::: .:::::::. ::::::::. .:::::::.'::.  .::':::''  ::::::    ::::::    *
*        ::: :::   ::: :::   ::: :::  ::'' ':::.::  :::    ::::::    ::::::    *
*       .::: :::   ::: :::   ::: :::.:' .   ::::'  .:::    '::::.::::.::::'    *
*    ..::::' '::...::' '::...::' ':::. :::  :::' ::::'          ::::::         *
*    ::::''   ':::::'   ':::::'   ':::::'' .::'  :::'           ::::::         *
*    '''                                  .::'                  '::::'         *
*                                        .::'                                  *
*                     Sobeys Ontario Mainframe System                          *
*                                                                              *
*                          Network Print Service                               *
*                                                                              *
*     Information Technology, 6355 Viscount Road, Mississauga, ON L4V 1W2      *
BANNER_LOGO_STOP
######################################################################
# EBCDIC TO ASCII Translation table
# =================================
# 1. Any leading spaces and empty line will be ignored.
# 2. There must be 16 lines with 32 bytes each line
# 3. The bytes must be from 0-9 A-F.
# 4. Any trailing comments will be ignored.
EBCDIC_TO_ASCCII_TABLE_START
   00010203DC09C37FCAB2D50B0C0D0E0F  #00
   10111213DBDA08C11819C8F21C1D1E1F  #10
   C4B3C0D9BF0A171BB4C2C5B0B1050607  #20
   CDBA16BCBBC9CC04B9CBCEDF1415FE1A  #30
   20FF838485A0C68687A4BD2E3C282B7C  #40
   268288898AA18C8B8DE121242A293BAA  #50
   2D2FB68EB7B5C78F80A5DD2C255F3E3F  #60
   9B90D2D3D4D6D7D8DE603A2340273D22  #70
   9D616263646566676869AEAFD0ECE7F1  #80
   F86A6B6C6D6E6F707172A6A791F792CF  #90
   E67E737475767778797AADA8D1EDE8A9  #A0
   5E9CBEFAB8F5F4ACABF35B5DEEF9EF9E  #B0
   7B414243444546474849F0939495A2E4  #C0
   7D4A4B4C4D4E4F505152FB968197A398  #D0
   5CF6535455565758595AFDE299E3E0E5  #E0
   30313233343536373839FCEA9AEBE99F  #F0
EBCDIC_TO_ASCCII_TABLE_STOP
######################################################################

NPF Customization Instructions
------------------------------
  1.Compile and generate load module into any LINKLST library.
    Refer the sample compile job EXITNPFC.

  2.In TCP/IP Network Print Facility ISPF Panels,
    a. Select O for Options
    b. Select A for ADD
    c. Enter the option name, i.e. EXPCLLS0
    d. Enter EXPCLLS0 as the name of 'Input Record Exit'
    e. Enter 'BINARY NOBURST' as the LPR options

  3.Create a NPF printer to use this NPF option
    In TCP/IP Network Print Facility ISPF Panels,
    a. Select R for Routing
    b. Select A for ADD
    c. Enter the printer name, i.e. VCIT3
       Enter the minor name i.e. ALSCC(Class A, Form LSCC)
    d. Enter EXPCLLS0 as the option name
       Enter IP address of target network PCL printer.
       Enter IPPRT as printer name, or given by printer server.

 NPF Configuration Example
 *************************
 Here is sample definitions for network printer with TCP/IP address
 211.128.74.49:

 1. NPF Options
 We define 4 NPF options for 4 different forms
 OPTION   EXIT NAME LPR OPTION
 ======== ========= ===================
 EXPCLLG0 EXPCLLG0  BINARY NOBURST
 EXPCLLS0 EXPCLLS0  BINARY NOBURST
 EXPCLPT0 EXPCLPT0  BINARY NOBURST
 EXPCLPT1 EXPCLPT1  BINARY NOBURST

 2. NPF Routing
 We define 4 NPF routings with follow

 MAJOR    MINOR OPTION   IP ADDR        PRINTER NAME
 ======== ===== ======== ============== ============
 VCIT1    ASTD  EXPCLPT0 211.128.74.49  ITPRT
 VCIT1    ALGCC EXPCLLG0 211.128.74.49  ITPRT
 VCIT1    ALSCC EXPCLLS0 211.128.74.49  ITPRT
 VCIT1    APTCC EXPCLPT1 211.128.74.49  ITPRT

 Here IP Addr is the IP address of network printer, Printer name is any
 name for printer, or printer name in printer server if you use the
 printer server other than network printer.
 Major Name is JES DEST name (printer name).
 Minor Name is SYSOUT CLASS plus FORM name.

 MAJOR of VCIT1 and MINOR ALSCC mean the output data will be accepted
 when its DEST is VCIT1, SYSOUT CLASS is A and FORM is LSCC.

Usage Instruction
-----------------
1. Make sure NPF is installed and running (both NPF Writer and
  Queue manager).

2. You should print the dataset with Carriage Control attributes
  i.e. FBA, VBA datasets, to printer with option CC.

3. Refer sample JCL to print the data set:
 //PRINT   EXEC PGM=IEBGENER
 //SYSPRINT  DD SYSOUT=*
 //SYSOUT    DD SYSOUT=*
 //SYSIN     DD DUMMY
 //SYSUT1    DD DISP=SHR,DSN=SP2487.TEMP
 //SYSUT2    DD SYSOUT=(A,,LSCC),DEST=VCIT1


Restrictions
------------
 Because the job information can be only provided by JES2 in JSPA,
 this package may not suitable for VTAM printers.

 This package has been only tested in OS/390 V2.10.

Questions & suggestions
=======================
 Should you have any question, please contact Hunter Zhou at
 zhough2000@yahoo.com .

 April, 2003

 Hunter Guanghui Zhou
 Phone: 1-(416)-602-9567
 E-mail: zhough2000@yahoo.com
