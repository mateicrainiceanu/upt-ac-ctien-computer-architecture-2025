module count11 #(parameter w = 4, i_val = 0) (
    input clk, rst_b, c_up,
    output reg [w-1: 0] q
);

    always @(posedge clk, negedge rst_b) begin
        if(!rst_b)      q <= i_val;
        else if (c_up)    q <= q + 11;
    end

endmodule

module count11_tb; //w = 10; ic 'h[3fb] 11 1111 1011

    reg clk, rst_b, c_up;
    wire [9: 0] q;

    count11 #(.w(10), .i_val('h3fb)) dut(.clk(clk), .rst_b(rst_b), .c_up(c_up), .q(q));
    
    localparam CLK_PERIOD=200; // <=> #define in c
    localparam RUN_CYCLES = 7;
    localparam RST_PULSE = 10;

    initial begin
        clk = 0; repeat (2*RUN_CYCLES) #(CLK_PERIOD/2) clk = 1-clk;
    end

    initial begin
        rst_b = 0; #RST_PULSE; rst_b = 1;
    end 

    initial begin
        c_up = 1;
        #CLK_PERIOD;
        c_up = 0;
        #(CLK_PERIOD);
        c_up = 1;
        #(2 * CLK_PERIOD);
        c_up = 0;
        #(CLK_PERIOD);
        c_up = 1;
    
    end



endmodule