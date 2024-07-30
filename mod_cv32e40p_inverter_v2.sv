`timescale 1 ns / 1 ps

module cv32e40p_RO_inverter_v2
(
  input  logic 	i_inv,
  output logic 	o_inv
);
  always @(i_inv) begin		
    #5;
    o_inv = ~i_inv;
  end
endmodule