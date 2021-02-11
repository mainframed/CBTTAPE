```
//***FILE 745 is contributed semi-anonymously and contains a very   *   FILE 745
//*           comprehensive file browser package called FM.  This   *   FILE 745
//*           is still a work in progress, but it is probably       *   FILE 745
//*           quite a useful tool already, as it now is.            *   FILE 745
//*                                                                 *   FILE 745
//*           Questions:  email sbgolob@cbttape.org                 *   FILE 745
//*                             sbgolob@attglobal.net               *   FILE 745
//*                                                                 *   FILE 745
//*           To install, run the $TSORECV member after             *   FILE 745
//*           customizing it to your installation's standards,      *   FILE 745
//*           and then look at the FM.DOC pds which results.        *   FILE 745
//*                                                                 *   FILE 745
//*   Description of the FM product.                                *   FILE 745
//*                                                                 *   FILE 745
//*     FM  (File Formatter)                                        *   FILE 745
//*                                                                 *   FILE 745
//*     FM allows users to view sequential files, PDSs, PDSEs,      *   FILE 745
//*     and VSAM files of most types and VTOCs.                     *   FILE 745
//*                                                                 *   FILE 745
//*     The purpose of FM is to allow data to not only be           *   FILE 745
//*     viewed in plain text, but also to be 'formatted'.  The      *   FILE 745
//*     design of FM allows new formats to be added easily.         *   FILE 745
//*     Some types of data common to most all MVS (OS/390, z/OS     *   FILE 745
//*     or whatever it is called now) systems like SMF are          *   FILE 745
//*     already known (at least some SMF record types).             *   FILE 745
//*                                                                 *   FILE 745
//*     The utility determines the data set's DSORG                 *   FILE 745
//*     dynamically.  That is it determines if the data set is      *   FILE 745
//*     sequential, a PDS, VSAM, etc and uses the appropriate       *   FILE 745
//*     access method.                                              *   FILE 745
//*                                                                 *   FILE 745
//*     If a PDS or PDSE is referenced without a member name, a     *   FILE 745
//*     list of the members is displayed.  PDS(/E)s with RECFM      *   FILE 745
//*     U are assumed to be "loadlibs", all other RECFMs are        *   FILE 745
//*     "non loadlibs".                                             *   FILE 745
//*                                                                 *   FILE 745
//*     Data from the data set or directory is read into a data     *   FILE 745
//*     space before being displayed.  This has its advantages      *   FILE 745
//*     and disadvantages.  On the plus side, file I/O is only      *   FILE 745
//*     required once.  You can scroll forward, backward,           *   FILE 745
//*     reference anything read into the data space with the        *   FILE 745
//*     system doing any required I/O via system paging which       *   FILE 745
//*     has less overhead and is faster than file I/O.  On the      *   FILE 745
//*     negative side, if the data is too large to be loaded        *   FILE 745
//*     into the data space, only a portion can be FM'd at a        *   FILE 745
//*     time.  There are options on invocation that allow you       *   FILE 745
//*     to specify records to skip, number of records to read,      *   FILE 745
//*     and for VSAM files you can use FROMKEY and TOKEY or RBA     *   FILE 745
//*     for positioning.  (I intend to add the FROMKEY and          *   FILE 745
//*     TOKEY someday!)  The system defualt for the dataspace's     *   FILE 745
//*     size is 239 pages.  I intend to add a keyword to allow      *   FILE 745
//*     users to request a larger dataspace.                        *   FILE 745
//*                                                                 *   FILE 745
//*     I tried to keep the hard-coded message text to a            *   FILE 745
//*     minimum.  Since I am only (somewhat) literate in            *   FILE 745
//*     English (United States variety), the only messages          *   FILE 745
//*     provided now are English.  If anyone wants to take on       *   FILE 745
//*     translating the messages, the source for US English is      *   FILE 745
//*     in source FMMSGUS.  The language you use can be             *   FILE 745
//*     customized on a user by user basis.  The options are        *   FILE 745
//*     kept in member FM of the ISPPROF data set.  If you do       *   FILE 745
//*     create a new messages module, don't forget to add it to     *   FILE 745
//*     the assemble and link-edit JCL.  I suppose you could        *   FILE 745
//*     even translate the text in the SPF panels.                  *   FILE 745
//*                                                                 *   FILE 745
//*     Other odds/ends                                             *   FILE 745
//*     As of now, FM depends on SPF.  I have been looking at       *   FILE 745
//*     'faking out' the SPF functions.                             *   FILE 745
//*                                                                 *   FILE 745
//*     There is no provision for HFS stuff as of yet.              *   FILE 745
//*                                                                 *   FILE 745
//*     I plan on allowing you to enter "FM" as a primary           *   FILE 745
//*     command so you can start a new "session" on a new data      *   FILE 745
//*     set.                                                        *   FILE 745
//*                                                                 *   FILE 745
//*     I work at a JES3 shop.  We don't have any JES2 SMF data     *   FILE 745
//*     so I don't have much motivation for worrying about          *   FILE 745
//*     formatting any SMF records that would be created by         *   FILE 745
//*     JES2.                                                       *   FILE 745
//*                                                                 *   FILE 745
//*     I have been thinking about FMing storage.  This would       *   FILE 745
//*     allow formatting of in storage control blocks.  Anyone      *   FILE 745
//*     know much about cross memory stuff?  Anyone know how to     *   FILE 745
//*     get the ALET for another address space?  Is using ALETs     *   FILE 745
//*     and the access registers even possible for accessing        *   FILE 745
//*     data in another address space?                              *   FILE 745
//*                                                                 *   FILE 745
//*     FM really doesn't 'know' much about tapes.  In the last     *   FILE 745
//*     several years the use of tape has declined drastically      *   FILE 745
//*     here.  The older round-reels were notorious for causing     *   FILE 745
//*     problems.  The main purpose for developing DITTO was        *   FILE 745
//*     for messing around with tapes.  By the way DO NOT USE       *   FILE 745
//*     DITTO on any system later than about MVS 3 (ESA).  On       *   FILE 745
//*     anything later, DITTO CLOBBERS something and the system     *   FILE 745
//*     becomes unusable requiring an IPL.                          *   FILE 745
//*                                                                 *   FILE 745
//*     Commands can be recalled via a question mark (?).           *   FILE 745
//*     Up to the last 20 commands can be recalled.                 *   FILE 745
//*                                                                 *   FILE 745
//*     You can see the contents of various fields in the           *   FILE 745
//*     common area by entering DEBUG as a primary command.         *   FILE 745
//*                                                                 *   FILE 745
//*     FORMATs                                                     *   FILE 745
//*                                                                 *   FILE 745
//*     When a sequential file is first displayed, it is shown      *   FILE 745
//*     using the default format which is BROWSE.  PDS(/E)          *   FILE 745
//*     directories are displayed as member lists.  You can         *   FILE 745
//*     change which format is being used by entering "FORMAT       *   FILE 745
//*     nnnnnnnn" as a primary command.                             *   FILE 745
//*                                                                 *   FILE 745
//*                                                                 *   FILE 745
//*     Formats are defined by members in the FMFORMAT library.     *   FILE 745
//*                                                                 *   FILE 745
//*     As supplied the formats available are:                      *   FILE 745
//*                                                                 *   FILE 745
//*      BROWSE        Displays data 'a-line-at-a-time' that        *   FILE 745
//*                    allows up, down, left, and right             *   FILE 745
//*                    scrolling.                                   *   FILE 745
//*                                                                 *   FILE 745
//*      DIR           Used to display non-loadlib PDS(/E)          *   FILE 745
//*                    directories.                                 *   FILE 745
//*                                                                 *   FILE 745
//*      HEX           Displays data as two hex characters per      *   FILE 745
//*                    byte.  The display allows scrolling up,      *   FILE 745
//*                    down, left, and right.                       *   FILE 745
//*                                                                 *   FILE 745
//*      LDIR          Used to display loadlib PDS(/E)              *   FILE 745
//*                    directories.                                 *   FILE 745
//*                                                                 *   FILE 745
//*      RVTOC         Displays VTOC info in "raw" form.            *   FILE 745
//*                                                                 *   FILE 745
//*      SMF           Assumes the data is SMF data.  Most SMF      *   FILE 745
//*                    record types have customized displays.       *   FILE 745
//*                    Some records have multiple "screens".        *   FILE 745
//*                    "up" and "down" scrolls records, "left"      *   FILE 745
//*                    and "right" change "screens" for a given     *   FILE 745
//*                    record.                                      *   FILE 745
//*                                                                 *   FILE 745
//*      VHEX          Displays data in 'vertical' hex.  Each       *   FILE 745
//*                    record is displayed the way ISPF displays    *   FILE 745
//*                    hex values.                                  *   FILE 745
//*                                                                 *   FILE 745
//*      VTOC          Displays data sets on a volume.              *   FILE 745
//*                                                                 *   FILE 745
//*     FM does not require APF authorization and does not          *   FILE 745
//*     update data sets.                                           *   FILE 745
//*                                                                 *   FILE 745
//*     It does not do much to verify data is valid (like           *   FILE 745
//*     packed decimal) before using it.  If dates in PDS(/E)       *   FILE 745
//*     directores are not valid, SMF data is not valid, etc,       *   FILE 745
//*     etc, FM will ABEND.  Intercepting ABENDs is another one     *   FILE 745
//*     of those 'round tuit's.                                     *   FILE 745
//*                                                                 *   FILE 745
//*     FM does not update anything, so the best way to learn       *   FILE 745
//*     how to use it is to just "play around" with it.             *   FILE 745
//*                                                                 *   FILE 745

```
