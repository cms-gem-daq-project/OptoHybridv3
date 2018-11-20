module trigger_links #(
parameter FPGA_TYPE_IS_VIRTEX6 = 0,
parameter FPGA_TYPE_IS_ARTIX7 = 0,
parameter ILINKS = 4

) (

  input mgt_clk_p, // 160 MHz Reference Clock direct from IO
  input mgt_clk_n, // 160 MHz Reference Clock direct from IO

  input clk_40,  // 40  MHz from logic MMCM
  input clk_80,  // 80  MHz from logic MMCM
  input clk_160, // 160 MHz from logic MMCM

  input reset_i,

  output reg [ILINKS-1:0] pll_locked,
  output reg [ILINKS-1:0] reset_done,

  output [ILINKS-1:0] trg_tx_p,
  output [ILINKS-1:0] trg_tx_n,

  input [13:0] cluster0,
  input [13:0] cluster1,
  input [13:0] cluster2,
  input [13:0] cluster3,
  input [13:0] cluster4,
  input [13:0] cluster5,
  input [13:0] cluster6,
  input [13:0] cluster7,

  input [11:0] bxn_counter,
  input        ttc_bx0,

  output reg [7:0] valid_clusters,

  output valid_clusters_or,

  input overflow
);

reg [3:0] reset_cnt;
reg reset;

always @(posedge clk_40) begin
  if (reset_i)
    reset_cnt <= 0;
  else if (~(&reset_cnt))
    reset_cnt <= reset_cnt + 1'b1;
  else
    reset_cnt <= reset_cnt;

  reset <= !(&reset_cnt);
end

wire mgt_refclk;

