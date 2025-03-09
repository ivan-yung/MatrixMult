module toplevel (
    input start, clk, reset,
    output [7:0] HEX0,
    output done,
    output [10:0] clock_count,
	output [18:0] out_allegedly
);

    wire [7:0] addrA1, addrA2, addrB1, addrB2, addrC;
    wire [7:0] data_inA, data_inB;
    wire signed [7:0] data_outA1, data_outA2, data_outB1, data_outB2;

    wire [18:0] dot_prod1, dot_prod2, dot_prod3, dot_prod4, buffer_out;

    wire Load, macc_clear, read_in_C, writeToReg;

    RAMA_DP RA (
        .clk(clk),
        // .we(1'b0),
        .we(Load),
        .addr1(addrA1),
        .addr2(addrA2),
        .data_in(8'b0),
        .data_out_1(data_outA1),
        .data_out_2(data_outA2)
    );

    RAMB_DP RB (
        .clk(clk),
        .we(Load),
        .addr1(addrB1),
        .addr2(addrB2),
        .data_in(8'b0),
        .data_out_1(data_outB1),
        .data_out_2(data_outB2)
    );

    RAMOUTPUT RAMOUTPUT (
        .clk(clk),
        .mwr(read_in_C),
        .addr(addrC),
        .mdi(buffer_out),
        .mdo(out_allegedly)
    );

    AddrReg_DP AR0 (
        .clk(clk),
        .Load(Load),
        .reset(reset),
        .addrA1(addrA1),
        .addrA2(addrA2),
        .addrB1(addrB1),
        .addrB2(addrB2)
    );

    Creg CR0( //Cout instantiation
        .clk(clk),
        .Load(writeToReg),
        .reset(reset),
        .addr(addrC) 
    );

    MAC M0 (
        .A(data_outA1),
        .B(data_outB1),
        .clk(clk),
        .macc_clear(macc_clear),

        .acc(dot_prod1) // Matrix C input
    );

    MAC M1 (
        .A(data_outA1),
        .B(data_outB2),
        .clk(clk),
        .macc_clear(macc_clear),

        .acc(dot_prod2) // Matrix C input
    );

    MAC M2(
        .A(data_outA2),
        .B(data_outB1),
        .clk(clk),
        .macc_clear(macc_clear),

        .acc(dot_prod3)
    );

    MAC M3(
        .A(data_outA2),
        .B(data_outB2),
        .clk(clk),
        .macc_clear(macc_clear),

        .acc(dot_prod4)
    );

    buffer buff (
        .clk(clk),
        .reset(reset),
        .mult_count(clock_count),
        .prod1(dot_prod1),
        .prod2(dot_prod2),
        .prod3(dot_prod3),
        .prod4(dot_prod4),
        .out(buffer_out),
        .Load_Creg(writeToReg)    
    );

    ctrl_mat_mult_DP U0(
        .start(start),
        .clk(clk),
        .reset(reset),
        .clock_count(clock_count),
        .done(done),
        .MAC_CLR(macc_clear),
        .Load(Load),
        .wireOut(read_in_C)
    );

    assign HEX0[0] = done;

endmodule