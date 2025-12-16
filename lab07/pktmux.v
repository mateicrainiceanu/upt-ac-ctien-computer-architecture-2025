module pktmux (
    input  [63:0] pkt,
    input  [63:0] msg_len,
    input         pad_pkt,
    input         zero_pkt,
    input         mgln_pkt,
    output reg [63:0] o
);

    always @(*) begin
        if (pad_pkt)        o = 1 << 63; 
        else if (zero_pkt)  o = 0;
        else if (mgln_pkt)  o = msg_len;
        else                o = pkt;
    end

endmodule


module pktmux_tb;

    reg [63:0] pkt, msg_len;
    reg pad_pkt, zero_pkt, mgln_pkt;
    wire [63:0] o;

    pktmux dut ( .pkt(pkt), .msg_len(msg_len), .pad_pkt(pad_pkt),
        .zero_pkt(zero_pkt), .mgln_pkt(mgln_pkt), .o(o)
    );

    task urand64(output reg [63:0] r);
        begin
            r[63:32] = $urandom();
            r[31:0]  = $urandom();
        end
    endtask

    localparam DELAY_UNIT = 100;
    integer i, iu1, j;

    initial begin
        for (i = 0; i < 13; i = i + 1) begin
            case (i % 4)
                0: {pad_pkt, zero_pkt, mgln_pkt} = 0;
                1: {pad_pkt, zero_pkt, mgln_pkt} = 4;
                2: {pad_pkt, zero_pkt, mgln_pkt} = 2;
                3: {pad_pkt, zero_pkt, mgln_pkt} = 1;
            endcase

            iu1 = i + 1;
            j = 15 - i;
            
            pkt     = {16{iu1[3:0]}};
            msg_len = {16{j[3:0]}};
            #DELAY_UNIT;
        end
    end

endmodule