generate

  //----------------------------------------------------------------------------------------------------------------------
  // Virtex-6
  //----------------------------------------------------------------------------------------------------------------------
  if (FPGA_TYPE_IS_VIRTEX6) begin
    IBUFDS_GTXE1 ibufds_mgt
    (
        .I       (mgt_clk_p),
        .IB      (mgt_clk_n),
        .O       (mgt_refclk),
        .ODIV2   (),
        .CEB     (1'b0)
    );

  end

  //----------------------------------------------------------------------------------------------------------------------
  // Artix-7
  //----------------------------------------------------------------------------------------------------------------------

  if (FPGA_TYPE_IS_ARTIX7) begin
    IBUFDS_GTE2  ibufds_mgtclk0
    (
        .I       (mgt_clk_p ),
        .IB      (mgt_clk_n ),
        .O       (mgt_refclk),
        .ODIV2   (),
        .CEB     (1'b0)
    );

    wire cpll_outclk0;
    wire cpll_outrefclk0;
    wire cpll_plllock;
    wire cpll_refclklost;
    wire cpll_powerdown;
    wire gtp_pllreset_out;
    wire cpll_outclk1;
    wire cpll_outrefclk1;

    wire cpll_reset     = reset || gtp_pllreset_out || cpll_reset;
    wire cpll_refclk_in = mgt_refclk;

    // keep CPLL powered down for some number of clocks
    a7_trig_tx_buf_bypass_cpll_railing #( .USE_BUFG(0))
    cpll_railing_pll0_q0_clk0_refclk_i (
      .cpll_reset_out (cpll_reset),
      .cpll_pd_out    (cpll_powerdown),
      .refclk_out     (),
      .refclk_in      (cpll_refclk_in)
    );

    a7_trig_tx_buf_bypass_common #(
      .WRAPPER_SIM_GTRESET_SPEEDUP ("FALSE"),
      .SIM_PLL0REFCLK_SEL          (3'b001),
      .SIM_PLL1REFCLK_SEL          (3'b001)
    ) common0_i (
      .PLL0LOCKDETCLK_IN  (clk_40),
      .PLL0RESET_IN       (cpll_reset),
      .PLL0REFCLKSEL_IN   (3'b001),
      .PLL0PD_IN          (cpll_powerdown),
      .GTREFCLK0_IN       (mgt_refclk),
      .GTREFCLK1_IN       (1'b0),
      .PLL0OUTCLK_OUT     (cpll_outclk0),
      .PLL0OUTREFCLK_OUT  (cpll_outrefclk0),
      .PLL0LOCK_OUT       (cpll_plllock),
      .PLL0REFCLKLOST_OUT (cpll_refclklost),
      .PLL1OUTCLK_OUT     (cpll_outclk1),
      .PLL1OUTREFCLK_OUT  (cpll_outrefclk1)
    );

  end
endgenerate

wire [55:0] link_r = {cluster3, cluster2, cluster1, cluster0};
wire [55:0] link_l = {cluster7, cluster6, cluster5, cluster4};

always @(posedge clk_40) begin
 valid_clusters[0] <= ~(cluster0[10:9]==2'b11);
 valid_clusters[1] <= ~(cluster1[10:9]==2'b11);
 valid_clusters[2] <= ~(cluster2[10:9]==2'b11);
 valid_clusters[3] <= ~(cluster3[10:9]==2'b11);
 valid_clusters[4] <= ~(cluster4[10:9]==2'b11);
 valid_clusters[5] <= ~(cluster5[10:9]==2'b11);
 valid_clusters[6] <= ~(cluster6[10:9]==2'b11);
 valid_clusters[7] <= ~(cluster7[10:9]==2'b11);
end

assign valid_clusters_or = |valid_clusters;

reg [55:0] link [3:0];

always @(*) begin
  // to csc
  link[0] <= link_r;  // CR (CSC right link)
  link[1] <= link_l;  // CL (csc left link)

  // to utca
  link[2] <= link_r;  // GR (GEM right link)
  link[3] <= link_l;  // GL (GEM left link)
end

wire [3:0] tx_out_clk;
wire [3:0] tx_pll_locked;
wire [3:0] tx_resetdone;

reg [3:0] txpll_rst_cnt = 0;
reg txpll_rst=0;

always @(posedge clk_80) begin
  if (reset)
    txpll_rst_cnt <= 0;
  else if (!(&txpll_rst_cnt))
    txpll_rst_cnt <= txpll_rst_cnt + 1'b1;

  txpll_rst <= !(&txpll_rst_cnt);
end

wire usrclk  = clk_160;
wire usrclk2 = clk_80;

always @(posedge clk_80) begin
  reset_done <= tx_resetdone;
  pll_locked <= tx_pll_locked;
end

localparam ILINKS_PER_MODULE = 1;
localparam IMODULES          = ILINKS / ILINKS_PER_MODULE;

genvar igem;
generate

  wire [3:0] mgt_refclk_array = FPGA_TYPE_IS_VIRTEX6 ? {4{mgt_refclk}} : 4'd0;

  for (igem=0; igem<IMODULES; igem=igem+1'b1) begin: gemgen
  gem_fiber_out  #(
    .FPGA_TYPE_IS_VIRTEX6 (FPGA_TYPE_IS_VIRTEX6),
    .FPGA_TYPE_IS_ARTIX7  (FPGA_TYPE_IS_ARTIX7),
    .NLINKS               (ILINKS_PER_MODULE)
  )
  gem_fibers_out   (

      .TRG_TX_P            (trg_tx_p[(igem+1)*ILINKS_PER_MODULE-1:igem*ILINKS_PER_MODULE]), // pick a fiber
      .TRG_TX_N            (trg_tx_n[(igem+1)*ILINKS_PER_MODULE-1:igem*ILINKS_PER_MODULE]), // pick a fiber
      .GEM_DATA            (link[igem][55:0]),                                              //
      .GEM_OVERFLOW        (overflow),                                                      //
      .BXN_COUNTER         (bxn_counter),                                                   //
      .BC0                 (ttc_bx0),                                                       //
      .TRG_TX_REFCLK       (mgt_refclk_array[igem]),                                        // QPLL 160 from MGT clk
      .TRG_TXUSRCLK        (usrclk),                                                        // get 160 from TXOUTCLK (times 2)
      .TRG_TXUSRCLK2       (usrclk2),                                                       // get 80 from TXOUTCLK
      .TRG_CLK80           (usrclk2),                                                       // get 80 from TXOUTCLK
      .TRG_GTXTXRST        (txpll_rst),                                                     // maybe Manual "reset" only
      .TRG_TX_PLLRST       (txpll_rst),                                                     // Tie LOW.
      .TRG_RST             (reset),                                                         // gtx_reset =  PBrst | !TxSyncDone | !RxSyncDone
      .ENA_TEST_PAT        (1'b0),                                                          // HIGH for PRBS! (Low will send data from GxC registers)  Use This Later, send low-rate pattern.
      .INJ_ERR             (1'b0),                                                          // use my switch/PB combo logic for this, high-true? Pulse high once.
      .TRG_TXOUTCLK        (tx_out_clk[igem]),                                              // 80 MHz; This has to go to MCM to generate 160/80
      .TRG_TX_PLL_LOCK     (tx_pll_locked[igem]),                                           // inverse holds the MCM in Reset; Tx GTX PLL Ref lock
      .TRG_TXRESETDONE     (tx_resetdone[igem]),                                            // N/A
      .TX_SYNC_DONE        (),                                                              // not used in DCFEB tests
      .STRT_LTNCY          (),                                                              // after every Reset, to TP for debug only  -- !sw7 ?
      .LTNCY_TRIG          (),                                                              // bring out to TP.  Signals when TX sends "FC" (once every 128 BX).  Send raw to TP  --sw8,7

      .TRG_TX_PLL0PLLRST_OUT       (gtp_pllreset_out),
      .TRG_TX_PLL0PLLLOCK_IN       (cpll_plllock),
      .TRG_TX_PLL0PLLREFCLKLOST_IN (cpll_refclklost),
      .TRG_TX_PLL0OUTCLK_IN        (cpll_outclk0),
      .TRG_TX_PLL0OUTREFCLK_IN     (cpll_outrefclk0),
      .TRG_TX_PLL1OUTCLK_IN        (cpll_outclk1),
      .TRG_TX_PLL1OUTREFCLK_IN     (cpll_outrefclk1)
  );
  end

endgenerate

//------------------------------------------------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------------------------------------------
