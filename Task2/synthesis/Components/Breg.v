module Breg (
    input clk, Load, reset,
    output reg [7:0] addr // address to be accessed
);


    //Access matrix B loading 1 value at a time by rows
    always @(posedge clk or posedge reset) begin
        if (reset)
            addr <= 0;
        if (Load)
            addr <= addr + 1;

    end

endmodule