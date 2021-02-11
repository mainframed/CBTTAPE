Hi

This function package was originally DRXMATFN which is for VM/CMS.
No enhancement yet, except just to make it run on OS/390 or z/OS.
Hence, legacy HFP is still used which is low precision and
accuracy, since the last touch was in 1993 on VM/ESA on ESA/370
machine.  Next plan is to convert it to BFP once I have enough
time.

This package can be used as a supplement to your rexx to provide
several math functions such as sin(), cos(), tan() etc.   Hence,
your rexx will look like PL/1. Without such package, rexx doesn't
support any math functions.   However, it just for availability.
There is no guarantee for the performance, since all rexx
variables are internally presented as text string.

This zip file consist of 2 XMI files:
DRXMATH.SRC.XMI - Source library
DRXMATH.LNK.XMI - Pre-generated load library

Follow the explanation below to install this package into your OS/390
system.


Regards,
_____________
Deru Sudibyo
email:  "Deru Sudibyo" <deru.sudibyo@gmail.com>


Pre-generated Load Library
==========================

Original dsname is NIT.CBT.SRCLIB.  Please rename according to your
naming standard.  Since it was generated on OS/390 2.7, it should be
okay to be directly used on any OS/390 level of V2R7 or above.
If you choose this way, you don't need to complete installation steps.
All you have to do are:

(1) Upload this pre-generated loadlib to your OS/390 (binary mode).
(2) Do TSO RECEIVE to restore the original loadlib.
(3) Rename loadlib according to your naming standard.
(4) Put its dataset name into your current LNKLST.
(5) Re-activate your current LNKLST.
(6) Do some necessary test using your own rexx program




Source Library
==============

Original dsname is NIT.CBT.SRCLIB.  Please rename according to your
naming standard.   Using this source library, you can do complete
installation your self.   Upload this as follow:

(1) Upload this source loadlib to your OS/390 (binary mode).
(2) Do TSO RECEIVE to restore the original loadlib.
(3) Rename loadlib according to your naming standard.
(4) Check the following detail...

Member List
===========
  DRXFLOC  : Sourcecode of package & package directory
  DRXMATH  : Sourcecode of package only module
  @RXCSECT : Local macro
  @RXENTRY : Local macro
  @RXEXIT  : Local macro
  @RXFDIR  : Local macro
  DRXFUNC  : Local macro
  ASSEMBLE : Assembling & linkeditor procedure
  JDRXFLOC : Job to generate the package
  JDRXTEST : Job for batch testing
  TTEST0   : Rexx program for testing
  TTEST1   : Rexx program for testing
  TTEST2   : Rexx program for testing
  TTEST3   : Rexx program for testing
  TTEST5   : Rexx program for testing
  TTEST6   : Rexx program for testing

Installation Instructions
=========================

A. Using Given Library - Everything in one library
--------------------------------------------------

  (1) Change LNKLIB name in JDRXFLOC job to your applicable loadlib
      Make sure your loadlib is concatenated in your active LNKLST.

  (2) Submit JDRXFLOC

  (3) If error is encountered, review JDRXFLOC report, and contact
      me (deru.sudibyo@gmail.com) if you think necessary.

  (4) Submit JDRXTEST to verify the installation.  Please review
      its report.


B. Using Optimum Library Configuration
--------------------------------------

  (1) Allocate a local source library if one doesn't exist

  (2) Allocate a local macro library if one doesn't exist

  (3) Copy DRXFLOC and DRXMATH from this library into your local
      sourcecode library

  (4) Copy all these local macros from this library into your
      local macro library

  (5) Copy ASSEMBLE procedure into your local PROCLIB

  (6) Copy JDRXFLOC and JDRXTEST into your local job library

  (7) Copy all TTESTn into your local SYSEXEC library

  (8) Customize JDRXFLOC and JDRXTEST to conform your library structure

  (9) Run/submit JDRXFLOC to generate function package module

  (10) If error is encountered, review JDRXFLOC report, and contact
       me (deru.sudibyo@gmail.com) if you think necessary.

  (11) Run/submit JDRXTEST to verify your installation.
       IVP can also be done interactively on TSO using all TTESTx rexx
       program, as long as concatenated into either SYSEXEC or SYSPROC.

----------------------------End-of-document----------------------------
