module fac (
    input x, y, ci,
    output co, z 
);

assign co = x & y | x&ci | y&ci;
assign z = x ^ y ^ ci;

endmodule

module fac_tb; // ";" for no input or output // CUT (circuit under test) == FAC

//for each input -> reg signal with same name and width
reg x, y, ci;

//for each output -> wire with the same name
wire co, z;

fac dut (.x(x), .y(y), .ci(ci), .co(co), .z(z));
//dut - design under test //.x[connection from fac](x[connection from containing container])

integer k;

initial begin

    $display("Time\t x\t y\t ci\t co\t z\t");
    $monitor("%4t\t %b\t %b\t %b\t %b\t %b\t", $time, x, y, ci, co, z); // [%4t - time on 4 decimals]

    for(k = 0; k < 8; k = k + 1) begin
        {x, y, ci} = k; #10; //concatenating the signal, integer 32 bits. only the lsb are assigned | #delay
    end
end

endmodule

/*
add wave *
run -all
*/