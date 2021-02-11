***********************************************************************
* File 564 contains three PDS's in IEBUPDTE unload format. They are:  *
* DATA, INSTRUCT, and MEMORY.                                         *
*                                                                     *
* DATA library:  Contains control cards and data used by the JCL      *
*                members in File 560 when running the programs in     *
*                File 558 (assembler), File 559 (C), and File 563     *
*                COBOL. No further documentation is given for members *
*                in this PDS.                                         *
*                                                                     *
* INSTRUCT library: Contains detailed instructions for use of some of *
*                the programs that need more than a quick description *
*                in the program source code and/or execution JCL. A   *
*                short description of each member is shown below.     *
*                                                                     *
* MEMORY library: Contains general lore I needed to get the job done. *
*                As I got older and my long and short term memories   *
*                faded, I needed some way to remember how to do those *
*                things I only did once in a while, but were critical *
*                when the need arose. Then all I had to do was        *
*                remember to look in there. This will be of most value*
*                to older System Programers who haven't yet developed *
*                a system of their own. Still, I have provided a      *
*                short description of each member below.              *
***********************************************************************
***********************************************************************
*    INSTRUCT LIBRARY MEMBERS                                         *
***********************************************************************
ABAL      .Instructions for the ABAL program in FILE 558.
ABEND878  .An information APAR made by IBM to aid in debugging S878,
           S80A, and other out-of-storage problems, such as S106-0C
ALOCDYN1  .Instructions for calling subroutine ALLOCDYN in FILE 558 from
           an assembler language program.
ALOCDYN2  .Instructions for calling subroutine ALLOCDYN in FILE 558 from
           a COBOL program.
CHRDUMP   .Instructions for program chrdump in FILE 558.
COBOL2    .Note to programmers concerning our use of COBOL II compile
           parameters.
COB2ASM   .Instructions for the COB2ASM program in FILE 558.
COMPASM   .Instructions for the COMPASM program in FILE 558.
COPYDUMP  .Instructions for the COPYDUMP program in FILE 558.
COPYMULT  .Instructions for the COPYMULT program in FILE 558.
DASDIO    .Note on using TMONMVS to display DASD I/O data.
DDLIST    .Instructions for the DDLIST program in FILE 558.
DISASM    .Instructions for the DISASM0/DISASM1/DISASM2 disassembler
           in FILE 558.
DUMPFIL   .Instructions for using program DUMPFIL in FILE 558.
DYNALOC1  .Instructions for calling the DYNALOC program in FILE 558 from
           an assembler language program.
DYNALOC2  .Instructions for calling the DYNALOC program in FILE 558 from
           a COBOL program.
DYNERRS   .Documentation for the DYNERRS assembler message table in
           FILE 558.
ENQLIST   .Instructions for the ENQLIST program in FILE 558.
EXCHANGE  .Instructions for using program EXCHANGE in FILE 558.
EXCPIO    .Instructions for calling the EXCPIO subroutine in FILE 558.
FINDMAC   .Use instructions for the FINDMAC program in FILE 558.
FINDSUBR  .Instructions for the FINDSUBR program in FILE 558.
GENLDAT1  .COBOL program calling instructions for the GENLDAT2 sub-
           routine in file 558.
GENLDAT2  .Assembler program calling instructions for the GENLDAT2 sub-
           routine in file 558.
GETGDG    .Calling instructions for the GETGDG subroutine in FILE 558.
ILBCHECK  .Use instructions for the ILBCHECK program in FILE 558.
IPCS      .Notes on using the IBM program IPCS for viewing dumps.
IPOUPDTE  .IBM IPO instructions for the IBM utility IPOUPDTE.
JOBINFO   .Calling instructions for the JOBINFO subroutine in FILE 558.
LIBPRNT   .Instructions for using the LIBPRNT program in FILE 558.
LSTVTOC   .Instructions for using the LSTVTOC1, LSTVTOC2, and LSTVTOC3
           programs in FILE 558.
MODSCB    .Instructions for using the MODSCB program in FILE 558.
MODXREF   .Usage for the MODXREF program in FILE 558.
PDSPGMS   .Short descriptions of a number of programs in FILE 558 that
           process PDS's.
PDSREAD   .Instructions for calling the PDSREAD subroutine in FILE 558.
PRNTMULT  .Use instructions for the PRNTMULT program in FILE 558.
PRTPCH    .Instructions for using program PRTPCH in FILE 558.
QWIKVTOC  .Usage instructions for the QWIKVTOC program in FILE 558.
RCVRPDS   .How to use the RCVRPDS program in FILE 558.
READDIR   .Calling instructions for the READDIR subroutine in FILE 558.
READMEM   .Calling instructions for the READMEM subroutine in FILE 558.
RENSCR    .Using the RENSCR program in FILE 558.
RMFINST   .Notes on using IBM's RMF Monitor III
SIRTSO    .Usage for an old IBM system monitor called SIT or SIRTSO
SMODE     .Coding instructions for use of the SMODE macro in FILE 558.
SRBINST   .Describes the use of the macros BCBLDSRB, BCGETRTN, BCSRBFRE
           BCSRBDEF, BCSRBENT, and BCSRBPST, in scheduling and writing
           routines.
