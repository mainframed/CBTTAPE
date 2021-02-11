 /* REXX caller to L_PGM             */
 /* CALLPGM(dsn,member,'N' or omit)  */
 Arg parm
 If "POS"('(',parm) > 0 Then
    Arg dsn '(' member ')' . ',' option
 Else
    Arg dsn ',' member ',' option
 /* For production use L_PGM,        */
 /* for testing changes use L_PGM:*/
 ret = L_PGM(dsn,member)
 /* ret = L_PGM(dsn,member)          */
 val = value(dsn)
 Parse Value val With . 53 p#vol 59 .
 /* Display $OPEN control block:     */
 /* Say 'Length='LENGTH(val)         */
 /* Say val                          */
 /* display variables                */
 /* Say 'L_PGM.rc='rc' result='result*/
 Say 'DSN    =' dsn
 Say 'Member =' member
 Say 'Option =' option
 If ret <> '1' Then EXIT
 Say 'Volume =' p#vol
 Parse Value ptab With 1 p#name 9 p#entry 13 p#size 17 . 18 p#ssi,
 21 p#flags 25 p#aname 33 p#aentry
 Parse Value c2x(p#ssi) With 1 p#ssi 6 .
 If p#ssi = '00000' Then p#ssi = '        '
 Else Do
    p#ssi = "DATE"('U',p#ssi,'J')
    End
 Parse Value c2x(p#flags) With 1 p#ac 3 p#at1 5 p#at2 7 p#ft2
 Parse Value x2b(p#at1) With 1 p#rent 2 p#reus 3 p#ovly,
    4 p#test 5 p#ol 6 p#sctr 7 p#exec 8 .
 Parse value x2b(p#at2) With . 5 p#ne 6 . 8 p#refr
 Parse Value x2b(p#ft2) With 1 p#alias 2 . 4 p#rmod 5 p#aamod 7 p#mamod
 If p#rmod Then p#rmod = 'ANY';Else p#rmod = '24'
 If p#mamod = '00' Then p#amod = '24';Else p#amod = '31'
 Say 'Name       Offset     Size Date/Mlt Type'
 p#entry = c2x(p#entry)
 If p#entry = '00000000' Then p#entry = '       0'
 Else p#entry = right(strip(p#entry,'l','0'),8,' ')
 p#size  = c2x(p#size)
 If p#size  = '00000000' Then p#size  = '       0'
 Else p#size = right(strip(p#size,'l','0'),8,' ')
 If p#alias Then Do
    If p#aamod = '00' Then p#amod = '24';Else p#amod = '31'
    Say p#aname p#aentry,
        p#size,
        'is alias of' p#name
    End
 p#attr = ''
 If p#rent Then p#attr = p#attr 'RENT'
 If p#reus Then p#attr = p#attr 'REUS'
 If p#refr Then p#attr = p#attr 'REFR'
 If p#ovly Then p#attr = p#attr 'OVLY'
 If p#test Then p#attr = p#attr 'TEST'
 If p#ol   Then p#attr = p#attr 'OL'
 If p#sctr Then p#attr = p#attr 'SCTR'
 /* If p#exec Then p#attr = p#attr 'EXEC' */
 If p#ne   Then p#attr = p#attr 'NE'
 If p#ac ='01' Then p#attr = p#attr 'AC=1'
 Say p#name p#entry,
    right(strip(p#size,'l','0'),8,' '),
    p#ssi 'A='p#amod,
    'R='p#rmod||p#attr
 ccomnt.00  = 'SD (Section Definition)'
 ccomnt.03  = 'LR (Label Reference)'
 ccomnt.04  = 'PC (Private Code)'
 ccomnt.05  = 'CB (Common Block)'
 ccomnt.01  = '?'
 ccomnt.02  = 'ER (External Reference)'
 ccomnt.06  = 'PR (Pseudo Register)'
 ccomnt.07  = 'NULL'
 ccomnt.0A = 'WER (Weak External Reference)'
 comnt.C  = 'Character'
 comnt.X  = 'Hexadecimal'
 comnt.B  = 'Binary'
 comnt.F  = 'Fixed Point Fullword'
 comnt.H  = 'Fixed Point Halfword'
 comnt.E  = 'Floating Point Fullword'
 comnt.D  = 'Floating Point Doubleword'
 comnt.A  = 'Address Fullword'
 comnt.Y  = 'Address Halfword'
 comnt.S  = 'Address Halfword'
 comnt.V  = 'External Address Fullword'
 comnt.P  = 'Packed Decimal'
 comnt.Z  = 'Packed Decimal'
 comnt.L  = 'Floating Point Doubleword'
 comnt.0  = 'Blank'
 comnt.1  = 'Csect start'
 comnt.2  = 'Fiction Section'
 comnt.3  = 'Common'
 comnt.4  = 'Machine Innstruction'
 comnt.5  = 'CCW'
 comnt.6  = 'Relocatable EQU'
 i = 1
 Say 'CSECTS:'
 Do WHILE("LEFT"(ctab.i,5) <> 'CTAB.')
    Parse Value ctab.i With 1 c#name 9 c#addr 13 c#size 17,
    c#type 18 c#ssi .
    c#type = C2X(c#type)
    If c#type = '00' Then Do
       Parse Value c2x(c#ssi) With 1 c#ssi 6 .
       If c#ssi = '00000' Then c#ssi = '        '
       Else Do
          c#ssi = "DATE"('U',c#ssi,'J')
          End
       End
    Else c#ssi = '        '
    c#addr = c2x(c#addr)
    If c#addr = '00000000' Then c#addr = '       0'
    Else c#addr = right(strip(c#addr,'l','0'),8,' ')
    c#size  = c2x(c#size)
    If c#size  = '00000000' Then c#size  = '       0'
    Else c#size = right(strip(c#size,'l','0'),8,' ')
    Say c#name c#addr c#size c#ssi ccomnt.c#type
    j = 1
    If option = 'N' Then Do
    Do WHILE("LEFT"(ctab.i.j,5) <> 'CTAB.')
       Parse Value ctab.i.j With 1 n#name 9 n#addr 13 n#size,
       17 n#type 18 n#dim
       n#addr = c2x(n#addr)
       If n#addr = '00000000' Then n#addr = '       0'
       Else n#addr = right(strip(n#addr,'l','0'),8,' ')
       n#size  = c2x(n#size)
       If n#size  = '00000000' Then n#size  = '       0'
       Else n#size = right(strip(n#size,'l','0'),8,' ')
       n#dim=c2x(n#dim)
       If n#dim   = '00000000' Then n#dim   = '       0'
       Else n#dim  = right(strip(n#dim ,'l','0'),8,' ')
       Say n#name n#addr n#size n#dim '  ' n#type,
       comnt.n#type
       j = j + 1
       End
       End
    i = i + 1
    End
 If option <> 'N' Then EXIT
 i = 1
 If "LEFT"(dtab.1,5) <> 'DTAB.' Then Do
    Say 'DSECTS: (Mlt for DSECT is the # of parent CSECT)'
    End
 ccomnt.00  = 'SD (DSECT Definition)'
 Do WHILE("LEFT"(dtab.i,5) <> 'DTAB.')
    Parse Value dtab.i With 1 c#name 9 c#addr 13 c#size 17,
    c#type 18 c#num
    c#type = C2X(c#type)
    c#addr = c2x(c#addr)
    If c#addr = '00000000' Then c#addr = '       0'
    Else c#addr = right(strip(c#addr,'l','0'),8,' ')
    c#size  = c2x(c#size)
    If c#size  = '00000000' Then c#size  = '       0'
    Else c#size = right(strip(c#size,'l','0'),8,' ')
    c#num   = c2x(c#num)
    If c#num   = '000000' Then c#num  = '       0'
    Else c#num  = right(strip(c#num ,'l','0'),8,' ')
    Say c#name c#addr c#size c#num ' ',
    ccomnt.c#type
    j = 1
    Do WHILE("LEFT"(dtab.i.j,5) <> 'DTAB.')
       Parse Value dtab.i.j With 1 n#name 9 n#addr 13 n#size,
       17 n#type 18 n#dim
       n#addr = c2x(n#addr)
       If n#addr = '00000000' Then n#addr = '       0'
       Else n#addr = right(strip(n#addr,'l','0'),8,' ')
       n#size  = c2x(n#size)
       If n#size  = '00000000' Then n#size  = '       0'
       Else n#size = right(strip(n#size,'l','0'),8,' ')
       n#dim=c2x(n#dim)
       If n#dim   = '00000000' Then n#dim   = '       0'
       Else n#dim  = right(strip(n#dim ,'l','0'),8,' ')
       Say n#name n#addr n#size n#dim '  ' n#type,
       comnt.n#type
       j = j + 1
       End
    i = i + 1
    End
 EXIT
