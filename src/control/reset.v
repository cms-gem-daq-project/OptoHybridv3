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

  output reg ready_o,
  output reg reset_o
);

  initial reset_o <= 1'b1;
  initial ready_o <= 1'b0;

  wire [3:0] powerup_dly = 4'd8;
  reg powerup_ff  = 0;
  SRL16E u_startup (.CLK(clock_i),.CE(!powerup),.D(mmcms_locked_i),.A0(powerup_dly[0]),.A1(powerup_dly[1]),.A2(powerup_dly[2]),.A3(powerup_dly[3]),.Q(powerup));
  always @(posedge clock_i) powerup_ff <= powerup;
  wire ready = powerup_ff;

  always @(posedge clock_i) reset_o <= !ready;
  always @(posedge clock_i) ready_o <=  ready;

endmodule
