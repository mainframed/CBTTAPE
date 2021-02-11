
## $README.txt
```
TXT2XML
=======

   From TXT (flat files) to XML and vice-versa.

1) Introduction
---------------

   In 2002, after a XML internet course, I was thoughful. Strange, I
   thought : XML and COBOL, there are concepts in common. Hierarchy of
   data, identation for a better visualization, complex entities (in
   COBOL : group items), ... Wouldn't it be interesting if it was
   possible to convert data from a flat file to XML one using a COBOL
   copybook ?

   Nobody will stop XML (r)evolution and in my administration, there
   are plenty of COBOL copybooks and ... flat files So why not ? And
   in September 2002, the first release of TXT2XML was released.

   "Interesting" say my collegues. But after the migration of all of
   our programs to the EURO currency, nobody was ready to investigate
   this technology. There were too much projects that have been
   delayed ...

   So, TXT2XML was frozen until 2004 when somebody asked me to make
   conversion in both senses (to and from XML).

2) Installation
---------------

   Very simple :

   a) copy the TXT2XML.PANEL(TXT2XML) to your ISPF panel dataset.
   b) copy the TXT2XML.EXEC(TXT2XML) to your ISPF EXEC or REXX
      dataset.
   c) copy the TXT2XML.CNTL(TXT2XML) to your JCL DATASET and submit
      the job. The JCL step names ending with KO should end with a
      RC = 12 and the JCL step names ending with OK should end
      with a RC = 0 or 4.

3) Function / History
---------------------

   Function:  Convert a text dataset to of from a XML one using a
              COBOL copybook as reference.

   Invoked from: The ISPF command line (TSO TXT2XML), an another REXX,
                 a batch job.

   30/09/02 - Version 0.1
     + start
     + indent XML according to the item level.
   04/11/02 - Version 0.2
     + handle multi-line cobol item declaration.
     + ignore line numbers in columns 1-6 & 73-80
     + ignore level 66, 77, 88 items.
     + stop if level is greater than 50.
     + stop if level is not numeric.
     + stop if some COBOL reserved words are found.
     + replace 9(4) by 9999 and X(3) by XXX.
   06/11/02 - Version 0.3
     + handle OCCURS clause for group
       and elementary items.
   21/11/02 - Version 1.0
     + read line by line instead of reading all  lines.
     + write line by line instead of writing all lines.
     + accept any case for COBOL item names.
   28/06/04 - Version 1.1 RC1
     + Bug corrected : VALUES COBOL clauses are now ignored.
     + Make conversion in both senses from XML to
       TXT and from TXT to XML.
     + Renumber cobol levels from 1 by 1 so that
       identation of XML is independent of absolute COBOL levels.
     + Change input file parameter name to txt and
       output file parameter name to xml.
     + Added a x000 "Records processed" message.
     + Added a error message if the file transfer
       of TXT2XML has changed verticals bars
       (concatenation and OR operator) to |.
     + Added a report of cobol items: level, name
       type, start and length .
     + During conversion from XML to TXT, check
       that XML numeric values are really numeric.
     + Error force termination of the program
       with return code set to 12.

4) Warnings
-----------

     - You have to parse the XML file with the corresponding
       DTD, XML schemas. This REXX will not do any parsing.
     - Attributes of XML elements are ignored.
     - XML with mixed contents is not supported.
     - Element content is supposed to be on only one line
     - Before the conversion from XML to TXT,
       THE XML INPUT FILE MUST BE "XML WELL-FORMED".
     - Two ( or more ) dimmension arrays are not supported.
     - level 66, 77, 88 are ignored.
     - binary and packed-decimal data are not supported.
     - Escaping of special characters (&lt; instead of <) is
       not supported.
     - CDATA is not supported.

5) Todo
-------

     - Support of COBOL binary and packed data ?
     - Support of attributes of XML elements ?
     - Support of CDATA
     - Support of escape chars like &lt; for "<"
     - Support of element content on more than one line

6) Bugs, comments and remarks ...
---------------------------------

     are expected with great impatience. Submit them to

        sunuraxi@users.sourceforge.net

     with as much info as possible :-))))

     Web site : http://sourceforge.net/projects/txt2xml-rexx/

```

