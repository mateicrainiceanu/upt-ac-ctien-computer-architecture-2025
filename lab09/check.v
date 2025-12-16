module check (input [4:0]i, output o);
    assign o = !i[0] & !i[1] & !i[2];
endmodule

module check_tb;

    reg [4: 0] i;
    wire o;

    check dut(.i(i), .o(o)); 

    integer k;
    initial begin
        $display("Time\ti\t\to");
        $monitor("%0t\t%b\t%d\t %d)", $time, i, i, o);
        i = 0;
        for (k = 1; k < 32; k = k + 1)
            #10 i = k;
    end

endmodule