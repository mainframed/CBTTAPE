The MAXITRAN exec is used to script batch FTP between an MVS client
and another FTP server. It provides functions such as delete of
source files after GET (delete is the default!). Read the doc
"maxitran.doc" for complete documentation.

This software is distributed into the public domain "as-is" by
Rob Wunderlich (RobWunderlich@ussposco.com).

To execute maxitran, copy the member "PROC" to a proclib (or JCLLIB)
as member "MAXITRAN". Update the SYSPROC DD stmt to point to this PDS.


Customizations required before you use this at your site:
-- Member MAXITRAN --
1)The shipped default is "GETDELETE YES" which means files will
be deleted from the server after a sucessfull GET. If you want to
change the default for your shop, change the line
  flagGetDelete=1
to
  flagGetDelete=0

2)If you use the email feature, you might want to
update subroutine "sendmail" to use "HELO" and "FROM" values that
are meaningful for your site.

The email email routine expects that you have an MVS SMTP server
set up named "SMTP" that services output class B.
