`timescale 1ns / 1ps

module   gem_fiber_out #(parameter SIM_SPEEDUP = 0) (
	input         RST,           // PRBS Reset
	input         TRG_SIGDET,    // ??
	output        TRG_TDIS,      // N/A
	output        TRG_TX_N,
	output        TRG_TX_P,

  input [55:0]  GEM_DATA,      // 56 bit GEM data
  input         GEM_OVERFLOW,  //  1 bit GEM has more than 8 clusters

	input         TRG_TX_REFCLK, // 160 MHz Reference Clock from QPLL
	input         TRG_TXUSRCLK,  // 160 MHz (derived from TXOUTCLK)
	input         TRG_CLK80,     // 80  MHz (derived from TXOUTCLK)
	input         TRG_GTXTXRST,  // GTX Transmit Data Reset
	output        TRG_TXOUTCLK,  // 80  MHz GTX clock output
	input         TRG_TX_PLLRST, // use !rxpll_lock ?
	input         TRG_RST,       // Data Reset

	input         INJ_ERR,       // PRBS Error Inject

	input         ENA_TEST_PAT,  // HIGH for PRBS!  (Low will send data from GxC registers)
	output        TRG_TX_PLL_LOCK,
	output        TRG_TXRESETDONE,
	output        TX_SYNC_DONE,
	output        STRT_LTNCY,
	output reg    LTNCY_TRIG,
	output        MON_TX_SEL,
	output [3:0]  MON_TRG_TX_ISK,
	output [31:0] MON_TRG_TX_DATA
);

wire trg_tx_dis;

//Inputs to TRG GTX transmitter
wire [ 3:0] trg_tx_isk;
wire [31:0] trg_tx_data;
wire        tx_dlyaligndisable;
wire        tx_dlyalignreset;
wire        tx_enpmaphasealign;
wire        tx_pmasetphase;
reg         trg_txresetdone_r;
reg         trg_txresetdone_r2;
wire [7:0]  tx_dly_align_mon;
wire        tx_dly_align_mon_ena;
wire [7:0]  frm_sep;
reg  [7:0]  trgcnt;
wire        lt_trg;
reg         rst_tx;


//PRBS signals
parameter MXBITS = 56;
wire [MXBITS-1:0] prbs;
wire [MXBITS-1:0] out_data;

reg         tx_sel;
reg         tx_sel_bar;
wire        prbs_rst;
reg         p_rst1,p_rst2,p_rst3,p_rst4;
reg         p_rst5,p_rst6,p_rst7,p_rst8;

assign MON_TX_SEL           = tx_sel;
assign MON_TRG_TX_ISK       = trg_tx_isk;
assign MON_TRG_TX_DATA      = trg_tx_data;
assign trg_tx_dis           = 1'b0;
assign tx_dly_align_mon_ena = 1'b0;

//----------------------------------------------------------------------------------------------------------------------
// 
//----------------------------------------------------------------------------------------------------------------------

  IBUF IBUF_TRG_SIGDET (.O(TRG_SD),.I(TRG_SIGDET));

  OBUF  #(.DRIVE(12),.IOSTANDARD("DEFAULT"),.SLEW("SLOW")) OBUF_TRG_TDIS (.O(TRG_TDIS),.I(trg_tx_dis));

//----------------------------------------------------------------------------------------------------------------------
// 
//----------------------------------------------------------------------------------------------------------------------

  TRG_TX_BUF_BYPASS # ( .WRAPPER_SIM_GTXRESET_SPEEDUP   (SIM_SPEEDUP))      // Set this to 1 for simulation
  trg_tx_buf_bypass_i (

    //----- Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR ------
    .GTX0_RXN_IN                    (),
    .GTX0_RXP_IN                    (),
    //-------------- Transmit Ports - 8b10b Encoder Control Ports --------------
    .GTX0_TXCHARISK_IN              (trg_tx_isk),
    //---------------- Transmit Ports - TX Data Path interface -----------------
    .GTX0_TXDATA_IN                 (trg_tx_data),
    .GTX0_TXOUTCLK_OUT              (TRG_TXOUTCLK),
    .GTX0_TXUSRCLK_IN               (TRG_TXUSRCLK),
    .GTX0_TXUSRCLK2_IN              (TRG_CLK80),
    //-------------- Transmit Ports - TX Driver and OOB signaling --------------
    .GTX0_TXN_OUT                   (TRG_TX_N),
    .GTX0_TXP_OUT                   (TRG_TX_P),
    //------ Transmit Ports - TX Elastic Buffer and Phase Alignment Ports ------
    .GTX0_TXDLYALIGNDISABLE_IN      (tx_dlyaligndisable),
    .GTX0_TXDLYALIGNMONENB_IN       (tx_dly_align_mon_ena),
    .GTX0_TXDLYALIGNMONITOR_OUT     (tx_dly_align_mon),
    .GTX0_TXDLYALIGNRESET_IN        (tx_dlyalignreset),
    .GTX0_TXENPMAPHASEALIGN_IN      (tx_enpmaphasealign),
    .GTX0_TXPMASETPHASE_IN          (tx_pmasetphase),
    //--------------------- Transmit Ports - TX PLL Ports ----------------------
    .GTX0_GTXTXRESET_IN             (TRG_GTXTXRST),
    .GTX0_MGTREFCLKTX_IN            (TRG_TX_REFCLK),
    .GTX0_PLLTXRESET_IN             (TRG_TX_PLLRST),
    .GTX0_TXPLLLKDET_OUT            (TRG_TX_PLL_LOCK),
    .GTX0_TXRESETDONE_OUT           (TRG_TXRESETDONE)
  );

//---------------------------- TXSYNC module ------------------------------
// Since you are bypassing the TX Buffer in your wrapper, you will need to drive
// the phase alignment ports to align the phase of the TX Datapath. Include
// this module in your design to have phase alignment performed automatically as
// it is done in the example design.

  always @(posedge TRG_CLK80 or negedge TRG_TXRESETDONE) begin
    trg_txresetdone_r  <= (!TRG_TXRESETDONE) ? 1'b0 : TRG_TXRESETDONE; 
    trg_txresetdone_r2 <= (!TRG_TXRESETDONE) ? 1'b0 : trg_txresetdone_r; 
  end

  TX_SYNC #( .SIM_TXPMASETPHASE_SPEEDUP   (SIM_SPEEDUP))
  gtx0_txsync_i (
    .TXENPMAPHASEALIGN  (tx_enpmaphasealign),
    .TXPMASETPHASE      (tx_pmasetphase),
    .TXDLYALIGNDISABLE  (tx_dlyaligndisable),
    .TXDLYALIGNRESET    (tx_dlyalignreset),
    .SYNC_DONE          (TX_SYNC_DONE),
    .USER_CLK           (TRG_CLK80),
    .RESET              (!trg_txresetdone_r2)
  );

//----------------------------------------------------------------------------------------------------------------------
// Transmit data
//----------------------------------------------------------------------------------------------------------------------

  assign out_data    = ENA_TEST_PAT ? {prbs[47:0],prbs[7:0]} : GEM_DATA;

	assign trg_tx_data = rst_tx ? 32'h50BC50BC : (tx_sel ? out_data[55:24] : {out_data[23:0],frm_sep[7:0]});

	assign trg_tx_isk  = rst_tx ?  4'b0101 : (tx_sel ? 4'b0000 : 4'b0001);

  // reset latches
  //---------------------------------------------------
	always @(posedge TRG_CLK80) begin
		rst_tx     <= TRG_RST;
		LTNCY_TRIG <= lt_trg;
	end

  // transmit select
  //---------------------------------------------------
	always @(posedge TRG_CLK80 or posedge TRG_RST) begin
    tx_sel     <= (TRG_RST) ? 1'b1 : ~tx_sel; 
    tx_sel_bar <= (TRG_RST) ? 1'b0 :  tx_sel; 
	end


  //---------------------------------------------------
	always @(posedge TRG_CLK80 or posedge rst_tx) begin
    trgcnt <= (rst_tx) ? 8'h00 : trgcnt+1'b1; 
	end

  //---------------------------------------------------
  //---------------------------------------------------
  assign lt_trg = (!rst_tx && (trgcnt==8'h00)) ? 1'b1 : 1'b0; 

  //---------------------------------------------------
  // we should cycle through these four K-codes:  BC, F7, FB, FD to serve as
  // bunch sequence indicators.when we have more than 8 clusters
  // detected on an OH (an S-bit overflow)
  // we should send the "FC" K-code instead of the usual choice.
  //---------------------------------------------------

  reg [7:0] frame_sep;
  reg [2:0] frame_sep_cnt=0;

  always @(posedge TRG_CLK80) begin
    frame_sep_cnt <= (TRG_GTXTXRST) ? 3'd0 : frame_sep_cnt + 1'b1;
  end

  always @(*) begin
    case (frame_sep_cnt)
      3'd0: frame_sep <= 8'hBC; // bc
      3'd1: frame_sep <= 8'hBC; // bc
      3'd2: frame_sep <= 8'hF7; // f7
      3'd3: frame_sep <= 8'hF7; // f7
      3'd4: frame_sep <= 8'hFB; // fb
      3'd5: frame_sep <= 8'hFB; // fb
      3'd6: frame_sep <= 8'hFD; // fd
      3'd7: frame_sep <= 8'hFD; // fd
    endcase
  end

  assign frm_sep = (GEM_OVERFLOW) ? 8'hFC : frame_sep; 


//----------------------------------------------------------------------------------------------------------------------
// Test pattern reset
//----------------------------------------------------------------------------------------------------------------------

	assign prbs_rst    = RST | TRG_RST | p_rst1 | p_rst2 | p_rst3 | p_rst4 | p_rst5 | p_rst6 | p_rst7 | p_rst8;
	always @(posedge TRG_CLK80) begin
		if (tx_sel_bar) begin
			p_rst1 <= RST | TRG_RST;
			p_rst2 <= p_rst1;
			p_rst3 <= p_rst2;
			p_rst4 <= p_rst3;
			p_rst5 <= p_rst4;
			p_rst6 <= p_rst5;
			p_rst7 <= p_rst6;
			p_rst8 <= p_rst7;
		end
	end

//----------------------------------------------------------------------------------------------------------------------
// Pseudo Random Bit Stream
//----------------------------------------------------------------------------------------------------------------------

	PRBS_tx #(.start_pattern ( 48'hFFFFFF000000))
	tx1 (
		.OUT_CLK_ENA (tx_sel),
		.GEN_CLK     (TRG_CLK80),
		.RST         (prbs_rst),
		.INJ_ERR     (INJ_ERR),
		.PRBS        (prbs[47:0]),
		.STRT_LTNCY  (STRT_LTNCY)
	);

//----------------------------------------------------------------------------------------------------------------------
endmodule
//----------------------------------------------------------------------------------------------------------------------
