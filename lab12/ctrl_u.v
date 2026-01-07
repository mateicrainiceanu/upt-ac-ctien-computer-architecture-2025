module ctrl_u(
  input clk, rst_b, bgn, q_0, cnt_is_7,
  output c0, c1, c2, c3, c4, c5, c6, fin
);
  //implementation here

  localparam S0=0, S1=1, S2=2, S3=3, S4=4, S5=5, S6=6, S7=7;
  reg  [7:0] st;
  wire [7:0] nst;

  assign nst[S0] = st[S0] & (~bgn) | st[S7];
  assign nst[S1] = st[S0] & bgn;
  assign nst[S2] = st[S1];
  assign nst[S3] = st[S2] & q_0 | st[S4] & (~cnt_is_7) & q_0;
  assign nst[S4] = st[S2] & (~q_0) | st[S3] | st[S4] & (~cnt_is_7) & (~q_0);
  assign nst[S5] = st[S4] & cnt_is_7;
  assign nst[S6] = st[S5];
  assign nst[S7] = st[S6];

  assign c0  = st[S1];
  assign c1  = st[S2];
  assign c2  = st[S3];
  assign c3  = st[S4];
  assign c4  = st[S5];
  assign c5  = st[S6];
  assign c6  = st[S7];
  assign fin = st[S6] | st[S7];

  always @(posedge clk, negedge rst_b)
    if (!rst_b) begin
      st <= 0;
      st[S0] <= 1;
    end else
      st <= nst;

endmodule