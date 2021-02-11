

                   SSSS H   H  AAA  RRRR  EEEEE DDDD
                  S     H   H A   A R   R E     D   D
                   SSS  HHHHH AAAAA RRRR  EEEE  D   D
                      S H   H A   A R  R  E     D   D
                  SSSS  H   H A   A R   R EEEEE DDDD

                      SSSS PPPP   OOO   OOO  L
                     S     P   P O   O O   O L
                      SSS  PPPP  O   O O   O L
                         S P     O   O O   O L
                     SSSS  P      OOO   OOO  LLLLL

                        M   M  OOO  DDDD   SSSS
                        MM MM O   O D   D S
                        M M M O   O D   D  SSS
                        M   M O   O D   D     S
                        M   M  OOO  DDDD  SSSS

                       for jes2 1.7 and jes2 1.8


  DISCLAIMER -

***********************************************************************
*                                                                     *
*     THE MODS ON THIS TAPE HAVE BEEN USED SUCCESSFULLY AND TO THE    *
*  BEST OF OUR KNOWLEDGE THEY ARE OPERATIONAL, HOWEVER NO WARRANTY IS *
*  MADE TO THE ACCURACY OF THE MODS AND NO RESPONSIBILITY IS ASSUMED  *
*  FOR ANY MODIFICATION DIRECTLY OR INDIRECTLY CAUSED BY THE USE OF   *
*  THE MODIFICATIONS.  IT IS THE USERS RESPONSIBILITY TO EVALUATE THE *
*  USEFULLNESS OF THE MATERIAL.                                       *
*                                                                     *
*     WE DO NOT GUARANTEE TO KEEP ANY MATERIAL PROVIDED UP TO DATE,   *
*  NOR DO WE GUARANTEE TO PROVIDE ANY CORRECTIONS OR EXTENSIONS MADE  *
*  IN THE FUTURE.                                                     *
*                                                                     *
***********************************************************************


  This is the installation PDS for the Shared Spool Mods for jes2 1.7
 and jes2 1.8.  The shared spool mods were formely known as the
 Mellon shared spool mods.

   All who use the shared spool mods owe a debt of gratitude to Mellon
 Bank for the original implementaion of the shared spool mods, but
 because it has been maintained outside of Mellon for a dozen years,
 and has been rewritten twice since then, we will refer to the mods
 as the SHARED SPOOL MODS from now on.  Once again -
                      THANK YOU MELLON BANK !



  In this PDS you should find the following members.

@@README -   That is this member, you are reading it.

DISCLAIM -   Our standard disclaimer - we guarentee / warrent nothing!

SSMINSTP -   Shared Spool Mods installation manual - PDF format

SSMINSTW -   Shared Spool Mods installation manual - Word Document

SSMUSERP -   Shared Spool Mods Users Guide - PDF format

SSMUSERW -   Shared Spool Mods Users Buide - Word Document

SSMOPSGP -   Shared Spool Mods Operations Guide - PDF format

SSMOPSGW -   Shared Spool Mods Operations Guide - Word Document

LSES500  -   THE Single usermod needed to install the entire package.

LSES501  -   A set of fixes to the original distribution - they are required.

LSES502  -   A set of fixes to the original distribution - they are required.

LSES500J -   Sample JCL to run the RECEIVE / APPLY Check / APPLY
    (You must apply lses500, lses501 and lses502 for the SHARED SPOOL MODS).

JES2PARM -   Sample JES2 parms needed to implement the package.


*** then we have the following three members - they are not really part of
*** the shared spool mods - but we have been distributing them, and some
*** folks still need them.  If you want to use these, you will have to
*** apply them seperately from the shared spool mods - we just have the
*** source - they are not setup as usermods.


STSCX01A -   our version of the page seperator exit. (not part of ssm's)

STSCX05B -   Prevent purging by job range. (not part of ssm's)

STSCX15A -   Causes FCBs to be reload with each job unless std forms.

STSCx36A -   SAF processing for jobs coming in from RJE/NJE sources.




  The documentation members suffixed with a 'P' i.e. SSMINSTP are PDF
format documents.  To use them you will need to transfer them to a PC
using your favorite file transfer program using a BINARY option - ie.
no translation.  You will probably need to make sure they are
transferred to a new file name that ends in ".PDF", or you may not be
able to read them.

  If you can not read PDF docs the original "WORD" formatted docs
are included in the members suffixed with a "W" i.e. SSMINSTW.  You
will probably need to offload them to a PC file with a suffix of DOC
to read them properly.


  The three basic pieces of documentation are -

1 The installation guide - gives background, installation instructions,
  and other information needed to setup the SHARED SPOOL MODS Package.

2 The Users Guide - gives detailed info on JECL statements and is aimed
  at the end users - whoever codes and uses JCL.

3 The Operations Guide - gives detailed informatin about all of the
  new JES2 display and modify commands avaialable with the package.





  Once you have the package setup - please drop me a line at
   SGMCCOLLEY@ALLTEL.NET  or STEPHEN.MCCOLLEY@SUNTRUST.BANK so that
  I can add you to the mailing list.  That way I can let you know about
  bugs, fixes, and new releases as I make the avaialable.

  If you drop me your REAL mailing address, I will send you a REAL
  "Shared Spool Mods" coffee cup - I still have plenty of these.

** end of doc **
