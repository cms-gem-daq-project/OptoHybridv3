`timescale 1ns / 1ps

module   gem_data_out #(
  parameter FPGA_TYPE_IS_VIRTEX6 = 0,
  parameter FPGA_TYPE_IS_ARTIX7  = 0,
  parameter FRAME_CTRL_TTC = 1
)
(
  output [3:0]  trg_tx_n,
  output [3:0]  trg_tx_p,

  input [1:0]  refclk_n,
  input [1:0]  refclk_p,

  input [56*2-1:0]  gem_data,      // 56 bit gem data
  input             overflow_i,    // 1 bit gem has more than 8 clusters
  input [11:0]      bxn_counter_i, // 12 bit bxn counter
  input             bc0_i,         // 1  bit bx0 flag
  input             resync_i,      // 1  bit resync flag

  input clock_40,
  input clock_80,
  input clock_160,

  input reset_i
);

//----------------------------------------------------------------------------------------------------------------------
// Signals
//----------------------------------------------------------------------------------------------------------------------

  wire usrclk_160;
  wire reset;

//----------------------------------------------------------------------------------------------------------------------
// Transmit data
//----------------------------------------------------------------------------------------------------------------------

  wire [111:0] gem_data_buf;

  wire mgt_reset;
  wire mgt_reset_sync;

  reg [7:0] frame_sep;

  wire [3:0] tx_fsm_reset_done;
  wire ready;
  wire ready_sync;

  wire bc0;
  wire resync;
  wire overflow;
  wire [1:0] bxn_counter_lsbs;

  reg [1:0] tx_frame=0;

  reg [15:0] trg_tx_data [3:0] ;
  reg [1:0]  trg_tx_isk  [3:0];

  wire [55:0] gem_link_data [3:0];

  assign gem_link_data[0] = gem_data_buf[55:0];
  assign gem_link_data[1] = gem_data_buf[111:56];
  assign gem_link_data[2] = gem_data_buf[55:0];
  assign gem_link_data[3] = gem_data_buf[111:56];

  always @(posedge usrclk_160) begin
    tx_frame  <= (reset || ~ready) ? 2'd0 : tx_frame + 1'b1;
  end

  parameter MGT_RESET_CNT_MAX = 'd1023;
  parameter MGT_RESET_BITS    = $clog2 (MGT_RESET_CNT_MAX);

  reg [MGT_RESET_BITS-1:0] mgt_reset_cnt = 0;

  always @ (posedge clock_40) begin
    if (reset_i)
      mgt_reset_cnt <= 0;
    else if (mgt_reset_cnt < MGT_RESET_CNT_MAX)
      mgt_reset_cnt <= mgt_reset_cnt + 1'b1;
    else
      mgt_reset_cnt <= mgt_reset_cnt;
  end

  assign mgt_reset = (mgt_reset_cnt == MGT_RESET_CNT_MAX);

  genvar ilink;
  generate
    for (ilink=0; ilink < 4; ilink=ilink+1)
    begin: linkgen

      always @(posedge usrclk_160) begin

        if (reset || ~ready) begin
          trg_tx_data[ilink]  <= 16'hFFBC;
          trg_tx_isk[ilink]  <= 2'b01;
        end
        else begin
          case (tx_frame)
            2'd0: begin
                  trg_tx_data[ilink] <= {gem_link_data[ilink][7:0] , frame_sep[7:0]};
                  trg_tx_isk[ilink]  <= 2'b01;
            end
            2'd1: begin
                  trg_tx_data[ilink] <= {gem_link_data[ilink][23:8]};
                  trg_tx_isk[ilink]  <= 2'b00;
            end
            2'd2: begin
                  trg_tx_data[ilink] <= {gem_link_data[ilink][39:24]};
                  trg_tx_isk[ilink]  <= 2'b00;
            end
            2'd3: begin
                  trg_tx_data[ilink] <= {gem_link_data[ilink][55:40]};
                  trg_tx_isk[ilink]  <= 2'b00;
            end
          endcase
        end
      end

  end
  endgenerate

  //---------------------------------------------------
  // we should cycle through these four K-codes:  BC, F7, FB, FD to serve as
  // bunch sequence indicators.when we have more than 8 clusters
  // detected on an OH (an S-bit overflow)
  // we should send the "FC" K-code instead of the usual choice.
  //---------------------------------------------------

  //-local (ttc independent) counter ---------------------------------------------------------------------------------

  reg [3:0] frame_sep_cnt=0;

  always @(posedge usrclk_160) begin
    frame_sep_cnt <= (reset || ~ready) ? 3'd0 : frame_sep_cnt + 1'b1;
  end

  wire [1:0] frame_sep_cnt_switch = FRAME_CTRL_TTC ? bxn_counter_lsbs : frame_sep_cnt[3:2]; // take only the two MSBs because of divide by 4 40MHz <--> 160MHz conversion

  always @(*) begin
    if (bc0)
      frame_sep <= 8'h1C;
    else if (resync)
      frame_sep <= 8'h3C;
    else if (overflow)
      frame_sep <= 8'hFC;
    else begin
      case (frame_sep_cnt_switch)
        2'd0:  frame_sep <= 8'hBC;
        2'd1:  frame_sep <= 8'hF7;
        2'd2:  frame_sep <= 8'hFB;
        2'd3:  frame_sep <= 8'hFD;
      endcase
    end
  end


  generate
  if (FPGA_TYPE_IS_ARTIX7) begin

      initial $display ("Generating optical links for Artix-7");

      assign ready = &tx_fsm_reset_done;

      synchronizer synchronizer_reset      (.async_i (reset_i),   .clk_i (usrclk_160), .sync_o (reset));
      synchronizer synchronizer_ready_sync (.async_i (ready),     .clk_i (clock_160),  .sync_o (ready_sync));
      synchronizer synchronizer_mgtrst     (.async_i (mgt_reset), .clk_i (usrclk_160), .sync_o (mgt_reset_sync));

      cluster_data_cdc
      cluster_data_cdc (
        .wr_clk        (clock_160),
        .rd_clk        (usrclk_160),
        .din           ({gem_data,    bc0_i, resync_i, bxn_counter_i[1:0],  overflow_i}),
        .dout          ({gem_data_buf,bc0,   resync,   bxn_counter_lsbs,    overflow  }),
        .full          (),
        .empty         (),
        .wr_en         (ready_sync),
        .rd_en         (1'b1)
      );

      a7_gtp_wrapper a7_gtp_wrapper (

        .soft_reset_tx_in          (mgt_reset),

        .Q0_CLK0_GTREFCLK_PAD_N_IN (refclk_n[0]),
        .Q0_CLK0_GTREFCLK_PAD_P_IN (refclk_p[0] ),

        .Q0_CLK1_GTREFCLK_PAD_N_IN (refclk_n[1] ),
        .Q0_CLK1_GTREFCLK_PAD_P_IN (refclk_p[1]),

        .TXN_OUT                   (trg_tx_n),
        .TXP_OUT                   (trg_tx_p),

        .sysclk_in                 (clock_40),

        .gt0_txcharisk_i           (trg_tx_isk[0]),
        .gt1_txcharisk_i           (trg_tx_isk[1]),
        .gt2_txcharisk_i           (trg_tx_isk[2]),
        .gt3_txcharisk_i           (trg_tx_isk[3]),

        .gt0_txdata_i              (trg_tx_data[0]),
        .gt1_txdata_i              (trg_tx_data[1]),
        .gt2_txdata_i              (trg_tx_data[2]),
        .gt3_txdata_i              (trg_tx_data[3]),

        .tx_fsm_reset_done         (tx_fsm_reset_done),

        .gt0_txusrclk_o            (usrclk_160),
        .gt1_txusrclk_o            (),
        .gt2_txusrclk_o            (),
        .gt3_txusrclk_o            ()
      );
  end
  endgenerate

  generate
  if (FPGA_TYPE_IS_VIRTEX6) begin

      initial $display ("Generating optical links for Virtex-6");

      assign gem_data_buf     = gem_data;
      assign reset            = reset_i;
      assign reset_sync       = reset;
      assign bc0              = bc0_i;
      assign resync           = resync_i;
      assign bxn_counter_lsbs = bxn_counter_i[1:0];
      assign overflow         = overflow_i;
      assign ready            = ~reset;
      assign usrclk_160       = clock_160;

      v6_gtx_wrapper v6_gtx_wrapper (
        .refclk_n          (refclk_n),
        .refclk_p          (refclk_p),
        .clock_40          (clock_40),
        .clock_160         (clock_160),
        .GTTX_RESET_IN     (mgt_reset),
        .TXN_OUT           (trg_tx_n),
        .TXP_OUT           (trg_tx_p),
        .GTX0_TXCHARISK_IN (trg_tx_isk[0]),
        .GTX1_TXCHARISK_IN (trg_tx_isk[1]),
        .GTX2_TXCHARISK_IN (trg_tx_isk[2]),
        .GTX3_TXCHARISK_IN (trg_tx_isk[3]),
        .GTX0_TXDATA_IN    (trg_tx_data[0]),
        .GTX1_TXDATA_IN    (trg_tx_data[1]),
        .GTX2_TXDATA_IN    (trg_tx_data[2]),
        .GTX3_TXDATA_IN    (trg_tx_data[3])
      );

  end
  endgenerate

//----------------------------------------------------------------------------------------------------------------------
endmodule
//----------------------------------------------------------------------------------------------------------------------
