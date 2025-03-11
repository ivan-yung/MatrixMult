module RAMB_DP (
    input clk,              // Clock signal
    input we,               // Write enable (0 = nothing, 1 = Read)
    input [7:0] addr1, addr2,       // 6-bit address (0 to 63 for 64 locations)
    input signed [7:0] data_in,    // 8-bit input data (for writing)
    output reg signed [7:0] data_out_1, data_out_2 // 8-bit output data (for reading)
);

    reg signed [7:0] memory [63:0];

    initial begin
        $readmemb("../../modelsimfiles/part4test/ram_b_init.txt", memory);
    end

    always @(posedge clk) begin
        if (we) 
            // memory[addr] <= data_in;  // Write operation

        data_out_1 <= memory[addr1];
        data_out_2 <= memory[addr2];
    end

endmodule