module testbench;
    reg clock;
    reg signed [15:0] inputSignal;
    wire signed [15:0] outputSignal;

    // simple moving average filter (boxcar filter)
    // samples = 5
    // ci = 1 / 5 = 0.2 -> 2 (fixed point number which should be understood in 1/10)
    wire signed [15:0] c1 = 2;
    wire signed [15:0] c2 = 2;
    wire signed [15:0] c3 = 2;
    wire signed [15:0] c4 = 2;
    wire signed [15:0] c5 = 2;

    firFilter fir(clock, inputSignal, c1, c2, c3, c4, c5, outputSignal);

    always begin
        #10 clock = ~clock;
    end

    // input signal: simple triangle wave in [-10, 10]
    initial begin
        clock = 1;
        inputSignal = 0;
        #20 inputSignal = 5;
        #20 inputSignal = 10;
        #20 inputSignal = 5;
        #20 inputSignal = 0;
        #20 inputSignal = -5;
        #20 inputSignal = -10;
        #20 inputSignal = -5;
        #20 inputSignal = 0;
        #20 inputSignal = 5;
        #20 inputSignal = 10;
        #20 inputSignal = 5;
        #20 inputSignal = 0;
        #20 inputSignal = -5;
        #20 inputSignal = -10;
        #20 inputSignal = -5;
        #20 inputSignal = 0;
        #20 inputSignal = 5;
        #20 $finish;
    end

    initial begin
        $monitor("inputSignal: %d, outputSignal: %d", inputSignal, outputSignal);
    end
endmodule;