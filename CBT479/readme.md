```
//***FILE 479 is a collection of programs from Paul W. Lemons.      *   FILE 479
//*           Currently, this collection consists of three TSO      *   FILE 479
//*           programs.                                             *   FILE 479
//*                                                                 *   FILE 479
//*           email:   Paul W Lemons <plemons2@txu.com>             *   FILE 479
//*                                                                 *   FILE 479
//*      BCEDIT    - A set of REXX execs to edit and update         *   FILE 479
//*                  the current Global Notification records        *   FILE 479
//*                  in SYS1.BRODCAST.  These are the messages      *   FILE 479
//*                  that are displayed to everyone by the          *   FILE 479
//*                  LISTBC program, when they LOGON to TSO.        *   FILE 479
//*                  The system administrator can maintain these    *   FILE 479
//*                  notices easily with the help of these EXECs.   *   FILE 479
//*                                                                 *   FILE 479
//*      Important note:  In order for the BCEDIT package to        *   FILE 479
//*      be able to issue the proper OPERATOR SEND commands on      *   FILE 479
//*      behalf of the TSO user, TSO CONSOLE authority has to       *   FILE 479
//*      have been turned on.  To make that job easier, an          *   FILE 479
//*      updated version of the authorized TSO command CPSCB        *   FILE 479
//*      has been included in this file.  Since CPSCB does not      *   FILE 479
//*      produce any TSO output when it has executed success-       *   FILE 479
//*      fully, its companion TSO command LPSCB (List the PSCB)     *   FILE 479
//*      has also been included in this file.  These two TSO        *   FILE 479
//*      commands are designed to be used together, with CPSCB      *   FILE 479
//*      doing the changing, and LPSCB doing the reporting.         *   FILE 479
//*                                                                 *   FILE 479
//*      BKSEARCH  - A frontend to IBM's Bookmanager.  It is        *   FILE 479
//*                  designed to be cursor sensitive and will       *   FILE 479
//*                  search for an abend code or a system message   *   FILE 479
//*                  in the books contained in the IBM messages     *   FILE 479
//*                  bookshelf.  It would require that bookshelf    *   FILE 479
//*                  to have been uploaded and the BookManager      *   FILE 479
//*                  clist library to be allocated.  This code      *   FILE 479
//*                  will accept an abend code or message as a      *   FILE 479
//*                  parm.  However the best way to implement       *   FILE 479
//*                  would be to assign it to a PFKey and then      *   FILE 479
//*                  pressing that PFKey to read the data at the    *   FILE 479
//*                  cursor position.  This is NOT an edit macro    *   FILE 479
//*                  and should work from anywhere within ISPF.     *   FILE 479
//*                  I would be remiss in not acknowledging Doug    *   FILE 479
//*                  Nadel's %VCURSOR code that is an integral      *   FILE 479
//*                  part of this code.                             *   FILE 479
//*                                                                 *   FILE 479
//*      YAHTZEE   - A single player version of the YAHTZEE game    *   FILE 479
//*                  that runs under TSO.                           *   FILE 479
//*                                                                 *   FILE 479

```
