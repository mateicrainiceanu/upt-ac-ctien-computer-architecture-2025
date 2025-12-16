module mux2s #(parameter w = 4) (input [w-1:0] d0, d1, d2, d3,
    input [1:0]s, output reg [w-1:0] o);

    always @(*) begin
        case (s)
            0:          o=d0;
            1:          o=d1;
            2:          o=d2;
            default:    o=d3;
        endcase
    end

endmodule

module mux2s_tb; 
    reg [7: 0] d0, d1, d2, d3;
    reg [1: 0] s; 
    wire [7: 0] o;

    mux2s #(.w(8)) dut(.d0(d0), .d1(d1), .d2(d2), .d3(d3), .s(s), .o(o));

    //$urandom() -> 32 bit random value

    integer i;
    initial begin
        $display("Time\t sel\t d3\t d2\t d1\t d0\t | \t o");
        $monitor("%4t\t %d\t %x\t %x\t %x\t %x\t | \t %x", $time, s, d3, d2, d1, d0, o);

        for (i = 0; i < 8; i = i + 1) begin
            {d3, d2, d1, d0} = $urandom();
            s = i; // selects the lest significant 2 bits
            #100;
        end
    end

endmodule