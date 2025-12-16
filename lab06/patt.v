module patt (input clk, rst_b, i, output o);

localparam S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4;

reg [2:0] st, nst;

always @ (*)
    case (st)
    S0:     if (i)      nst = S1;   else    nst = S0;
    S1:     if (i)      nst = S1;   else    nst = S2;
    S2:     if (i)      nst = S3;   else    nst = S0;
    S3:     if (i)      nst = S4;   else    nst = S2;
    S4:     if (i)      nst = S1;   else    nst = S2;
    endcase

assign o = (st == S4);

always @(posedge clk, negedge rst_b)
    if (!rst_b)     st <= S0;   else    st <= nst;

endmodule

module patt_tb;
reg clk, rst_b, i;
wire o;

//add here
patt dut(.clk(clk), .rst_b(rst_b), .i(i), .o(o));

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

                        i = 1;
    #CLK_PERIOD         i = 0;
    #CLK_PERIOD         i = 1;
    #(2 * CLK_PERIOD)   i = 0;
    #CLK_PERIOD         i = 1;

end

endmodule