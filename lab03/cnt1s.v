module cnt1s (
  input [5:0] i,
  output reg [2:0] o
);
  //write Verilog code here
    integer k;
    always @ (*) begin
        o = 0;
        for (k = 0; k < 6; k = k + 1)
            o = o + i[k];
    end

endmodule

module cnt1s_tb;
  reg [5:0] i;
  wire [2:0] o;

  cnt1s cnt1s_i (.i(i), .o(o));

  integer k;
  initial begin
    $display("Time\ti\t\to");
    $monitor("%0t\t%b(%2d)\t%b(%0d)", $time, i, i, o, o);
    i = 0;
    for (k = 1; k < 64; k = k + 1)
      #10 i = k;
  end
endmodule