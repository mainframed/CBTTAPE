#ifdef IN_GCC
#ifdef S390
# include "s390-protos.h"
#elif defined(I386)
# include "i386-protos.h"
#else
# include "i370-protos.h"
#endif
#endif
#include "tm-preds.h"
