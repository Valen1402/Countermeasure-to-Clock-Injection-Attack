`timescale 1 ns / 1 ps

module cv32e40p_RO_inverter
(
  input  logic 	i_inv,
  output logic 	o_inv
);
  always @(i_inv) begin		
    #1;
    o_inv = ~i_inv;
  end
endmodule