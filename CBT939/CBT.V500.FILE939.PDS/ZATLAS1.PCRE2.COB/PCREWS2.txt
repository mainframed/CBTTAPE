      * this is a description of the working-storage section, common
      * needed variables.
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
      * While the original UNIX/Windows program now supports the
      *testing of both the 8-bit and 16-bit PCRE libraries in a single
      *program, the z/OS COBOL (and C) versions support only 8 bit
      *EBCDIC.  Modules such as COMPLIE8 (originally pcre_compile.c)
      *in the library itself, are also specifically compiled for 8 bit
      *EBCDIC.  It does, however, make use of SUPPORT_PCRE8 to ensure
      *that it calls only supported library functions.

      *****************************************************************
       01   PCREWS-NULL-PTR         USAGE POINTER VALUE NULL.
       01   PCREWS-RE-PTR           USAGE POINTER VALUE NULL.
       01   PCREWS-RE-I         redefines PCREWS-RE-PTR pic 9(9) comp.
       01   PCREWS-PATTERN-PTR      USAGE POINTER VALUE NULL.
       01   PCREWS-SUBJECT-PTR      USAGE POINTER VALUE NULL.
       01   PCREWS-REPL-PTR         USAGE POINTER VALUE NULL.
       01   PCREWS-NAME-TABLE       USAGE POINTER VALUE NULL.
       01   PCREWS-ovector          USAGE POINTER VALUE NULL.
       01   PCREWS-start-offset     pic s9(9) binary value 0.

       01   PCREWS-OPTION-BITS      PIC 9(9) COMP.
       01   PCREWS-OPTION-BITS-X    REDEFINES
                                    PCREWS-OPTION-BITS PIC X(4).
       01   PCREWS-crlf-is-newline  PIC S9(8) COMP.
       01   PCREWS-errornumber      PIC S9(8) COMP.
       01   PCREWS-find-all         PIC S9(8) COMP.
       01   PCREWS-NAMECOUNT        PIC S9(8) COMP.
       01   PCREWS-NAME-ENTRY-SIZE  PIC S9(8) COMP.
       01   PCREWS-RC               PIC S9(8) COMP.
       01   PCREWS-UTF8             PIC S9(8) COMP.
       01   PCREWS-newline          PIC 9(9) COMP.
       01   PCREWS-ERROROFFSET      PIC 9(9) COMP.

       01   PCREWS-subject-length   PIC S9(9) COMP.
       01   PCREWS-repl-length      PIC S9(9) COMP.
       01   PCREWS-match-data       USAGE POINTER VALUE NULL.
       01   PCREWS-output           USAGE POINTER VALUE NULL.
       01   pcrews-outlength        PIC S9(9) COMP.

      * The original C does pointer arithmetic.  COBOL usees
      * reference modification, so the below is a number, not pointer.
       01   PCREWS-substring-start       PIC 9(9) COMP.
       01   PCREWS-substring-length      PIC 9(9) COMP.
