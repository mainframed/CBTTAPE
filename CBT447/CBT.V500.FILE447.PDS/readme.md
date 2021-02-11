
## @FILE447.txt
```
//***FILE 447 is from Rick Fochtman of Chicago, Illinois, and       *   FILE 447
//*           contains two programs to improve GRS facilities,      *   FILE 447
//*           so that the messages which GRS produces, will         *   FILE 447
//*           approximate those which MIM produces, reporting       *   FILE 447
//*           ENQUEUE conflicts on the operator console.            *   FILE 447
//*                                                                 *   FILE 447
//*             email:   sbgolob@cbttape.org     or                 *   FILE 447
//*                      sbgolob@attglobal.net                      *   FILE 447
//*                                                                 *   FILE 447
//*           Since we've gone to GRS, in place of MIM, there       *   FILE 447
//*           was one feature of MIM that was sorely missed.        *   FILE 447
//*           MIM would explain the nature of dataset               *   FILE 447
//*           contentions in greater detail than the initial        *   FILE 447
//*           messages from GRS.  True, you could get the detail    *   FILE 447
//*           by issuing the "D GRS,C" command, if you managed      *   FILE 447
//*           to catch it quick enough.  We deemed that this was    *   FILE 447
//*           insufficient.  Attached are the solutions             *   FILE 447
//*           developed here.  One is a started task that checks    *   FILE 447
//*           for a contention situation each minute and            *   FILE 447
//*           displays information about it.  The other is an MPF   *   FILE 447
//*           exit that displays the same information whenever a    *   FILE 447
//*           dataset contention situation is announced via the     *   FILE 447
//*           IEF099I message.                                      *   FILE 447
//*                                                                 *   FILE 447
```