TAKETEST  .Tips for taking tests (not computer related).
TRACE     .An APAR made by IBM to describe the GETMAIN/FREEMAIN trace
           facility built into the operating system. This provides a
           much more complete trace than does GTF tracing of SVC's,
           since many storage requests are done by branch entry, and
           will not be seen by GTF SVC traces.
TRACEBR   .Notes on tracing wild branches using SLIP and GTF.
UPDMEM    .calling instructions for the subroutine UPDMEM in FILE 558.
VI        .Simplified instructions for using the VI editor in the AIX
           operating system or other UNIX-based operating systems.
VOLLIST2  .Instructions for the VOLLIST2 program in FILE 558.
WAITASEC  .Using the WAITASEC program on FILE 558.
WHEREAMI  .Usage instructions for the WHEREAMI subroutine on FILE 558.
***********************************************************************
*    MEMORY LIBRARY MEMBERS                                           *
***********************************************************************
ACF2      .Some common ACF2 commands.
ADDR31    .Sample assembler code for 31-bit addressing, page 1 of 2.
ADDR312   .Sample assembler code for 31-bit addressing, page 2 of 2.
APF       .Notes about APF.
AUXSTOR   .Some solutions for Auxiliary Storage shortage problems.
BOOKMGR   .Using Book Manager.
BUCKETS   .Information about IBM Retain Buckets (ancient).
CA        .Computer Associates (CA) notes.
CANCEL    .Commands for canceling jobs.
CATALOG   .Catalog Address Space notes.
CA7       .CA-7 Scheduler stuff.
CA90S     .CA-90s info.
CICS      .CICS commands and other things.
CLANG     .Mainframe C-language lore, page 1 of 2.
CLANG2    .Mainframe C-language lore, page 2 of 2.
COBOL     .COBOL notes, page 1 of 2.
COBOL02   .COBOL notes, page 2 of 2.
CONSOLES  .Some MVS console commands.
CTLBLK01  .Selected Control Block Fields: CDE, XTLST, DCB
CTLBLK02  .Selected Control Block Fields: DEB
CTLBLK03  .Selected Control Block Fields: Format 1 DSCB
CTLBLK04  .Selected Control Block Fields: RB, PDSDIR, IOB
CTLBLK05  .Selected Control Block Fields: TCB, TIOT, UCB
DB2       .Random DB2 things.
DFHSM     .Some useful DFHSM commands.
DFSMS     .Notes on DFSMS usage.
DISK      .DASD information.
DISPLAY   .Mainframe console DISPLAY commands.
DUMP      .Console DUMP commands, system dump datasets, traces, etc.
EMAIL     .Nothing of value here...
ENDEVOR   .Bits and pieces about the CA-Endevor product, page 1 of 3.
ENDEVOR2  .Bits and pieces about the CA-Endevor product, page 2 of 3.
ENDEVOR3  .Bits and pieces about the CA-Endevor product, page 3 of 3.
ENQ       .Various things about MVS ENQ and .VARY commands.
ESATEST   .IPL, LOGON instructions for our test LPAR.
EXCHANGE  .Instructions for use of the EXCHANGE program in FILE 558.
FILEAID   .Some use info for the Compuware FileAid product.
FILES     .A list of various files whose names I had trouble remembering
FTP       .Transferring files between mainframe and PC using Reflections
GTF       .Notes on using GTF traces.
HCD       .Display command for HCD.
IBMLINK1  .Using IBM's IBMLINK, page 1 of 2.
IBMLINK2  .Using IBM's IBMLINK, page 2 of 2.
ICEBERG   .ICEBERG DASD information.
IMS       .Useless IMS notes.
INTERNET  .Ditto for internet.
IODF      .Sample IODF ACTIVATE command.
IPCS1     .Using IPCS to analyze system dumps, page 1 of 2.
IPCS2     .Using IPCS to analyze system dumps, page 2 of 2.
ISMF      .ISMF info.
ISPF      .ISPF notes, page 2 of 2.
ISPF2     .ISPF notes, page 2 of 2.
JCL       .JCL job classes and sysout classes used here.
JCLCHECK  .Information about using the JCLCHECK product.
JES2      .Some JES2 commands.
LAN       .Mapping LAN drives to the PC.
LE        .A little one-liner about L.E. here.
LLA       .LLA usage notes.
LNKLST    .MVS lnklst commands LNKLST, and on-the-fly changes, pg 1 of 2
LNKLST2   .MVS lnklst commands LNKLST, and on-the-fly changes, pg 2 of 2
LOGREC    .Notes about LOGREC.
LPA       .LPA size and display commands.
LPAR      .Some LPAR configuration instructions.
MAGSTAR   .Description, notes on MAGSTAR devices.
MANUALS1  .Common IBM Manuals, page 1 of 3.
MANUALS2  .Common IBM Manuals, page 2 of 3.
MANUALS3  .Common IBM Manuals, page 3 of 3.
MIM       .Several commands for the MIM product.
MODEL     .A blank page for creating new memory pages.
MVSSYS    .MVS System topics: EDT, IOCDS, IPL, PROG00, etc.
NDM       .Information bits concerning NDM.
OMVS      .About Unix on the mainframe.
OPSLOG    .Using OPSLOG (I never did).
OPSMVS    .Some automated Operations Start and Stop commands.
PAGEDSET  .Page dataset notes.
PRINTMPG  .Similar to MODEL, but smaller pages.
PROGPROP  .Program properties table notes.
Q         .Commands for use with the Q product.
QWIKREF   .Bits concerning the QWIKREF product.
REFLECTN  .Usage and tips for the IBM Reflections product, page 1 of 2.
REFLECT2  .Usage and tips for the IBM Reflections product, page 2 of 2.
RESPONSE  .A note on response problems caused by the ICEBERG.
RMFMON3A  .Instructions for using IBM's RMF Monitor III, page 1 of 4.
RMFMON3B  .Instructions for using IBM's RMF Monitor III, page 2 of 4.
RMFMON3C  .Instructions for using IBM's RMF Monitor III, page 3 of 4.
RMFMON3D  .Instructions for using IBM's RMF Monitor III, page 4 of 4.
RMF1      .Commands used with IBM's RMF Monitor, page 1 of 2.
RMF2      .Commands used with IBM's RMF Monitor, page 2 of 2.
SAR       .Scraps about the SAR product.
SAS       .A few facts about SAS as used here.
SDSF      .Some instructions for using the SDSF product.
SECURITY  .A few local security procedures.
SHRDSERV  .Notes on the Compuware Shared Services product.
SLIP1     .A number of sample SLIP commands, page 1 of 2.
SLIP2     .A number of sample SLIP commands, page 2 of 2.
SLSS      .Using IBMLINK to get SLSS information.
SMF       .A variety of SMF bits and peices, page 1 of 2.
SMF2      .A variety of SMF bits and peices, page 2 of 2.
SMPE      .SMPE information, as it is used here, page 1 of 2.
SMPE2     .SMPE information, as it is used here, page 2 of 2.
SMR       .Information about the SMR product.
SMS       .Notes on the IBM SMS product as we use it here.
STORABND  .Various notes on S878 abends and causes.
STORMAP   .Instructions for using the WHERE program in FILE558.
STROBE    .Comments about the STROBE product.
STRTPEND  .A couple of reasons for START PENDING messages.
STRTSTP1  .START and STOP commands for various things, page 1 of 6.
STRTSTP2  .START and STOP commands for various things, page 2 of 6.
STRTSTP3  .START and STOP commands for various things, page 3 of 6.
STRTSTP4  .START and STOP commands for various things, page 4 of 6.
STRTSTP5  .START and STOP commands for various things, page 5 of 6.
STRTSTP6  .START and STOP commands for various things, page 6 of 6.
SYNCSORT  .Some SYNCSORT notes.
SYSCON    .Use instructions for the locally written SYSCON program.
TAPE      .Some hints for using tapes here.
TMONMVS1  .Commands for the TMONMVS product, page 1 of 3
TMONMVS2  .Commands for the TMONMVS product, page 2 of 3
TMONMVS3  .Commands for the TMONMVS product, page 3 of 3
TMS       .Using TMS (CA-1) here.
TRACEBR   .Tracing wild branches with SLIP and GTF.
TRANSMIT  .Using XMIT to unload PDS's, page 1 of 2.
TRANSMT2  .Using XMIT to unload PDS's, page 2 of 2.
TSOAUTH   .TSO Command Authorization information.
TSOCMNDS  .Some useful local TSO commands.
TSOTEST   .Using TSO TEST command in an ISPF session.
USERMODS  .Nothing here...
VARY      .MVS VARY commands.
VLF       .Notes on VLF.
VOICMAIL  .Skip it.
VTOC      .DASD VTOC information.
VVDS      .Some DASD VVDS references.
XPEDINST  .Installation guide for Compuware's XPEDITER product.
XPEDITER  .Using XPEDITER to test programs, page 1 of 2.
XPEDITR2  .Using XPEDITER to test programs, page 2 of 2.
XPEDSRT1  .XPEDITER testing for SORT exits, page 1 of 2.
XPEDSRT2  .XPEDITER testing for SORT exits, page 2 of 2.
Y2KLPAR   .Useless information on our Y2K LPAR.
