
## $DOCREXW.txt
```
 The documentation for the REXXWAIT program is contained in the code.

 Lionel B. Dyck
 Systems Software Lead
 Kaiser Permanente Information Technology
 25 N. Via Monte Ave
 Walnut Creek, Ca 94598

 Phone:   (925) 926-5332
 Fax:     (925) 926-5292

 E-Mail:    Lionel.B.Dyck@kp.org

```

## $DOCSLEJ.txt
```
This is a TSO CLIST or REXX command to delay execution of whatever
was executing for a certain number of seconds.  E.G.

       SLEEP  5

means wait for 5 seconds.  A la the VM Command SLEEP.

This command was submitted to the CBT Tape by John Kalinich, and
was written by

    (c) Hans Joolen
        Delft University of Technology
        The Netherlands

```

## $DOCSLES.txt
```
REXX Function to wait for a specified time
------------------------------------------

1.0 Installation of SLEEP

    Supplied Material :
    README.TXT    -  This file
    SLEEP.TXT     -  Assembler source code for the SLEEP function

    (a) File transfer the SLEEP.TXT file to the mainframe host
        using ASCII-EBCDIC translation.

    (b) Assemble and link SLEEP into a load library that is
        available to your TSO userid. Use the following
        linkedit attributes :
           AMODE(31)
           RMODE(ANY)
           RENT
           REUS
           AC(0)

2.0 Using SLEEP

    The program will wait for a specified amount of seconds. The number
    of seconds to wait for is passed as a parameter to the function
    by the invoking REXX Exec. If no parameter is passed, a default of
    10 seconds is used. The maximum specification is 99999 seconds.

    Syntax :

        rcode = SLEEP(secs)

    Keywords :

        RCODE
          The return code from the SLEEP function. This can be one of
          the following values :
            0  - Successful execution of the function
           -1  - Error in the parameter passed. Verify that the
                 seconds passed is numeric and between 1 and 99999.

        SECS
          The number of seconds to wait for. This value can be between 1 and
          99999. If not specified, SLEEP will use a default value of 10.

    Example :

      rcode = SLEEP(60)  /* Wait for a minute */





Rob Scott
Scott Enterprise Consultancy Ltd

Website : www.secltd.co.uk
Email   : rob@secltd.co.uk
```

## $DOCSYSL.txt
```
Reply-To:     TSO REXX Discussion List <TSO-REXX@BITNIC.CREN.NET>
Sender:       TSO REXX Discussion List <TSO-REXX@BITNIC.CREN.NET>
From:         Roger Lacroix <roger.lacroix@CANREM.COM>
Organization: CRS Online  (Toronto, Ontario)
Subject:      SLEEP
To:           Multiple recipients of list TSO-REXX <TSO-REXX@BITNIC.CREN.NET>

HT>Sender: TSO REXX Discussion List <TSO-REXX@BITNIC.BITNET>
HT>From: Bill Harvey <HARVEY@WUVMD.BITNET>

HT>Is there any kind of SLEEP or WAIT command that can be executed from a
HT>REXX program to cause it to pause for a period of time?  I'm thinking
HT>of something like VM's CP SLEEP command...


I wrote an MVS TSO assembler routine to do the job (see below).
Compile and link the code below and you should be a happy camper <grin> .

Hope this helps
Roger...
```

## $DOCWAIT.txt
```
Please find attached a copy of our program. TSOWAIT


I hope it can be useful for other people and please feel free to change
it were required.


*
*
*
*
*	Met vriendelijke Groet/Mit freundliche Gruss/Kind regards

Wim Hondorp

Akzo Nobel Information Services
dept. OOC
P.o. Box 9300
6800 SB Arnhem
The Netherlands

Phone: ++31 - 26 3 66 4991
Fax: ++31 - 26 3 66 2929

E-mail: Wim.Hondorp@akzonobel.com

```

