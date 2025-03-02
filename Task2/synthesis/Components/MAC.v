module MAC (
	input signed [7:0] A,
	input signed [7:0] B,
	input clk, macc_clear,
	
	output reg signed [18:0] acc
);
	
	reg signed [18:0] acc_c;
    
    always @(*) begin
		if (macc_clear) begin
			acc_c <= A * B;
		end else begin
			acc_c <= acc + A * B;
		end
    end
	always @(posedge clk) begin
		acc <= acc_c;
	end

endmodule
