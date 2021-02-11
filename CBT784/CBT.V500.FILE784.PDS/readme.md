
## $$DOC.txt
```
 Author: John A. McKown
 Email: joarmc@swbell.net
 Support: None guaranteed, but I would like "bug" reports.
 Latest email:  "McKown, John" <john.archie.mckown@GMAIL.com>

 This contains two different implementations of a Web page which allows a
 user to get data set information similar to ISPF option 3.4.

 Both implementations use AJAX to update the Web page "in place". The
 first is the simpler because the CGI actually creates the HTML for the
 Web page and the Javascript on the Web page simply puts that HTML on the
 page. The second is more complex in that the CGI actually creates the
 text form of a JSON object.  The Javascript on the Web page then
 instatiates this object which it uses to dynamically create the HTML to
 display. The second form is more powerful in that the JSON object can
 be used in other ways by other AJAX code.

 The RECEIVE member in this PDS shows the general way to recreate the
 z/OS dataset which needs to be copied into a UNIX file in order to be
 unwound. This dataset is a "pax" archive which contains both the HTML
 and REXX (CGI) code needed to implement this. When unwound, the pax
 archive will create a "dslist" and "dslist-bin" subdirectory in the
 current subdirectory. Before unwinding the pax archive, you should "cd"
 to the HTTPD's "root" directory. This is usually
 /usr/lpp/internet/server_root.

 You need to update the HTTPD server's configuration file with code
 similar to the following:

Protection dslisting  {
        ServerId        Use_Mainframe_ID
        AuthType        Basic
        PasswdFile      %%SAF%%
        UserID          %%CLIENT%%
        Mask            All
}

Protect /dslist/* dslisting
Protect /dslist-bin/* dslisting

Exec  /dslist-bin/*  /usr/lpp/internet/server_root/dslist-bin/*
Pass  /dslist/*      /usr/lpp/internet/server_root/dslist/*

 The Protection directive above requires that the Web user present a
 valid RACF userid and password in order to access the site. It may be
 possible to remove this so that anyone can do this function without any
 validation. I do not regard this as a good idea and have not tested
 whether it works or not. It may or may not depending on the RACF
 security at your installation. In particular, it depends on the access
 lists for the datasets referenced in the TSO/REXX program. If you do
 not require the "login", the CGI will run with a default RACF id which
 may not have READ access to the required datasets.  Even more
 restrictions as to which RACF users can use this function can be
 implemented by using UNIX acls (Access Control Lists) on the UNIX
 subdirectories containing the UNIX/REXX CGI program and the HTML web
 page.  Discussing how to do this is beyond the scope of this
 documentation.

 As mentioned before, there are two versions of this code. The first is
 the HTML version. It has three elements. One is a TSO/REXX program,
 DSLIST4, which must reside in a generally accessible REXX program
 library. The second is a UNIX/REXX CGI program, dslist-html.rexx, which
 resides in the "dslist-bin/" subdirectory beneath your HTTPD server's
 "root" directory.  The third is an HTML file, dslist-html.html, which
 resides in the "dslist/" subdirectory beneath your HTTPD server's
 "root" directory.

 The second is the more advanced JSON version. It also has three
 elements. The first is the TSO/REXX program, DSLIST0, which must reside
 in a generally accessible REXX program library. The second is a
 UNIX/REXX CGI program, dslist-json.rexx, which resides in the
 "dslist-bin/" subdirectory beneath your HTTPD server's "root"
 directory.  The third is an HTML file, dslist-json.html, which resides
 in the "dslib/" subdirectory beneath your HTTPD server's "root"
 directory.

 The JSON version is more advanced because it could be used as the basis
 for implemetning a SOAP service to deliver dataset information to other
 platforms.  JSON is well supported by code written in JavaScript,
 python, and Perl. I am not sure, but it is likely supported by Ruby as
 well. I do not know which, if any, Microsoft technologies support JSON.
 If you want more information, try your favorite Internet search engine.

 As an example of returning a JSON object to something other than a
 browser, the "wget" command could be used something like:

 wget --http-user=user --http-password=password \
   'http:/server/dslist-bin/dslist-json.rexx?index=SYS1.M*LIB' \
   -O dslist.json

 The above command, when customized, should return a JSON text object
 with the requested information into the file "dslist.json".

 Required customization:

 You must customize the "dslist-html.rexx" and "dslist-json.rexx"
 programs to refer to the dataset containing the DSLIST4 and DSLIST0
 programs respectively. As distributed, the dataset name in both of
 these programs is SYS1.LI.CLIST.CNTL which is our general purpose
 TSO/REXX program library. You can place the TSO/REXX programs in any
 library you want, but the users of the function must have at least READ
 access to them. These libraries do not need to be placed in any TSO
 procedure.

 You may need to customize the DSLIST0 and DSLIST4 programs if your shop
 does not name its ISPF libraries the way that we do. I use the names as
 distributed by IBM. That is: ISP.SISPnnnn .

 If you do not want to place the UNIX code in the "dslist" and
 "dslist-bin" subdirectories, then you must change the
 "dslist-html.html" and "dslist-json.html" files to refer to the
 location where you placed them. You will also need to change the
 example HTTPD configuration entries.


 Logic overview of the HTML version.

 The Web page displays some help text as well as a data entry field in
 which the user enters the name of the dataset to be looked up or a
 dataset name pattern. There is a drop down box which contains 4 values,
 only one of which may be selected. This is equivalent to ISPF option
 3.4's "Volume", "Space", "Attribute", or "Total" option. There is also
 a single button labelled "Perform Lookup" which invokes the AJAX
 process to do the lookup. Pressing the "Perform Lookup" button invokes
 the JavaScript routine "sendLevel()". This routine first removes the
 previous output from the Web page, then sets up the AJAX environment,
 issues a GET request to the HTTPD server to invoke the UNIX/REXX
 routine "dslist-bin/dslist2-html.rexx".  When the HTTPD server returns
 the information requested, the "parseGetResponse()" Javascript function
 is invoked. This function updates the Web page with the information
 requested. It does this my simply using the data returned to if from
 the dslist2-html.rexx program as-is with no processing. This is
 possible because the DSLIST4 returns the required HTML directly.

 The UNIX/REXX program "dslist-bin/dslist2-html.rexx" first decodes its
 input using the "cgiparse" routine supplied by IBM for this purpose.
 This creates two REXX variables: FORM_LEVEL which is the value to be
 looked up, and FORM_OPTION which is the output desired. It then invokes
 the DSLIST4 TSO/REXX routine with the "address TSO" function. This
 particular line needs to be customized in order to specify the TSO/REXX
 library which contains the DSLIST4 program. The UNIX program traps the
 output of DSLIST4 by use of the "OUTTRAP" function.  Unfortuntely, the
 "address TSO" function ends up putting out messages of its own. In
 order to filter those out, the UNIX/REXX program ignores all lines
 which do not begin with a less than sign.

 The TSO/REXX program "DSLIST4" first determines if it is running under
 ISPF. If it is not, then it allocates the ISPF libraries (which may
 need customization at your shop) and reinvokes itself with an ISPSTART
 command.  Once in ISPF, the program uses the LMDINIT and LMDLIST
 functions to retrieve the requested data. The program uses the SAY verb
 to print its output to the dslist2-html.rexx program.  Due to a
 restriction on the length of a line, there are multiple SAY verbs for
 each logical line of output. This does not cause any problem with the
 Web page because the HTML renderer ignores end of line characters. The
 DSLIST4 actually creates the HTML for the table which is then sent to
 the Web page's Javascript "parseGetResponse" function.

 If you update the DSLIST4 program by adding or changing any SAY
 instruction, it is critical that the first character of the line start
 with a < character. This is because dslist2-html.rexx will not return
 any line not starting with a < to the Web page. Also the < character
 must be part of the valid HTML response.

 The only customization which is absolutely required to change the name
 of the TSO/REXX program library which is in the "dslist2-html.rexx"
 program. The DSLIST4 determines where it is executing from and so does
 not "hard code" any TSO/REXX program library. It may be necessary to
 customise the DSLIST4 program if your ISPF libraries are not the same
 as mine.  Please look in the DSLIST4 source code. This customization
 should be simple. My ISPF libraries all start with ISP.SISP*



 Logic overview of the JSON version.

 The Web page displays some help text as well as a data entry field in
 which the user enters the name of the dataset to be looked up or a
 dataset name pattern. There is a drop down box which contains 4 values,
 only one of which may be selected. This is equivalent to ISPF option
 3.4's "Volume", "Space", "Attribute", or "Total" option. There is also a
 single button labelled "Perform Lookup" which invokes the AJAX process
 to do the lookup. Pressing the "Perform Lookup" button invokes the
 JavaScript routine "sendLevel()". This routine first removes the
 previous output from the Web page, then sets up the AJAX environment,
 issues a GET request to the HTTPD server to invoke the UNIX/REXX
 routine "dslist-bin/dslist-json.rexx".   When the HTTPD server returns
 the information requested, the "parseGetResponse()" Javascript function
 is invoked. This function updates the Web page with the information
 requested.

 The "parseGetResponse()" function in this version is much more
 complicated than in the HTML version. That is because it must first
 convert the text JSON object returned to it by the dslist-json.rexx
 program into an actual JavaScript object. This is done rather simply
 using the "eval" JavaScript function. Note that this function can only
 be used when the JSON object coming from the server can be 100%
 trusted. In this particular case, that is true.  For information coming
 from other sites or even from an internal site which you do not
 control, this may not be true. Caution is recommended.

 The parseGetResponse() function uses the information in the JSON
 object, along with the "option" speicified by the user (Volume, Space,
 Attr, or Total) to create the HTML which is then used to dynamically
 update the Web page.

 The UNIX/REXX program "dslist-bin/dslist-json.rexx" first decodes its
 input using the "cgiparse" routine supplied by IBM for this purpose.
 This creates two REXX variables: FORM_LEVEL which is the value to be
 looked up, and FORM_OPTION which is the output desired. FORM_OPTION is
 not actually used by this routine at present, but it is passed to the
 DSLIST0 program.  It then invokes the DSLIST0 TSO/REXX routine with the
 "address TSO" function. This particular line needs to be customized in
 order to specify the TSO/REXX library which contains the DSLIST0
 program. The UNIX program traps the output of DSLIST0 by use of the
 "OUTTRAP" function.  Unfortuntely, the "address TSO" function ends up
 putting out messages of its own. In order to filter those out, the
 UNIX/REXX program ignores all lines which do not begin with a less than
 sign. It also strip off those leading < characters. This last step is
 unlike the DSLIST4 program, which leaves the leading < characters
 intact.

 The TSO/REXX program "DSLIST0" first determines if it is running under
 ISPF. If it is not, then it allocates the ISPF libraries (which may
 need customization at your shop) and then reinvokes itself with an
 ISPSTART command.  Once in ISPF, the program uses the LMDINIT and
 LMDLIST functions to retrieve the requested data. The program uses the
 SAY verb to print its output to the dslist-json.rexx program. Due to a
 restriction on the length of a line, there are multiple SAY verbs for
 each logical line of output. The DSLIST0 program creates a text JSON
 object which is passed to the "dslist-json.rexx" program which does
 some post processing (removing leading < characters) and then sends
 them on to the Web browser.

 The only customization which is absolutely required to change the name
 of the TSO/REXX program library which is in the "dslist-json.rexx"
 program. The DSLIST0 determines where it is executing from and so does
 not "hard code" any TSO/REXX program library. It may be necessary to
 customise the DSLIST0 program if your ISPF libraries are not the same
 as mine.  Please look in the DSLIST0 source code. This customization
 should be simple. My ISPF libraries all start with ISP.SISP*

```

