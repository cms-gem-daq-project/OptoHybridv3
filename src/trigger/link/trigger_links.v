module trigger_links_v (

  input mgt_refclk, // 160 MHz QPLL Clock

  input clk_40,
  input clk_80,
  input clk_160,

  input reset,

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

  input overflow
);

wire [55:0] link_r = {cluster3, cluster2, cluster1, cluster0};
wire [55:0] link_l = {cluster7, cluster6, cluster5, cluster4};

wire [55:0] link [3:0];

// to csc
assign link[0] = link_r;  // CR (CSC right link)
assign link[1] = link_l;  // CL (csc left link)

// to utca
assign link[2] = link_r;  // GR (GEM right link)
assign link[3] = link_l;  // GL (GEM left link)

wire [3:0] tx_out_clk;
wire [3:0] tx_pll_locked;

SRL16E #(.INIT(16'h7FFF)) SRL16TXPLL(
  .Q(txpll_rst), .A0(1'b1), .A1(1'b1), .A2(1'b1), .A3(1'b1), .CE (1'b1), .CLK(clk_40), .D(1'b0)
);

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

  .TRG_TX_REFCLK       (mgt_refclk),          // QPLL 160 from MGT clk
  .TRG_TXUSRCLK        (usrclk),              // get 160 from TXOUTCLK (times 2)
  .TRG_CLK80           (usrclk2),             // get 80 from TXOUTCLK
  .TRG_GTXTXRST        (1'b0),                // maybe Manual "reset" only
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
