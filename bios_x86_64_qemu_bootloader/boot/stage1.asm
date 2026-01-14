; ; BIOS works by loading the first sector form the disk i.e MBR
; ; MBR sector must take 512 bytes and the last two bytes must be 0x55 and 0xAA
; ; BIOS places the loaded MBR bytes into address 0x7c00
; ; During this time the CPU runs in 16 bits real mode
;
; BITS 16 
; ORG 0x7c00 ; telling assembler that this code will be placed exactly at this address
;
; start:
;   ; first we initialize the segment registers
;   ; Interrupt handlers can't work before so we enable interrupts only after setting the registers
;   ; The segment registers are special regs. We can't set them with immediate value so moving from ax
;   cli ; clear interrupts
;   xor ax, ax
;   mov ds, ax
;   mov es, ax
;   mov ss, ax
;   mov sp, 0x7c00 ; start address of stack. Grows down from the location
;   sti ; enable interrupts
;
;   ; load stage 2 bootloader (sector 2 - 10 of disk i.e 9 sectors each of 512 bytes)
;   ; using the disk read service provided by BIOS
;   ; see Ralf Brown's Interrupt list for detail (https://www.ctyme.com/intr/rb-0607.htm)
;   mov ah, 0x02 ; disk function: read sector
;   mov al, 9 ; how many sectors to read
;   mov ch, 0 ; cylinder
;   mov dh, 0 ; head
;   mov cl, 2 ; sector
;   mov bx, 0x8000 ; load destination. Any other address can be chosen that is within 1MB and doesn't override other memory
;   int 0x13 ; BIOS disk IO interrupt
;
;   ; far jump to stage2
;   ; far jump is the only way of setting code segment (cs)
;   ; jmp segment:offset sets cs to segment
;   ; with segmentation, address = cs * 16 + offset
;   ; cs might have other values so without this the jump can take place to a wrong address
;   jmp 0x0000:0x8000
;
;
; mbr_error:
;   jmp mbr_error
;
; ; pad remaning bytes to zero
; ; $ = current location in bytes
; ; $$ = start of this section i.e (.text, .data, etc)
; times 510 - ($ - $$) db 0
; dw 0xAA55 ; MBR must end with 0x55 0xAA. Little endian


BITS 16 
ORG 0x7c00

start:
  cli
  xor ax, ax
  mov ds, ax
  mov es, ax
  mov ss, ax
  mov sp, 0x7c00
  sti
  
  mov [boot_drive], dl
  
  ; Check if extended read is available
  mov ah, 0x41
  mov bx, 0x55AA
  mov dl, [boot_drive]
  int 0x13
  jc .use_chs         ; Extended read not available, fall back to CHS
  
  ; Use LBA extended read (much simpler!)
  mov si, dap
  mov ah, 0x42
  mov dl, [boot_drive]
  int 0x13
  jc disk_error
  jmp 0x0000:0x8000

.use_chs:
  ; Fallback to CHS (for very old systems)
  ; Read 17 sectors at a time
  mov ah, 0x02
  mov al, 17
  mov ch, 0
  mov dh, 0
  mov cl, 2
  mov dl, [boot_drive]
  mov bx, 0x8000
  int 0x13
  jc disk_error
  
  ; Read remaining 17 sectors
  mov ah, 0x02
  mov al, 17
  mov ch, 0
  mov dh, 1         ; Head 1 (next track)
  mov cl, 1
  mov dl, [boot_drive]
  mov bx, 0xA200
  int 0x13
  jc disk_error
  
  jmp 0x0000:0x8000

disk_error:
  mov si, error_msg
  call print_string
  mov al, ah
  call print_hex
.hang:
  cli
  hlt
  jmp .hang

print_string:
  pusha
  mov ah, 0x0e
.loop:
  lodsb
  or al, al
  jz .done
  int 0x10
  jmp .loop
.done:
  popa
  ret

print_hex:
  pusha
  mov cx, 2
.loop:
  rol al, 4
  push ax
  and al, 0x0f
  add al, '0'
  cmp al, '9'
  jle .print
  add al, 7
.print:
  mov ah, 0x0e
  int 0x10
  pop ax
  loop .loop
  popa
  ret

boot_drive: db 0
error_msg: db 'Error: ', 0

; Disk Address Packet for LBA reading
align 4
dap:
    db 0x10           ; Size of DAP (16 bytes)
    db 0              ; Unused
    dw 34             ; Number of sectors to read
    dw 0x8000         ; Offset
    dw 0x0000         ; Segment
    dq 1              ; LBA start sector (sector 1, because LBA counts from 0)

times 510 - ($ - $$) db 0
dw 0xAA55
