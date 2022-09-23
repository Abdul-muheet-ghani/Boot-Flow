ENTRY(_start)
PROVIDE( __stack_top = ORIGIN(BRAM) + LENGTH(BRAM));
MEMORY
{
    DDR(rx):ORIGIN =0x80000000,LENGTH =4K
    BRAM(rwx):ORIGIN =0x8C000000,LENGTH =4K
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
    }> BRAM
}