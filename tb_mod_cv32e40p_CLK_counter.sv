`timescale 1 ns / 1 ps

module tb_clk_counter;

    localparam NUMBER_OF_CLK  = 4;

    logic                       clk;
    logic                       rst;
    logic [NUMBER_OF_CLK-1:0]   en;
    logic [NUMBER_OF_CLK-1:0]   clk1;
    logic                       alarm;
    logic                       mismatch;
    reg  [NUMBER_OF_CLK-1:0][3:0]     count_cur_pclk;
    reg  [NUMBER_OF_CLK-1:0][3:0]     count_pre_pclk;
    reg  [NUMBER_OF_CLK-1:0][3:0]     count_cur_nclk;
    reg  [NUMBER_OF_CLK-1:0][3:0]     count_pre_nclk;

    CLK_counter CLK_counter (
        .clk(clk),
        .rst(rst),
        .en(en),
        .mismatch(mismatch),
        .alarm(alarm),
        .clk1(clk1),
        .count_cur_pclk(count_cur_pclk),
        .count_pre_pclk(count_pre_pclk),
        .count_cur_nclk(count_cur_nclk),
        .count_pre_nclk(count_pre_nclk)
    );

    initial begin
      clk = 0;
      forever 
        fork
          #10 clk = ~clk;
        join
    end

    initial begin
        #0;
        rst = 0;
        en = 'b0000;

        #20;
        rst = 1;

        #20;
        en = 'b1111;

        #204;
        clk = ~clk;
        #1;
        clk = ~clk;
        #1000;
        $finish();
    end
    
endmodule