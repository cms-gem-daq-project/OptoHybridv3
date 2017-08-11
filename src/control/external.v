//--------------------------------------------------------------------------------
// CMS Muon Endcap
// GEM Collaboration
// Optohybrid v3 Firmware -- Stupid HDMI Controller
// T. Lenzi, A. Peck
//--------------------------------------------------------------------------------
// Description:
//   This module controls the HDMI outputs to provide programmable combinations
//   of S-bits
//--------------------------------------------------------------------------------
// 2017/07/24 -- Initial port to version 3 electronics
// 2017/07/25 -- Port to Verilog
// 2017/07/25 -- Clear synthesis warnings from module
// 2017/08/10 -- Add reset and fanout
//--------------------------------------------------------------------------------

module external (

  input clock,

  input reset_i,

  //Sbits

  input [23:0] active_vfats_i,
  input [1:0]  sys_sbit_mode_i,
  input [29:0] sys_sbit_sel_i,

  output reg [5:0]  ext_sbits_o

);

  reg reset=0;
  always @(posedge clock)
    reset <= reset_i;

  wire [23:0] ors = active_vfats_i;

  reg  [ 7:0] eta_row;
  reg  [ 5:0] sector_row;
  reg  [ 4:0] sbits_sel [5:0];

  // SBits output

  genvar j;
  generate
  for (j=0; j<8; j=j+1) begin: zerotoseven
    always @(posedge clock)
      eta_row[j] <= ors[j] || ors[8+j] || ors[16+j];
  end
  endgenerate


  generate
  for (j=0; j<6; j=j+1) begin: zerotofive

    always @(posedge clock) begin
      if (reset) begin
        sector_row[j] <= 0;
        sbits_sel [j] <= 0;
      end
      else begin
        sector_row[j] <= ors[j*4] || ors[j*4+1] || ors[j*4+2] || ors[j*4+3];
        sbits_sel [j] <= sys_sbit_sel_i[(j*5+4):(j*5)];
      end

    end

    always @(posedge clock) begin
      if (reset) begin
        ext_sbits_o[j] <= 0;
      end
      else begin
        case (sys_sbit_mode_i)
          2'b00: ext_sbits_o[j] <= ors        [sbits_sel[j]];
          2'b01: ext_sbits_o[j] <= eta_row    [sbits_sel[j]];
          2'b10: ext_sbits_o[j] <= sector_row           [j];
          2'b00: ext_sbits_o[j] <= 6'h0;
        endcase
      end
    end

  end
  endgenerate

endmodule
