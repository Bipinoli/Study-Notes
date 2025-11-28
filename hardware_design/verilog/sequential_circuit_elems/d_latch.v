// the following behavioral code will be converted to the D-Latch
module generate_d_latch(enable, data, out);
  input enable, data;
  output out;

  assign out = enable ? data : out;
endmodule
