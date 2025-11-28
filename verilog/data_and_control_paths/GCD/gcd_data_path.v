// check the design in 'design/' folder
module gcd_data (clock, data_in, sel_in, load_a, load_b, sel_a_in_x, sel_a_in_y, less_than, equal, greater_than);
  input clock, sel_in, load_a, load_b, sel_a_in_x, sel_a_in_y;
  input [15:0] data_in;
  output less_than, equal, greater_than;

  wire [15:0] bus, a_out, b_out, x, y, sub_result;

  mux load_input(data_in, sub_result, sel_in, bus);

  data_loader A(.clock(clock), .data_in(bus), .load(load_a), .data_out(a_out));
  data_loader B(.clock(clock), .data_in(bus), .load(load_b), .data_out(b_out));

  mux X(a_out, b_out, sel_a_in_x, x);
  mux Y(a_out, b_out, sel_a_in_y, y);

  comparator compare(a_out, b_out, less_than, equal, greater_than);

  subtractor subtract(x, y, sub_result);
endmodule

module data_loader(clock, data_in, load, data_out);
  input clock, load;
  input [15:0] data_in;
  output reg [15:0] data_out;

  always @(posedge clock)
  begin
    if (load) data_out = data_in;
  end
endmodule

module mux(option_a, option_b, select, out);
  input select;
  input [15:0] option_a, option_b;
  output [15:0] out;
  
  assign out = select ? option_a : option_b;
endmodule

module comparator(a, b, less_than, equal, greater_than);
  input [15:0] a, b;
  input less_than, equal, greater_than;

  assign less_than = a < b;
  assign equal = a == b;
  assign greater_than = a > b;
endmodule

module subtractor(x, y, sub_result);
  input [15:0] x, y;
  output [15:0] sub_result;
  assign sub_result = x - y;
endmodule
