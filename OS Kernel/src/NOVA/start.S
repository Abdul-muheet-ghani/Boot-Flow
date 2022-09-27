.global start

.section .text
    start:
        addi x4,x0,9
        li	a5,35
        slli a5,a5,0x1a
        sw x4,0(x5)
        ret