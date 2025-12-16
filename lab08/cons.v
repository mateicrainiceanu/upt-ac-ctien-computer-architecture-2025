module cons(input clk, rst_b, val, input [7:0] data, output reg [7:0] sum);

    integer last_val = 0;

    always @(posedge clk, negedge rst_b) begin 
        if (!rst_b) begin
            sum <= 0;
            last_val <= 0;
        end 
        else if (val) begin
                if (data >= last_val) begin 
                    sum <= sum + data;
                end
                else 
                    sum <= data;
                last_val <= data;
        end 
    end

endmodule

module const_tb;

    reg clk, rst_b;
    wire val; 
    wire [7:0] data, sum;

    prod pr(.clk(clk), .rst_b(rst_b), .val(val), .data(data));
    cons dut(.clk(clk), .rst_b(rst_b), .val(val), .data(data), .sum(sum));

    localparam CLK_PERIOD = 100;
    localparam RUN_CYCLES = 30;
    localparam RESET_DELAY = 10;

    initial begin rst_b = 0; #RESET_DELAY rst_b = 1; end 

    initial begin
        clk = 0; repeat (2*RUN_CYCLES) #(CLK_PERIOD/2) clk = 1-clk;
    end

endmodule