module fdivby3(
    input clk,
    input rst_b, 
    input clr,
    input c_up,
    output fdclk
);

    localparam S0 = 0, S1 = 1, S2 = 2;
    reg [2:0] st;
    wire [2:0] nst;

    assign nst[S0] = (st[S0] & (~c_up | clr)) |
                      (st[S1] & clr) |
                      (st[S2] & (c_up | clr));

    assign nst[S1] = (st[S0] & c_up & ~clr) |
                      (st[S1] & ~c_up & ~clr);

    assign nst[S2] = (st[S1] & c_up & ~clr) |
                      (st[S2] & ~c_up & ~clr);

    assign fdclk = st[S0];

    always @(posedge clk or negedge rst_b) begin
        if (~rst_b)
            st <= 3'b001;  
        else
            st <= nst;
    end

endmodule


module fdivby3_tb;

    reg clk, rst_b, clr, c_up;
    wire fdclk;

    fdivby3 dut(.clk(clk), .rst_b(rst_b), .clr(clr), .c_up(c_up), .fdclk(fdclk));

    localparam CLK_PERIOD = 100;
    localparam RUN_CYCLES = 25;
    localparam RST_PULSE = 20;

    initial begin
        clr = 0;
        c_up = 1;
        rst_b = 0;
        #RST_PULSE
        rst_b = 1;
    end

    initial begin 
        clk = 0;
        repeat (RUN_CYCLES * 2) #(CLK_PERIOD/2) clk = 1-clk; 
    end

    initial begin
        #(4 * CLK_PERIOD)   clr = 1;
        #CLK_PERIOD         clr = 0;
    end

    initial begin
        #(6 * CLK_PERIOD)   c_up = 0;
        #CLK_PERIOD         c_up = 1;
        #(4 * CLK_PERIOD)   c_up = 0;
        #(2*CLK_PERIOD)     c_up = 1;
    end

endmodule