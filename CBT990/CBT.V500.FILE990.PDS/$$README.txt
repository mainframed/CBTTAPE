This PDS contains the sample code that is referenced in the ISPF Tips
and Tricks publication. Code snippets are not included here as the
snippets are short examples.

An ISPF dialog has been provided to simplify access to these examples.

To experiment with the samples:  Execute the $DEVISPF exec

There are 2 TSO Transmit (XMIT) format files must be received and
installed to be used. These reside members of this PDS.  See member $$XMIT
for information on how to do this.

To experiment with these copy the REXX members into a library included in
your SYSEXEC (or SYSPROC) concatenation, and copy the Panel members into
a library in your ISPPLIB concatenation.

Documentation can be found at www.lbdsoftware.com where it is available in
ePUB, Mobi (Old Kindle), AZW3 (New Kindle) and PDF formats.

Member naming convention:
    $$   Informational members
    $    Code use to drive the driver ISPF application
    #    Members in TSO Transmit format
    JC   JCL members
    PN   Panel members
    RX   Rexx members
    CMT and LOADISPF are included as is
    S    Sample members used by sample code

Member types by ID:
    Macro  REXX ISPF Edit Macros
    Panel  ISPF Panels
    Rexx   REXX Exec
    Skel   ISPF Skeleton
    Text   Something to read
    XMIT   TSO Transmit format membetr
    Sample Sample member used by sample code

The members of this PDS are:

