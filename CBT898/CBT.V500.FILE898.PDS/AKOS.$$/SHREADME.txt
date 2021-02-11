 SHOWSTOR.
 ~~~~~~~~~
 SHOWSTOR is a REXX based program to let you look at storage.
 This storage may be looked at under your address space, under another
 address space or called from a program to navigate the program (also
 the contents of the on-line TSO address space).

 You can map storage using IBM supplied or your own DSECTS.

 Can be used as a vehicle for launching the on-line disassembler.

 Installation.
 ~~~~~~~~~~~~~
 1. Upload to mainframe into a sequential dataset (distributed dataset)
    which has minimum attributes of RECFM=FB,LRECL=80.
 2. Receive the distributed PDS by entering RECEIVE INDA(/) against
    the disributed dataset under ISPF option 3.4.
    If you take the defaults, it will be put into PDS
    'userid.ALLIN1.SHOWSTOR'.
 3. Under 3.4, against the above dataset enter RECEIVE INDA(/(SHOWLMOD))
    to receive the required load module.
    XMEMSTOR will need to be moved to an APF authorised library and
    program XMEMSTOR will need to be defined as an authorised program
    in 'SYSx.PARMLIB(IKJTSOnn)' to be able to use cross memory to access
    and/or change data in another address space.
    Alter member SH$PARMS to point to authorised dataset.
    (As a quick evaluation, copy into an APF auhorised datase and call
    it "IEBCOPY".)
 4. Under native TSO (READY prompt):
      EX 'userid.ALLIN1.SHOWSTOR(SHALLOC)'

 Uses and usage.
 ~~~~~~~~~~~~~~~
 1. Invoke using SHOWSTOR under option 6 or "TSO SHOWSTOR" in any ISPF
    panel.
 2. If wanting to look at another address space invoke using the "ASN"
    (Address Space Name) command. To use this facility successfully,
    you must fulfill all the APF requirements described above.
 3. Rather than cover usage instructions, there is a comprehensive set
    of help avaialble after invoking the application.
    For help use your PF1 key or alternatively enter "HELPSHOW" on the
    command line.  Note, that my normal "?" is not a valid help launcher
    as "?" is a valid SHOWSTOR command (change data).
 4. SHOWTOR uses the dynamic tutorial driver "HELPDRVR".
    Once in the tutorial enter "/TN" for tutorial navigation commands
    and/or "/QR" for tutorial quick ref.  ( Refer to HELPDRVR for it's
    packaging.)
 5. Load modules can be loaded into memory using the "SLM" REXX
    command and once it's memory storage is displayed, it can be
    disassembled on-line.
 6. SHOWSTOR can be invoked from an assembler or COBOL program to
    display program storage (and amend storage if required).  Handy for
    sites without XPEDITER or such.

