module ringBuffer (
    input wire clock,
    input wire reset,
    input wire enable,
    input wire push,
    input wire pop,
    input wire [7:0] datain,
    output reg [7:0] dataout
);
    // Memory size = 8
    // 10 memory cells of 1 byte size
    reg [7:0] memory [9:0];

    // 4 bits to be alble to hold numbers upto 10
    reg [3:0] head;
    reg [3:0] tail;

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            head <= 3'b000;
            tail <= 3'b000;
        end else if (enable) begin 
            if (push) begin
                head <= (head + 1) % 10;
                memory[head] <= datain; // `<=` is non-blocking so old value of head
            end else if (pop) begin
                tail <= (tail + 1) % 10;
                dataout <= memory[tail];
            end
        end
    end

endmodule