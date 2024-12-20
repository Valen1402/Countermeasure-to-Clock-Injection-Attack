`timescale 1 ns / 1 ps

module tb_ring_oscillator;

    logic en1;
    logic out1;
    ring_oscillator ro1 (
        .en (en1),
        .o_ro(out1)
    );
    defparam ro1.INVERTERS_PER_RING=3;

    initial begin
        #0;
        en1 = 0;

        #20;
        en1 = 1;

        #300;
        $finish();
    end
    
endmodule