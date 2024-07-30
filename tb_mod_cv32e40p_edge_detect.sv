`timescale 1ns/1ps

module tb_cv32e40p_edge_detect;

logic in;
logic pulse;


cv32e40p_edge_detect cv32e40p_edge_detect(
  .in(in),
  .pulse(pulse)
);

initial begin
  #10;
  in = 1;
  #3;
  in = 0;
  #20;
  in = 1;
  #20;
end

endmodule