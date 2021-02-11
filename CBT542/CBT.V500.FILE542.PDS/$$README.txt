#* TEXT - $$README : Contains the overview for this PDS               */
/**********************************************************************/

 Here are a number of bits of handy REXX code, the list may well grow as
 I tidy up some of my REXX library.

 There are some of samples of using the DFSMS/MVS Catalog Search
 Interface (CSI). More detail can be found in :

 DFSMS/MVS - Managing Catalogs - Document Number SC26-4914
 Appendix D "Catalog Search Interface User's Guide"

 The original code was derived from the IBM provided sample in
 'SYS1.SAMPLIB(IGGCSIRX)' but has been heavily modified (including
 correcting the bugs in that code).

 Hopefully it is now correct and should work as intended. However as
 usual, no guarantee is implied.

 Most code is designed for either foreground or background execution.

 The pieces are as follows :

 #DELDUP  - Edit macro to delete duplicate lines

 #DELNDUP - Edit macro to delete non-duplicate lines

 ALICOUNT - This simply finds all of the aliases in the system and gives
            a count of datasets that are using them.
            Handy for finding all those redundant aliases cluttering up
            your mastercat.

 ALIMAKE  - So you have just disconnected a usercat and lost all the
            alises ... Reconnect the catalog and then run this to get
            a DEF ALIAS for all the 'suitable' HLQs in the catalog.

 BODGECAT - A sample workaround for a LISTDS on an uncataloged dsn.

 CSICODE  - Base CSI code, setup to be modified for other functions.
            As provided it simply list ALL entries.

 CSICODEV - Generates a LISTCAT like output for a VSAM file.
            Contains most of the CSI VSAM fields.

 CSITAPES - Stripped down version of above code to simply list all tape
            based datasets in the catalogs.

 DDSCAN   - Search a selected DD in JCL for a particular member.

 HFSSTAT  - Provide statistics for HFS files prior to the DSNINFO
            ISPF service provided at OS/390 V2R10.

 RCNVTCAT - A replacement for MCNVTCAT.
            This should allow those who are unhappy with IBMs removal of
            MCNVTCAT support to feel 'safe'. It is faster than MCNVTCAT
            and (hopefully) provides directly compatible output.
            (Just in case 'anyone' has rolled their own code to use
             the MCNVTCAT output).

            Also generates RECATALOG statements for PAGE and SYS1.**
            clusters.

            Also can be used to compare two catalogs.

 RDA      - An SDSF DA 'replacement' displays various fields that you
            would normally see in the SDSF DA display.

 RINIT    - An SDSF INIT 'replacement' displays various fields that you
            would normally see in the SDSF INIT display.

 SPACE    - Displays SMS pools and allow drill down to volume/dataset
            level. Has various extras including displaying the catalog
            status of all datasets on a volume.

 SYSINF   - Another system information REXX. There are others, some are
            worse, some are better - this is mine :-)

 TABLSTAT - Want to know when all those tables/profile members in a PDS
            were created/updated ? Well this will add normal PDS stats
            to all of the members matching the detail inside the
            table/s.

 I have also added MAKEINDX in case anyone is wondering what the point
 of the strange comments in everything are (and where the $$$INDEX came
 from).

 Have fun and I hope these help someone.

 Cheers - Alastair Gray (Consultant Systems Type)
          Lausanne, Switzerland 22nd November 2002

 ** UPDATE **

 I have now made a general change and modified all uses of the 'not'
 symbol (¬) to use a slash instead (/) as this does not seem to suffer
 as much from translation table problems.

 I have also attempted to remove the requirement for OMVS in my CSI code
 this was added after a request for a 'no-TSO' support option. The code
 should now allow for TSO or OMVS (one of them must be available).
 As usual, let me know if this causes problems elsewhere.

 Cheers - Alastair Gray (Consultant Systems Type)
          Lausanne, Switzerland 3rd March 2003

 ** UPDATE 2 **

 I have made two mods to the CSI based code, as a result of some bug
 reports and the great assistance of the reporters in running debug
 code for me (cheers to John and Don) :

 1. The code has been modified to handle CSIOPTNS set as either blank or
    'F' for fullword. This allows for field lengths greater than 65535.
    I have also changed the code so that for OS/390 R10 and above this
    option will be enabled automatically.
    Please note that at the time of writing, my handling of the fullword
    option is right - it is the manual(s) that are wrong.

 2. I have added some DEBUG options to create some handy - for me -
    info in sensitive areas.
    They are numbered to allow for further future debug areas ;-)#

 Cheers - Alastair Gray (Systems and Storage Type)
          Lausanne, Switzerland 14th January 2004
