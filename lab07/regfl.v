
module regfl (
    input clk, rst_b, we,
    input [2: 0] s,
    input [63:0] d,
    output [511: 0] q
);
    wire [7:0] dout;

    dec #(.w(3)) dec3(.s(s), .e(we), .o(dout));

    generate
        genvar i;
        for (i = 0; i < 8; i = i+1) begin
            rgst #(.w(64)) i2(.clk(clk), .rst_b(rst_b), .ld(dout[i]), .clr(1'd0),
            .d(d), .q(q[(511 - i * 64 )-: 64])
            );
        end
    endgenerate

endmodule

module regfl_tb;

    reg clk, rst_b, we;
    reg [2:0]       s;
    reg [63: 0]     d;
    wire [511: 0]   q;
    
    regfl dut(.clk(clk), .rst_b(rst_b), .we(we), .s(s), .d(d), .q(q));

    localparam CLK_PERIOD = 100, RUN_CYCLES = 13, RST_PULSE = 25;

    initial begin
        clk = 0; repeat (2*RUN_CYCLES) #(CLK_PERIOD/2) clk = 1-clk;
    end

    initial begin rst_b = 0; #RST_PULSE rst_b = 1; end
    initial begin we = 1; #(6*CLK_PERIOD) we = 0; #CLK_PERIOD we = 1;  end

    integer i;

    initial begin
        for (i = 0; i < 13; i = i + 1) begin
            s = $urandom();
            d = {16{i[3:0]}};
            #CLK_PERIOD;
        end
    end

endmodule