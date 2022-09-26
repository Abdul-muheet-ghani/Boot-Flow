PROVIDE( __stack_top = ORIGIN(BRAM) + LENGTH(BRAM));
MEMORY
{
    DDR(rx):ORIGIN =0x80000000,LENGTH =4k
    BRAM(rwx):ORIGIN =0x8C000000,LENGTH =4k
}

SECTIONS
{
    .text :
    {
        *(.text)
        *(.rodata)
    }> BRAM

    . = 0x8C000000;
    .sdata :
    {
        *(.sdata)
    }> BRAM

    .bss :
    {
        *(.bss)
    }> DDR

    .sbss :
    {
        *(.sbss)
    }> DDR
}