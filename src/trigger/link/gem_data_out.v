`timescale 1ns / 1ps

module   gem_data_out #(
  parameter FPGA_TYPE_IS_VIRTEX6 = 0,
  parameter FPGA_TYPE_IS_ARTIX7  = 0,
  parameter ALLOW_TTC_CHARS      = 0,
  parameter ALLOW_RETRY          = 0,
  parameter FRAME_CTRL_TTC       = 0

)
(
  output [3:0]  trg_tx_n,
  output [3:0]  trg_tx_p,

  input [1:0]  refclk_n,
  input [1:0]  refclk_p,

  input [2:0]       tx_prbs_mode,

  input [56*2-1:0]  gem_data,      // 56 bit gem data
  input             overflow_i,    // 1 bit gem has more than 8 clusters
  input [11:0]      bxn_counter_i, // 12 bit bxn counter
  input             bc0_i,         // 1  bit bx0 flag
  input             resync_i,      // 1  bit resync flag

  input pll_reset_i,
  input [3:0] mgt_reset_i,
  input gtxtest_start_i,
  input txreset_i,
  input mgt_realign_i,
  input txpowerdown_i,
  input [1:0] txpowerdown_mode_i,
  input txpllpowerdown_i,

  input clock_40,
  input clock_160,

  output ready_o,

  output pll_lock_o,

  output txfsm_done_o,

  input force_not_ready,

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

  reg  overflow_reg, overflow_reg2;
  reg  [111:0] gem_data_reg;
  reg  [111:0] gem_data_reg2;
  wire [111:0] gem_data_sync;

  wire [3:0] mgt_reset;
  wire mgt_reset_sync;

  reg [7:0] frame_sep;

  wire [3:0] tx_fsm_reset_done;
  wire [3:0] tx_sync_done;
  assign txfsm_done_o = &tx_fsm_reset_done;
  wire [3:0] pll_lock;
  assign pll_lock_o = &pll_lock;
  reg  ready;
  wire ready_sync;
  wire rd_en;

  wire bc0;
  wire resync;
  wire overflow;
  wire [1:0] bxn_counter_lsbs;

  reg [1:0] tx_frame=0;

(* keep="true", max_fanout = "4" *)  reg [15:0] trg_tx_data [3:0] ;
(* keep="true", max_fanout = "4" *)  reg [1:0]  trg_tx_isk   [3:0];

  wire [55:0] gem_link_data [3:0];

  assign gem_link_data[0] = gem_data_sync[55:0];
  assign gem_link_data[1] = gem_data_sync[111:56];
  assign gem_link_data[2] = gem_data_sync[55:0];
  assign gem_link_data[3] = gem_data_sync[111:56];

  always @(posedge usrclk_160) begin
    tx_frame  <= (reset || ~ready_sync) ? 2'd0 : tx_frame + 1'b1;
  end

  //--------------------------------------------------------------------------------------------------------------------
  // Ready Timer
  //--------------------------------------------------------------------------------------------------------------------

  parameter READY_CNT_MAX = 2**18-1;
  parameter READY_BITS    = $clog2 (READY_CNT_MAX);
  reg [READY_BITS-1:0] ready_cnt = 0;

  always @ (posedge clock_40) begin
    if (~ready || force_not_ready)
      ready_cnt <= 0;
    else if (ready_cnt < READY_CNT_MAX)
      ready_cnt <= ready_cnt + 1'b1;
    else
      ready_cnt <= ready_cnt;
  end

  assign ready_o = (ready_cnt == READY_CNT_MAX);

  //--------------------------------------------------------------------------------------------------------------------
  // Retry
  //--------------------------------------------------------------------------------------------------------------------

  wire retry = (ALLOW_RETRY && startup_done && !ready);

  //--------------------------------------------------------------------------------------------------------------------
  // Startup
  //--------------------------------------------------------------------------------------------------------------------

  parameter STARTUP_RESET_CNT_MAX = 2**22-1;
  parameter STARTUP_RESET_BITS    = $clog2 (STARTUP_RESET_CNT_MAX);

  reg [STARTUP_RESET_BITS-1:0] startup_reset_cnt = 0;

  always @ (posedge clock_40) begin
    if (reset_i || retry)
      startup_reset_cnt <= 0;
    else if (startup_reset_cnt < STARTUP_RESET_CNT_MAX)
      startup_reset_cnt <= startup_reset_cnt + 1'b1;
    else
      startup_reset_cnt <= startup_reset_cnt;
  end


  parameter STABLE_CLOCK_PERIOD = 25;

  `ifdef XILINX_ISIM
    parameter DONT_SUPRESS_STARTUP=0;
  `else
    parameter DONT_SUPRESS_STARTUP=1;
  `endif

  parameter MGT_RESET_CNT0    = DONT_SUPRESS_STARTUP * 4000   * 1000 / STABLE_CLOCK_PERIOD; // usec
  parameter MGT_RESET_CNT1    = DONT_SUPRESS_STARTUP * 8000   * 1000 / STABLE_CLOCK_PERIOD; // usec
  parameter MGT_RESET_CNT2    = DONT_SUPRESS_STARTUP * 12000  * 1000 / STABLE_CLOCK_PERIOD; // usec
  parameter MGT_RESET_CNT3    = DONT_SUPRESS_STARTUP * 14000  * 1000 / STABLE_CLOCK_PERIOD; // usec
  parameter PLL_RESET_CNT     = DONT_SUPRESS_STARTUP * 0      * 1000 / STABLE_CLOCK_PERIOD; // usec
  parameter PLL_POWERDOWN_CNT = DONT_SUPRESS_STARTUP * 0      * 1000 / STABLE_CLOCK_PERIOD; // usec
  parameter TXPOWERDOWN_CNT   = DONT_SUPRESS_STARTUP * 0      * 1000 / STABLE_CLOCK_PERIOD; // usec
  parameter GTXTEST_RESET_CNT = DONT_SUPRESS_STARTUP * 16000  * 1000 / STABLE_CLOCK_PERIOD; // usec
  parameter TXRESET_CNT       = DONT_SUPRESS_STARTUP * 18000  * 1000 / STABLE_CLOCK_PERIOD; // usec
  parameter MGT_REALIGN_CNT   = DONT_SUPRESS_STARTUP * 0      * 1000 / STABLE_CLOCK_PERIOD; // usec
  parameter DONE_CNT          = DONT_SUPRESS_STARTUP * 30000  * 1000 / STABLE_CLOCK_PERIOD; // usec

  assign pll_reset    = pll_reset_i      || (startup_reset_cnt <  PLL_RESET_CNT);
  assign mgt_reset[0] = mgt_reset_i[0]   || (startup_reset_cnt <  MGT_RESET_CNT0);
  assign mgt_reset[1] = mgt_reset_i[1]   || (startup_reset_cnt <  MGT_RESET_CNT1);
  assign mgt_reset[2] = mgt_reset_i[2]   || (startup_reset_cnt <  MGT_RESET_CNT2);
  assign mgt_reset[3] = mgt_reset_i[3]   || (startup_reset_cnt <  MGT_RESET_CNT3);
  wire gtxtest_start  = gtxtest_start_i  || (startup_reset_cnt == GTXTEST_RESET_CNT);
  wire txreset        = txreset_i        || (startup_reset_cnt == TXRESET_CNT);
  wire mgt_realign    = mgt_realign_i    || (startup_reset_cnt == MGT_REALIGN_CNT);
  wire txpowerdown    = txpowerdown_i    || (startup_reset_cnt <  TXPOWERDOWN_CNT);
  wire txpllpowerdown = txpllpowerdown_i || (startup_reset_cnt <  PLL_POWERDOWN_CNT);

  wire [1:0] txpowerdown_mode = {2{txpowerdown}} & txpowerdown_mode_i;

  assign startup_done   = (startup_reset_cnt >  DONE_CNT);

  reg [9:0] gtxtest_cnt=1023;
  always @ (posedge clock_40) begin
    if (gtxtest_start)
      gtxtest_cnt <= 0;
    else if (gtxtest_cnt < 1023)
      gtxtest_cnt <= gtxtest_cnt + 1'b1;
    else
      gtxtest_cnt <= gtxtest_cnt;
  end

  wire gtxtest_reset = (gtxtest_cnt > 0 && gtxtest_cnt < 256) || (gtxtest_cnt > 511 && gtxtest_cnt < 768);

  genvar ilink;
  generate
    for (ilink=0; ilink < 4; ilink=ilink+1)
    begin: linkgen

      always @(posedge usrclk_160) begin

        if (reset || ~ready_sync) begin
          trg_tx_data[ilink]  <= 16'hFFFC;
          trg_tx_isk [ilink]  <= 2'b01;
        end
        else begin
          case (tx_frame)
            2'd0: begin
                  trg_tx_data[ilink] <= {gem_link_data[ilink][7:0] , frame_sep[7:0]};
                  trg_tx_isk [ilink] <= 2'b01;
            end
            2'd1: begin
                  trg_tx_data[ilink] <= {gem_link_data[ilink][23:8]};
                  trg_tx_isk [ilink] <= 2'b00;
            end
            2'd2: begin
                  trg_tx_data[ilink] <= {gem_link_data[ilink][39:24]};
                  trg_tx_isk [ilink] <= 2'b00;
            end
            2'd3: begin
                  trg_tx_data[ilink] <= {gem_link_data[ilink][55:40]};
                  trg_tx_isk [ilink] <= 2'b00;
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
    frame_sep_cnt <= (reset || ~ready_sync) ? 3'd0 : frame_sep_cnt + 1'b1;
  end

  wire [1:0] frame_sep_cnt_switch = FRAME_CTRL_TTC ? bxn_counter_lsbs : frame_sep_cnt[3:2]; // take only the two MSBs because of divide by 4 40MHz <--> 160MHz conversion

  always @(*) begin
    if (bc0 && ALLOW_TTC_CHARS)
      frame_sep <= 8'h1C;
    else if (resync && ALLOW_TTC_CHARS)
      frame_sep <= 8'h3C;
    else if (overflow && ALLOW_TTC_CHARS)
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


      always @(posedge clock_160) begin
        ready <= &tx_fsm_reset_done;
      //ready <= &tx_fsm_reset_done && startup_done;
      end

      synchronizer synchronizer_reset      (.async_i (reset_i),   .clk_i (usrclk_160), .sync_o (reset));
      synchronizer synchronizer_ready_sync (.async_i (ready),     .clk_i (usrclk_160), .sync_o (ready_sync));
      synchronizer synchronizer_mgtrst     (.async_i (mgt_reset[0]), .clk_i (usrclk_160), .sync_o (mgt_reset_sync));

      cluster_data_cdc
      cluster_data_cdc (
        .wr_clk        (clock_40),
        .rd_clk        (usrclk_160),
        .din           ({gem_data,     bc0_i, resync_i, bxn_counter_i[1:0],  overflow_i}),
        .dout          ({gem_data_sync,bc0,   resync,   bxn_counter_lsbs,    overflow    }),
        .full          (),
        .empty         (),
        .wr_en         (ready),
        .rd_en         (tx_frame==0)
      );

      a7_gtp_wrapper a7_gtp_wrapper (

        .soft_reset_tx_in          (mgt_reset[0]),

        .pll_lock_out (pll_lock),

        .refclk_in_n (refclk_n),
        .refclk_in_p (refclk_p),

        .TXN_OUT                   (trg_tx_n),
        .TXP_OUT                   (trg_tx_p),

        .sysclk_in                 (clock_40),

        .gt0_txcharisk_i           (trg_tx_isk [0]),
        .gt1_txcharisk_i           (trg_tx_isk [1]),
        .gt2_txcharisk_i           (trg_tx_isk [2]),
        .gt3_txcharisk_i           (trg_tx_isk [3]),

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

      always @(posedge usrclk_160) begin
        gem_data_reg <= gem_data;
        gem_data_reg2 <= gem_data_reg;

        overflow_reg <= overflow_i;
        overflow_reg2 <= overflow_reg;
      end

      assign gem_data_sync    = gem_data_reg2;
      assign overflow         = overflow_reg2;
      assign ready_sync       = ready;
      assign reset            = reset_i;
      assign reset_sync       = reset;
      assign bc0              = bc0_i;
      assign resync           = resync_i;
      assign bxn_counter_lsbs = bxn_counter_i[1:0];
      assign usrclk_160       = clock_160;

      assign pll_lock_o = &pll_lock;

      always @(*) ready <= (&tx_sync_done) && (&tx_fsm_reset_done) && (&pll_lock);

      v6_gtx_wrapper v6_gtx_wrapper (
        .refclk_n          (refclk_n),
        .refclk_p          (refclk_p),
        .clock_160         (clock_160),
        .gtx_txoutclk      (),
        .TXN_OUT           (trg_tx_n),
        .TXP_OUT           (trg_tx_p),
        .GTX0_TXCHARISK_IN (trg_tx_isk[0]),
        .GTX1_TXCHARISK_IN (trg_tx_isk[1]),
        .GTX2_TXCHARISK_IN (trg_tx_isk[2]),
        .GTX3_TXCHARISK_IN (trg_tx_isk[3]),
        .GTX0_TXDATA_IN    (trg_tx_data[0]),
        .GTX1_TXDATA_IN    (trg_tx_data[1]),
        .GTX2_TXDATA_IN    (trg_tx_data[2]),
        .GTX3_TXDATA_IN    (trg_tx_data[3]),
        .tx_resetdone_o    (tx_fsm_reset_done),
        .gtx_tx_sync_done  (tx_sync_done),
        .pll_lock          (pll_lock),
        .realign           (mgt_realign),
        .plltxreset_in     (pll_reset),                     // This port resets the TX PLL of the GTX transceiver when driven High.
                                                            // It affects the clock generated from the TX PMA. When this reset is
                                                            // asserted or deasserted, TXRESET must also be asserted or deasserted.
        .gttx_reset_in     (mgt_reset[3:0]),                // This port is driven High and then deasserted to start the full TX GTX
                                                            // transceiver reset sequence. This sequence takes about 120 µs to
                                                            // complete and systematically resets all subcomponents of the GTX
                                                            // transceiver TX.
                                                            // If the RX PLL is supplying the clock for the TX datapath,
                                                            // GTXTXRESET and GTXRXRESET must be tied together. In addition,
                                                            // the transmitter reference clock must also be supplied (see Reference Clock Selection, page 102)
        .txenprbstst_in    (tx_prbs_mode),                  // 000: Standard operation mode (test pattern generation is OFF)
                                                            // 001: PRBS-7
                                                            // 010: PRBS-15
                                                            // 011: PRBS-23
                                                            // 100: PRBS-31
                                                            // 101: PCI Express compliance pattern. Only works with 20-bit mode
                                                            // 110: Square wave with 2 UI (alternating 0’s/1’s)
                                                            // 111: Square wave with 16 UI or 20 UI period (based on data width)
        .txreset_in (txreset),                              // PCS TX system reset. Resets the TX FIFO, 8B/10B encoder and other
                                                            // transmitter registers. This reset is a subset of GTXTXRESET
        .txpowerdown (txpowerdown_mode),                    // 00: P0 (normal operation)
                                                            // 01: P0s (low recovery time power down)
                                                            // 10: P1 (longer recovery time; Receiver Detection still on)
                                                            // 11: P2 (lowest power state)
        .txpllpowerdown (txpllpowerdown),
        .gtxtest_in ({11'b10000000000,gtxtest_reset,1'b0})  // GTXTEST[0]: Reserved. Tied to 0.
                                                            // GTXTEST[1]: The default is 0. When this bit is set to 1, the TX output clock dividers are reset.
                                                            // GTXTEST[12:2]: Reserved. Tied to 10000000000.
      );

  end
  endgenerate

//----------------------------------------------------------------------------------------------------------------------
endmodule
//----------------------------------------------------------------------------------------------------------------------
