module reg_q(
  input clk, rst_b, clr_lsb, ld_ibus, ld_obus, sh_r,
  input sh_i, [7:0] ibus,
  output reg [7:0] obus, [7:0] q
);
  always @ (posedge clk, negedge rst_b)
    if (!rst_b)  q <= 0;
    else if (clr_lsb)   q[0] <= 0;
    else if (ld_ibus)   q <= ibus;
    else if (sh_r)      q <= {sh_i, q[7:1]};

  always @ (*) //write content to obus when ld_obus==1
    obus = (ld_obus) ? q : 8'bz;
endmodule