      * This is a partial port of the public header (pcre2.h) file for
      * the PCRE library to COBOL.  It is to be COPIED by applications
      * that call the PCRE functions.
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
      * The structures for passing out data via callout functions.
      * We use structures so that new fields can be added on the end
      * in future versions, without changing the API of the function,
      * thereby allowing old clients to work without modification.
      * Define the generic versions in a macro; the width-specific
      * is always 8 in z/OS EBCDIC.

       01 PCRE2-CALLOUT-STARTMATCH-x PIC X(4) VALUE    x'00000001'.
       01 PCRE2-CALLOUT-STARTMATCH
             REDEFINES PCRE2-CALLOUT-STARTMATCH-x PIC 9(9) COMP.
       * Set for each bumpalong
       01 PCRE2-CALLOUT-BACKTRACK-x  PIC X(4) VALUE    x'00000002'.
       01 PCRE2-CALLOUT-BACKTRACK
             REDEFINES PCRE2-CALLOUT-BACKTRACK-x PIC 9(9) COMP.
      * Set after a backtrack

       01 :PREFIX:-pcre2-callout-block.
      * Identifies version of block
           05 :PREFIX:-version                 PIC 9(9) COMP.
      * ------------------------ Version 0 ---------------------------
      * Number compiled into pattern
           05 :PREFIX:-callout-number          PIC 9(9) COMP.
      * Max current capture
           05 :PREFIX:-capture-top             PIC 9(9) COMP.
      * Most recently closed capture
           05 :PREFIX:-capture-last            PIC 9(9) COMP.
      * The offset vector -
           05 :PREFIX:-offset-vector           USAGE POINTER.
      * Pointer to current mark or NULL
           05 :PREFIX:-mark                    USAGE POINTER.
      * The subject being matched
           05 :PREFIX:-subject                 USAGE POINTER.
      * The length of the subject
           05 :PREFIX:-subject-length          PIC 9(9) COMP.
      * Offset to start of this match attempt
           05 :PREFIX:-start-match             PIC 9(9) COMP.
      * Where we currently are in the subject
           05 :PREFIX:-current-position        PIC 9(9) COMP.
      * Offset to next item in the pattern
           05 :PREFIX:-pattern-position        PIC 9(9) COMP.
      * Length of next item in the pattern
           05 :PREFIX:-next_item-length        PIC 9(9) COMP.
      * ------------------- Added for Version 1 ----------------------
      * Offset to string within pattern
           05 :PREFIX:-callout-string-offset   PIC 9(9) COMP.
      * Length of string compiled into pattern
           05 :PREFIX:-callout-string-length   PIC 9(9) COMP.
      * String compiled into pattern
           05 :PREFIX:-callout-string          USAGE POINTER.
      * --------------------------------------------------------------
      * ------------------- Added for Version 2 ----------------------
           05 :PREFIX:-callout_flags          PIC 9(9) COMP.
      * See above for list

       01 :PREFIX:-pcre2-callout-enumerate-block.
      * Identifies version of block */ \
           05 :PREFIX:-version                    PIC 9(9) COMP.
      * ------------------------ Version 0 ---------------------------
      * Offset to next item in the pattern */ \
           05 :PREFIX:-en-pattern-position        PIC 9(9) COMP.
      * Length of next item in the pattern */ \
           05 :PREFIX:-en-next_item-length        PIC 9(9) COMP.
      * Number compiled into pattern */ \
           05 :PREFIX:-en-callout-number          PIC 9(9) COMP.
      * Offset to string within pattern */ \
           05 :PREFIX:-en-callout-string-offset   PIC 9(9) COMP.
      * Length of string compiled into pattern */ \
           05 :PREFIX:-en-callout-string-length   PIC 9(9) COMP.
      * String compiled into pattern */ \
           05 :PREFIX:-en-callout-string          USAGE POINTER.
      * --------------------------------------------------------------

       01 :PREFIX:-pcre2-callout-enumerate-block.
      * Identifies version of block
           05 :PREFIX:-version                    PIC 9(9) COMP.
      * ------------------------ Version 0 ---------------------------
      * Offset to next item in the pattern
           05 :PREFIX:-pattern-position           PIC 9(9) COMP.
      * Length of next item in the pattern
           05 :PREFIX:-next-item-length           PIC 9(9) COMP.
      * Number compiled into pattern
           05 :PREFIX:-callout-number             PIC 9(9) COMP.
      * Offset to string within pattern
           05 :PREFIX:-callout-string-offset      PIC 9(9) COMP.
      * Length of string compiled into pattern
           05 :PREFIX:-callout-string-length      PIC 9(9) COMP.
      * String compiled into pattern
           05 :PREFIX:-callout-string             USAGE POINTER.
      * --------------------------------------------------------------

       01 :PREFIX:-pcre2_substitute_callout_block { \
      * Identifies version of block */ \
           05 :PREFIX:-version;
      * ------------------------ Version 0 ---------------------------
      * Pointer to input subject string
           05 :PREFIX:-input                      USAGE POINTER.
      * Pointer to output buffer
           05 :PREFIX:-output                     USAGE POINTER.
      * Changed portion of the output
           05 :PREFIX:-output-offsets  PIC 9(9) COMP   occurs 2.
      * Pointer to current ovector
           05 :PREFIX:-ovector                    USAGE POINTER.
      * Count of pairs set in ovector
           05 :PREFIX:-oveccount                  PIC 9(9) COMP.
      * Substitution number
           05 :PREFIX:-subscount                  PIC 9(9) COMP.
      * ---------------------------------------------------------------

