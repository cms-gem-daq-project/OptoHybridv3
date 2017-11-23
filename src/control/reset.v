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


  reg [5:0] reset_hold = -1;

  initial reset_o <= 1'b1;

  reg reset_start=1'b1;
  always @ (posedge clock_i)
    reset_start <= soft_reset || ~(mmcms_locked_i && gbt_rxready_i && gbt_rxvalid_i && gbt_txready_i);

  always @ (posedge clock_i)
    if (reset_start)
      reset_hold <= -1;
    else if (reset_hold != 0)
      reset_hold <= reset_hold - 1'b1;

  wire ready = (reset_hold == 0);

  always @(posedge clock_i)
    reset_o <= !ready;

endmodule
