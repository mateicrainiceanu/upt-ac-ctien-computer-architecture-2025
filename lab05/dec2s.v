module dec2s (
    input [1: 0]s, input e, output reg [3: 0] o
);

always @() begin
    o = 0;
    case (s)
        0:      o[0] <= e;
        1:      o[1] <= e;
        2:      o[2] <= e;
        3:      o[3] <= e;
    endcase

end
    
endmodule