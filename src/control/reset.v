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
//--------------------------------------------------------------------------------

module reset (

  input clock_i,

  input mmcms_locked_i,

  input gbt_rxready_i,
  input gbt_rxvalid_i,
  input gbt_txready_i,

  output reg reset_o
);

  initial reset_o <= 1'b1;

  reg reset_start=1'b1;
  always @ (posedge clock_i)
    reset_start <= mmcms_locked_i && gbt_rxready_i && gbt_rxvalid_i && gbt_txready_i;

  wire [3:0] powerup_dly = 4'd8;
  reg powerup_ff  = 0;
  SRL16E u_startup (.CLK(clock_i),.CE(!powerup),.D(reset_start),.A0(powerup_dly[0]),.A1(powerup_dly[1]),.A2(powerup_dly[2]),.A3(powerup_dly[3]),.Q(powerup));
  always @(posedge clock_i) powerup_ff <= powerup;
  wire ready = powerup_ff;

  always @(posedge clock_i) reset_o <= !ready;

endmodule
