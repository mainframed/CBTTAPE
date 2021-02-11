This is a bunch of rexx functions and some ispf stuff.

@CSR            - get data from ispf screen under cursor
ASM@CSR         - build @csr
ASMDEQ          - build rxdeq
ASMENQ          - build rxenq
ASMSLEEP        - build sleep
ASMSPFP         - build lgnspf
ASMWTOR         - build rxwtor
ASMXL           - build xl
AXBASML         - proc for assemblies
LGN@ENT         - entry macro
LGN@RET         - exit  macro
LGNASML         - proc for assemblies
LGNSPF          - Rexx function to return ISPF parms for LOGON proc exec
LGNSRCH         - binary search macro
LGNUDEFD        - part of lgnspf
LGNUDEFE        - part of lgnspf
LGNUDEFN        - part of lgnspf
LGNUDEFP        - part of lgnspf
RLTPLST         - plist to call rltsub
RLTSUB          - s/routine to return rexx result
RXDEQ           - issue DEQ macro from rexx exec
RXENQ           - issue ENQ macro from rexx exec
RXWTOR          - issue WTO/WTOR from rexx exec
SLEEP           - wait for specified number of seconds; ATTN terminates
SPFDOC          - doc for lgnspf
XL              - get the data from the screen and display a list of
                  datasets if data is a dataset name; works in edit,
                  browse and sdsf.
