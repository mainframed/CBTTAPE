             ISPF Edit cursor macros V/B/E
             -----------------------------

 Using these macros you can quickly open data sets or its members
 whose names are on your screen in Edit/View mode. Just move the cursor
 to the need name and press Fn assigned early to V(view), E(edit), or
 B(browse).

 To assign an Fn key in Edit/View mode, type KEYS in the command line,
 then assign for example F4 and F16 (shift+F4) as follows:
   F4 . . .  V________________________________________  SHORT   V/E___
   F16  . .  E________________________________________  SHORT   V/E___

 Macros understand and substitute the following JCL variables:
  - &SYSUID variable
  - 5 first PROC variables (//P1 PROC HLQ=MDCP,TYPE='PROD',...
  - SET variables          (//   SET  M=BSPUFI

 To activate macros copy V,B,E,VBE members to a library allocated
 with dd-name SYSPROC for your ISPF session. Use TASID 6 or ISRDDN
 in the command line to get info about your SYSPROC libraries.

 Best wishes,
             Vladimir Mestovski,IBA,Minsk,Belarus
                  v2gri033@us.ibm.com
                  mestovsky@iba.by
