// traffic light sequence is a Moore machine as the next state only depends on
// the current state and not the input
module traffic_light(clock, light);
  input clock;
  output reg[2:0] light;

  parameter red=3'b100, green=3'b010, yellow=3'b001;

  always @(posedge clock)
  case (light)
    red: light <= green;
    green: light <= yellow;
    yellow: light <= red;
    default: 
    begin
      $display("default state");
      light <= red;
    end
  endcase

endmodule

