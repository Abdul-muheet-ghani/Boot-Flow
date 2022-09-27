#include <stdint.h>
#include <stdio.h>

#define a (*(int *)0x8C000000)
#define b (*(int *)0x8C000004)
#define c (*(int *)0x8C000008)
#define e (*(int *)0x88000000)

int main() {
    char d[50] = {'h','e'};
    e = d;
    a=10;
    b=2;
    c = b+a;
    return 0;
}