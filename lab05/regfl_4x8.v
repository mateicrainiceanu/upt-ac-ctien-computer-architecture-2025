module regfl_4x8 (
    input clk, rst_b, wr_e, input [1:0] wr_addr,
    input [1:0] rd_addr, input [7:0] wr_data,
    output [7:0] rd_data
);

    wire [3:0] dout;
    wire [7:0] rout [0:3];

    dec2s i0();

endmodule