module simpleLatch (
    input wire clock,
    input wire reset,
    input wire enable,
    input wire a,
    output reg b
);
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            b <= 0;
        end else if (enable) begin 
            b <= a;
        end
    end

endmodule