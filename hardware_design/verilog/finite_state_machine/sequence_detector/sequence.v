// it is a Mealy machine as the output depends on the present state as well as
// the input
//
//
// Machine detects 0110 pattern in the input bit stream

module sequence (x, clock, found);
  input x, clock;
  output reg found;

  parameter start_state=3'b000, first_zero_found=3'b001, first_one_found=3'b010;
  parameter second_one_found=3'b011, complete_pattern_found=3'b111;

  reg [2:0] cur_state;

  always @(posedge clock)
    case (cur_state)
      start_state: begin 
        cur_state <= x ? start_state: first_zero_found;
        found <= 0;
      end
      first_zero_found: begin 
        cur_state <= x ? first_one_found: first_zero_found;
        found <= 0;
      end
      first_one_found: begin 
        cur_state <= x ? second_one_found: first_zero_found;
        found <= 0;
      end
      second_one_found: begin 
        cur_state <= x ? start_state: complete_pattern_found;
        found <= 1;
      end
      default: begin
        found <= 0;
        cur_state <= start_state;
      end
    endcase
endmodule
