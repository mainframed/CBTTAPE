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
_dbg = .true

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

    if  __optflg("class",  "class",     "--table", ".false") then ,
        iterate
    if  __optflg("class",  "class",     "-class", ".true") then ,
        iterate

    if  __optflg("static",  "static",   "--static --public", ".true") then ,
        iterate
    if  __optflg("static",  "static",   "--private", ".false") then ,
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

if  _dbg then do
    say "*****" left("lang",   10)  lang
    say "*****" left("static", 10)  static
    say "*****" left("class",  10)  class
    say "*****" left("CPfr",   10)  CPfr
    say "*****" left("CPto",   10)  CPto
    say "*****" left("wget",   10)  wget
    say "*****" left("repo",   10)  CPrepo
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
Address HOSTEMU "EXECIO * DISKR '"frSrc"' ( stem frSrc. finis "
if  RC \= 0 then do
    call __log "Error Processing" "'"frSrc"'"
    call __leave
    exit
end

call checkCP "to"
Address HOSTEMU "EXECIO * DISKR '"toSrc"' ( stem toSrc. finis "
if  RC \= 0 then do
    call __log "Error Processing" "'"toSrc"'"
    call __leave
    exit
end

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

chars = 0
do  c = 1 to toSrc.0
    Buff = space(toSrc.c)
    if  left(Buff,2) = "/*" then ,
        leave
    if  Buff = "" then ,
        iterate
    if  left(Buff,1) = "*" then ,
        iterate
    if  words(Buff) < 2 then ,
        iterate

    chars +=1
    parse var buff hex sym .

    toCHR.sym = hex

end
call __log  "To table '"CPto"' contains '"chars"' chars"

--do  sym over toCHR.
--    say sym tochr.sym
--end


tabl = copies(x2c(toCHR.SP010000), 256)

chars = 0
do  c = 1 to frSrc.0
    Buff = space(frSrc.c)
    if  left(Buff,2) = "/*" then ,
        leave
    if  Buff = "" then ,
        iterate
    if  left(Buff,1) = "*" then ,
        iterate
    if  words(Buff) < 2 then ,
        iterate

    chars +=1

    parse var buff hex sym .

    if  symbol("toCHR."sym) \= "VAR" then ,
        iterate

    tabl = overlay(x2c(toCHR.sym),tabl,x2d(hex)+1)

end

call __log  "From table '"CPfr"' contains '"chars"' chars"

if  lang \= "none" then ,
    if  \__open(TBds,"wr") then do
        call __log "Error opening" "'"TBds"'"
        call __leave
        exit
    end

interpret "call TBwrite_"lang

if  lang \= "none" then do
    call __close TBds
    call __log "table '"TBnm"' created in '"TBds"'"
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

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
checkCP:
    parse arg _CP_

    interpret ,
    "if  \haveCP"_CP_" then do ; " ,
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

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
TBwrite_none:
    do  i = 1 to 256 by 16
        call __log ">>"c2x(substr(tabl,i,16))"<<"
    end
    return

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
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

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
TBwrite_c:

    if  class then do
        offs = '    '
        call lineout TBds, '#ifndef _'upper(TBnm)'_C_'
        call lineout TBds, '#define _'upper(TBnm)'_C_'

        if  static then ,
            call lineout TBds, 'static'

        call lineout TBds, 'unsigned char'
        call lineout TBds, TBnm '( const unsigned ch)'
        call lineout TBds, '{'
        call lineout TBds, offs || 'unsigned char'
        call lineout TBds, offs || 'tabl[] = {'
    end
    else do
        offs = ''
        call lineout TBds, '#ifndef _'upper(TBnm)'_H_'
        call lineout TBds, '#define _'upper(TBnm)'_H_'

        if  static then ,
            call lineout TBds, offs || 'static'

        call lineout TBds, offs || 'unsigned char'
        call lineout TBds, TBnm'[] = {'
    end

    rulr = '    /* 0   1   2   3   4   5   6   7   8   9   A   B   C   D   E   F        */'
    call lineout TBds, offs || rulr
    head = '    "'
    tail = '"'
    do  i = 1 to 256 by 16
        body = ''
        do  j = 1 to 16
            body = body'\x'c2x(substr(tabl,i+j-1,1))
        end
        call lineout TBds, offs || head || body || tail '/*' d2x((i-1)%16) '*/'
    end
    call lineout TBds, offs || rulr

    call lineout TBds, offs || '} ;'

    if  class then do
        call lineout TBds, ''
        call lineout TBds, offs || 'return ( tabl[ch] ) ;'
        call lineout TBds, ''
        call lineout TBds, '} ;'

    end

    call lineout TBds, '#endif'

    return

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
::requires hostemu LIBRARY
::requires  "esmcutil.cls"
