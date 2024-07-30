`timescale 1 ns / 1 ps

module cv32e40p_PDL3
(
  input  logic      clk,
  input  logic      rst_n,

  output logic      Q1,
  output logic      delay_line,

  output logic      alarm
);

  wire              D1, D2, D3;
  reg                   Q2, Q3;

  cv32e40p_PDL_buffer PDL_buffer_3 (
	.clk	(clk),
    .i_buf  (Q1),
    .o_buf  (delay_line)
  );

  assign D1             = ~Q1;
  assign D2             = delay_line;
  assign alarm          = Q2 ^ Q3;
  assign D3             = Q1;

  always_ff @(posedge clk) begin
    if (~rst_n) begin
      Q1      <= 0;
      Q2      <= 0;
      Q3      <= 0;
      
    end else begin
      Q1      <= D1;
      Q2      <= D2;
      Q3      <= D3;
    end
  end

endmodule