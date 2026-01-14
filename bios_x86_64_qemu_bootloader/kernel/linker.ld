OUTPUT_FORMAT(binary)
ENTRY(kernel_main)

SECTIONS
{
    /* Stage2 starts at 0x8000, typically ~16KB with page tables */
    /* So kernel starts around 0xC000 */
    . = 0xC000;
    
    .text : {
        *(.text)
    }
    
    .rodata : {
        *(.rodata)
    }
    
    .data : {
        *(.data)
    }
    
    .bss : {
        *(.bss)
    }
}
