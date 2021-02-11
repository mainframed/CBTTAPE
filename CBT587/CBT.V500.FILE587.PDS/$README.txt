 This is an older version of the VTOC command looking for some
 talented and worthy person who is willing to merge it with the
 current VTOC command.  I'm sorry I did not feed this back to the
 world when I did the work, but now I would like to make amends.

 Well here's the idea I had. Even though my version left off around
 1990 there are still many improvements that could be incorporated
 into the existing VTOC command. I warn you it won't be easy; I had
 to scare up additional base registers in my time.

 Why would you want this stuff?

 1) I coded a VTOCMAP module which generates a mapping of the VTOC
 that can optionally be outputted to the VTOCOUT DD if you use the
 MAP operand, but the beauty was I always did a VTOC integrity check
 to show gaps or overlapping extents in the VTOCs I was reading and
 put out a message if there were errors even if you did not have the
 MAP operand.

 2) I coded the "NOT" of many operands like NLEV (things of NOT this
 high level qualifier would show in the output), NCON (NOT
 containing), NEND (NOT ending).

 3) Added  BEG and NBEG (beginning with and not beginning with like
 BEG(SYS) which shows SYSxxxxx as opposed to coding LE(SYS1 SYS2
 SYS3 etc).

 4) Minor allowed > < = ^= etc instead of GT, LT, EQ, and NE on LIM
 and ANDx operands.

 5) Increased ANDx and ORx to allow many more conditionals than the
 original VTOC command had.

 6) Allowed * on checking for dates, where * means current date.
 I.E. LIM(CDATE LT *) meaning I want things created prior to today.

 7) Did something to allow KEYLE (key length) for ISAM I think.

 8) Added LOWLEVEL and NLOWLEVEL to allow check of entire low level
 qualifier as opposed to END which only checks that the last few
 characters match.

 9) Put volume ID in error messages for better knowledge of which
 pack had a problem.

 10) Turn off catalog search when extents are zero.

 11) Provide ability to show whether last open of a dataset was for
 update or not.

 12) Allow OPTCD as a LIM value, was originally done to spot use of
 OPTCD EQ W which I didn't want people using.

  All modifications are well documented within the code, line by
 line and in a modifications list up front in the modules.

  Definitely as this code currently stands it only knew about UCB
 addresses that were 000-FFF; it knew not of 0000-FFFF UCB
 addresses.
