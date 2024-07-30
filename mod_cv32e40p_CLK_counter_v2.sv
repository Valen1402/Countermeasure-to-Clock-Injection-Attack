module CLK_counter_v2 #(
    NUMBER_OF_CLK = 4
)(
    input  logic                      clk,
    input  logic                      rst,
    input  logic [NUMBER_OF_CLK-1:0]  en,

    output logic                      alarm,
    output logic                      alarm_pulse,
    output logic                      mismatch,
    output logic [NUMBER_OF_CLK-1:0]  clk1
    ,
    output reg  [NUMBER_OF_CLK-1:0][3:0]     count_cur_pclk,
    output reg  [NUMBER_OF_CLK-1:0][3:0]     count_pre_pclk,
    output reg  [NUMBER_OF_CLK-1:0][3:0]     count_cur_nclk,
    output reg  [NUMBER_OF_CLK-1:0][3:0]     count_pre_nclk
);
    //wire [NUMBER_OF_CLK-1:0]          clk1;
    //reg  [NUMBER_OF_CLK-1:0][5:0]     count_cur_pclk;
    //reg  [NUMBER_OF_CLK-1:0][5:0]     count_pre_pclk;
    //reg  [NUMBER_OF_CLK-1:0][5:0]     count_cur_nclk;
    //reg  [NUMBER_OF_CLK-1:0][5:0]     count_pre_nclk;
    //reg                               mismatch;

    //wirepclk_mismatch, nclk_mismatch;
    //assign pclk_mismatch = count_cur_pclk != count_pre_pclk;
    //assign nclk_mismatch = count_cur_nclk != count_pre_nclk;

    //logic alarm_pulse, mismatch;

    logic [NUMBER_OF_CLK-1:0]         pclk_mismatch, nclk_mismatch;
    logic                             first_mismatch;
    //TOLERANCE
    always_comb begin
      if (count_cur_pclk[3] > count_pre_pclk[3]) begin
        pclk_mismatch[3] = ((count_cur_pclk[3] - count_pre_pclk[3])>2) ? 1:0;
      end else begin
        pclk_mismatch[3] = ((count_pre_pclk[3] - count_cur_pclk[3])>2) ? 1:0;
      end

      if (count_cur_nclk[3] > count_pre_nclk[3]) begin
        nclk_mismatch[3] = ((count_cur_nclk[3] - count_pre_nclk[3])>2) ? 1:0;
      end else begin
        nclk_mismatch[3] = ((count_pre_nclk[3] - count_cur_nclk[3])>2) ? 1:0;
      end
      
    end
    
    ro_clk ro_clk (
      .en(en),
      .clk1(clk1)
    );

    always @(posedge clk) begin
      if (~rst) begin
        mismatch        <= 0;
        alarm_pulse           <= 0;
        count_cur_pclk  <= 0;
        count_pre_pclk  <= 0;
        count_cur_nclk  <= 0;
        count_pre_nclk  <= 0;
        first_mismatch  <= 1;
      end
      
      else begin
        
        count_pre_nclk <= count_cur_nclk;
        if (nclk_mismatch[3]) begin
          if (mismatch)
            alarm_pulse       <= 1;
          else
            mismatch    <= 1;

        end else begin
          alarm_pulse         <= 0;
          mismatch      <= 0;
        end
      end
    end

    always @(negedge clk) begin
      count_pre_pclk <= count_cur_pclk;
      if (pclk_mismatch[3]) begin
        if (mismatch)
          alarm_pulse       <= 1;
        else
          mismatch    <= 1;

      end else begin
        mismatch      <= 0;
      end
    end

    // clk1 is the fast clk
    always @(posedge clk1[3]) begin
      if(clk) begin
        count_cur_nclk[3] <= 0;
        count_cur_pclk[3] <= count_cur_pclk[3] + 1;
      end else begin
        count_cur_pclk[3] <= 0;
        count_cur_nclk[3] <= count_cur_nclk[3] + 1;
      end
    end

  cv32e40p_edge_detect posedge_detect(
    .in(alarm_pulse),
    .pulse(alarm)
  );


endmodule