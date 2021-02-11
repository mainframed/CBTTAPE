BASH 4.2 for z/OS
=================
port by John A. McKown
----------------------
mailto:john.archie.mckown@gmail.com

This is my attempt to port the GNU BASH shell, release 4.2 to z/OS. The
source was obtained by doing a

git clone git://git.savannah.gnu.org/bash.git

on a Linux/Intel system. Curiously, the BASH developers did not use a
git branch to separate the releases.  In order to do a fork from the 4.2
position, I did:

git branch bash-4.2-zos bash-4.2
git checkout bash-4.2-zos

At the time that I did the above, this forked the new branch from commit
495aee441b75276e38c75694ccb455bb6463fdb9

All changes were made in the bash-4.2-zos branch. The simple way to see
what the changes are is to do the command:
git diff bash-4.2 bash-4.2-zos

The file dist.pax.Z was created after a successful configure, make, and
make install on z/OS 2.1. It contains only the files needed to run BASH.
It does not include any source.

Required ./configure parameters
-------------------------------
The following options were used to address one or more problems that I
ran into doing the BASH port. Someone who is smarter than I might be
able to figure out how to get around them.
* --without-bash-malloc was required because without it bash never
  worked. It got out-of-memory errors during initialization.
* --disable-mem-scramble Not really required due to the above, but I
  don't think that z/OS has the same exploitation problems as other
  architectures. I could well be wrong.
* --prefix= is set to a non-GNU subdirectory in my bash source
  subdirectory. This simply made it easier for me to do a "make install"
  and be able to use pax to bundle the results into a single pax archive
  file.

Manual changes after ./configure
--------------------------------
* None at present

Source code availability
------------------------
BASH is licensed under the GPL. This requires that, if distributed, all changes
to the source must be available.  This release of BASH is normally distributed
via the http://cbttape.org site.  There are two different downloads available.
One is with the full source.  The other is only with the files needed to actual
run BASH.  The file you are reading is the one in the PDS containing the pax
archive of the entire UNIX subdirectory containing BASH, so you have all
the source, which satisfies the GPL requirements.  The sour also        ce is
available at https://github.com/JohnArchieMckown/bash and can most be   easily
downloaded by doing the command:

git clone git@github.com:JohnArchieMckown/bash.git

However, it can also be downloaded from your browser in "zip" format
from the web site. The source on github is in ASCII, not EBCDIC! And it
uses UNIX LF line endings, not Windows CRLF line endings.  It is your
responsibility to do the ASCII to EBCDIC translation as well as changing
the line endings if you use Windows. I am not a Windows power user, so I
don't really know how to do all of this. Using Linux, the simpliest
thing to do is:

1. Go to the web site above
2. Make sure that you are on the branch "bash-4.2-zos" and
   not the default of JohnArchieMcKown (an error on my part)
3. Download the zip file into an empty subdirectory (cd ~/emptydir)
4. unzip bash-bash-4.2-zos.zip
5. This creates the directory bash-bash-4.2-zos under ~/emptydir (example)
6. tar cf bash-4.2-zos.tar bash-bash-4.2-zos
7. use ftp to do a BINary upload to a z/OS UNIX subdirectory
8. Use pax to unwind the tar file and translate to IBM-1047 via:
   pax -ofrom=ISO8859-1,to=IBM-1047 -rf bash-4.2-zos.tar

As an alternative to the above, if you have Java installed on z/OS, you
should be able to do something like:
1. create an empty directory as in: mkdir ~/emptydir
2. ftp the zip file into this directory, using BINary mode
3. Use the jar command to "unzip" the zip file.
   jar xf bash-bash-4.2-zos.zip
   This creates the bash-bash-4.2-zos subdirectory.
4. create another subdirectory in ~/emptydir, perhaps like:
   mkdir bash-4.2-zos
5. Use pax to copy and translate as in:
   pax -ofrom=ISO8859-1,to=IBM-1047 -rw bash-bash-4.2-zos bash-4.2-zos
6. cd bash-4.2-zos/bash-bash-4.2-zos
7. mv * ..
8. cd ..
9. rm bash-bash-4.2-zos
   I don't know why pax insists on the weird move, but it does. So I simply
   move everything up, then remove the extra subdirectory
10. At this time, in ~/emptydir (example), there is the bash-bash-4.2-zos and
    the bash-4.2-zos subdirectories. The former has the ASCII. The latter has
    the EBCDIC. You can remove the former with the command:
    rm -rf bash-bash-4.2-zos

z/OS UNIX post install customizations
-------------------------------------

First off, in order to enable BASH line editing to be equivalent to what is
normal in many Linux environments, it is necessary to copy the "initrc" file
which is in the dist/bin subdirectory to the /etc subdirectory. If you don't
have the ability to do this, you can copy it into the "~/.inputrc" file. That is
you need to copy it into your home directory, and name it ".inputrc" instead of
"inputrc".  This is not really necessary, it simply puts in more key mappings
for more keys on the PC when you are using some of the common Linux terminal
emulators such as "xterm".

If you want BASH to be your normal shell and your z/OS security administrator
does not want to update your UNIX profile, then you can do this rather easily by
updating the .profile start up script in your home directory, that is
"~/.profile". Do _not_ start this file with the normal "magic" first line of
#!/bin/sh Instead use something like:  set | fgrep -q BASH_ || exec -a
-bash /usr/local/bin/bash You must change the "/usr/local/bin" to the
actual directory which conta bash executable.
                                                                        ins the

One problem which does not have a simple solution is that most people are used
to starting all of their shell scripts with the "magic" line in the previous
paragraph.  Unfortunately, this _will_ cause BASH to invoke the normal z/OS
/bin/sh program, thus running the script using it instead of BASH.  I cannot
think of a simple way around this.

Known differences / problems / cautions
---------------------------------------
1. For some reason, when an array is accessed with a subscript of either
   "@" or "*", the order of the entries is not necessarily the same as
   they were in the tests. They are all output, but not in the same
   order. The BASH info text does not, in itself, specify the order of
   output as best as I can tell.

2. There may be differences in the characters output from some functions
   due to the differences in the collating sequences in EBCDIC versus
   ASCII. One immediate difference is that in ASCII, numbers are
   collated _before_ letters, whereas in EBCDIC, they come after.

3. You need to keep in mind that many shell scripts start with the line:
   #!/bin/sh
   This is because /bin/sh is a symlink to BASH. However, this is _not_
   true in z/OS. This means that any shell script which starts with that
   line will be run in the normal /bin/sh UNIX shell command processor
   and _NOT_ in BASH. Assuming that BASH is on your PATH, you can avoid
   this by replacing the above line with one similar to:
   #!/bin/env bash

4. Another thing to look at is the IBM supplied /etc/profile file. This
   file is "sourced" by both /bin/sh and BASH when they are the "login
   shell". In this file is a reference to the $SHELL environment variable.
   As best as I can tell, this is set to the value specified in the user's
   OMVS segment. Although I have not encountered it, the usage in
   /etc/profile _might_, under some circumstances, cause BASH initialization
   to reinvoke the /bin/sh program as the shell. In particular, if the
   STEPLIB environment variable is unset and the OMVS segment has /bin/sh
   as the shell program, the distributed /etc/profile will reinvoke /bin/sh
   with STEPLIB set to "none". Review this and change as needed.
