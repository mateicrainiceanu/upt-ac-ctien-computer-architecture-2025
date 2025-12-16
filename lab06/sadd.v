module sadd(input  clk, rst_b, x, y, output reg z);
localparam S0 = 0, S1 = 1;
reg st, nst;

always @(*)
    case (st) 
    S0:     if (x & y)      nst = S1;   else nst = S0;
    S1:     if (~x & ~y)    nst = S0;   else nst = S1;   
    endcase

always @(*) begin
    z = 0;
    case (st)
    S0: if (x ^ y)  z = 1;    else z = 0;
    S1: if (x & y)  z = 1;    else z = 0;
    endcase
end

always @(posedge clk, negedge rst_b) begin
    if (!rst_b)     st <= 0;    else st <= nst;
end

endmodule

module sadd_tb; 

reg clk, rst_b, x, y;
wire z;
sadd dut(.clk(clk), .rst_b(rst_b), .x(x), .y(y), .z(z));

// generate clk and reset
localparam CLK_PERIOD   = 200;
localparam RUN_CYCLES   = 8;
localparam RST_PULSE    = 10;

initial begin
    clk = 0; 
    repeat (2 * RUN_CYCLES) #(CLK_PERIOD/2) clk = 1 - clk;
end


initial begin
    rst_b = 0; #RST_PULSE; rst_b = 1;
end

initial begin

                {x, y} = 1;
    #CLK_PERIOD {x, y} = 3;
    #CLK_PERIOD {x, y} = 2;
    #CLK_PERIOD {x, y} = 0;

end


endmodule