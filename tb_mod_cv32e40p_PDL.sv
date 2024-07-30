`timescale 1 ns / 1 ps

module tb_cv32e40p_PDL;
  const time CLK_PERIOD             = 10ns;
  const time CLK_HALF_PERIOD        = CLK_PERIOD / 2;

  logic                             clk;
  logic                             rst_n;
  logic                             alarm;
  logic                             Q1;
  logic                             delay_line;

	initial begin
    clk                             = 1'b0;
    fork
      forever #CLK_HALF_PERIOD  clk = ~clk;
    join
  end

  initial begin
    rst_n                           = 1'b0;
    repeat(2) @(posedge clk);
    rst_n                           = 1'b1;
  end

  //// DUT ////

  cv32e40p_PDL3 DUT(
    .clk          (clk),
    .rst_n        (rst_n),
    .Q1           (Q1),
    .delay_line   (delay_line),
    .alarm        (alarm)
  );


endmodule