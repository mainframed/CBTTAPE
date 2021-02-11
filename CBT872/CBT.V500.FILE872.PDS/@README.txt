This is a port to z/OS of the bzip2-library written by
Julian Seward <jseward§bzip.org>

I added a wrapper that can easily be called from COBOL.
By now it is used to compress a chunk if data is in memory and writes
it to DASD. The text in ZW-BZLIB-TEXT with length ZW-BZLIB-LENGTH
is compressed and written to DASD.

   05  ZW-BZLIB-RC                  PIC S9(008) BINARY.
   05  ZW-BZLIB-LENGTH              PIC S9(008) BINARY.
   05  ZW-BZLIB-TEXT                PIC  X(800000).
   05  ZW-BZLIB-FUNC                PIC S9(008) BINARY

   MOVE 'BZ2LIB' TO ZW-UPRO
   CALL ZW-UPRO USING ZW-BZLIB-FUNC
                      ZW-BZLIB-TEXT
                      ZW-BZLIB-LENGTH
                      ZW-BZLIB-RC

First call is with ZW-BZLIB-FUNC = 1 to initialize and open the
dataset at DD:BZOUT
SET ZW-BZLIB-FUNC = 2 to write as many chunks of data as you want.
SET ZW-BZLIB-FUNC = 3 to close the dataset.

Of course, the wrapper could be enhanced by adding a decompression-
call that the library also supports.

The decompression could also be done by e.g. a java program that uses
the class org.apache.tools.bzip2.CBZip2InputStream. Note that you
will have to read and discard the first two bytes ('BZ').
Look at: http://www.kohsuke.org/bzip2/

I have also included the full original tarball containing all the
stuff Julian has done. (bzip2-1.0.3_bin.tar.tgz aka BZIP2TGZ)

Please feel free to contact me: roland_scholz§web.de
