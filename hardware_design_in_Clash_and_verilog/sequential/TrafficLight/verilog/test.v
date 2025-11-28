module testbench;
    reg clock;
    wire[1:0] light;

    trafficLight tl(clock, light);

    // clock period = 20 units
    always begin
        #10 clock = ~clock;
    end

    initial begin
        clock = 0;
        #200;
        $finish;
    end

    initial begin
        $monitor("time: %t, light: %d", $time, light);
    end

endmodule