module bist (input clk, rst_b, output [3:0] sig);

    wire [4:0] q_i;
    wire o_i;

    lfsr5b l(.clk(clk), .rst_b(rst_b), .q(q_i));
    check c(.i(q_i), .o(o_i));
    sisr4b s(.clk(clk), .rst_b(rst_b), .i(o_i), .q(sig));
    
endmodule

module bist_tb;

    reg clk, rst_b;
    wire [3:0] sig;

    bist dut(.clk(clk), .rst_b(rst_b), .sig(sig));

    localparam CLK_PERIOD   = 100;
    localparam RUN_CYCLES   = 32;
    localparam RST_PULSE    = 25;

    initial begin
        rst_b = 0;
        #RST_PULSE rst_b = 1;
    end

    initial begin
        clk = 0;
        repeat (2 * RUN_CYCLES) #(CLK_PERIOD/2) clk = 1 - clk;
    end
endmodule