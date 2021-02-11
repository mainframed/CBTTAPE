
## $$README.txt
```
Notes:

This program was submitted to the CBT Tape by Jim Marshall (File 316)
and was fixed by Eugene Vogt.  email: racfra2@bluewin.ch

TIDYASM is a program that cleans up Assembler code and repositions
the comments.  The default PARM is PARM='36,71' where 36 is the
column where the comments are assumed to begin, and 71 is the
column where the comments are assumed to end.  I do not recommend
making the second parm any less than 71, for the following reason:

TIDYASM (as currently coded) has a possibility of going into an
endless loop.  Coding the second parm too small, will make it easier
for the loop to happen.  This situation is currently being looked
into, but for now, we are putting this program out anyway, so people
can benefit from it when it does work, which is most of the time.

My recommendation is that for a given piece of source code, you
should try running this program without a PARM, taking the default
of column 36 for "comment start" and 71 for "comment end".  If
that works well for you, then you can start playing with the
parms, to see if a different setting will work out better.  But
always keep watching out for the loop, because it is endless, and
this program (even for very large source modules) should end very
quickly when there is no loop.

Good luck.

Sam Golob  (sbgolob@attglobal.net   or  sbgolob@cbttape.org)

```

