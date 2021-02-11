#!/usr/bin/rexx
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
/* Name : <filename>                                                               */
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
/* This work is     "Copyright (c) 2012-2013 Enrico Sorichetti"                    */
/* Licensed under a "Creative Commons Attribution-ShareAlike 3.0 Unported License" */
/* Human readable   "http://creativecommons.org/licenses/by-sa/3.0/deed.en_US"     */
/* Legalese         "http://creativecommons.org/licenses/by-sa/3.0/legalcode"      */
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

Trace "O"
signal on novalue name novalue
numeric digits 12

parse source _src
parse lower var _src _sys _env _cmd .

if  pos("windows",lower(_sys)) > 0 then ,
    .local~psep = "\"
else ,
    .local~psep = "/"

z = filespec("n",_cmd)
parse var z .local~self "." .

.local~cpyr.0 = 0
.local~cpyr.1 = 'This work is     "Copyright (c) 2012-2013 Enrico Sorichetti"'
.local~cpyr.2 = 'Licensed under a "Creative Commons Attribution-ShareAlike 3.0 Unported License"'
.local~cpyr.3 = 'Human readable   "http://creativecommons.org/licenses/by-sa/3.0/deed.en_US"'
.local~cpyr.4 = 'Legalese         "http://creativecommons.org/licenses/by-sa/3.0/legalcode"'

parse arg _args
_args = space(_args) "ffffffff"x
_argc = words(_args)

call time("R")
call __start

CPrepo = "."

langtabl = "none    rexx    c "
sufftabl = ".txt    .cls    .h "

lang = "rexx"
suff = ".cls"

callwget = "wget -q -t 2 -T 30 -w 30 "
wgethost = "ftp://ftp.software.ibm.com/software/globalization/gcoc/attachments/"

iarg = 0
args = ""
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

    if  __optstr("lang",    "lang",     "-L --lang") then ,
        iterate

    if  __optflg("static",  "static",   "-P --private", ".false") then ,
        iterate
    if  __optflg("static",  "static",   "-G --public", ".true") then ,
        iterate

    if  __optnum("CPfr",    "CPfr",     "-F --from") then ,
        iterate

    if  __optnum("CPto",    "CPto",     "-T --to") then ,
        iterate

    if  __optflg("wget",    "wget",     "-W --wget", ".true") then ,
        iterate

    if  __optstr("repo",    "CPrepo",   "-R --repo") then ,
        iterate

    if  left(optc,1) = "-" then do
        call __log  "Unknown option : '"optc"' "
        iarg += 1
        iterate
    end

    args = args optc
    iarg += 1

end

argc = words(args)

if  argc \= 0 then ,
    call __log  "positional arguments ignored "

if  \havelang then ,
    call __log  "Language not specified defaulting to " "'"lang"'"

if  (wordpos(lang, langtabl) = 0) then do
    call __log  "Unsupported language " "'"lang"'"
    call __leave
    exit
end
else ,
    suff = word(sufftabl, wordpos(lang, langtabl))

if  haverepo then do
    if  \__isPAth(CPrepo) then do
        call __log  "CP repository not found or invalid" "'"CPrepo"'"
        call __leave
        exit
    end
end

call checkCP "fr"

call checkCP "to"

TBnm = lower(CPfr || "_TO_" || CPto)
TBds = lower(TBnm || suff)
if  lang = "none" then ,
    call __log  "Displaying translate table " "'"TBnm"'"
else ,
    call __log  "Building translate table " "'"TBnm"'" "for" "'"lang"'"

if  \__open(toSrc,"r") then do
    call __log "Error opening" "'"toSrc"'"
    call __leave
    exit
end

toCHARS = 0
do  toLines = 1 while (lines(toSrc) > 0 )
    tobuff = space(linein(toSrc))
    if  left(toBuff,2) = "/*" then ,
        leave
    if  toBuff = "" then ,
        iterate
    if  left(toBuff,1) = "*" then ,
        iterate
    if  words(toBuff) < 2 then ,
        iterate

    tochars +=1
    parse var tobuff hex sym .

    toCHR.sym = hex

end
call __close toSrc
call __log  "To table '"CPto"' contains '"tochars"' chars"

--do  sym over toCHR.
--    say sym tochr.sym
--end


if  \__open(frSrc,"r") then do
    call __log "Error opening" "'"frSrc"'"
    call __leave
    exit
end

tabl = copies(x2c(toCHR.SP010000), 256)

frChars = 0
do  frLines = 1 while (lines(frSrc) > 0 )
    frbuff = space(linein(frSrc))
    if  left(frBuff,2) = "/*" then ,
        leave
    if  frBuff = "" then ,
        iterate
    if  left(frBuff,1) = "*" then ,
        iterate
    if  words(frBuff) < 2 then ,
        iterate

    frChars +=1

    parse var frbuff hex sym .

    if  symbol("toCHR."sym) \= "VAR" then ,
        iterate

    tabl = overlay(x2c(toCHR.sym),tabl,x2d(hex)+1)

end
call __close frSrc
call __log  "From table '"CPfr"' contains '"frChars"' chars"

if  lang \= "none" then ,
    if  \__open(TBds,"wr") then do
        call __log "Error opening" "'"TBds"'"
        call __leave
        exit
    end

interpret "call TBwrite_"lang

if  lang \= "none" then ,
    call __close TBds

