`timescale 1ns / 1ps

module   gem_fiber_out #(
  parameter NLINKS               = 1,
  parameter SIM_SPEEDUP          = 0,
  parameter GE11 = 0,
  parameter GE21  = 0
)
(
  output [NLINKS-1:0]  TRG_TX_N,
  output [NLINKS-1:0]  TRG_TX_P,

  input [55:0]  GEM_DATA,      // 56 bit GEM data
  input         GEM_OVERFLOW,  //  1 bit GEM has more than 8 clusters
  input [11:0]  BXN_COUNTER ,  //  12 bit bxn counter
  input         BC0         ,  //  1  bit bx0 flag

  input         TRG_TX_REFCLK,        // 160 MHz Reference Clock from QPLL
  input         SYSCLK_IN,
  input         MMCM_LOCK_I,
  output        MMCM_RESET_O,

  output TRG_TX_PLL0PLLRST_OUT,
  input  TRG_TX_PLL0OUTCLK_IN,
  input  TRG_TX_PLL0OUTREFCLK_IN,
  input  TRG_TX_PLL0PLLLOCK_IN,
  input  TRG_TX_PLL0PLLREFCLKLOST_IN,
  input  TRG_TX_PLL1OUTCLK_IN,
  input  TRG_TX_PLL1OUTREFCLK_IN,

  input         TRG_TXUSRCLK,      // 160 MHz (derived from TXOUTCLK)
  input         TRG_TXUSRCLK2,     //
  input         TRG_GTXTXRST,      // GTX Transmit Data Reset

  input         TRG_CLK80,         // 80  MHz (derived from TXOUTCLK)
  output        TRG_TXOUTCLK,      // 80  MHz GTX clock output
  input         TRG_TX_PLLRST,     // use !rxpll_lock ?
  input         TRG_RST,           // Data Reset

  input         INJ_ERR,       // PRBS Error Inject

  input         ENA_TEST_PAT,  // HIGH for PRBS!  (Low will send data from GxC registers)
  output        TRG_TX_PLL_LOCK,
  output        TRG_TXRESETDONE,
  output        TX_SYNC_DONE,
  output        STRT_LTNCY,
  output reg    LTNCY_TRIG
);

//----------------------------------------------------------------------------------------------------------------------
// Signals
//----------------------------------------------------------------------------------------------------------------------

//PRBS signals
localparam MXBITS = 56;

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


wire [MXBITS-1:0] prbs;
wire [MXBITS-1:0] out_data;

reg         tx_sel;
reg         tx_sel_bar;
wire        reset_prbs;
reg         p_rst1,p_rst2,p_rst3,p_rst4;
reg         p_rst5,p_rst6,p_rst7,p_rst8;

//----------------------------------------------------------------------------------------------------------------------
//
//----------------------------------------------------------------------------------------------------------------------

assign trg_tx_dis           = 1'b0;
assign tx_dly_align_mon_ena = 1'b0;


  generate

  //------------------------------------------------------------------------------------------------------------------
  // Virtex 6
  //------------------------------------------------------------------------------------------------------------------

  if (GE11) begin

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
      .GTX0_TXUSRCLK2_IN              (TRG_TXUSRCLK2),
      //-------------- Transmit Ports - TX Driver and OOB signaling --------------
      .GTX0_TXN_OUT                   (TRG_TX_N[0]),
      .GTX0_TXP_OUT                   (TRG_TX_P[0]),
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

  end

  //------------------------------------------------------------------------------------------------------------------
  // Artix-7
  //------------------------------------------------------------------------------------------------------------------

  if (GE21) begin

  // txusrclk rate  = line rate / internal datapath width = 3200 / 20 = 160 MHz
  // txusrclk2 rate = txusrclk / 2 (when in 32 or 40 bit) = 80MHz

    wire gt0_gttxreset_in = 1'b0; // tied to GND in exdes
    wire gt0_txuserrdy_in = 1'b1; // tied to VCC in exdes
    wire tx_reset_fsm_done;
    wire rx_reset_fsm_done;

    ila_gem_fiber_out ila_gem_fiber_out_inst (

      .clk     (SYSCLK_IN),

      .probe0  (trg_tx_isk[3:0]),
      .probe1  (TRG_TXRESETDONE),
      .probe2  (trg_tx_data[31:0]),
      .probe3  (tx_reset_fsm_done),
      .probe4  (rx_reset_fsm_done),
      .probe5  (MMCM_LOCK_I),
      .probe6  (MMCM_RESET_O)
    );

    a7_trig_tx_buf_bypass
        a7_trig_tx_buf_bypass_inst     (
            .SYSCLK_IN                       (SYSCLK_IN),
            .SOFT_RESET_TX_IN                (1'b0),
            .DONT_RESET_ON_DATA_ERROR_IN     (1'b0),
            .GT0_TX_FSM_RESET_DONE_OUT       (tx_reset_fsm_done),
            .GT0_RX_FSM_RESET_DONE_OUT       (rx_reset_fsm_done),
            .GT0_DATA_VALID_IN               (1'b1),
            .GT0_TX_MMCM_LOCK_IN             (MMCM_LOCK_I),
            .GT0_TX_MMCM_RESET_OUT           (MMCM_RESET_O),
            //_________________________________________________________________________
            //GT0  (X0Y0)
            //____________________________CHANNEL PORTS________________________________
            //-------------------------- Channel - DRP Ports  --------------------------
            .gt0_drpaddr_in                  (9'd0),
            .gt0_drpclk_in                   (1'd0),
            .gt0_drpdi_in                    (16'd0),
            .gt0_drpdo_out                   (),
            .gt0_drpen_in                    (1'd0),
            .gt0_drprdy_out                  (),
            .gt0_drpwe_in                    (1'd0),
            //------------------- RX Initialization and Reset Ports --------------------
            .gt0_eyescanreset_in             (1'd0),
            //------------------------ RX Margin Analysis Ports ------------------------
            .gt0_eyescandataerror_out        (),
            .gt0_eyescantrigger_in           (1'd0),
            //---------- Receive Ports - RX Decision Feedback Equalizer(DFE) -----------
            .gt0_dmonitorout_out             (),
            //----------- Receive Ports - RX Initialization and Reset Ports ------------
            .gt0_gtrxreset_in                (1'd0),
            .gt0_rxlpmreset_in               (1'd0),
            //------------------- TX Initialization and Reset Ports --------------------
            .gt0_gttxreset_in                (gt0_gttxreset_in),
            .gt0_txuserrdy_in                (gt0_txuserrdy_in),
            //---------------- Transmit Ports - FPGA TX Interface Ports ----------------
            .gt0_txdata_in                   (trg_tx_data),
            .gt0_txusrclk_in                 (TRG_TXUSRCLK),
            .gt0_txusrclk2_in                (TRG_TXUSRCLK2),
            //---------------- Transmit Ports - TX 8B/10B Encoder Ports ----------------
            .gt0_txcharisk_in                (trg_tx_isk),
            //------------- Transmit Ports - TX Configurable Driver Ports --------------
            .gt0_gtptxn_out                  (TRG_TX_N[0]),
            .gt0_gtptxp_out                  (TRG_TX_P[0]),
            //--------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
            .gt0_txoutclk_out                (TRG_TXOUTCLK),
            .gt0_txoutclkfabric_out          (),
            .gt0_txoutclkpcs_out             (),
            //----------- Transmit Ports - TX Initialization and Reset Ports -----------
            .gt0_txresetdone_out             (TRG_TXRESETDONE),
            //____________________________COMMON PORTS________________________________
            .GT0_PLL0OUTCLK_IN               (TRG_TX_PLL0OUTCLK_IN),
            .GT0_PLL0OUTREFCLK_IN            (TRG_TX_PLL0OUTREFCLK_IN),
            .GT0_PLL0RESET_OUT               (TRG_TX_PLL0PLLRST_OUT),
            .GT0_PLL0LOCK_IN                 (TRG_TX_PLL0PLLLOCK_IN),
            .GT0_PLL0REFCLKLOST_IN           (TRG_TX_PLL0PLLREFCLKLOST_IN),
            .GT0_PLL1OUTCLK_IN               (TRG_TX_PLL1OUTCLK_IN),
            .GT0_PLL1OUTREFCLK_IN            (TRG_TX_PLL1OUTREFCLK_IN)
    );

    assign TRG_TX_PLL_LOCK = 1'b1;
    assign TX_SYNC_DONE = 1'b1;
    assign tx_dlyalignreset = 1'b0;
    assign tx_enpmaphasealign = 1'b0;
    assign tx_pmasetphase = 1'b0;

    end
  endgenerate

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

  reg [7:0] frame_sep_lcl;
  reg [7:0] frame_sep_ttc;

  localparam FRAME_CTRL_TTC = 0;

  wire [7:0] frame_sep = FRAME_CTRL_TTC ? frame_sep_ttc : frame_sep_lcl;

  //-local (ttc independent) counter ---------------------------------------------------------------------------------

  reg [2:0] frame_sep_cnt=0;

  always @(posedge TRG_CLK80) begin
    frame_sep_cnt <= (TRG_GTXTXRST) ? 3'd0 : frame_sep_cnt + 1'b1;
  end

  always @(*) begin
    case (frame_sep_cnt)
      3'd0: frame_sep_lcl <= 8'hBC; // bc
      3'd1: frame_sep_lcl <= 8'hBC; // bc
      3'd2: frame_sep_lcl <= 8'hF7; // f7
      3'd3: frame_sep_lcl <= 8'hF7; // f7
      3'd4: frame_sep_lcl <= 8'hFB; // fb
      3'd5: frame_sep_lcl <= 8'hFB; // fb
      3'd6: frame_sep_lcl <= 8'hFD; // fd
      3'd7: frame_sep_lcl <= 8'hFD; // fd
    endcase
  end

  always @(*) begin
    case (BXN_COUNTER[1:0])
      2'd0: frame_sep_ttc <= 8'hBC; // bc
      2'd1: frame_sep_ttc <= 8'hF7; // f7
      2'd2: frame_sep_ttc <= 8'hFB; // fb
      2'd3: frame_sep_ttc <= 8'hFD; // fd
    endcase
  end

  //assign frm_sep = BC0 ? 8'h50 : (GEM_OVERFLOW) ? 8'hFC : frame_sep;
  assign frm_sep = (GEM_OVERFLOW) ? 8'hFC : frame_sep;

//----------------------------------------------------------------------------------------------------------------------
endmodule
//----------------------------------------------------------------------------------------------------------------------
