module Creg_OP (
    input clk,
    input reset,
    input Load,
    output reg [7:0] addr
);

    reg [3:0] row, col;
    reg [1:0] index;  // Keeps track of which of the 4 addresses in the 2×2 block to output

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            row <= 0;
            col <= 0;
            index <= 0;
        end else if (Load) begin
            if (index < 3) begin
                index <= index + 1;  // Cycle through 4 addresses in the block
            end else begin
                index <= 0;
                if (row < 6) begin
                    row <= row + 2;  // Move to the next two rows
                end else begin
                    row <= 0;
                    col <= col + 2;  // After finishing rows, move to next column pair
                end
            end
        end
    end

    always @(*) begin
        case (index)
            2'b00: addr = row * 8 + col;        // (row, col)
            2'b10: addr = row * 8 + col + 1;    // (row, col+1)
            2'b01: addr = (row+1) * 8 + col;    // (row+1, col)
            2'b11: addr = (row+1) * 8 + col + 1;// (row+1, col+1)
        endcase
    end

endmodule