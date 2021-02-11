                     SOFTWARE STATUS REPORT
                     ----------------------
     SOFTWARE STATUS REPORT is an ISPF application consisting of 3 load modules,
2 CLISTs, 5 ISPF panels, 5 ISPF tutorial panels, and 4 ISPF message members.
It allows recording of software products installed on your system and
maintenance history for each product. Products can be displayed by PRODUCT NAME,
ACRONYM, VENDOR, CATEGORY, FMID OR PTF/MOD. A formatted hardcopy report can be
produced, with products organized on the report according to customizeable
combinations of VENDOR and CATEGORY.


     Throughout this installation tape the following dataset naming conventions
are used:
          Hi-level qualifier SSR denotes PS and PO datasets
          Hi-level qualifier SSRV denotes VSAM datasets

Change these as needed throughout this PDS to meet your installation needs.


     The SOFTWARE STATUS database consists of 5 VSAM datasets:

        SSRV.SOFTSTAT.INDXTBL - RRDS - Rec Len 2040
           - holds up to 58 VENDOR or CATEGORY names per record
        SSRV.SOFTSTAT.PRODTBL - RRDS - Rec Len 8180
           - holds up to 96 PRODUCT NAME/ACRONYMs per record
        SSRV.SOFTSTAT.HISTORY - KSDS - Rec Len 53
           - holds a single maintenance entry for a single product per record
        SSRV.SOFTSTAT.PTFAIX  - ALT INDEX
           - alt index to base cluster SSRV.SOFTSTAT.HISTORY
        SSRV.SOFTSTAT.FMIDAIX - ALT INDEX
           - alt index to base cluster SSRV.SOFTSTAT.HISTORY


                         CONTENTS OF TAPE
                         ----------------
1. SSR.SOFTSTAT.LIB - This PDS
2. SSR.SSRINTBL.INIT - 1 rec for initializing SSRV.SOFTSTAT.INDXTBL
3. SSR.SSRPRTBL.INIT - 1 rec for initializing SSRV.SOFTSTAT.PRODTBL
4. SSR.SSRHSTRY.INIT - 1 rec for initializing SSRV.SOFTSTAT.INDXTBL


                     INSTALLATION INSTRUCTIONS
                     -------------------------
1. Copy the 2 macros to your mac library. They are REG, RETURN72.
2. Assemble DATEMVS to a library where it can be included with SSR011PR.
3. Compile COBOL program SSR01AR, then assemble SSR010PR and SSR011PR.
4. (Optional) Copy source members for the above three modules from this PDS to
   your source library. The names are the same.
5. Copy the 2 procs on this PDS, SSRALLOC and SSRPRINT to your proc library.
6. Copy ISPF panels and tutorial panels from this PDS to your ISPF panel
   library. There are 10 in all: SSRPNL00, SSRPNL30, SSRPNL31, SSRPNL32,
   SSRPNL33, SSRPNL34, SSRHLP00, SSRHLP30, SSRHLP31, SSRHLP32, SSRHLP33,
   and SSRHLP34.
7. Copy the ISPF message members from this PDS to your ISPF message library.
   There are 4: SSRMS00, SSRMS01, SSRMS30, SSRMS90.
8. Copy the control cards for the print job from this PDS to your parm library.
   There are 2 members: SSRPRNTC and SSRPRNTS. SSRPRNTC will need to be
   customized for your installation - see below.
9. Member INIT on this PDS contains an IDCAMS job to define the VSAM clusters
   Alt-indexes and paths required, to initialize them from files supplied on
   the tape, and to build the alternate indexes. Edit member INIT first.
10. Edit the ISPF Menu from which you intend to invoke SOFTWARE STATUS REPORT
   to as follows:
       under this:     &ZSEL = TRANS(TRUNC(&ZCMD,'.')
                                .
                                .
                                .
         add this:           x,'CMD(SSRALLOC) NEWAPPL(SSR) NOCHECK'

11. In the APPLICATION COMMAND TABLE UTILITY (3.9), create an ISPF Command
   Table with APPLICATION ID = SSR, which will allow the ISPF commands DOWN
   and UP to be passed to the SSR application:
               VERB    T    ACTION
               ----    -    ------
               DOWN    4    PASSTHRU
               UP      2    PASSTHRU


                     CONTROL CARDS FOR PRINTING THE REPORT
                     -------------------------------------
     The proc SSRPRINT, copied to your proclib, contains a DD card for ddname
CNTLCARD, dsname YOUR.PARMLIB(SSRPRNTC). Member SSRPRNTC, copied to your parm
library, contains the control cards for formatting the report. These control
cards will need to be customized for you installtion.
     Products will be grouped in the report by VENDOR and CATEGORY within
VENDOR, or by CATEGORY and VENDOR within CATEGORY. Both types of grouping can
occur in the same report.
     Control card format is:
         1. Any number of spaces
         2. Keyword 1 (VENDOR or VEND, CATEGORY or CAT)
         3. Value for keyword 1, in parenthesis, no intervening spaces.
         4. Any number of spaces
         5. Keyword 2 (opposite of Keyword 1)
         6. Value for keyword 2, in parenthesis, no intervening spaces.
     If asterisk(*) is used for value, all values will be considered a match.

     Examples:
     ---------
   VEND(IBM)   CAT(OS)   - will list products alphabetically for which Vendor =
                          IBM and Category = OS
VENDOR(IBM) CATEGORY(*)  - will list IBM products alphabetically within all
                          categories (listed alphabetically)
   CAT(*)  VENDOR(*)     - will list by vendor within category.

     The first control card which a product matches will determine the
placement of the product in the report. Any given product will appear in the
report only once.
     If no control cards are supplied, CAT(*) VEND(*) is the default.
