module traffic_testbench;
  reg clock;
  wire [2:0] light;

  traffic_light tf(clock, light);

  always #5 clock = ~clock;

  initial 
  begin
    clock = 0;
    #100 $finish;
  end
  
  initial
  begin
    $monitor("time: %2t, clock: %b, light (RGY): %b", $time, clock, light);
  end
endmodule
