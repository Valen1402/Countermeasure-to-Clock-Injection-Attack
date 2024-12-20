module ro_clk #(
    NUMBER_OF_CLK = 4
)(
    input  logic [NUMBER_OF_CLK-1:0]  en,
    output logic [NUMBER_OF_CLK-1:0]  clk1
);
    ring_oscillator # (
      .INVERTERS_PER_RING(7)
      ) ro0 (
          .en (en[0]), .o_ro(clk1[0])
      );

    ring_oscillator # (
      .INVERTERS_PER_RING(5)
      ) ro1 (
          .en (en[1]), .o_ro(clk1[1])
      );
    
    ring_oscillator # (
      .INVERTERS_PER_RING(3)
      ) ro2 (
          .en (en[2]), .o_ro(clk1[2])
      );

    ring_oscillator # (
      .INVERTERS_PER_RING(1)
      ) ro3 (
          .en (en[3]), .o_ro(clk1[3])
      );


    /*
    generate
      genvar i;
      for(i=0; i<NUMBER_OF_CLK; i=i+1) begin
        ring_oscillator # (
          .INVERTERS_PER_RING(INVERTERS_RO[i])
        ) ro (
          .en (en[i]), .o_ro(clk1[i])
        );
      end
    endgenerate
    */

endmodule