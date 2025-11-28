// following the example from: https://youtu.be/9uw25PU5B3k?list=PLJ5C_6qdAvBELELTSPgzYkQg3HgclQh-5&t=1731

module example (A, B, C, D, E, F, Y);
  input A, B, C, D, E, F;
  output Y;
  wire t1, t2, t3, Y;

  nand #1 G1 (t1, A, B);
  nand #2 G2 (t2, C, ~B, D);
  nor #1 G3 (t3, E, F);
  nand #1 G4 (Y, t1, t2, t3);
endmodule
