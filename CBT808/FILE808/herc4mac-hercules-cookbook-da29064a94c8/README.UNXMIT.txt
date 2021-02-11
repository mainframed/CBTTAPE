what is supported ... ( unxmit.rex)
FB/VB
PS/PO/POE
ISPF packed files
*** note *** *** note *** *** note *** *** note *** *** note *** *** note ***
packing algorithm was reverse engeneered by packing a few different files
FB 80
FB 600
VB 1024
( and packing an IDTF XMI )

if somebody who knows is willing to share the full logic behind it
he will be most welcomed!
*** **** *** *** **** *** *** **** *** *** **** *** *** **** *** *** **** ***


*** note *** *** note *** *** note *** *** note *** *** note *** *** note ***
the codepages used were CP01047 for EBCDIC and
CP00367 for ASCII ( the plain ASCII printable )
*** **** *** *** **** *** *** **** *** *** **** *** *** **** *** *** **** ***

handling of <non> text files
THE SCRIPT WILL RECOGNIZE AND HANDLE CORRECTLY ALSO ISPF PACKED FILE TYPES
a ISPF packed IDTF thing will not be corrupted
( if somebody will provide an IDTF file with different file types I will be glad to test )

an attempt is made to determine the file <type> and save it
using the proper file extemsion
IDTF files          .xmi
PDF documents       .pdf
<Word> documents    .doc
<zipped> files      .zip
s370 object decks   .obj
DBRM.               .dbrm

a file with non printable chars int the first idtf data buffer
will be processed with no translation and file type .bin

currently supported options are ...

unxmit --info           will display the IDTF control records
[enrico@enrico-mbp xmitools]$unxmit --info testpds

unxmit   - Started : 15:46:19
unxmit   - 'info' specified, all other options will be ignored

unxmit   - Input   : testpds.xmi
unxmit   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
unxmit   - INMR01 1 76
unxmit   - INMR01.1.INMFACK     =
unxmit   - INMR01.1.INMNUMF     = 1
unxmit   - INMR01.1.INMTUID     = B
unxmit   - INMR01.1.INMFUID     = DAVE
unxmit   - INMR01.1.INMFTIME    = 20040309032825
unxmit   - INMR01.1.INMTNODE    = A
unxmit   - INMR01.1.INMLRECL    = 80
unxmit   - INMR01.1.INMFNODE    = NODENAME
unxmit   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
unxmit   - INMR02 1 96
unxmit   - INMR02.1.INMDIR      = 6
unxmit   - INMR02.1.INMSIZE     = 58786
unxmit   - INMR02.1.INMDSNAM    = DAVE.TEST.PDS
unxmit   - INMR02.1.INMBLKSZ    = 8800
unxmit   - INMR02.1.INMRECFM    = 9000
unxmit   - INMR02.1.INMUTILN    = IEBCOPY
unxmit   - INMR02.1.INMLRECL    = 80
unxmit   - INMR02.1.INMDSORG    = 0200
unxmit   - INMR02.1.INMTYPE     = 00
unxmit   - INMR02.1.INMFSEQ     = 1
unxmit   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
unxmit   - INMR02 2 59
unxmit   - INMR02.2.INMSIZE     = 58786
unxmit   - INMR02.2.INMFSEQ     = 1
unxmit   - INMR02.2.INMBLKSZ    = 3120
unxmit   - INMR02.2.INMRECFM    = 4802
unxmit   - INMR02.2.INMUTILN    = INMCOPY
unxmit   - INMR02.2.INMLRECL    = 32756
unxmit   - INMR02.2.INMDSORG    = 4000
unxmit   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
unxmit   - INMR03 1 34
unxmit   - INMR03.1.INMDSORG    = 4000
unxmit   - INMR03.1.INMRECFM    = 0001
unxmit   - INMR03.1.INMLRECL    = 80
unxmit   - INMR03.1.INMSIZE     = 58786
unxmit   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
unxmit   - INMR06
unxmit   - buffers : 10
unxmit   - dirmems : 0
unxmit   - members : 0

unxmit   - Ended   : 15:46:19 Elapsed : 0
[enrico@enrico-mbp xmitools]$

unxmit --dump/--vdump   will produce an UP/DOWN hex dump of the input file
[enrico@enrico-mbp xmitools]$unxmit --dump testpds

unxmit   - Started : 15:48:32
unxmit   - '.dump' specified, all other options will be ignored

unxmit   - Input   : testpds.xmi
unxmit   -                >>12345678901234567890123456789012345678901234567890123456789012345678901234567890<<
unxmit   -      1       1 >>\INMR01......&......NODENAME......DAVE......A......B......20040309032825........<<
unxmit   -                >>ECDDDFF0400005110000DDCCDCDC110000CCEC100000C100000C120000FFFFFFFFFFFFFF12000001<<
unxmit   -                >>095490102010100101085645514502010441550101011020101204010E200403090328250F010110<<

