`timescale 1 ns / 1 ps

module cv32e40p_edge_detect
(
  input  logic 	in,
  output logic 	pulse
);
  logic  in2, in3;

  cv32e40p_RO_inverter_v2 inv1 (
    .i_inv(in),
    .o_inv(in2)
  );

  cv32e40p_RO_inverter_v2 inv2 (
    .i_inv(in2),
    .o_inv(in3)
  );

  assign pulse = ~in3 & in;
  
endmodule