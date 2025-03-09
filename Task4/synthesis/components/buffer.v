module buffer_OP (
    input clk,
    input reset,
    input [10:0] mult_count,
    input [18:0] prod1,
    input [18:0] prod2,
    input [18:0] prod3,
    input [18:0] prod4,
    output reg [18:0] out,
    output reg Load_Creg // Signal to activate Load for Creg
);

    reg [2:0] counter; // 3-bit counter (0 to 7)
    reg [18:0] buffer_reg2, buffer_reg3, buffer_reg4;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 0;
            buffer_reg2 <= 0;
            buffer_reg3 <= 0;
            buffer_reg4 <= 0;
            out <= 0;
            Load_Creg <= 0;
        end else begin
            if (mult_count > 8) begin
                counter <= (counter == 7) ? 0 : counter + 1; // Reset counter every 8 cycles

                case (counter)
                    0: begin
                        Load_Creg <= 1;
                        out <= prod1;
                        buffer_reg2 <= prod2;
                        buffer_reg3 <= prod3;
                        buffer_reg4 <= prod4;
                    end
                    3: begin
                        Load_Creg <= 1;
                        out <= buffer_reg4;
                    end
                    2: begin
                        Load_Creg <= 1;
                        out <= buffer_reg3;
                    end
                    1: begin
                        Load_Creg <= 1;
                        out <= buffer_reg2;
                    end
                    default: begin
                        Load_Creg <= 0;
                    end
                endcase
            end
        end
    end
endmodule