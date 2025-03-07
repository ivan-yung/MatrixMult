module RAMA (
    input clk,              // Clock signal
    input we,               // Write enable (0 = nothing, 1 = Read)
    input [7:0] addr,       // 6-bit address (0 to 63 for 64 locations)
    input signed [7:0] data_in,    // 8-bit input data (for writing)
    output reg signed [7:0] data_out // 8-bit output data (for reading)
);

    // (* ram_init_file = "initFile/initfile.mif" *) 
    reg [7:0] memory [63:0];

    initial begin
        $readmemb("../modelsimfiles/ram_a_init.txt", memory);
    end

    always @(posedge clk) begin
        if (we) 
            // memory[addr] <= data_in;  // Write operation
            data_out <= memory[addr];     // Read operation
    end

endmodule



// module tb_ram;
//     reg clk;
//     reg we;
//     reg [5:0] addr;
//     reg [7:0] data_in;
//     wire [7:0] data_out;

//     // Instantiate RAM module
//     single_port_ram uut (
//         .clk(clk),
//         .we(we),
//         .addr(addr),
//         .data_in(data_in),
//         .data_out(data_out)
//     );

//     // Generate Clock Signal
//     always #5 clk = ~clk;

//     initial begin
//         clk = 0;
//         we = 1;    // Enable write mode

//         // Write values in column-major order
//         addr = 0; data_in = 8'hA1; #10;  // Write A[0,0]
//         addr = 1; data_in = 8'hB2; #10;  // Write A[1,0]
//         addr = 8; data_in = 8'hC3; #10;  // Write A[0,1]

//         we = 0;    // Switch to read mode

//         // Read values
//         addr = 0; #10;  // Read A[0,0] (Expect A1)
//         addr = 1; #10;  // Read A[1,0] (Expect B2)
//         addr = 8; #10;  // Read A[0,1] (Expect C3)

//         $stop;
//     end
// endmodule
