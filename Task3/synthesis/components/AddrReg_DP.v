module AddrReg_DP ( 
    input clk, Load, reset,
    output reg [7:0] addrA, // Address to access A
    output reg [7:0] addrB1,  // Address to access B
    output reg [7:0] addrB2
);

    reg [3:0] i, j, k; // Loop indices (max 8)
    reg done;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            i      <= 0; // Row index of C
            j      <= 0; // Column index of C
            k      <= 0; // Dot product index
            addrA  <= 0;
            addrB1 <= 0;
            addrB2 <= 8;
            done   <= 0;
        end else if (Load && !done) begin
            addrA  <= k * 8 + i; // row-major access in A
            addrB1  <= j * 8 + k; // column-wise access in B
            addrB2 <= (j + 1) * 8 + k;

            if (k < 7) begin
                k <= k + 1; // Move to next multiplication in dot product
            end else begin
                k <= 0; // Reset dot product index
                if (j < 6) begin
                    j <= j + 2; // Move to next column of C
                end else begin
                    j <= 0; // Reset column index
                    if (i < 7) begin
                        i <= i + 1; // Move to next row of C
                    end else begin
                        done <= 1; // All calculations done
                    end
                end
            end
        end
    end

endmodule