/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
/* Name : <filename>                                                               */
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
/* This work is     "Copyright (c) 2013-2013 Enrico Sorichetti"                    */
/* Licensed under a "Creative Commons Attribution-ShareAlike 3.0 Unported License" */
/* Human readable   "http://creativecommons.org/licenses/by-sa/3.0/deed.en_US"     */
/* Legalese         "http://creativecommons.org/licenses/by-sa/3.0/legalcode"      */
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
/*  Char/String Related                                                       */
/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
::routine __isnum public
  return (verify(arg(1),"0123456789") = 0 )

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
::routine __ishex public
  return ( verify(lower(arg(1)),'0123456789abcdef') = 0 )

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
::routine __strings public
    if  arg() \= 1 then
        return 0

    apos = "'"; quot = '"'; stop = 'ff'x;

    strv = strip(arg(1)) || stop

    strc = 0;
    do while ( strv \= stop)
        strc += 1
        char = left(strv,1)
        if  char \= apos & char \= quot then ,
            char = " "

        next = min(_Pos(char,strv,2), ,
                   _Pos(stop,strv,2))

        if  char = " " then ,
            strv = strip(substr(strv,next))
        else
            strv = strip(substr(strv,next+1))

    end

    return strc

return 0

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
::routine __string public
    if  arg() \= 2 then
        return ""

    apos = "'"; quot = '"'; stop = 'ff'x;

    strv = strip(arg(1)) || stop

    strc = 0 ;
    do while ( strv \= stop)
        strc += 1
        char = left(strv,1)
        if  char \= apos & char \= quot then ,
            char = " "

        next = min(_Pos(char,strv,2), ,
                   _Pos(stop,strv,2))

        if strc = arg(2) then leave

        if char = " " then ,
            strv = strip(substr(strv,next))
        else
            strv = strip(substr(strv,next+1))
    end

    if strc < arg(2) then ,
        return ""

    if  substr(strv,next,1) = char then ,
        return strip(left(strv,next))
    else ,
        return strip(left(strv,next-1))

