module reg_q(
  input clk, rst_b, clr_lsb, ld_ibus, ld_obus, sh_r,
  input sh_i, [7:0] ibus,
  output reg [7:0] obus, [7:0] q
);
  always @ (posedge clk, negedge rst_b)
    //treat inputs rst_b, clr_lsb, ld_ibus, sh_r here

  always @ (*) //write content to obus when ld_obus==1
    obus = (ld_obus) ? q : 8'bz;
endmodule