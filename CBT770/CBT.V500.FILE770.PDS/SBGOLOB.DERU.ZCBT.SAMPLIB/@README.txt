zCBT SAMPLIB
============

This SAMPLIB contains 6 members:

  ZCBT
  JCBTEST1
  JCBTEST2
  IEALPA00
  IEFSSN00
  CBTIPL


1. ZCBT Member
--------------

ZCBT is a procedure to initialize zCBT subsystem.  It must be in your
current system PROCLIB (e.g. SYS1.PROCLIB).  Before you can use zCBT
supported rexx functions, zCBT subsystem must already be initialized
and activated.  This procedure is one of the ways to do.   Customize
this procedure to meet your environment before you can use.   At the
first time you install zCBT, start this procedure to initialize zCBT
with the following command:

     START ZCBT,SUB=MSTR,SSN=subsystemname

Unless you setup IEFSSNxx and IEALPAxx members of PARMLIB for zCBT
subsystem to initialize automatically each IPL, you have to start
ZCBT once each IPL period.


2. JCBTEST1 and JCBTEST2 Members
--------------------------------

These are 2 jobs to run zCBT installation verification procedures.  Job
JCBTEST1 is an STC and must be placed in your current PROCLIB to execute
rexx program CBTIVP in REXXLIB and can be renamed to any name.   Whereas
job JCBTEST2 is a batch job to run rexx programs CBTIVP1 and CBTIVP2 in
REXXLIB and must exactly use jobname of JCBTEST2.  Both jobs must be
customized to meet your environment.

To verify zCBT installation, once ZCBT subsystem is initialized (by mean
starting ZCBT, then start JCBTEST1.  Then you submit JCBTEST2.  JCBTEST1
is terminated following JCBTEST2 termination.


3. IEALPA00 and IEFSSN00 Members
--------------------------------

IEALPA00 and IEFSSN00 are sample of PARMLIB parameters you must prepare
if you need zCBT to manage system startup procedure.  In this case, zCBT
must be ready earlier than other application tasks.  zCBT subsystem must
be initialized during NIP.  Therefore, zCBT EMS modules must be already
loaded on LPA.

IEALPA00 is to ask z/OS to load all zCBT EMS modules onto modifiable LPA
(EMLPA) during NIP period.   You must correct the library name to meet
the true name of your zCBT LOADLIB dataset.  However, you may not change
the modules names.  You can either use this sample as a separate PARMLIB
member by pointing it with MLPA=xx in your current IEASYSxx, or merge it
into the existing IEALPAxx member.

IEFSSN00 is to ask z/OS to define subsystem name for zCBT and execute
the initialization routine CBTEMSSS.  You can change the subsystem name
to any valid subsystem name, or just leave this given name (CBT).  You,
however, must not change the initialization routine name.  The name must
be CBTEMSSS.  When you implement this SSN sample, you must already setup
the above IEALPA00 sample.  z/OS will search CBTEMSSS module in the LPA.
You can either use this sample as a separate PARMLIB member by pointing
it with SSN=xx in your current IEASYSxx, or merge it into the existing
IEFSSNxx member.


4. CBTIPL Member
----------------

CBTIPL is a sample of system startup procedure.  It executes CBTIPL rexx
program in REXXLIB dataset, which starts JES2 and other independent jobs
at the first stage.  Next stage, it starts other jobs which depends on
JES2, including VTAM.  The final stage, starts other jobs which depends
on VTAM.

When you plan to use this sample, you must customize it to meet to your
environment requirements.  You must also properly prepared IEALPA00 and
IEFSSN00 samples

If you plan to use CBTIPL for system startup, do the following steps:

 (1)  Customize both IEALPA00 and IEFSSN00 samples and make sure both
      are properly effective when you IPL the system.  This means, ZCBT
      is automatically started during NIP.  See syslog.

 (2)  Customize CBTIPL rexx program in REXXLIB dataset (PDS) to meet
      you environments:

        a.  Adopt all your current COMMNDxx content to CBTIPL by
            converting each COM='bla bla bla' in COMMNDxx becomes
            x = cbcmd('bla bla bla') in CBTIPL.

        b.  Put COM='START CBTIPL,SUB=MSTR' as the only content of
            your current COMMNDxx.
