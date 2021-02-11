
      Job Scheduler Installation Manual
      ---------------------------------

      Following setup needs to be checked before running the  Job
      Scheduler Tool :

      1) Following members must be present in the panel dataset:
         XXXX.PANELS(FB:80)

          USERENTY
          DECNPNL
          THROTBL
          GENTAB
          RSRTPAN

      2) Following members must be present in the Rexx dataset:
         XXXX.REXX(FB:80)

          INITTOOL
          SCHDULER
          SCHTEST
          SHWHLP
          HELP
          README
          SDSFUPDT
          JOBLIST

      3) Following members must be present in the SKel dataset:
         XXXX.SKELS(FB:80)

          SCHDJCL
          SCHRSTRT
          Important : The JCLs provided with the skel library might
          *********   need changes depending on the installation.
                      ISRDDN can be used for finding out the
                      concatenations.

      4) Following table dataset must be present:
         XXXX.TABLES(FB:80)

      INITIALIZATION procedure
      ------------------------

      Edit the INITTOOL member with the dataset names for the TABLES,
      PANELS and JCL library.

      JCL changes to be done to use Scheduler
      ---------------------------------------

      A step has to be added to each jcl. This step will capture
      the return codes for all the previous steps or any ABEND in
      previous step. The step has to have COND=EVEN to intercept an
      ABEND.
      The following step needs to be added to each JCL as the last step.

     //ISPF    EXEC PGM=IKJEFT01,DYNAMNBR=1500,PARM='',COND=EVEN
     //SYSPROC  DD  DSN=hlq.TEST.REXX,DISP=SHR         ---------
     //SYSPRINT DD SYSOUT=*
     //SYSTSPRT DD SYSOUT=*
     //SYSOUT   DD SYSOUT=*
     //ISPFILE DD DUMMY
     //ISPLOG  DD SYSOUT=*,DCB=(RECFM=VA,LRECL=125,BLKSIZE=129)
     //SYSTSIN DD *
         ISPSTART CMD(%SDSFUPDT jobname ) NEWAPPL(BAT)
     /*                         -------
     //                            ¦
                                    --> Name of the job

      Executing the scheduler
      -----------------------
      Concat the rexx library to SYSPROC or SYSEXEC.
      Execute the member SCHDULER. This will show navigation panels,
      using which all functions such as creation and maintenance of
      master tables, Submitting the scheduler job or Submitting
      the Scheduler job with RESTART job can be done.

      For help regarding the Job entry to master tables, please refer
      the member HELP in rexx library.

      For any queries or bugs please mail to
          Ramahari@Chn.Cognizant.Com
          harirs@yahoo.com

