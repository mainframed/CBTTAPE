nawk for z/OS
=============
The source for nawk was initially downloaded from
ftp://ftp.pbone.net/mirror/download.fedora.redhat.com/pub/fedora/linux\
/releases/22/Everything/source/SRPMS/n/nawk-20121220-3.fc21.src.rpm
I processed it by doing:
    rpm2cpio <nawk-20121220-3.fc21.src.rpm | cpio -dium
This contained the file awk.tar.gz, which I unwound and then deleted,
leaving only the source.
That was then make the initial commit.

The only real change was in the makefile to define the proper C compiler
executable and flags. The normal z/OS make command will work. I.e. this
distribution does not require any GNU utilities to implement.

In addition, I created the awk.1.cat file on Linux because the awk.1 file
is in a markup form which is unusable on z/OS. The command to do so was:
    groff -T ascii awk.1 >awk.1.cat

