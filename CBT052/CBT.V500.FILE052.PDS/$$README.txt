
 SHOWMVS  as ported to MVS38j

 Version: V38J.0000

 May 7, 2002 Jim Morrison
   n9gtm@comcast.net

Changes made to the original (very early) SHOWMVS code that
Gilbert Saint-Flour provided are mostly noted in changes.txt.
I've loved SHOWMVS since I first heard about it.  It's nice to
be able to do something for SHOWMVS, especially using the original
author's code.  SHOWMVS is available for more modern MVS-OS/390-z/OS
versions at the CBTtape site: http://www.cbttape.org

It is my understanding that Roland Shiradin is currently the keeper
of the SHOWMVS flame.  A hearty thanks to Gilbert, Roland, and everyone
else who's had their fingers in SHOWMVS over the ages.

Since SHOWMVS requires an assembler higher than ASMF, I acquired the
Dignus ... (wait for it) ... HOBBYIST LICENSE Systems/ASM product.
Very cool.  Eventually you'll be able to get info on the HOBBYIST
LICENSE at http://www.dignus.com but for now, just call them at
1-877-4DIGNUS.  Very reasonably priced, too.  BTW, they also offer
a Systems/C HOBBYIST LICENSE, which I plan to play with as soon as
I get a few other things out of the way (also very reasonably priced).

INSTALL NOTES

Linkedit the supplied object deck (or create your own by whatever
technique you wish).  I supply lkedshow.jcl, which also runs SHOWMVS
after it's linked.  You'll have to change the JCL a bit for such things
as SYSLMOD dataset name, and perhaps a few other things.

If you assemble it yourself, note that I supply a few macros.  You'll
need to load those somewhere and point the assembler SYSLIB ddname at
them.  The macros I supply are all named *.mac.  You'll also need
SYS1.AMACLIB and SYS1.AMODGEN in your SYSLIB concatenation.

Good luck, and enjoy SHOWMVS!

Jim


