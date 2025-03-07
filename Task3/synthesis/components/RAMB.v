module RAMB (
    input clk,              // Clock signal
    input we,               // Write enable (0 = nothing, 1 = Read)
    input [7:0] addr,       // 6-bit address (0 to 63 for 64 locations)
    input signed [7:0] data_in,    // 8-bit input data (for writing)
    output reg signed [7:0] data_out // 8-bit output data (for reading)
);

    // (* ram_init_file = "initFile/initfile.mif" *) 
    reg [7:0] memory [63:0];

    initial begin
        $readmemb("../modelsimfiles/ram_b_init.txt", memory);
    end

    always @(posedge clk) begin
        if (we) 
        //     memory[addr] <= data_in;  // Write operation
            data_out <= memory[addr];     // Read operation

    end

endmodule

