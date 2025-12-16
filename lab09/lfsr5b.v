module lfsr5b (input clk, rst_b, output [4:0] q);

    genvar k; generate
        for (k = 0; k < 5; k = k + 1) begin:some_name
            if (k == 0)
                d_ff i(.clk(clk), .rst_b(1'd1), .set_b(rst_b), .d(q[4]), .q(q[k]));
            else if (k == 2)
                d_ff i(.clk(clk), .rst_b(1'd1), .set_b(rst_b), .d(q[1] ^ q[4]), .q(q[k]));
            else
                d_ff i(.clk(clk), .rst_b(1'd1), .set_b(rst_b), .d(q[k-1]), .q(q[k]));
        end
    endgenerate

endmodule

module lfsr5b_tb;

    reg clk, rst_b;
    wire [4:0] q;

    lfsr5b dut(.clk(clk), .rst_b(rst_b), .q(q));

    localparam CLK_PERIOD   = 100;
    localparam RUN_CYCLES   = 35;
    localparam RST_PULSE    = 25;

    initial begin
        rst_b = 0;
        #RST_PULSE rst_b = 1;
    end

    initial begin
        clk = 1;
        repeat (2 * RUN_CYCLES) #(CLK_PERIOD/2) clk = 1 - clk;
    end

endmodule