unxmit   -      1      81 >>...<<
unxmit   -                >>200<<
unxmit   -                >>600<<

unxmit   -                >>12345678901234567890123456789012345678901234567890123456789012345678901234567890<<
unxmit   -      2       1 >>\INMR02..........IEBCOPY........Vs........................&.........-...........<<
unxmit   -                >>ECDDDFF0000120000CCCCDDE12000000EA0300000081000000400000005030000002604000090000<<
unxmit   -                >>0954902000108010795236780C010400520C010220020101002010400000001040020090102000C0<<

unxmit   -      2      81 >>............DAVE..TEST..PDS<<
unxmit   -                >>000000000000CCEC00ECEE00DCE<<
unxmit   -                >>103006020304415504352303742<<

unxmit   -                >>12345678901234567890123456789012345678901234567890123456789012345678901234567890<<
unxmit   -      3       1 >>\INMR02..........INMCOPY........Vs...... ........."4..................<<
unxmit   -                >>ECDDDFF0000120000CDDCDDE12000000EA03000040040000007F030000000304000040<<
unxmit   -                >>0954902000108010795436780C010400520C01020002010400F400010400C009010282<<

unxmit   -                >>12345678901234567890123456789012345678901234567890123456789012345678901234567890<<
unxmit   -      4       1 >>\INMR03........Vs...... ........&........<<
unxmit   -                >>ECDDDFF12000000EA030000400400000504000000<<
unxmit   -                >>09549030C010400520C0102000201020009010201<<

