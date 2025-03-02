// module Areg (
//     input clk, Load, reset,
//     output reg [7:0] addrA // address to be accessed A
//     output reg [7:0] addrB // address to be accessed B
// );
//     reg [7:0] counter, rows, RowsMult, colsMult, col;

//     always @(posedge clk or posedge reset) begin
//         if (reset) begin
//             counter <= 0;
//             rows <= 0;
//             RowsMult <= 0;
//             colsMult <= 0;
//             col <= 0;
//         end

//         if (Load) begin
//             if (RowsMult < 8) begin
//                 //multiply dot product 8 times R[i] * C[i++]
//                 if (colsMult < 8) begin
//                     // A addresses
//                     if (col == 7) begin  // Instead of modulus
//                         col <= 0;
//                         rows <= rows + 1;
//                         addrA <= rows + 1; // Update addr correctly
//                     end else begin
//                         col <= col + 1;
//                         addrA <= addr + 8;
//                     end
//                     // B addresses
//                     addrB <= addrB + 1; //Update addr B correctly
//                 end    
//                 colsMult <= colsMult + 1;
//             end
//             RowsMult <= RowsMult + 1;
//         end    

//     end    

// endmodule


module AddrReg ( 
    input clk, Load, reset,
    output reg [7:0] addrA, // Address to access A
    output reg [7:0] addrB  // Address to access B
);

    reg [3:0] i, j, k; // Loop indices (max 8)
    reg done;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            i      <= 0; // Row index of C
            j      <= 0; // Column index of C
            k      <= 0; // Dot product index
            addrA  <= 0;
            addrB  <= 0;
            done   <= 0;
        end else if (Load && !done) begin
            addrA  <= k * 8 + i; // Column-major access in A
            addrB  <= j * 8 + k; // Row-wise access in B due to column-major storage

            if (k < 7) begin
                k <= k + 1; // Move to next multiplication in dot product
            end else begin
                k <= 0; // Reset dot product index
                if (j < 7) begin
                    j <= j + 1; // Move to next column of C
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
