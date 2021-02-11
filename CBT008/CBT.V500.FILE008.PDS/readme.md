
## @FILE008.txt
```
//***FILE 008 now contains the jobs used by Sam Golob to create     *   FILE 008
//*           this tape.  This stuff (in Arnie's time) used to      *   FILE 008
//*       be part of File 001, but it was taken out by Sam Golob    *   FILE 008
//*       for lack of space.  Also, the jobs at the Connecticut     *   FILE 008
//*       Bank used different JCL than we now use.  So we are       *   FILE 008
//*       now re-inserting our JCL on the CBT Tape here in          *   FILE 008
//*       File 008, so you can get an idea about how this tape      *   FILE 008
//*       was created.  Load modules for the programs found         *   FILE 008
//*       in this JCL can be found in the member LOADLIB, which     *   FILE 008
//*       is in TSO XMIT format.  (dsn: SBGOLOB.CBTCREAT.LOAD)      *   FILE 008
//*                                                                 *   FILE 008
//*       Materials and programs which I use to package the         *   FILE 008
//*       INDIVIDUAL FILES on this tape, may be found on File 006.  *   FILE 008
//*                                                                 *   FILE 008
//*       See member $$$$NOTE which tells you that this file is     *   FILE 008
//*       not really accurate until after production of the tape    *   FILE 008
//*       version is complete.  So look on the Updates page for     *   FILE 008
//*       the ACCURATE version of this file, which was actually     *   FILE 008
//*       used to create the previous tape version.                 *   FILE 008
//*                                                                 *   FILE 008
//*      - - - - - - - - - - - - - - - - - - - - - - - - - - - -    *   FILE 008
//*      >>                                                   <<    *   FILE 008
//*      >>  Description of creating the tape and reloading   <<    *   FILE 008
//*      >>  its files to the www.cbttape.org web site:       <<    *   FILE 008
//*      >>                                                   <<    *   FILE 008
//*      - - - - - - - - - - - - - - - - - - - - - - - - - - - -    *   FILE 008
//*      *                                                     *    *   FILE 008
//*      * After the tape has been created, using the jobs     *    *   FILE 008
//*      * NEWT500*, it was then unloaded to disk, using the   *    *   FILE 008
//*      * jobs V500J** and the pds'es converted to TSO XMIT   *    *   FILE 008
//*      * format using the jobs V500X**.  All the files are   *    *   FILE 008
//*      * then FTP'ed to the PC.                              *    *   FILE 008
//*      *                                                     *    *   FILE 008
//*      * For zipping, I use WinRAR (the authentic version    *    *   FILE 008
//*      * from their web site www.rarlab.com).  And then I    *    *   FILE 008
//*      * FTP all the zipped files to the www.cbttape.org     *    *   FILE 008
//*      * web site.                                           *    *   FILE 008
//*      *                                                     *    *   FILE 008
//*      * On the PC, I rename all the zipped files from names *    *   FILE 008
//*      * FILEnnn.zip to CBTnnn.zip, with a capital "CBT".    *    *   FILE 008
//*      * These are then uploaded to the www.cbttape.org      *    *   FILE 008
//*      * web site to refill the CBT directory there.         *    *   FILE 008
//*      *                                                     *    *   FILE 008
//*      * Several tape copying and tape mapping programs      *    *   FILE 008
//*      * are used, as described in the rest of the NEWT500*  *    *   FILE 008
//*      * jobs.  The program load modules for these, have     *    *   FILE 008
//*      * been supplied in the member LOADLIB.                *    *   FILE 008
//*      *                                                     *    *   FILE 008
//*      - - - - - - - - - - - - - - - - - - - - - - - - - - - -    *   FILE 008
//*                                                                 *   FILE 008
//*        Other materials included here:                           *   FILE 008
//*                                                                 *   FILE 008
//*        Member CBTSTATS (dated CBT Version 320) contains         *   FILE 008
//*        some of Arnie's old job stats, which he recorded for     *   FILE 008
//*        his own records.  The information in this member         *   FILE 008
//*        contains the (clock time) length of his runs, exact      *   FILE 008
//*        footages, and record counts, etc.  I don't want to       *   FILE 008
//*        leave it out.  Arnie Casinghino forged the spirit        *   FILE 008
//*        of this collection, and dedicated his every extra        *   FILE 008
//*        effort to its continuance.  I had a very big act         *   FILE 008
//*        to follow, in trying to maintain and enhance Arnie's     *   FILE 008
//*        work of 15 years.  Arnie definitely set the tone         *   FILE 008
//*        for everything that you see here.                        *   FILE 008
//*                                                                 *   FILE 008
//*        Arnie's data on this file extends through Version        *   FILE 008
//*        320 of this tape.  Arnie supported this tape through     *   FILE 008
//*        Version 321.  After that point, the management of        *   FILE 008
//*        the CBT Tape was taken over by me (Sam Golob), in        *   FILE 008
//*        Sept. 1990.  My first tape version was Version 322.      *   FILE 008
//*                                                                 *   FILE 008
//*      - - - - - - - - - - - - - - - - - - - - - - - - - - - -    *   FILE 008
//*                                                                 *   FILE 008
//*        I kept the tape up across an assortment of jobs,         *   FILE 008
//*        and also through the kindness of several data            *   FILE 008
//*        centers, all of whom are owed a big "thank you".         *   FILE 008
//*                                                                 *   FILE 008
//*        VERY VERY SPECIAL THANKS go to the late Gilbert          *   FILE 008
//*        Saint-flour, who left us too soon.  Gilbert was          *   FILE 008
//*        solely responsible for providing a work platform         *   FILE 008
//*        to support the making of this tape, for at least         *   FILE 008
//*        5 years.  He owned a P/390 that he used, to run his      *   FILE 008
//*        business, and he gave me a userid on his machine         *   FILE 008
//*        so I could support the CBT Tape from there.              *   FILE 008
//*        Later on, when I was working at an MVS site in           *   FILE 008
//*        another company, the lines were always open to           *   FILE 008
//*        Gilbert's machine as well, so that everything could      *   FILE 008
//*        be preserved and none of the material ever got lost.     *   FILE 008
//*        BTW this was with written permission from that           *   FILE 008
//*        company.                                                 *   FILE 008
//*                                                                 *   FILE 008
//*        More thanks........                                      *   FILE 008
//*                                                                 *   FILE 008
//*        Also, big thanks have to go to Scott Sherer and          *   FILE 008
//*        NaSPA, for contracting to duplicate the tapes after      *   FILE 008
//*        I made the first one.  This went on for almost ten       *   FILE 008
//*        years, until we started the www.cbttape.org website      *   FILE 008
//*        at the end of 1998.  NaSPA's support began in 1989,      *   FILE 008
//*        when Arnie was still making CBT Tapes at CBT.            *   FILE 008
//*                                                                 *   FILE 008
//*        Even before Arnie's shop lost their tape drives,         *   FILE 008
//*        Scott and NaSPA were already duplicating CBT tapes       *   FILE 008
//*        at Deluxe Check Printers.  Credit goes to Marty Kuntz    *   FILE 008
//*        who worked duplicating the tapes at Deluxe.              *   FILE 008
//*                                                                 *   FILE 008
//*        Arnie's "Connecticut Bank & Trust" data center           *   FILE 008
//*        got rid of their tape drives in 1990.                    *   FILE 008
//*        (We had about 1 1/2 years' advance warning before        *   FILE 008
//*        we were obligated to completely switch over).            *   FILE 008
//*                                                                 *   FILE 008
//*        Even more special thanks go to Sam Knutson, who          *   FILE 008
//*        started the website, paid for it himself for a while,    *   FILE 008
//*        administers it, and so forth.  The fact that he put      *   FILE 008
//*        it on a reliable provider with much redundancy and       *   FILE 008
//*        almost no down time, is a great boon to someone who      *   FILE 008
//*        is doing an IPL of a new system during off hours,        *   FILE 008
//*        especially on a Sunday.                                  *   FILE 008
//*                                                                 *   FILE 008
//*        We owe a big debt of gratitude to Innovation Data        *   FILE 008
//*        Processing, the makers of FDR and other fine software    *   FILE 008
//*        products, for sponsoring the www.cbttape.org web site    *   FILE 008
//*        during much of its existence (for at least 15 or 16      *   FILE 008
//*        years by now).  Thanks to John Mazzone in particular.    *   FILE 008
//*                                                                 *   FILE 008
//*        If some tool breaks, while you are installing a new      *   FILE 008
//*        version of z/OS, you can hunt around on our site for     *   FILE 008
//*        a newer version of what broke, and the hour doesn't      *   FILE 008
//*        matter.  The credit for this convenience, goes solely    *   FILE 008
//*        to Sam Knutson.  (sknutson@cbttape.org)                  *   FILE 008
//*                                                                 *   FILE 008
//*        Many other pats on the back go to Sam Knutson, also.     *   FILE 008
//*        (This is for a lot of other stuff he does, to            *   FILE 008
//*        constantly contribute, and for his continued and         *   FILE 008
//*        continuous enthusiasm.  AND for his sessions at SHARE.)  *   FILE 008
//*                                                                 *   FILE 008
//*        Our gratitute goes out to all the other data centers     *   FILE 008
//*        which have helped me out over the years:                 *   FILE 008
//*        (I have left several of them out intentionally, but      *   FILE 008
//*        we still owe all of them a "thank you".)                 *   FILE 008
//*                                                                 *   FILE 008
//*        0-  Newsweek, Inc, of course.....                        *   FILE 008
//*             Credit goes posthumously to my boss Stan McGinley.  *   FILE 008
//*        1-  First National Bank of Toms River, NJ.               *   FILE 008
//*             Credit goes to Fred Hetzel.                         *   FILE 008
//*        2-  Jensen Research Corp.  (Credit to Eric Jensen)       *   FILE 008
//*        3-  Brooklyn College of the City of New York             *   FILE 008
//*             (To Howard Givner and the whole crew there)         *   FILE 008
//*        4-  City University of New York                          *   FILE 008
//*             (Ben Klein and Aron Eisenpress in particular.)      *   FILE 008
//*        5-  DOITT - Department of Information Technology         *   FILE 008
//*             and Telecommunications - New York City              *   FILE 008
//*             (To everyone there--a wonderful environment)        *   FILE 008
//*        6-  The Great Atlantic and Pacific Tea Company           *   FILE 008
//*             (Now also defunct. They were helpful.)              *   FILE 008
//*                                                                 *   FILE 008
//*  ===>> 7-  An extra special thank you, of the highest order,    *   FILE 008
//*             must be made to the Open Mainfram Project of the    *   FILE 008
//*             Linux Foundation who (as of September 2020) have    *   FILE 008
//*             made their z14 mainframe available to us for the    *   FILE 008
//*             purpose of software development for CBT Tape        *   FILE 008
//*             products.  Thank you to all the people there, too   *   FILE 008
//*             numerous to mention.  And thank you to all the      *   FILE 008
//*             CBT Tape contributors who are using this system     *   FILE 008
//*             to further develop their products that we are       *   FILE 008
//*             distributing here.                                  *   FILE 008
//*                                                                 *   FILE 008
//*        I worked for my father, Milton J. Golob, of blessed      *   FILE 008
//*        memory, for about a year.  During that time, I was       *   FILE 008
//*        accumulating contribution tapes (this was before         *   FILE 008
//*        the Internet) in several satchels.  My father gave       *   FILE 008
//*        me a few months off, so I could work at an MVS           *   FILE 008
//*        site and make CBT Tapes there.  Many thanks to him too!  *   FILE 008
//*        (He allowed me to accept the contract at Brooklyn        *   FILE 008
//*        College while I was still working for him.)              *   FILE 008
//*                                                                 *   FILE 008
//*        More thanks go to the many contributors of material.     *   FILE 008
//*        THE ENTIRE COLLECTION DEPENDS ON ALL OF YOU.......       *   FILE 008
//*                                                                 *   FILE 008
//*        Separate thanks go to people who help me fix things      *   FILE 008
//*        on a regular basis:  John McKown, Bill Godfrey, Greg     *   FILE 008
//*        Price, John Kalinich, Ze'ev Atlas, Gabriel Gargiulo,     *   FILE 008
//*        Roland Schiradin, Willy Jensen, Robert AH Prins, Rob     *   FILE 008
//*        Prins (two different people), and many, many others.     *   FILE 008
//*        I can't mention everybody, but many thanks to you        *   FILE 008
//*        all...!!                                                 *   FILE 008
//*                                                                 *   FILE 008
//*        Other thanks go to people who insisted that I NOT        *   FILE 008
//*        BE ABLE TO MAKE ONE PENNY from this endeavor.  It        *   FILE 008
//*        has certainly kept the spirit of the CBT Tape up,        *   FILE 008
//*        and the costs down.  All the best of everything to       *   FILE 008
//*        all of you.  (I mean it.)  YOU KNOW WHO YOU ARE...!!     *   FILE 008
//*                                                                 *   FILE 008
//*        R.I.P. to Dave Andrews and John Hooper, my dear friends. *   FILE 008
//*               And of course to Rick Fochtman, Ken Tomiak,       *   FILE 008
//*               and Gerhard Postpischil.                          *   FILE 008
//*                                                                 *   FILE 008
//*        John Hooper is responsible for very reliable code,       *   FILE 008
//*        in CBT File 019.                                         *   FILE 008
//*                                                                 *   FILE 008
//*        Much of Gerhard's code is in CBT Files 860, 861, & 862.  *   FILE 008
//*        These are very large files, and are worth exploration.   *   FILE 008
//*                                                                 *   FILE 008
//*        You all owe Dave Andrews and his former boss, Bill       *   FILE 008
//*        Winters, for the fact that you are able to have the      *   FILE 008
//*        HLASM Assembler.  WITHOUT THEM, YOU WOULDN'T HAVE IT.    *   FILE 008
//*        Both of them have also passed on, as has John Ehrman.    *   FILE 008
//*        We have to be grateful to all of them, for their work.   *   FILE 008
//*                                                                 *   FILE 008
```

