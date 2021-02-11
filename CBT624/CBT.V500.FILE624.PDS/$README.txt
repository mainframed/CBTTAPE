Important Note for the FIND REXX to be able to run correctly.

  A "CALL IDCAMS" TSO command will have to call IDCAMS in
  APF authorized mode.  This is accomplished by putting an
  entry for IDCAMS in the active IKJTSOxx member in PARMLIB,
  in the AUTHPGM NAMES( ) section.  Also, you can see CBT
  Tape files 185 and 186 for a way to accomplish this APF
  authorization for a limited group of users, or for yourself
  only.  Or you can use a PARMLIB TSO command, if you have
  authority to do so.

  Note by Sam Golob - 04/30/03      sbgolob@cbttape.org

