module seq3b (
  input [3:0] i,
  output reg o
);
  //write Verilog code here
  integer k;

  always @(*) begin
    o = 0;
    for (k = 0; k < 3 - 1; k=k+1) begin
      if (i[k] == i[k+1] && i[k+2] == i[k+1] && i[k] == i[k+2]) o = 1;
    end
  end
endmodule

module seq3b_tb;
  reg [3:0] i;
  wire o;

  seq3b seq3b_i (.i(i), .o(o));

  integer k;
  initial begin
    $display("Time\ti\t\to");
    $monitor("%0t\t%b(%2d)\t%b", $time, i, i, o);
    i = 0;
    for (k = 1; k < 16; k = k + 1)
      #10 i = k;
  end
endmodule