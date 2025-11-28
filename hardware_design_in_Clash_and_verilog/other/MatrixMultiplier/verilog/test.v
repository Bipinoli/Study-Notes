module testbench;
    reg signed [15:0] A11;
    reg signed [15:0] A12;
    reg signed [15:0] A13;
    reg signed [15:0] A21;
    reg signed [15:0] A22;
    reg signed [15:0] A23;
    reg signed [15:0] A31;
    reg signed [15:0] A32;
    reg signed [15:0] A33;

    reg signed [15:0] B11;
    reg signed [15:0] B12;
    reg signed [15:0] B13;
    reg signed [15:0] B21;
    reg signed [15:0] B22;
    reg signed [15:0] B23;
    reg signed [15:0] B31;
    reg signed [15:0] B32;
    reg signed [15:0] B33;

    wire signed [15:0] Y11;
    wire signed [15:0] Y12;
    wire signed [15:0] Y13;
    wire signed [15:0] Y21;
    wire signed [15:0] Y22;
    wire signed [15:0] Y23;
    wire signed [15:0] Y31;
    wire signed [15:0] Y32;
    wire signed [15:0] Y33;


    matrixMultiplier3by3 mult(
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

    initial begin
        A11 = 1; A12 = 2; A13 = 3;
        A21 = 4; A22 = 5; A23 = 6;
        A31 = 7; A32 = 8; A33 = 9;

        B11 = 1; B12 = 2; B13 = 3;
        B21 = 4; B22 = 5; B23 = 6;
        B31 = 7; B32 = 8; B33 = 9;

        #10;
        A11 = -1; A12 = -2; A13 = -3;
        A21 = -4; A22 = -5; A23 = -6;
        A31 = -7; A32 = -8; A33 = -9;

        B11 = -1; B12 = -2; B13 = -3;
        B21 = -4; B22 = -5; B23 = -6;
        B31 = -7; B32 = -8; B33 = -9;

        #10;
        A11 = 1; A12 = -2; A13 = -3;
        A21 = -4; A22 = 5; A23 = -6;
        A31 = -7; A32 = -8; A33 = 9;

        B11 = 1; B12 = -2; B13 = -3;
        B21 = -4; B22 = 5; B23 = -6;
        B31 = -7; B32 = -8; B33 = 9;
    end

    initial begin
        $monitor("%d, %d, %d,\n%d, %d, %d,\n%d, %d, %d\n\n", Y11, Y12, Y13, Y21, Y22, Y23, Y31, Y32, Y33);
    end

endmodule