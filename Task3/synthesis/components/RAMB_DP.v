module RAMB_DP (
    input clk,                     // Clock signal
    input we,                      // Write enable (1 = Write, 0 = Read)
    input [7:0] addr1, addr2,     // Two separate 6-bit addresses (0 to 63)
    input signed [7:0] data_in,     // 8-bit input data (for writing)
    output reg signed [7:0] data_out_1, data_out_2 // Two 8-bit outputs for independent reads
);

    reg signed [7:0] memory [0:63];

    initial begin
        $readmemb("ram_b_init.txt", memory);
    end

    always @(posedge clk) begin
        if (we) 
            // memory[addr1] <= data_in;  // Write operation on port A
       
        // Independent Read Operations for both ports
        data_out_1 <= memory[addr1];
        data_out_2 <= memory[addr2];
    end

endmodule
