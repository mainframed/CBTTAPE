 This dataset contains DSECTs to be used to map memory by SHOWSTOR using
 the "/MAP(dsect_name)" command.

 You can map system control blocks or user programs using the SHOWSTOR
 infrastructure and DSECT members from this dataset.

 Use the HELP facility (by default PF01 key) under SHOWSTOR for details
 of how to create your own user/system DSECT maps.

 You can setup pointers to full macro by creating member name with a '@'
 prefixing the dot command.  In that member the words format is:
    1.  '*' comment indicator
    2.  Location.  MACLIB or MODGEN (or any other variable name) that is
        setup in SH$PARMS (the parameter driver of SHOWSTOR).
    3.  Member name in above dataset.
 Once the initial DSECT map is setup, you can use DSECTBP (or DBP
 LINEMAC command) to build the '@' pointer.  (If you introduce new
 source dataset then ensure that SH$PARMS is set up accordingly with the
 DD/DSN pairing.)
