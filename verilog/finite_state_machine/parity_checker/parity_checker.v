module parity_checker (x, clock, even_odd);
  input x, clock;
  output reg even_odd;

  parameter even=0, odd=1; 

  always @(posedge clock)
    case (even_odd)
      even: even_odd <= x ? odd: even;
      odd: even_odd <= x ? even: odd;
      default: even_odd <= even;
    endcase
endmodule