call __log "table '"TBnm"' created in '"TBds"'"

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
    "if wordpos(optc,_opts_) > 0 then do " "; " ,
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
    "if wordpos(optc,_opts_) > 0 then do " "; " ,
        "if have"_optf_" then do " "; " ,
            "call __log  ""option : '"optc"' Already specified"" " "; " ,
            "call __leave " "; " ,
            "exit " "; " ,
        "end " "; " ,
        "else do " "; " ,
            "if  argv = 'ffffffff'x | " ,
                "left(argv,1) = ""-"" then do"  "; " ,
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
__optnum:
    use strict arg _optf_, _optv_, _opts_
    if  symbol("have"_optf_) \= "VAR" then ,
        interpret "have"_optf_" = .false "
    if  symbol(_optv_) \= "VAR" then ,
        interpret _optv_" = 0 "

    interpret ,
    "if wordpos(optc,_opts_) > 0 then do " "; " ,
        "if have"_optf_" then do " "; " ,
            "call __log  ""option : '"optc"' Already specified"" " "; " ,
            "call __leave " "; " ,
            "exit " "; " ,
        "end " "; " ,
        "else do " "; " ,
            "if  argv = 'ffffffff'x | " ,
                "left(argv,1) = ""-"" then do"  "; " ,
                "call __log  ""option : '"optc"' requires an argument"" " "; " ,
                "call __leave" "; " ,
                "exit" "; " ,
            "end" "; " ,
            "if datatype(argv) \= ""NUM"" then do" "; " ,
                "call __log  ""option : '"optc"' requires a numeric argument, was '"argv"'"" " "; " ,
                "call __leave" "; " ,
                "exit" "; " ,
            "end" "; " ,
            "have"_optf_" = .true " "; " ,
            _optv_" = argv " "; " ,
            "iarg += 2 " "; " ,
            "return .true " "; " ,
        "end " "; " ,
    "end " "; "
    return .false

checkCP:
    parse arg _CP_
    interpret   "if  \haveCP"_CP_" then do ; " ,
                "    call __log  ""'"_CP_"' CodePage not specified"" ; " ,
                "    call __leave ; " ,
                "    exit ; " ,
                "end ; " ,
                "if  datatype(CP"_CP_") \= ""NUM"" then do ; " ,
                "    call __log  ""Invalid From CodePage"" ""'""CP"_CP_"""'"" ; " ,
                "    call __leave ; " ,
                "    exit ; " ,
                "end ; " ,
                "CP"_CP_" = ""CP"" || right(CP"_CP_",5,""0"") ; " ,
                ""_CP_"Src = CPrepo || .local~psep || CP"_CP_""".txt"" ; " ,
                "if  \__exists("_CP_"Src)then do ; " ,
                "    if  \wget then do ; " ,
                "        call __log  ""'"_CP_"' CodePage not found"" ""'""CP"_CP_"""'"" ; " ,
                "        call __leave ; " ,
                "        exit ; " ,
                "    end ; " ,
                "    else do ; " ,
                "        call __log  ""Downloading"" ""'""CP"_CP_"""'"" ""from "" wgethost ; " ,
                "        callwget wgethost""//""CP"_CP_""".txt"" ""-O"" "_CP_"Src ; " ,
                "        if  RC \= 0 then do ; " ,
                "            call __log  ""Error downloading"" ""'""CP"_CP_"""'"" ; " ,
                "            call __leave ; " ,
                "            exit ; " ,
                "        end ; " ,
                "    end ; " ,
                "end ; "
    return


TBwrite_none:
    do  i = 1 to 256 by 16
        call __log ">>"c2x(substr(tabl,i,16))"<<"
    end
    return

TBwrite_rexx:
    rulr = copies(" ",length(Tbnm)) " /* 0 1 2 3 4 5 6 7 8 9 A B C D E F              */"
    call lineout TBds, rulr

    head = TBnm ' = "'
    tail = '"x || ,'
    do  i = 1 to 256 by 16
        if  d2c(i-1) = "f0"x then ,
            tail = left('"x',length(tail))
        call lineout TBds, head || c2x(substr(tabl,i,16)) || tail "/*" d2x((i-1)%16) "*/"
        head = right('"',length(head))
    end
    call lineout TBds, rulr

    return

/* */

TBwrite_c:

    call lineout TBds, "#ifndef _"upper(TBnm)"_H_"
    call lineout TBds, "#define _"upper(TBnm)"_H_"

    if  static then ,
        call lineout TBds, "static unsigned char"
    else ,
        call lineout TBds, "unsigned char"
    call lineout TBds, TBnm'[] = {'
    rulr = "/*     0   1   2   3   4   5   6   7   8   9   A   B   C   D   E   F        */"
    call lineout TBds, rulr
    head = '    "'
    tail = '"'
    do  i = 1 to 256 by 16
        body = ""
        do  j = 1 to 16
            body = body"\x"c2x(substr(tabl,i+j-1,1))
        end
        call lineout TBds, head || body || tail "/*" d2x((i-1)%16) "*/"
    end
    call lineout TBds, rulr

    call lineout TBds, '    } ;'

    call lineout TBds, "#endif"

    return

/*
TBwrite_c:

    call lineout TBds, "#ifndef _"upper(TBnm)"_H_"
    call lineout TBds, "#define _"upper(TBnm)"_H_"

    head = TBnm'[] = { "'
    tail = '"'
    do  i = 1 to 256 by 16
        body = ""
        do  j = 1 to 16
            body = body"\x"c2x(substr(tabl,i+j-1,1))
        end
        if  d2c(i-1) = "f0"x then ,
            tail = '" }'
        call lineout TBds, head || body || tail
        head = right('"',length(head))
    end

    call lineout TBds, "#endif"

    return
*/

ifdef:

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
::requires  "esmcutil.cls"
