      * This is a partial port of a private header (pcre2_intmodedep.h)
      * file for the PCRE library to COBOL.  It is to be COPIED by
      * applications that call the PCRE functions.
      * Version 0.2
      * Contributed by:   Ze'ev Atlas  2015.
      * Copyright (c) 2015, Ze'ev Atlas.
      * All rights reserved.

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

      * 3. Neither the name of the University of Cambridge nor the
      * names of its contributors may be used to endorse or promote
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
      *---------------------------------------------------------------
      *
      * The real match data structure. Define ovector as large as it
      * can ever actually be so that array bound checkers don't
      * grumble. Memory for this structure is obtained by calling
      * pcre2_match_data_create(), which sets the size as the
      * offset of ovector plus a pair of elements for each
      * capturable string, so the size varies from call to call.
      * As the maximum number of capturing subpatterns is 65535 we
      * must allow for 65536 strings to include the overall match.
      * (See also the heapframe structure below.)

       01  :PREFIX:-pcre2-match-data.
      * memctl;
           COPY PCRMECTL.
      * The pattern used for the match
           05  :PREFIX:-code          USAGE POINTER.
      * The subject that was matched
           05  :PREFIX:-subject       USAGE POINTER.
      * Pointer to last mark
           05  :PREFIX:-mark          USAGE POINTER.
      * Offset to leftmost code unit
           05  :PREFIX:-leftchar      PIC 9(9) COMP.
      * Offset to rightmost code unit
           05  :PREFIX:-rightchar     PIC 9(9) COMP.
      * Offset to starting code unit
           05  :PREFIX:-startchar     PIC 9(9) COMP.
      * Type of match (normal, JIT, DFA)
      * There is no uint8_t in COBOL
           05  :PREFIX:-matchedby     PIC X.
           05  :PREFIX:-flags         PIC X.
      * Number of pairs
           05  :PREFIX:-oveccount     PIC 9(4) COMP.
      * The return code from the match
           05  :PREFIX:-rc           PIC 9(9) COMP.
      * The first field */
           05  :PREFIX:-ovector      PIC 9(9) COMP OCCURS 1.

