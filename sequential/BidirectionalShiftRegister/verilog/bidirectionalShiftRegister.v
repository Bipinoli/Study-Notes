module bidirectionalShiftRegister (
    input wire clock,
    input wire reset,
    input wire enable,
    input wire load,
    input wire shiftLeft,
    input wire [7:0] datain,
    output reg [7:0] dataout
);
    always @ (posedge clock or posedge reset) begin
        if (reset) begin
            dataout <= 8'b00000000;
        end else if (enable) begin
            if (load) begin
                dataout <= datain;
            end else if (shiftLeft) begin
                dataout <= dataout << 1;
            end else begin
                dataout <= dataout >> 1;
            end
        end
    end

endmodule