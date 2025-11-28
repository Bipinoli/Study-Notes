// check the design in the 'design/' folder
module gcd_control (clock, start, less_than, equal, greater_than, sel_in, load_a, load_b, sel_a_in_x, sel_a_in_y, finish);
  input clock, start, less_than, equal, greater_than;
  output reg sel_in, load_a, load_b, sel_a_in_x, sel_a_in_y, finish;

  parameter state_start=3'b000, state_read_a=3'b001, state_read_b=3'b010, state_a_lt_b=3'b011, state_a_gt_b=3'b100, state_finish=3'b111;
  reg [2:0] cur_state;

  // need to give the load signals sime time to propagate before doing state
  // transition
  always @(posedge clock)
    case (cur_state)
      state_start: if (start) cur_state <= state_read_a;
      state_read_a: begin #1; cur_state <= state_read_b; end
      state_read_b: begin
        #1;
        if (equal) cur_state <= state_finish;
        if (less_than) cur_state <= state_a_lt_b;
        if (greater_than) cur_state <= state_a_gt_b;
      end
      state_a_lt_b: begin
        #1;
        if (equal) cur_state <= state_finish;
        if (less_than) cur_state <= state_a_lt_b;
        if (greater_than) cur_state <= state_a_gt_b;
      end
      state_a_gt_b: begin
        #1;
        if (equal) cur_state <= state_finish;
        if (less_than) cur_state <= state_a_lt_b;
        if (greater_than) cur_state <= state_a_gt_b;
      end
      state_finish: cur_state <= state_finish;
      default: cur_state <= state_start;
    endcase

  always @(cur_state)
    case (cur_state)
      state_start: begin 
        sel_in <= 1; 
        load_a <= 1;
        load_b <= 0;
        finish <= 0;
      end
      state_read_a: begin
        sel_in <= 1;
        load_a <= 0;
        load_b <= 1;
      end
      state_read_b: begin 
        load_b <= 0;
        if (less_than) begin 
          sel_in <= 0; sel_a_in_x <= 0; sel_a_in_y <= 1; 
          #1; load_b <= 1; load_a <= 0;
        end
        else if (greater_than) begin 
          sel_in <= 0; sel_a_in_x <= 1; sel_a_in_y <= 0; 
          #1; load_a <= 1; load_b <= 0;
        end
        else if (equal) finish <= 1;
      end
      state_a_lt_b: begin 
        if (less_than) begin 
          sel_in <= 0; sel_a_in_x <= 0; sel_a_in_y <= 1; 
          #1; load_b <= 1; load_a <= 0;
        end
        else if (greater_than) begin 
          sel_in <= 0; sel_a_in_x <= 1; sel_a_in_y <= 0; 
          #1; load_a <= 1; load_b <= 0;
        end
        else if (equal) finish <= 1;
      end
      state_a_gt_b: begin 
        if (less_than) begin 
          sel_in <= 0; sel_a_in_x <= 0; sel_a_in_y <= 1; 
          #1; load_b <= 1; load_a <= 0;
        end
        else if (greater_than) begin 
          sel_in <= 0; sel_a_in_x <= 1; sel_a_in_y <= 0; 
          #1; load_a <= 1; load_b <= 0;
        end
        else if (equal) finish <= 1;
      end
      state_finish: begin 
        finish <= 1; 
        load_a <= 0; load_b <= 0;
      end
      default: begin load_a <= 0; load_b <= 0; finish <= 0; end
    endcase
endmodule
