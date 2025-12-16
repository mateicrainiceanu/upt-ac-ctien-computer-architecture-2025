module sisr4b(input i, clk, rst_b, output [3:0] q); 

genvar k; for (k = 0; k < 4; k = k+1) begin
    if (k == 0)
        d_ff d(.clk(clk), .rst_b(rst_b), .set_b(1'd1), .d(i ^ q[3]), .q(q[k]));
    else if (k == 1)
        d_ff d(.clk(clk), .rst_b(rst_b), .set_b(1'd1), .d(q[0] ^ q[3]), .q(q[k]));
    else
        d_ff d(.clk(clk), .rst_b(rst_b), .set_b(1'd1), .d(q[k - 1]), .q(q[k]));
    

end

endmodule