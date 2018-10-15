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

  input soft_reset,

  input mmcms_locked_i,

  input gbt_rxready_i,
  input gbt_rxvalid_i,
  input gbt_txready_i,

  output reg reset_o
);

parameter MXRESETB = 10;
reg [MXRESETB-1:0] soft_reset_delay = 0;
reg soft_reset_start=0;


// delay soft_reset by ~256 bx to give time for the system to send a wishbone response before resetting
always @(posedge clock_i) begin

  // strobe soft_reset for 1 clock cycle
  soft_reset_start <= (soft_reset_delay == 'd1);

  if (soft_reset)
    soft_reset_delay <= 'd1023;
  else if (soft_reset_delay != 0)
    soft_reset_delay <= soft_reset_delay - 1'b1;
end


  reg [5:0] reset_hold = -1;

  initial reset_o <= 1'b1;

  reg reset_start=1'b1;
  always @ (posedge clock_i)
    reset_start <= (soft_reset_start) || ~(mmcms_locked_i && gbt_rxready_i && gbt_rxvalid_i && gbt_txready_i);

  always @ (posedge clock_i)
    if (reset_start)
      reset_hold <= -1;
    else if (reset_hold != 0)
      reset_hold <= reset_hold - 1'b1;

  wire ready = (reset_hold == 0);

  always @(posedge clock_i)
    reset_o <= !ready;

endmodule
