module mloopadd(
    input clk, rst_b, 
    input [9:0] x, 
    output [15:0] a
    );

integer count = 0;
wire [9:0] xo;

rgst #(.w(10)) rt(.clk(clk), .rst_b(rst_b), .ld(1'd1), .clr(1'd0), .d(x), .q(xo));
rgst #(.w(16)) rb(.clk(clk), .rst_b(rst_b), .ld(1'd1), .clr(1'd0), .d(a + xo), .q(a));

endmodule

module mloopadd_tb;

    reg clk, rst_b;
    reg [9:0] x;
    wire [15:0] sum;


    mloopadd dut(.clk(clk), .rst_b(rst_b), .x(x), .a(sum));

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
        x = 1;
        repeat(198) begin
            #CLK_PERIOD x = x + 3; 
        end
        #CLK_PERIOD x = 0; 
    end


endmodule