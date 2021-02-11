
HERCULES VMS
suggested   directory structure for the hercules VMs

/Hercules.VMs       *** can be anything else
    xxxxxxxx        the system
        cntl
        conf
        dasd
        shad
        logs
        spool
        tapes
        utils
these are the paths that the _hercules scripts checks for existance

suggested naming convention for the dasd images

0300.r29r1a.3390.cckd
0a80.zares1.3390.ckd

for the shadow files
r29r1a_1.3390

the device address and the device type are important so that
the dasd configuration can be built by processing the dasd directory

example REXX configuration included
