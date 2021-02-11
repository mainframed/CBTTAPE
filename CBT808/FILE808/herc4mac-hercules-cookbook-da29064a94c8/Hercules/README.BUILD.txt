the latest flavor of XCODE has dropped some components of the autotools chain

the only one really needed are autoconf and automake ,
but I preferred to have a consistent GNU tools chain,

suggested directory structure

for the GNU toolchain

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


for HERCULES ITSELF

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
                    cd /Hercules/xxxxxxxx/bin
                    sudo chown root:wheel hercifc
                    sudo chmod +s hercifc


this setup makes easy to run with different Hercules builds
