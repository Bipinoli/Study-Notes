module testbench;
    reg clock;
    reg reset;
    reg enable;
    reg push;
    reg pop;
    reg [7:0] datain;
    wire [7:0] dataout;

    ringBuffer buffer(clock, reset, enable, push, pop, datain, dataout);

    // clock time period: 20 time units
    always begin
        #10 clock = ~clock;
    end

    initial begin
        clock = 1;
        reset = 1;
        push = 0;
        pop = 0;
        enable = 0;
        datain = 0;

        // Set up VCD file to view waveform in GTKWave
        $dumpfile("waveform.vcd"); // Specify the name of the VCD file
        $dumpvars(0, testbench);    // Dump all variables in the testbench

        // 1 cycle to properly reset first
        #20; 
        reset = 0;
        enable = 1;

        // push 10, 20, 30
        #20;
        push = 1;
        datain = 10;

        #20;
        datain = 20;

        #20;
        datain = 30;

        // pop 2 times
        #20;
        push = 0;
        pop = 1;    
        datain = 0;
        #20;

        // push 40 50
        #20;
        push = 1;
        pop = 0;
        datain = 40;

        #20;
        datain = 50;

        // pop 3 times
        #20
        pop = 1;
        push = 0;

        #20
        pop = 1;
        push = 0;

        #40;

        pop = 0;
        push = 0;

        // push 10 numbers
        #20;
        push = 1;
        pop = 0;
        datain = 1;

        #20; datain = 2;
        #20; datain = 3;
        #20; datain = 4;
        #20; datain = 5;
        #20; datain = 6;
        #20; datain = 7;
        #20; datain = 8;
        #20; datain = 9;
        #20; datain = 10;

        // pop 10 times
        #20;
        push = 0;
        pop = 1;
        datain = 0;
        #180;

        push = 0;
        pop = 0;

        #20;
        $finish;
    end

    initial begin
        $monitor("time: %t, reset: %b, enable: %b, push: %b, pop: %b datain: %d, dataout: %d", $time, reset, enable, push, pop, datain, dataout);
    end

endmodule
