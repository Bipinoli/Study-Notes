BITS 16
ORG 0x8000

start:
    cli
    lgdt [gdt_descriptor]
    
    mov eax, cr0
    or eax, 1
    mov cr0, eax
    
    jmp CODE_SEG:init_pm

BITS 32
init_pm:
    mov ax, DATA_SEG
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov esp, 0x90000
    
    ; Enable PAE
    mov eax, cr4
    or eax, 1 << 5
    mov cr4, eax
    
    ; Load PML4
    mov eax, pml4_table
    mov cr3, eax
    
    ; Enable long mode
    mov ecx, 0xC0000080
    rdmsr
    or eax, 1 << 8
    wrmsr
    
    ; Enable paging
    mov eax, cr0
    or eax, 1 << 31
    mov cr0, eax
    
    jmp CODE64_SEG:kernel_entry

BITS 64
kernel_entry:
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    
    ; Jump to kernel which is loaded right after stage2
    ; Calculate: 0x8000 (stage2 start) + stage2 size
    mov rax, stage2_end
    call rax
    
.hang:
    hlt
    jmp .hang

align 8
gdt_start:
    dq 0x0000000000000000
    dq 0x00CF9A000000FFFF
    dq 0x00CF92000000FFFF
    dq 0x00AF9A000000FFFF
gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dq gdt_start

CODE_SEG    equ 0x08
DATA_SEG    equ 0x10
CODE64_SEG  equ 0x18

align 4096
pml4_table:
    dq pdpt_table + 3
    times 511 dq 0

align 4096
pdpt_table:
    dq pd_table + 3
    times 511 dq 0

align 4096
pd_table:
    ; Identity map first 2MB
    dq 0x0000000000000083
    times 511 dq 0

stage2_end:
; Kernel code will be placed right here when loaded into memory
