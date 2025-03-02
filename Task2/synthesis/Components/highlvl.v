module toplevel (
    input start, clk, reset,
    output [7:0] HEX0,
    output done,
    output [10:0] clock_count 
);

    wire [7:0] addrA, addrB, addrC;
    wire [7:0] data_inA, data_inB;
    wire signed [7:0] data_outA, data_outB;

    wire [18:0] dot_prod;
    wire [18:0] out_allegedly;

    wire Load, macc_clear, read_in_C;

    RAMA RA (
        .clk(clk),
        // .we(1'b0),
        .we(Load),
        .addr(addrA),
        .data_in(8'b0),
        .data_out(data_outA)
    );

    RAMB RB (
        .clk(clk),
        // .we(1'b0),
        .we(Load),
        .addr(addrB),
        .data_in(8'b0),
        .data_out(data_outB)
    );

    RAMOUTPUT RAMOUTPUT (
        .clk(clk),
        .mwr(read_in_C),
        .addr(addrC),
        .mdi(dot_prod),
        .mdo(out_allegedly)
    );

    // Areg AR0 ( //Areg instantiation
    //     .clk(clk),
    //     .Load(Load),
    //     .reset(reset),
    //     .addr(addrA)
    // );

    // Breg BR0 ( //Breg instantiation
    //     .clk(clk),
    //     .Load(Load),
    //     .reset(reset),
    //     .addr(addrB)
    // );

    AddrReg AR0 (
        .clk(clk),
        .Load(Load),
        .reset(reset),
        .addrA(addrA),
        .addrB(addrB)
    );

    Creg CR0( //Cout instantiation
        .clk(clk),
        .Load(read_in_C),
        .reset(reset),
        .addr(addrC) 
    );

    MAC M0 (
        .A(data_outA),
        .B(data_outB),
        .clk(clk),
        .macc_clear(macc_clear),

        .acc(dot_prod) // Matrix C input
    );

    ctrl_mat_mult U0(
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