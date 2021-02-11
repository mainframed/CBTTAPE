ALLOCADD and DEALLOC are a pair of REXX exec's for use with dynamically
adding and removing datasets from a DD allocation.

ALLOCADD is a TSO Command in REXX that will add one, or more, datasets
to an existing allocation. If the ddname is not allocated then it will
be allocated.

    Syntax:    %allocadd ddname dsn1 dsn2 dsn3 ... dsn# \ opt

               opt is B to place last otherwise the dsns are
               allocated in before existing allocations

There are TSO concatenation commands on the CBT Tape, and elsewhere,
that are load modules and thus more efficient than this.

DEALLOC is a TSO Command in REXX that will remove one dataset from an
existing allocation.

This version is intended for sites where the installation of a load modules
may be prohibited.

This code is provided as-is, without any warranty or guarantee, and the
usual stipulation that before using it should be tested in your site.

===================================================================

CONCATIT:
 Function:  Three (3) in one

            Re-Allocate the specified DD adding the
            requested dataset(s) to the front (F) or
            back (B - default) of the allocation

 Syntax:    %concatit option

            Options:  A - Add dataset(s) to a DD
                      R - Remove a dataset from a DD
                      L - List the datasets allocated to DD

 Add:       %concatit A ddname dsn1 dsn2 dsn3 . dsn# \ opt

            opt is B to place last otherwise the dsns are
            allocated in before existing allocations

 Usage Notes: If the ddname is not allocated it will be

 Remove:    %concatit R ddname dsn

 List:      %concatit L ddname
