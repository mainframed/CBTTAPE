                            Notes and Commentary

Georgetown University uses the homegrown utility CCFDELET for ensuring
that a data set is deleted prior to running a step that will reallocate
it. It has some advantages over the following alternatives:
1) IEFBR14 with a "MOD,DELETE" DD card. Unfortunately, if the data set
   is in migrated status, DFHSM will first restore it before deleting
   it. There is no restore with CCFDELET.
2) IDCAMS. The need to use control cards is the disadvantage here. With
   CCFDELET, you (can) specify the data set to delete in the PARM field
   of the EXEC card.
CCFDELET has the good points of IEFBR14 without the disadvantage of
recalling migrated data sets. The data set to delete is visible in the
JCL. It works with JCL procedures and JCL symbols.

CCFDELET deletes data sets by invoking IDCAMS and supplying control
cards to it. The appendix "Invoking Access Method Services from Your
Program" in the Access Method Services manual taught me how to do this.
The program has not changed since 1994. What was assembled and linked
then has continued to work up through OS/390 2.10, which is the release
that Georgetown currently runs.

You are getting the source Georgetown uses with one exception noted
below.  You should probably review it before you put it into
production.  It works at Georgetown but no guarantee is made that it
will work anywhere else. Use it at your own risk.  The one change to
the source is a commented out entry of the text unit pointer list that
starts at the label TUPTRLST. Comments there indicate why.

You can reach me at:
email: sipusic@georgetown.edu
phone: 202-687-3934
address: Thomas Sipusic
         Georgetown University Information Services
         Box 571138
         St. Mary's Hall 304D
         Washingtion, DC 20057
