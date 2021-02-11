```
//***FILE 994 is from Sam Golob (indirectly by way of Jeff Broido   *   FILE 994
//*           and Bill Godfrey), and contains two programs to dump  *   FILE 994
//*           the contents of a load module in hex, so that you     *   FILE 994
//*           can see its contents.                                 *   FILE 994
//*                                                                 *   FILE 994
//*           This will help you "see" all the data within a load   *   FILE 994
//*           module.                                               *   FILE 994
//*                                                                 *   FILE 994
//*           The dump is in an ISPF-like hex format, with ruler.   *   FILE 994
//*                             --------- --- ------  ---- -----    *   FILE 994
//*           email:   sbgolob@cbttape.org                          *   FILE 994
//*                                                                 *   FILE 994
//*           Important Note:                                       *   FILE 994
//*           --------- ----                                        *   FILE 994
//*           If you invoke LISTMOD or LISTMODD without parameters, *   FILE 994
//*           then you will dump the ENTIRE MODULE from the         *   FILE 994
//*           beginning to the end.  The header information         *   FILE 994
//*           (see below) will help you locate the entry point      *   FILE 994
//*           of the module displayed, within the dump of the       *   FILE 994
//*           entire load module.                                   *   FILE 994
//*                                                                 *   FILE 994
//*           If you invoke LISTMOD or LISTMODD with the parameter  *   FILE 994
//*           "ENTRY", then the display will only go from the       *   FILE 994
//*           entry point until the physical end of the module.     *   FILE 994
//*                                                                 *   FILE 994
//*           Two programs which are included:                      *   FILE 994
//*                                                                 *   FILE 994
//*           LISTMOD, which dumps  64 characters of the load       *   FILE 994
//*           module per line, and counts the displacements in      *   FILE 994
//*           hexadecimal numbers.                                  *   FILE 994
//*                                                                 *   FILE 994
//*           LISTMODD, which dumps 100 characters of the load      *   FILE 994
//*           module per line, and counts the displacements in      *   FILE 994
//*           decimal numbers.  (LISTMOD with DECIMAL display)      *   FILE 994
//*                                                                 *   FILE 994
//*           Enough information is included in the headers         *   FILE 994
//*           of the program outputs, to help you find the          *   FILE 994
//*           information you want, in the load module.             *   FILE 994
//*           as follows:                                           *   FILE 994
//*                                                                 *   FILE 994
//*    Sample heading information from a LOADED module:             *   FILE 994
//*    (same heading for either program)                            *   FILE 994
//*                                                                 *   FILE 994
//* Loaded Program Name:  IEBCOPY                                   *   FILE 994
//* --------------------------------------------------------------  *   FILE 994
//* Module has been LOADED.       CDE Address:  009A9090            *   FILE 994
//* Length of loaded module Hex:  00025CB0    Decimal:      154800  *   FILE 994
//* Length after entry address :  00020CB0    Decimal:      134320  *   FILE 994
//* Displacement of entry point:  00005000    Decimal:       20480  *   FILE 994
//*                                                                 *   FILE 994
//*    Sample heading information from a LPA module:                *   FILE 994
//*                                                                 *   FILE 994
//* Loaded Program Name:  IEFAB4A0                                  *   FILE 994
//* ----------------------------------------------------------------*   FILE 994
//* Module is from LPA.  LPDE Address: 00C742D0   Alias of: IEFW21SD*   FILE 994
//* Length of loaded module Hex:  000DD450    Decimal:      906320  *   FILE 994
//* Length after entry address :  00070D08    Decimal:      462088  *   FILE 994
//* Displacement of entry point:  0006C748    Decimal:      444232  *   FILE 994
//*                                                                 *   FILE 994
//*           Output is in PUTLINE format, so it can be captured    *   FILE 994
//*           and displayed on a full screen.                       *   FILE 994
//*                                                                 *   FILE 994
//*           Since the outputs are often very large, and need to   *   FILE 994
//*           be captured in their entirety so the whole display    *   FILE 994
//*           is visible and scrollable, therefore we have included *   FILE 994
//*           Mark Zelden's TSOE, TSOV, TSOB, and TSOR REXX execs   *   FILE 994
//*           here, to make the display easier, doing the outtrap   *   FILE 994
//*           automatically.                                        *   FILE 994
//*                                                                 *   FILE 994
//*           For example: TSO TSOV LISTMOD  pgmname  (hex measure) *   FILE 994
//*                                                                 *   FILE 994
//*                        TSO TSOV LISTMODD pgmname  (dec measure) *   FILE 994
//*                                                                 *   FILE 994
//*           Or:                                                   *   FILE 994
//*                                                                 *   FILE 994
//*               TSO TSOV LISTMOD  pgmname ENTRY  (hex measure)    *   FILE 994
//*                                                                 *   FILE 994
//*               TSO TSOV LISTMODD pgmname ENTRY  (dec measure)    *   FILE 994
//*                                                                 *   FILE 994
//*               TSO TSOV LISTHEAD pgmname ENTRY                   *   FILE 994
//*                                                                 *   FILE 994
//*       Description of the programs:                              *   FILE 994
//*                                                                 *   FILE 994
//*           LISTMOD  - Displays the load module in 64-byte lines. *   FILE 994
//*                      Displacements from the beginning are       *   FILE 994
//*                      marked in hex.  75-byte wide display.      *   FILE 994
//*                                                                 *   FILE 994
//*           LISTMODD - Displays the load module in 100-byte lines *   FILE 994
//*                      with the display being 112-bytes wide.     *   FILE 994
//*                      Displacements from the beginning are       *   FILE 994
//*                      marked in decimal.  Multiples of 100.      *   FILE 994
//*                                                                 *   FILE 994
//*           LISTHEAD - Program originally from Jeff Broido,       *   FILE 994
//*                      which displays standard load module        *   FILE 994
//*                      headers if they exist, and also the        *   FILE 994
//*                      first 300 bytes of the load module,        *   FILE 994
//*                      either at its beginning, or at its         *   FILE 994
//*                      entry point.                               *   FILE 994
//*                                                                 *   FILE 994

```
