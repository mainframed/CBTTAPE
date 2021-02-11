//*                                                                 *   FILE 708
//*     This isn't your mother's MPF exit!  It's the do all MPF     *   FILE 708
//*       exit.  It should replace most, if not all of your         *   FILE 708
//*       existing MPF exits.  If you are not using any MPF         *   FILE 708
//*       exits, you should check this one out.  Version 5.9.       *   FILE 708
//*                                                                 *   FILE 708
//*     The purpose of this product is to assist in automation      *   FILE 708
//*       of your MVS operating system.  This product will work     *   FILE 708
//*       on all system levels of ESA, OS/390 and z/OS.             *   FILE 708
//*                                                                 *   FILE 708
//*     The use of MPF has now become very easy.  No more recoding  *   FILE 708
//*       or writing a new MPF exits every time you need to issue a *   FILE 708
//*       reply or command.  No more maintaining multiple MPF exits *   FILE 708
//*       for seperate events.                                      *   FILE 708
//*                                                                 *   FILE 708
//*     Ease of use, once installed all that needs to be done to    *   FILE 708
//*       manage a new message is the following four (4) steps:     *   FILE 708
//*             1. Create a new member in the commands dataset.     *   FILE 708
//*             2. Make an entry into MPFLSTxx.                     *   FILE 708
//*             3. Start MPFLOAD                                    *   FILE 708
//*             4. SET MPF=xx                                       *   FILE 708
//*                                                                 *   FILE 708
//*     Manage up to 1000 different messages and 102 commands/logic *   FILE 708
//*      per message.                                               *   FILE 708
//*                                                                 *   FILE 708
//*     This exit can do the following:                             *   FILE 708
//*                                                                 *   FILE 708
//*     Reply to outstanding messages (WTOR's).  It can reply       *   FILE 708
//*                *                                                *   FILE 708
//*                R 00,WARM,NOREQ                                  *   FILE 708
//*                    to WTOR                                      *   FILE 708
//*                01 $HASP426 SPECIFY OPTIONS - JES2               *   FILE 708
//*                *                                                *   FILE 708
//*       The $HASP426 commands member would look like this:        *   FILE 708
//*                *                                                *   FILE 708
//*                REPLY NN,WARM,NOREQ                              *   FILE 708
//*                *                                                *   FILE 708
//*       With an update from Dean Tesar WTOR's with an RMAX of     *   FILE 708
//*          up to four digits is possible, if your RMAX is set to  *   FILE 708
//*          RMAX(999) or RMAX(9999) using three or four digit      *   FILE 708
//*          replies your commands member would look like:          *   FILE 708
//*                *                                                *   FILE 708
//*                REPLY NNNN,WARM,NOREQ                            *   FILE 708
//*                *                                                *   FILE 708
//*                                                                 *   FILE 708
//*     Issue; START commands, VARY commands, DISPLAY commands,     *   FILE 708
//*       SE commands, ROUTE commands, JES commands... in other     *   FILE 708
//*       words, any commands for any messages, i.e.                *   FILE 708
//*                *                                                *   FILE 708
//*                S TSO                                            *   FILE 708
//*                    for message                                  *   FILE 708
//*                IST020I VTAM INITIALIZATION COMPLETE             *   FILE 708
//*                                                                 *   FILE 708
//*     It also has IF SYSID logic built into it; so you can        *   FILE 708
//*       issue different commands to different systems.  For       *   FILE 708
//*       example, say you want to issue START commands for         *   FILE 708
//*       VPS, TND and OMEGVTM on your production LPAR SSC and      *   FILE 708
//*       only wanted to issue a START for TND on your systems      *   FILE 708
//*       programming LPAR SYSPGM and START of TSO on both.  The    *   FILE 708
//*       IF SYSID can also be used as an outer or inner IF, more   *   FILE 708
//*       on that later.                                            *   FILE 708
//*                *                                                *   FILE 708
//*       The IST020I commands member would look like this:         *   FILE 708
//*                *                                                *   FILE 708
//*                IF SYSID EQ SSC                                  *   FILE 708
//*                S VPS                                            *   FILE 708
//*                S TND                                            *   FILE 708
//*                S OMEGAVTM                                       *   FILE 708
//*                ENDIF                                            *   FILE 708
//*                *                                                *   FILE 708
//*                IF SYSID EQ SYSPGM                               *   FILE 708
//*                S TND                                            *   FILE 708
//*                ENDIF                                            *   FILE 708
//*                *                                                *   FILE 708
//*                S TSO                                            *   FILE 708
//*                                                                 *   FILE 708
//*     It can also find up to 4 separate words in a message up to  *   FILE 708
//*       25 characters per word.  All words must appear in that    *   FILE 708
//*       message, in any order.                                    *   FILE 708
//*                *                                                *   FILE 708
//*                IF ALL EQ word1 word2 word3 word4                *   FILE 708
//*                Do Something                                     *   FILE 708
//*                ENDIF                                            *   FILE 708
//*                *                                                *   FILE 708
//*     If you wanted to start NETSPOOL after a PrintServer         *   FILE 708
//*       Daemon has started; the MPFXTALL program is also case     *   FILE 708
//*       sensitive, so for the following message:                  *   FILE 708
//*                *                                                *   FILE 708
//*    AOP075I Daemon aopd was started successfully. (program:aopd) *   FILE 708
//*                *                                                *   FILE 708
//*       The AOP075I commands member would look like this:         *   FILE 708
//*                *                                                *   FILE 708
//*                IF ALL EQ Daemon aopd was started                *   FILE 708
//*                S NETSPOOL                                       *   FILE 708
//*                ENDIF                                            *   FILE 708
//*                                                                 *   FILE 708
//*     Oh, it also highlights messages.  To highlight abends;      *   FILE 708
//*       The IEF450I commands member would look like this:         *   FILE 708
//*                *                                                *   FILE 708
//*                HIGHLIGHT                                        *   FILE 708
//*                *                                                *   FILE 708
//*      Or use the AUTO/TOKEN feature AUTO(HIGHLITE).              *   FILE 708
//*       No commands member is necessary for this.                 *   FILE 708
//*         IEF450I,USEREXIT(MPFXTALL),AUTO(HIGHLITE),SUP(NO)       *   FILE 708
//*                *                                                *   FILE 708
//*      If you need to highlight a multi-line message you will     *   FILE 708
//*       need to use AUTO(SINGLE) this treats a multi-line as a    *   FILE 708
//*       single line.                                              *   FILE 708
//*         SSC111I,USEREXIT(MPFXTALL),AUTO(SINGLE),SUP(NO)         *   FILE 708
//*                                                                 *   FILE 708
//*     Then there's IF WORD logic check for one word up to 25      *   FILE 708
//*       characters in one specific location from 01 to 99.  This  *   FILE 708
//*       function can also be used with a wild card.  Also, here's *   FILE 708
//*       the usage of the IF SYSID used as an outer if.  So, if    *   FILE 708
//*       the system is SSC and the job that abended starts with    *   FILE 708
//*       PROD then the IEF450I commands member would look like     *   FILE 708
//*       this:                                                     *   FILE 708
//*                *                                                *   FILE 708
//*                IF SYSID EQ SSC                                  *   FILE 708
//*                IF WORD 01 PROD*                                 *   FILE 708
//*                HIGHLIGHT                                        *   FILE 708
//*                ENDIF                                            *   FILE 708
//*                ENDIF                                            *   FILE 708
//*                *                                                *   FILE 708
//*                                                                 *   FILE 708
//*     And now here's the GET and replace part of the program,     *   FILE 708
//*       very slick if I may say so myself.  It retrieves a word   *   FILE 708
//*       from whatever position you specify; then it replaces      *   FILE 708
//*       any % in the commands with that word.  So, to have        *   FILE 708
//*       MPFXTALL submit a job to dump an SMF dataset for the      *   FILE 708
//*       following message:                                        *   FILE 708
//*       *IEE362A SMF ENTER DUMP FOR SYS1.MAN2 ON SSCCAT           *   FILE 708
//*       The commands member IEE362A would look like this:         *   FILE 708
//*                *                                                *   FILE 708
//*                GET WORD 05                                      *   FILE 708
//*                S SMFAUTO,SMFDSN='%'                             *   FILE 708
//*                ENDGET                                           *   FILE 708
//*       The resulting command issued by MPFXTALL would be:        *   FILE 708
//*                *                                                *   FILE 708
//*        S SMFAUTO,SMFDSN='SYS1.MAN2'                             *   FILE 708
//*                *                                                *   FILE 708
//*       The GET can also be used as an inner GET with all IF's.   *   FILE 708
//*        So, you can do something fancy like this:                *   FILE 708
//*                *                                                *   FILE 708
//*                IF SYSID EQ SSC                                  *   FILE 708
//*                IF WORD 06 SSCCAT                                *   FILE 708
//*                GET WORD 05                                      *   FILE 708
//*                S SMFAUTO,SMFDSN='%'                             *   FILE 708
//*                ENDGET                                           *   FILE 708
//*                ENDIF                                            *   FILE 708
//*                ENDIF                                            *   FILE 708
//*                *                                                *   FILE 708
//*       Now, thanks to Peter Johnson this automation tool can     *   FILE 708
//*        handle multi-line messages.  So, for this multi-line     *   FILE 708
//*        SMF message:                                             *   FILE 708
//*   IEE391A SMF ENTER DUMP FOR DATA SET ON VOLSER SSCCAT,         *   FILE 708
//*                   DSN=SYS1.SSC.MAN1                             *   FILE 708
//*                *                                                *   FILE 708
//*       The IEE391A commands member would look like this:         *   FILE 708
//*                *                                                *   FILE 708
//*                GET WORD 10                                      *   FILE 708
//*                S SMFAUTO,%                                      *   FILE 708
//*                ENDGET                                           *   FILE 708
//*                *                                                *   FILE 708
//*       The resulting command issued by MPFXTALL would be:        *   FILE 708
//*                *                                                *   FILE 708
//*                S SMFAUTO,DSN=SYS1.SSC.MAN1                      *   FILE 708
//*                                                                 *   FILE 708
//*     A new addition to the GET is the GET REPLYID this will      *   FILE 708
//*       get the reply id number and replace any & with that       *   FILE 708
//*       number in that commands member, see PUTSWITCH for usage.  *   FILE 708
//*                                                                 *   FILE 708
//*     And of course, it does write to operator, highlighted       *   FILE 708
//*       or not.  So, if you wanted to send a WTO message for      *   FILE 708
//*       message ID $HASP612;                                      *   FILE 708
//*       The $HASP612 commands member would look like this:        *   FILE 708
//*                *                                                *   FILE 708
//*                WTO No jobs running on this system               *   FILE 708
//*                *                                                *   FILE 708
//*       And if you wanted it highlighted:                         *   FILE 708
//*                *                                                *   FILE 708
//*                WTOH No jobs running on this system              *   FILE 708
//*                                                                 *   FILE 708
//*     And it does suppression also.  To suppress a message like   *   FILE 708
//*       $HASP100 from the syslog and joblog the $HASP100 member   *   FILE 708
//*       would look like this:                                     *   FILE 708
//*                *                                                *   FILE 708
//*                SUPPRESS                                         *   FILE 708
//*                *                                                *   FILE 708
//*       Be cautious using SUPPRESS, once it's deletes thats it,   *   FILE 708
//*       it's gone.                                                *   FILE 708
//*                *                                                *   FILE 708
//*     Now thanks to Dean Tesar we have the joblog only and syslog *   FILE 708
//*       only suppression these modification will suppress only    *   FILE 708
//*       the joblog or only the syslog messages:                   *   FILE 708
//*                *                                                *   FILE 708
//*                NOJOBLOG                                         *   FILE 708
//*                *                                                *   FILE 708
//*                NOSYSLOG                                         *   FILE 708
//*                *                                                *   FILE 708
//*     Or use the AUTO/TOKEN feature AUTO(SUPPRESS)                *   FILE 708
//*       AUTO(NOJOBLOG) AUTO(NOSYSLOG).                            *   FILE 708
//*       No commands member is necessary for these.                *   FILE 708
//*         messageID,USEREXIT(MPFXTALL),AUTO(SUPPRESS)             *   FILE 708
//*         messageID,USEREXIT(MPFXTALL),AUTO(NOJOBLOG)             *   FILE 708
//*         messageID,USEREXIT(MPFXTALL),AUTO(NOSYSLOG)             *   FILE 708
//*                *                                                *   FILE 708
//*     If you need to only suppress from the console an MPFLSTxx   *   FILE 708
//*       entry like this will do the trick.                        *   FILE 708
//*                xxxxxxxx,SUP(YES)                                *   FILE 708
//*                                                                 *   FILE 708
//*     You want colors I'll give you colors, this ones for Jason.  *   FILE 708
//*       Change the color make it blink, underline and/or reverse  *   FILE 708
//*       video.  The options for the DISPLAY command are BLUE,     *   FILE 708
//*       PINK, RED, GREEN, TURQUOISE, YELLOW, WHITE, BLINK,        *   FILE 708
//*       REVERSE and UNDERLINE.                                    *   FILE 708
//*       The commands member to make it blink red would be:        *   FILE 708
//*                 DISPLAY RED                                     *   FILE 708
//*                 DISPLAY BLINK                                   *   FILE 708
//*                                                                 *   FILE 708
//*     The AUTO/TOKEN feature allows you to SUPPRESS, NOJOBLOG,    *   FILE 708
//*       NOSYSLOG and HIGHLITE multiple messages with one entry.   *   FILE 708
//*       No commands member is necessary for this.                 *   FILE 708
//*         BA*,USEREXIT(MPFXTALL),AUTO(SUPPRESS)                   *   FILE 708
//*                *                                                *   FILE 708
//*     Also, the AUTO/TOKEN feature has member selection, this     *   FILE 708
//*       allows you to select a different commands member then     *   FILE 708
//*       the messageID states.  This allows multiple messages to   *   FILE 708
//*       point to one commands member.                             *   FILE 708
//*         ABC1001E,USEREXIT(MPFXTALL),AUTO(ABCMSGS)               *   FILE 708
//*         ABC1002E,USEREXIT(MPFXTALL),AUTO(ABCMSGS)               *   FILE 708
//*                or                                               *   FILE 708
//*         ABC*,USEREXIT(MPFXTALL),AUTO(ABCMSGS)                   *   FILE 708
//*                *                                                *   FILE 708
//*     Special character handling for message id's is now          *   FILE 708
//*       available with the use of the AUTO/TOKEN feature.  For a  *   FILE 708
//*       message that start with a special character like a dash - *   FILE 708
//*       the MPFLSTxx member would contain the following:          *   FILE 708
//*       -SSCCORP0*,SUP(NO),USEREXIT(MPFXTALL),AUTO(SSCCORP1)      *   FILE 708
//*       And the commands member SSCCORP1 would contain whatever.  *   FILE 708
//*                *                                                *   FILE 708
//*     It also has a AUTO(SINGLE) which treats a multi-line as a   *   FILE 708
//*       single line.                                              *   FILE 708
//*                *                                                *   FILE 708
//*     MPFXTALL normally displays the following message for any    *   FILE 708
//*       managed message                                           *   FILE 708
//*       /* Issued by MPFXTALL for messageID      */               *   FILE 708
//*     If you wish not to display this use the following           *   FILE 708
//*       AUTO/TOKEN feature NODISPLY                               *   FILE 708
//*       SSCCORP9,USEREXIT(MPFXTALL),AUTO(NODISPLY)                *   FILE 708
//*       or set the default for all like this:                     *   FILE 708
//*       .DEFAULT,AUTO(NODISPLY)                                   *   FILE 708
//*                                                                 *   FILE 708
//*     Long message ID handling is also included, for long         *   FILE 708
//*       message ID's such as:                                     *   FILE 708
//*       SVT1P0001I SubTask 01 Completion - Group=22 Subgroup=L    *   FILE 708
//*       Use the first 8 characters of the message ID for the      *   FILE 708
//*       commands member name, so the commands member name for     *   FILE 708
//*       the above message would be SVT1P000 and the MPFLSTxx      *   FILE 708
//*       entry would look like this:                               *   FILE 708
//*                *                                                *   FILE 708
//*       SVT1P0001I,SUP(NO),RETAIN(NO),USEREXIT(MPFXTALL)          *   FILE 708
//*                *                                                *   FILE 708
//*      In addition to the long message id handling I've added     *   FILE 708
//*       logic testing for the message id.  So, here it is Dean    *   FILE 708
//*       and Diana you asked for it, yes, I do requests.           *   FILE 708
//*                *                                                *   FILE 708
//*       The IF MSGID EQ and IF MSGID NE for up to 25 character    *   FILE 708
//*        message id's.                                            *   FILE 708
//*       Say you need to handle several long messages with the     *   FILE 708
//*       same first 8 characters like:                             *   FILE 708
//*       SVT1P0011A Some message text                              *   FILE 708
//*       SVT1P0011B Some other message text                        *   FILE 708
//*       SVT1P0011C And another message text                       *   FILE 708
//*       SVT1P0012A And the just one more                          *   FILE 708
//*                *                                                *   FILE 708
//*      The MPFLSTxx member would contain the following:           *   FILE 708
//*       SVT1P0011A,SUP(NO),RETAIN(NO),USEREXIT(MPFXTALL)          *   FILE 708
//*       SVT1P0011B,SUP(NO),RETAIN(NO),USEREXIT(MPFXTALL)          *   FILE 708
//*       SVT1P0011C,SUP(NO),RETAIN(NO),USEREXIT(MPFXTALL)          *   FILE 708
//*       SVT1P0012A,SUP(NO),RETAIN(NO),USEREXIT(MPFXTALL)          *   FILE 708
//*                *                                                *   FILE 708
//*      The commands member SVT1P001 in SYS1.MPF.COMMANDS would    *   FILE 708
//*       contain the following:                                    *   FILE 708
//*                *                                                *   FILE 708
//*                IF MSGID EQ SVT1P0011A                           *   FILE 708
//*                Do something for this message                    *   FILE 708
//*                ENDIF                                            *   FILE 708
//*                *                                                *   FILE 708
//*                IF MSGID EQ SVT1P0011B                           *   FILE 708
//*                Do something else for this message               *   FILE 708
//*                ENDIF                                            *   FILE 708
//*                *                                                *   FILE 708
//*                IF MSGID EQ SVT1P0011C                           *   FILE 708
//*                And something different for this message         *   FILE 708
//*                ENDIF                                            *   FILE 708
//*                *                                                *   FILE 708
//*                IF MSGID EQ SVT1P0012A                           *   FILE 708
//*                And something totally diferent for this message  *   FILE 708
//*                ENDIF                                            *   FILE 708
//*                *                                                *   FILE 708
//*      Or you can use the AUTO/TOKEN feature for long message     *   FILE 708
//*       handling to point to a separate commands member.          *   FILE 708
//*      The MPFLSTxx member would contain the following:           *   FILE 708
//*       SVT1P0011A,SUP(NO),USEREXIT(MPFXTALL),AUTO(SVT1P11A)      *   FILE 708
//*       SVT1P0011B,SUP(NO),USEREXIT(MPFXTALL),AUTO(SVT1P11B)      *   FILE 708
//*      And the two commands member you would have:                *   FILE 708
//*       Do something                                              *   FILE 708
//*         and                                                     *   FILE 708
//*       Do something else                                         *   FILE 708
//*                *                                                *   FILE 708
//*      IBM's MPF has a limitation of a max of 10 characters per   *   FILE 708
//*       message, but MPFXTALL to the rescue, you can specify up   *   FILE 708
//*       to 25 characters in the IF MSGID EQ section of the        *   FILE 708
//*       product.  See the creme de la creme for details.          *   FILE 708
//*                                                                 *   FILE 708
//*     The IF MSGID+xx FOR xx this can be used when you have       *   FILE 708
//*       dozens of similar messages like CSQ1234I, CSQ1234E,       *   FILE 708
//*       CSQ1235I, CSQ1235E etc and you only want to only suppress *   FILE 708
//*       the I level messages.                                     *   FILE 708
//*       The MPFLSTxx member would contain:                        *   FILE 708
//*       CSQ*,USEREXIT(MPFXTALL),AUTO(CSQMSGS)                     *   FILE 708
//*                *                                                *   FILE 708
//*       And the commands member CSQMSGS would look like this:     *   FILE 708
//*                IF MSGID+07 FOR 01 I                             *   FILE 708
//*                SUPPRESS                                         *   FILE 708
//*                ENDIF                                            *   FILE 708
//*                *                                                *   FILE 708
//*      Also the if message id not equal can be used for checking  *   FILE 708
//*       if part of the message not equal, coded like this.        *   FILE 708
//*       message dosn't equal coded like this.                     *   FILE 708
//*               IF MSGNE+07 FOR 01 I                              *   FILE 708
//*                SUPPRESS                                         *   FILE 708
//*                ENDIF                                            *   FILE 708
//*                                                                 *   FILE 708
//*     And now thanks to Dean here is the MPFSUPNO, for those who  *   FILE 708
//*       have their MPFLSTxx DEFAULT set to SUP(YES) and wish to   *   FILE 708
//*       not suppress a specific message can do the following:     *   FILE 708
//*                *                                                *   FILE 708
//*                MPFLSTxx member:                                 *   FILE 708
//*                CSQ*,USEREXIT(MPFXTALL),AUTO(CSQMSGS)            *   FILE 708
//*                *                                                *   FILE 708
//*                Commands member CSQMSGS:                         *   FILE 708
//*                *DO NOT MPF SUPPRESS CSQ????E                    *   FILE 708
//*                IF MSGID+07 FOR 01 E                             *   FILE 708
//*                MPFSUPNO                                         *   FILE 708
//*                ENDIF                                            *   FILE 708
//*                *                                                *   FILE 708
//*        The end result would be all messages that start with     *   FILE 708
//*        CSQ would be suppressed except for those message that    *   FILE 708
//*        have an E in column 8.                                   *   FILE 708
//*                                                                 *   FILE 708
//*     And now for the creme de la creme.  I now present the       *   FILE 708
//*       SWITCH/VARIABLE section of my product, consisting of the  *   FILE 708
//*       set switch, delete switch, alter switch, if switch on,    *   FILE 708
//*       if switch off, if switch equal and if switch not equal.   *   FILE 708
//*       This is my way of thanking Don, Todd and Emma for         *   FILE 708
//*       intrusting me with their OS upgrade project after only a  *   FILE 708
//*       few conference calls.  I believe this should complete     *   FILE 708
//*       your free automation solution.  I also believe everybody  *   FILE 708
//*       else should thank them for inspiring me to write this     *   FILE 708
//*       code.  With this addition to my product all of you should *   FILE 708
//*       be armed sufficiently to totally eliminate any other      *   FILE 708
//*       automation products at your shop.                         *   FILE 708
//*      Now for the meat and taters:                               *   FILE 708
//*      The SETSWITCH command will set a persistent switch with    *   FILE 708
//*       a user defined name field up to 8 characters and a user   *   FILE 708
//*       defined status/information field up to 16 characters.     *   FILE 708
//*       Both fields have no other limitations; you can use any    *   FILE 708
//*       characters, spaces, special characters and numbers.       *   FILE 708
//*      The DELSWITCH command that's what it does, it deletes      *   FILE 708
//*       the switch.                                               *   FILE 708
//*      The ALTSWITCH is used to alter the status/information      *   FILE 708
//*       part of the switch from anything to anything.             *   FILE 708
//*      The PUTSWITCH places whatever is stored in the             *   FILE 708
//*       status/information part of the switch to the console.     *   FILE 708
//*      The IF SWITCH logic has four separate checks.              *   FILE 708
//*      The IF SWITCH ON checks only to see if the switch is       *   FILE 708
//*       on/exists, it doesn't check the status/information        *   FILE 708
//*       section.                                                  *   FILE 708
//*      The IF SWITCH OFF checks only to see if the switch is      *   FILE 708
//*       off/doesn't exists.                                       *   FILE 708
//*      The IF SWITCH EQ checks the named switch                   *   FILE 708
//*       status/information field is equal to that of the if       *   FILE 708
//*       statement.                                                *   FILE 708
//*      The IF SWITCH NE checks the named switch                   *   FILE 708
//*       status/information field to not be equal to the if        *   FILE 708
//*       statement.  Here's all the different syntax:              *   FILE 708
//*                *                                                *   FILE 708
//*                * Correct positioning                            *   FILE 708
//*          =COLS>123456789012345678901234567890123456789          *   FILE 708
//*                *         |        |                             *   FILE 708
//*                SETSWITCH xxxxxxxx xxxxxxxxxxxxxxxx              *   FILE 708
//*                *         |                                      *   FILE 708
//*                DELSWITCH xxxxxxxx                               *   FILE 708
//*                *         |        |                             *   FILE 708
//*                ALTSWITCH xxxxxxxx xxxxxxxxxxxxxxxx              *   FILE 708
//*                *         |                                      *   FILE 708
//*                PUTSWITCH xxxxxxxx                               *   FILE 708
//*                *            |                                   *   FILE 708
//*                IF SWITCH ON xxxxxxxx                            *   FILE 708
//*                do something                                     *   FILE 708
//*                ENDIF SWITCH ON                                  *   FILE 708
//*                *             |                                  *   FILE 708
//*                IF SWITCH OFF xxxxxxxx                           *   FILE 708
//*                do something                                     *   FILE 708
//*                ENDIF SWITCH OFF                                 *   FILE 708
//*                *            |        |                          *   FILE 708
//*                IF SWITCH EQ xxxxxxxx xxxxxxxxxxxxxxxx           *   FILE 708
//*                do something                                     *   FILE 708
//*                ENDIF SWITCH EQ                                  *   FILE 708
//*                *            |        |                          *   FILE 708
//*                IF SWITCH NE xxxxxxxx xxxxxxxxxxxxxxxx           *   FILE 708
//*                do something                                     *   FILE 708
//*                ENDIF SWITCH NE                                  *   FILE 708
//*                *                                                *   FILE 708
//*      Here's a sample of usage for messages:                     *   FILE 708
//*       DCOMMMP1:246:0:DB00308I - LOG AREA IS  50% FULL,          *   FILE 708
//*       DCOMMMP1:246:0:DB00308I - LOG AREA IS  70% FULL,          *   FILE 708
//*       DCOMMMT3:246:0:DB00308I - LOG AREA IS  50% FULL,          *   FILE 708
//*       DCOMMMT3:246:0:DB00308I - LOG AREA IS  70% FULL,          *   FILE 708
//*                *                                                *   FILE 708
//*      The MPFLSTxx entries would look like this:                 *   FILE 708
//*       DCOMMMP1:*,USEREXIT(MPFXTALL),SUP(NO),AUTO(SPILL)         *   FILE 708
//*       DCOMMMT3:*,USEREXIT(MPFXTALL),SUP(NO),AUTO(SPILL)         *   FILE 708
//*       $HASP395,SUP(NO),RETAIN(NO),USEREXIT(MPFXTALL)            *   FILE 708
//*                *                                                *   FILE 708
//*      The commands member SPILL would look like this:            *   FILE 708
//*       IF MSGID EQ DCOMMMP1:246:0:DB00308I                       *   FILE 708
//*       IF SWITCH OFF DCOMMMP1                                    *   FILE 708
//*       SETSWITCH DCOMMMP1 Submitted DCOMSPLP                     *   FILE 708
//*       S DCOMSPLP                                                *   FILE 708
//*       WTO MPFXTALL submitted offload DCOMSPLP for DCOMMMP1      *   FILE 708
//*       ENDIF SWITCH OFF                                          *   FILE 708
//*       IF SWITCH ON DCOMMMP1                                     *   FILE 708
//*       WTO DCOMSPLP active for DCOMMMP1 no offload submitted     *   FILE 708
//*       ENDIF SWITCH ON                                           *   FILE 708
//*       ENDIF                                                     *   FILE 708
//*       *                                                         *   FILE 708
//*       IF MSGID EQ DCOMMMT3:246:0:DB00308I                       *   FILE 708
//*       IF SWITCH OFF DCOMMMT3                                    *   FILE 708
//*       SETSWITCH DCOMMMT3 Submitted DCOMSPL3                     *   FILE 708
//*       S DCOMSPL3                                                *   FILE 708
//*       WTO MPFXTALL submitted offload DCOMSPL3 for DCOMMMT3      *   FILE 708
//*       ENDIF SWITCH OFF                                          *   FILE 708
//*       IF SWITCH ON DCOMMMT3                                     *   FILE 708
//*       WTO DCOMSPL3 active for DCOMMMT3 no offload submitted     *   FILE 708
//*       ENDIF SWITCH ON                                           *   FILE 708
//*       ENDIF                                                     *   FILE 708
//*       *                                                         *   FILE 708
//*      The commands member $HASP395 would look like this:         *   FILE 708
//*       IF WORD 01 DCOMSPLP                                       *   FILE 708
//*       DELSWITCH DCOMMMP1                                        *   FILE 708
//*       WTO DCOMSPLP has ended DCOMMMP1 switch has been reset     *   FILE 708
//*       ENDIF                                                     *   FILE 708
//*       *                                                         *   FILE 708
//*       IF WORD 01 DCOMSPL3                                       *   FILE 708
//*       DELSWITCH DCOMMMT3                                        *   FILE 708
//*       WTO DCOMSPL3 has ended DCOMMMT3 switch has been reset     *   FILE 708
//*       ENDIF                                                     *   FILE 708
//*       *                                                         *   FILE 708
//*      Here's one usage for the PUTSWITCH and GET REPLYID this    *   FILE 708
//*       one's for Jimmy from Alaska.                              *   FILE 708
//*       *                                                         *   FILE 708
//*      Theses are the messages:                                   *   FILE 708
//*       @32 REPLY WITH REQUEST TO IDMS V8                         *   FILE 708
//*       @31 REPLY WITH REQUEST TO IDMS V9                         *   FILE 708
//*       *                                                         *   FILE 708
//*      The MPFLSTxx entries would look like this:                 *   FILE 708
//*       REPLY,SUP(NO),RETAIN(NO),USEREXIT(MPFXTALL),AUTO(NO)      *   FILE 708
//*       SHUTIDMS,SUP(NO),RETAIN(NO),USEREXIT(MPFXTALL),AUTO(NO)   *   FILE 708
//*       *                                                         *   FILE 708
//*      The commands member REPLY would look like this:            *   FILE 708
//*       IF WORD 05 V8                                             *   FILE 708
//*       GET REPLYID                                               *   FILE 708
//*       DELSWITCH IDMSV8                                          *   FILE 708
//*       SETSWITCH IDMSV8   &,/CHE DUMPQ                           *   FILE 708
//*       ENDGET ID                                                 *   FILE 708
//*       ENDIF                                                     *   FILE 708
//*       *                                                         *   FILE 708
//*       IF WORD 05 V9                                             *   FILE 708
//*       GET REPLYID                                               *   FILE 708
//*       DELSWITCH IDMSV9                                          *   FILE 708
//*       SETSWITCH IDMSV9   &,/CHE DUMPQ                           *   FILE 708
//*       ENDGET ID                                                 *   FILE 708
//*       ENDIF                                                     *   FILE 708
//*       *                                                         *   FILE 708
//*      The commands member SHUTIDMS would look like this:         *   FILE 708
//*       IF SWITCH ON IDMSV8                                       *   FILE 708
//*       PUTSWITCH IDMSV8                                          *   FILE 708
//*       DELSWITCH IDMSV8                                          *   FILE 708
//*       ENDIF SWITCH ON                                           *   FILE 708
//*       *                                                         *   FILE 708
//*       IF SWITCH ON IDMSV9                                       *   FILE 708
//*       PUTSWITCH IDMSV9                                          *   FILE 708
//*       DELSWITCH IDMSV9                                          *   FILE 708
//*       ENDIF SWITCH ON                                           *   FILE 708
//*       *                                                         *   FILE 708
//*      Then have your automation shutdown procedure issue a       *   FILE 708
//*       SHUTIDMS and MPFXTALL will issue the following:           *   FILE 708
//*        31,/CHE DUMPQ                                            *   FILE 708
//*        32,/CHE DUMPQ                                            *   FILE 708
//*                                                                 *   FILE 708
//*     A few very slick additions from Garry Green.  First is the  *   FILE 708
//*       ASTYPE this allows you too check if the task is a TSO,    *   FILE 708
//*       Batch or STC, T for TSO, J for BATCH and S for STC.       *   FILE 708
//*        IF ASTYPE EQ T                                           *   FILE 708
//*        IF ASTYPE EQ J                                           *   FILE 708
//*        IF ASTYPE EQ S                                           *   FILE 708
//*       So if you needed to reply cancel to the following message *   FILE 708
//*       only for TSO Userid's                                     *   FILE 708
//*        *61 IEF238D GSI - REPLY DEVICE NAME OR 'CANCEL'.         *   FILE 708
//*       The Commands IEF238D member would look like this          *   FILE 708
//*        IF ASTYPE EQ T                                           *   FILE 708
//*        REPLY NN,CANCEL                                          *   FILE 708
//*        ENDIF ASTYPE                                             *   FILE 708
//*       *                                                         *   FILE 708
//*     Now for the TSOROUTE command this allows a TSO user to      *   FILE 708
//*       reply to there own outstanding requests WTOR's from there *   FILE 708
//*       own TSO userid for WTOR's issued for there TSO userid.    *   FILE 708
//*       So if you want all user's to be able to reply to message  *   FILE 708
//*       *61 IEF238D GSI - REPLY DEVICE NAME OR 'CANCEL'.          *   FILE 708
//*       The Commands IEF238D member would look like this          *   FILE 708
//*        IF ASTYPE EQ T                                           *   FILE 708
//*        TSOROUTE REPLY                                           *   FILE 708
//*        ENDIF ASTYPE                                             *   FILE 708
//*       This will allow only the TSO userid to reply to the       *   FILE 708
//*       outstanding reply, the TSO userid will receive the        *   FILE 708
//*       following message, there will be no outstanding request   *   FILE 708
//*       on the master console:                                    *   FILE 708
//*        MPF201I ONLY THIS TSO TERMINAL CAN REPLY TO FOLLOWING    *   FILE 708
//*         WTOR-CONSOLES CAN'T REPLY                               *   FILE 708
//*        IEF238D GGG - REPLY DEVICE NAME OR 'CANCEL'.             *   FILE 708
//*       *                                                         *   FILE 708
//*       The other options for TSOROUTE are TSOROUTE which only    *   FILE 708
//*       sends a message to to the TSO userid as follows:          *   FILE 708
//*        MPF203I FOLLOWING WTOR FOR DISPLAY ONLY - REPLY MUST BE  *   FILE 708
//*         ENTERED FROM CONSOLE                                    *   FILE 708
//*        IEF238D GSI - REPLY DEVICE NAME OR 'CANCEL'.             *   FILE 708
//*       *                                                         *   FILE 708
//*       And the TSOROUTE SUPPRESS this will suppress the reply    *   FILE 708
//*       to the outstanding request, good for password replies.    *   FILE 708
//*       The message sent to the TSO userid is as follows:         *   FILE 708
//*        MPF201I ONLY THIS TSO TERMINAL CAN REPLY TO FOLLOWING    *   FILE 708
//*         WTOR-CONSOLES CAN'T REPLY                               *   FILE 708
//*        MPF202I REPLY VALUE YOU ENTER WILL BE SUPPRESSED FROM    *   FILE 708
//*         CONSOLE, JOBLOG & SYSLOG                                *   FILE 708
//*        IEF238D GSI - REPLY DEVICE NAME OR 'CANCEL'.             *   FILE 708
//*                                                                 *   FILE 708
//*     ESTAE recovery routine added by Garry GREAT addition        *   FILE 708
//*       now no matter what happens MPFTXALL will stay alive.      *   FILE 708
//*       If an MPF exit routine such as MPFXTALL abends, it is     *   FILE 708
//*       disabled for ALL the message id's that it is associated   *   FILE 708
//*       This can have several undesirable side effects:           *   FILE 708
//*       1) Perhaps the exit is abending due to a bug triggered by *   FILE 708
//*          only one message id that rarely occurs.                *   FILE 708
//*       2) Until the disablement is noticed, many automation      *   FILE 708
//*          events can be lost.                                    *   FILE 708
//*       ESTAEX protection around the entire MPFXTALL code;        *   FILE 708
//*       in the event that there is an abend in MPFXTALL, a WTO    *   FILE 708
//*       MPF038E MPFXTALL ABENDED; ABEND WAS SUPPRESSED message    *   FILE 708
//*       will be issued, no further processing will occur for the  *   FILE 708
//*       message that caused the abend, but since the abend was    *   FILE 708
//*       suppressed, MPFXTALL remains active.                      *   FILE 708
//*                                                                 *   FILE 708
//*     Inner and outer IF's for all, IF's any combination up to 16 *   FILE 708
//*       deep any order, keep track of your ENDIF's and ENDGET's.  *   FILE 708
//*                                                                 *   FILE 708
//*     Added error handling for Sysprog's that don't RTFM.         *   FILE 708
//*                                                                 *   FILE 708
//*     The SETAUTO command will set the Automation flag ON, this   *   FILE 708
//*       will pass the message to any other automation packages,   *   FILE 708
//*       why I don't know, why would one need anything else.       *   FILE 708
//*                                                                 *   FILE 708
//*     The SETAUTONO command will set the Automation flag OFF,     *   FILE 708
//*       this will not pass the message to any other automation    *   FILE 708
//*       packages.                                                 *   FILE 708
//*                                                                 *   FILE 708
//*     The SETAMRF command will set the Automatic Retain on for    *   FILE 708
//*       that message, AMRF needs to be on for this to work.       *   FILE 708
//*                                                                 *   FILE 708
//*     This exit has been tested on OS/390 2.10, z/OS 1.4 z/OS 1.5 *   FILE 708
//*       z/OS 1.6 z/OS 1.7 z/OS 1.8.                               *   FILE 708
//*                                                                 *   FILE 708
//*     For existing users, if you're using a version previous to   *   FILE 708
//*       Version 5 please see $EXISTNG for proper replacment steps.*   FILE 708
//*                                                                 *   FILE 708
//*     Your next stop should be $INSTALL and $USAGE                *   FILE 708
//*                                                                 *   FILE 708
//*     This exit was originally started from CBT FILE345           *   FILE 708
//*       MPFXTALL courtesy of Murray Nicholas.  Thank you          *   FILE 708
//*       Murray for a great idea.                                  *   FILE 708
//*                                                                 *   FILE 708
//*     Also included are the DYNAMIC ALLOCATION Macros from        *   FILE 708
//*       CBT FILE615 courtesy of Lionel B Dyck.  Thank you         *   FILE 708
//*       Lionel for an easy and seamless way to implement          *   FILE 708
//*       Dynamic Allocation.                                       *   FILE 708
//*                                                                 *   FILE 708
//*     And also the read directory part of the MPFLOAD program     *   FILE 708
//*       was copied from CBT FILE558 courtesy of Dick              *   FILE 708
//*       Thornton.  Thanks Dick for the code you provided.         *   FILE 708
//*       Lots of good code there.  You should all have a look.     *   FILE 708
//*                                                                 *   FILE 708
//*     I'd also like to thank Marc Reibstein for his neet parsing  *   FILE 708
//*       routine @ http://www.marcsweb.com/mnweb_370trtparse.shtml *   FILE 708
//*       I no longer use this thanks to Garry's SRST command       *   FILE 708
//*       addition.                                                 *   FILE 708
//*                                                                 *   FILE 708
//*     And I'd like to thank Dave Mesiano and Mike Wojtukiewicz    *   FILE 708
//*       for there help with questions I've had.                   *   FILE 708
//*                                                                 *   FILE 708
//*     And last but not least to Sam Golob for pointing me to      *   FILE 708
//*       some neat HEX conversion macro and code.  Thanks Sam      *   FILE 708
//*       for enabling me to display the address and length of      *   FILE 708
//*       the Name/Token created and for all of your great work     *   FILE 708
//*       with CBT.                                                 *   FILE 708
//*                                                                 *   FILE 708
//*     I've included programs ASKOPER by Bill Godfrey and PAUSE    *   FILE 708
//*       since I use them and made reference to them in an example *   FILE 708
//*       of my automated shutdown see member SHUTDOWN.             *   FILE 708
//*                                                                 *   FILE 708
//*     And now I'd like to thank all the new contributors.         *   FILE 708
//*                                                                 *   FILE 708
//*  Contributed modifications:                                     *   FILE 708
//*                                                                 *   FILE 708
//*   Tom Lewis:                                                    *   FILE 708
//*       TL01 - Displays the message id causing the command/reply  *   FILE 708
//*              to be issued ie.  Ata'boy Tom.                     *   FILE 708
//*        /* Issued by MPFXTALL for messageID      */              *   FILE 708
//*                                                                 *   FILE 708
//*   Peter Johnson:                                                *   FILE 708
//*       PJ01 - Multi-line message handling, great addition.       *   FILE 708
//*       PJ02 - Multiple blanks allowed between words.             *   FILE 708
//*       PJ03 - Get Word length increased to 40 chars              *   FILE 708
//*       PJGS1 - Joint effort of AUTO/TOKEN by Peter and Glenn     *   FILE 708
//*                                                                 *   FILE 708
//*   Garry G. Green:                                               *   FILE 708
//*       GG01 - Code to enable MPFLOAD to act as a subsystem,      *   FILE 708
//*              this allows MPFLOAD to execute very early in the   *   FILE 708
//*              IPL, another great addition.                       *   FILE 708
//*       GG58 - IF ASTYPE and TSOROUTE                             *   FILE 708
//*       GG59 - ESATE protection for MPFXTALL ******* Thanks Garry *   FILE 708
//*                                                                 *   FILE 708
//*   Dean Tesar                                                    *   FILE 708
//*       DT01 - Code for suppressing joblog only messages NOJOBLOG *   FILE 708
//*              and syslog only messages NOSYSLOG.                 *   FILE 708
//*       DT02 - MPFSUPNO setting                                   *   FILE 708
//*       DT03 - Three and four digit replies                       *   FILE 708
//*       DT04 - Set AUTO NO setting                                *   FILE 708
//*                                                                 *   FILE 708
//*                                                                 *   FILE 708
//*     If you want to be on the mailing list send me an email.     *   FILE 708
//*                                                                 *   FILE 708
//*     All comments, suggestions or requests please send email.    *   FILE 708
//*                                                                 *   FILE 708
//*     Author: Glenn Siegel                                        *   FILE 708
//*             S.S.C. Corp.                                        *   FILE 708
//*             GlennSiegel@optonline.net                           *   FILE 708
//*             631-444-5339                                        *   FILE 708
//*             516-607-4005 Cell                                   *   FILE 708
//*             We do systems right!                                *   FILE 708
//*                                                                 *   FILE 708
