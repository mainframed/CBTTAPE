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

iarg = 0; args = ""
do  while ( iarg < _argc )

    if  iarg = 0 then do
        optc = ""; argv = ""
    end
    else do
        optc = word(_args, iarg); argv = word(_args, iarg+1)
    end

    if  optc = "-H" | ,
        optc = "--help" then do
            call __log "*** have a nice read ***"
            do  s = 1 to sourceline()
                call __log sourceline(s)
            end
        exit
    end

    if  __optflg("ext", "ext", "--noext", ".false") then ,
        iterate

    if  __optflg("flg", "flg", "--flg -F", ".true") then ,
        iterate

    if  __optflg("flg", "flg", "--noflg", ".false") then ,
        iterate

    if  __optstr("str", "str", "--str -S") then ,
        iterate

    if  __optnum("num", "num", "--num -N") then ,
        iterate

    if  left(optc,1) = "-" then do
        call __log  "Unknown option : '"optc"' "
        iarg += 1
        iterate
    end

    args = strip(args optc)
    iarg += 1

end

call __log " ext = >>"ext"<<"
call __log " flg = >>"flg"<<"
call __log " str = >>"str"<<"
call __log " num = >>"num"<<"

args = __argsort(args)
argc = words(args)

do iarg = 1 to argc
    argv = word(args, iarg)
    say ""
    call __log "processing: " iarg argv
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
/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

::requires  "esmcutil.cls"
