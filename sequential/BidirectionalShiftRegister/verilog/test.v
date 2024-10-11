module testbench;

    reg clock;
    reg reset;
    reg enable;
    reg load;
    reg shiftLeft;
    reg [7:0] datain;
    wire [7:0] dataout;

    bidirectionalShiftRegister bsr(clock, reset, enable, load, shiftLeft, datain, dataout);

    // clock time period = 20 time units
    always begin
    #10 clock = ~clock;
    end

    initial begin
        clock = 1;
        reset = 1;
        
        #20;
        reset = 0;
        enable = 1;

        #20;
        load = 1;
        datain = 8'b10110110;

        #20;
        load = 0;
        datain = 0;
        shiftLeft = 0;

        #80; // 4 cycles
        shiftLeft = 1;

        #100; // 5 cycles

        $finish;
    end

    initial begin
        $monitor("time: %t, reset: %b, enable: %b, load: %b, shift_left: %b, datain: %b, dataout: %b", $time, reset, enable, load, shiftLeft, datain, dataout);
    end

endmodule