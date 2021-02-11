```
//***FILE 700 is from Jim Haire and contains some very useful       *   FILE 700
//*           REXX execs.                                           *   FILE 700
//*                                                                 *   FILE 700
//*           email:  James.Haire@target.com                        *   FILE 700
//*                                                                 *   FILE 700
//*     Documentation of the execs:                                 *   FILE 700
//*                                                                 *   FILE 700
//*     The components I sent are easily installed.  Just put       *   FILE 700
//*     them in a dataset allocated to SYSEXEC and they should      *   FILE 700
//*     work.                                                       *   FILE 700
//*                                                                 *   FILE 700
//*     3 of the components are subroutines used by the main        *   FILE 700
//*     commands:                                                   *   FILE 700
//*                                                                 *   FILE 700
//*          @CURSOR  - Subroutine which returns information        *   FILE 700
//*                     about the location of the cursor.           *   FILE 700
//*          @DATA    - Returns the data on the line the cursor     *   FILE 700
//*                     is on.                                      *   FILE 700
//*          @CONVERT - Performs numeric conversion within the      *   FILE 700
//*                     SUM command.                                *   FILE 700
//*                                                                 *   FILE 700
//*     The commands are as follows:                                *   FILE 700
//*                                                                 *   FILE 700
//*     SNIP -     Use this command to cut a piece of code          *   FILE 700
//*                without cutting the whole line.  Goes over       *   FILE 700
//*                multiple screens.  Best used when the            *   FILE 700
//*                command is put behind a PF KEY.                  *   FILE 700
//*                                                                 *   FILE 700
//*                In EDIT or VIEW mode, place your cursor at       *   FILE 700
//*                the upper leftmost part of the code you want     *   FILE 700
//*                to cut out within your dataset.   Press your     *   FILE 700
//*                "SNIP" key.  Next place your cursor at the       *   FILE 700
//*                lower rightmost corner of the data you want      *   FILE 700
//*                to cut.  Press the "SNIP" key again.  You        *   FILE 700
//*                have just cut that section of code to your       *   FILE 700
//*                profile.                                         *   FILE 700
//*                                                                 *   FILE 700
//*                If you continue to use the SNIP command, the     *   FILE 700
//*                data will be appended to the end of your         *   FILE 700
//*                profile.                                         *   FILE 700
//*                                                                 *   FILE 700
//*     SNIPSHOT - This gives you a "snapshot" of the data you      *   FILE 700
//*                have just snipped.                               *   FILE 700
//*                                                                 *   FILE 700
//*                Type "SNIPSHOT" on the command line to see       *   FILE 700
//*                what you snipped.  You also have the ability     *   FILE 700
//*                to clear your profile at this time if you        *   FILE 700
//*                like.                                            *   FILE 700
//*                                                                 *   FILE 700
//*     GLUE     - This will paste the contents of the profile      *   FILE 700
//*                to wherever you have placed your cursor.         *   FILE 700
//*                                                                 *   FILE 700
//*                Type "GLUE" and place your cursor where you      *   FILE 700
//*                want the data in the profile to appear.          *   FILE 700
//*                This could overlay the data which is already     *   FILE 700
//*                there.  You can use the (B)efore and (A)fter     *   FILE 700
//*                commands to insert lines before or after the     *   FILE 700
//*                line the cursor is on.                           *   FILE 700
//*                                                                 *   FILE 700
//*                The GLUE command will remove the data from       *   FILE 700
//*                the profile.  You can type "GLUE KEEP" to        *   FILE 700
//*                keep the data in the profile after the GLUE      *   FILE 700
//*                command has been completed.                      *   FILE 700
//*                                                                 *   FILE 700
//*     PICK     - Like the SNIP command, except it cuts out the    *   FILE 700
//*                data the cursor is on, delimited by spaces.      *   FILE 700
//*                Only need to execute the PICK command once to    *   FILE 700
//*                cut out the data.                                *   FILE 700
//*                                                                 *   FILE 700
//*     STAG     - Short for STAGGER.  Lets you GLUE one line       *   FILE 700
//*                at a time out of the profile.                    *   FILE 700
//*                                                                 *   FILE 700
//*                The line is removed after it is GLUEd.           *   FILE 700
//*                                                                 *   FILE 700
//*     SUM      - If you have placed numbers in your profile       *   FILE 700
//*                through the SNIP or PICK commands, you can       *   FILE 700
//*                sum these numbers without having to use a        *   FILE 700
//*                calculator.                                      *   FILE 700
//*                                                                 *   FILE 700
//*     ERASPROF - Erases the contents of the profile.              *   FILE 700
//*                                                                 *   FILE 700
//*     There are explanations in the comments of the programs      *   FILE 700
//*     themselves which give options for using the commands        *   FILE 700
//*                                                                 *   FILE 700

```
