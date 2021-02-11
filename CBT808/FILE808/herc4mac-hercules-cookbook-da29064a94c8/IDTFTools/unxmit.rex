#!/usr/bin/rexx
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
/* Name : <filename>                                                               */
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
/* This work is     "Copyright (c) 2013-2013 Enrico Sorichetti"                    */
/* Licensed under a "Creative Commons Attribution-ShareAlike 3.0 Unported License" */
/* Human readable   "http://creativecommons.org/licenses/by-sa/3.0/deed.en_US"     */
/* Legalese         "http://creativecommons.org/licenses/by-sa/3.0/legalcode"      */
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

Trace "O"
signal on novalue name novalue
numeric digits 12

parse source _src
parse lower var _src _sys _env _cmd .

if  pos("windows", lower(_sys)) > 0 then ,
    .local~psep = "\"
else ,
    .local~psep = "/"

z = filespec("n", _cmd)
parse var z .local~self "." .

.local~cpyr.0 = 0
.local~cpyr.1 = 'This work is     "Copyright (c) 2013-2013 Enrico Sorichetti"'
.local~cpyr.2 = 'Licensed under a "Creative Commons Attribution-ShareAlike 3.0 Unported License"'
.local~cpyr.3 = 'Human readable   "http://creativecommons.org/licenses/by-sa/3.0/deed.en_US"'
.local~cpyr.4 = 'Legalese         "http://creativecommons.org/licenses/by-sa/3.0/legalcode"'

parse arg _args
_args = space(_args) "ffffffff"x
_argc = words(_args)

call time("R")
call __start

iarg = 0; args = ""
do  while ( iarg < _argc )

    if  iarg = 0 then do
        optc = ""; argv = ""
    end
    else do
        optc = word(_args, iarg); argv = word(_args, iarg+1)
    end

    if  optc = "-h" | ,
        optc = "--help" then do
            call __log "*** have a nice read ***"
            do  s = 1 to sourceline()
                call __log sourceline(s)
            end
        exit
    end

    if  __optstr("CP", "CP", "--CP") then ,
        iterate

    if  __optflg("trim", "trim", "--notrim", ".false") then ,
        iterate

    if  __optflg("trim", "trim", "--trim", ".true") then ,
        iterate

    if  __optflg("proc", "info", "--info", ".true") then ,
        iterate

    if  __optflg("proc", "dump", "--dump --vdump", ".true") then do
        calldump = "call __vdump ibuf, buff, CP"
        iterate
    end

    if  __optflg("proc", "dump", "--hdump", ".true") then do
        calldump = "call __hdump ibuf, buff, CP"
        iterate
    end

    if  __optstr("dest", "dest", "-D --dest") then ,
        iterate

    if  __optflg("dest", "real", "--real", ".true") then ,
        iterate

    if  left(optc, 1) = "-" then do
        call __log  "Unknown option : '"optc"' "
        iarg += 1
        iterate
    end

    args = args optc
    iarg += 1

end

if  haveCP then do
    if  wordpos(CP, "dummy cp01047_to_cp00367") = 0 then do
        call __log "Invalid codepage" "'"CP"'"
        call __leave
        exit
    end
end
else ,
    CP  = "cp01047_to_cp00367"

args = __argsort(args)
argc = words(args)

if  argc = 0 then do
    call __log  "need an argument (file to be UNXMITted)! "
    call __leave
    exit
end


if	dump then ,
	call __log  "'.dump' specified, all other options will be ignored"
else ,
if	info then ,
	call __log  "'info' specified, all other options will be ignored"

XMIheadr = "e0c9d5d4d9f0f1"x
XMIsuffx = ".xmi"
XMIsuff2 = ".xmit"

PDSheadr = "00ca6d0f"x
POEheadr = "01ca6d0f"x
R1offset = 2
R2offset = 2
R3offset = 2

PDoffset = 2
PSoffset = 2

