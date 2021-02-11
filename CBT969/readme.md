```
//*  Member PDSEGEN -                                               *   FILE 312
//*                                                                 *   FILE 312
//*     The PDSEGEN ISPF Dialog found in this package will          *   FILE 312
//*     present the user with a list of all members of their        *   FILE 312
//*     PDSE, including all generations.  There are several         *   FILE 312
//*     commands and many line selection options available,         *   FILE 312
//*     including Browse, Edit, View, Compare, Delete, Promote,     *   FILE 312
//*     and Recover.  The list of members will be updated           *   FILE 312
//*     appropriately as members are edited, added, deleted,        *   FILE 312
//*     recovered, or promoted. Full member filtering using         *   FILE 312
//*     * and % is available as are date filters.                   *   FILE 312
//*                                                                 *   FILE 312
//*     Other capabilities include the ability to Backup your       *   FILE 312
//*     PDSE, with ALL generations, to a standard PDS so that       *   FILE 312
//*     it can be transported/copied by other utilities. Then       *   FILE 312
//*     there is the Restore capability to rebuild the PDSE with    *   FILE 312
//*     all generations.                                            *   FILE 312
//*                                                                 *   FILE 312
//*     The Copy command will copy a PDS into a PDSE with           *   FILE 312
//*     generations enabled or copy a PDSE with members and         *   FILE 312
//*     generations to another PDSE without the loss of any         *   FILE 312
//*     generations.                                                *   FILE 312
//*                                                                 *   FILE 312
//*     The PRUNE function will let you remove older (or all)       *   FILE 312
//*     generations that the user considers obsolete. Or            *   FILE 312
//*     completely empty the PDSE of all members and generations.   *   FILE 312
//*     PRUNE can be limited using FILTERs.                         *   FILE 312
//*                                                                 *   FILE 312
//*     The Validate command will invoke the IBM IEBPDSE utility    *   FILE 312
//*     which will validate the integrity of the PDSE and, if       *   FILE 312
//*     the correct PTF is installed clean up pending delete        *   FILE 312
//*     members/generations.                                        *   FILE 312
//*                                                                 *   FILE 312
//*     Reasons to consider PDSEGEN:                                *   FILE 312
//*                                                                 *   FILE 312
//*     1. To see the generations easily                            *   FILE 312
//*     2. To be able to compare current generation to prior        *   FILE 312
//*        generations to see what changed (broke)                  *   FILE 312
//*     3. To easily recover a prior generation using recover to a  *   FILE 312
//*        new member or promote to replace the current base member *   FILE 312
//*     4. To easily clean up obsolete, no longer needed,           *   FILE 312
//*        generations (prune)                                      *   FILE 312
//*     5. To safely copy the base member and all generations       *   FILE 312
//*     6. To easily backup and restore without loss of generations *   FILE 312
//*     7. Protection from accidentally editing a non-0 generation  *   FILE 312
//*     8. Easily search members and generations                    *   FILE 312
//*     9. Easy access to up to 15 datasets                         *   FILE 312
//*     10. Info on which generation is being browsed/edited/viewed *   FILE 312
//*     11. All the above and more                                  *   FILE 312
//*                                                                 *   FILE 312
//*     NOTE: This application requires z/OS 2.1 or newer to        *   FILE 312
//*           support access via ISPF to generations and does       *   FILE 312
//*           NOT support load libraries or aliases at this         *   FILE 312
//*           time.                                                 *   FILE 312

```
