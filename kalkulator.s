SYSEXIT = 1
EXIT_SUCCESS = 0

.data
    dodatnia:
        .float 2.40
    ujemna:
        .float -1.13
    zero:
        .float 0.00

    single:
        .byte 0x7f, 0x00
    double:
        .byte 0x7f, 0x02

.section .text
.global _start

_start:
    fldcw double
    #fldcw single

    fldz
    fdiv dodatnia   #+0

    fldz
    fdiv ujemna     #-0

    flds dodatnia
    fdiv zero       #+inf

    flds ujemna
    fdiv zero       #-inf

    fldz
    fdiv zero       #NaN

    mov $SYSEXIT, %eax
    mov $EXIT_SUCCESS, %ebx

    int $0x80
