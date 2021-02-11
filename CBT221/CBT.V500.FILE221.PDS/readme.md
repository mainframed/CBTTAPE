
## $$$DOC01.txt
```
This file (221) goes together with File 220 from Lee Conyers.

This file (221) contains REXX execs to perform many EDP auditing
"snooping" functions.  This material will be useful for systems
programmers as well.  The material was tested on an MVS/XA 2.2.3
system.  Some of it also runs on MVS/ESA 4.3, but not all of it.

If you can fix any of this material for higher versions of the MVS
operating system, please submit your material to Sam Golob, at his
address as listed on File 001 of this tape.

      Lee Conyers
      U.S. Department of Transportation
      700 4th Street SW
      Room 7404, M-35
      Washington, DC  20590
      (202) 366-1126

```

## $$$DOC02.txt
```
Subject:  RE: CBT contribution
From:     "Cieri, Anthony" <ACieri@seic.com>
Date:     2/18/2014 4:39 PM
To:       Sam Golob <sbgolob@cbttape.org>

Hi Sam,

Sorry that it took a while, but I have finally documented my
updates and changes to CBT file221. The execs in file 221 work in
conjunction with programs and SAS code in file 220. This was a
nice little history lesson in the evolution from MVS XA 2.2 to
z/OS V1.13.

I have added two members ($$MODS and $$WORKDS) to the PDS that,
hopefully describe the change that I made in order to get these
execs to run under z/OS 1.13. I started by updating only those
that were necessary to run the associated SAS jobs in file 220.
As of this email, I have updated most , but NOT all of them.

Please find the modified PDS attached to this email in TSO IDTF
(XMIT) format!!!

Please let me know if you have any questions or require any
additional documentation.

Thanks
Tony

Anthony J.Cieri
SEI Investments
1 Freedom Valley Drive
Oaks, PA 19456

(P) 610.676.4088
(F) 484.676.4088
Email: acieri@seic.com
       Anthony.Cieri4@gmail.com

```

