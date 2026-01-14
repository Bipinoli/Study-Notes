void kernel_main() {
    volatile char* vga = (volatile char*)0xB8000;
    const char* msg = "Hello, world!";

    for (int i = 0; msg[i]; i++) {
        vga[i * 2] = msg[i];
        vga[i * 2 + 1] = 0x07;
    }

    while (1) {}
}
