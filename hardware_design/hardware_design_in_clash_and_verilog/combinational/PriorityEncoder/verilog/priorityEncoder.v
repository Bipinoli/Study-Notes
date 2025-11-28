module priorityEncoder (
    input wire enable,
    input wire [7:0] channels,
    output wire [2:0] selected
);
    // highest bit has the highest priority
    assign selected = enable ? (
        channels[7] ? 3'd7 :
        channels[6] ? 3'd6 :
        channels[5] ? 3'd5 :
        channels[4] ? 3'd4 :
        channels[3] ? 3'd3 :
        channels[2] ? 3'd2 :
        channels[1] ? 3'd1 :
        channels[0] ? 3'd0 :
        3'bzzz
    ) : 3'bzzz;

endmodule