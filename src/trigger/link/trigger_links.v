module trigger_links (

  input mgt_clk_p, // 160 MHz Reference Clock
  input mgt_clk_n, // 160 MHz Reference Clock

  input clk_40,
  input clk_80,
  input clk_160,

  input reset_i,

  output [3:0] trg_tx_p,
  output [3:0] trg_tx_n,

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

  output [7:0] valid_clusters,

  output       valid_clusters_or,

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

IBUFDS_GTXE1 ibufds_mgt
(
    .I       (mgt_clk_p),
    .IB      (mgt_clk_n),
    .O       (mgt_refclk),
    .ODIV2   (),
    .CEB     (1'b0)
);

wire [55:0] link_r = {cluster3, cluster2, cluster1, cluster0};
wire [55:0] link_l = {cluster7, cluster6, cluster5, cluster4};

assign valid_clusters[0] = ~(cluster0[10:9]==2'b11);
assign valid_clusters[1] = ~(cluster1[10:9]==2'b11);
assign valid_clusters[2] = ~(cluster2[10:9]==2'b11);
assign valid_clusters[3] = ~(cluster3[10:9]==2'b11);
assign valid_clusters[4] = ~(cluster4[10:9]==2'b11);
assign valid_clusters[5] = ~(cluster5[10:9]==2'b11);
assign valid_clusters[6] = ~(cluster6[10:9]==2'b11);
assign valid_clusters[7] = ~(cluster7[10:9]==2'b11);

assign valid_clusters_or = |valid_clusters;

wire [55:0] link [3:0];

// to csc
assign link[0] = link_r;  // CR (CSC right link)
assign link[1] = link_l;  // CL (csc left link)

// to utca
assign link[2] = link_r;  // GR (GEM right link)
assign link[3] = link_l;  // GL (GEM left link)

wire [3:0] tx_out_clk;
wire [3:0] tx_pll_locked;

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

genvar igem;
generate
for (igem=0; igem<4; igem=igem+1'b1) begin: gemgen
gem_fiber_out  gem_fibers_out   (
  .RST                 (1'b0),           // Manual only
  .TRG_SIGDET          (),               // from IPAD to IBUF.  N/A?
  .TRG_TDIS            (),               // OBUF output, for what?  N/A?
  .TRG_TX_P            (trg_tx_p[igem]), // pick a fiber
  .TRG_TX_N            (trg_tx_n[igem]), // pick a fiber

  .GEM_DATA            (link[igem][55:0]),
  .GEM_OVERFLOW        (overflow),

  .BXN_COUNTER         (bxn_counter),
  .BC0                 (ttc_bx0),

  .TRG_TX_REFCLK       (mgt_refclk),             // QPLL 160 from MGT clk
  .TRG_TXUSRCLK        (usrclk),              // get 160 from TXOUTCLK (times 2)
  .TRG_CLK80           (usrclk2),             // get 80 from TXOUTCLK
  .TRG_GTXTXRST        (txpll_rst),           // maybe Manual "reset" only
  .TRG_TX_PLLRST       (txpll_rst),           // Tie LOW.
  .TRG_RST             (reset),               // gtx_reset =  PBrst | !TxSyncDone | !RxSyncDone
  .ENA_TEST_PAT        (1'b0),                // HIGH for PRBS! (Low will send data from GxC registers)  Use This Later, send low-rate pattern.
  .INJ_ERR             (1'b0),                // use my switch/PB combo logic for this, high-true? Pulse high once.
  .TRG_TXOUTCLK        (tx_out_clk[igem]),    // 80 MHz; This has to go to MCM to generate 160/80
  .TRG_TX_PLL_LOCK     (tx_pll_locked[igem]), // inverse holds the MCM in Reset; Tx GTX PLL Ref lock
  .TRG_TXRESETDONE     (),                    // N/A
  .TX_SYNC_DONE        (),                    // not used in DCFEB tests
  .STRT_LTNCY          (),                    // after every Reset, to TP for debug only  -- !sw7 ?
  .LTNCY_TRIG          (),                    // bring out to TP.  Signals when TX sends "FC" (once every 128 BX).  Send raw to TP  --sw8,7
  .MON_TX_SEL          (),                    // N/A
  .MON_TRG_TX_ISK      (),                    // N/A returns 4 bits
  .MON_TRG_TX_DATA     ()                     // N/A returns 32 bits
);
end
endgenerate

//------------------------------------------------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------------------------------------------
