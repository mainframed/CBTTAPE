This dataset contains JCL and test data for the MTCHMRG program.

The test scripts should have return codes of 0 from all IEBCOMPR
steps.  Some of the executions of the MTCHMRG program will have
return codes of 1 indicating multiple matching keys were found
in both SYSUT1 and SYSUT2.  Some of the executions of the MTCHMRG
program will have return codes of 8 indicating the input parms do
not match the DD statements.  This last condition is what is being
tested for, and the test and prod versions of the program should
produce identical return codes.

The volume test script is only for comparing performance.

$README  This member
@nnnS1   SYSUT1 input members for testing
@nnnS2   SYSUT2 input members for testing
COMPARE  IEBCOMPR control card for testing
MTCHTST0 Test script to verify any changes you make
MTCHTST1 Continuation of Test script to verify any changes you make
MTCHTST2 Continuation of Test script to verify any changes you make
MTCHTST3 Continuation of Test script to verify any changes you make
MTCHTST4 Continuation of Test script to verify any changes you make
MTCHTST5 Continuation of Test script to verify any changes you make
MTCHTST6 Volume Test script to verify any changes you make

