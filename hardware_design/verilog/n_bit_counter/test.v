module counter_testbench;

  parameter N = 7;

  reg clock;
  reg clear;

  wire [0:N] count;

  counter DUT(clear, clock, count);

  always begin
    #10 clock = ~clock; 
  end

  initial begin
    clock = 0;

    // clear firt
    clear = 1;
    #20;
    clear = 0;

    // count for some time
    #400;

    // clear again
    clear = 1;
    #20;
    clear = 0;

    // count more
    #200;

    $finish;
  end

  initial begin
    $monitor("Time: %t, clear: %b, count: %b", $time, clear, count);
  end


endmodule
