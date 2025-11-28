module testbench;
  
  reg clock;
  reg clear;

  wire [3:0] count;

  Counter DUT(.clock(clock), .clear(clear), .count(count));

  // clock time period: 20 units
  always begin
    #10 clock = ~clock;
  end

  initial begin
    clock = 0;
    clear = 1;

    // clear to start with 0
    #20; clear = 0; // 1 cycle time for clear signal

    // count until 10 then clear 
    #200; // 10 * 20 units

    clear = 1;
    #20; clear = 0; // 1 cycle time for clear signal

    // keep counting with overflow
    #400;

    $finish;
  end

  initial begin
    $monitor("Time: %t, clear: %b, count: %d", $time, clear, count);
  end

endmodule
