/* rexx */
/*************************************************************/
/*  Because CALC is an ISPF TSO command supplied by IBM,     */
/*  this REXX exec must be renamed or invoked using a        */
/*  a percent sign as follows:                               */
/*     "TSO  %CALC"                                          */
/*************************************************************/
numhexdigits = 8                                /* set default for # of
                                                   hex digits to use  */
numdigits = 10                                  /* set default for # of
                                                   significant digits to
                                                   be used in numeric
                                                   operations         */
numeric digits numdigits                        /* set numeric digits */
say  'REXX Calculator active!'                  /* display msg        */
hexmode = 'OFF'                                 /* hex off initially  */
prompt = ' Enter input, "END", or "?" for help.'  /* init prompt msg  */
do forever                                      /* do till no input   */
  if hexmode = 'OFF' then                       /* display prompt msg */
    say 'CALC (Decimal mode) - 'prompt
  else
    say 'CALC (Hex mode) - 'prompt
Signal On Syntax                                /* error condition    */
  parse upper external input                    /* get calc input     */
  select                                        /* select on input    */
    when input = '?'   then call helpme         /* call for help      */
    when input = 'HEX' then hexmode = 'ON'      /* turn on hex mode   */
    when input = 'DEC' then hexmode = 'OFF'     /* turn on dec mode   */
    when input = 'END' then leave               /* exit               */
    when input = ''    then iterate             /* re-prompt for input*/
    otherwise do
      drop decans                               /* reset output value */
      drop hexans                               /* reset output value */
      if hexmode = 'OFF' then
        call calcdec                            /* call decimal rtn   */
      else                                      /* do hex processing  */
        call calchex
    end                                         /* end otherwise      */
  end                                           /* end of select      */
end                                             /* get more input     */
say 'REXX Calculator ending.'                   /* display exit msg   */
exit                                            /* exit from program  */
calcdec: procedure expose input numdigits numhexdigits
  if verify(input,'1234567890E+-*/% ().')=0 then /* verify input      */
    do
      interpret decans ' = 'input '+ 0'         /* compute output     */
      decans = decans +0                        /* add 0 in case only a
                                                   single # is given.
                                                   This will force it to
                                                   scientific mode if
                                                   the result is large*/
      hexans = dec2hex(decans)                  /* get hex equivalent */
      if hexans = '' then                       /* check for hex rslt */
        hexdisp = '(Hex equivalent not available)'     /* no hex msg  */
      else hexdisp = '('||hexans||' hex)'       /* hex result msg     */
      input = ''''||input||''''                 /* put quotes around the
                                                   input so it can be
                                                   passed as one parm */
       say  'CALC ' input '=' decans hexdisp
    end
  else say 'CALC Invalid input. Enter "?" for help.'
return
calchex: procedure expose input numdigits numhexdigits
  numeric digits numdigits*2                    /* need to increment the
                                                   numeric digits so
                                                   x2d will work      */
  if verify(input,'1234567890ABCDEF+-*/% ()')=0 then /* verify input  */
    do
      decstr = ''                               /* init decimal equiv */
      toobig = 'NO'                             /* init toobig flag   */
      nxtinput = input                          /* init next string   */
      do until length(nxtinput)=0               /* do till no more    */
        nonhex = verify(nxtinput,'1234567890ABCDEF')/* find nonhex chr*/
        if nonhex=0 then nonhex=length(nxtinput)+1 /* set to str end  */
        if nonhex=1 then                        /* if next symbol is not
                                                   a number, append it*/
          decstr = decstr || substr(nxtinput,1,1)
        else                                    /* otherwise, append the
                                                   decimal equivalent #,
                                                   plus the next oper */
          if nonhex > numhexdigits +1 then      /* check input # size */
            toobig = 'YES'                      /* set too big flag   */
          else                                  /* size is ok         */
            decstr=decstr||x2d(substr(nxtinput,1,nonhex-1))||,
                   substr(nxtinput,nonhex,1)
        nxtinput=substr(nxtinput,nonhex+1)      /* reset next string  */
      end                                       /* end do till no more*/
      if toobig = 'YES' then                    /* if input too big   */
         say 'CALC Input number too large for calculations.'
      else                                      /* input OK, get hex  */
        do
          numeric digits numdigits              /* reset numeric digit*/
          interpret 'decans ='decstr            /* compute dec result */
          decans = decans +0                    /* add 0 in case only a
                                                   single # is given.
                                                   This will force it to
                                                   scientific mode if
                                                   the result is large*/
          hexans = dec2hex(decans)              /* get hex equivalent */
          if hexans = '' then                   /* display results    */
            hexans = 'Hex result not available.'
          input = ''''||input||''''             /* put quotes around the
                                                   input so it can be
                                                   passed as one parm */
           say 'CALC 'input '=' hexans,
              '('decans' decimal)'
        end
    end
    else say 'CALC Invalid input. Enter "?" for help.'
return
dec2hex: procedure expose numdigits numhexdigits
  parse arg decans
  if index(decans,'E') > 0 then return ''       /* exponent is too big*/
  if index(decans,'.') > 0 then do              /* fractional value?  */
                                                /* since n.0 = n, strip
                                                   off the '.0' so that
                                                   the value can be
                                                   converted to hex   */
    decans = strip(decans,'T','0')              /* strip trailing 0's */
    decans = strip(decans,'T','.')              /* strip trailing '.' */
  end
  if index(decans,'.') > 0,                     /* if fraction        */
   | decans > x2d('FFFFFFFF'),                  /* or too big         */
   | (decans < 0 & decans < x2d('F0000000',8)), /* or too small       */
      then return ''                            /* don't convert      */
  if decans < 0 then                            /* if negative #      */
    hexans = d2x(decans,numhexdigits)           /* convert neg value  */
  else
    hexans = d2x(decans)                        /* convert to hex     */
  return hexans                                 /* return hex value   */
Syntax:                                         /* error              */
Select
When rc=42 Then Do                              /* return code 42     */
 Say ERRORTEXT(rc)                              /* display message    */
 Say 'Either the number is too big (infinity)',
   'or division by ''0'' was attempted'         /* display 2nd message*/
End
Otherwise Do
 Say ERRORTEXT(rc)                              /* other return code  */
End
End
Return
Helpme:
say '                                                                 '
say ' o When you enter CALC you are in decimal mode. To switch to     '
say '   hexadecimal mode enter "HEX". To switch back to decimal mode  '
say '   enter "DEC".                                                  '
say '                                                                 '
say ' o Enter a valid REXX arithmetic expression. Valid functions are:'
say '   + (add), - (subtract), * (multiply, / (divide returning       '
say '   decimal quotient), % (divide returning intiger quotient),     '
say '   // (divide returning remainder), and ** (exponentiation).     '
say '   EXAMPLES: 3+4 ; 543-32; 100*22 ; 250/5 ; 3+(100/20)*3.4       '
say '                                                                 '
say ' o Results are given in both decimal and hexadecimal. Decimal    '
say '   results that are not whole numbers are not converted to       '
say '   hexadecimal.                                                  '
say '                                                                 '
say ' o Decimal results greater than ten billion are displayed in     '
say '   scientific notation. Negative hexadecimal results are         '
say '   displayed to 8 places.                                        '
say '                                                                 '
say '                                                                 '
Return
