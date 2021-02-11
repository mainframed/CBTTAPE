```
//***FILE 229 is a collection of tape copying programs that was     *   FILE 229
//*           put together here by Sam Golob.  The primary program  *   FILE 229
//*           is called COPYMODS, and it can copy an input tape,    *   FILE 229
//*           end to end, to as many as 16 output tapes in one      *   FILE 229
//*           job step.  In addition, COPYMODS has been enhanced to *   FILE 229
//*           include many new features, but its default operation  *   FILE 229
//*           is still nearly identical to that of the original     *   FILE 229
//*           COPYMODS program from Paul Tokheim of the U.S. Air    *   FILE 229
//*           Force in Denver.  Paul's original COPYMODS program    *   FILE 229
//*           has been included here as member COPYMODO, so you     *   FILE 229
//*           can see how many enhancements have been made.         *   FILE 229
//*           Also see File 847 for a code history of how this      *   FILE 229
//*           program's enhancements were developed.                *   FILE 229
//*                                                                 *   FILE 229
//*           If you copy tapes a lot, you'll enjoy the many        *   FILE 229
//*           options in the COPYMODS program.  Additionally,       *   FILE 229
//*           you can use COPYFILE, COPYSLNL, and COPYNLNL to       *   FILE 229
//*           achieve whatever tape copying results you want.       *   FILE 229
//*           If you can't do some job in tape copying that you     *   FILE 229
//*           want to do, please contact me, and I'll see if we     *   FILE 229
//*           can add a feature.  Thanks in advance.  (S.G.)        *   FILE 229
//*                                                                 *   FILE 229
//*           Note:  I actually did it for someone, who wanted      *   FILE 229
//*           to copy SL tapes to scratch tapes to preserve the     *   FILE 229
//*           output volser.  See Version 086 of COPYMODS and       *   FILE 229
//*           higher, using the SHOOVL and KEEPVOL options.         *   FILE 229
//*           Also, a combination of SHOOVL and READ will do a      *   FILE 229
//*           "dry run" to see what will result from a KEEPVOL.     *   FILE 229
//*                                                                 *   FILE 229
//*      Keywords:  TAPECOPY COPYMODS                               *   FILE 229
//*                                                                 *   FILE 229
//*      Note:  COPYFILE and COPYSLNL now have an option to dump    *   FILE 229
//*      ----   tape labels for copied files, in COPYMODS LABLDUMP  *   FILE 229
//*             format.  To enable this, you have to code a         *   FILE 229
//*             //TAPELOUT DD card in the JCL, and also put a       *   FILE 229
//*             //LABLDUMP DD card pointing to an FB-80 format      *   FILE 229
//*             dataset that will receive the tape label images.    *   FILE 229
//*                                                                 *   FILE 229
//*  >>> COPYFILE dumps and prints labels from the output tape.     *   FILE 229
//*  >>> COPYSLNL dumps and prints labels from the input tape,      *   FILE 229
//*             since the output tape from COPYSLNL has no labels.  *   FILE 229
//*                                                                 *   FILE 229
//*      email:  sbgolob@cbttape.org   or  sbgolob@att.net          *   FILE 229
//*                                                                 *   FILE 229
//*           Since it is difficult to test a new level of          *   FILE 229
//*           COPYMODS for all cases, I have decided to include     *   FILE 229
//*           a previous release of COPYMODS in this file, as       *   FILE 229
//*           a fallback, if necessary.                             *   FILE 229
//*                                                                 *   FILE 229
//*           In skilled hands, COPYMODS is an extremely versatile  *   FILE 229
//*           tape copying tool.  You should learn how to use       *   FILE 229
//*           its many options.  The pds member called #MANUAL      *   FILE 229
//*           documents most of them.                               *   FILE 229
//*                                                                 *   FILE 229
//*           Using a PARM of HEXPRT, or HEXPRT in a SYSIN card,    *   FILE 229
//*           COPYMODS will hex dump the first 132 bytes of the     *   FILE 229
//*           first n records of each file, where n=4 by default.   *   FILE 229
//*           This can be overridden by coding PRINTRCDS=nnn        *   FILE 229
//*           in a SYSIN card.  This action is similar to what      *   FILE 229
//*           TAPESCAN does, so if you code READ and HEXPRT in      *   FILE 229
//*           PARM or SYSIN for an execution of COPYMODS, you get   *   FILE 229
//*           a similar result to what you get for TAPESCAN.        *   FILE 229
//*                                                                 *   FILE 229
//*           I have also included another version of COPYMODS      *   FILE 229
//*           called COPYMODT from Art Tansky.  COPYMODT has        *   FILE 229
//*           some features which I haven't yet incorporated        *   FILE 229
//*           into COPYMODS.  One of its features is to count       *   FILE 229
//*           bytes for each file and tape label read.  That        *   FILE 229
//*           feature has is now an option in this version of       *   FILE 229
//*           COPYMODS, using the keywords of BYTES and CUMTOT,     *   FILE 229
//*           and also CUMSEP.                                      *   FILE 229
//*                                                                 *   FILE 229
//*           Art Tansky's other new feature is to support very     *   FILE 229
//*           many output DD names, because in Art's version        *   FILE 229
//*           the output DCB's are created dynamically, and are     *   FILE 229
//*           not static in the program.  COPYMODT currently        *   FILE 229
//*           supports up to 100 output tapes.                      *   FILE 229
//*                                                                 *   FILE 229
//*           Currently, my version does not do any GETMAINs.       *   FILE 229
//*           If my version of COPYMODS can be loaded into core,    *   FILE 229
//*           it will execute.  The tape buffer is a part of        *   FILE 229
//*           the COPYMODS program itself, and is 64K bytes long.   *   FILE 229
//*                                                                 *   FILE 229
//*           Several other programs from File 316 of the CBT       *   FILE 229
//*           Tape have also been included here for convenience.    *   FILE 229
//*           They are:                                             *   FILE 229
//*                                                                 *   FILE 229
//*           COPYFILE - Copies selected files from one SL tape     *   FILE 229
//*                      to another, using control cards.           *   FILE 229
//*                                                                 *   FILE 229
//*                     (These programs are needed because          *   FILE 229
//*                      COPYMODS cannot easily select files        *   FILE 229
//*                      from the input tape to copy.  Its          *   FILE 229
//*                      default action is to copy a tape from      *   FILE 229
//*                      end to end.  COPYFILE, COPYSLNL, and       *   FILE 229
//*                      COPYNLNL provide extremely flexible        *   FILE 229
//*                      file selection criteria for copying        *   FILE 229
//*                      SOME files of a tape, and not others.)     *   FILE 229
//*                                                                 *   FILE 229
//*                 ---> Fixed for intermittent ABEND 400 on        *   FILE 229
//*                      writes.  Unpredictable, so I replaced      *   FILE 229
//*                      Frank Yates' double buffering that was     *   FILE 229
//*                      GETMAINed, by single buffering with a      *   FILE 229
//*                      buffer inside the program.  Seems to       *   FILE 229
//*                      work.  Still keeping old level around.     *   FILE 229
//*                                                                 *   FILE 229
//*           COPYFIL# - Help member for the COPYFILE control       *   FILE 229
//*                      cards, so you know how to use them in      *   FILE 229
//*                      the COPYFILE, COPYSLNL, and COPYNLNL       *   FILE 229
//*                      programs, to select which files from       *   FILE 229
//*                      the input tape that you want to copy.      *   FILE 229
//*                                                                 *   FILE 229
//*           COPYSLNL - Same as COPYFILE, except that labels       *   FILE 229
//*                      are stripped off in the output tape,       *   FILE 229
//*                      so the output tape is NL.  Same control    *   FILE 229
//*                      cards as COPYFILE.                         *   FILE 229
//*                                                                 *   FILE 229
//*                      Now you can also use the STRIP option      *   FILE 229
//*                      of COPYMODS to create an NL tape from      *   FILE 229
//*                      an SL tape.  But COPYSLNL has file         *   FILE 229
//*                      selection controls that COPYMODS does      *   FILE 229
//*                      not have.                                  *   FILE 229
//*                                                                 *   FILE 229
//*                 ---> Fixed for intermittent ABEND 400 on        *   FILE 229
//*                      writes.  Unpredictable, so I replaced      *   FILE 229
//*                      Frank Yates' double buffering that was     *   FILE 229
//*                      GETMAINed, by single buffering with a      *   FILE 229
//*                      buffer inside the program.  Seems to       *   FILE 229
//*                      work.  Still keeping old level around.     *   FILE 229
//*                                                                 *   FILE 229
//*           COPYSLN# - Help member for the COPYSLNL control       *   FILE 229
//*                      cards, so you know how to use them in      *   FILE 229
//*                      the COPYFILE, COPYSLNL, and COPYNLNL       *   FILE 229
//*                      programs, to select which files from       *   FILE 229
//*                      the input tape that you want to copy.      *   FILE 229
//*                                                                 *   FILE 229
//*           COPYNLNL - Similar to COPYFILE, and uses the same     *   FILE 229
//*                      control cards, but copies selected files   *   FILE 229
//*                      from NL input tape to an NL output tape.   *   FILE 229
//*                      Only stops copying after 2 consecutive     *   FILE 229
//*                      tape marks.                                *   FILE 229
//*                                                                 *   FILE 229
//*                 ---> Fixed for intermittent ABEND 400 on        *   FILE 229
//*                      writes.  Unpredictable, so I replaced      *   FILE 229
//*                      Frank Yates' double buffering that was     *   FILE 229
//*                      GETMAINed, by single buffering with a      *   FILE 229
//*                      buffer inside the program.  Seems to       *   FILE 229
//*                      work.  Still keeping old level around.     *   FILE 229
//*                                                                 *   FILE 229
//*           COPYNLN# - Help member for the COPYNLNL control       *   FILE 229
//*                      cards, so you know how to use them in      *   FILE 229
//*                      the COPYFILE, COPYSLNL, and COPYNLNL       *   FILE 229
//*                      programs, to select which files from       *   FILE 229
//*                      the input tape that you want to copy.      *   FILE 229
//*                                                                 *   FILE 229
//*           CKIEBGEN - A simple copy program that uses QSAM       *   FILE 229
//*                      and just does GET and PUT.  DCB's are      *   FILE 229
//*                      coded very generally, and DCB info about   *   FILE 229
//*                      the input and output files has to be       *   FILE 229
//*                      specified in the JCL.  Adapted from        *   FILE 229
//*                      Baldomero Castilla's program of the        *   FILE 229
//*                      same name, but I added record counts,      *   FILE 229
//*                      and a DCB report for the input and         *   FILE 229
//*                      output datasets.  Also record selection.   *   FILE 229
//*                                                                 *   FILE 229
//*                      This program lacks the "smart-ss"          *   FILE 229
//*                      features of IEBGENER, but consequently     *   FILE 229
//*                      it can be used to copy more kinds of       *   FILE 229
//*                      sequential files than IEBGENER can.        *   FILE 229
//*                      Try it on FB-80 zip files, or parts of     *   FILE 229
//*                      XMIT files, to complete broken ones.       *   FILE 229
//*                                                                 *   FILE 229
//*                      Functionality added to select parts of     *   FILE 229
//*                      files to copy, through a SYSIN DD card     *   FILE 229
//*                      (which is optional) and by using           *   FILE 229
//*                                                                 *   FILE 229
//*                      SKIP=mmmmmmm                               *   FILE 229
//*                      COPY=nnnnnnn                               *   FILE 229
//*                                                                 *   FILE 229
//*                      control cards in SYSIN to determine        *   FILE 229
//*                      which segment of the file to copy.         *   FILE 229
//*                                                                 *   FILE 229
//*           Hopefully, File 229 contains everything you need      *   FILE 229
//*           to assemble all the programs.  If you think there's   *   FILE 229
//*           something missing, look at the MACROS member from     *   FILE 229
//*           File 316, or in File 316 source members.              *   FILE 229
//*                                                                 *   FILE 229
//*           All of these programs, except for CKIEBGEN, whose     *   FILE 229
//*           purpose is different, can now copy tape files         *   FILE 229
//*           with blocksize up to 64K blocks.                      *   FILE 229
//*                                                                 *   FILE 229
//*           The new features of the COPYMODS program are          *   FILE 229
//*           summarized below, but there's more than meets the     *   FILE 229
//*           eye.  If you do tape copying, these programs          *   FILE 229
//*           deserve study, for the extent of their capabilities.  *   FILE 229
//*                                                                 *   FILE 229
//*       >>  COPYMODS will automatically detect input tapes        *   FILE 229
//*       >>  with many leading tape marks, and will advance the    *   FILE 229
//*       >>  tape past them, if there is real data afterwards.     *   FILE 229
//*       >>  This requires no effort on the part of the user,      *   FILE 229
//*       >>  and it is done automatically.  SYSPRINT will report   *   FILE 229
//*       >>  the results.                                          *   FILE 229
//*                                                                 *   FILE 229
//*           When first written, the intent of the COPYMODS        *   FILE 229
//*           program was to copy NL tapes.  I have modified        *   FILE 229
//*           COPYMODS very extensively, to teach it about          *   FILE 229
//*           Standard Labeled tapes, and I have modified it        *   FILE 229
//*           to copy large-blocked files of up to 64K.  (SG        *   FILE 229
//*           12/00).  COPYMODS can now do many tricks with         *   FILE 229
//*           IBM Standard Labels and SL tapes.                     *   FILE 229
//*                                                                 *   FILE 229
//*           I USE THIS PROGRAM FOR CREATING COPIES OF THE CBT     *   FILE 229
//*           MVS UTILITIES TAPE.  (SG 10/93)                       *   FILE 229
//*                                                                 *   FILE 229
//*           This program is useful in making "carbon copies"      *   FILE 229
//*           from one tape to another, and it can also convert     *   FILE 229
//*           from one tape medium to another.  For example, it     *   FILE 229
//*           can convert from reels to cartridges, or vice-versa.  *   FILE 229
//*                                                                 *   FILE 229
//*           My advice is, however, that you should not mix        *   FILE 229
//*           media types when you make multiple output tapes in    *   FILE 229
//*           one run.  For example, //OUT1 and //OUT2 should       *   FILE 229
//*           both be reels, or both cartridges of the same         *   FILE 229
//*           format (like 3480, 3490IDRC, or 3490E).  Do not mix   *   FILE 229
//*           these.  //IN can be different from //OUTx, however.   *   FILE 229
//*           It is my experience that when the //IN (input tape)   *   FILE 229
//*           was of different media type than the //OUTx (output   *   FILE 229
//*           tapes), this program has always worked flawlessly     *   FILE 229
//*           to convert the tape to a different media format.      *   FILE 229
//*                                                                 *   FILE 229
//*           I've also solved the 2-tape-marks-together problem    *   FILE 229
//*           when you have a null SL tape file.  The program will  *   FILE 229
//*           now copy past that point, if it has seen a HDR1 or    *   FILE 229
//*           HDR2 label before the 2 consecutive tape marks.       *   FILE 229
//*                                                                 *   FILE 229
//*           Under PARM control, this program can now create       *   FILE 229
//*           initted tapes, and optionally change the VOLSER       *   FILE 229
//*           of the newly initted SL tapes.  Thus, you can init    *   FILE 229
//*           a large number of tapes at the same time.             *   FILE 229
//*           (The new INITVOLS parameter eliminates the need       *   FILE 229
//*           for an already initted input tape, and you can        *   FILE 229
//*           INIT up to 16 output tapes at the same time.)         *   FILE 229
//*                                                                 *   FILE 229
//*           If you code a parm of SYSIN in the EXEC card,         *   FILE 229
//*           COPYMODS will take its parms from SYSIN, as well      *   FILE 229
//*           as from the EXEC card.  SYSIN is scanned last.        *   FILE 229
//*           Therefore SYSIN overrides the EXEC card if there      *   FILE 229
//*           is a conflict.  Parms coded later, always override    *   FILE 229
//*           parms coded earlier.  As of Level 049 of COPYMODS,    *   FILE 229
//*           you don't actually have to code PARM=SYSIN in the     *   FILE 229
//*           exec card.  The mere presence or absence of a         *   FILE 229
//*           //SYSIN DD card in the execution JCL of COPYMODS      *   FILE 229
//*           will determine whether (or not) the SYSIN ddname      *   FILE 229
//*           is opened and scanned.                                *   FILE 229
//*                                                                 *   FILE 229
//*           See the $$PARMS and $$PARMS1 member of this dataset   *   FILE 229
//*           for hints and advice on how to use the many options   *   FILE 229
//*           of COPYMODS.                                          *   FILE 229
//*                                                                 *   FILE 229
//*  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  *   FILE 229
//*                                                                 *   FILE 229
//*       NEW FEATURES ADDED BY SAM GOLOB:                          *   FILE 229
//*                                                                 *   FILE 229
//*       (Also please see the individual Level nnn changes,        *   FILE 229
//*       as listed in the COPYMODS source code, for more           *   FILE 229
//*       information.)                                             *   FILE 229
//*                                                                 *   FILE 229
//*       It is recommended that you view the PARMTABL entries      *   FILE 229
//*       and look at the supplied #MANUAL member in the            *   FILE 229
//*       distribution pds, CBT File 229, for even more info.       *   FILE 229
//*                                                                 *   FILE 229
//*       1.  64K BLOCKS ON A TAPE CAN BE COPIED.                   *   FILE 229
//*                                                                 *   FILE 229
//*       2.  UP TO 16 OUTPUT DDNAMES ALLOWED.                      *   FILE 229
//*                                                                 *   FILE 229
//*       3.  INITTED TAPES, AND SL MULTIVOLUME TAPES CAN           *   FILE 229
//*           BE CORRECTLY COPIED.                                  *   FILE 229
//*                                                                 *   FILE 229
//*       4.  ALL STANDARD LABEL INFORMATION, OR ANY                *   FILE 229
//*           PARTICULAR LABEL TYPES, CAN BE PRINTED, IF            *   FILE 229
//*           FOUND ON THE INPUT TAPE.                              *   FILE 229
//*                                                                 *   FILE 229
//*       5.  A FLEXIBLE TABLE-DRIVEN PARM KEYWORD SCANNER          *   FILE 229
//*           WAS ADDED.  THIS ALLOWS FOR EASY SETTING OF           *   FILE 229
//*           PROGRAM DEFAULTS, AND KEYWORD SYNONYMS.  SEE          *   FILE 229
//*           LABEL PARMTABL.  THE PARM SCANNER IS NOW A            *   FILE 229
//*           SEPARATE PROGRAM CALLED PARMCHEK, WHICH MUST BE       *   FILE 229
//*           ASSEMBLED IN BATCH, TOGETHER WITH THE COPYMODS        *   FILE 229
//*           MAIN SOURCE CODE.                                     *   FILE 229
//*                                                                 *   FILE 229
//*       6.  OPTIONALLY, THE VOLSER OF THE OUTPUT TAPES            *   FILE 229
//*           CAN BE SET TO THE JCL VOLSER, INSTEAD OF THE          *   FILE 229
//*           INPUT TAPE'S VOLSER.  USE THE CHGVOL PARM TO          *   FILE 229
//*           INVOKE THIS ACTION.                                   *   FILE 229
//*                                                                 *   FILE 229
//*       7.  TAPES WITH LEADING TAPE MARKS CAN BE COPIED           *   FILE 229
//*           EITHER AS-IS, OR WITH THE LEADING TAPE MARKS          *   FILE 229
//*           LEFT OFF.  OPTION OF LTMSKIP OR LTMCOPY.              *   FILE 229
//*                                                                 *   FILE 229
//*       8.  EOV LABELS IN THE MIDDLE OF A TAPE, CAN NOW BE        *   FILE 229
//*           CHANGED TO EOF LABELS, IF THE TAPE WAS CREATED        *   FILE 229
//*           AS A COMPOSITE, BY THE COPYFILE PROGRAM.  THE         *   FILE 229
//*           PARM IS EOV2EOF (SEE PARMTABL FOR ALL ACCURATE        *   FILE 229
//*           AND CURRENT PARM KEYWORD SETTINGS).  THIS ALSO        *   FILE 229
//*           WORKS WHEN ADDING EXTERNAL LABELS TO AN NL TAPE.      *   FILE 229
//*                                                                 *   FILE 229
//*       9.  COPYMODS CAN NOW BE RUN READ-ONLY FOR THE INPUT       *   FILE 229
//*           TAPE, USING PARMS OF READ, READONLY, OR NOWRITE.      *   FILE 229
//*                                                                 *   FILE 229
//*      10.  COPYMODS CAN READ A TAPE (EITHER WHILE COPYING        *   FILE 229
//*           IT, OR IN READ-ONLY MODE), AND DUMP ALL THE TAPE      *   FILE 229
//*           LABELS TO AN FB-80 OUTPUT FILE WITH A DDNAME OF       *   FILE 229
//*           LABLDUMP.  USE A PARM OF LABLDUMP TO INVOKE THIS      *   FILE 229
//*           SERVICE.                                              *   FILE 229
//*                                                                 *   FILE 229
//*      11.  COPYMODS CAN READ AN SL TAPE AND DUMP THE LABELS      *   FILE 229
//*           OFF INTO AN OUTPUT FILE.  THESE LABEL IMAGES HAVE     *   FILE 229
//*           EXTRA CONTROL CARDS ADDED.  THESE LABELS CAN BE       *   FILE 229
//*           MERGED WITH THE FILES IN AN NL VERSION OF THE         *   FILE 229
//*           SAME TAPE, AND A NEW SL TAPE CREATED.  BY DEFAULT,    *   FILE 229
//*           BLOCK COUNTS IN THE EOF1 AND EOV1 OF THE OUTPUT       *   FILE 229
//*           TAPE ARE CORRECTED TO SHOW THE ACTUAL BLOCK           *   FILE 229
//*           COUNTS ON THE TAPE, BUT THIS ACTION CAN BE            *   FILE 229
//*           MANUALLY TURNED OFF WITH A PARM SETTING.              *   FILE 229
//*                                                                 *   FILE 229
//*      11a. IF YOU CODE A PARM OF SYSIN IN THE PARM FIELD OF      *   FILE 229
//*           THE EXEC CARD, THEN COPYMODS NOW TAKES PARM INPUT     *   FILE 229
//*           FROM SYSIN, AND THESE CAN OVERRIDE THE OTHER PARMS    *   FILE 229
//*           IN THE EXEC CARD, BECAUSE SYSIN IS SEARCHED LATER.    *   FILE 229
//*                                                                 *   FILE 229
//*           (BUT YOU DON'T HAVE TO CODE PARM=SYSIN IN THE PARM    *   FILE 229
//*           FIELD OF THE EXEC CARD.  IF THE SYSIN DDNAME IS       *   FILE 229
//*           PRESENT IN THE JCL, PARMCHEK WILL OPEN IT, AND        *   FILE 229
//*           WILL USE IT TO SCAN FOR PARMS.  SG - 07/03).          *   FILE 229
//*                                                                 *   FILE 229
//*      11b. ANY SPECIAL SYSIN KEYWORD, SUCH AS:                   *   FILE 229
//*           TAPEOWNER=xxxxxxxxxx                                  *   FILE 229
//*           FILELIMIT=nnnn                                        *   FILE 229
//*           LABELIMIT=nnnn                                        *   FILE 229
//*           PRINTRCDS=nnnn                                        *   FILE 229
//*             or                                                  *   FILE 229
//*           OUTVOLALL=volser , WILL CAUSE THE REST OF A SYSIN     *   FILE 229
//*           CARD TO BE IGNORED FOR PARMS FROM THE PARM TABLE.     *   FILE 229
//*                                                                 *   FILE 229
//*      11c. OUTVOLALL=volser , STARTING IN COLUMN1 OF A SYSIN     *   FILE 229
//*           CARD, WILL CAUSE ALL OUTPUT VOL1 LABELS TO BE         *   FILE 229
//*           OVERWRITTEN WITH THE CODED VOLSER.  THE REST OF       *   FILE 229
//*           THAT CARD IS NOT SEARCHED FOR PARMS.                  *   FILE 229
//*                                                                 *   FILE 229
//*      12.  OVERLAYING OF THE VOLSER (IN THE VOL1 LABEL)          *   FILE 229
//*           CAN ALSO BE DONE IF YOU ARE ADDING EXTERNAL           *   FILE 229
//*           LABELS TO AN NL TAPE.  THE OUTPUT TAPES CAN           *   FILE 229
//*           HAVE DIFFERENT VOLSER'S FROM THE VOL1 LABEL           *   FILE 229
//*           IN THE EXTERNAL LABEL DATASET.                        *   FILE 229
//*                                                                 *   FILE 229
//*      13.  LABLDUMP AND LABADDIN NOW TAKE IBM STANDARD USER      *   FILE 229
//*           LABELS (SUL) INTO ACCOUNT.  UP TO 8 UHLn AND/OR       *   FILE 229
//*           UTLn LABELS ALLOWED.  THEREFORE, YOU CAN MAKE A       *   FILE 229
//*           TAPE WITH ANY USER LABELS YOU WANT, EVEN THOUGH       *   FILE 229
//*           YOUR SYSTEM CAN'T CREATE SUCH A TAPE BY ITSELF.       *   FILE 229
//*           LABLDUMP DUMPS ALL THE LABEL RECORDS FROM AN SL       *   FILE 229
//*           TAPE TO AN EXTERNAL FILE (WITH SPECIAL CONTROL        *   FILE 229
//*           CARDS), AND LABADDIN CAN ADD THESE LABELS TO AN       *   FILE 229
//*           NL TAPE TO MAKE AN SL TAPE.  (OF COURSE, YOU CAN      *   FILE 229
//*           EDIT THE LABEL FILE ON DISK BEFORE USING IT TO        *   FILE 229
//*           CREATE A NEW SL TAPE FROM AN NL TAPE.)                *   FILE 229
//*                                                                 *   FILE 229
//*      14.  DEFAULT ACTION OF COPYMODS WITH LABADDIN IS THAT      *   FILE 229
//*           IT IS "LABEL DRIVEN".  THAT IS, IF THERE ARE MORE     *   FILE 229
//*           NL TAPE FILES THAN EXTERNAL LABELS, THE PROGRAM       *   FILE 229
//*           STOPS WHEN IT RUNS OUT OF LABELS.  IF THERE ARE       *   FILE 229
//*           MORE LABEL SETS THAN FILES, THE OUTPUT TAPE IS        *   FILE 229
//*           WRITTEN WITH NULL STANDARD LABEL FILES UNTIL THE      *   FILE 229
//*           LABEL DATASET IS EXHAUSTED, EVEN AFTER THE LAST       *   FILE 229
//*           DATA FILE HAS BEEN WRITTEN.                           *   FILE 229
//*                                                                 *   FILE 229
//*           A NEW OPTION CALLED NOEXNULL ALLOWS COPYMODS TO       *   FILE 229
//*           STOP AS SOON AS THE NL TAPE FILES ARE EXHAUSTED,      *   FILE 229
//*           EVEN IF THERE ARE ADDITIONAL LABEL SETS IN THE        *   FILE 229
//*           EXTERNAL LABEL DATASET.                               *   FILE 229
//*                                                                 *   FILE 229
//*      15.  WHEN DOING LABADDIN PROCESSING, IF THE LAST LABEL     *   FILE 229
//*           SET IN THE EXTERNAL LABEL FILE HAS A HDR1 AND A       *   FILE 229
//*           HDR2 LABEL, BUT NO ENDOFLABELHEADER AND NO EOF1       *   FILE 229
//*           AND NO EOF2, THE LBLFIX PARAMETER ALLOWS THE          *   FILE 229
//*           PROGRAM TO ACT AS IF THESE CONTROL CARDS WERE         *   FILE 229
//*           THERE.  THE EOF1 IS BUILT FROM THE HDR1 AND THE       *   FILE 229
//*           MEASURED BLOCK COUNT, AND THE EOF2 IS BUILT FROM      *   FILE 229
//*           THE HDR2.                                             *   FILE 229
//*                                                                 *   FILE 229
//*      16.  COPYMODS CAN NOW INIT TAPES WITHOUT COPYING AN        *   FILE 229
//*           INPUT TAPE.  USE A PARM OF INITVOLS.  ASCII TAPES     *   FILE 229
//*           ARE INITTED WITH A PARM OF EITHER INASC3 OR           *   FILE 229
//*           INASC4, FOR ASCII LEVEL 3 AND ASCII LEVEL 4           *   FILE 229
//*           RESPECTIVELY.  A PARM OF INASCII DEFAULTS TO          *   FILE 229
//*           ASCII LEVEL 3.                                        *   FILE 229
//*                                                                 *   FILE 229
//*      17.  COPYMODS CAN NOW CHANGE THE OWNER INFORMATION         *   FILE 229
//*           IN THE VOL1 LABEL.  USE THE TAPEOWNER= KEYWORD        *   FILE 229
//*           IN A SYSIN CARD.  14 CHARACTER TAPE OWNERS ARE        *   FILE 229
//*           SUPPORTED FOR ASCII TAPES.  IBM SL TAPES HAVE         *   FILE 229
//*           10 CHARACTERS IN THE TAPE OWNER FIELD.                *   FILE 229
//*                                                                 *   FILE 229
//*      18.  COPYMODS CAN LIMIT ITSELF IN THE NUMBER OF FILES      *   FILE 229
//*           COPIED, IF THE FILELIMIT=NN KEYWORD IS CODED IN       *   FILE 229
//*           SYSIN.  IF THE INPUT IS SL, THEN THE FILELIMIT        *   FILE 229
//*           IS INTERPRETED AS SL FILES, AND MULTIPLIED BY 3.      *   FILE 229
//*           IF NOT, THEN IT IS INTERPRETED AS NL.  SL             *   FILE 229
//*           INTERPRETATION OF FILE NUMBERS CAN BE FORCED,         *   FILE 229
//*           USING THE SLLIM PARM KEYWORD.  NL INTERPRETATION      *   FILE 229
//*           IS FORCED USING THE NLLIM PARM KEYWORD.               *   FILE 229
//*                                                                 *   FILE 229
//*      19.  USING THE "BYTES" PARAMETER, COPYMODS WILL REPORT     *   FILE 229
//*           BYTE COUNTS FOR ALL FILES IN THE INPUT TAPE, AND      *   FILE 229
//*           TOTAL BYTES FOR THE ENTIRE TAPE.  THE "CUMTOT"        *   FILE 229
//*           PARAMETER REPORTS CUMULATIVE BYTE TOTALS OVER         *   FILE 229
//*           MANY FILES, AND IMPLIES THAT THE "BYTES" PARM         *   FILE 229
//*           IS ALSO IN EFFECT.  A VARIANT OF THE "CUMTOT"         *   FILE 229
//*           PARAMETER IS THE "CUMSEP" PARAMETER, WHICH REPORTS    *   FILE 229
//*           CUMULATIVE BYTE TOTALS, FILE BY FILE, BUT CUMSEP      *   FILE 229
//*           SEPARATES BYTE TOTALS COMING FROM LABELS, FROM THE    *   FILE 229
//*           BYTE TOTALS COMING FROM DATA FILES.                   *   FILE 229
//*                                                                 *   FILE 229
//*      20.  COPYMODS NOW PRINTS "OPTIONS IN EFFECT" WITH THE      *   FILE 229
//*           "OPTION" PARAMETER.  (DEFAULT AS DISTRIBUTED, IS      *   FILE 229
//*           TO PRINT THEM.)                                       *   FILE 229
//*                                                                 *   FILE 229
//*           IF YOU ARE CONFUSED THAT THE OPTION REPORT DOES       *   FILE 229
//*           NOT SEEM TO REFLECT THE OPTION KEYWORDS YOU ARE       *   FILE 229
//*           CODING IN YOUR JCL, PLEASE BE AWARE THAT COPYMODS     *   FILE 229
//*           DOES SOME OPTION ADJUSTMENTS TO RESOLVE APPARENT      *   FILE 229
//*           INCONSISTENCIES WITH THE PARM SETTINGS.  TO GET       *   FILE 229
//*           A "BEFORE AND AFTER" REPORT FOR THIS ACTION, CODE     *   FILE 229
//*           THE "CODEDPRM" PARM KEYWORD.                          *   FILE 229
//*                                                                 *   FILE 229
//*      21.  BLOCK CORRECTION FOR EOF1 AND EOV1 LABELS NOW         *   FILE 229
//*           TAKES THE HIGH ORDER 4 BYTES OF THE BLOCK COUNT       *   FILE 229
//*           INTO ACCOUNT.  THIS IS A DIFFERENT FIELD IN THE       *   FILE 229
//*           EOF1 OR EOV1 LABEL (LAST 4 BYTES).  IF A TAPE         *   FILE 229
//*           FILE (EBCDIC SL TAPES ONLY) HAS MORE THAN 1           *   FILE 229
//*           MILLION BLOCKS IN IT, THEN THIS FIELD IS USED.        *   FILE 229
//*           OTHERWISE IT IS BLANKS.                               *   FILE 229
//*                                                                 *   FILE 229
//*      22.  COPYMODS CAN NOW DO A QUICK DUMP OF TAPE LABELS,      *   FILE 229
//*           WITHOUT READING THE TAPE DATA.  USE THE PARM OF       *   FILE 229
//*           LBDQUICK (WHICH IMPLIES READONLY), JUST TO DO         *   FILE 229
//*           A LABLDUMP AND "FORWARD SPACE FILE" OVER THE          *   FILE 229
//*           DATA BLOCKS ON THE TAPE.                              *   FILE 229
//*                                                                 *   FILE 229
//*      23.  USING PARM=STRIP, COPYMODS CAN STRIP ALL LABELS       *   FILE 229
//*           FROM SL TAPES TO MAKE NL OUTPUT TAPES.  IF            *   FILE 229
//*           FILE LIMITING IS NOT IN EFFECT (NO FILELIMIT=nnn      *   FILE 229
//*           CARD IN SYSIN), THEN THE LABELS AND THE TAPE MARK     *   FILE 229
//*           THAT FOLLOWS EACH ONE, WILL NOT BE WRITTEN TO THE     *   FILE 229
//*           OUTPUT TAPE(S).  IT DOES NOT MATTER WHERE THE         *   FILE 229
//*           LABELS ARE, ON THE TAPE, SO IF YOU HAVE SOME KIND     *   FILE 229
//*           OF MESSED-UP TAPE WITH LABELS IN THE WRONG PLACE,     *   FILE 229
//*           THESE WILL STILL BE CORRECTLY STRIPPED OFF.  IF       *   FILE 229
//*           FILE LIMITING IS IN EFFECT, THEN THE INPUT TAPE       *   FILE 229
//*           IS ASSUMED TO BE SL, AND THE NUMBER CODED IN THE      *   FILE 229
//*           FILELIMIT=nnn SYSIN CARD IS MULTIPLIED BY 3, AND      *   FILE 229
//*           THE COPYING IS STOPPED AFTER THAT POINT OF THE        *   FILE 229
//*           INPUT TAPE.                                           *   FILE 229
//*                                                                 *   FILE 229
//*           FOR PARM=STRIP OPERATIONS, COPYMODS USES THE          *   FILE 229
//*           LABELCHK ROUTINE TO DETERMINE IF A TAPE FILE IS       *   FILE 229
//*           REALLY A LABEL, SO IT WILL STRIP OFF A LABEL FILE     *   FILE 229
//*           WHEREVER IT OCCURS.  THIS IS NOT LIKE THE COPYSLNL    *   FILE 229
//*           PROGRAM, WHICH ASSUMES THAT EACH DATA FILE IS         *   FILE 229
//*           SANDWICHED BETWEEN TWO LABEL FILES, AND WHICH         *   FILE 229
//*           DOES THE STRIPPING BY "COUNTING" AND NOT BY           *   FILE 229
//*           "FEELING".                                            *   FILE 229
//*                                                                 *   FILE 229
//*      24.  IF YOU HAVE SPECIFIED FILELIMIT=nnn IN A SYSIN        *   FILE 229
//*           CARD AND HAVE THEREFORE INVOKED FILE LIMITING,        *   FILE 229
//*           YOU CAN FORCE THE nnn TO BE INTERPRETED AS NL,        *   FILE 229
//*           USING THE NLLIM PARM, AND YOU CAN FORCE THE nnn       *   FILE 229
//*           TO BE INTERPRETED AS SL (AND THEREFORE BE             *   FILE 229
//*           MULTIPLIED BY 3), BY USING THE SLLIM PARM.            *   FILE 229
//*                                                                 *   FILE 229
//*      25.  USING PARM=IDRCOFF, YOU CAN INDICATE THAT THE         *   FILE 229
//*           TAPE IS NON-COMPRESSED.  THIS IS USEFUL FOR AWS       *   FILE 229
//*           FORMAT TAPES WHICH REALLY AREN'T RUNNING ON THE       *   FILE 229
//*           3490 HARDWARE AND ABOVE.  SO YOU JUST INDICATE        *   FILE 229
//*           THEM AS UNCOMPRESSED, AND THE VIRTUAL TAPE LABELS     *   FILE 229
//*           DO NOT INDICATE TO MVS THAT IDRC IS ON.  THIS         *   FILE 229
//*           ALLOWS A 3420 OR 3480 VIRTUAL DEVICE TO READ THE      *   FILE 229
//*           TAPE, WITHOUT INCURRING AN S413-40 ABEND.             *   FILE 229
//*                                                                 *   FILE 229
//*      26.  USING PARM=HEXPRT, THE FIRST 132 BYTES OF THE         *   FILE 229
//*           FIRST n RECORDS IN EACH FILE ARE PRINTED IN HEX       *   FILE 229
//*           AND EBCDIC.  DEFAULT FOR n IS 4.  THIS CAN BE         *   FILE 229
//*           OVERRIDDEN BY CODING PRINTRCDS=nnn IN THE SYSIN       *   FILE 229
//*           CARD, STARTING IN COLUMN 1.  GLOBAL VARIABLE          *   FILE 229
//*           &HEXDFLA CAN BE SET AT ASSEMBLY TIME, TO CHANGE       *   FILE 229
//*           THE DEFAULT n RECORDS TO BE HEX PRINTED.              *   FILE 229
//*                                                                 *   FILE 229
//*      27.  THE PARM SCANNING PROGRAM PARMCHEK, CUSTOMIZED        *   FILE 229
//*           TO THIS VERSION OF COPYMODS, NOW DOES THE PARM        *   FILE 229
//*           SCANNING INSTEAD OF THE INLINE PARMCHK SUBROUTINE.    *   FILE 229
//*           THEREFORE, THIS PROGRAM SHOULD BE ASSEMBLED IN        *   FILE 229
//*           BATCH, TOGETHER WITH THE PARMCHEK PROGRAM.            *   FILE 229
//*           THIS ALSO ALLOWS OPTIONAL DDNAME //PARMREPT TO        *   FILE 229
//*           BE CODED, TO SHOW THE RESULTS FROM THE PARM SCAN.     *   FILE 229
//*                                                                 *   FILE 229
//*      28.  SUPPORT FOR ANSI/ISO (ASCII) TAPES.  LEVELS 3 AND     *   FILE 229
//*           4 ARE SUPPORTED.  COPYMODS CAN INIT ASCII TAPES       *   FILE 229
//*           (KEYWORDS INASC3 AND INASC4), AND CAN PERFORM         *   FILE 229
//*           ALL ITS FUNCTIONALITY ON THEM.  14 CHARACTER TAPE     *   FILE 229
//*           OWNER FIELD IS SUPPORTED FOR ASCII TAPES, AS WELL     *   FILE 229
//*           AS MOST OF THE OTHER DIFFERENCES BETWEEN ASCII        *   FILE 229
//*           LABEL FORMATS AND IBM (EBCDIC) LABEL FORMATS.         *   FILE 229
//*                                                                 *   FILE 229
//*      29.  SECURITY INDICATORS IN TAPE LABELS CAN BE TURNED      *   FILE 229
//*           OFF IN THE COPIED TAPES USING THE SECOFF KEYWORD.     *   FILE 229
//*           THESE INDICATORS (TURNED OFF) ARE:                    *   FILE 229
//*            ASCII SPACE IN BYTE 11 OF ASCII VOL1 LABEL.          *   FILE 229
//*            ASCII SPACE IN BYTE 54 OF ASCII XXX1 LABELS.         *   FILE 229
//*            EBCDIC 0 IN BYTE 54 OF IBM XXX1 LABELS.              *   FILE 229
//*           IF THESE HAD BEEN ANYTHING OTHER THAN THE ABOVE,      *   FILE 229
//*           THE SECOFF KEYWORD WILL CAUSE THEM TO BE RESET        *   FILE 229
//*           AS ABOVE, TO INDICATE NO DATASET PROTECTION.          *   FILE 229
//*                                                                 *   FILE 229
//*           RACF OR OTHER SECURITY MAY OVERRIDE THESE LABEL       *   FILE 229
//*           SECURITY INDICATORS, BUT WE HAVE THE ABILITY TO       *   FILE 229
//*           COMPLETELY TURN THEM OFF AT THE TAPE LABEL LEVEL.     *   FILE 229
//*           THE NOSECOFF KEYWORD NULLIFIES THE EFFECT OF THE      *   FILE 229
//*           SECOFF KEYWORD.                                       *   FILE 229
//*                                                                 *   FILE 229
//*      30.  COPYMODS CAN TRANSPARENTLY (WITH NO FURTHER EFFORT    *   FILE 229
//*           ON THE PROGRAMMER'S PART) READ PAST LEADING TAPE      *   FILE 229
//*           MARKS ON THE INPUT TAPE.  THESE MAY BE EITHER         *   FILE 229
//*           COPIED TO THE OUTPUT TAPES (KEYWORD LTMCOPY) OR       *   FILE 229
//*           NOT COPIED TO THE OUTPUT TAPES (KEYWORD LTMSKIP).     *   FILE 229
//*           MORE EXTENSIVE "LTM SERVICE" HAS BEEN BUILT INTO      *   FILE 229
//*           THIS PROGRAM.                                         *   FILE 229
//*                                                                 *   FILE 229
//*      31.  COPYMODS CAN DISPLAY 6250 BPI FOOTAGES FOR THE        *   FILE 229
//*           FILES ON THE TAPE, USING THE FOOTAGE KEYWORD.         *   FILE 229
//*           FOOTAGE CALCULATIONS FOR EACH FILE, AS WELL AS        *   FILE 229
//*           FOOTAGE FOR THE ENTIRE TAPE, UP TO THE CURRENT        *   FILE 229
//*           FILE, ARE DISPLAYED.                                  *   FILE 229
//*                                                                 *   FILE 229
//*      32.  COPYMODS WILL DISPLAY MINIMUM AND MAXIMUM BLOCK       *   FILE 229
//*           SIZES FOR EACH TAPE FILE READ, WHEN THE MINMAX        *   FILE 229
//*           OPTION IS CODED.                                      *   FILE 229
//*                                                                 *   FILE 229
//*      33.  COPYMODS CAN OPTIONALLY SHOW THE SIZE OF EACH         *   FILE 229
//*           TAPE DATA BLOCK (TECHNICALLY CALLED A "RECORD")       *   FILE 229
//*           ON THE TAPE, USING THE RECSIZE OPTION.  AS CODED      *   FILE 229
//*           CURRENTLY, RECSIZE CAN PRODUCE A LOT OF SYSPRINT      *   FILE 229
//*           OUTPUT, SINCE IT PRODUCES ONE LINE PER TAPE DATA      *   FILE 229
//*           BLOCK.  THE RECSIZE OPTION DISPLAYS DETAILS,          *   FILE 229
//*           WHICH THE MINMAX OPTION SUMMARIZES.  IF RECSIZE       *   FILE 229
//*           IS CODED, THEN THE MINMAX OPTION IS FORCED ON.        *   FILE 229
//*                                                                 *   FILE 229
//*      34.  THE KEEPVOL OPTION WILL ALLOW THE USE OF THE VOL1     *   FILE 229
//*           LABEL FROM A TARGET TAPE, IF THE VOL1 OF THE          *   FILE 229
//*           TARGET TAPE EXISTS, AND IF IT IS THE SAME TYPE        *   FILE 229
//*           AS THE VOL1 OF THE COPIED TAPE.  THIS ALLOWS FOR      *   FILE 229
//*           THE MOUNTING OF A SCRATCH TAPE, WHERE YOU DON'T       *   FILE 229
//*           KNOW THE VOLSER OF THE TARGET TAPE AHEAD OF TIME.     *   FILE 229
//*           THE KEEPVOL OPTION WILL ALLOW THE COPIED VOLUME       *   FILE 229
//*           TO KEEP THE SAME VOLSER AS THE SCRATCH TAPE, SO       *   FILE 229
//*           THAT A TAPE MANAGEMENT SYSTEM CAN KEEP TRACK OF       *   FILE 229
//*           IT.  EACH TARGET TAPE WILL GET DIFFERENT ACTION       *   FILE 229
//*           USING KEEPVOL, DEPENDING ON WHAT WAS ON IT BEFORE.    *   FILE 229
//*           IF THE VOL1 LABEL ON THE TARGET TAPE IS NOT THE       *   FILE 229
//*           SAME TYPE AS THE SOURCE TAPE, OR IF THE TARGET        *   FILE 229
//*           TAPE IS NON-LABELED, THEN A "STRAIGHT COPY" IS        *   FILE 229
//*           DONE TO THAT PARTICULAR OUTPUT TAPE, AS BEFORE.       *   FILE 229
//*                                                                 *   FILE 229
//*      35.  A COMBINATION OF THE OPTIONS "READ" AND "SHOOVL"      *   FILE 229
//*           (SHOW OUTPUT VOLUMES) WILL DO A "DRY RUN" TO SHOW     *   FILE 229
//*           YOU THE FUTURE RESULTS FROM A "KEEPVOL" RUN.          *   FILE 229
//*           "READ" WILL READ THE INPUT TAPE IN ITS ENTIRETY,      *   FILE 229
//*           AND "SHOOVL" WILL SHOW YOU THE FIRST 80 BYTES OF      *   FILE 229
//*           EACH OF THE OUTPUT TAPES.  NO ACTUAL COPY OF THE      *   FILE 229
//*           INPUT TAPE WILL BE DONE.  "KEEPVOL" IMPLIES           *   FILE 229
//*           "SHOOVL", BUT A TAPE COPY WILL ACTUALLY BE DONE.      *   FILE 229
//*                                                                 *   FILE 229

```
