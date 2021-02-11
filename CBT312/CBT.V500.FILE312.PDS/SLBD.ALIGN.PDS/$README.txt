ALIGN is an ISPF Edit Command (Macro) that will align text in the
active Edit (or View) session Left, Right, Center, or Reverse.

Row selection is using C or CC.

    Options:
    ? display help
    C ll - strip and center
    F ll - flow text to line length(ll)
    L - strip and left justify
    R - strip and right justify
    V - strip and reverse text

    Optional for C is ll for line length
    e.g. ALIGN C 65
         To align center for a width of 65

TFLOW is used by ALIGN.
