Preface:

This package contains three programs: RUNAUTH, HOSTCMD and SYSCMD.

        With the first program, authorized program can be called
        from un-authorized TSO environment, including CLIST or
        REXX script, where direct call caused system abend 047.
        The second program allows execute of host (CP or Hercules)
        command, passed as a paramerter, on z/OS or OS/390.
        Running both together, CP or Hercules commands can be
        entered from unauthorized TSO session without any system
        mods.  Third program SYSCMD allows execute of MVS system
        commands (MVS console commands) from the program, the
        same thing as provided by TSO CONSOLE service. This
        program also can be used together with RUNAUTH to allow
        to run MVS commands from unauthorized TSO session.

Installation:
        - Copy delivered program sources (runauth.asm, hostcmd.asm and
          syscmd.asm) to any source library;
        - Use delivered job skeletons (runauth.make, hostcmd.make and
          syscmd.make) to assembly and link-edit a load module. Update
          this job skeleton to provide valid JOB card, actual source
          library and desired load libarary - change SET statements at
          the beginning of job skeleton as required;
        - The HOSTCMD and SYSCMD load modules must reside on
          APF-authorized LNKLST library; The RUNAUTH load module can
          be placed in any library and not not need to be authorized;
        - Update IKJTSO00 on SYS1.PARMLIB or it's equivalent to add
          HOSTCMD and SYSCMD to list of commands authorized in TSO
          service facility (section AUTHTSF). Please use delivered
          IKJTSO00.parmlib as a reference.
        - Don't forget to refresh system after updating PARMLIB (with
          SET IKJTSO=xx and SETPROG; also refresh LLA with
          F LLA,REFRESH if necessary) or just re-ipl.

Usage:
        - To use HOSTCMD and SYSCMD from batch:
          // EXEC PGM=HOSTCMD,PARM='host_command'
          // EXEC PGM=SYSCMD,PARM='MVS_command'
          see also example jobs hostcmd.run, SYSCMD.run
        - To use HOSTCMD from TSO clist:
          CMD = 'host_command'
          PGM = 'HOSTCMD'
          address LINKMVS RUNAUTH 'PGM CMD'
          CMD = 'MVS_command'
          PGM = 'SYSCMD'
          address LINKMVS RUNAUTH 'PGM CMD'
          or to get a host command responce:
          CMD = 'host_command'
          PGM = 'HOSTCMD'
          RESPONCE = COPIES('00'x, 4096)
          address LINKMVS RUNAUTH 'PGM CMD RESPONCE'
          See also example REXX script runauth.clist and job
          runauth.run.

Author:
         Gregory Bliznets gbliznets@iba.by
         RUNAUTH based on idea and code described in the article
         "Removing user-written authorization SVC" written by Adrian
         Cole, see http://www.xephon.com/arcframe/m072a06

Changes:
         02.08.2006 HOSTCMD updated to avoid abend 171 due to PGFIX
                    error.
         04.08.2006 SYSCMD is added to the package, all descriptions
                    corrected.
         05.08.2006 HOSTCMD updated to set DIAG properly; Now DIAG
                    responce available.
