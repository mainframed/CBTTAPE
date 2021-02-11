SHAREVAR is a REXX program designed to make it easy to share REXX
variables, including stems, between different REXX programs.  Only stems
that are numeric,and for which stem.0 has the count, are supported.

All listed variables, including stem variables will be encoded into
the ISPF variable that is then saved in the ISPF Shared variable Pool
with a Put and all variables in the list will be reconstituted on the
Get.

Examples are provided:

          TVX is the driver demonstration exec. Invoke it with a dataset
          name, or let it default to SYS1.PARMLIB, and it invokes TVX0
          to create a set of REXX variables and a stem. The variables
          are then 'put' to an ISPF variable of 'dsi'. Next TVX invokes
          TVX1 to 'get' the 'dsi' variable, decodes it to recreate all
          of the original variables, including the stem. TVX1 then
          displays, using the say instruction, the variables and their
          values.

Usage:    To use SHAREVAR, copy the entire member into the REXX
          programs that will be using it.

Syntax:     rc = sharevar(action ispfvar list)

            rc = return code

            Action is:  Put or Get
                  Put will create the ISPF variable with
                      the provided list of rexx variables
                      'encoded' within.
                  Get will restore the rexx variables

            ispfvar is the ISPF variable name to use

            list is a list, enclosed in quotes, of REXX
                    variables to be Put (shared).

Examples:   rc = sharevar('put' 'myispfvar' ,
                          'userid var1 var2 stem1. stem2.')
            rc = sharevar('get' 'myisfvar')

Usage Notes: This code must be copied into each of the
              REXX execs in which it will be used

              If called and not under ISPEXEC then it
              will Address ISPExec

              Each REXX variable will be 'encoded' with an
              x'01' before each variable or stem value.
              Each stem value will be encoded on it's own
              and only numeric stems are supported.

              Sample:  is the x'01'

               USERID slbd  stem.0 4  stem.1 abc ...

              Procedure is not used as it hides all the
              routines variables which must be exposed.
              Since we don't know which variables to
              expose - none are.

Dependencies: Must be used under ISPF
