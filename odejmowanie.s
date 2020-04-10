    SYSEXIT = 1
    EXIT_SUCCESS = 0

.data

liczba1:
    .long 0xffffa031,0x19f70012,0xdeadbeef,0x42042069

liczba2:
    .long 0x00f00022,0x00234111,0x12345678,0xfedcba11

.global _start

_start:
    movl $4, %edx               #licznik do petli
    clc
    pushf

odejmowanie:
    clc
    
    decl %edx
    popf

    movl liczba1 (,%edx,4),%eax
    movl liczba2 (,%edx,4),%ebx

    sbb %eax, %ebx
    pushl %ebx
    pushf

    cmp $0, %edx
    jz przeniesienie

    sub $1, %edx
    jmp end

przeniesienie:
    popf
    movl $0,%eax
    movl $0,%ebx

    sbb %eax,%ebx
    push %ebx
    movl $4,%edx
    jmp end

end:
    mov $SYSEXIT, %eax
    mov $EXIT_SUCCESS, %ebx
    int $0x80