//--------------------------------------------------------------------------------
// CMS Muon Endcap
// GEM Collaboration
// Optohybrid v3 Firmware -- FMM
// A. Peck
//--------------------------------------------------------------------------------
// Description:
//
//    Bunch Crossing Counter:
//       Increments by 1 every clock cycle, runs from 0 to 3563.
//      Resets to bxn_preset value when resync or bxreset is received.
//      Bxn_preset is likely to be the L0 latency of 160 cycles.
//      If bunch crossing 0 (bx0) does not arrive when the count is bxn_preset, the sync_err bit is set.
//      Latch BXN at pre-trigger and again at L1A for DMB header.
//
//--------------------------------------------------------------------------------
// 2017/08/03 -- Initial port from TMB CCB Logic
//--------------------------------------------------------------------------------

module fmm (

  // clock & reset
  input clock,
  input reset_i,

  // ttc commands
  input ttc_bx0,
  input ttc_resync,

  // control

  input dont_wait,

  // output
  output reg fmm_trig_stop

);

  reg reset=0;
  always @(posedge clock) begin
    reset <= reset_i;
  end

  //-------------------------------------------------------------------------------------------------------------------
  //  FMM Section:
  //-------------------------------------------------------------------------------------------------------------------

  // FMM State Machine Declarations

  reg  [4:0] fmm_sm; // synthesis attribute safe_implementation of fmm_sm is yes;

  parameter fmm_startup  = 0; // synthesis attribute fsm_encoding of fmm_sm is auto;
  parameter fmm_resync   = 1;
  parameter fmm_wait_bx0 = 2;
  parameter fmm_run      = 3;

  // FMM State Machine

  initial fmm_sm = fmm_startup;

  wire startup_done = !reset;

  always @(posedge clock) begin

    // start-up reset
    if (reset)
        fmm_sm <= fmm_startup;

    // re-sync  reset
    else if (ttc_resync)
        fmm_sm <= fmm_resync;

    else begin

      case (fmm_sm)

      // Startup wait
      fmm_startup:
        if (startup_done)
        fmm_sm <= fmm_wait_bx0;

      // Resync
      fmm_resync:
        if (ttc_bx0) // Bx0 arrived 1bx after resync
        fmm_sm <= fmm_run;
        else
        fmm_sm <= fmm_wait_bx0;

      // Wait for bx0 after start_trigger
      fmm_wait_bx0:
        if (ttc_bx0 || dont_wait)
        fmm_sm <= fmm_run;

      // Process triggers
      fmm_run:
        fmm_sm <= fmm_run;

      default:
        fmm_sm <= fmm_startup;
      endcase
    end
  end

  // FMM Control signals
  initial fmm_trig_stop = 1;                  // Power up stop state

  always @(posedge clock) begin
  if   (reset)  fmm_trig_stop <= 1;                   // sync reset
  else          fmm_trig_stop <= (fmm_sm != fmm_run); // Stop clct trigger sequencer
  end

//----------------------------------------------------------------------------------------------------------------------
// Simulation state machine display
//----------------------------------------------------------------------------------------------------------------------

  reg [55:0] fmm_sm_disp;

  always @* begin
  case (fmm_sm)
  fmm_startup:  fmm_sm_disp <= "startup";
  fmm_resync:   fmm_sm_disp <= "resync ";
  fmm_wait_bx0: fmm_sm_disp <= "waitbx0";
  fmm_run:      fmm_sm_disp <= "run    ";
  default       fmm_sm_disp <= "default";
  endcase
  end

endmodule
