// sample window: 5
// sample inputs: x1, x2, x3, x4, x5 where x1 is the most recent sample
// coefficients: signed 16 bit ints
module convolveWindow (
    input wire signed [15:0] x1,
    input wire signed [15:0] x2,
    input wire signed [15:0] x3,
    input wire signed [15:0] x4,
    input wire signed [15:0] x5,
    input wire signed [15:0] c1,
    input wire signed [15:0] c2,
    input wire signed [15:0] c3,
    input wire signed [15:0] c4,
    input wire signed [15:0] c5,
    output wire signed [15:0] y
);
    assign y = c1 * x1 + c2 * x2 + c3 * x3 + c4 * x4 + c5 * x5;
endmodule


module firFilter (
    input wire clock,
    input wire signed [15:0] inputSignal,
    input wire signed [15:0] c1,
    input wire signed [15:0] c2,
    input wire signed [15:0] c3,
    input wire signed [15:0] c4,
    input wire signed [15:0] c5,
    output reg signed [15:0] outputSignal
);
    reg signed [15:0] x1;
    reg signed [15:0] x2;
    reg signed [15:0] x3;
    reg signed [15:0] x4;
    reg signed [15:0] x5;

    wire signed [15:0] y;

    convolveWindow convolve (x1, x2, x3, x4, x5, c1, c2, c3, c4, c5, y);

    always @(posedge clock) begin
        x5 <= x4;
        x4 <= x3;
        x3 <= x2;
        x2 <= x1;
        x1 <= inputSignal;
        outputSignal <= y;
    end
endmodule