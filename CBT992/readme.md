```
//***FILE 992 is a collection of code snippets (not necessarily     *   FILE 992
//*           executable as-is) which have been used in programs    *   FILE 992
//*           to limit their use, for safety and security reasons.  *   FILE 992
//*           If you only want certain people to use the code, or   *   FILE 992
//*           if you require that a user have access to a certain   *   FILE 992
//*           RACF profile, etc. etc., here is some code that you   *   FILE 992
//*           can fit into existing programs to accomplish that     *   FILE 992
//*           goal.  Also, some narratives (without code) have      *   FILE 992
//*           been included, explaining the rationale behind        *   FILE 992
//*           either protecting code from unauthorized use, or to   *   FILE 992
//*           show how to bypass existing protection, as well.      *   FILE 992
//*           It all depends on what you need, or what you want     *   FILE 992
//*           to do.                                                *   FILE 992
//*                                                                 *   FILE 992
//*       Members in this PDS:                                      *   FILE 992
//*                                                                 *   FILE 992
//*       IMPLEXEC - Code which makes the unauthorized user think   *   FILE 992
//*                  that the command doesn't exist.                *   FILE 992
//*                                                                 *   FILE 992
//*       IDS8CHAR - Notes on how to convert PSCBUSER dependent     *   FILE 992
//*                  code, which identifies the user's TSO id,      *   FILE 992
//*                  when 8-character userids are in effect, and    *   FILE 992
//*                  you're running under one of these.  Then,      *   FILE 992
//*                  the PSCBUSER field isn't valid.                *   FILE 992
//*                                                                 *   FILE 992
//*       RACRO01  - Code to use RACROUTE to require READ access    *   FILE 992
//*                  to FACILITY class profiles, in order to run    *   FILE 992
//*                  the TSO command.                               *   FILE 992
//*                                                                 *   FILE 992
//*       RACRO02  - Code to use RACROUTE to require READ access    *   FILE 992
//*                  to FACILITY class profiles, in order to run    *   FILE 992
//*                  a batch program.                               *   FILE 992
//*                                                                 *   FILE 992

```