unxmit   -                >>12345678901234567890123456789012345678901234567890123456789012345678901234567890<<
unxmit   -      5       1 >>{.._....-.&............"8....Vs...&.....«............J...<<
unxmit   -                >>C0C600026059000033320007F0000EA0025000006040008000000DF00<<
unxmit   -                >>00ADF2020000000C0000F00F8DC0F5200200002080400000010061A00<<

unxmit   -                >>12345678901234567890123456789012345678901234567890123456789012345678901234567890<<
unxmit   -      6       1 >>..................3U............................................................<<
unxmit   -                >>80000F00080B008275FE0000B000B000000000000000000000000000000000000000000000000000<<
unxmit   -                >>01000F000F7004BD0834000320432040100000000000000000000000000000000000000000000000<<

unxmit   -      6      81 >>................................................................................<<
unxmit   -                >>00000000000000000000000000000000000000000000000000000000000000000000000000000000<<
unxmit   -                >>00000000000000000000000000000000000000000000000000000000000000000000000000000000<<

unxmit   -      6     161 >>................................................................................<<
unxmit   -                >>00000000000000000000000000000000000000000000000000000000000000000000000000000000<<
unxmit   -                >>00000000000000000000000000000000000000000000000000000000000000000000000000000000<<

unxmit   -      6     241 >>.....................................<<
unxmit   -                >>0000000000000000000000000000000000000<<
unxmit   -                >>0000000000000000000000000000000000000<<

unxmit   -                >>12345678901234567890123456789012345678901234567890123456789012345678901234567890<<
unxmit   -      7       1 >>......................¬AAAAAAAA........................DAVE      ZZZZZZZZ.......<<
unxmit   -                >>8000000000000FFFFFFFF06CCCCCCCC000000020008000822000000CCEC444444EEEEEEEE0000000<<
unxmit   -                >>0000000000810FFFFFFFF0211111111003F1004146F146F26020200415500000099999999005F100<<

unxmit   -      7      81 >>.................DAVE      .....................................................<<
unxmit   -                >>40008000822000000CCEC444444FFFFFFFF000000000000000000000000000000000000000000000<<
unxmit   -                >>4146F146F260202004155000000FFFFFFFF000000000000000000000000000000000000000000000<<

unxmit   -      7     161 >>................................................................................<<
unxmit   -                >>00000000000000000000000000000000000000000000000000000000000000000000000000000000<<
unxmit   -                >>00000000000000000000000000000000000000000000000000000000000000000000000000000000<<

unxmit   -      7     241 >>.................................................<<
unxmit   -                >>0000000000000000000000000000000000000000000000000<<
unxmit   -                >>0000000000000000000000000000000000000000000000000<<

unxmit   -                >>12345678901234567890123456789012345678901234567890123456789012345678901234567890<<
unxmit   -      8       1 >>{............THIS IS LINE 1 IN MEMBER AAAAAAAA                                  <<
unxmit   -                >>C00000B00000AECCE4CE4DCDC4F4CD4DCDCCD4CCCCCCCC4444444444444444444444444444444444<<
unxmit   -                >>00000320430003892092039550109504542590111111110000000000000000000000000000000000<<

unxmit   -      8      81 >>             THIS IS LINE 2 IN MEMBER AAAAAAAA (LAST LINE)                      <<
unxmit   -                >>4444444444444ECCE4CE4DCDC4F4CD4DCDCCD4CCCCCCCC44DCEE4DCDC54444444444444444444444<<
unxmit   -                >>00000000000003892092039550209504542590111111110D312303955D0000000000000000000000<<

unxmit   -      8     161 >>             ............<<
unxmit   -                >>444444444444400000B000000<<
unxmit   -                >>0000000000000000032044000<<

unxmit   -                >>12345678901234567890123456789012345678901234567890123456789012345678901234567890<<
unxmit   -      9       1 >>{............THIS IS LINE 1 IN MEMBER ZZZZZZZZ                                  <<
unxmit   -                >>C00000B00000AECCE4CE4DCDC4F4CD4DCDCCD4EEEEEEEE4444444444444444444444444444444444<<
unxmit   -                >>00000320450003892092039550109504542590999999990000000000000000000000000000000000<<

unxmit   -      9      81 >>             THIS IS LINE 2 IN MEMBER ZZZZZZZZ (LAST LINE)                      <<
unxmit   -                >>4444444444444ECCE4CE4DCDC4F4CD4DCDCCD4EEEEEEEE44DCEE4DCDC54444444444444444444444<<
unxmit   -                >>00000000000003892092039550209504542590999999990D312303955D0000000000000000000000<<

unxmit   -      9     161 >>             ............<<
unxmit   -                >>444444444444400000B000000<<
unxmit   -                >>0000000000000000032046000<<

unxmit   -                >>12345678901234567890123456789012345678901234567890123456789012345678901234567890<<
unxmit   -     10       1 >>\INMR06<<
unxmit   -                >>ECDDDFF<<
unxmit   -                >>0954906<<

unxmit   - buffers : 10
unxmit   - dirmems : 0
unxmit   - members : 0

unxmit   - Ended   : 15:48:32 Elapsed : 0
[enrico@enrico-mbp xmitools]$

unxmit --hdump          will produce a  <data>  hex dump of the input files
no reason to include a sample

unxmit --real           will use as <destination> directory the real dataset name
                        as stored in the INMR02 control record
[enrico@enrico-mbp xmitools]$unxmit --real testpds

unxmit   - Started : 15:44:24

unxmit   - Input   : testpds.xmi
unxmit   - aaaaaaaa  recds(       2) bytes(        78) file(dave.test.pds/aaaaaaaa.txt)
unxmit   - zzzzzzzz  recds(       2) bytes(        78) file(dave.test.pds/zzzzzzzz.txt)
unxmit   - buffers : 10
unxmit   - dirmems : 2
unxmit   - members : 2

unxmit   - Ended   : 15:44:24 Elapsed : 0
[enrico@enrico-mbp xmitools]$

as opposed to
[enrico@enrico-mbp xmitools]$unxmit testpds

unxmit   - Started : 15:44:36

unxmit   - Input   : testpds.xmi
unxmit   - aaaaaaaa  recds(       2) bytes(        78) file(testpds/aaaaaaaa.txt)
unxmit   - zzzzzzzz  recds(       2) bytes(        78) file(testpds/zzzzzzzz.txt)
unxmit   - buffers : 10
unxmit   - dirmems : 2
unxmit   - members : 2

unxmit   - Ended   : 15:44:36 Elapsed : 0
[enrico@enrico-mbp xmitools]$

unxmit --dest <somewhere>   will use as <destination> directory the somewhere thing
                            it will create if not there

[enrico@enrico-mbp xmitools]$unxmit --dest somewhereelse testpds

unxmit   - Started : 15:50:30

unxmit   - Input   : testpds.xmi
unxmit   - aaaaaaaa  recds(       2) bytes(        78) file(somewhereelse/aaaaaaaa.txt)
unxmit   - zzzzzzzz  recds(       2) bytes(        78) file(somewhereelse/zzzzzzzz.txt)
unxmit   - buffers : 10
unxmit   - dirmems : 2
unxmit   - members : 2

unxmit   - Ended   : 15:50:30 Elapsed : 0
[enrico@enrico-mbp xmitools]$


unxmit was tested on ALL the cbt files

the only problems encountered were with the files 852/853 and 872
where I was not able to determine the EBCDIC codepage used.


the EBCDIC ASCII translate table was generated using the CPtool.rex
script described in the README.CPTOOL.txt

the translate table was ( for brevity ) renamed to CP01047

P.S.

the whole copyright and license text display can be disabled by ...
.local~?cpyr.0 = 0

