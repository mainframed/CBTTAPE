
## $README$.txt
```
./ ADD NAME=AGE      0100-18018-18018-1437-00010-00010-00000-KTOMIAK 20

DEMO.README(AGE)

Did you start editing a member before making a backup copy? Well, it
is not too let. Issue AGE newmbr_name and the as yet unsaved edited
version will be copied to the newmbr_name. If you made changes and
did a save then that will be backed up. AGE is meant to be used just as
soon as your edit session starts.

Syntax: AGE newmbr_name
./ ADD NAME=BIORYTHM 0100-18014-18014-0910-00006-00006-00000-KTOMIAK 31

DEMO.README(BIORYTHM)

Invoked as part of the DEMO primary dialog panel selection.

It plots your emotional, intelligence, and physical levels.
./ ADD NAME=BITS     0100-18013-18013-1416-00015-00015-00000-KTOMIAK 26

DEMO.README(BITS)

REXX provides three bit oriented built-in functions: BITAND, BITOR, and
BITXOR. I include CHR2BIT and HEX2BIT as user functions to return the
bit string equivalent of the argument you pass to the function. This comes
in handy when parsing control blocks and you want to visualize the contents
of a flag type field. You can even test the bits for 0 and 1 representing
off and on.

REXX code CHR2BIT takes in a character (any of the 256 EBCDIC characters)
string and passes back the bit-string equivalent.

REXX code HEX2BIT takes in a hexadecimal string and passes back the
bit-string equivalent.
./ ADD NAME=BLKFCTR  0100-18014-18014-0919-00007-00007-00000-KTOMIAK 19

DEMO.README(BLKFCTR)

Calculates blocking factors to help find teh optimal BLKSIZE.

With system-managed storage you should code BLKSIZE=0 and let the
system determine half track blocking for you.
./ ADD NAME=BLKLTRS  0100-18094-18094-0740-00034-00034-00000-KTOMIAK 04

DEMO.README(BLKLTRS)

Purpose:    Overlay a 9x12 block with a blocked letter.
Abstract:   This EDIT macro accepts a short string of characters
            and overlays blocked letters at the cursor position.
            DEMO was used with blkltrs DEMO with the cursor
            five positions in on line 10.

     DDDDDD      EEEEEEEEE   MMM   MMM     OOOOO
     D     D     E           M  M M  M    O     O
     D      D    E           M   M   M   O       O
     D       D   E           M   M   M   O       O
     D       D   EEEEEEE     M       M   O   H   O
     D       D   E           M       M   O       O
     D      D    E           M       M   O       O
     D     D     E           M       M    O     O
     DDDDDD      EEEEEEEEE   M       M     OOOOO


            Minor checking is done prior to overlaying data.
            ---------------------------------------------------------
            1) Are there nine (9) lines to work with?
            2) Are their enough columns withing the BOUNDS
               of the dataset(member)?
            3) Are there valid characters?

            Special handling.
            ---------------------------------------------------------
            1) Shift-6 for the not-sign might be a caret character
               in Windows based terminal emulators. To get a not-sign
               you may need to use 'blkltrs notsign'.
            2) A space (blank) is another tricky character to request.
               Uou may need to use 'blkltrs space' or 'blkltrs blank'.
./ ADD NAME=BUBLSORT 0100-18018-18018-1509-00010-00010-00000-KTOMIAK 45

DEMO.README(BUBLSORT)

Three routines you can copy into your code and modify to the stem name
you want to sort. You can call Bubble_Sort_Ascending or
Bubble_Sort_Descending. The bigger your stem the longer it will take.
The third routine shows how to modify one of the two primary sort routines
to be more specific. Bubble_sort_Ascending_Word accepts a numeric and compares
that numbered word of the stem. You really need to know your data to
sort at lower than a record level.
./ ADD NAME=CASEIT   0100-18014-18014-0920-00004-00004-00000-KTOMIAK 34

DEMO.README(CASEIT)

Convert a text string to all lower or all upper case characters.
./ ADD NAME=CHR2BIT  0100-18033-18033-0844-00015-00015-00000-KTOMIAK 08

DEMO.README(CHR2BIT)

REXX provides three bit oriented built-in functions: BITAND, BITOR, and
BITXOR. I include CHR2BIT and HEX2BIT as user functions to return the
bit string equivalent of the argument you pass to the function. This comes
in handy when parsing control blocks and you want to visualize the contents
of a flag type field. You can even test the bits for 0 and 1 representing
off and on.

REXX code CHR2BIT takes in a character (any of the 256 EBCDIC characters)
string and passes back the bit-string equivalent.

REXX code HEX2BIT takes in a hexadecimal string and passes back the
bit-string equivalent.
./ ADD NAME=CNTLBLKS 0100-17142-17142-1634-00304-00304-00000-KTOMIAK 33
; Sample Control Block Location Information
;
;DSECT   Address    Description                                 Macro
;------- ---------- ------------------------------------- ----- --------
PSA      0.         Prefixed Save Area                    PVT   IHAPSA
CVT      PSA+10.    Communication Vector Table            NUC   CVT
PCCA     PSA+208    Physical Configuration Comm. Area     SQA   IHAPCCA
LCCA     PSA+210    Logical Configuration Comm. Area      SQA   IHALCCA
TCB      PSA+21C    Task Control Block (current)          LSQA  IKJTCB
ASCB     PSA+224    Address Space Control Block (current) SQA   IHAASCB
;
PSA      0.         Prefixed Save Area                    PVT   IHAPSA
CVT      PSA+10.    Communication Vector Table            NUC   CVT
CVTFIX   CVT-100    Communications Vector Table Prefix
UCM      CVT+64     Unit Control Module                   NUC   IEECUCM
IOCOM    CVT+7C     I/O Communication area                NUC   IECDIOCM
ECVT     CVT+8C     Extended CVT                          ENUC  IHAECVT
BASEA    CVT+94     Master Scheduler Resident Data Area   NUC   IEEBASEA
TSVT     CVT+9C     TSO/E Vector Table                    CSA   IKJTSVT
LPAQ     CVT+BC     LPA Cde List
SMCA     CVT+C4     SMF Control Table                     SQA   IEESMCA
SCVT     CVT+C8     Secondary Communication Vector Table  NUC   IHASCVT
JESCT    CVT+128    JES Communication Table               NUC   IEFJESCT
CVTEXT   CVT+148    Communications Vector Table Extention
PVT      CVT+164    RSM Page Vector Table
GVT      CVT+1B0    GRS Vector table
ASVT     CVT+22C    Address Space Vector Table            NUC   IHAASVT
GDA      CVT+230    Global Data Area                      ESQA  IHAGDA
RTCT     CVT+23C    Recovery/Termination Control Table
SHDR     CVT+250
RMCT     CVT+25C    System Resources Manager Ctrl Table   ENUC  IRARMCT
CSD      CVT+294    Common System Data                    SQA   IHACSD
ASMVT    CVT+2C0    Auxiliary Storage Mgt Vector Table    NUC
PCCAVT   CVT+2FC    PCCA Vector Table                     SQA   IHAPCCAT
LCCAVT   CVT+300    LCCA Vector Table                     SQA
SFT      CVT+304
STGS     CVT+31C    Measurement Facility Control Block
SCCB     CVT+340    Service Call Control Block            ESQA  IHASCCB
SVT      CVT+364    Supervisor Vector Table               NUC   IHASVT
HSM      CVT+3DC
RCVT     CVT+3E0    RACF CVT                              SQA   ICHPRCVT
HID      CVT+42C    CPU Information Iosdshid
RCE      CVT+490    RSM Control and Enumeration Area      ENUC  IARRCE
VSTGX    CVT+4AC    Virtual Storage Extension of CVT      NUC
NUCMAP   CVT+4B0    Nucleus Map                           ENUC
DFA      CVT+4C0    DFP Id Table
LLT      CVT+4DC    Link List Table                       SQA
LNKLST   CVT+4DC    Link List Table                       SQA
;
PSA      0.         Prefixed Save Area                    PVT   IHAPSA
ASCB     PSA+224    Address Space Control Block (current) SQA   IHAASCB
SVRB     ASCB+10
CSCB     ASCB+38    Command Scheduling Control Block      ELSQA IEECHAIN
TSB      ASCB+3C    Terminal Status Block (current)       CSA   IKJTSB
ASXB     ASCB+6C    Address Space Extension Block         LSQA  IHAASXB
OUCB     ASCB+90    Resources Manager User Cont Blk       ESQA  IRAOUCB
OUXB     ASCB+94    Resources Manager User Extension Blk  ESQA  IHAOUXB
ASCBJBNI ASCB+AC    ASCB (Current) Batch Jobname (or zero)
ASCBJBNS ASCB+B0    ASCB (Current) Start/Mount/Logon
ASSB     ASCB+150   Addr Space Secondary Block (current)  ESQA  IHAASSB
RAX      ASCB+16C   RSM Add Space Block Extension         ESQA  IARRAX
RAB      ASCB+178   RSM Address Space Block
;
PSA      0.         Prefixed Save Area                    PVT   IHAPSA
ASCB     PSA+224    Address Space Control Block (current) SQA   IHAASCB
LDA      ASCB+30    Local Data Area                       ELSQA IHALDA
ASXB     ASCB+6C    Address Space Extension Block         LSQA  IHAASXB
ACEE     ASXB+C8    Accessor Environment Element          LSQA  IHAACEE
ACEX     ACEE+98    ACEE extension (current)              LSQA
;
CVT      PSA+10.    Communication Vector Table            NUC   CVT
ECVT     CVT+8C     Extended CVT                          ENUC  IHAECVT
CSVT     ECVT+E4    Contents Supervisor Table
LLTX     CSVT+4     Link List Table Volumes
APHT     CSVT+C
APHT??   APHT+8     APF List
;
PSA      0.         Prefixed Save Area                    PVT   IHAPSA
ASCB     PSA+224    Address Space Control Block (current) SQA   IHAASCB
CSCB     ASCB+38    Command Scheduling Control Block      ELSQA IEECHAIN
CSCX     CSCB+DC    CSCB Extension                        SQA
;
PSA      0.         Prefixed Save Area                    PVT   IHAPSA
CVT      PSA+10.    Communication Vector Table            NUC   CVT
ECVT     CVT+8C     Extended CVT                          ENUC  IHAECVT
DLCBC    ECVT+88    Dynamic Linklist Ctl Blk (current)    ESQA  CSVDLCB
IPA      ECVT+188   Initialization Parameter Area         ECSA  IHAIPA
;
PSA      0.         Prefixed Save Area                    PVT   IHAPSA
ASCB     PSA+224    Address Space Control Block (current) SQA   IHAASCB
ASSB     ASCB+150   Addr Space Secondary Block (current)  ESQA  IHAASSB
DLCBU    ASSB+EC    Dynamic Linklist Ctl Blk (user)       ESQA  CSVDLCB
VAB      ASSB+F0    VSM Address space Block               ESQA  IGVVAB
XMSE     ASSB+48    Cross_Memory Control Block (current)  EPVT
;
PSA      0.         Prefixed Save Area                    PVT   IHAPSA
ASCB     PSA+224    Address Space Control Block (current) SQA   IHAASCB
ASXB     ASCB+6C    Address Space Extension Block         LSQA  IHAASXB
LWA      ASXB+14    TSO LWA
OUSB     ASXB+80    Resources Manager User Swappable Blk  ELSQA IHAOUSB
;
PSA      0.         Prefixed Save Area                    PVT   IHAPSA
CVT      PSA+10.    Communication Vector Table            NUC   CVT
BASEA    CVT+94     Master Scheduler Resident Data Area   NUC   IEEBASEA
BASEX    BASEA+C8   Basea Extension                       ESQA  IEEBASEA
;
PSA      0.         Prefixed Save Area                    PVT   IHAPSA
CVT      PSA+10.    Communication Vector Table            NUC   CVT
CVTEXT   CVT+148    Communications Vector Table Extention
VTAMCVT  CVTEXT+40
;
PSA      0.         Prefixed Save Area                    PVT   IHAPSA
CVT      PSA+10.    Communication Vector Table            NUC   CVT
DFA      CVT+4C0    DFP Id Table
DFVT     DFA+2C
;
PSA      0.         Prefixed Save Area                    PVT   IHAPSA
CVT      PSA+10.    Communication Vector Table            NUC   CVT
ECVT     CVT+8C     Extended CVT                          ENUC  IHAECVT
DLCBC    ECVT+88    Dynamic Linklist Ctl Blk (current)    ESQA  CSVDLCB
LLTC     DLCBC+10   Link List Table (current)             SQA
LLTU     DLCBU+10   Link List Table (user)                SQA
;
PSA      0.         Prefixed Save Area                    PVT   IHAPSA
CVT      PSA+10.    Communication Vector Table            NUC   CVT
GDA      CVT+230    Global Data Area                      ESQA  IHAGDA
CAUBU    GDA+19C    Unowned CAUB                          ESQA  IGVCAUB
CAUBS    GDA+194    System CAUB                           ESQA  IGVCAUB
SPT      GDA+88     VSM Subpool Table                     ESQA  IHASPT
;
PSA      0.         Prefixed Save Area                    PVT   IHAPSA
CVT      PSA+10.    Communication Vector Table            NUC   CVT
HSM      CVT+3DC
HSMASCB  HSM+8      HSM ASCB if any!
;
PSA      0.         Prefixed Save Area                    PVT   IHAPSA
CVT      PSA+10.    Communication Vector Table            NUC   CVT
IOCOM    CVT+7C     I/O Communication area                NUC   IECDIOCM
IOVT     IOCOM+D0   IOS Vector Table                      ENUC
;
PSA      0.         Prefixed Save Area                    PVT   IHAPSA
CVT      PSA+10.    Communication Vector Table            NUC   CVT
IOCOM    CVT+7C     I/O Communication area                NUC   IECDIOCM
IOVT     IOCOM+D0   IOS Vector Table                      ENUC
ULUT     IOVT+8     Ucb Lookup Table                      ESQA
CDA      IOVT+18    Configuration Data Area               ENUC
;
PSA      0.         Prefixed Save Area                    PVT   IHAPSA
CVT      PSA+10.    Communication Vector Table            NUC   CVT
JESCT    CVT+128    JES Communication Table               NUC   IEFJESCT
SSCVT    JESCT+18   Subsystem Communications Vector Table
SSCT     JESCT+18   Subsystem Communications Vector Table CSA   IEFJSCVT
DACA     JESCT+78   Device allocation Communication Area  ECSA
;
PSA      0.         Prefixed Save Area                    PVT   IHAPSA
CVT      PSA+10.    Communication Vector Table            NUC   CVT
JESCT    CVT+128    JES Communication Table               NUC   IEFJESCT
SSCVT    JESCT+18   Subsystem Communications Vector Table
SSCT     JESCT+18   Subsystem Communications Vector Table CSA   IEFJSCVT
DACA     JESCT+78   Device allocation Communication Area  ECSA
VATLST   DACA+C     Volume Attributs List                 ECSA
EDT      DACA+60
EDTL     DACA+60    EDT list                              ECSA
EDT1     EDTL+10    First EDT                             ECSA
EDT2     EDTL+14    Second EDT                            ECSA
;
EDT      DACA+60
LUV      EDT+10
LUV??    LUV+1C
;
TCB      PSA+21C    Task Control Block (current)          LSQA  IKJTCB
JSCB     TCB+B4     Job/Step Control Block                LSQA  IEZJSCB
JCT      JSCB+104   Job Control Table
PSCB     JSCB+108   TSO Protected Step Control Block
SCT      JSCB+148   Step Control Table
JSCBACT  JSCB+15C   Active Job/Step Control Block         LSQA  IEZJSCB
;
TCB      PSA+21C    Task Control Block (current)          LSQA  IKJTCB
JSCB     TCB+B4     Job/Step Control Block                LSQA  IEZJSCB
JCT      JSCB+104   Job Control Table
PSCB     JSCB+108   TSO Protected Step Control Block
SCT      JSCB+148   Step Control Table
JSCBACT  JSCB+15C   Active Job/Step Control Block         LSQA  IEZJSCB
SSIB     JSCBACT+13C  Subsystem Identification Block      LSQA  IEFJSSIB
;
PSA      0.         Prefixed Save Area                    PVT   IHAPSA
ASCB     PSA+224    Address Space Control Block (current) SQA   IHAASCB
ASXB     ASCB+6C    Address Space Extension Block         LSQA  IHAASXB
LWA      ASXB+14    TSO LWA
CPPL     LWA+254    TSO CPPL
;
TCB      PSA+21C    Task Control Block (current)          LSQA  IKJTCB
JSCB     TCB+B4     Job/Step Control Block                LSQA  IEZJSCB
JCT      JSCB+104   Job Control Table
PSCB     JSCB+108   TSO Protected Step Control Block
UPT      PSCB+34
;
PSA      0.         Prefixed Save Area                    PVT   IHAPSA
CVT      PSA+10.    Communication Vector Table            NUC   CVT
PVT      CVT+164    RSM Page Vector Table
RIT      PVT+4      RSM Internal Table
RSH      PVT+14     RSM RECOVERY REFRESH TABLE
;
PSA      0.         Prefixed Save Area                    PVT   IHAPSA
CVT      PSA+10.    Communication Vector Table            NUC   CVT
RCVT     CVT+3E0    RACF CVT                              SQA   ICHPRCVT
DSDT     RCVT+E0    RACF Dataset Descriptor Table         ECSA
RCVX     RCVT+258   Racf CVT Extension                    SQA
DPTB     RCVT+2E8   RACF Dynamic Parse Table              ECSA
;
PSA      0.         Prefixed Save Area                    PVT   IHAPSA
CVT      PSA+10.    Communication Vector Table            NUC   CVT
RMCT     CVT+25C    System Resources Manager Ctrl Table   ENUC  IRARMCT
CCT      RMCT+4     SRM CPU management Control Table      ENUC
ICT      RMCT+8     I/O Management Control Table          ENUC
MCT      RMCT+C     Storage Management Control Table      ENUC  IRAMCT
RMPT     RMCT+10    Srm
RMCA     RMCT+14    System Resource Manager Control Area
WMST     RMCT+18    WMST wlm srm                          ESQA  IRAWMST
WMCT     RMCT+20    WMCT wlm srm
RMEX     RMCT+28    SRM External Entry Point Descriptor
LSCT     RMCT+3C    Logical Swap Control Table            ENUC
DMCT     RMCT+B4    Domain Table                          ESQA
RCT      RMCT+E4    SRM Resource Control Table            ENUC  IRARCT
;
TCB      PSA+21C    Task Control Block (current)          LSQA  IKJTCB
JSCB     TCB+B4     Job/Step Control Block                LSQA  IEZJSCB
JCT      JSCB+104   Job Control Table
PSCB     JSCB+108   TSO Protected Step Control Block
SCT      JSCB+148   Step Control Table
SCTX     SCT+44     Step Control Table Extension
;
SCVT     CVT+C8     Secondary Communication Vector Table  NUC   IHASCVT
SVCT     SCVT+84    SVC table                             ENUC  IHASVC
SVCTABLE SCVT+84    SVC Table
SVCTAB2  SCVT+88    SVC Update Recording Table
;
PSA      0.         Prefixed Save Area                    PVT   IHAPSA
CVT      PSA+10.    Communication Vector Table            NUC   CVT
SMCX     SMCA+178   SMCA Extension
SMCA     CVT+C4     SMF Control Table                     SQA   IEESMCA
;
TCB      PSA+21C    Task Control Block (current)          LSQA  IKJTCB
JSCB     TCB+B4     Job/Step Control Block                LSQA  IEZJSCB
SPQE     TCB+18
SPQA     SPQE+8
DQE      SPQA       VSM Descriptor Queue Element
;
PSA      0.         Prefixed Save Area                    PVT   IHAPSA
CVT      PSA+10.    Communication Vector Table            NUC   CVT
JESCT    CVT+128    JES Communication Table               NUC   IEFJESCT
SSCVT    JESCT+18   Subsystem Communications Vector Table
SSCT     JESCT+18   Subsystem Communications Vector Table CSA   IEFJSCVT
SSVT     SSCT+10    Subsystem Vector Table                CSA   IEFJSSVT
;
PSA      0.         Prefixed Save Area                    PVT   IHAPSA
CVT      PSA+10.    Communication Vector Table            NUC   CVT
MFCB     CVT+31C    Measurement Facility Control Block
LPAR     MFCB+2EC   Lpar information
;
PSA      0.         Prefixed Save Area                    PVT   IHAPSA
CVT      PSA+10.    Communication Vector Table            NUC   CVT
SVT      CVT+364    Supervisor Vector Table               NUC   IHASVT
XMD      SVT+94     Cross_Memory Directory (in PCAUTH)    EPVT  IHAXMD
;
TCB      PSA+21C    Task Control Block (current)          LSQA  IKJTCB
RB       TCB        Rb for this task
;
TIOT     TCB+C      Task Input/Output Table (current)     LSQA  IEFTIOT1
SPQE     TCB+18
LLE      TCB+24     Last Load List Element
JSTCB    TCB+7C     Job Step TCB
TCBFSA   TCB+70     TCB First Save Area
TCT      TCB+A4     Smf Timing Control Table
;
TCB      PSA+21C    Task Control Block (current)          LSQA  IKJTCB
TCT      TCB+A4     Smf Timing Control Table
TCTSTOR  TCT+8      TCT Storage Area
;
PSA      0.         Prefixed Save Area                    PVT   IHAPSA
ASCB     PSA+224    Address Space Control Block (current) SQA   IHAASCB
ASSB     ASCB+150   Addr Space Secondary Block (current)  ESQA  IHAASSB
VAB      ASSB+F0    VSM Address space Block               ESQA  IGVVAB
CAUB     VAB+8      Common Area User Block (current)      ESQA  IGVCAUB
;
PSA      0.         Prefixed Save Area                    PVT   IHAPSA
CVT      PSA+10.    Communication Vector Table            NUC   CVT
VSTGX    CVT+4AC    Virtual Storage Extension of CVT      NUC
LPAT     VSTGX+38   Link Pack Area Table                  EPLPA
;
PSA      0.         Prefixed Save Area                    PVT   IHAPSA
CVT      PSA+10.    Communication Vector Table            NUC   CVT
RMCT     CVT+25C    System Resources Manager Ctrl Table   ENUC  IRARMCT
WMCT     RMCT+20    WMCT WLM SRM
SCTE     WMCT+24    WLM SRM
;
;
; Orphaned control block in original source
;
CPMT     CMCT+C     Channel Path Measurement Table
;
PIT      HCCT+4F0   Initiator List (Changes Frequently)
SJB      PIT+4
;
./ ADD NAME=CONDCODE 0100-18014-18014-0921-00007-00007-00000-KTOMIAK 26

DEMO.README(CONDCODE)

Purpose:    Retrieve Condition Codes for each prior step.
Abstract:   Follow MVS control blocks to the STEP CONTROL TABLE,
            then decipher status bytes to display what occurred
            for each of the prior steps.
./ ADD NAME=CRDG     0100-18036-18036-1215-00017-00017-00000-KTOMIAK 57

DEMO.README(CRDG)

DEMO.CNTL(CRDG*) contain sample jobs to work with a CICS CSD (DFHCSD).

  CRDGCBDC compiles and links a slightly modified version of
  IBM's DFH0CBDC COBOL II program used in an EXTRACT. It places
  each option on its own line.

  CRDG02* defines and initializes the DFHCSD.

  CRDG05* thru CRDG36 define each resource-type using all of the
  option combinations as a way of validatating the DATA(DFHRMETA)
  definitions used by REXX(DFHRXALL) to parse DFHCSD records directly.

  CRDG38* show how to use other DFHCSDUP commands other than ALTER, DEFINE,
  and DELETE.
./ ADD NAME=CSRDSN   0100-18112-18112-0318-00031-00031-00000-KTOMIAK 13

DEMO.README(CSRDSN)

Ever want to put the cursor on a data set name and have something
useful happen? Using this EDIT macro you can VIEW (the default),
BROWSE, or EDIT the data set. Use DSCB to flesh out a DD statement
usable for a DISP=(NEW,CATLG) use. Want to view the information LISTDSI
and DSINFO provide? INFO will provide a side-by-side report. LIST will
run LISTCAT ENTRY() ALL output for your viewing pleasure.

Referencing a BASE GDG name to get all GDS items? No problem, a list
of the GDS names will be added as '==MSG>' lines that you can then use.
GDS items will be shown in the proper LIFO or FIFO order.

VSAM support is dependent on your installation having a tool that can
browse, edit, or view the cluster. Code currently invokes IBM FileManager.

Do you use SET or have instream procedures that define values for
symbolics? Substitution will be done in an attempt to resolve the
true data set name.

z/OS UNIX System Services directory and filenames are also supported.
At least one forward slash (/) is required.

Syntax: CSRDSN
Syntax: CSRDSN help
Syntax: CSRDSN browse
Syntax: CSRDSN dscb
Syntax: CSRDSN edit
Syntax: CSRDSN info
Syntax: CSRDSN listcat
./ ADD NAME=DDBYCBLK 0100-18033-18033-0918-00012-00012-00000-KTOMIAK 01

DEMO.README(DDBYCBLK)

DDBYCBLK stands for discover allocated DD statemtns by following MVS
control blocks.

My primary use is to validate a DDNAME is allocated and discover to what data
set it refers. During LOGON processing it can be advantageous to know what the
current allocations are and then manipulate the list and reallocate the DD.

Another use would be identifying the concatenated data sets and performing a
search on each individual data set looking for duplicate member names.
./ ADD NAME=DDBYLSTA 0101-18014-18033-0917-00012-00012-00000-KTOMIAK 06

DEMO.README(DDBYLSTA)

DDBYLSTA stands for discover allocated DD statements by using the TSO
LISTALC STATUS command.

My primary use is to validate a DDNAME is allocated and discover to what data
set it refers. During LOGON processing it can be advantageous to know what the
current allocations are and then manipulate the list and reallocate the DD.

Another use would be identifying the concatenated data sets and performing a
search on each individual data set looking for duplicate member names.
./ ADD NAME=DDBYQLIB 0100-18033-18033-1120-00006-00006-00000-KTOMIAK 36

DEMO.README(DDBYQLIB)

DDBYQLIB stands for discover allocated DD statemtns by using the ISPF
QBASELIB FEATURE.

./ ADD NAME=DDBYUSS  0100-18033-18033-0948-00012-00012-00000-KTOMIAK 48

DEMO.README(DDBYUSS)

DDBYUSS stands for discover allocated DD statemtns by using the UNIX
System Services bpxwdyn feature.

BPXWDYN is limited to retrieving ONLY the first data set name allocated
to the requested DDname.

I have no use for this routine as the DDBYCBLK and DDBYLSTA provide a
complete retrieval of DSnames allocated. That allows you to know if
the DDname can be opened for output or not.
./ ADD NAME=DFHR     0101-18018-18018-1122-00017-00015-00000-KTOMIAK 45

DEMO.README(DFHR)

Also known as CICS stuff. Complements DEMO.README(TXID).

DEMO.CNTL(DFHR1388) runs DEMO.REXX(DFHR1388) to analyze the startup
group of your choosing and builds control cards to alter descriptions
to known values the vendors failed to provide.

If you have a VSAM editing tool like File-Aid then you can edit the DFHCSD to
update the IBM Protected transactions with lame descriptions to something
meaningful. You could also REPRO your DFHCSD to a flat file, update that, then
REPRO the flat file to an empty (not initialized) DFHCSD. You may have to
update a field length, I do not have a VSAM editing tool handy at this
point in time.

DEMO.CNTL(DFHRMETA) is a data file describing the DFHCSD record formats.
./ ADD NAME=DFHRXALL 0100-18033-18033-0959-00006-00006-00000-KTOMIAK 33

DEMO.README(DFHRXALL)

DEMO.CNTL(DFHRXALL) invokes DEMO.REXX(DFHRXALL) to
read the output from a repro of a DFHCSD to a flat file and
show the description of transaction identifiers (TXID).
./ ADD NAME=DISKRVBS 0100-18016-18016-1052-00011-00011-00000-KTOMIAK 27

DEMO.README(DISKRVBS)

Overview: With the right level of TSO/E REXX you can now do DISK I/O
          to RECFM=VBS data sets. SMF data typically falls under
          VBS.

DEMO.CNTL(DISKRVBS) is a sample job to run the REXX code.
DEMO.REXX(DISKRVBS) will allocate and read a VBS file showing the
mimimum (smallest) record length the the maximum (largest) record length.

./ ADD NAME=DISPLYSZ 0100-18014-18014-0932-00006-00006-00000-KTOMIAK 52

DEMO.README(DISPLYSZ)

Overview: Retrieve the display length and width.
          Length = rows/lines.
          Width = characters per row/line.
./ ADD NAME=EXECIO   0100-18014-18014-0945-00010-00010-00000-KTOMIAK 17

DEMO.README(EXECIO)

EXECIO is a powerfil file read/write Application Programming Interface.
It operates at an application level, thus you can open a file with EXECIO in
one routine and call another routine to read/write the open file.

EXECIO1 allocates a file and then calls upon EXECIO2 to call upon EXECIO3
to write 6 records. Control returns to EXECIO2 which reads 3 records. Control
returns to EXECIO3 and a fourth record is read. EXECIO1 then closes the file.
./ ADD NAME=HEX2BIT  0100-18033-18033-0844-00015-00015-00000-KTOMIAK 32

DEMO.README(HEX2BIT)

REXX provides three bit oriented built-in functions: BITAND, BITOR, and
BITXOR. I include CHR2BIT and HEX2BIT as user functions to return the
bit string equivalent of the argument you pass to the function. This comes
in handy when parsing control blocks and you want to visualize the contents
of a flag type field. You can even test the bits for 0 and 1 representing
off and on.

REXX code CHR2BIT takes in a character (any of the 256 EBCDIC characters)
string and passes back the bit-string equivalent.

REXX code HEX2BIT takes in a hexadecimal string and passes back the
bit-string equivalent.
./ ADD NAME=ISPFBTCH 0101-18018-18030-1215-00005-00005-00000-KTOMIAK 44

DEMO.README(ISPFBTCH)

DEMO.CNTL(ISPFBTCH) can be used in a batch job that has allocated the
proper TSO and ISPF allocations to run REXX code that uses ISPF services.
./ ADD NAME=IXCMIAPU 0100-18019-18019-1117-00004-00004-00000-KTOMIAK 01

DEMO.README(IXCMIAPU)

DEMO.CNTL(IXCMIAPU) will list defined LOGSTREAMS.
./ ADD NAME=KTPM     0104-18013-18181-0832-00046-00007-00000-KTOMIAK 12

Kenneth Tomiak Programming Method (KTPM) collection.

KTPM.README(KTPM)

KTPM is a REXX primary program that displays a selection menu panel. It is
designed to hold more options than fit on the screen. It also shows where the
limit for 24, 32, and 43 lines per screen land. Options can be selected even
when they are not displayed on the screen.

In the MS-Windows world of applications we are presented with a MENU bar and a
QUICK ACCESS TOOLBAR at the top of the screen. In the IBM-ISPF world of dialogs
we can use PDC and point and shoot fields to mimic MS-Windows display style.

Dynamically built panels typically restrict themselves to the old and common
24x80 screen size. Data Tag Language (DTL) allows for building a panel that
supports a larger screen size, but is still limited to knowing which screen
size is being used to then display the appropriate panel. A few users have
found custom sized displays to their liking and then live with applications
not taking advantage of the panel size. I offer little help in custom sized
display support and recommend you stick with the three common sizes of
24x80, 27x132, and 43x132. Using a scrollable panel you then have two sizes
to contend with; the 80 column wide and the 132 column wide display sizes.

My primary selection panel uses both numbered and named options. 0 thru 2
mimic what many installations have. "R" and "SD" launch vendor tools. 10 thru
13 launch some additional demonstration styles of panels. 14 thru 50 are
placeholders to show where the bottom of a panel is on different sized
displays.

Option 11 KTPMDEEP has 85 lines with one data entry field per line.
It uses a scrollable panel that supports multiple data entry fields. I
searched for any example of building a dynamic panel and found the same
limitation in all of what GOOGLE found: data entry fields had to fit on the
fixed portion of the panel. I overcame this limitation by updating the variables
based on what portion of the dynamic area was being presented.

Option 12 KTPMTBL1 uses ISPF services to present fields from a table.
In addition to scrollable panels there are scrollable fields. A long field
is supported by using multiple lines or a scrollable field. Option 12 shows
how to use scrollable fields with an ISPF table. You can scroll right and left
in the last column, You can also sort using either of the blue colored
column names.

Option 13 KTPMCNSL uses CONSOLE services with the DEVSERV command to show
online DISK attributes.
./ ADD NAME=LIFOFIFO 0100-18096-18096-0922-00021-00021-00000-KTOMIAK 21

DEMO.README(LIFOFIFO)

For many decades the use of a GDG base name in JCL required sorting
timestamp sensitive data before it could be used because the last
(most recent) catalogued GDS was returned first and the first (oldest)
catalogued GDS was returned last.

With PARMLIB(IGGCATxx) specifying GDGFIFOENABLE(YES) you then ALTER
your GDG base to FIFO and LIFO as the need arises. By using FIFO you
eliminate having to SORT data that was otherwise in chronological order.

Be aware that SMF and RMF may not have been written out in chronological
order. However, if you sorted the data to create the GDS then there is
no need to sort FIFO GDS.


Setup:   *.PARMLIB(IEASYSxx): CATALOG=xx
         *.PARMLIB(IGGCATxx): GDGFIFOENABLE(YES)


./ ADD NAME=LOGON    0102-18010-18013-0901-00031-00029-00000-KTOMIAK 09

DEMO.README(LOGON)

Every installation has their own screwy methods of allocating data sets to a
TSO/E session and launching ISPF. Under LOGON I present one way to use a CLIST
for its ability to use NOFLUSH and MAIN and then call on REXX code to allocate
the important TSO/E and ISPF related data sets prior to launching ISPF to a
named panel. It optionally adds user named data sets, convenient for the System
Programmer developing tools for themself and others.

Another method uses a data list and validates each entry. It can place entries
ahead of or following other data sets. Ideally you start out with data sets in
most frequently used order and then prepend your test data sets ahead of the
production version.

It is also possible to use the LOGON procedure name to allocate role based data
sets. Likewise, you could discover what SAF (ACF2, RACF, TSS) groups the user is
connected to and do role based allocations.

As far as performance goes, the fewer data sets you have allocated the quicker
it is to logon. For that reason, some installations reward quick response time
over split screen dedicated tool sessions. That is, the logon procedure and
accompanying CLIST/REXX allocations are for the bare bones data sets to have
ISPF work. Thereafter, invoking a panel selection will allocate the tool data
sets under that split screen session. The goal would be to let the user keep
many split screen sessions open and swap to them instesd of constantly opening
and closing the same tool throughout the day.

Clist LOGONKET calls REXX LOGONTSO to optionally prepend user's data sets.
Clist MYISPF calls REXX MYALLOC.
Clist ON starts ISPF.
./ ADD NAME=OBJ2HEX  0100-18015-18015-1603-00010-00010-00000-KTOMIAK 28

DEMO.README(OBJ2HEX)

Overview: Reads any 80 byte data set and writes out two hex lines
          for each record. It also writes out JCL that can be used
          to reconstruct it. This is useful for OBJECT decks and
          ISPF panels that use non-display (hexadecimal) attributes.

Use DEMO.CNTL(OBJ2HEX) to create BUILDOB(object) and JCL (object$).
Use DEMO.BUILDOBJ(object$) to reconstruct the member.
./ ADD NAME=PDS2     0101-18015-18015-1613-00008-00000-00000-KTOMIAK 47

DEMO.README(PDS2)

DEMO.REXX(PDS2UPDT) converts a PDS into an IEBUPDTE stream.
Pass a valid PDS data set name. Output goes to
&SYSUID.SEQOUT.original.name

DEMO.REXX(PDS2XMIT) uses a panel to help transmit a PDS.
./ ADD NAME=REXXREF  0100-18014-18014-0909-00008-00008-00000-KTOMIAK 16

DEMO.README(REXXREF)

REXX members REXR* are examples of using the instructions and built-in
functions documented in the REXX Reference manual chapters 3, 4, and 10.

These working examples are provided to help the new REXX coder understand
how to use the instructions and built-in functions.
./ ADD NAME=SDUMPKT  0100-18014-18014-0913-00046-00046-00000-KTOMIAK 30

DEMO.README(SDUMPKT)

 Overview: Similar to using IPCS to view storage.
           SDUMPKT is a Storage (memory) display tool.

 Syntax:   SDUMPKT {Address {O+/-ffset} {Length} {Display {Rows}}}
           tso %sdumpkt '0'x 128
             Takes the defaults for Offset, Length, and Display.
           tso %sdumpkt '0'x +16 4 t 33
             Without keyword labels the positional sequence is needed.
           tso %sdumpkt =a'0'x =0+16 =l4 =dt =r33
             When using the keyword labels they can be in any order.
           1) Address: The starting location in X, D, or named format.
              DEFAULT: "0"x
              Mimimum: "0"x | 0
              Maximum: 4TB-16 ((2 ** 40) - 16)
                       "03FFFFFFFFF0"x
                       4398046511088
              Named  : Limited control block support.
                        ACEE
                        ASCB
                        ASXB
                        CVT
                        PSA
                        RCVT
           2) Offset : Added to starting address in X or D format.
              DEFAULT: +"0"x
                +    : Move starting address forward.
                -    : Move starting address backward.
              Minimum: Result cannot be less than 0
              Maximum: Result cannot exceed starting address maximum.
           3) Length:  How much storage is retrieved.
              DEFAULT: 256
              Minimum: 16
              Maximum: output-based.
           4) {T}erminal | {P}anel | {V}iew
              DEFAULT: Panel when ISPF is ACTIVE, else TSO/E.
                Panel: ISPF based table.
                TSO/E: linemode.
                View : temporary data set.
           5) {R}ows for TSO/E paging.
              DEFAULT: 23 on a 24x80 terminal.
              If you set this higher than what fits you will not get
              the heading at the top.

./ ADD NAME=SHOW     0100-18018-18018-1150-00009-00009-00000-KTOMIAK 56

DEMO.README(SHOW)

The DEMO.CNTL(SHOW*) members highlight how a passed parameter is
seen by programs. Your calling program and called sub-routine must
match in whether a parameter-list, length of parm, or just the
parameter are pointed at.

The layout of the parameter must also match between caller and callee.
./ ADD NAME=STEROIDS 0100-18032-18032-1314-00010-00010-00000-KTOMIAK 11

DEMO.README(STEROIDS)

DEMO.CNTL(STEROIDS) is used as a batch job that has allocated the
proper TSO and ISPF allocations to run REXX code that uses ISPF services.

It shows various ways to call a COBOL program, uses CONSOLE services,
and an enhanced version of SWAREQ (sware22) that handles above the bar JFCB
addresses. It will also read the IEFBR14 load module from SYS1.LINKLIB and
show the link-edit date.
./ ADD NAME=TSAD0690 0100-18018-18018-1147-00005-00005-00000-KTOMIAK 50

DEMO.README(TSAD0690)

DEMO.CNTL(TSAD0690) is JCL to assemble and link a program that uses
SNAPSHOT to dump pre-selected memory address locations
./ ADD NAME=TXID     0100-18018-18018-1119-00006-00006-00000-KTOMIAK 39

DEMO.README(TXID)

DEMO.CNTL(TXID*) members are data files for DFHR1388. They hold meaningful
descriptions for known transaction identifiers. See DEMO.README(DFHR) for
more on updating descriptions in your DFHCSD to something useful.
./ ADD NAME=URLCHECK 0100-18030-18030-1213-00008-00008-00000-KTOMIAK 58

DEMO.README(URLCHECK)

DEMO.CNTL(URLCHECK) can be used in a batch job to run the REXX code that
retrieves the last modification date of a web page and lets you know if
it has been updated since the previous check.

A list of URLs to check is stored in DEMO.DATA(URLCHECK).
```

