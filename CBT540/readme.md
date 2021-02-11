```
//***FILE 540 is from Sam Golob and contains his PARM and SYSIN     *   FILE 540
//*           scanner, adapted from the COPYMODS program in File    *   FILE 540
//*           229 of this tape.  The COPYMODS parm scanner is now   *   FILE 540
//*           a callable service.  So is the program which          *   FILE 540
//*           displays all the option bits, which the parm          *   FILE 540
//*           scanner has set, just so you can check that they've   *   FILE 540
//*           been set correctly.                                   *   FILE 540
//*                                                                 *   FILE 540
//*           Note:  This is a non-reentrant version of PARMCHEK    *   FILE 540
//*                  and a re-entrant program must LINK to it,      *   FILE 540
//*                  to preserve re-entrancy.  (Soon to be fixed,   *   FILE 540
//*                  I hope.)                                       *   FILE 540
//*                                                                 *   FILE 540
//*           This program, called PARMCHEK, will convert keywords  *   FILE 540
//*           in the PARM field of the EXEC card, and in the SYSIN  *   FILE 540
//*           ddname if present, into 5 bytes of bit settings,      *   FILE 540
//*           based on entries in a table.  It is possible to add   *   FILE 540
//*           user code, to handle keywords with values, and an     *   FILE 540
//*           example of such user code is included in the PARMCHEK *   FILE 540
//*           program.                                              *   FILE 540
//*                                                                 *   FILE 540
//*           PARMCHEK can be invoked as a separate CSECT that is   *   FILE 540
//*           linkedited into the calling program, or it may be     *   FILE 540
//*           invoked using a LOAD and BALR 14,15 as a separate     *   FILE 540
//*           program.  A sample program which invokes PARMCHEK     *   FILE 540
//*           with this logic, has been included, and it is called  *   FILE 540
//*           PARMDRVR.                                             *   FILE 540
//*                                                                 *   FILE 540
//*           A sample program to be linkedited with PARMCHEK       *   FILE 540
//*           as a sample driver is included as member PARMLINK.    *   FILE 540
//*                                                                 *   FILE 540
//*           There is also included, a program called SAMPOPTS     *   FILE 540
//*           which can display in the SYSPRINT file, all the       *   FILE 540
//*           options which have been set in the PARM flags,        *   FILE 540
//*           once PARMCHEK has "done its thing", and set its bits. *   FILE 540
//*                                                                 *   FILE 540
//*       Note:  Currently, PARMCHEK is not re-entrant, but         *   FILE 540
//*              it is hoped that this will be fixed shortly.       *   FILE 540
//*                                                                 *   FILE 540
//*     PARMCHEK program description:                               *   FILE 540
//*                                                                 *   FILE 540
//*     PURPOSE: This program converts keywords in a PARM           *   FILE 540
//*              field or in SYSIN, into bit settings that          *   FILE 540
//*              a program can use, to control options in           *   FILE 540
//*              its execution.                                     *   FILE 540
//*                                                                 *   FILE 540
//*              This program can be run as a subroutine            *   FILE 540
//*              which is called, to set up to 5 bytes of           *   FILE 540
//*              bits, up to 40 bits in all, based on the           *   FILE 540
//*              settings of keywords in a table.                   *   FILE 540
//*                                                                 *   FILE 540
//*              This routine makes it easy to put a lot of         *   FILE 540
//*              options into a program.  If you want to            *   FILE 540
//*              add options, or use other words in PARM or         *   FILE 540
//*              SYSIN to call the same options, all you            *   FILE 540
//*              have to do, is to change or add entries in         *   FILE 540
//*              a table.  There is no extra coding to be           *   FILE 540
//*              done.                                              *   FILE 540
//*                                                                 *   FILE 540
//*              Keywords in the PARM or SYSIN areas do not         *   FILE 540
//*              have to be delimited by commas or spaces or        *   FILE 540
//*              anything else.  Although for clarity, I'd          *   FILE 540
//*              certainly recommend that you put commas or         *   FILE 540
//*              spaces between the PARM field keywords.            *   FILE 540
//*              Therefore, I'd also advise that when you           *   FILE 540
//*              design keywords to put into the table to           *   FILE 540
//*              designate options, that you make them              *   FILE 540
//*              significantly different from each other.           *   FILE 540
//*              There is a length field in the table,              *   FILE 540
//*              however, which gives you some more control         *   FILE 540
//*              in this area.                                      *   FILE 540
//*                                                                 *   FILE 540
//*   Note:  In Version 1.3, I added code (if you comment out one   *   FILE 540
//*          line) to optionally require spaces or commas as        *   FILE 540
//*          delimiters between parms.  My intent was not to have   *   FILE 540
//*          the code require delimiters, but if you want them,     *   FILE 540
//*          you can now require them. (SG 05/29/02)                *   FILE 540
//*                                                                 *   FILE 540
//*          In this release, you can now easily code other         *   FILE 540
//*          characters, such as periods or dashes, to be used      *   FILE 540
//*          as delimiting characters for parms.  Just look at      *   FILE 540
//*          the new code, and you'll see that it's easy to do.     *   FILE 540
//*          That code is soon after label PRMNFND in PARMCHEK.     *   FILE 540
//*                                                                 *   FILE 540
//*              From a calling program, it would be possible       *   FILE 540
//*              to call PARMCHEK twice, against two different      *   FILE 540
//*              tables, to set 10 bytes of options, instead        *   FILE 540
//*              of 5 bytes of options, and so forth...             *   FILE 540
//*                                                                 *   FILE 540
//*              This gives you the opportunity of having           *   FILE 540
//*              a tremendous number of options, set by             *   FILE 540
//*              keywords, in your program, without using           *   FILE 540
//*              up valuable "base register space" for such         *   FILE 540
//*              coding.                                            *   FILE 540
//*                                                                 *   FILE 540
//*                                                                 *   FILE 540
//*     METHOD:  Bits, in the 5 bytes of PARMFLGS, are set,         *   FILE 540
//*              from a table, based on assembled defaults.         *   FILE 540
//*              These default settings are then overridden         *   FILE 540
//*              from a scan of words in the PARM field of          *   FILE 540
//*              the EXEC card.                                     *   FILE 540
//*                                                                 *   FILE 540
//*              If a SYSIN DD card is present, its cards           *   FILE 540
//*              are scanned against the table entries, to          *   FILE 540
//*              further override the bit settings which            *   FILE 540
//*              have already been done by the defaults and         *   FILE 540
//*              the PARM field.                                    *   FILE 540
//*                                                                 *   FILE 540
//*              The main purpose of this routine is to set         *   FILE 540
//*              bits from words.  However, if you need some        *   FILE 540
//*              keywords with values, such as (for example)        *   FILE 540
//*              FILELIMIT=69  in your program, you may use         *   FILE 540
//*              the "user code" section of this program            *   FILE 540
//*              to code that stuff in, so that these special       *   FILE 540
//*              keywords can be coded in SYSIN.                    *   FILE 540
//*                                                                 *   FILE 540
//*              Two sample keywords expecting number values:       *   FILE 540
//*              FILELIMIT=nnn  or                                  *   FILE 540
//*              LABELIMIT=mmm                                      *   FILE 540
//*              have been coded here, just to illustrate           *   FILE 540
//*              how the user coding might work.                    *   FILE 540
//*                                                                 *   FILE 540
//*              Search order is:  Defaults, then PARM in           *   FILE 540
//*              the EXEC card, then SYSIN.                         *   FILE 540
//*                                                                 *   FILE 540
//*              As coded here, the FILELIMIT= and                  *   FILE 540
//*              LABELIMIT= keywords in SYSIN have to be in         *   FILE 540
//*              column 1 of the SYSIN cards, and if these          *   FILE 540
//*              "special keywords" are present in a card,          *   FILE 540
//*              the rest of that card is not scanned for           *   FILE 540
//*              the table keywords.                                *   FILE 540
//*                                                                 *   FILE 540
//*              As coded here, the PARMTABL is a separate          *   FILE 540
//*              CSECT, addressable by V-CONs from the              *   FILE 540
//*              PARMCHEK CSECT.                                    *   FILE 540
//*                                                                 *   FILE 540
//*              It would probably be best to invoke the            *   FILE 540
//*              PARMCHEK program as a separate CSECT which         *   FILE 540
//*              is linkedited with the calling program,            *   FILE 540
//*              but it may be LOADed and BALR 14,15 'ed to,        *   FILE 540
//*              and run as a separate program.  (See the           *   FILE 540
//*              PARMDRVR program that is included in this          *   FILE 540
//*              package, as a sample.)                             *   FILE 540
//*                                                                 *   FILE 540
//*      Input:  A fullword containing the address of the           *   FILE 540
//*              saved Register 1 from the calling program,         *   FILE 540
//*              which points to its parms.                         *   FILE 540
//*                                                                 *   FILE 540
//*              A table containing parms, which is coded           *   FILE 540
//*              according to the following rules, and which        *   FILE 540
//*              has entries of 15 bytes apiece.                    *   FILE 540
//*                                                                 *   FILE 540
//*        FORMAT OF THE PARM TABLE                                 *   FILE 540
//*                                                                 *   FILE 540
//*          ONE ENTRY IS 15 BYTES                                  *   FILE 540
//*                                                                 *   FILE 540
//*            1ST BYTE:      LENGTH OF THIS PARM KEYWORD IN HEX    *   FILE 540
//*                           (This is the word which               *   FILE 540
//*                            controls the bit settings.)          *   FILE 540
//*                           (up to and including 8 bytes)         *   FILE 540
//*                                                                 *   FILE 540
//*            2ND BYTE:      X'01' says turn bit flag(s) OFF       *   FILE 540
//*                           X'00' says turn bit flag(s) ON        *   FILE 540
//*                           X'10' set entry as a DEFAULT          *   FILE 540
//*                                                                 *   FILE 540
//*            NEXT 8 BYTES:  PARM NAME - LEFT JUSTIFIED            *   FILE 540
//*                           (This is the word searched on,        *   FILE 540
//*                            in the EXEC PARM and SYSIN           *   FILE 540
//*                            areas.)                              *   FILE 540
//*                                                                 *   FILE 540
//*            NEXT 5 BYTES:  FLAG BIT settings controlled by       *   FILE 540
//*                            this keyword.                        *   FILE 540
//*                                                                 *   FILE 540
//*                           These are the bits which the          *   FILE 540
//*                            keyword will flip on (or off).       *   FILE 540
//*                                                                 *   FILE 540
//*                           You may control multiple bits         *   FILE 540
//*                            using one keyword.  All bits         *   FILE 540
//*                            controlled by this keyword           *   FILE 540
//*                            are coded in this entry field.       *   FILE 540
//*                                                                 *   FILE 540
//*            The table is ended by an entry of X'FF's.            *   FILE 540
//*                                                                 *   FILE 540
//*                                                                 *   FILE 540
//*      Output:  R1 points to a 5-byte area containing the         *   FILE 540
//*               40 switch settings.                               *   FILE 540
//*                                                                 *   FILE 540
//*               Sample code to use PARMCHEK output:               *   FILE 540
//*                                                                 *   FILE 540
//*                        ST    R1,PARMADDR                        *   FILE 540
//*                        USING PARMFLGS,R1                        *   FILE 540
//*               *                                                 *   FILE 540
//*               PARMFLGS DSECT                                    *   FILE 540
//*               PARMFLG1 DS    X                                  *   FILE 540
//*               PARMFLG2 DS    X                                  *   FILE 540
//*               PARMFLG3 DS    X                                  *   FILE 540
//*               PARMFLG4 DS    X                                  *   FILE 540
//*               PARMFLG5 DS    X                                  *   FILE 540
//*                                                                 *   FILE 540
//*                 then ....                                       *   FILE 540
//*                                                                 *   FILE 540
//*                        TM    PARMFLG2,X'04'                     *   FILE 540
//*                        BZ    some location                      *   FILE 540
//*                          ....                                   *   FILE 540
//*                                                                 *   FILE 540
//*               R2 points to the address of a data area           *   FILE 540
//*               containing values generated by this               *   FILE 540
//*               program.  It's address is at label STRTVALU       *   FILE 540
//*               and its length is in the first fullword           *   FILE 540
//*               at STRTVALU.                                      *   FILE 540
//*                                                                 *   FILE 540
//*               R2 is accessed in a similar manner to R1.         *   FILE 540
//*               See the PARMDRVR program for an example           *   FILE 540
//*               illustrating one way in which PARMCHEK            *   FILE 540
//*               may be called.                                    *   FILE 540
//*                                                                 *   FILE 540

```
