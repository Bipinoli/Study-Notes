// traffic light is a Moore system as next state is a function of present state
module trafficLight (
    input wire clock,
    output reg[1:0] light
);
    parameter red = 2'b01, yellow = 2'b11, green = 2'b10;
    initial light = red;

    always @(posedge clock) begin
        case (light)
            red: light <= green;
            green: light <= yellow;
            yellow: light <= red;
        endcase
    end
endmodule