//--------------------------------------------------------------------------------
// CMS Muon Endcap
// GEM Collaboration
// Optohybrid v3 Firmware -- Reset
// A. Peck
//--------------------------------------------------------------------------------
// Description:
//   This module provides a synchronized reset pulse on startup after the MMCMs lock
//--------------------------------------------------------------------------------
// 2017/08/01 -- Initial
// 2019/04/25 -- Cleanup source
//--------------------------------------------------------------------------------

module reset (

  input clock_i,

  input soft_reset,

  input mmcms_locked_i,

  input gbt_rxready_i,
  input gbt_rxvalid_i,
  input gbt_txready_i,

  output core_reset_o,
  output reset_o
);

  parameter MXRESETB = 10;
  reg [MXRESETB-1:0] soft_reset_delay = 0;
  reg soft_reset_start=0;


  // delay soft_reset by ~256 bx to give time for the system to send a wishbone response before resetting
  // to prevent backend from crashing
  always @(posedge clock_i) begin

    // strobe soft_reset for 1 clock cycle
    soft_reset_start <= (soft_reset_delay == 'd1);

    if (soft_reset)
      soft_reset_delay <= 'd1023;
    else if (soft_reset_delay != 0)
      soft_reset_delay <= soft_reset_delay - 1'b1;
  end

  //--------------------------------------------------------------------------------------------------------------------
  // Hold (Long) Reset
  //--------------------------------------------------------------------------------------------------------------------

  parameter HOLD_RESET_CNT_MAX = 2**22-1;
  parameter HOLD_RESET_BITS    = $clog2 (HOLD_RESET_CNT_MAX);

  reg [HOLD_RESET_BITS-1:0] hold_reset_cnt = 0;

  always @ (posedge clock_i) begin
    if ((soft_reset_start) || ~(mmcms_locked_i && gbt_rxready_i && gbt_rxvalid_i && gbt_txready_i))
      hold_reset_cnt <= 0;
    else if (hold_reset_cnt < HOLD_RESET_CNT_MAX)
      hold_reset_cnt <= hold_reset_cnt + 1'b1;
    else
      hold_reset_cnt <= hold_reset_cnt;
  end

  assign reset_o = (hold_reset_cnt < HOLD_RESET_CNT_MAX);

  //--------------------------------------------------------------------------------------------------------------------
  // Startup (Short) Reset
  //--------------------------------------------------------------------------------------------------------------------

  parameter STARTUP_RESET_CNT_MAX = 2**5-1;
  parameter STARTUP_RESET_BITS    = $clog2 (STARTUP_RESET_CNT_MAX);

  reg [STARTUP_RESET_BITS-1:0] startup_reset_cnt = 0;

  always @ (posedge clock_i) begin
    if (~(mmcms_locked_i && gbt_rxready_i && gbt_rxvalid_i && gbt_txready_i))
      startup_reset_cnt <= 0;
    else if (startup_reset_cnt < STARTUP_RESET_CNT_MAX)
      startup_reset_cnt <= startup_reset_cnt + 1'b1;
    else
      startup_reset_cnt <= startup_reset_cnt;
  end

  assign core_reset_o = (hold_reset_cnt < STARTUP_RESET_CNT_MAX);

endmodule
