# linsupa.asm - support code for C programs for Linux
#
# This program written by Paul Edwards
# Released to the public domain

.globl __setj
__setj:
push %ebp
mov %esp, %ebp

movl 8(%ebp), %eax
push %ebp
mov %esp, %ebx
push %ebx # esp

movl %ecx, 4(%eax)
movl %edx, 8(%eax)
movl %edi, 12(%eax)
movl %esi, 16(%eax)

pop %ebx
movl %ebx, 20(%eax) # esp
movl 0(%ebp), %ebx
movl %ebx, 24(%eax) # ebp

movl 4(%ebp), %ebx # return address
movl %ebx, 28(%eax) # return address

pop %ebx
movl %ebx, 0(%eax)
mov $0, %eax

pop %ebp
ret



.globl __longj
__longj:
push %ebp
mov %esp, %ebp

movl 8(%ebp), %eax
movl 20(%eax), %ebp
mov %ebp, %esp

pop %ebx # position of old ebx
pop %ebx # position of old ebp
pop %ebx # position of old return address

mov 28(%eax), %ebx # return address
push %ebx

mov 24(%eax), %ebx # ebp saved as normal
push %ebx
mov %esp, %ebp

movl 0(%eax), %ebx
movl 4(%eax), %ecx
movl 8(%eax), %edx
movl 12(%eax), %edi
movl 16(%eax), %esi

movl 32(%eax), %eax

pop %ebp

ret


.globl __write
__write:
push %ebp
mov %esp, %ebp
push %ebx
push %ecx
push %edx

# function code 4 = write
movl $4, %eax
# handle
movl 8(%ebp), %ebx
# data pointer
movl 12(%ebp), %ecx
# length
movl 16(%ebp), %edx
int $0x80
pop %edx
pop %ecx
pop %ebx
pop %ebp
ret


.globl __read
__read:
push %ebp
mov %esp, %ebp
push %ebx
push %ecx
push %edx

# function code 3 = read
movl $3, %eax
# handle
movl 8(%ebp), %ebx
# data pointer
movl 12(%ebp), %ecx
# length
movl 16(%ebp), %edx
int $0x80
pop %edx
pop %ecx
pop %ebx
pop %ebp
ret



.globl __open
__open:
push %ebp
mov %esp, %ebp
push %ebx
push %ecx
push %edx

# function code 5 = open
movl $5, %eax
# filename
movl 8(%ebp), %ebx
# flag
movl 12(%ebp), %ecx
# mode
movl 16(%ebp), %edx
int $0x80
pop %edx
pop %ecx
pop %ebx
pop %ebp
ret



.globl __seek
__seek:
push %ebp
mov %esp, %ebp
push %ebx
push %ecx
push %edx

# function code 19 = lseek
movl $19, %eax
# handle
movl 8(%ebp), %ebx
# offset
movl 12(%ebp), %ecx
# whence
movl 16(%ebp), %edx
int $0x80
pop %edx
pop %ecx
pop %ebx
pop %ebp
ret



.globl __rename
__rename:
push %ebp
mov %esp, %ebp
push %ebx
push %ecx

# function code 38 = rename
movl $38, %eax
# old file
movl 8(%ebp), %ebx
# new file
movl 12(%ebp), %ecx
int $0x80
pop %ecx
pop %ebx
pop %ebp


.globl __remove
__remove:
push %ebp
mov %esp, %ebp
push %ebx
# function code 10 = unlink
movl $10, %eax
# filename
movl 8(%ebp), %ebx
int $0x80
pop %ebx
pop %ebp
ret


.globl __close
__close:
push %ebp
mov %esp, %ebp
push %ebx
# function code 6 = close
movl $6, %eax
# handle
movl 8(%ebp), %ebx
int $0x80
pop %ebx
pop %ebp
ret


.globl __exita
__exita:
# exit/terminate
movl $1, %eax
int $0x80
ret


.globl __time
__time:
push %ebp
mov %esp, %ebp
push %ebx
# function code 13 = retrieve current time
movl $13, %eax
# pointer to time_t
movl 8(%ebp), %ebx
int $0x80
pop %ebx
pop %ebp
ret
