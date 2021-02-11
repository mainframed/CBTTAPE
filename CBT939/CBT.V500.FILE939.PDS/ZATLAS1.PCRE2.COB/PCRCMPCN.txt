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
      * The real compile context structure

       01  :PREFIX:-pcre2-compile-context.
      * memctl;
           COPY PCRMECTL.
           05  :PREFIX:-stack-guard          USAGE POINTER.
           05  :PREFIX:-stack-guard-data     USAGE POINTER.
           05  :PREFIX:-tables               USAGE POINTER.
           05  :PREFIX:-max-pattern-length   PIC 9(4) COMP.
           05  :PREFIX:-bsr-convention       PIC 9(4) COMP.
           05  :PREFIX:-newline-convention   PIC 9(4) COMP.
           05  :PREFIX:-parens-nest-limit    PIC 9(9) COMP.
           05  :PREFIX:-extra-options        PIC 9(9) COMP.
