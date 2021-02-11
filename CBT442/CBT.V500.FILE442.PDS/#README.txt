----- Revive! -----
>> How to Install.
   1. change #COMPILE member.
     STEP A
      - JOBCAT   : your user catalog
      - SYSIN    : this library.
      - SYSLIB+2 : this library.
      - SYSLIB+3 : ispf macro library.
      - SYSLIN   : your object library.
     STEP L
      - LINK     : ispf module library.
      - OBJ      : your object library.
      - SYSLMOD  : your module library.

   2. submit #COMPILE member.

   3. change @REV member.
      - REVMOD   : your module library.
      - RECPNL   : your panel library.
      - REVMSG   : your messages library.
      - ISPLOAD  : ispf module library.

   4. change #COPY member.
      - DIST     : this library.
      - PANEL    : your ispf panel library.
      - MSGS     : your ispf messages library.
      - CLIST    : your tso clist library.

   5. submit #COPY member.


>> How to Start.
   if CLIST LIBRARY concatination your logon procedure ?
     - TSO @REV <enter>

   or

     - TSO EX 'clist.library(@REV)' <enter>


--------------------------------------------------------------
 if you have any question ,
   call to kimu@bigfoot.com    or
           http://home4.highway.ne.jp/kimu/

