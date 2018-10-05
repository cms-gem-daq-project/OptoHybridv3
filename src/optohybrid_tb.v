`timescale 1ns/1ps


module sr64 (
  input CLK,
  input CE,
  input [5:0] SEL,
  input SI,
  output DO
);

parameter SELWIDTH = 6;
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

reg[23:0] SOT_INVERT;

initial SOT_INVERT  = 24'hf99286;

reg [7:0] VFAT0_TU_INVERT  = 8'h45;
reg [7:0] VFAT1_TU_INVERT  = 8'h67;
reg [7:0] VFAT2_TU_INVERT  = 8'h46;
reg [7:0] VFAT3_TU_INVERT  = 8'he7;
reg [7:0] VFAT4_TU_INVERT  = 8'h2d;
reg [7:0] VFAT5_TU_INVERT  = 8'hbd;
reg [7:0] VFAT6_TU_INVERT  = 8'h8;
reg [7:0] VFAT7_TU_INVERT  = 8'h32;
reg [7:0] VFAT8_TU_INVERT  = 8'h71;
reg [7:0] VFAT9_TU_INVERT  = 8'h7;
reg [7:0] VFAT10_TU_INVERT = 8'hdc;
reg [7:0] VFAT11_TU_INVERT = 8'hee;
reg [7:0] VFAT12_TU_INVERT = 8'had;
reg [7:0] VFAT13_TU_INVERT = 8'h17;
reg [7:0] VFAT14_TU_INVERT = 8'he5;
reg [7:0] VFAT15_TU_INVERT = 8'h8f;
reg [7:0] VFAT16_TU_INVERT = 8'he2;
reg [7:0] VFAT17_TU_INVERT = 8'h6;
reg [7:0] VFAT18_TU_INVERT = 8'h30;
reg [7:0] VFAT19_TU_INVERT = 8'h5d;
reg [7:0] VFAT20_TU_INVERT = 8'h60;
reg [7:0] VFAT21_TU_INVERT = 8'h73;
reg [7:0] VFAT22_TU_INVERT = 8'ha;
reg [7:0] VFAT23_TU_INVERT = 8'h14;

reg [191:0] TU_INVERT;

initial TU_INVERT = { VFAT23_TU_INVERT, VFAT22_TU_INVERT, VFAT21_TU_INVERT, VFAT20_TU_INVERT, VFAT19_TU_INVERT, VFAT18_TU_INVERT, VFAT17_TU_INVERT, VFAT16_TU_INVERT, VFAT15_TU_INVERT, VFAT14_TU_INVERT, VFAT13_TU_INVERT, VFAT12_TU_INVERT, VFAT11_TU_INVERT, VFAT10_TU_INVERT, VFAT9_TU_INVERT, VFAT8_TU_INVERT, VFAT7_TU_INVERT, VFAT6_TU_INVERT, VFAT5_TU_INVERT, VFAT4_TU_INVERT, VFAT3_TU_INVERT, VFAT2_TU_INVERT, VFAT1_TU_INVERT, VFAT0_TU_INVERT};


parameter DDR = 0;

//----------------------------------------------------------------------------------------------------------------------
//
//----------------------------------------------------------------------------------------------------------------------


  //--------------------------------------------------------------------------------------------------------------------
  // clock synthesis
  //--------------------------------------------------------------------------------------------------------------------

  reg clk40     = 0; // 40  MHz for logic
  reg clk160    = 0; // 160 MHz for logic
  reg clk320    = 1; // 320 MHz for logic
  reg clk640    = 0; // 640  MHz for stimulus at DDR
  reg clk1280   = 0; // 1280 MHz for stimulus at DDR
  reg clk12G8   = 0; // 12.8 GHz for IOdelay generation

  always @* begin
    clk12G8   <= #  0.039 ~clk12G8; // 78 ps clock (12.8GHz) to simulate TAP delay
    clk1280   <= #  0.390 ~clk1280;
    clk640    <= #  0.780 ~clk640;
    clk320    <= #  1.560 ~clk320;
    clk160    <= #  3.120 ~clk160;
    clk40     <= # 12.480 ~clk40;
  end

  //--------------------------------------------------------------------------------------------------------------------
  // S-bit Serialization
  //--------------------------------------------------------------------------------------------------------------------

  // s-bits are transmitted MSB first
  // with SOT aligned to the most significant bit (7)
  reg [2:0] sot_cnt=3'd4; // cnt to 8
  wire sotd0 = (sot_cnt==7);
  // frame counter for the 8 S-bits in a 40 MHz clock cycle
  always @(posedge clk320)
    sot_cnt <= sot_cnt - 1'b1;

  reg [2:0] slow_cnt=0;
  always @(posedge clk320)
    if (sotd0)
      slow_cnt <= slow_cnt + 1'b1;

  reg [7:0] pat_sr = 0;


  generate

  if (DDR) begin

      // at DDR 128 bit test pattern gets shifted into the S-bit packer..
      // the same s-bits are inserted into every S-bit

      //parameter [127:0] test_pat = 128'hCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC;
        parameter [127:0] test_pat = 128'hff00ff00ff00ff00ff00ff00ff00ff00;

        wire [15:0] vfat_tu [7:0];

        assign vfat_tu [0] = slow_cnt==0 ? test_pat [0  +:16] : 0;
        assign vfat_tu [1] = slow_cnt==0 ? test_pat [16 +:16] : 0;
        assign vfat_tu [2] = slow_cnt==0 ? test_pat [32 +:16] : 0;
        assign vfat_tu [3] = slow_cnt==0 ? test_pat [48 +:16] : 0;
        assign vfat_tu [4] = slow_cnt==0 ? test_pat [64 +:16] : 0;
        assign vfat_tu [5] = slow_cnt==0 ? test_pat [80 +:16] : 0;
        assign vfat_tu [6] = slow_cnt==0 ? test_pat [96 +:16] : 0;
        assign vfat_tu [7] = slow_cnt==0 ? test_pat [112+:16] : 0;

        genvar itu;
        for (itu=0; itu<8; itu=itu+1'b1) begin: tuloop
          always @ (posedge clk1280) begin
            pat_sr [itu] <= vfat_tu[itu][sot_cnt];
          end
        end
  end
  else begin

    // at SDR, 64 bit test pattern gets shifted into the S-bit packer..
    // the same s-bits are inserted into every S-bit

        // send pattern in two subsequent bunch crossings (to test odd/even endcoders)
        // then remain idle for a period to make latency measurements clearer


        reg [63:0] test_pat_even = 64'h0000000000000001;
        reg [63:0] test_pat_odd  = 64'h0000000000000002;

        reg [63:0] pat;
        always @(posedge clk40) begin
          // barrell shift the pattern on every slow clock
// if (slow_cnt==0) begin
//            test_pat_odd  <= {test_pat_odd  << 1'b1, test_pat_odd [63]};
//            test_pat_even <= {test_pat_even << 1'b1, test_pat_even[63]};
//            test_pat_even <= {test_pat_even << 1'b1, test_pat_even[63]};
//          end

          pat <= (slow_cnt==0) ? test_pat_even : (slow_cnt==1) ? test_pat_odd : 64'd0;
        end


        wire [7:0] vfat_tu [7:0];

        assign vfat_tu [0] = pat [0 +:8];
        assign vfat_tu [1] = pat [8 +:8];
        assign vfat_tu [2] = pat [16+:8];
        assign vfat_tu [3] = pat [24+:8];
        assign vfat_tu [4] = pat [32+:8];
        assign vfat_tu [5] = pat [40+:8];
        assign vfat_tu [6] = pat [48+:8];
        assign vfat_tu [7] = pat [56+:8];

        genvar itu;
        for (itu=0; itu<8; itu=itu+1'b1) begin: tuloop
          always @ (*) begin
            pat_sr [itu] <= vfat_tu[itu][sot_cnt];
          end
        end

  end

  endgenerate


  wire [191:0] phase_err;
  wire aligner_sump;

  wire [1535+1536*DDR:0] sbits;


  // apply a delay, opposite to the delay that we we later counteract with TU_POSNEG

  wire [191:0] tu_p;
  wire [191:0] tu_p_inverted;

  reg [8:0] tu_cnt=0;
  reg [5:0] tu_dly=0;

  always @(posedge clk40)
    tu_cnt <= tu_cnt + 1'b1;

  always @(posedge clk40)
  if (&tu_cnt)
  tu_dly <= tu_dly + 6'd32;

  genvar ipin;
  generate
  for (ipin=0; ipin<192; ipin=ipin+1) begin: pinloop
    // clock at very high frequency so that SRL can simulate an IDELAY in 78 ps taps
    sr64 srp (clk12G8, 1'b1, tu_dly,  pat_sr[ipin/24], tu_p[ipin]); // make each vfat the same
    //sr64 srp (clk12G8, 1'b1, 6'd63 - TU_OFFSET [ipin*5+:4],  pat_sr[ipin/24], tu_p[ipin]); // make each vfat the same
    assign tu_p_inverted[ipin] = TU_INVERT[ipin] ? ~tu_p[ipin] : tu_p[ipin];
  end
  endgenerate


  wire [23:0] sof;
  wire [23:0] sof_inverted;

  genvar ifat;
  generate
  for (ifat=0; ifat<24; ifat=ifat+1) begin: fatloop
    // 40 taps @ 78 ps each = 3.125 ns
    sr64 srfp (clk12G8, 1'b1,tu_dly,  sotd0, sof[ifat]);
    //sr64 srfp (clk12G8, 1'b1,6'd63-SOT_OFFSET [ifat*5+:4] - 6'd40*SOT_POSNEG[ifat],  sotd0, sof[ifat]);
    assign sof_inverted[ifat] = SOT_INVERT[ifat] ? ~sof[ifat] : sof[ifat];
  end
  endgenerate

  //--------------------------------------------------------------------------------------------------------------------
  // GBT Serialization
  //--------------------------------------------------------------------------------------------------------------------

  //
  reg [11:0] startup_clock=0;
  parameter startup_count = 600;
  always @(posedge clk40) begin
    if (startup_clock < startup_count)
      startup_clock <= startup_clock + 1'b1;
  end

  wire startup_done = (startup_clock == startup_count);


  reg          wr_en       = 1'b1;
  wire         wr_valid    = startup_done;

  wire  [15:0] address     = {5'h0, 11'h0}; // 32'h0; // write to loopback
  reg   [31:0] data        = 32'h12345678;

  wire l1a      = 1'b0;
  wire bc0      = 1'b0;
  wire resync   = 1'b0;

  wire [48:0] gbt_packet = {wr_en, wr_valid, address[15:0], data[31:0]};

  wire [7:0] elink_data;

  reg [3:0] gbt_frame=0;

  link_oh_fpga_tx link_oh_fpga_tx (

    .reset_i              (1'b0),
    .ttc_clk_40_i         (clk40),
    .l1a_i                (l1a),
    .bc0_i                (bc0),
    .resync_i             (resync),

    .elink_data_o         (elink_data),

    .request_valid_i      (wr_valid),
    .request_write_i      (wr_en),
    .request_addr_i       (address),
    .request_data_i       (data),

    .busy_o               ()

  );

  always @(posedge clk40) begin
    wr_en       <= ~wr_en;
  end

  reg [1:0] clk40_sync;

  reg [2:0] bitsel=0;

  always @(negedge clk320) begin

    clk40_sync[0] <= clk40;
    clk40_sync[1] <= clk40_sync[0];

  if (clk40_sync[1:0] == 2'b01) // catch the rising edge of clk40
      bitsel <= 3'd7;
  else
      bitsel <= bitsel-1'b1;
  end


  // Elinks
  reg [7:0] elink_data_sync_1;
  reg [7:0] elink_data_sync;
  always @(negedge clk320) begin
  elink_data_sync_1 <= elink_data;
  elink_data_sync   <= elink_data_sync_1;
  end

  reg elink_i_p, elink_i_n;
  always @(*) begin

       elink_i_p =  elink_data_sync [bitsel];
       elink_i_n = ~elink_data_sync [bitsel];

  end

//----------------------------------------------------------------------------------------------------------------------
// Optohybrid IO
//----------------------------------------------------------------------------------------------------------------------

  wire [1:0] gbt_eclk_p = {2{ clk320}};
  wire [1:0] gbt_eclk_n = {2{~clk320}};

  // 40 MHz clocks

  reg [1:0] gbtclk;
  always @(*) begin
    gbtclk[0] <= #6.8 clk40; // logic clock
    gbtclk[1] <= #18   clk40; // gbt   clock
  end

  wire logic_clock_p =  gbtclk[0]; // fixed and phase shiftable
  wire logic_clock_n = ~gbtclk[0];

  wire elink_clock_p =  gbtclk[1]; // fixed and phase shiftable
  wire elink_clock_n = ~gbtclk[1];


  wire elink_o_p;
  wire elink_o_n;

  // SCA IO
  wire [3:0] sca_io = {4'b0000};

  // GBTx Control
  wire gbt_txready_i = 1'b1;
  wire gbt_rxvalid_i = 1'b1;
  wire gbt_rxready_i = 1'b1;

  // MGT
  wire mgt_clk_p_i =  clk160;
  wire mgt_clk_n_i = ~clk160;

  wire [23:0] vfat_sot_p =  sof_inverted; //   SOT_INVERT ^ sof;
  wire [23:0] vfat_sot_n = ~sof_inverted; // ~(SOT_INVERT ^ sof);

  wire [191:0] vfat_sbits_p =  tu_p_inverted ; //  (TU_INVERT ^ tu_p);
  wire [191:0] vfat_sbits_n = ~tu_p_inverted ; // ~(TU_INVERT ^ tu_p);

  wire [15:0] led_o;

  wire [11:0] ext_reset_o;

  wire [3:0] mgt_tx_p_o;
  wire [3:0] mgt_tx_n_o;

  optohybrid_top optohybrid_top (

      .logic_clock_p    (logic_clock_p),
      .logic_clock_n    (logic_clock_n),

      .elink_clock_p    (elink_clock_p),
      .elink_clock_n    (elink_clock_n),

      .elink_i_p     (elink_i_p),
      .elink_i_n     (elink_i_n),

      .elink_o_p     (elink_o_p),
      .elink_o_n     (elink_o_n),

      .sca_io        (sca_io),

      .gbt_txready_i (gbt_txready_i),
      .gbt_rxvalid_i (gbt_rxvalid_i),
      .gbt_rxready_i (gbt_rxready_i),

      .mgt_clk_p_i   ({2{mgt_clk_p_i}}),
      .mgt_clk_n_i   ({2{mgt_clk_n_i}}),

      .vfat_sot_p    (vfat_sot_p),
      .vfat_sot_n    (vfat_sot_n),

      .vfat_sbits_p  (vfat_sbits_p),
      .vfat_sbits_n  (vfat_sbits_n),

      .led_o         (led_o),

      .ext_reset_o   (ext_reset_o),

      .mgt_tx_p_o    (mgt_tx_p_o),
      .mgt_tx_n_o    (mgt_tx_n_o)
  );

  //--------------------------------------------------------------------------------------------------------------------
  // GBT Deserialization
  //--------------------------------------------------------------------------------------------------------------------

  // for loopback need to take serialized elink s-bit outputs, deserialize them,
  // feed them into this module, parse the 16 bit packets, recover the data
  // :(


  reg  [7:0] fifo_tmp;
  reg  [7:0] elink_o_parallel;
  reg  [7:0] elink_o_parallel0;
  reg  [7:0] elink_o_parallel1;
  reg  [7:0] elink_o_parallel2;
  reg  [7:0] elink_o_parallel3;
  reg  [7:0] elink_o_parallel4;
  reg  [7:0] elink_o_parallel5;
  reg  [7:0] elink_o_parallel6;
  reg  [7:0] elink_o_parallel7;

  wire [7:0] fifo_dly;
  wire [7:0] fifo_dly0;
  wire [7:0] fifo_dly1;
  wire [7:0] fifo_dly2;
  wire [7:0] fifo_dly3;
  wire [7:0] fifo_dly4;
  wire [7:0] fifo_dly5;
  wire [7:0] fifo_dly6;
  wire [7:0] fifo_dly7;

  always @(posedge gbt_eclk_p[0]) begin
  // this may need to be bitslipped... depending on the phase alignment of the clocks
  fifo_tmp[7:0]  <= {fifo_tmp[ 6:0], ~elink_o_p}; // polarity swap on e-link 1
  end

  wire  [7:0] elink_o_fifo = fifo_tmp;

  wire [3:0] dly_adr = 4'd0;
  wire [3:0] dly_adr0= 4'd0;
  wire [3:0] dly_adr1= 4'd1;
  wire [3:0] dly_adr2= 4'd2;
  wire [3:0] dly_adr3= 4'd3;
  wire [3:0] dly_adr4= 4'd4;
  wire [3:0] dly_adr5= 4'd5;
  wire [3:0] dly_adr6= 4'd6;
  wire [3:0] dly_adr7= 4'd7;

  genvar ibit;
  generate
  for (ibit=0; ibit<8; ibit=ibit+1) begin: gen_bitloop
    SRL16E dly (.CLK(~gbt_eclk_p[0]),.CE(1'b1),.D(elink_o_fifo[ibit]),.A0(dly_adr[0]),.A1(dly_adr[1]),.A2(dly_adr[2]),.A3(dly_adr[3]),.Q(fifo_dly[ibit]));
    SRL16E dly0 (.CLK(~gbt_eclk_p[0]),.CE(1'b1),.D(elink_o_fifo[ibit]),.A0(dly_adr0[0]),.A1(dly_adr0[1]),.A2(dly_adr0[2]),.A3(dly_adr0[3]),.Q(fifo_dly0[ibit]));
    SRL16E dly1 (.CLK(~gbt_eclk_p[0]),.CE(1'b1),.D(elink_o_fifo[ibit]),.A0(dly_adr1[0]),.A1(dly_adr1[1]),.A2(dly_adr1[2]),.A3(dly_adr1[3]),.Q(fifo_dly1[ibit]));
    SRL16E dly2 (.CLK(~gbt_eclk_p[0]),.CE(1'b1),.D(elink_o_fifo[ibit]),.A0(dly_adr2[0]),.A1(dly_adr2[1]),.A2(dly_adr2[2]),.A3(dly_adr2[3]),.Q(fifo_dly2[ibit]));
    SRL16E dly3 (.CLK(~gbt_eclk_p[0]),.CE(1'b1),.D(elink_o_fifo[ibit]),.A0(dly_adr3[0]),.A1(dly_adr3[1]),.A2(dly_adr3[2]),.A3(dly_adr3[3]),.Q(fifo_dly3[ibit]));
    SRL16E dly4 (.CLK(~gbt_eclk_p[0]),.CE(1'b1),.D(elink_o_fifo[ibit]),.A0(dly_adr4[0]),.A1(dly_adr4[1]),.A2(dly_adr4[2]),.A3(dly_adr4[3]),.Q(fifo_dly4[ibit]));
    SRL16E dly5 (.CLK(~gbt_eclk_p[0]),.CE(1'b1),.D(elink_o_fifo[ibit]),.A0(dly_adr5[0]),.A1(dly_adr5[1]),.A2(dly_adr5[2]),.A3(dly_adr5[3]),.Q(fifo_dly5[ibit]));
    SRL16E dly6 (.CLK(~gbt_eclk_p[0]),.CE(1'b1),.D(elink_o_fifo[ibit]),.A0(dly_adr6[0]),.A1(dly_adr6[1]),.A2(dly_adr6[2]),.A3(dly_adr6[3]),.Q(fifo_dly6[ibit]));
    SRL16E dly7 (.CLK(~gbt_eclk_p[0]),.CE(1'b1),.D(elink_o_fifo[ibit]),.A0(dly_adr7[0]),.A1(dly_adr7[1]),.A2(dly_adr7[2]),.A3(dly_adr7[3]),.Q(fifo_dly7[ibit]));
  end
  endgenerate

  always @(posedge clk40) begin
    elink_o_parallel  <= fifo_dly;
    elink_o_parallel0 <= fifo_dly0;
    elink_o_parallel1 <= fifo_dly1;
    elink_o_parallel2 <= fifo_dly2;
    elink_o_parallel3 <= fifo_dly3;
    elink_o_parallel4 <= fifo_dly4;
    elink_o_parallel5 <= fifo_dly5;
    elink_o_parallel6 <= fifo_dly6;
    elink_o_parallel7 <= fifo_dly7;
  end

  wire [31:0] gbt_rx_request;
  wire        gbt_rx_valid;

  link_oh_fpga_rx
  i_gbt_rx_link (
      .ttc_clk_40_i  (clk40),
      .reset_i       (1'b0),

      // inputs
      .elink_data_i (elink_o_parallel),

      // outputs
      .reg_data_valid_o      (gbt_rx_valid),
      .reg_data_o    (gbt_rx_request),
      .error_o ()
  );

//----------------------------------------------------------------------------------------------------------------------
endmodule
//----------------------------------------------------------------------------------------------------------------------