inpf = ""
do iarg = 1 to argc
    if  inpf \= "" then ,
        call __close inpf

    argv = strip(word(args, iarg))
    inpf = argv
    if  \__isFile(inpf) then do
        inpf = argv || XMIsuffx
        if  \__isFile(inpf) then do
            inpf = argv || XMIsuff2
            if  \__isFile(inpf) then do
                call __log "file not found      : '"argv"'"
                iterate iarg
            end
        end
    end

    if  \__open(inpf, "rb") then do
        call __log "error opening       : '"inpf"'"
        iterate iarg
    end

    buff = charin(inpf, 2, 7)
    call __close inpf
    if buff \= XMIheadr then do
        call __log "not an IDTF file    : '"inpf"'"
        iterate iarg
    end
    if  \__open(inpf, "rb") then do
        call __log "error on 2nd open of: '"inpf"'"
        iterate iarg
    end

    say ""
    call __log "Input   : "inpf

    if \havedest then do
        dest = filespec("N", inpf)
        extn = ""
        p = lastpos(".", dest)
        if  p > 0 then do
            parse var dest dest =(p) extn
        end
    end

    call inminit

    outf = ""; name = ""; memb = ""
    kmbr = 0; kdir = 0;
    krec = 0; kbyt = 0

    shft = .false

    do  ibuf = 1 while ( chars(inpf) > 0 )
        buff = _getbuf(inpf)

        flag = substr(buff, 1, 1)

        if  '20'x = bitand(flag, '20'x) then do
            /*  process control record */

			if  outf \= "" then do
				call __close outf
				call __log left(memb, 10)"recds("right(krec, 8)") bytes("right(kbyt, 10)") file("outf")" desc
                outf = ""; name = ""; memb = ""
                krec = 0; kbyt = 0
                shft = .false
			end

            INMRTYP = __CPconv(substr(buff, 2, 6), CP)

            if  dump then do
                interpret calldump
                if  INMRTYP = "INMR06" then ,
                    leave ibuf
                iterate ibuf
            end

            if  INMRTYP = "INMR01" then do
                inmr01c += 1
                buff = substr(buff, 8)
                call process_INMR01 inmr01c
                iterate ibuf
            end

            if  INMRTYP = "INMR02" then do
                inmr02c += 1
                INMR02.inmr02c.inmfseq = c2d(substr(buff, 8, 4))
                buff = substr(buff, 12)
                call process_INMR02 inmr02c

                if  \dump & \info then ,
                if  _dsorg(INMR02.inmr02c.inmdsorg) = "?" then do
                    call __log "_dsorg '"INMR02.inmr02c.inmdsorg"' not supported"
                    iterate iarg
                end

                if  \dump & \info then ,
                if  _recfm(INMR02.inmr02c.inmrecfm) = "?" then do
                    call __log "_recfm '"INMR02.inmr02c.inmrecfm"' not supported"
		    		call __log  "Processing terminated for" "'"inpf"'"
                    iterate iarg
                end

