`timescale 1ns/1ps
module sr32 (
  input CLK,
  input CE,
  input [4:0] SEL,
  input SI,
  output DO
);

parameter SELWIDTH = 5;
localparam DATAWIDTH = 2**SELWIDTH;
reg [DATAWIDTH-1:0] data;
assign DO = data[SEL];
always @(posedge CLK)
begin
  if (CE == 1'b1)
    data <= {data[DATAWIDTH-2:0], SI};
end
endmodule

//----------------------------------------------------------------------------------------------------------------------
//
//----------------------------------------------------------------------------------------------------------------------


module optohybrid_top_tb;

parameter DDR = 0;

// need to simulate a fast clock for ps delays

reg clk160    = 0;
reg clk12G8   = 0;
reg clk1280   = 0;
reg clk320    = 1;
reg clk40     = 0;
reg clk640    = 0;
reg clk320_90 = 0;

always @* begin
  clk12G8   <= #0.039   ~clk12G8; // 78 ps clock (12.8GHz) to simulate TAP delay
  clk1280   <= #0.390   ~clk1280;
  clk640    <= #0.780   ~clk640;
  clk320    <= #1.560   ~clk320;
  clk160    <= #3.120   ~clk160;
  clk320_90 <= #0.780    clk320;
  clk40     <= # 12.48  ~clk40;
end

wire fastclk_0   =  clk320;
wire fastclk_180 = ~clk320;
wire fastclk_90  =  clk320_90;

reg [2:0] sot_cnt=0; // cnt to 8
wire sotd0 = (sot_cnt==0);

//parameter [127:0] test_pat = 128'hCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC;
parameter [127:0] test_pat = 128'hff00ff00ff00ff00ff00ff00ff00ff00;

reg [7:0] sbits_tx=0;
always @(posedge clk320) begin
  if (sot_cnt==7)
  sbits_tx <= ~sbits_tx;
end

reg [127:0] pat_sr   = test_pat;
always @ (posedge clk1280) begin
  pat_sr [0] <= sbits_tx[sot_cnt];

end

// reg [127:0] pat_sr   = test_pat;
// always @ (posedge clk1280)
//   pat_sr <= {pat_sr[126:0], pat_sr[127]};

always @(posedge clk320)
  sot_cnt <= sot_cnt + 1'b1;


wire [191:0] phase_err;
wire aligner_sump;

wire [1535+1536*DDR:0] sbits;


// apply a delay, opposite to the delay that we we later counteract with TU_POSNEG

wire [191:0] tu_p;

`include "trigger/trig_alignment/tap_delays.v"

genvar ipin;
generate
for (ipin=0; ipin<192; ipin=ipin+1) begin: pinloop
  sr32 srp (clk12G8, 1'b1, 5'd31 - TU_OFFSET [ipin*5+:4],  pat_sr[0], tu_p[ipin]);
end
endgenerate


wire [23:0] sof;

genvar ifat;
generate
for (ifat=0; ifat<24; ifat=ifat+1) begin: fatloop
  sr32 srfp (clk12G8, 1'b1, 5'd31-SOF_OFFSET [ifat*5+:4] - 20*SOF_POSNEG[ifat],  sotd0, sof[ifat]);
  //sr32 srfp (clk12G8, 1'b1, 5'd31 - SOF_OFFSET [ifat*5+:4],  sotd0, sof[ifat]);
end
endgenerate

//----------------------------------------------------------------------------------------------------------------------
//
//----------------------------------------------------------------------------------------------------------------------

// gbt data

wire        wr_en    = 1'b1;
wire        wr_valid = 1'b1;
wire [31:0] address  = {8'h40, 24'h0}; // 32'h0; // write to loopback
reg  [31:0] data     = 32'h12345678;
//reg  [31:0] mask     = 32'hffffffff;
wire [11:0] frame_end= 12'hABC;

wire l1a      = 1'b1;
wire bc0      = 1'b1;
wire resync   = 1'b1;
wire calpulse = 1'b1;

wire [3:0] gbt_ttc = {l1a, calpulse, resync, bc0};

wire [65:0] gbt_packet = {wr_en, wr_valid, address[31:0], data[31:0]};

reg[15:0] gbt_dout;

reg [2:0] gbt_frame=0;

always @(posedge clk40) begin
  case (gbt_frame)
    3'd0: gbt_frame <= 3'd1; // begin
    3'd1: gbt_frame <= 3'd2; // addr
    3'd2: gbt_frame <= 3'd3; // addr
    3'd3: gbt_frame <= 3'd4; // data
    3'd4: gbt_frame <= 3'd5; // data
    3'd5: gbt_frame <= 3'd6; // data
    3'd6: gbt_frame <= 3'd0; // end
  endcase
end


always @(posedge clk40) begin
  case (gbt_frame)
    3'd6: gbt_dout <= {gbt_ttc,wr_valid,wr_en,2'b00,address[31:24]}; // begin
    3'd0: gbt_dout <= {gbt_ttc,                     address[23:12]}; // addr
    3'd1: gbt_dout <= {gbt_ttc,                     address[11:0 ]}; // addr
    3'd2: gbt_dout <= {gbt_ttc, 4'd0,               data   [31:24]}; // data
    3'd3: gbt_dout <= {gbt_ttc,                     data   [23:12]}; // data
    3'd4: gbt_dout <= {gbt_ttc,                     data   [11:0] }; // data
    3'd5: gbt_dout <= {gbt_ttc,                     frame_end     }; // end
  endcase
end

