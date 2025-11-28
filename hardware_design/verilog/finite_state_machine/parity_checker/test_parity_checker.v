module parity_testbench;
  reg x, clock;
  wire even_odd;
  parity_checker pc (x, clock, even_odd);

  always #5 clock = ~clock;

  initial 
  begin 
    clock = 0;
    x = 0;
    #10;
    x = 1;
    #10;
    x = 1;
    #10;
    x = 0;
    #10;
    x = 1;
    #10;
    x = 1;
    #200 $finish;
  end

  initial
  begin
    $monitor("time: %3t, clock: %b, x: %b, even_odd: %b", $time, clock, x, even_odd);
  end
endmodule
