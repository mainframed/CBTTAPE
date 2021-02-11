INTRODUCTION TO MPFXTALL PROCESSING

MPFXTALL is a very simple MPF exit which can be invoked through MPFLST
members of SYS1.PARMLIB in order to respond automatically to the
appearance of any message on the operator's console.  MPFXTALL does not
reply to WTORs at this stage, it simply issues operator commands as a
message occurs.


OPERATION

For any message to be automated, it must appear in
SYS1.PARMLIB(MPFLSTxx) with an entry such as the following:

IST123I,USEREXIT(MPFXTALL)

When message IST123I occurs, standard MVS MPF processing will invoke the
MPFXTALL exit.  MPFXTALL extracts the message id from the first 8 bytes
of the message text and then searches for a member with that name in
yourHLQ.MPFEXIT.COMMANDS.  Having found this member, MPFXTALL reads
each line and, if it is not a comment (an asterisk in column 1), issues
the command as supplied.

LIMITATIONS

Message numbers are restricted to a maximum of 8 bytes (length of a PDS
member name).  No code has been implemented to handle longer messages.

POSSIBLE FUTURE ENHANCEMENTS

1:  Add code to handle replies to WTORS
2:  Add code to handle "CALL" as a command.  This would call another
user written program (exit) to handle more complicated issues than
simply issuing a series of commands in response to a specific message.
3:  Add code to handle long message numbers.  Messages longer than 8
bytes would be identified in a member named to match just the first 8
bytes and the appropriate commands could by listed under each long
message number heading.

