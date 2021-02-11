         MACRO
&NAME    MSG   &TEXT
         LCLA  &A
&A       SETA  K'&TEXT-2+4  SUBTRACT QUOTES, ADD PREFIX FOUR BYTES
&NAME    DC    H'&A',H'0',C&TEXT
         MEND
