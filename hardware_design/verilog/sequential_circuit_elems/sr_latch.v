// the following behavioral code will be converted to a SR-Latch
module generate_sr_latch(Q, Q_bar, S, R);
  input S, R;
  output Q, Q_bar;

  // translated from the NAND ciruit diagram
  assign Q = ~(R & Q_bar);
  assign Q_bar = ~(S & Q);
endmodule
