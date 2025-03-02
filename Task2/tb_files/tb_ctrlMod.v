module tb_ctrlMod;
    reg start, reset, clk;
    wire [10:0] clock_count;
    wire done, MAC_CLR, Load, wireOut;

    ctrl_mat_mult UUT (
        .start(start),
        .reset(reset),
        .clk(clk),
        .clock_count(clock_count),
        .done(done),
        .MAC_CLR(MAC_CLR),
        .Load(Load),
        .wireOut(wireOut)
    );

    // Clock generator
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    initial begin
        reset = 1; // reset state machine
        start = 0;
        #100 reset = 0;  // release reset

        start = 1;

   $monitor("Mac Clear, %b   time = %0t", 
            MAC_CLR, $time);



        #1500;
        $stop;
    end

endmodule