/* REXX -- compare two parameters and exit with RC */
 Arg parm
 Select
 When arg() > 1 Then Do
    par.1   = "STRIP"(arg(1))
    par.2   = "STRIP"(arg(2))
    end
 When "POS"(',',parm) > 0 Then Do
    Parse Var parm par.1 ',' par.2
    par.1   = "STRIP"(par.1)
    par.2   = "STRIP"(par.2)
    End
 Otherwise Do
    par.1   = "WORD"(parm,1)
    par.2   = "WORD"(parm,2)
    End
 End
/* Check the parameters: */
 If par.1 = par.2 Then EXIT(0)
 Else EXIT(8)
