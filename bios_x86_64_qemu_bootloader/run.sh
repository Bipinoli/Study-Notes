#!/bin/bash
mkdir -p build

nasm -f bin boot/stage1.asm -o build/stage1.bin
nasm -f bin boot/stage2.asm -o build/stage2.bin

STAGE2_SIZE=$(stat -c%s build/stage2.bin 2>/dev/null || stat -f%z build/stage2.bin)
echo "Stage2 size: $STAGE2_SIZE bytes"

KERNEL_ADDR=$((0x8000 + ((STAGE2_SIZE + 4095) / 4096) * 4096))
echo "Kernel will load at: 0x$(printf '%X' $KERNEL_ADDR)"

gcc -ffreestanding -m64 -mno-red-zone -c kernel/kernel.c -o build/kernel.o

cat >build/temp_linker.ld <<EOF
OUTPUT_FORMAT(binary)
ENTRY(kernel_main)
SECTIONS
{
    . = 0x$(printf '%X' $KERNEL_ADDR);
    .text : { *(.text) }
    .rodata : { *(.rodata) }
    .data : { *(.data) }
    .bss : { *(.bss) }
}
EOF

ld -T build/temp_linker.ld -o build/kernel.bin build/kernel.o

truncate -s 512 build/stage1.bin

cat build/stage1.bin build/stage2.bin build/kernel.bin >build/os.img

# Pad to ensure proper disk size
truncate -s 1M build/os.img

TOTAL_SIZE=$(stat -c%s build/os.img 2>/dev/null || stat -f%z build/os.img)
SECTORS_NEEDED=$(((TOTAL_SIZE + 511) / 512))
echo "Total sectors: $SECTORS_NEEDED"

qemu-system-x86_64 -drive format=raw,file=build/os.img
