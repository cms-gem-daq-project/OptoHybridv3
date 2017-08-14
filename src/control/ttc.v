//--------------------------------------------------------------------------------
// CMS Muon Endcap
// GEM Collaboration
// Optohybrid v3 Firmware -- TTC
// A. Peck
//--------------------------------------------------------------------------------
// Description:
//
//    Bunch Crossing Counter:
//      Increments by 1 every clock cycle, runs from 0 to 3563.
//      Resets to bxn_preset value when resync or bxreset is received.
//      Bxn_preset is likely to be the L0 latency of 160 cycles.
//      If bunch crossing 0 (bx0) does not arrive when the count is bxn_preset, the sync_err bit is set.
//      Latch BXN at pre-trigger and again at L1A for DMB header.
//
//--------------------------------------------------------------------------------
// 2017/08/03 -- Initial port from TMB sequencer
// 2017/08/07 -- Add bc0 counters (local and received)
//--------------------------------------------------------------------------------

module ttc (

  input clock,

  input reset,

  input ttc_bx0,

  input ttc_resync,

  input  [MXBXN-1:0] bxn_offset, // BXN offset at reset

  output reg [MXCNT-1:0] orbit_counter,
  output reg [MXBXN-1:0] bxn_counter,

  output reg [MXCNT-1:0] bx0_counter_lcl,
  output reg [MXCNT-1:0] bx0_counter_rxd,

  output     bx0_sync_err, // sync error on bx0
  output reg bxn_sync_err  // bunch counter sync error

);

  parameter        MXBXN     = 12;       // Number BXN bits, LHC bunchs numbered 0 to 3563
  parameter [12:0] LHC_CYCLE = 12'd3564; // LHC period, max BXN count+1
  parameter        MXCNT     = 32;       // Maximum counter length
  parameter        MXUPT     = 16;       // Maximum counter length

  // Bunch Crossing Counter, counts 0 to 3563, presets at resync or bxreset, stops counting, resumes at bx0

  //--------------------------------------------------------------------------------------------------------------------
  // Restrict bxn offsets to be in the interval 0 < LHC_CYCLE to prevent non-physical bxns
  //--------------------------------------------------------------------------------------------------------------------

  reg [MXBXN-1:0] bxn_offset_lim     = 0;

  always @(posedge clock) begin
    bxn_offset_lim <= (bxn_offset >= LHC_CYCLE) ? (LHC_CYCLE-1'b1) : (bxn_offset);
  end

  //--------------------------------------------------------------------------------------------------------------------
  // hold the bunch crossing counter until the first bx0 is received
  //--------------------------------------------------------------------------------------------------------------------
  reg bxn_hold = 1'b1;
  always @(posedge clock) begin
    if      ( reset   ) bxn_hold <= 1; // Count hold FF
    else if ( ttc_bx0 ) bxn_hold <= 0;
  end

  //--------------------------------------------------------------------------------------------------------------------
  // bxn counter should restore to its preset value if it is being held or a resync is received
  //--------------------------------------------------------------------------------------------------------------------

  wire bxn_preset = (bxn_hold || ttc_resync) && !ttc_bx0;   // Load bxn offset value

  //--------------------------------------------------------------------------------------------------------------------
  // Max value overflow
  //--------------------------------------------------------------------------------------------------------------------

  wire bxn_ovf = bxn_counter == LHC_CYCLE[11:0]-1;      // BXN maximum count for pretrig bxn counter

  //--------------------------------------------------------------------------------------------------------------------
  // BXN Counter
  //--------------------------------------------------------------------------------------------------------------------

  initial bxn_counter  = 0;

  always @(posedge clock) begin
    if      (bxn_preset) bxn_counter  <= bxn_offset_lim;  // Counter
    else if (bxn_ovf   ) bxn_counter  <= 0;
    else                 bxn_counter  <= bxn_counter+1'b1;
  end

  //--------------------------------------------------------------------------------------------------------------------
  // Synchronization
  //--------------------------------------------------------------------------------------------------------------------

  initial bxn_sync_err = 0;

  wire bxn_sync = bxn_counter == bxn_offset_lim; // BXN now at offset value (i.e. local bx0)

  wire bx0_local = bxn_counter == 0; // This TMBs bxn is at 0

  always @(posedge clock) begin
    if      (bxn_preset)  bxn_sync_err <= 0; // Sync err latch if count isnt at offset on ttc_bx0
    else if (ttc_bx0   )  bxn_sync_err <= !bxn_sync || bxn_sync_err;
    else if (bxn_sync  )  bxn_sync_err <= !ttc_bx0  || bxn_sync_err;
  end

  assign bx0_sync_err = bxn_sync_err || bxn_preset; // single clock strobe of sync error at bx0

  //--------------------------------------------------------------------------------------------------------------------
  // BX0 Counters
  //--------------------------------------------------------------------------------------------------------------------

  initial bx0_counter_rxd = 0;
  initial bx0_counter_lcl = 0;

  always @(posedge clock) begin

      if      (ttc_resync) bx0_counter_rxd = 0;
      else if (ttc_bx0)    bx0_counter_rxd = bx0_counter_rxd + 1'b1;

      if      (ttc_resync) bx0_counter_lcl = 0;
      else if (bx0_local)  bx0_counter_lcl = bx0_counter_lcl + 1'b1;

  end

  //--------------------------------------------------------------------------------------------------------------------
  // Orbit Counter
  //--------------------------------------------------------------------------------------------------------------------

  // counts bx0s from bx counter

  initial orbit_counter = 0;

  wire orbit_cnt_reset = ttc_resync;
  wire orbit_cnt_ovf   = (orbit_counter == {MXCNT{1'b1}});
  wire orbit_cnt_en    = bxn_ovf && !orbit_cnt_ovf;

  always @(posedge clock) begin
    if      (orbit_cnt_reset) orbit_counter=0;
    else if (orbit_cnt_en   ) orbit_counter=orbit_counter+1'b1;
  end

endmodule
