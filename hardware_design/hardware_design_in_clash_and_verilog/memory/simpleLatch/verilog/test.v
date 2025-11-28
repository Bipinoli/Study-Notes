module testbench;
    reg clock;
    reg reset;
    reg enable;
    reg a;
    wire b;

    simpleLatch latch(clock, reset, enable, a, b);

    // clock time period: 20 time units
    always begin
        #10 clock = ~clock;
    end

    initial begin
        clock = 1;
        reset = 1;
        enable = 0;
        a = 0;

        // Set up VCD file to view waveform in GTKWave
        $dumpfile("waveform.vcd"); // Specify the name of the VCD file
        $dumpvars(0, testbench);    // Dump all variables in the testbench

        // 1 cycle to properly reset first
        #20; 
        reset = 0;
        enable = 1;

        // a = [1,2,3,4,5,6]
        #20;
        a = 1;
        #20;
        a = 2;
        #20;
        a = 3;
        #20;
        a = 4;
        #20;
        a = 5;
        #20;
        a = 6;
        $finish;
    end

    initial begin
        $monitor("time: %t, reset: %b, enable: %b, a: %b, b: %b", $time, reset, enable, a, b);
    end
endmodule
