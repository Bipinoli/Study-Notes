/* 
* Design in structural domain
* ----------------------------
*
*  Truth table (full adder)
*  -----------
*   A  B  C  Y  C1
*   0  0  0  0  0
*   0  0  1  1  0
*   0  1  0  1  0
*   0  1  1  0  1
*   1  0  0  1  0
*   1  0  1  0  1
*   1  1  0  0  1
*   1  1  1  1  1
*/
module FAdder (
  input A,
  input B,
  input C,
  output Y,
  output C1
);
  assign C1 = (A & B) | (B & C) | (C & A);
  assign Y = (A | B | C) & (A ^ B ^ C);
endmodule


// Ripple carry adder
module Adder (
  input [7:0] A,
  input [7:0] B,
  input carry_in,
  output [7:0] Y,
  output carry_out
);
  wire [7:0] carry;

  FAdder add0 (A[0], B[0], carry_in, Y[0], carry[0]);
  FAdder add1 (A[1], B[1], carry[0], Y[1], carry[1]);
  FAdder add2 (A[2], B[2], carry[1], Y[2], carry[2]);
  FAdder add3 (A[3], B[3], carry[2], Y[3], carry[3]);
  FAdder add4 (A[4], B[4], carry[3], Y[4], carry[4]);
  FAdder add5 (A[5], B[5], carry[4], Y[5], carry[5]);
  FAdder add6 (A[6], B[6], carry[5], Y[6], carry[6]);
  FAdder add7 (A[7], B[7], carry[6], Y[7], carry[7]);

  assign carry_out = carry[7];
endmodule

