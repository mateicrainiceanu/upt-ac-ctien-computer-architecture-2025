module add2b (
    input [1:0] x, y, 
    input ci, 
    output co, 
    output [1:0] z
);
    // internal wire
    wire co0_ci1;

    fac fac_0(.x(x[0]), .y(y[0]), .ci(ci), .co(co0_ci1), .z(z[0])); 
    fac fac_1(.x(x[1]), .y(y[1]), .ci(co0_ci1), .co(co), .z(z[1])); 
endmodule


module add2b_tb;
    reg [1:0] x, y;
    reg ci;
    wire co;
    wire [1:0] z;

    add2b dut(.x(x), .y(y), .ci(ci), .co(co), .z(z));
    
    integer k;

    initial begin
        $display("Time\t x\t y\t ci\t co\t z");
        $monitor("%4t\t %b\t %b\t %b\t %b\t %b", $time, x, y, ci, co, z);

        for (k = 0; k < 32; k = k + 1) begin
            {x, y, ci} = k;
            #5; // delay to observe changes
        end
    end
endmodule
