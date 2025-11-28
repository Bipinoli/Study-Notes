// combinational design of 3 by 3 matrix multiplier of 16 bit signed integers
module matrixMultiplier3by3 (
    A11, A12, A13,
    A21, A22, A23,
    A31, A32, A33,

    B11, B12, B13,
    B21, B22, B23,
    B31, B32, B33,

    Y11, Y12, Y13,
    Y21, Y22, Y23,
    Y31, Y32, Y33
);
    // input wire signed [15:0] A [0:2][0:2];
    // input wire signed [15:0] B [0:2][0:2];
    // output wire signed [15:0] Y [0:2][0:2];

    // sadly normal verilog doesn't support unpacked array
    input wire signed [15:0] A11;
    input wire signed [15:0] A12;
    input wire signed [15:0] A13;
    input wire signed [15:0] A21;
    input wire signed [15:0] A22;
    input wire signed [15:0] A23;
    input wire signed [15:0] A31;
    input wire signed [15:0] A32;
    input wire signed [15:0] A33;

    input wire signed [15:0] B11;
    input wire signed [15:0] B12;
    input wire signed [15:0] B13;
    input wire signed [15:0] B21;
    input wire signed [15:0] B22;
    input wire signed [15:0] B23;
    input wire signed [15:0] B31;
    input wire signed [15:0] B32;
    input wire signed [15:0] B33;

    output wire signed [15:0] Y11;
    output wire signed [15:0] Y12;
    output wire signed [15:0] Y13;
    output wire signed [15:0] Y21;
    output wire signed [15:0] Y22;
    output wire signed [15:0] Y23;
    output wire signed [15:0] Y31;
    output wire signed [15:0] Y32;
    output wire signed [15:0] Y33;

    // Yij = Sum (Aik * Bkj)
    assign Y11 = (A11 * B11) + (A12 * B21) + (A13 * B31);
    assign Y12 = (A11 * B12) + (A12 * B22) + (A13 * B32);
    assign Y13 = (A11 * B13) + (A12 * B23) + (A13 * B33);
    assign Y21 = (A21 * B11) + (A22 * B21) + (A23 * B31);
    assign Y22 = (A21 * B12) + (A22 * B22) + (A23 * B32);
    assign Y23 = (A21 * B13) + (A22 * B23) + (A23 * B33);
    assign Y31 = (A31 * B11) + (A32 * B21) + (A33 * B31);
    assign Y32 = (A31 * B12) + (A32 * B22) + (A33 * B32);
    assign Y33 = (A31 * B13) + (A32 * B23) + (A33 * B33);




    // wire signed [15:0] AT [0:2][0:2];
    // wire signed [15:0] BT [0:2][0:2];
    // wire signed [15:0] YT [0:2][0:2];

    // assign AT[0][0] = A11;
    // assign AT[0][1] = A12;
    // assign AT[0][2] = A13;
    // assign AT[1][0] = A21;
    // assign AT[1][1] = A22;
    // assign AT[1][2] = A23;
    // assign AT[2][0] = A31;
    // assign AT[2][1] = A32;
    // assign AT[2][2] = A33;

    // assign BT[0][0] = B11;
    // assign BT[0][1] = B12;
    // assign BT[0][2] = B13;
    // assign BT[1][0] = B21;
    // assign BT[1][1] = B22;
    // assign BT[1][2] = B23;
    // assign BT[2][0] = B31;
    // assign BT[2][1] = B32;
    // assign BT[2][2] = B33;

    // integer i = 0;
    // integer j = 0;
    // integer k = 0;
    
    // always @(*) begin
    //     for (i=0; i<3; i=i+1) begin
    //         for (j=0; j<3; j=j+1) begin
    //             assign YT[i][j] = 0;
    //             for (k=0; k<3; k=k+1) begin
    //                 assign YT[i][j] = YT[i][j] + (A[i][k] * B[k][j]);
    //             end
    //         end
    //     end
    // end

    // assign Y11 = YT[0][0];
    // assign Y12 = YT[0][1];
    // assign Y13 = YT[0][2];
    // assign Y21 = YT[1][0];
    // assign Y22 = YT[1][1];
    // assign Y23 = YT[1][2];
    // assign Y31 = YT[2][0];
    // assign Y32 = YT[2][1];
    // assign Y33 = YT[2][2];


endmodule