/*
                if	INMR02.inmr02c.inmutiln = "INMCOPY" & ,
                	_dsorg(INMR02.inmr02c.inmdsorg) \= "PS" then do
                		call __log  "mismatched utilid:" inmr02c INMR02.xfseq.inmutiln
                		call __log  "           _dsorg :" inmr02c INMR02.xfseq.inmdsorg _dsorg(INMR02.inmr02c.inmdsorg)
		    		    call __log  "Processing terminated for" "'"inpf"'"
                	    iterate iarg
                end
                if	INMR02.inmr02c.inmutiln = "IEBCOPY" & ,
                	_dsorg(INMR02.inmr02c.inmdsorg) \= "PO" then do
                		call __log  "mismatched utilid:" inmr02c INMR02.xfseq.inmutiln
                		call __log  "           _dsorg :" inmr02c INMR02.xfseq.inmdsorg _dsorg(INMR02.inmr02c.inmdsorg)
		    		    call __log  "Processing terminated for" "'"inpf"'"
                		iterate iarg
                end
  */

                iterate ibuf
            end

            if  INMRTYP = "INMR03" then do
                inmr03c += 1
                if  inmr03c \= INMR02.inmr03c.inmfseq then do
                    say "oh shit ! file sequence mismatch "
                    signal logic__error
                end
                buff = substr(buff, 8)
                call process_INMR03 inmr03c

                if  \dump & \info then do
                    if  real then ,
                        dest = lower(INMR02.inmr03c.inmdsnam)
                    if  \__mkdir(dest) then do
	    			    call __log  "Duplicate Object" "'"dest"'"
		    		    call __log  "Processing terminated for" "'"inpf"'"
			    	    iterate iarg
                    end
                end
                iebcrseq = 1
                iterate ibuf
            end

            call process_INMRXX

            if  INMRTYP = "INMR06" then ,
                leave ibuf

        end

        if  info then ,
            iterate ibuf

        if  dump then do
            interpret calldump
            iterate ibuf
        end

        if  _dsorg(INMR02.inmr03c.inmdsorg) = "PS" then do
            LRECL = INMR02.inmr03c.inmlrecl
            XRECL = LRECL
            if  \shft & outf = "" then do
            	if	symbol("INMR02."inmr03c".inmterm") = "VAR" then ,
            	    name = dest || ".mail"
                else ,
                    name = dest

                unpk = .false
                asis = .false
                desc = ""

                if  _ispackd(substr(buff, PSoffset, 8)) then do
                    unpk = .true
                    desc = "ISPF-packed"
                    fill = "40"x
                    obuf = ""; olen = 0
                    shft = .false
                    xbuf = substr(buff, PSoffset + 8)
                end
            end

            if  unpk then do
                if  shft then do
                    xbuf = xbuf || substr(buff, PSoffset)
                    shft = .false
                end
                -- say "at shift   "c2x(xbuf)
                -- say "at shift   "__CPconv(xbuf)
                call _ISPunpk
            end
            else ,
                call _wrtbuf substr(buff, PSoffset)

            iterate ibuf
        end
        else ,
        if  _dsorg(INMR02.inmr03c.inmdsorg) = "PO" then do
            if iebcrseq = 1 then do
                /* IEBCOPY first control record */
		        if	( substr(buff, R1offset, 4) = PDSheadr ) then ,
		            iebcpdst = "PDS"
		        else ,
		        if	( substr(buff, R1offset, 4) = POEheadr ) then ,
		            iebcpdst = "PDSE"
		        else do
			        call __log  "invalid IEBCOPY control info '"upper(c2x(substr(buff, R1offset, 4)))"'x "
		    		call __log  "Processing terminated for" "'"inpf"'"
			        iterate iarg
			        exit
        		end
    	    	r1dsorg  = c2x(substr(buff, R1offset+4, 2))
	    	    r1blksz  = c2d(substr(buff, R1offset+6, 2))
		        LRECL    = c2d(substr(buff, R1offset+8, 2))
		        if  LRECL \= INMR02.inmr03c.inmlrecl then do
		            say "oh shit ! lrecl mismatch "
		            signal logic__error
		        end
		        r1recfm  = c2x(substr(buff, R1offset+10, 2))
		        if  r1recfm \= INMR02.inmr03c.inmrecfm then do
		            say "oh shit ! _recfm mismatch"
		            signal logic__error
		        end
		        if r1recfm = "9000" then ,
		            XRECL = LRECL
                else ,
                    XRECL = LRECL - 4
                r1tblksz = c2x(substr(buff, R1offset+14, 2))
		        r1devtyp = c2x(substr(buff, R1offset+16, 20))
		        TRKSXCYL = c2d(substr(buff, R1offset+26, 2))
                iebcrseq = 2
                iterate ibuf
            end
            if iebcrseq = 2 then do
                /* IEBCOPY second control record */
		        debp	= R2offset
		        debt.0  = c2d(substr(buff, debp, 1))
		        relt	= 0
		        do  i = 1 to debt.0
			        debp = debp + 16
			        debf = c2d(substr(buff, debp+6 , 2)) * TRKSXCYL  + ,
                           c2d(substr(buff, debp+8 , 2))
			        debl = c2d(substr(buff, debp+10, 2)) * TRKSXCYL  + ,
                           c2d(substr(buff, debp+12, 2))
			        trks = c2d(substr(buff, debp+14, 2))
			        size = debl - debf + 1
			        if	size \= trks then ,
                        signal logic__error
			        debt.i.1    = debf
			        debt.i.2    = debl
			        debt.i.3    = relt
			        debt.i.4    = relt + trks
			        relt        = relt + trks
		        end
                iebcrseq = 3
                iterate ibuf
            end
            if  iebcrseq = 3 then do
                /* IEBCOPY directory control record */
			    buff = substr(buff, R3offset)
			    do  idir = 1 while (buff \= "")
			    	if  substr(buff, 1, 1) = "88"x then do
			    	    iebcrseq = 0
			    	    iterate ibuf
			    	end
			    	parse var buff . 23 dirb 277 buff
			    	do while ( dirb \= "" )
			    		if	length(dirb) < 12 then ,
			    		    iterate idir
			    		if	substr(dirb, 1, 8) = "ffffffffffffffff"x then do
			    			iebcrseq = 0
			    			iterate ibuf
                        end
			    		ttr	= lower(c2x(substr(dirb, 9, 3)))
			    		flg	= bitand(substr(dirb, 12, 1), '80'x)
			    		udl	= c2d(bitand(substr(dirb, 12, 1), '1F'x))
			    		if  ttr \== "000000" then do
			    		    if	flg = '00'x then do
			    			    MEMBER.ttr = strip(__CPconv(substr(dirb, 1, 8), CP) )
			    			    kdir += 1
    			    	    end
    			    	end
    			    	dirb = substr(dirb, 12 + udl * 2 + 1)
			    	end
			    end
                iterate ibuf
            end

            /* process members */
		    offs = PDoffset
			do while offs < length(buff)
				blksz = c2d(substr(buff, offs + 10, 2))
				if  blksz = 0 | ,
				    substr(buff, offs, 1) \= "00"x then do
			        if  outf \= "" then do
				        call __close outf
				        call __log left(memb, 10)"recds("right(krec, 8)") bytes("right(kbyt, 10)") file("outf")" desc
                    end
                    outf = ""; name = ""; memb = ""
                    krec = 0; kbyt = 0
                    shft = .false
                    iterate ibuf
                end
			    if  memb = "" then do
		            membcc = c2d(substr(buff, offs+4, 2))
		            membhh = c2d(substr(buff, offs+6, 2))
		            membrr = c2x(substr(buff, offs+8, 1))
		            trk    = membcc * TRKSXCYL  + membhh
		            do	i = 1 to debt.0
			            if ( trk >= debt.i.1 ) & ( trk <= debt.i.2 ) then ,
				        leave
		            end
		            ttr  = lower(right(d2x(trk - debt.i.1 + debt.i.3), 4, '0') || membrr)
		            if  symbol("MEMBER.ttr") \= "VAR" then do
		                say "oh shit ! MEMBER stem conflict"
		                signal logic__error
		            end
		            memb = lower(strip(MEMBER.ttr))
		            name = memb
			        kmbr += 1
			    end

			    offs += 12
			    if  _recfm(INMR02.inmr03c.inmrecfm) = "F" then do
			        RDWL = 0
			        wtmk = offs + LRECL * ( blksz % LRECL )
				    offs = offs + RDWL
			        do  while ( offs < wtmk )
			            lrec = LRECL

			            if  \shft & outf = "" then do
                            unpk = .false
                            desc = ""
			                if  _ispackd(substr(buff, offs+RDWL, 8)) then do
                                unpk = .true
                                desc = "ISPF-packed"
                                fill = "40"x
                                obuf = ""; olen = 0
                                shft = .false
                                xbuf = substr(buff, offs+RDWL+8, lrec-RDWL-8)
                            end

                        end

                        if  unpk then do
                            if  shft then do
                                shft = .false
                                xbuf = xbuf || substr(buff, offs+RDWL, lrec-RDWL)
                            end
                            call _ISPunpk
                        end
                        else ,
                            call _wrtbuf substr(buff, offs+RDWL, lrec-RDWL)

                        offs += lrec
                    end
                end

                else ,
			    if  _recfm(INMR02.inmr03c.inmrecfm) = "V" then do
			        RDWL = 4
			        wtmk = offs + c2d(substr(buff, offs, 2))
				    offs = offs + RDWL
                    do  while ( offs < wtmk )
			            lrec = c2d(substr(buff, offs, 2))

			            if  \shft & outf = "" then do
                            unpk = .false
                            desc = ""
			                if  _ispackd(substr(buff, offs+RDWL, 8)) then do
                                unpk = .true
                                desc = "ISPF-packed"
                                fill = "40"x
                                obuf = ""; olen = 0
                                shft = .false
                                xbuf = substr(buff, offs+RDWL+8, lrec-RDWL-8)
                            end
                        end

                        if  unpk then do
                            if  shft then do
                                shft = .false
                                xbuf = xbuf || substr(buff, offs+RDWL, lrec-RDWL)
                            end
                            call _ISPunpk
                        end
                        else ,
                            call _wrtbuf substr(buff, offs+RDWL, lrec-RDWL)

                        offs += lrec
                    end
                end

                else ,
                    signal logic__error
			end

        end

    end
