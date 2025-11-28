module testbench;
    reg enable;
    reg [7:0] channels;
    wire [2:0] selected;

    priorityEncoder encoder(enable, channels, selected);

    initial begin
        enable = 0;
        channels = 8'b10111010;

        #10;
        enable = 1;
        channels = 8'b11111010;

        #10;
        enable = 1;

        #10;
        channels = 8'b01111010;

        #10;
        channels = 8'b00011100;

        #10;
        channels = 8'b00000000;
    end

    initial begin
        $monitor("time: %t, enable: %b, channels: %b, selected %d", $time, enable, channels, selected);
    end

endmodule