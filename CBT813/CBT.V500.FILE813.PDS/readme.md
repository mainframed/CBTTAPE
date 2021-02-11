
## @FILE813.txt
```
//***FILE 813 is from Richard L. Rice and contains a fixed version  *   FILE 813
//*           of his SUTL (System Utility) package that allow you   *   FILE 813
//*           to get system information from an MVS system on your  *   FILE 813
//*           network that you are NOT logged on to.  This utility  *   FILE 813
//*           was previously packaged on File 171.                  *   FILE 813
//*                                                                 *   FILE 813
//*           email:  Richard.L.Rice@conocophillips.com             *   FILE 813
//*                                                                 *   FILE 813
//*       SYSTEM UTILITY (SUTL)  -  A VTAM LU 6.2 application       *   FILE 813
//*                  that allows a TSO user to obtain informa-      *   FILE 813
//*                  tion about executing jobs, the APF list,       *   FILE 813
//*                  IPL date/time/sysres, link list, etc.          *   FILE 813
//*                  Most of this information is usually            *   FILE 813
//*                  available via other utilities already in       *   FILE 813
//*                  use, but this utility allows the TSO user      *   FILE 813
//*                  to get info from a system that he is not       *   FILE 813
//*                  logged on to.                                  *   FILE 813
//*                                                                 *   FILE 813
//*                    SYSTEM UTILITY (SUTL)                        *   FILE 813
//*                                                                 *   FILE 813
//*        SUTL IS A VTAM LU 6.2 APPLICATION THAT ALLOWS A TSO      *   FILE 813
//*        USER TO OBTAIN INFORMATION ABOUT EXECUTING JOBS, THE     *   FILE 813
//*        APF LIST, IPL DATE/TIME/SYSRES, LINK LIST, ETC.  MOST    *   FILE 813
//*        OF THIS INFORMATION IS USUALLY AVAILABLE VIA OTHER       *   FILE 813
//*        UTILITIES ALREADY IN USE, SO WHY BOTHER GOING TO THE     *   FILE 813
//*        TROUBLE OF 'RE-INVENTING' THIS WHEEL AND ADDING VTAM     *   FILE 813
//*        OVER-HEAD IN THE PROCESS?  BEING A VTAM APPLICATION      *   FILE 813
//*        MEANS THAT A TSO USER CAN GET INFO FROM A SYSTEM         *   FILE 813
//*        THAT HE IS NOT LOGGED ON TO.  IF YOU HAVE MULTIPLE       *   FILE 813
//*        PROCESSORS OR LPARS, YOU CAN "WATCH" EXECUTING JOBS ON   *   FILE 813
//*        ANY OF THE SYSTEMS NO MATTER WHICH SYSTEM YOU ARE        *   FILE 813
//*        LOGGED ON TO.  BESIDES IT WAS A GOOD WAY TO LEARN        *   FILE 813
//*        SOMETHING AND HAVE A USEFUL UTILITY WHEN IT WAS          *   FILE 813
//*        WORKING.                                                 *   FILE 813
//*                                                                 *   FILE 813
//*        SUTL CONSISTS OF TWO BASIC COMPONENTS, (1) A DATA        *   FILE 813
//*        COLLECTOR THAT WOULD PROBABLY BE BEST TO RUN AS A        *   FILE 813
//*        STARTED TASK (STC) AND (2) THE TSO/SPF CODE THAT SENDS   *   FILE 813
//*        REQUESTS TO THE DATA COLLECTOR AND DISPLAYS THE DATA.    *   FILE 813
//*                                                                 *   FILE 813
//*        THE DATA COLLECTOR (STC) SHOULD BE RUN ON EACH SYSTEM.   *   FILE 813
//*        THE STC DOES REQUIRE APF AUTHORIZATION FOR THE UCB       *   FILE 813
//*        FUNCTION.  IF YOU REMOVE THE UCB FUNCTION, SUTL WILL     *   FILE 813
//*        NOT REQUIRE ANY SPECIAL PRIVILEGES.                      *   FILE 813
//*                                                                 *   FILE 813
//*        THE TSO/SPF PART REQUIRES ONE VTAM APPL ID PER ACTIVE    *   FILE 813
//*        TSO USER.  THESE APPL IDS ARE ASSEMBLED AND LINK         *   FILE 813
//*        EDITED INTO A LOAD MODULE AS PART OF THE INSTALLATION    *   FILE 813
//*        STEPS.  I FELT THAT IT WOULD BE LESS OVERHEAD PER        *   FILE 813
//*        INVOCATION TO SEARCH A PRE-ASSEMBLED/LINK EDITED LOAD    *   FILE 813
//*        MODULE THAN TO READ A PARAMETER DATA SET (THIS WOULD     *   FILE 813
//*        MEAN ALLOCATING THE DATA SET, OPENING IT, READING AND    *   FILE 813
//*        SCANNING EACH STATEMENT, CLOSING, AND THEN               *   FILE 813
//*        DE-ALLOCATING).                                          *   FILE 813
//*                                                                 *   FILE 813
//*                                                                 *   FILE 813
```

