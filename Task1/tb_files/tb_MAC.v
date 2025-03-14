module MAC_tb;
    reg signed [7:0] a, b;
    reg clk, macc_clear;
    wire signed [18:0] acc;
    integer i;
    MAC uut (
        .A(a),
        .B(b),
        .clk(clk),
        .macc_clear(macc_clear),
        .acc(acc)
    );
    
    // Clock generation
    always #5 clk = ~clk;
    
initial begin
	 #100;
    // Initialize signals
    clk = 0;
    a = 0;
    b = 0;
    macc_clear = 0;
    #20;
	 macc_clear = 1;
	 #20
	 macc_clear = 0;

	 
    $monitor("Time = %0t | a = %d | b = %d | macc_clear = %b | acc = %d | product = %d", 
                 $time, a, b, macc_clear, acc, a * b);

    // Test Case 1: Multiply and accumulate
    a = 8'sd3; b = 8'sd4; #20; // 3 * 4 = 12, acc = 12
    a = 8'sd2; b = 8'sd5; #20; // 2 * 5 = 20, acc = 22

    // Test Case 2: Clear and assign product
    macc_clear = 1;
    a = 8'sd7; b = 8'sd6; #20; // 7 * 6 = 42, acc = 42
    macc_clear = 0; 

    // Test Case 3: Continue accumulation
    a = 8'sd1; b = 8'sd3; #20; // 1 * 3 = 3, acc = 45
	 
	 macc_clear = 1;
	 #20;
	 macc_clear = 0;
		

	 // Test random cases
    for (i = 0; i < 5; i = i + 1) begin
		a = $random;
      b = $random;
      #20;
   end
	
	
	
		
    // Test Case 5: Accumulate after reset
    a = 8'b11111111; b = 8'b11111111; #20; // -1 * -1
    a = 8'b01111111; b = 8'b01111111; #20; // 127 * 127

    // End simulation
    #20;
    $stop;
end

endmodule