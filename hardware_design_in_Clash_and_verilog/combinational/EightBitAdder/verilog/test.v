module testbench;
  reg [7:0] A;
  reg [7:0] B;
  reg carry_in;
  wire [7:0] Y;
  wire carry_out;

  Adder adder(.A (A), .B (B), .Y (Y), .carry_in (carry_in), .carry_out (carry_out));

initial
begin
  $dumpfile("testrun.vcd");
  $dumpvars(0, testbench);

  // Test case 1: 94 + 44 = 138
  A = 8'b01011110;  // Decimal 94
  B = 8'b00101100;  // Decimal 44
  carry_in = 0;
  #5;  // Wait for 5 time units
  $display("%d + %d = %d, carry = %b", A, B, Y, carry_out);

  // Test case 2:
  A = 8'b11101010; // 234
  B = 8'b11010100; // 212
  carry_in = 1;
  #5;
  $display("In decimal: %d + %d + 1 = %d, carry = %b", A, B, Y, carry_out);
  $display("In binary: %b + %b + 1 = %b, carry = %b", A, B, Y, carry_out);

end

endmodule
