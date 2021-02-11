      ****************************************************************
      * This file is a copybook, intended as a nested program to     *
      * display a memory dump of up to 4k bytes.  It could be        *
      * compiled independently and called a normal subroutine as well*
      * Calling the dumpmem routine:                                 *
      * call 'dumpmem' using string-variable length end-call         *
      * Where                                                        *
      * whatever is some number and length is how many bytes you want*
      * to display                                                   *
      * 01 string-variable      pic x(whatever).                     *
      * 01 length               pic s9(9) comp-5.                    *
      ****************************************************************
      *
      * Copyright (c) 2015 Ze'ev Atlas
      * Please refer to the LICENSE document to see all other
      * applicable copyrights.
      *
      *---------------------------------------------------------------
      *Redistribution and use in source and binary forms, with or
      *without modification, are permitted provided that the following
      *conditions are met:

      * 1. Redistributions of source code must retain the above
      * copyright notice, this list of conditions and the following
      * disclaimer.

      * 2. Redistributions in binary form must reproduce the above
      * copyright notice, this list of conditions and the following
      * disclaimer in the documentation and/or other materials
      * provided with the distribution.

      * 3. Neither the name of Ze'ev Atlas nor the names of other
      * contributors may be used to endorse or promote
      * products derived from this software without specific prior
      * written permission.

      *THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
      *CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
      *INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
      *MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
      *DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
      *CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
      *SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
      *NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
      *LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
      *HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
      *CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
      *OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
      *EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
      ****************************************************************
       identification division.
       PROGRAM-ID.  'DUMPMEM'.
      * limited to display 4k bytes
       data division.
       working-storage section.
       01 i          pic s9(9) comp-5.
       01 j          pic s9(9) comp-5.
       01 k          pic s9(9) comp-5.
       01 l          pic s9(9) comp-5.
       01 xj         pic s9(9) comp-5.
       01 low-printable  pic s9(4) comp-5 value 31.
       01 endianess      pic s9(4) comp-5 value 1.
       01 len-max    pic s9(9) comp-5 value 4096.
       01 x          pic x(4).
       01 xi         redefines x pic s9(9) comp-5.
       01 hextab     pic x(16) value '0123456789ABCDEF'.
       01 buff       pic x(66).
       01 ASCII-EBCDIC    pic x value '1'.
          88 it-is-ebcdic value x'f1'.
       linkage section.
       01 datax      pic x(4096).
       01 len        pic s9(9) comp-5.
       procedure division using datax len.
      * a crude way to decide ascii/ebcdic and endianess
           if it-is-ebcdic
              move 63 to low-printable
              move 4 to endianess
           end-if
           move 4096 to len-max
           if len > len-max
              display 'limiting dump to 4k'
      *       move 4096 to len-max
           else
              move len to len-max
           end-if
           move spaces to buff
           move 1 to j
           move 49 to k
           move '|' to buff(k:1)
           add 1 to k
           perform varying i from 1 by 1 until i > len-max
              move low-values to x
              move datax (i:1) to x(endianess:1)
      * a crude way to prevent displaying control characters
              if xi > low-printable and xi < 255
                 move datax (i:1) to buff(k:1)
              else
                 move '.' to buff(k:1)
              end-if
              divide xi by 16 giving xj
              add 1 to xj giving l
              move hextab(l:1) to buff(j:1)
              add 1 to j
              multiply xj by 16 giving xj
              subtract xj from xi giving xi
              add 1 to xi giving l
              move hextab (l:1) to buff (j:1)
              add 2 to j
              add 1 to k
              if j > 47 or i + 1 > len-max
                  display buff
                  move spaces to buff
                  move 1 to j
                  move 49 to k
                  move '|' to buff(k:1)
                  add 1 to k
              end-if
           end-perform.
       END PROGRAM 'DUMPMEM'.