reg [1:0] clk40_sync;

reg [2:0] bit=0;

always @(negedge clk320) begin

  clk40_sync[0] <= clk40;
  clk40_sync[1] <= clk40_sync[0];

  if (clk40_sync[1:0] == 2'b01) // catch the rising edge of clk40
      bit <= 3'd7;
  else
      bit <= bit-1'b1;
end


// Elinks

reg [15:0] to_gbt_1;
reg [15:0] to_gbt;
always @(negedge clk320) begin
  to_gbt_1 <= gbt_dout;
  to_gbt   <= to_gbt_1;
end

wire [1:0] elink_i_p;
assign elink_i_p [1]= to_gbt [bit+8]; // msb first
assign elink_i_p [0]= to_gbt [bit  ]; // msb first

wire [1:0] elink_i_n = ~elink_i_p;

//----------------------------------------------------------------------------------------------------------------------
//
//----------------------------------------------------------------------------------------------------------------------

// 320 MHz clocks. don't know why there are two

wire [1:0] gbt_eclk_p = {2{ clk320}};
wire [1:0] gbt_eclk_n = {2{~clk320}};

// 40 MHz clocks

reg [1:0] gbtclk;
always @(*) begin
  gbtclk[0] <= #6.8  clk40; // logic clock
  gbtclk[1] <= #0.00 clk40; // frame clock
end

wire [1:0] gbt_dclk_p =  gbtclk; // fixed and phase shiftable
wire [1:0] gbt_dclk_n = ~gbtclk;


wire [1:0] elink_o_p;
wire [1:0] elink_o_n;

// SCA IO
wire [3:0] sca_io = {4'b0000};

// HDMI
wire [3:0] hdmi_p = {4'b0000};
wire [3:0] hdmi_n = {4'b0000};

// GBTx Control
wire gbt_txready_i = 1'b1;
wire gbt_rxvalid_i = 1'b1;
wire gbt_rxready_i = 1'b1;

// MGT
wire mgt_clk_p_i =  clk160;
wire mgt_clk_n_i = ~clk160;

wire [23:0] vfat_sof_p =  sof;
wire [23:0] vfat_sof_n = ~sof;

wire [191:0] vfat_sbits_p =  tu_p;
wire [191:0] vfat_sbits_n = ~tu_p;

wire [15:0] led_o;

wire gbt_txvalid_o;

wire [11:0] ext_reset_o;

wire [3:0] mgt_tx_p_o;
wire [3:0] mgt_tx_n_o;

optohybrid_top optohybrid_top (

    .gbt_eclk_p    (gbt_eclk_p),
    .gbt_eclk_n    (gbt_eclk_n),

    .gbt_dclk_p    (gbt_dclk_p),
    .gbt_dclk_n    (gbt_dclk_n),

    // elink      (// elink),

    .elink_i_p     (elink_i_p),
    .elink_i_n     (elink_i_n),

    .elink_o_p     (elink_o_p),
    .elink_o_n     (elink_o_n),

    .sca_io        (sca_io),

    .hdmi_p        (hdmi_p),
    .hdmi_n        (hdmi_n),

    .gbt_txready_i (gbt_txready_i),
    .gbt_rxvalid_i (gbt_rxvalid_i),
    .gbt_rxready_i (gbt_rxready_i),

    .mgt_clk_p_i   (mgt_clk_p_i),
    .mgt_clk_n_i   (mgt_clk_n_i),

    .vfat_sof_p    (vfat_sof_p),
    .vfat_sof_n    (vfat_sof_n),

    .vfat_sbits_p  (vfat_sbits_p),
    .vfat_sbits_n  (vfat_sbits_n),

    .led_o         (led_o),

    .gbt_txvalid_o (gbt_txvalid_o),

    .ext_reset_o   (ext_reset_o),

    .mgt_tx_p_o    (mgt_tx_p_o),
    .mgt_tx_n_o    (mgt_tx_n_o)
);

// for loopback need to take serialized elink s-bit outputs, deserialize them,
// feed them into this module, parse the 16 bit packets, recover the data
// :(

reg  [15:0] elink_o_fifo;
reg  [15:0] elink_o_parallel;
wire [15:0] fifo_dly;
always @(posedge gbt_eclk_p[0]) begin
  // this may need to be bitslipped... depending on the phase alignment of the clocks
  elink_o_fifo[7:0]  <= {elink_o_fifo[ 6:0],elink_o_p[0]};
  elink_o_fifo[15:8] <= {elink_o_fifo[14:8],elink_o_p[1]};
end

wire [3:0] dly_adr = 4'd3;
genvar ibit;
generate
for (ibit=0; ibit<16; ibit=ibit+1) begin: gen_bitloop
  SRL16E dly (.CLK(~gbt_eclk_p[0]),.CE(1'b1),.D(elink_o_fifo[ibit]),.A0(dly_adr[0]),.A1(dly_adr[1]),.A2(dly_adr[2]),.A3(dly_adr[3]),.Q(fifo_dly[ibit]));
end
endgenerate


always @(posedge clk40) begin
  elink_o_parallel <= fifo_dly;
end

wire [31:0] gbt_rx_request;
wire        gbt_rx_valid;

link_gbt_rx i_gbt_rx_link (
      .ttc_clk_40_i            ( clk40),
      .reset_i                 ( 1'b0),

      // inputs
      .gbt_rx_data_i           ( elink_o_parallel),

      // outputs
      .req_en_o                ( gbt_rx_valid),
      .req_data_o              ( gbt_rx_request)
);

endmodule
