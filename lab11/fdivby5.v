module fdivby5(input clk, rst_b, clr, c_up, output fdclk);
    wire [2: 0] o, i; //registers output
    rgst #(.w(3)) i0 (.clk(clk), .rst_b(rst_b), 
    .clr(clr | o[2]), .ld(c_up), .d(i), .q(o));
    assign i[2] = (o[1] & o[0]) ^ o[2]; 
    assign i[1] = o[0] ^ o[1]; 
    assign i[0] = ~o[0]; 

    assign fdclk = ~(o[0] | o[1] | o[2]);
endmodule

module fdivby5_tb;

    reg clk, rst_b, clr, c_up;
    wire fdclk;

    fdivby5 dut(.clk(clk), .rst_b(rst_b), .clr(clr), .c_up(c_up), .fdclk(fdclk));

    localparam CLK_PERIOD = 100;
    localparam RUN_CYCLES = 15;
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
        #(6 * CLK_PERIOD)   clr = 1;
        #CLK_PERIOD         clr = 0;
        #(5 * CLK_PERIOD)   clr = 1;
        #CLK_PERIOD         clr = 0;

    end

endmodule