Member   Type    Description
$$README Text    Overview of the Samples
$$XMIT   Text    Doc on how to process the XMIT members
$DEVCPY  Rexx    Exec using LMCOPY to copy Samples into User Libraries
$DEVCPYP Panel   ISPF Prompt Panel for $DEVCPY
$DEVISPF Rexx    Exec to display the Sample Members
$DEVPH   Panel   ISPF Tutorial Panel for $DEVPP
$DEVPP   Panel   ISPF Panel used by $DEVISPF
$DEVPX   Panel   ISPF Popup Panel to Prompt for parms when executing Rexx
#RXFORM  XMIT    #RXFORM  tool in TSO Transmit format
#TRYIT   XMIT    #TRYIT tool in TSO Transmit format
CMT      Macro   Rexx Edit Macro to insert Comments in Code/JCL/etc.
JCBAT1   JCL     Sample ISPF in Batch JCL using the TASID Utility
JCBAT2   JCL     Sample ISPF in Batch JCL using the RXLMD   Rexx
LOADISPF Rexx    REXX code to be used with other code
PNABC    Panel   Sample ISPF Panel to demonstrate an Action Bar
PNAREA   Panel   ISPF Panel to demonstrate a scrolling Panel
PNDYN    Panel   ISPF Panel demonstrating a dynamic area
PNDYNTBL PANEL   ISPF Panel used by the RXDYNTBL - Dynamic Table Adds
PNDYNTP  Panel   ISPF Panel used by RXDYNTBL to prompt for values
PNEDITHL Panel   ISPF Panel demonstrating changing the data colors
PNFLDH   Panel   ISPF Panel to demonstrate Field Level Help
PNFLDH1  Panel   Sample Field Level Help panel
PNFLDH2  Panel   Sample Field Level Help panel
PNNUMC   Panel   ISPF Panel used by the RXNUMCE exec
PNPNS    Panel   ISPF Panel to demonstrate Point-and-Shoot
PNPOP    Panel   ISPF Panel to demonstrate ISPF Popup Panels
PNPOPV   Panel   ISPF Panel to demonstrate ISPF Popup Panels with dynamic msgs
PNPREXX  Panel   ISPF Panel to demonstrate Panel REXX
PNPROG1  Panel   ISPF Panel used by RXPROG1
PNPROG2  Panel   ISPF Panel used by RXPROG2
PNSCRL   Panel   ISPF Panel to demonstrate a scrollable field
PNTAB    Panel   ISPF Panel used by the RXTAB Exec and RXTABLE Exec
PNVDSN   Panel   ISPF Panel to demonstrate Panel REXX to validate a Data Set
RXABC    Rexx    Rexx code to drive the Action Bar Panel
RXAREA   Rexx    Rexx Exec to drive RXAREAP
RXCENTER Macro   Rexx Edit Macro to Center text and use a Range
RXCMDS   Rexx    Exec to demonstrate File Tailoring
RXDYN    Rexx    Rexx to demonstrate a dynamic ISPF Panel (PNDYN)
RXDYNTBL Rexx    Rexx to demonstrate adding rows to a table when needed
RXEDITHL Rexx    Rexx to demonstrate dyamic panel colors (PNEDITHL)
RXEDMHL  Rexx    Rexx used by RXEDITHL to insert messages
RXEM     Macro   Primary ISPF Edit macro for Alias Demonstration
RXEMAC   Macro   ISPF Edit Macro
RXEMACE  Rexx    Exec to demonstrate the ISPF Edit Macro use
RXEME    Macro   Edit Macro to replace the ISPF Edit END command
RXEMS    Macro   Edit Macro to replace the ISPF Edit SAVE command
RXEMTRY  Rexx    Exec to demonstrate ISPF command Aliases
RXFLD    Rexx    REXX code to drive PNFLDH
RXIVAR   Rexx    Rexx to display the value of any ISPF variable
RXLISPF  Rexx    Single Exec to demonstrate LOADISPF more fully
RXLMD    Rexx    Rexx to demonstrate using LMDLIST service
RXLMM    Rexx    Rexx to demonstrate using LMMLIST service
RXMSG    Rexx    Exec to demonstrate ISPF Messages
RXNOTEPD Rexx    Sample ISPF NotePad application
RXNUMC   Rexx    Exec subroutine to convert numbers to human readable
RXNUMCE  Rexx    Exec to demonstrate RXNUMC
RXPNS    Rexx    Exec to drive PNPNS
RXPNSL   Rexx    Single Exec using LOADISPF to demonstrate Point-and-Shoot
RXPOP    Rexx    Exec to drive PNPOP
RXPOPDO  Rexx    Exec to drive RXPOPM on all members of a data set
RXPOPKEY Rexx    Exec to drive RXPOP and demonstrate turning PFSHOW Off
RXPOPM   REXX    ISPF Edit Macro to report 'ideal' location for addpop
RXPREXX  Rexx    Exec to drive PNPREXX
RXPROG1  Rexx    Exec to demonstrate a progress popup
RXPROG2  Rexx    Exec to demonstrate a progress popup meter
RXRAND   Rexx    Exec to demonstrate various Random ddname techniques
RXRVAR   Rexx    Rexx to display/evaluate any REXX expression
RXSCRL   Rexx    Exec to display a panel with a scrollable field
RXSKLCMD Rexx    Exec to Demonstrate File Tailoring (Skel)
RXSKLRX  Rexx    Sample to demonstrate File Tailoring with REXX (Skel)
RXSKLRXE Rexx    Exec to demonstrate File Tailoring (Skel)
RXSKLRXV Rexx    Exec to demonstrate File Tailoring with variable (Skel)
RXSTEM   Rexx    Exec to demonstrate how to browse data in a stem variable
RXSTEME  Rexx    Exec to demonstrate how to STEMEDIT to browse a stem
RXSTEMS  Rexx    Exec to demonstrate sorting a stem variable
RXTAB    Rexx    Exec to demonstrate Table processing
RXTABLE  Rexx    Exec to demonstrate Table processing (improved)
RXTM     Rexx    Exec to demonstrate calling RXTSOMAC
RXTSOMAC Rexx    Exec to demonstrate detecting call as TSO or Edit Macro
RXVDSN   Rexx    Exec to drive RXVDSNP Panel
SKCMD    Skel    Sample Skeleton for RXSKLCMD
SKREXX   Skel    Sample Skeleton with REXX
SKREXXE  Skel    Skeleton to demonstrate Skeleton REXX with Execio
SKREXXV  Skel    Skeleton to demonstrate Skeleton REXX with variable