return ""

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
::routine __pos public
    p = pos( arg(1), arg(2), arg(3))
    if  p > 0  then ,
        return p
    return 999999

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
::routine __plural public
    if arg(2) = 1 then ,
        return arg(1)
    else ,
        return arg(1) || "s"

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
/*  Console Related                                                           */
/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
::routine __log public
	if arg() = 1 then ,
	    .output~lineout(left(.local~self, 9) || "- " || strip(arg(1),"T"))
	else ,
		.output~lineout("")
	return

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
::routine __err public
	if  arg() = 1 then ,
	    .error~lineout(left(.local~self, 9) || "- " || strip(arg(1),"T"))
	else ,
	    .error~lineout("")
	return 0

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
::routine __start public
    if  .local~cpyr.0 > 0 then do
        do  i = 1 to .local~cpyr.0
            interpret "call __log .local~cpyr."i
        end
        say ""
    end
	call __log "Started :" time()
	return

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
::routine __leave public
    et = arg(1)
    if et \= "" then do
        parse var et secs "." usec
        ss = (   secs // 60 )
        mm = (   secs  % 60 ) // 60
        hh = ( ( secs  % 60 )  % 60 ) // 24
        dd = ( ( secs  % 60 )  % 60 )  % 24
        if          dd \= 0 then ,
            elaps = dd __plural("day",dd) hh __plural("hour",hh) mm __plural("minute",mm) ss __plural("second",ss)
        else    if  hh \= 0 then ,
            elaps = hh __plural("hour",hh) mm __plural("minute",mm) ss __plural("second",ss)
        else    if  mm \= 0 then ,
            elaps = mm __plural("minute",mm) ss __plural("second",ss)
        else    if  ss \= 0 then ,
            elaps = ss __plural("second",ss)
        else ,
            elaps = 0
        call __log "Ended   :" time()  "Elapsed :" elaps
    end
    else ,
	    call __log "Ended   :" time()

    return

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
::routine __pause public
	call __log "Press (ENTER) to continue"
	pull z
	return

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
::routine __cancel public
	call __log "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
	call __log arg(1)
	call __log "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
	exit

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
::routine __yesno public
	say left(.local~self, 9) || "- " || strip(arg(1),"T")
	_repl = "z"
	do while ( pos(_repl,"y nxq ") = 0 )
		say copies(" ",12) || "(y/Y/[enter]) to continue"
		say copies(" ",12) || "(n/N/x/X) to exit"
		parse pull _repl
		_repl = lower(left(strip(_repl),1))
	end
	return translate(_repl,"11000","y nxq")

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
/*  File Related                                                              */
/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
::routine __exists public
    if  SysIsFile(arg(1)) then ,
        return .true
    if SysIsFileDirectory(arg(1)) then ,
         return .true
	return .false

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
::routine __isFile public
    if  SysIsFile(arg(1)) then ,
        return .true
    return .false

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
::routine __isPath public
	if  SysIsFileDirectory(arg(1)) then ,
        return 1
    return .false

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
::routine __mkdir public
    parse arg todo
    done = ""
    do  while ( todo \= "" )
        parse var todo curr (.local~psep) todo
        done = done || curr || .local~psep
        if  SysIsFileDirectory(done) then ,
            iterate
        if  SysMkDir(done) \= 0 then ,
            return .false
    end
    return .true

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
::routine __open public
	if arg() < 2 then ,
		return .false
	if lower(arg(2)) = "r" then ,
		parms  = " open read "
	else ,
	if lower(arg(2)) = "rb" then ,
		parms  = " open read binary"
	else ,
 	if	lower(arg(2)) = "w" then ,
		parms  = " open write"
	else ,
 	if	lower(arg(2)) = "wr" then ,
		parms  = " open write replace"
	else ,
		return .false
	if arg() = 3 then do
		if \datatype(arg(3),"n") then ,
			return .false
		parms  = parms  || " reclenght " arg(3)
	end
	return ( stream(arg(1), "c", parms ) = "READY:" )

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
::routine __close public
	parms = " close"
	return ( stream(arg(1), "c", parms) = "READY:" )

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
/*  Environment Related                                                       */
/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
::routine __getenv public
	return VALUE(arg(1),,"ENVIRONMENT")

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

::routine __setenv public
	return VALUE(arg(1),arg(2),"ENVIRONMENT")

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

::routine __unsetenv public
	call VALUE arg(1), .NIL, "ENVIRONMENT"
	return 0

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
/*  Misc                                                                      */
/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
::routine __ls public
    Address "bash" "ls "arg(1)" | rxqueue"
    list = ""
    do i = 1 while queued() > 0
	    parse pull data
	    list = list data
    end
    return space(list)

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
::routine __vdump public
    parse arg ibuf, buff, CP
	if  ibuf = 0 then ,
	    hdr1 = copies(" ",7)
    else ,
	    hdr1 = copies(" ",7) copies(" ",7)
	offs	= 1
	call __log hdr1 || ">>" || copies("1234567890",8) || "<<"
	do  while ( buff \= "" )
		parse var buff with 1 temp 81 buff
		if  ibuf = 0 then ,
		    call __log left(right(offs,6),7) || ">>" || __e2a(temp, CP) || "<<"
		else ,
		    call __log left(right(ibuf,6),7) left(right(offs,6),7) || ">>" || __e2a(temp, CP) || "<<"

		temp    = c2x(temp)
		buf0    = ""
		buf1    = ""
		do	i = 1 to length(temp) - 1 by 2
			buf0    = buf0 || substr(temp, i    , 1 )
			buf1    = buf1 || substr(temp, i + 1, 1 )
		end
		call __log hdr1 || ">>" || buf0 || "<<"
		call __log hdr1 || ">>" || buf1 || "<<"
		call __log
		offs += 80
	end
	return 0

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
::routine __hdump public
    parse   arg ibuf, buff, CP
	if  ibuf = 0 then ,
	    hdr1 = copies(" ",7)
    else ,
	    hdr1 = copies(" ",7) copies(" ",7)
	offs	= 1
	call __log hdr1 || ">>" || copies("1 2 3 4 5 6 7 8 9 0 ",8) || "<<"
	do  while ( buff \= "" )
		parse var buff with 1 temp 81 buff
		buf0 = ""
		do  i = 1 to length(temp)
		    buf0 = buf0 || substr(temp,i,1) || "40"x
		end
	if  ibuf = 0 then ,
		call __log                       left(right(offs,6),7) || ">>" || __e2a(buf0, CP) || "<<"
	else ,
		call __log left(right(ibuf,6),7) left(right(offs,6),7) || ">>" || __e2a(buf0, CP) || "<<"
	    buf1 = c2x(temp)
	if  ibuf = 0 then ,
		call __log                       left(right(offs,6),7) || ">>" ||       buf1       || "<<"
	else ,
		call __log left(right(ibuf,6),7) left(right(offs,6),7) || ">>" ||       buf1       || "<<"
		call __log
		offs += 80
	end
	return 0

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
::routine __CPconv public

    use strict arg buf, CP

                        /* 0 1 2 3 4 5 6 7 8 9 A B C D E F              */
    cp00367_to_cp01047  = "40404040404040404040404040404040"x || , /* 0 */
                          "40404040404040404040404040404040"x || , /* 1 */
                          "405A7F7B5B6C507D4D5D5C4E6B604B61"x || , /* 2 */
                          "F0F1F2F3F4F5F6F7F8F97A5E4C7E6E6F"x || , /* 3 */
                          "7CC1C2C3C4C5C6C7C8C9D1D2D3D4D5D6"x || , /* 4 */
                          "D7D8D9E2E3E4E5E6E7E8E9ADE0BD5F6D"x || , /* 5 */
                          "79818283848586878889919293949596"x || , /* 6 */
                          "979899A2A3A4A5A6A7A8A9C04FD0A140"x || , /* 7 */
                          "40404040404040404040404040404040"x || , /* 8 */
                          "40404040404040404040404040404040"x || , /* 9 */
                          "40404040404040404040404040404040"x || , /* A */
                          "40404040404040404040404040404040"x || , /* B */
                          "40404040404040404040404040404040"x || , /* C */
                          "40404040404040404040404040404040"x || , /* D */
                          "40404040404040404040404040404040"x || , /* E */
                          "40404040404040404040404040404040"x      /* F */
                        /* 0 1 2 3 4 5 6 7 8 9 A B C D E F              */
    cp01047_to_cp00367  = "20202020202020202020202020202020"x || , /* 0 */
                          "20202020202020202020202020202020"x || , /* 1 */
                          "20202020202020202020202020202020"x || , /* 2 */
                          "20202020202020202020202020202020"x || , /* 3 */
                          "20202020202020202020202E3C282B7C"x || , /* 4 */
                          "2620202020202020202021242A293B5E"x || , /* 5 */
                          "2D2F2020202020202020202C255F3E3F"x || , /* 6 */
                          "202020202020202020603A2340273D22"x || , /* 7 */
                          "20616263646566676869202020202020"x || , /* 8 */
                          "206A6B6C6D6E6F707172202020202020"x || , /* 9 */
                          "207E737475767778797A2020205B2020"x || , /* a */
                          "202020202020202020202020205D2020"x || , /* b */
                          "7B414243444546474849202020202020"x || , /* c */
                          "7D4A4B4C4D4E4F505152202020202020"x || , /* d */
                          "5C20535455565758595A202020202020"x || , /* e */
                          "30313233343536373839202020202020"x      /* f */
                        /* 0 1 2 3 4 5 6 7 8 9 a b c d e f              */

    interpret "return translate(buf, "CP")"

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
::routine __a2e public

    use strict arg buf, CP="cp00367_to_cp01047"

                        /* 0 1 2 3 4 5 6 7 8 9 A B C D E F              */
    cp00367_to_cp01047  = "40404040404040404040404040404040"x || , /* 0 */
                          "40404040404040404040404040404040"x || , /* 1 */
                          "405A7F7B5B6C507D4D5D5C4E6B604B61"x || , /* 2 */
                          "F0F1F2F3F4F5F6F7F8F97A5E4C7E6E6F"x || , /* 3 */
                          "7CC1C2C3C4C5C6C7C8C9D1D2D3D4D5D6"x || , /* 4 */
                          "D7D8D9E2E3E4E5E6E7E8E9ADE0BD5F6D"x || , /* 5 */
                          "79818283848586878889919293949596"x || , /* 6 */
                          "979899A2A3A4A5A6A7A8A9C04FD0A140"x || , /* 7 */
                          "40404040404040404040404040404040"x || , /* 8 */
                          "40404040404040404040404040404040"x || , /* 9 */
                          "40404040404040404040404040404040"x || , /* A */
                          "40404040404040404040404040404040"x || , /* B */
                          "40404040404040404040404040404040"x || , /* C */
                          "40404040404040404040404040404040"x || , /* D */
                          "40404040404040404040404040404040"x || , /* E */
                          "40404040404040404040404040404040"x      /* F */
                        /* 0 1 2 3 4 5 6 7 8 9 A B C D E F              */

    interpret "return translate(buf, "CP")"

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
::routine __e2a public

    use strict arg buf, CP="cp01047_to_cp00367", ...

                        /* 0 1 2 3 4 5 6 7 8 9 A B C D E F              */
    cp01047_to_cp00367  = "20202020202020202020202020202020"x || , /* 0 */
                          "20202020202020202020202020202020"x || , /* 1 */
                          "20202020202020202020202020202020"x || , /* 2 */
                          "20202020202020202020202020202020"x || , /* 3 */
                          "20202020202020202020202E3C282B7C"x || , /* 4 */
                          "2620202020202020202021242A293B5E"x || , /* 5 */
                          "2D2F2020202020202020202C255F3E3F"x || , /* 6 */
                          "202020202020202020603A2340273D22"x || , /* 7 */
                          "20616263646566676869202020202020"x || , /* 8 */
                          "206A6B6C6D6E6F707172202020202020"x || , /* 9 */
                          "207E737475767778797A2020205B2020"x || , /* a */
                          "202020202020202020202020205D2020"x || , /* b */
                          "7B414243444546474849202020202020"x || , /* c */
                          "7D4A4B4C4D4E4F505152202020202020"x || , /* d */
                          "5C20535455565758595A202020202020"x || , /* e */
                          "30313233343536373839202020202020"x      /* f */
                        /* 0 1 2 3 4 5 6 7 8 9 A B C D E F              */

    interpret "return translate(buf, "CP")"

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
::routine __argsort public

    parse arg u
    n = words(u)
    a.0 = n
    do  i = 1 to n
        parse var u a.i u
    end

    h = a.0
    do  while h > 1;
        h = h % 2;
        do  i = 1 for a.0 - h
            j = i; k = h + i;
            do  while a.k < a.j
                t = a.j; a.j = a.k; a.k = t;
                if  h >= j then ,
                    leave;
                j = j - h; k = k - h;
            end
        end
    end

    s = ""; l = ""
    do  i = 1 to n
        c = a.i
        if  c \= l then ,
            s = s c
        l = c
    end

    return space(s)

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

