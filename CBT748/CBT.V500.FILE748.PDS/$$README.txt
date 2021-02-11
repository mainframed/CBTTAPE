 This is a small system to control
 the transfer of programs from Development into
 Production Environment.
 The idea behind it is to give the head of section
 (whom approves the transfers) the comfort of doing
  it from their email client inbox, without forms
 and without needing to log into the mainframe.

 The process starts when a REXX routine creates
 a transfer request into a file. Later, a program
 named MAILSEND is called to build an email
 and send it to the SMTP daemon server, which
 sends it to the Microsoft exchange server.
 Once the user receives the email he either
  Approve  or  Reject  the program transfer
 and sends it back to the mainframe.

 The email arrives at the mainframe and is received
 by a program named MAILRECV which is started
 at every 5 minutes (via STC).
 The program issue a  receive  to read the email
 and to process a message files which comes
 as an attachment of the email (file POSTDATA.ATT).

 Once this message is decoded it calls another REXX program
 which updates a file with the pending transfer requests and
 also calls others processes to make the transfer.

 Here is a summary of the members in this library:

1. CALLDECA   REXX sample program used to call DECODE64
   (the call is external to the routine)
   Note: DECODE64 may reside on LLA or LPA

2. CALLDECR   REXX sample program used to call DECODREX
   (the call is internal to the routine; both routines must be part
    of the same REXX program)

3. CALLSEND   REXX sample program used to call MAILSEND

4. DECODE64   Assembler program for decoding the BASE64

5. DECODREX   REXX program for decoding the BASE64

6. MAILPARM   Parameter file pointed by SYSTSIN on the PROCMAIL

7. MAILRECV   REXX program which is called to receive the email
   at the Mainframe. At the end of the routine we will have:

  Variables y.1  y.2 and y.3 have the time the email was received
  the sender and the plain text from the DECODE64.
  Example:
  y.1 = Email Received at:  Sat  4 Nov 2006 21:08:27 +0300
  y.2 = From: "Jose Neto" <joserfneto@yahoo.co.uk>
  y.3 = Message Content is: group1=Approve+Order+12345

  In our system we address a table where the key is the order
  number and set the approval status.
  Also  MAILRECV saves the log from the email in a file with a
  DSNAME in the format: MAILCH.LOG.MISC.D041106.T210648meaning
  it t was received at 4/11/200 at 21:06:48.

  Note: the base64 text will come in a file which is attached
  to the email with a filename="POSTDATA.ATT"

8. MAILSEND  REXX program which is called to send the email
   to the Microsoft Exchange Server
   The email is formatted using HTML tags.

   You do not need to be a expert on HTML language to code it.
   The following sites were my guideline to build it:

   http://www.tizag.com/htmlT/forms.php
   http://www.w3.org/TR/REC-html40/cover.html#minitoc
   http://www.htmlgoodies.com/tutorials/forms/article.php/3479121
   http://www.w3.org/TR/REC-CSS1

9. PROCMAIL   The procedure used to call MAILRECV REXX Program

   Note: the RACF User associated with the Procedure has to be
   the same as the one used in the MAILSEND program. In our case
   it was named MAILCH
   (check strings  MAIL FROM:  and  FROM: on the MAILSEND program)

10. SENDMAIL   A sample JCL which you might use to build up
   and test your own HTML form before inserting it into the
   MAILLSEND program.

   Note: The SMTP configuration is not very difficult. You will
   find all the information you need in the manuals:
   IP Configuration Guide at section  Configuring the SMTP server
   and
   IP Configuration Reference at chapter  SMTP Server