--  call __log "Input   : '"inpf"'"

    call __log "buffers : "ibuf
    call __log "dirmems : "kdir
    call __log "members : "kmbr

end

call __leave time('E')
exit

logic_error:
call __log  "******************************************************************"
call __log  "** "
call __log  "** Logic error at line '"sigl"' "
call __log  "** "
call __log  "******************************************************************"
exit

novalue:
call __log  "******************************************************************"
call __log  "** "
call __log  "** Novalue trapped, line '"sigl"' var '"condition("D")"' "
call __log  "** "
call __log  "******************************************************************"
exit

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
__optflg:
    use strict arg _optf_, _optv_, _opts_, _flgv_
    if  symbol("have"_optf_) \= "VAR" then ,
        interpret "have"_optf_" = .false"
    if  symbol(_optv_) \= "VAR" then ,
        interpret _optv_" = \"_flgv_

    interpret ,
    "if wordpos(optc, _opts_) > 0 then do " "; " ,
        "if have"_optf_" then do " "; " ,
            "call __log  "" "optc" Already specified"" " "; " ,
            "call __leave " "; " ,
            "exit " "; " ,
        "end " "; " ,
        "else do " "; " ,
            "have"_optf_" = .true " "; " ,
            _optv_" = "_flgv_ "; " ,
            "iarg += 1 " "; " ,
            "return .true " "; " ,
        "end " "; " ,
    "end " "; "
    return .false

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
__optstr:
    use strict arg _optf_, _optv_, _opts_
    if  symbol("have"_optf_) \= "VAR" then ,
        interpret "have"_optf_" = .false "
    if  symbol(_optv_) \= "VAR" then ,
        interpret _optv_" = """" "

    interpret ,
    "if wordpos(optc, _opts_) > 0 then do " "; " ,
        "if have"_optf_" then do " "; " ,
            "call __log  ""option : '"optc"' Already specified"" " "; " ,
            "call __leave " "; " ,
            "exit " "; " ,
        "end " "; " ,
        "else do " "; " ,
            "if  argv = 'ffffffff'x | " ,
                "left(argv, 1) = ""-"" then do"  "; " ,
                "call __log  ""option : '"optc"' requires an argument"" " "; " ,
                "call __leave" "; " ,
                "exit" "; " ,
            "end" "; " ,
            "have"_optf_" = .true " "; " ,
            _optv_" = lower(argv) " "; " ,
            "iarg += 2 " "; " ,
            "return .true " "; " ,
        "end " "; " ,
    "end " "; "
    return .false


/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
inminit:
    drop    INMR01.
    drop    INMR02.
    drop    INMR03.
    drop    INMR04.
    drop    INMR05.
    drop    INMR06.
    drop    INMR07.
    drop    INMR08.

    inmr01c = 0; INMR01.0 = 0;
    inmr02c = 0; INMR02.0 = 0;
    inmr03c = 0; INMR03.0 = 0;
    inmr04c = 0; INMR04.0 = 0;
    inmr05c = 0; INMR05.0 = 0;
    inmr06c = 0; INMR06.0 = 0;
    inmr07c = 0; INMR07.0 = 0;
    inmr08c = 0; INMR08.0 = 0;

    inmkey.1  = '0001'x; inmdesc.1  = "inmddnam"; inmconv.1  = "c";
    inmkey.2  = '0002'x; inmdesc.2  = "inmdsnam"; inmconv.2  = "c";
    inmkey.3  = '0003'x; inmdesc.3  = "inmmembr"; inmconv.3  = "c";
    inmkey.4  = '000B'x; inmdesc.4  = "inmsecnd"; inmconv.4  = "d";
    inmkey.5  = '000C'x; inmdesc.5  = "inmdir"  ; inmconv.5  = "d";
    inmkey.6  = '0022'x; inmdesc.6  = "inmexpdt"; inmconv.6  = "c";
    inmkey.7  = '0028'x; inmdesc.7  = "inmterm" ; inmconv.7  = "c";
    inmkey.8  = '0030'x; inmdesc.8  = "inmblksz"; inmconv.8  = "d";
    inmkey.9  = '003C'x; inmdesc.9  = "inmdsorg"; inmconv.9  = "x";
    inmkey.10 = '0042'x; inmdesc.10 = "inmlrecl"; inmconv.10 = "d";
    inmkey.11 = '0049'x; inmdesc.11 = "inmrecfm"; inmconv.11 = "x";
    inmkey.12 = '1001'x; inmdesc.12 = "inmtnode"; inmconv.12 = "c";
    inmkey.13 = '1002'x; inmdesc.13 = "inmtuid" ; inmconv.13 = "c";
    inmkey.14 = '1011'x; inmdesc.14 = "inmfnode"; inmconv.14 = "c";
    inmkey.15 = '1012'x; inmdesc.15 = "inmfuid" ; inmconv.15 = "c";
    inmkey.16 = '1020'x; inmdesc.16 = "inmlref" ; inmconv.16 = "c";
    inmkey.17 = '1021'x; inmdesc.17 = "inmlchg" ; inmconv.17 = "c";
    inmkey.18 = '1022'x; inmdesc.18 = "inmcreat"; inmconv.18 = "c";
    inmkey.19 = '1023'x; inmdesc.19 = "inmfvers"; inmconv.19 = "c";
    inmkey.20 = '1024'x; inmdesc.20 = "inmftime"; inmconv.20 = "c";
    inmkey.21 = '1025'x; inmdesc.21 = "inmttime"; inmconv.21 = "c";
    inmkey.22 = '1026'x; inmdesc.22 = "inmfack" ; inmconv.22 = "c";
    inmkey.23 = '1027'x; inmdesc.23 = "inmerrcd"; inmconv.23 = "c";
    inmkey.24 = '1028'x; inmdesc.24 = "inmutiln"; inmconv.24 = "c";
    inmkey.25 = '1029'x; inmdesc.25 = "inmuserp"; inmconv.25 = "c";
    inmkey.26 = '102A'x; inmdesc.26 = "inmrecct"; inmconv.26 = "c";
    inmkey.27 = '102C'x; inmdesc.27 = "inmsize" ; inmconv.27 = "d";
    inmkey.28 = '102D'x; inmdesc.28 = "inmffm"  ; inmconv.28 = "c";
    inmkey.29 = '102F'x; inmdesc.29 = "inmnumf" ; inmconv.29 = "d";
    inmkey.30 = '8012'x; inmdesc.30 = "inmtype" ; inmconv.30 = "x";
    inmkey.31 = '8018'x; inmdesc.31 = "inmlsize"; inmconv.31 = "d";

    inmkeys = 31

    inmdsnam__ = '0002'x
    inmdsorg__ = '003C'x
    inmrecfm__ = '0049'x
    inmlrecl__ = '0042'x

    inmutiln__ = '1028'x

    return

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
process_INMR01:
process_INMR02:
process_INMR03:
    parse arg inmrseq
    leng = length(buff)
    do while ( length(buff)  > 0 )
        next = _getkey(buff)
        nfnd = .true
        select
            when inmkey = inmdsnam__ then do
                dsnam =  __CPconv(keyv.1, CP)
                do  k = 2 to keyv.0
                    dsnam = dsnam || "." || __CPconv(keyv.k, CP)
                end
                /* dsnam = lower(dsnam) */
                call value INMRTYP"."inmrseq".inmdsnam", dsnam
                nfnd = .false
            end

            otherwise ,
                do  k = 1 to inmkeys
                    if  inmkey = inmkey.k then do
                        nfnd = .false
                        knam = INMRTYP"."inmrseq"."inmdesc.k
                        if  keyv.0 = 0 then ,
                            call value knam, ""
                        else,
                        if  inmconv.k = "d" then ,
                            call value knam, c2d(keyv.1)
                        else ,
                        if  inmconv.k = "x" then ,
                            call value knam, c2x(keyv.1)
                        else ,
                            call value knam, __CPconv(keyv.1, CP)
                        leave
                    end
                end
        end
        if  nfnd then ,
            call __log INMRTYP "unsupported key" c2x(substr(buff, 3+1, 16))

        buff = substr(buff, next)
    end

    if info then do
        call __log  copies("- ", 30)
        call __log  INMRTYP inmrseq leng

        interpret  "do v over "INMRTYP". ;" ,
                       "parse var v vseq '.' ;" ,
                       "if vseq \= inmrseq then iterate; " ,
                           "vname = INMRTYP'.'v ;" ,
                           "call __log left(vname, 20) ""="" "INMRTYP".v;" ,
                   "end "
    end
    return

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
process_INMRXX:
    if  info then do
        call __log  copies("- ", 30)
        call __log  INMRTYP
    end
    return


/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
_ISPunpk:
    do  forever
        if  olen > XRECL then do
            say "oh shit ! XRECL mismatch "
            signal logic__error
        end
        if  olen = XRECL then do
            call _wrtbuf obuf
            obuf = ""; olen = 0
        end

        /*
        if  xbuf = "" then do
            say "oh shit ! empty unpack buffer"
            signal logic__error
        end
        */
        if  xbuf = "" then do
            shft = .true
            return
        end

        xflg = substr(xbuf, 1, 1)

        select

            when xflg = "ff"x then ,
                return

            when xflg = "78"x  | xflg = "7c"x then do
                /* repeat spaces 1 byte  lenght */
                if  length(xbuf) <= 2 then do
                    shft = .true
                    return
                end
                xlen = c2d(substr(xbuf, 2, 1)) + 1
                if  ( olen + xlen ) \= XRECL then do
                    say "oh shit ! XRECL mismatch "
                    signal logic__error
                end
                obuf = obuf || copies(" ", xlen)
                olen += xlen
                call _wrtbuf obuf
                obuf = ""; olen = 0
                xbuf = substr(xbuf, 2 + 1)
--                iterate
            end

            when xflg = "79"x | xflg = "7d"x then do
                /* repeat spaces 2 bytes lenght */
                if  length(xbuf) <= 3 then do
                    shft = .true
                    return
                end
                xlen = c2d(substr(xbuf, 2, 2)) + 1
                if  ( olen + xlen ) \= XRECL then do
                    say "oh shit ! XRECL mismatch "
                    signal logic__error
                end
                obuf = obuf || copies(" ", xlen)
                olen += xlen
                call _wrtbuf obuf
                obuf = ""; olen = 0
                xbuf = substr(xbuf, 3 + 1)
--                iterate
            end

            when xflg = "7a"x | xflg = "7e"x then do
                /* repeat char 1 bytes lenght */
                if  length(xbuf) <= 3 then do
                    shft = .true
                    return
                end
                xlen = c2d(substr(xbuf, 2, 1)) + 1
                char = substr(xbuf, 3, 1)
                obuf = obuf || copies(char, xlen)
                olen += xlen
                xbuf = substr(xbuf, 3 + 1)
--                iterate
            end

            when xflg = "7b"x | xflg = "7f"x then do
                /* repeat char 2 bytes lenght */
                if  length(xbuf) <= 4 then do
                    shft = .true
                    return
                end
                xlen = c2d(substr(xbuf, 2, 2)) + 1
                char = substr(xbuf, 4, 1)
                obuf = obuf || copies(char, xlen)
                olen += xlen
                xbuf = substr(xbuf, 4 + 1)
--                iterate
            end

            when xflg = "f8"x | xflg = "fc"x then do
                /* string 1 byte  lenght */
                if  length(xbuf) <= 2 then do
                    shft = .true
                    return
                end
                xlen = c2d(substr(xbuf, 2, 1)) + 1
                if  length(xbuf) <= xlen + 2 then do
                    shft = .true
                    return
                end
                obuf = obuf || substr(xbuf, 3, xlen)
                olen += xlen
                xbuf = substr(xbuf, 2 + xlen + 1 )
--                iterate
            end

            when xflg = "f9"x | xflg = "fd"x then do
                /* string 2 bytes lenght */
                if  length(xbuf) <= 3 then do
                    shft = .true
                    return
                end
                xlen = c2d(substr(xbuf, 2, 2)) + 1
                if  length(xbuf) <= xlen + 3 then do
                    shft = .true
                    return
                end
                obuf = obuf || substr(xbuf, 4, xlen)
                olen += xlen
                xbuf = substr(xbuf, 3 + xlen + 1 )
--                iterate
            end

            when xflg >= "80"x then do
                xlen = c2d(xflg) - 127
                if  length(xbuf) <= xlen + 1 then do
                    shft = .true
                    return
                end
                obuf = obuf || substr(xbuf, 2, xlen)
                olen += xlen
                xbuf = substr(xbuf, 1 + xlen + 1)
--                iterate
            end

            otherwise do
                xlen = c2d(xflg) + 1
                if  length(xbuf) <= xlen + 1 then do
                    shft = .true
                    return
                end
                obuf = obuf || copies("40"x, xlen)
                olen += xlen
                xbuf = substr(xbuf, 2)
                if  xbuf = "" then do
                    shft = .true
                    return
                end
--                iterate

            end /* end select */

        end

    end

    say "oh shit ! missing/lost 'ff'x "
    signal logic__error

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
_wrtbuf:
    parse arg buf
    if  outf = "" then do

		if	substr(buf, 2, 7) = XMIheadr then do
			suff = XMIsuffx
			asis = .true
		end
		else ,
			call _ftype buf

        outf = dest || .local~psep || name || suff

    	if	\__open(outf, "wr") then do
	    	call __log  "error opening"  "'"outf"'"
		    call __log  "Processing terminated for" "'"inpf"'"
			call __leave
			exit
		end
        krec = 0; kbyt = 0
        olen = 0
    end

    if  asis then do
        call charout outf, buf
        kbyt += length(buf)
    end
    else do
        obuf = __CPconv(buf, CP)
        if  trim then ,
            obuf = strip(obuf, "T")
        call lineout outf, obuf
        kbyt += length(obuf)
    end
    krec += 1;

    return

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
_getbuf: Procedure
    parse arg file
    leng = charin(file, , 1)
    flag = charin(file, , 1)
    buff = flag || charin(file, , c2d(leng)-2)
    do  while '00'x = Bitand(flag, '40'x)
        leng = charin(file, , 1)
        flag = charin(file, , 1)
        buff = buff || charin(file, , c2d(leng)-2)
    end
    return buff

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
_getkey: procedure expose inmkey keyv.
    parse arg   buff
    parse var   buff ,
                inmkey  +2 ,
                coun    +2 ,
                .
    coun = c2d(coun)
    keyv.0 = coun
    next = 5
    do  k = 1 to coun
        leng  = c2d(substr(buff, next  , 2))
        keyv.k = substr(buff, next+2, leng)
        next  = next + leng + 2
    end
    return next

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
_dsorg: procedure
    if  left(arg(1), 2) = "02" then ,
        return "PO"
    if  left(arg(1), 2) = "40" then ,
        return "PS"
    return "?"

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
_recfm: procedure
    w = x2c(arg(1))
    if  bitand(w, 'C000'x) = 'C000'x then ,
        return "?"
    if  bitand(w, '8000'x) = '8000'x then ,
        return "F"
    if  bitand(w, '4000'x) = '4000'x then ,
        return "V"
    return "?"

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
_ftype: procedure expose suff asis

    parse arg buf

    sigs =  "02c5e2c4"x ,
            "02e3e7e3"x ,
            "02d9d3c4"x ,
            "02c5d5c4"x ,
            "255044462d"x ,
            "504b0304"x ,
            "d0cf11e0a1b11ae1"x ,
            "c4c2d9d4000000a0"x
    sufs =  ".obj" ,
            ".obj" ,
            ".obj" ,
            ".obj" ,
            ".pdf" ,
            ".zip" ,
            ".doc" ,
            ".dbrm"

    ebcp =  "404a4b4c4d4e4f"x || ,
            "505a5b5c5d5e5f"x || ,
            "60616a6b6c6d6e6f"x || ,
            "797a7b7c7d7e7f"x || ,
            "818283848586878889"x || ,
            "919293949596979899"x || ,
            "a1a2a3a4a5a6a7a8a9ad"x || ,
            "bd"x || ,
            "c0c1c2c3c4c5c6c7c8c9"x || ,
            "d0d1d2d3d4d5d6d7d8d9"x || ,
            "e0e2e3e4e5e6e7e8e9"x || ,
            "f0f1f2f3f4f5f6f7f8f9"x

    suff = ".txt"
    asis = .false

    -- say c2x(buf)

    do  i = 1 to words(sigs)
        sig = word(sigs, i)
        len = length(sig)
        if  left(buf, len) = sig then do
            suff = word(sufs, i)
            asis = .true
            return 0
        end
    end

    if  verify(buf, ebcp) \= 0 then do
        suff = ".bin"
        asis = .true
    end

    return 0

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
_ispackd: procedure expose XRECL
    parse arg buf
    if  buf == "000140c6"x || right(d2c(XRECL), 4, "00"x) | ,
        buf == "000140e5"x || right(d2c(XRECL), 4, "00"x) then ,
        return .true
    return .false


/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

::requires  "esmcutil.cls"
