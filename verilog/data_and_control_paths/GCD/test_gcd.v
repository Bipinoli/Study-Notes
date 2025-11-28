module testbench;
  reg [15:0] data_in;
  reg clock, start;
  wire sel_in, finish, load_a, load_b, sel_a_in_x, sel_a_in_y, less_than, equal, greater_than;


  gcd_data data_path(
    .clock(clock),
    .data_in(data_in),
    .sel_in(sel_in),
    .load_a(load_a),
    .load_b(load_b),
    .sel_a_in_x(sel_a_in_x),
    .sel_a_in_y(sel_a_in_y),
    .less_than(less_than),
    .equal(equal),
    .greater_than(greater_than)
  );
  gcd_control control_path(
    .clock(clock),
    .finish(finish),
    .start(start),
    .sel_in(sel_in),
    .load_a(load_a),
    .load_b(load_b),
    .sel_a_in_x(sel_a_in_x),
    .sel_a_in_y(sel_a_in_y),
    .less_than(less_than),
    .equal(equal),
    .greater_than(greater_than)
  );

  always #5 clock = ~clock;

  initial 
  begin
    clock = 0;
    #2 start = 1;
    #1000 $finish;
  end

  initial 
  begin
    #12 data_in = 78;
    #10 data_in = 143;
  end

  initial
  begin
    $dumpfile("gcd_test.vcd");
    $dumpvars(0, testbench);
    $monitor("time: %4t, state: %b, A: %d, B: %d, GCD: %d, finish: %b", $time, control_path.cur_state, data_path.a_out, data_path.b_out, data_path.a_out, finish);
  end

endmodule
