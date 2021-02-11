LSTVOL   Utility catalog interface subroutine                 1991-09-24
LC       TSO CP to obtain a list of dataset names from a catalog
         under a given high-level index, placing output on terminal
         or to a dataset.
Public Domain software by Bruce E. Hgman (NaSpa: HogmBru3)
                                          (CompuServ:  72050,1327)
(703) 685-4926 (home)  (202) 586-1965 (work) EST zone

LSTVOL   ASM    349065 91-09-24   17:08
LSTVOL   CMD      6509 91-09-24   17:09
LSTVOL   HLP      7416 91-09-24   17:08
LSTVOL   PRT    140288 91-09-24   17:09

.ASM:  assembler source and macros in IEBUPDTE ./ ADD format.
  Build a PDS using IEBUPDTE, then assemble and link LSTVOL and
  then LC.  All required macros are packaged with source.

.CMD:  CLISTs in IEBUPDTE format.  Add to SYSPROC.  CLIST LVXOP
  uses LC command to assemble list of names to operate on.  This
  CLIST is particularly useful for sysprogs who must rename
  a list of datasets from one high level index to another.

.HLP:  HELP() members

.PRT:  Assembly and LKED listings in print format: FBA
