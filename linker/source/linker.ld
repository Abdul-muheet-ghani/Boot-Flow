PROVIDE( __stack_top = ORIGIN(BRAM) + LENGTH(BRAM));
MEMORY
{
    DDR(rx):ORIGIN =0x8C000000,LENGTH =4k
    BRAM(rwx):ORIGIN =0x00000000,LENGTH =4k
}

SECTIONS
{
    .text :
    {
        *(.text)
        *(.rodata)
    }> BRAM

    .data :
    {
        *(.data)
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