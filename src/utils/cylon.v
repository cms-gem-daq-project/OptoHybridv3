`timescale 1ns / 1ps
//`define DEBUG_CYLON1 1
//--------------------------------------------------------------------------------------------------------------
//  Cylon sequence generator, one eye
//
//  10/01/2003  Initial
//  09/28/2006  Mod xst remove output ff, inferred ROM is already registered
//  10/10/2006  Replace init ff with srl
//  05/21/2007  Rename cylon9 to cylon1 to distinguish from 2-eye, add rate
//  08/11/2009  Replace 10MHz clock_vme with  40MHz clock, increase prescale counter by 2 bits
//  04/22/2010  Port to ise 11, add FF to srl output to sync with gsr
//  07/09/2010  Port to ise 12
//  07/24/2017  Expand to 12 bit for optohybrid
//  07/25/2017  Flop the q output
//--------------------------------------------------------------------------------------------------------------
  module cylon1 (clock,rate,q);

// Ports
  input               clock;
  input       [1:0]   rate;
  output  reg [11:0]  q;

// Initialization
  wire [3:0] pdly  = 0;
  reg        ready = 0;
  wire       idly;

  SRL16E uinit (.CLK(clock),.CE(!idly),.D(1'b1),.A0(pdly[0]),.A1(pdly[1]),.A2(pdly[2]),.A3(pdly[3]),.Q(idly));

  always @(posedge clock) begin
  ready <= idly;
  end

// Scale clock down below visual fusion
  `ifndef DEBUG_CYLON1
  parameter MXPRE = 21;  `else
  parameter MXPRE = 2;
  `endif

  reg  [MXPRE-1:0] prescaler  = 0;
  wire [MXPRE-1:0] full_scale = {MXPRE{1'b1}};

  always @(posedge clock) begin
  if (ready)
  prescaler <= prescaler + rate + 1'b1;
  end

  wire next_adr = (prescaler==full_scale);

// ROM address pointer runs 0 to 13
  reg  [4:0] adr = 23;

  wire last_adr = (adr==22);

  always @(posedge clock) begin
  if (next_adr) begin
  if (last_adr) adr <= 0;
  else          adr <= adr + 1'b1;
  end
  end

// Display pattern ROM
  reg  [11:0] rom;

  always @(adr) begin
  case (adr)
  5'd0:  rom   <= 12'b000000000001;
  5'd1:  rom   <= 12'b000000000010;
  5'd2:  rom   <= 12'b000000000100;
  5'd3:  rom   <= 12'b000000001000;
  5'd4:  rom   <= 12'b000000010000;
  5'd5:  rom   <= 12'b000000100000;
  5'd6:  rom   <= 12'b000001000000;
  5'd7:  rom   <= 12'b000010000000;
  5'd8:  rom   <= 12'b000100000000;
  5'd9:  rom   <= 12'b001000000000;
  5'd10: rom   <= 12'b010000000000;
  5'd11: rom   <= 12'b100000000000;
  5'd12: rom   <= 12'b010000000000;
  5'd13: rom   <= 12'b001000000000;
  5'd14: rom   <= 12'b000100000000;
  5'd15: rom   <= 12'b000010000000;
  5'd16: rom   <= 12'b000001000000;
  5'd17: rom   <= 12'b000000100000;
  5'd18: rom   <= 12'b000000010000;
  5'd19: rom   <= 12'b000000001000;
  5'd20: rom   <= 12'b000000000100;
  5'd21: rom   <= 12'b000000000010;
  5'd22: rom   <= 12'b000000000001;
  5'd23: rom   <= 12'b111111111111;
  default: rom <= 12'b101010101010;
  endcase
  end

  always @(posedge clock) begin
    q <= rom;
  end

//--------------------------------------------------------------------------------------------------------------
  endmodule
//--------------------------------------------------------------------------------------------------------------
