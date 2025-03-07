module tb_AddrReg;
    reg Load, reset, clk;
    wire [7:0] addrA; // Address to access A
    wire [7:0] addrB1;  // Address to access B
    wire [7:0] addrB2;

    AddrReg_DP UUT (
        .clk(clk),
        .Load(Load),
        .reset(reset),
        .addrA(addrA),
        .addrB1(addrB1),
        .addrB2(addrB2)
    );

    // Clock generator
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    initial begin

        $monitor("addrA, %d addrB1, %d, addrB2, %d", 
            addrA, addrB1, addrB2);

        reset = 1; // reset 
        Load = 0;
        #100 reset = 0;  // release reset

        // Addr set 1
        Load = 1;
        #5000;

        Load = 0;
        #100;
        $stop;
    end

endmodule