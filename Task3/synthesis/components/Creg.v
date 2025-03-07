module Creg (
    input clk, Load, reset,
    output reg [7:0] addr // address to be accessed
);

    reg [7:0] counter;
    reg [7:0] rows;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            addr <= 0;
            counter <= 0;
            rows <= 0;
        end else if (Load) begin
            if (counter == 7) begin  // Instead of modulus
                counter <= 0;
                rows <= rows + 1;
                addr <= rows + 1; // Update addr correctly
            end else begin
                counter <= counter + 1;
                addr <= addr + 8;
            end
        end
    end

endmodule
