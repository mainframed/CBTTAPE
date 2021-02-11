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
      * The real compiled code structure. The type for the blocksize
      * field is defined specially because it is required in
      * pcre2_serialize_decode() when copying the size from possibly
      * unaligned memory into a variable of the same type. Use a macro
      * rather than a typedef to avoid compiler warnings when this
      * file is included multiple times by pcre2test.

      * CODE_BLOCKSIZE_TYPE size_t

       01  :PREFIX:-pcre2-code.
      * memctl;            Memory control fields
           COPY PCRMECTL.
      * The character tables
           05  :PREFIX:-tables              USAGE POINTER.
      * Pointer to JIT code */
           05  :PREFIX:-executable-jit      USAGE POINTER.
      * Bitmap for starting code unit < 256
           05  :PREFIX:-start-bitmap        PIC X OCCURS 32.
      * CODE_BLOCKSIZE_TYPE  Total (bytes) that was malloc-ed
           05  :PREFIX:-blocksize           PIC 9(9) COMP.
      * Paranoid and endianness check */
           05  :PREFIX:-magic-number        PIC 9(9) COMP.
      * Options passed to pcre2_compile() */
           05  :PREFIX:-compile-options     PIC 9(9) COMP.
      * Options after processing the pattern */
           05  :PREFIX:-overall-options     PIC 9(9) COMP.
      * Various state flags */
           05  :PREFIX:-flags               PIC 9(9) COMP.
      * Limit set in the pattern */
           05  :PREFIX:-limit-heap          PIC 9(9) COMP.
      * Limit set in the pattern */
           05  :PREFIX:-limit-match         PIC 9(9) COMP.
      * Limit set in the pattern */
           05  :PREFIX:-limit-depth         PIC 9(9) COMP.
      * Starting code unit */
           05  :PREFIX:-first-codeunit      PIC 9(9) COMP.
      * This codeunit must be seen */
           05  :PREFIX:-last-codeunit       PIC 9(9) COMP.
      * What \R matches */
           05  :PREFIX:-bsr-convention      PIC 9(9) COMP.
      * What is a newline? */
           05  :PREFIX:-newline-convention  PIC 9(9) COMP.
      * Longest lookbehind (characters) */
           05  :PREFIX:-max-lookbehind      PIC 9(9) COMP.
      * Minimum length of match */
           05  :PREFIX:-minlength           PIC 9(9) COMP.
      * Highest numbered group */
           05  :PREFIX:-top-bracket         PIC 9(9) COMP.
      * Highest numbered back reference */
           05  :PREFIX:-top-backref         PIC 9(9) COMP.
      * Size (code units) of table entries */
           05  :PREFIX:-name-entry-size     PIC 9(9) COMP.
      * Number of name entries in the table */
           05  :PREFIX:-name-count          PIC 9(9) COMP.
