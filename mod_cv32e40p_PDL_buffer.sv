`timescale 1 ns / 1 ps

module cv32e40p_PDL_buffer
(
  input  logic  clk,
  input  logic 	i_buf,
  output logic 	o_buf
);
  always @(i_buf) begin		
    #9;
    o_buf = i_buf;
  end
endmodule

