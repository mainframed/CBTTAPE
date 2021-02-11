/*********************************************************************/
/* Welcome to CatLibs                                                */
/*********************************************************************/
The CATLIBS exec and the corresponding logon parmlibs will allocate the
necessary product libraries to your TSO session at logon time. The
parmlib members contain lists of DDNames and corresponding DSNs that are
required, one member for each product to be allocated.

It is set up to be very flexible and customizable by each individual
user. It does not require the user know anything about TSO or ISPF.
Maintenance of logon procs is greatly simplified and self documenting.
Once you gain an understanding of this allocation procedure, see the
$BENEFIT member for more information on why you might decide to use it.

Let's walk thru what CATLIBS does. This is going to sound WAY more
complicated than it is. Once you catch on, you will find it easy.
Here's a blow by blow account of the steps it goes through:

* Calls clist ISPFPROF, which must reside in the same library in which
  CATLIBS resides. It's function is to allocate an ISPF profile library.
  This is a required library and is equivalent to a cookie file in the
  web world, where it stores settings and variables across logons.

* Allocates a system logon parmlib and, if found, a user logon parmlib.
  If the user parmlib is found, it will override the members in the
  system parmlib. The various members in this parmlib will control what
  libraries are allocated to your logon.

* Reads in member $PRC2DRV (stands for 'Proc to Driver'). This member
  contains a list of logon proc names (as defined by your shop) and a
  corresponding 'driver' member, by convention starting with '@', such
  as @BASIC. This driver member will be used to pick which products to
  allocate to your logon. If your logon proc is not found in $PRC2DRV,
  the driver name defaults to @BASIC.

* Processes the driver member, which will have one of three
  possible commands on each line:
  > INCLUDE to include in a product parmlib member. This member will
    list the DDs and DSNs required for a specific product (see below).
  > MERGE to read in another driver member and merge it's contents
    with the current one. This allows you to 'nest' driver members
    so you can share their allocations and make maintenance easier.
  > STARTCMD to refer to a parmlib member that holds the ISPF startup
    command for your TSO session.
  Examples:
  > MERGE @BASIC to merge the current member with the @BASIC member.
  > INCLUDE PRODUCT1 to include a product parmlib member.
  > STARTCMD #BASIC to specify the ISPF start command member.
  Take a look at a couple of these members now to see what I mean.
  So the driver member @SPECIAL may look like this:
    | INCLUDE FILEAID        * include the fileaid product
    | MERGE @BASIC           * merge this driver with @BASIC
    | STARTCMD #SPECIAL      * the ISPF startup member

* Once all the driver members are processed, we will have a list of all
  include members merged in from all driver members. Each include
  statement refers to another member in the logon parmlib.
  Example merged listing:
    | INCLUDE PANVALET
    | INCLUDE CYFUSION
    | INCLUDE FILEAID
  etc.

* Reads in all the members to which the include commands refer.
  These members contain the DDNAME and DSN that the particular
  product requires.
  Example merged include member contents from above:
    | ISPLLIB 'SYSX.CAI.PAN.CAIISPL'     * from PANVALET
    | ISPMLIB 'SYSX.CAI.PAN.CAIISPM'     * from PANVALET
    | ISPPLIB 'SYSX.CAI.PAN.CAIISPP'     * from PANVALET
    | ISPMLIB 'SYSX.CYFUSION.MSGS'       * from CYFUSION
    | ISPPLIB 'SYSX.CYFUSION.PANELS'     * from CYFUSION
    | ISPTLIB 'SYSX.CYFUSION.TABLES'     * from CYFUSION
    | SYSEXEC 'SYSX.CYFUSION.EXECS'      * from CYFUSION
    | SYSEXEC 'SYSX.FILEAID.SYSEXEC'     * from FILEAID
  etc.
  Once each include member has been read in, we will have one large list
  of DDNAMEs and DSNs to be allocated, looking like the above example.

* Converts this long list of DDs and DSNs above into TSO
  allocate statements, which are then executed.
  Example of TSO commands converted from above example list:
    | ALLOC F(ISPLLIB) DA('SYSX.CAI.PAN.CAIISPL') SHR
    | ALLOC F(ISPMLIB) DA( -
    |    'SYSX.CAI.PAN.CAIISPM' -
    |    'SYSX.CYFUSION.MSGS' -
    |    ) SHR
    | ALLOC F(ISPPLIB) DA( -
    |    'SYSX.CAI.PAN.CAIISPP' -
    |    'SYSX.CYFUSION.PANELS' -
    |    ) SHR
    | ALLOC F(SYSEXEC) DA( -
    |    'SYSX.CYFUSION.EXECS' -
    |    'SYSX.FILEAID.SYSEXEC' -
    |    ) SHR
  etc.

* Lastly, reads the member specified by the *LAST* STARTCMD line in the
  merged drivers of the third step. The commands found in this member
  are executed. See member #SPECIAL to see an example. Normally this
  would be used to start ISPF, but any valid TSO command can be executed
  here, such as 'SDSF'. Also you can, for instance, place a LOGOFF
  command after the ISPF start command to achieve an automatic logoff
  when you exit ISPF.


To start using this, update your TSO logon proc to pass:
PARM='EX ''MA133.TSO.LOGON(CATLIBS)'''
in the TSO JCL. For example:
    | //TSOBASIC PROC
    | //TSOBASIC EXEC PGM=IKJEFT01,DYNAMNBR=256,
    | //         PARM='EX ''MA133.TSO.LOGON(CATLIBS)'''
    | //SYSLBC   DD DISP=SHR,DSN=SYS1.BRODCAST
    | //SYSPRINT DD TERM=TS,SYSOUT=*
    | //SYSTERM  DD TERM=TS,SYSOUT=*
    | //SYSIN    DD TERM=TS

You can also run the same command directly from the TSO READY prompt if
you want to test this.

See the CATLIBS exec for more details on parms you can pass to override
the default behavior of the exec.

/*********************************************************************/
/* More Excruciating Details                                         */
/*********************************************************************/
* See member #BASIC for more details on startup members.
* See member PRODUCT1  for more details on what else can be done with
  include members.
* See member USERFRST for more details on how to allocate your own
  libraries ahead of the standard libs (details in member $USE).
* See member USERLAST for more details on how to allocate your own
  libraries at the end of the standard libs.
* See member $USE in this library for examples on how to set up and
  use user parmlibs, as well as benefits and drawbacks of using this.
