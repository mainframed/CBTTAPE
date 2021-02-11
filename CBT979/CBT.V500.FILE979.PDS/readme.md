
## $$README.txt
```
           Instructions for using the Practice ZZSA package

Introduction:

The purpose of this file is to provide an environment where you can
practice using the ZZSA standalone recovery tool.

ZZSA is a recovery tool that was written by Jan Jaeger, and has nothing
to do with IBM.  ZZSA, however, can be used to read IBM disk packs which
were formatted for use by MVS or z/OS.

ZZSA is IPL text.  That is, the IPL text of ZZSA is loaded onto a disk
pack, and the disk pack is IPL-ed, standalone.  Other disk packs may be
in the configuration that is IPL-ed, and ZZSA will find them, if you
run Option 0 first, as soon as you get into ZZSA.

What is here, in this file?

I have made a package consisting of a 5-cylinder data volume, formatted
as a 3390 disk, containing ipl-text to IPL ZZSA, and also containing
a text pds, to practice on, so you can become familiar with using the
ZZSA file editor, and with the other ZZSA functions.

I have added a load library as well, and a listing of the (unrelated)
program called NODSI, which lends itself to a simple zap, in order to
remove a restriction to its use.

The Packaging of this file.

The package is a zipped file, (pds member PRACZZSA) which unzips to
a directory on the PC.  For argument's sake, we shall call the
directory praczzsa (Practice using ZZSA).  The directory contains a
subdirectory which has a version of the Hercules emulator.  I am
calling this version of the emulator hyperion-40w.  It comes from
www.softdevlabs.com.

Detailed instructions on how to use ZZSA may be found at the URL:

    http://www.cbttape.org/~jjaeger/zzsa.html

    or see member $$$#ZZSA in this pds.

Now, to set up ZZSA on your PC using this package.

1.  UNZIP the zip file into a directory that we'll call C:\praczzsa
    If it is not the c: drive, make the appropriate adjustments
    to the accompanying .bat (batch) files in the directory.

2.  Go to a command prompt screen if you are using Windows.

3.  cd to the directory, and run the zzsa.bat batch file.  Edit it
    to point to the proper disk if necessary.  An original copy of
    the IPL disk for zzsa is shipped with the package.  Its name is
    cyl005O.  With the first execution of the zzsa.bat file, this
    pack is copied over to the working pack, whose name is cyl005.
    In addition, a backup pack cyl005B is created with the first
    execution of zzsa.bat.  Upon subsequent execution of zzsa.bat,
    you have a choice if you want to use the pack cyl005B from last
    time, or you can overlay your working pack cyl005 with the
    original pack, cyl005O.  For example, if you clipped the cyl005
    pack so it has a different id, you might want to overlay it with
    the original pack that was shipped with this file, so you can
    start over.

4.  Set up your 3270 emulator to IP address 127.0.0.1, port 3270   The
    terminal should grab the Hyperion (aka Hercules) main screen.

5.  On the command prompt screen, which now has become a Hercules terminal,
    enter:   IPL a40

6.  Go to the Hyperion (Hercules) screen (the 3270 emulator) and enter
    ESC or PA1 to generate an interrupt. The ZZSA entry screen should
    now appear.   ZZSECRET is the password.  Enter it and PRESS ENTER.

7.  Always enter Option 0 first.  This enables ZZSA to find out which
    peripheral devices are connected to it.  Then you can try all the
    other options out.  See the detailed instructions at the
    following URL:

    http://www.cbttape.org/~jjaeger/zzsa.html

    Or see member $$$#ZZSA in this pds.

8.  After you have exited ZZSA with the X option, you can get out of
    Hercules (Hyperion) by entering quit in the command prompt screen,
    which had become the Hercules console.  It is now no longer the
    Hercules console, and it has now become a Windows Command screen,
    again.  Follow the additional prompts to make a backup of your
    cyl005 disk (cyl005B).

Good Luck......


```

