#include <stddef.h>

#pragma linkage(__aopen, OS)
void *__aopen(const char *ddname, int *mode, int *recfm,
              int *lrecl, int *blksize, void **asmbuf, const char *member);
#pragma linkage(__aread, OS)
int __aread(void *handle, void *buf, size_t *len);
#pragma linkage(__awrite, OS)
int __awrite(void *handle, unsigned char **buf, size_t *sz);
#pragma linkage(__aclose, OS)
void __aclose(void *handle);
#pragma linkage(__getclk, OS)
unsigned int __getclk(void *buf);
#pragma linkage(__gettz, OS)
int __gettz(void);
#pragma linkage(__getm, OS)
void *__getm(size_t sz);
#pragma linkage(__freem, OS)
void __freem(void *ptr);

#pragma linkage(__dynal, OS)
int __dynal(size_t ddn_len, char *ddn, size_t dsn_len, char *dsn);

#pragma linkage(__idcams, OS)
int __idcams(size_t len, char *data);

#pragma linkage(__getpfx, OS)
char *__getpfx(void);

#pragma linkage(__system, OS)
#ifdef MUSIC
int __system(int len, const char *command);
int __textlc(void);
int __svc99(void *rb);
#else
int __system(int req_type,
             size_t pgm_len,
             char *pgm,
             size_t parm_len,
             char *parm);
#endif

#pragma linkage(__doloop, OS)
void __doloop(void);
