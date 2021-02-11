With SAVELAB 2.0 the saved labels are now available regardless of the ISPF
Profile (applid) in use as the labels are now stored in an ISPF Table. During
the 1st use of SAVELAB 2.0 all the existing labels will be converted from the
ISPF Profile variable to a table (occurs only once so do this on the applid
that is most used).

Conversion can be done by using the pre 2.0 release to EXPORT the labels
that you care about and then IMPORT them using the 2.0 release.

NOTE: - do this before using the SAVELAB 2.0 or the conversion will fail.

If you have used a previous version of SAVELAB (prior to version 1.16)
then you should install the SAVELABF exec and have your users use it.

This will update the # character in the ISPF Profile variable savelbl to
the % character since a # may be used in a member name.
