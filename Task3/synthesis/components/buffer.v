module buffer (
    input clk, Load, reset,
    input [10:0] clock_count,
    input signed [18:0] prod1, // from MacA
    input signed [18:0] prod2, // from MacB
    output reg signed [18:0] out,
    output reg writeToReg
);
    reg odd;
    reg [7:0] counter;
    reg [18:0] out_c_1;
    reg [18:0] out_c_2;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            odd <= 0;
            out <= 0;
            out_c_1 <= 0;
            out_c_2 <= 0;
            writeToReg <= 0;
            counter <= 0;
        end else if (Load) begin
            out_c_1 <= prod1;
            out_c_2 <= prod2;
        end
    end

    always @(posedge clk or posedge reset)begin

        if (clock_count % 4 == 0) begin
            if (odd == 1) begin
                writeToReg = 1;
                out = out_c_2;
                odd = 0;
            end else begin
                writeToReg = 1;
                out = out_c_1;
                odd = 1;
            end 
        end else begin
            writeToReg <= 0;
        end

    end

endmodule
