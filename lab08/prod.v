module prod(input clk, rst_b, output reg val, output reg [7:0] data);

    integer cnt;

    always @(posedge clk, negedge rst_b) begin
        if(!rst_b) begin val <= 0; cnt <= 1; end
    
        else begin
            data <= $urandom_range(0,5);
            if (cnt == 1) begin
                if (val)    cnt <= $urandom_range(1,4);
                else        cnt <= $urandom_range(3,5);

                val <= 1 - val; 
            end
            else cnt <= cnt - 1; 
        end
    end

endmodule

module prod_tb;

    reg clk, rst_b;
    wire val;
    wire [7:0] data;

    prod dut(.clk(clk), .rst_b(rst_b), .val(val), .data(data));

    localparam CLK_PERIOD = 100;
    localparam RUN_CYCLES = 30;
    localparam RESET_DELAY = 10;

    initial begin rst_b = 0; #RESET_DELAY rst_b = 1; end 

    initial begin
        clk = 0; repeat (2*RUN_CYCLES) #(CLK_PERIOD/2) clk = 1-clk;
    end

endmodule