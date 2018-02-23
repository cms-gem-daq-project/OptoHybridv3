`timescale 1ns / 100 ps

module sca_control (

  input clock,

  input reset_i,

  input [2:0] sca_ctl,

  output reg tx_sync_mode,
  output reg gbt_loopback_mode,
  output reg led_sync_mode

);

reg reset=1;
always @(posedge clock) begin
  reset <= reset_i;
end


parameter [2:0] set_tx_sync_mode      = 3'd1;
parameter [2:0] set_gbt_loopback_mode = 3'd2;
parameter [2:0] set_led_sync_mode     = 3'd3;
parameter [2:0] rsvrd0                = 3'd4;
parameter [2:0] rsvrd1                = 3'd5;
parameter [2:0] rsvrd2                = 3'd6;
parameter [2:0] rsvrd3                = 3'd7;

reg [2:0] sca_control = 0;
always @(posedge clock) begin
  if (reset) sca_control <= 0;
  else       sca_control <= sca_ctl;
end

always @(posedge clock) begin
  if (reset)
    tx_sync_mode <= 1'b0;
  else if (sca_control==set_tx_sync_mode)
    tx_sync_mode <= 1'b1;
  else
    tx_sync_mode <= 1'b0;
end

always @(posedge clock) begin
  if (reset)
    gbt_loopback_mode <= 1'b0;
  else if (sca_control==set_gbt_loopback_mode)
    gbt_loopback_mode <= 1'b1;
  else
    gbt_loopback_mode <= 1'b0;
end

always @(posedge clock) begin
  if (reset)
    led_sync_mode <= 1'b0;
  else if (sca_control==set_led_sync_mode || sca_control==set_gbt_loopback_mode)
    led_sync_mode <= 1'b1;
  else
    led_sync_mode <= 1'b0;
end

//----------------------------------------------------------------------------------------------------------------------
endmodule
//----------------------------------------------------------------------------------------------------------------------

