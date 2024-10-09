module Counter (
  input clock,
  input clear,
  output reg [3:0] count
);
  always @ (posedge clock)
    if (clear)
      count = 0;
    else
      count = count + 1;

endmodule
