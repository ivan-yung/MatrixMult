module ctrl_mat_mult_OP (
input start, reset, clk,

    output reg [10:0] clock_count,
output reg done,
output reg MAC_CLR, Load, wireOut

);


reg [1:0] state, nextstate;

    reg MAC_CLR_C;
    reg wireOut_d;

    reg [10:0] mult_count;

    // State encoding
    localparam S0 = 2'b00;  // Initial state
    localparam S1 = 2'b01;  // multiplication state
    localparam S2 = 2'b10;  // done state
    
    // State transition on clock edge
    always @(posedge clk or posedge reset) begin

        MAC_CLR <= MAC_CLR_C;
        wireOut <= wireOut_d;

        if (reset) begin
            state <= S0;
            clock_count <= 0;
            mult_count <= 0;
            wireOut <= 0;
        end
        else begin
            state <= nextstate;

            if (state == S1) begin
                clock_count <= clock_count + 1;
                mult_count <= mult_count + 1;
            end
        end
    end
    
    // Next state logic and output assignments
    always @(*) begin
        // Default outputs
        nextstate = state;  // Default to staying in current state
        done = 0;
        MAC_CLR_C = 0;
        Load = 0;
        wireOut_d = 0;

        case (state)
            S0: begin
                if (start) begin
                    Load = 1;
                    nextstate = S1;
                end else begin
                    nextstate = S0;
                end
            end

            S1: begin
                Load = 1;

                if (mult_count == 0) begin
                    MAC_CLR_C = 1;
                    
                end else if (mult_count % 8 == 0) begin  //delay mac clr by one cyc.e???!!
                    //mac clear for next matrix op
                    MAC_CLR_C = 1;
                    wireOut_d = 1;
                    nextstate = S1;

                end else if (mult_count < 133) begin
                    //multiply again
                    nextstate = S1;

                end else begin
                    //done
                    nextstate = S2;
                end
            end

            S2: begin
                done = 1;
                if (!start) begin
                    nextstate = S0;
                end    
            end

            default: nextstate = S0;
        endcase
    end


endmodule