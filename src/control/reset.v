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

  input mmcms_locked_i,
  input idlyrdy_i,
  input gbt_rxready_i,
  input gbt_rxvalid_i,
  input gbt_txready_i,

  output core_reset_o,
  output reset_o
);

  parameter MXRESETB = 10;

  //--------------------------------------------------------------------------------------------------------------------
  // Startup (Short) Reset
  //--------------------------------------------------------------------------------------------------------------------

  parameter STARTUP_RESET_CNT_MAX = 2**8-1;
  parameter STARTUP_RESET_BITS    = $clog2 (STARTUP_RESET_CNT_MAX);

  reg [STARTUP_RESET_BITS-1:0] startup_reset_cnt = 0;

  always @ (posedge clock_i) begin
    if (~(idlyrdy_i && mmcms_locked_i && gbt_rxready_i && gbt_rxvalid_i && gbt_txready_i))
      startup_reset_cnt <= 0;
    else if (startup_reset_cnt < STARTUP_RESET_CNT_MAX)
      startup_reset_cnt <= startup_reset_cnt + 1'b1;
    else
      startup_reset_cnt <= startup_reset_cnt;
  end

  assign reset_o = (startup_reset_cnt < STARTUP_RESET_CNT_MAX);

endmodule
