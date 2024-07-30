`timescale 1 ns / 1 ps

module tb_ro_clk1;

    localparam NUMBER_OF_CLK  = 4;

    logic [NUMBER_OF_CLK-1:0]   en;
    logic [NUMBER_OF_CLK-1:0]   clk1;
    ro_clk ro_clk (
        .en (en),
        .clk1(clk1)
    );

    initial begin
        #0;
        en = 'b0000;

        #20;
        en = 'b1111;
    
        #300;
        $finish();
    end
    
endmodule