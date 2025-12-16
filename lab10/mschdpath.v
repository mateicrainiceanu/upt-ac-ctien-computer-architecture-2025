module mschdpath (input clk, rst_b, ld_mreg, upd_mreg, input [511:0] blk,
output [31:0] m0);

function [31:0] RtRotate(input [31:0] x, input [4:0] p);

    reg[63:0] tmp;

    begin
        tmp = {x, x};
        RtRotate = tmp[31: 0];
    end

endfunction


function [31:0] Sgm0 (input [31:0] x);
    begin
        Sgm0 = RtRotate(x, 7) ^ RtRotate(x, 18) ^ (x >> 3);
    end
endfunction

function [31:0] Sgm1 (input [31:0] x);
    begin
        Sgm1 = RtRotate(x, 17) ^ RtRotate(x, 19) ^ (x >> 10);
    end
endfunction

function [31:0] MUX(input s, input [31:0] d0, d1); 
    begin
        MUX = (s) ? d1 : d0;
    end
endfunction

function [31: 0] WORD (input [511: 0] blk, input [3:0] i);
    begin
        WORD = blk[511 - 32*i -: 32];
    end
endfunction

wire [31: 0] m [0:15]; // array of 16 elements , each of 32 bits;


genvar k; 
generate
    for (k = 0; k < 16; k = k + 1) begin
        if (k < 15) 
            rgst #(.w(32)) r (.clk(clk), .rst_b(rst_b), .clr(1'd0), .ld(upd_mreg),
            .d(MUX(ld_mreg, m[k+1], WORD(blk, k))), .q(m[k]));
        else 
            rgst #(.w(32)) r (.clk(clk), .rst_b(rst_b), .clr(1'd0), .ld(upd_mreg),
            .d(MUX(ld_mreg, m[0] + Sgm0(m[1]) + m[9] + Sgm1(m[14]), WORD(blk, k))), .q(m[k]));
    end
endgenerate

assign m0 = m[0];

endmodule

module mschdpath_tb;

    reg clk, rst_b, ld_mreg, upd_mreg;
    reg [511: 0] blk;
    wire [31: 0] m0;

    mschdpath dut(.clk(clk), .rst_b(rst_b), .ld_mreg(ld_mreg), .upd_mreg(upd_mreg), .blk(blk), .m0(m0));

    localparam CLK_PERIOD = 100;
    localparam RUN_CYCLES = 220;
    localparam RST_PULSE = 20;

    initial begin
        rst_b = 0;
        #RST_PULSE
        rst_b = 1;
    end

    initial begin 
        clk = 0;
        repeat (RUN_CYCLES * 2) #(CLK_PERIOD/2) clk = 1-clk; 
    end
  
    initial begin
        blk = ('h616263643031323380) << 440 | 8'h40;
        upd_mreg = 1;
        ld_mreg = 1;
        #CLK_PERIOD ld_mreg = 0;
    end

endmodule