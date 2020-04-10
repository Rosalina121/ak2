    SYSEXIT = 1
    EXIT_SUCCESS = 0

.data

liczba1:
    .long 0xf005a031,0x19f70012,0xdeadbeef,0x42042069

liczba2:
    .long 0xfff00022,0x00234111,0x12345678,0xfedcba11

.global _start

_start:
    movl $4, %edx               ;licznik do petli
    clc
    pushf

dodawanie:
    decl %edx
    popf

    movl liczba1 (,%edx,4),%eax
    movl liczba2 (,%edx,4),%ebx
    adcl %eax, %ebx
    pushl %ebx
    pushf

    cmp $0, %edx
    jne dodawanie

    popf
    movl $0, %eax
    adcl $0, %eax

    cmp $1, %eax
    jne end
    pushl %eax

end:
    mov $SYSEXIT, %eax
    mov $EXIT_SUCCESS, %ebx
    int $0x80