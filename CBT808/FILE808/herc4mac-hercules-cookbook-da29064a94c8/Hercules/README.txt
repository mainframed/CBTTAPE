GNU TOOLCHAIN <===
tested on SNOW Leopard, Lion, Mountain Lion

suggested directory structure

/gnu                        the gnu toolchain ++
    ...                     as
    ...                         per
    ...                             make
    ...                                 install
    src                     the sources
                            * in installation sequence )
        gnupg-1.4.13        * to check the signatures
        xz-5.0.4            * to download smaller distributables
        m4-1.4.16           * to avoid a warning when installing autoconf
        autoconf-2.69       * mandatory to install it before automake
        automake-1.13.1
        ...                 as many
        ...
        ...                         as needed/considered

here is my list
autoconf-2.69.tar.xz
automake-1.13.1.tar.xz
diffutils-3.2.tar.xz
enscript-1.6.6.tar.gz
gawk-4.0.2.tar.xz
gnupg-1.4.13.tar.bz2
grep-2.14.tar.xz
indent-2.2.10.tar.gz
libtool-2.4.2.tar.xz
m4-1.4.16.tar.xz
make-3.82.tar.gz
nano-2.3.1.tar.gz
sed-4.2.2.tar.bz2
tar-1.26.tar.xz
wget-1.14.tar.xz
xz-5.0.4.tar.gz


HERCULES ITSELF

/Hercules           the hercules home

    xxxxxxxx.src    the sources ( full git repository )

    xxxxxxxx        the binaries
        ...         as
        ...             per
        ...                 make
        ...                     install


built with          cd /Hercules/xxxxxxxx.src
                    ./configure --disable-nls --prefix=/Hercules/xxxxxxxx
                    make
                    make install
                    cd /Hercules/stg/bin
                    sudo chown root:wheel hercifc
                    sudo chmod +s hercifc


the binaries have been build on a core2, and have been tested also on an i7


to use networking   install tuntap from
                    http://tuntaposx.sourceforge.net

and remember to...  cd /dev
                    sudo chmod 777 tun*
                    in this way no need for hercules to run as sudo
                    ( the current implementation fo apple is buggy,
                      I will let You know when the fix is complete )

let me know if You plan to use REXX , better ooRexx than regina

to build hercules ...
                    cd /gnu/bin
                    . path.here <== it will prepend the `pwd` to Your path

to run hercules ...
                    cd /Hercules/stg/bin
                    . path.here <== it will prepend the `pwd` to Your path

the _hercules script does that for You, just use
                    _hercules -v stg

no real documentation yet I am working on it


find also in this same directory

_bash_profile       to be merged into Your .bash_profile
_gnu-conf           the script to install the GNU stuff
path.here           to prepend to the PATH the current directory
_hercules           to invoke Hercules according to my structure



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
