module RAMOUTPUT (
    input clk, mwr,
    input [7:0]addr,
    input [18:0] mdi,
    output reg [18:0] mdo
);

    reg signed [18:0] mem [63:0];


    always @ (posedge clk) begin
    if (mwr) mem[addr] <= mdi;
    mdo <= mem[addr];

end

endmodule