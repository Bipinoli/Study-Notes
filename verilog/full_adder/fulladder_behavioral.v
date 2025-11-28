module fulladder #(parameter N = 4) (
  input [N-1:0] num1,
  input [N-1:0] num2,
  output [N-1:0] sum,
  output carry_flag,
  output overflow_flag,
  output parity_flag,
  output zero_flag,
  output sign_flag
);

assign {carry_flag, sum} = num1 + num2;
assign sign_flag = sum[N-1];
assign parity_flag = ~^sum;
assign zero_flag = ~|sum;
assign overflow_flag = (num1[N-1] & num2[N-1] & ~sum[N-1]) | (~num1[N-1] & ~num2[N-1] & sum[N-1]); 

endmodule
