module adder_testbench;
  parameter N = 4;
  reg [N-1: 0] num1;
  reg [N-1: 0] num2;
  wire [N-1: 0] sum;
  wire carry_flag, zero_flag, overflow_flag, parity_flag, sign_flag;
  
  fulladder #(N) DUT (
    .num1(num1),
    .num2(num2),
    .sum(sum),
    .carry_flag(carry_flag),
    .zero_flag(zero_flag),
    .overflow_flag(overflow_flag),
    .parity_flag(parity_flag),
    .sign_flag(sign_flag)
  );

  initial
  begin
    $monitor("time: %d, num1: %b, num2: %b, sum: %b, carry: %b, zero: %b, overflow: %b, parity: %b, sign: %b", $time, num1, num2, sum, carry_flag, zero_flag, overflow_flag, parity_flag, sign_flag);

    // sign
    num1 = 4'b0101;
    num2 = 4'b1010;
    #10;

    // sign, carry
    num1 = 4'b1111;
    num2 = 4'b1111;
    #10;

    // sign, overflow
    // 4 signed bits can represent numbers from -8 to +7
    // so 5 + 5 = 10 will overflow
    num1 = 4'b0101; // 0101 -> 5
    num2 = 4'b0101;
    #10;

    // zero 
    // -2 + 2 = 0
    num2 = 4'b1110; // 2's complement of 2
    num1 = 4'b0010;
    #10;


    $finish;
  end

endmodule
