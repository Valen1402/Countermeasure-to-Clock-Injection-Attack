module ring_oscillator #(
    parameter INVERTERS_PER_RING = 3
)(
    input  logic en,
    output logic o_ro
);

    wire [INVERTERS_PER_RING-1:0] i_inv;
    wire [INVERTERS_PER_RING-1:0] o_inv;

    assign o_ro = o_inv[INVERTERS_PER_RING-1];
    assign i_inv[0] = en & o_inv[INVERTERS_PER_RING-1];
    //assign i_inv[INVERTERS_PER_RING-1 : 1] = o_inv[INVERTERS_PER_RING-2 : 0];

    generate
      cv32e40p_RO_inverter inv(
          .i_inv (i_inv[0]), .o_inv(o_inv[0])
        );
      genvar i;
      for(i=1; i<INVERTERS_PER_RING; i=i+1) begin
        cv32e40p_RO_inverter inv(
          .i_inv (o_inv[i-1]), .o_inv(o_inv[i])
        );
      end
    endgenerate

endmodule