
## $$$DOC.txt
```
This is the SOURCE library for Jeff Kaplan's collection of software.

This collection is currently in the condition of 'hodge-podge',
however, there is much useful material here.

    File 252 contains Jeff Kaplan's   SOURCE   library
    File 253 contains Jeff Kaplan's   EXEC     library
    File 254 contains Jeff Kaplan's   CNTL     library
    File 255 contains Jeff Kaplan's   ISPPLIB  library
    File 256 contains Jeff Kaplan's   ISPTLIB  library

Nothing is GUARANTEED to work anywhere else.  The user will have to
-------
              "look and try".......    However, there is much good
              code in this collection, including numerous direct
              calls to SVC 26.

   I am (sort of) an intermediary between Jeff Kaplan and the public.
However, his direct work phone is:  215-633-4614.

   If you can't reach Jeff at work, please try:

          Sam Golob
          P.O. Box 906
          Tallman, New York 10982-0906

          sbgolob@attglobal.net

Note:  Jeff's CNTL library also contains Assembler Source and REXX
       execs.  Please explore ALL files in this collection.  As of
       this cut of the tape, I have not sifted through all of Jeff's
       stuff and straightened it out.  There may also be some
       duplication of source code or REXX execs.

```

## $#DOC.txt
```
 This is a partial list of some of the things in this collection.


     ABENDWTO  -  Somewhat shop-dependent code which shows how
                  to scan for abends and return codes from
                  previous steps in the same job.  Then, if
                  there is a bad return code or abend, save all
                  the temporary files.

     ABINDEX   -  Shop-dependent.  Shows how to create hiperspace
                  etc.

     B2C       -  REXX binary-to-character conversion function.

     CATEDIT   -  Update an ICF Catalog in-place using QSAM
                  PUTX.  Purpose is to convert all files
                  cataloged to 3480's or 3490's into 3490e's.
                  (Interesting code.  Has to be authorized nowadays.)

     DYNADSN   -  Dynamically alters dsnames in succeeding
                  steps of a job.

     DYNATEST  -  JCL to test DYNADSN.

     FINDEXEC  -  EXEC to find where an EXEC is.

     FINDLLIB  -  EXEC to find an ISPLLIB member.

     FINDLOAD  -  EXEC to find a load module in the link list.

     FINDMLIB  -  EXEC to find an ISPF message member.

     FINDPLIB  -  Exec to find an ISPF panel.

     FINDSLIB  -  Exec to find an ISPF skeleton.

     FINDTLIB  -  Exec to find an ISPF table.

     FREEALL   -  TSO Free All command

     GRSUSER   -  TSO Command that can be used from an ISPF
                  3.4 list to determine who has the file.

     IGDACSMC  -  SMS ACS management class exit that can
                  dynamically change ACS variables.

     LINKLIST  -  Lists libraries in the link list.

     LPAR      -  (Modify to work in another shop)
                  Tells CPUID, etc.

     RACFUSER  -  TSO Command to display some RACF user data.

     RACFUSR1  -  Similar to RACFUSER.

     SLEEPSRC  -  SLEEP command from REXX.

     TIMEOUT   -  TSO/E Command to dynamically set TIME=1440
                  for your id.

     VMFCLEAR  -  TSO/E Clear Screen - like VM.

     XDSL      -

     XDSLSRC   -  External 3.4.  But shop dependent.  See
                  catalog access code in this member.  Direct
                  SVC 26 calls.

     XLIBALLD  -  TSO doesn't support SUBSYS= accesses that JCL
                  supports.  This allows these allocations in TSO.
                  Used for allocation LIBRARIAN datasets on TSO.

     XLIBALLS  -

     XLIBMEML  -  "Member Exists" REXX function.

     XLIBMEMX  -  "Member Exists" REXX function.

     XLISTA    -  LISTALC with a better format.

```

