// the following behaviorial code will be converted to the Demux
module generate_demux (out, in, select);
  input in;
  input [3:0] sel;
  output [15:0] out;

  assign out[sel] = in;
endmodule
