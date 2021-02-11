TO:  Those interested in the REXX function to access VSAM files

I have created several files as part of this "package":
   RXVSAM.ASM is the actual function (assembler source code)
   RXVSDOC.TXT contains documentation
   RXVSET.CMD contains a "setup" exec to allocate 3 VSAM files and
        enable you to run the following 3 demo/sample execs:
   RXVTESTE.CMD using RXVSAM with an ESDS
   RXVTESTK.CMD using RXVSAM with a KSDS
   RXVTESTR.CMD using RXVSAM with an RRDS

Since not everyone can receive a binary file, I've not ZIPPED anything,
it's all straight ASCII text.

If you upload the sample REXX execs, be forwarned that some file
transfer utilities don't handle the vertical bar (concatenation
character in REXX) very well.  It usually gets translated as a square
bracket.  So you may need to manually edit them before running them.

The load library into which you assemble and link RXVSAM M-U-S-T be
"available" to your TSO session (as per the documentation).  This may
require an ISPLLIB allocation, if the library isn't one of the "system"
ones that are automatically available.

If you really want the documentation (5 big pages) printed in a spiffy
format, I can snail-mail it to you.  The postscript file is a little
large, and I'd rather not incur the communication charges in sending
it, even if you are able to receive a binary file.

For additional background, you might be interested in
   TSO/E:  Procedures Language MVS/REXX Reference  SC28-1883-4
(I have the 5th edition, August 1991, there may be a newer one).
Chapter 12 covers external functions in different languages.

Mark Winges 415-752-8291
WingNotes@earthlink.net

P.S.  If I've been cumbersome in my method of getting the files to you,
and you have any suggestions, please let me know.  I'm a little
reluctant to just throw all this stuff up on a server.  Thanks.

