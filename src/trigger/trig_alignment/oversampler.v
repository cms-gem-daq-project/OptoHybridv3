//--------------------------------------------------------------------------------
// CMS Muon Endcap
// GEM Collaboration
// Optohybrid v3 Firmware -- Oversampler
// A. Peck
//--------------------------------------------------------------------------------
// Description:
//   adapted from Xilinx OVERSAMPLE.vhd XAPP8812
//   This module oversamples the incoming bitstream at multiple phases and provides
//   edge-detection
//--------------------------------------------------------------------------------
// 2017/07/24 -- Initial
//--------------------------------------------------------------------------------

module oversampler (

  input rx_p,
  input rx_n,

  input clock,
  
  input invert, 

  input reset_i,

  input fastclock, // input clocks should be 1/2 the data rate (160 MHz for standard operation, 320 for DDR)
  input fastclock90,
  input fastclock180,

  input  [1:0] phase_sel_in,
  output [1:0] phase_sel_out,

  input [7:0] stable_count_to_reset,
  input [7:0] err_count_to_shift,

  input [4:0] tap_delay_i,

  output reg phase_err,

  output reg d0,
  output reg d1

);


  reg reset;
  always @(posedge fastclock)
    reset <= reset_i;

  parameter       DDR        = 1'b0;

  parameter       PHASE_SEL_EXTERNAL = 1'b0;

  parameter       DATA_RATE = 320+320*DDR;
  parameter       NUM_TAPS_45  = DDR ? 5'd5 : 5'd10; // 45 degree phase shift in either 320 or 160 MHz clocks, using 78 ps taps
  // 78*5 = 390 ps, 78*10=780 ps

  initial $display ("Compiling oversampler with DDR=%d, INVERT=%d, TAP_DELAY=%d", DDR, invert, tap_delay_i);

  IBUFDS_DIFF_OUT #(.IBUF_LOW_PWR("FALSE"), .DIFF_TERM("TRUE"), .IOSTANDARD("LVDS_25"))
  ibufds (
    .I  (rx_p),
    .IB (rx_n),
    .O  ( rxd),
    .OB (_rxd)
  );


//----------------------------------------------------------------------------------------------------------------------
// Delays
//----------------------------------------------------------------------------------------------------------------------

  reg [4:0] tap_delay0;
  reg [4:0] tap_delay45;

  always @(posedge clock) begin
    tap_delay0  <= tap_delay_i ;
    tap_delay45 <= tap_delay_i  + NUM_TAPS_45;
  end

  (* IODELAY_GROUP = "IODLY_GROUP" *)
  IODELAYE1 #(
      .IDELAY_TYPE           ("VAR_LOADABLE"),
      .IDELAY_VALUE          (0),
      .HIGH_PERFORMANCE_MODE ("TRUE"),
      .REFCLK_FREQUENCY      (200))
  delay0   (
      .C           (clock),
      .T           (1'b1),
      .RST         (1'b1), // does this actually work? it will be transparent?
      .CE          (1'b0),
      .INC         (1'b0),
      .CINVCTRL    (1'b0),
      .CNTVALUEIN  (tap_delay0),
      .CLKIN       (1'b0),
      .IDATAIN     (rxd),
      .DATAIN      (1'b0),
      .ODATAIN     (1'b0),
      .DATAOUT     (rxd_delay0),
      .CNTVALUEOUT ()
  );

  (* IODELAY_GROUP = "IODLY_GROUP" *)
  IODELAYE1 #(
      .IDELAY_TYPE           ("VAR_LOADABLE"),
      .IDELAY_VALUE          (NUM_TAPS_45), // ~50 ps per tap, need to adjust
      .HIGH_PERFORMANCE_MODE ("TRUE"),
      .REFCLK_FREQUENCY      (200))
  delay1   (
      .C           (clock),
      .T           (1'b1),
      .RST         (1'b1),
      .CE          (1'b0),
      .INC         (1'b0),
      .CINVCTRL    (1'b0),
      .CNTVALUEIN  (tap_delay45),
      .CLKIN       (1'b0),
      .IDATAIN     (_rxd),
      .DATAIN      (1'b0),
      .ODATAIN     (1'b0),
      .DATAOUT     (_rxd_delay45),
      .CNTVALUEOUT ()
  );

//----------------------------------------------------------------------------------------------------------------------
// Serdes
//----------------------------------------------------------------------------------------------------------------------

  wire [7:0] q;

  ISERDESE1 #(

    .INTERFACE_TYPE ("OVERSAMPLE"),
    .DATA_RATE      ("DDR"), // Specify data rate of "DDR" or "SDR"
    .DATA_WIDTH     (4),     // Specify data width -
    .OFB_USED       ("FALSE"),
    .NUM_CE         (2), // Define number or clock enables to an integer of 1 or 2
    .SERDES_MODE    ("MASTER"),
    .IOBDELAY       ("IFD"))
  iserdes_odd   (
    .CLK          (fastclock),
    .CLKB         (fastclock180),
    .OCLK         (fastclock90),
    .D            (1'b0),
    .BITSLIP      (1'b0),
    .CE1          (1'b1),
    .CE2          (1'b1),
    .CLKDIV       (1'b0),
    .DDLY         (rxd_delay0),
    .DYNCLKDIVSEL (1'b0),
    .DYNCLKSEL    (1'b0),
    .OFB          (1'b0),
    .RST          (reset),
    .SHIFTIN1     (1'b0),
    .SHIFTIN2     (1'b0),
    .O            (),
    .Q1           (q[1]),
    .Q2           (q[5]),
    .Q3           (q[3]),
    .Q4           (q[7]),
    .Q5           (),
    .Q6           (),
    .SHIFTOUT1    (),
    .SHIFTOUT2    ()
  );

  ISERDESE1 #(
    .INTERFACE_TYPE ("OVERSAMPLE"),
    .DATA_RATE      ("DDR"), // Specify data rate of "DDR" or "SDR"
    .DATA_WIDTH     (4),     // Specify data width -
    .OFB_USED       ("FALSE"),
    .NUM_CE         (2), // Define number or clock enables to an integer of 1 or 2
    .SERDES_MODE    ("MASTER"),
    .IOBDELAY       ("IFD"))
    iserdes_even (
    .CLK          (fastclock),
    .CLKB         (fastclock180),
    .OCLK         (fastclock90),
      .D            (1'b0),
      .BITSLIP      (1'b0),
      .CE1          (1'b1),
      .CE2          (1'b1),
      .CLKDIV       (1'b0),
      .DDLY         (_rxd_delay45),
      .DYNCLKDIVSEL (1'b0),
      .DYNCLKSEL    (1'b0),
      .OFB          (1'b0),
      .RST          (reset),
      .SHIFTIN1     (1'b0),
      .SHIFTIN2     (1'b0),
      .O            (),
      .Q1           (q[0]),
      .Q2           (q[4]),
      .Q3           (q[2]),
      .Q4           (q[6]),
      .Q5           (),
      .Q6           (),
      .SHIFTOUT1    (),
      .SHIFTOUT2    ()
    );


    wire [7:0] i = q;
    reg  [7:0] ii=0;
    reg  [7:0] id=0;
    reg        i7dd=0;

    reg  [3:0] eq4 = 0;

    always @(posedge fastclock) begin

      ii   <=   i;
      id   <=  (ii^8'h55); // uninvert even bits

      eq4[0] <= (ii[0]==ii[1]) || (ii[4]==ii[5]);
      eq4[1] <= (ii[1]==ii[2]) || (ii[5]==ii[6]);
      eq4[2] <= (ii[2]==ii[3]) || (ii[6]==ii[7]);
      eq4[3] <= (ii[3]==ii[4]) || (id[7]==ii[0]);

    end

  //--------------------------------------------------------------------------------------------------------------------
  // Edge Detection
  //--------------------------------------------------------------------------------------------------------------------

  wire [3:0] phase_err4;

  // refer to XAPP881 figure 7 state machine
  assign phase_err4[2'b00] = (eq4[0] || eq4[3]);
  assign phase_err4[2'b01] = (eq4[1] || eq4[0]);
  assign phase_err4[2'b10] = (eq4[2] || eq4[1]);
  assign phase_err4[2'b11] = (eq4[3] || eq4[2]);

  reg rising, falling;

  wire [1:0] phase_sel_local;
  wire [1:0] sample_sel = phase_sel_local[1:0];
  assign phase_sel_out = phase_sel_local;

  generate
  always @(posedge fastclock) begin

    case (sample_sel)
    2'd0: {falling,rising} <= invert ? ~{id[0],id[4]} : {id[0],id[4]}; // eq00,  45 and 225 degree samples
    2'd1: {falling,rising} <= invert ? ~{id[1],id[5]} : {id[1],id[5]}; // eq01,   0 and 180 degree samples
    2'd3: {falling,rising} <= invert ? ~{id[2],id[6]} : {id[2],id[6]}; // eq11, 135 and 315 degree samples
    2'd2: {falling,rising} <= invert ? ~{id[3],id[7]} : {id[3],id[7]}; // eq10,  90 and 270 degree samples
    endcase

    case (sample_sel)
    2'd0: phase_err <= phase_err4[2'b00]; // eq00,  45 and 225 degree samples
    2'd1: phase_err <= phase_err4[2'b01]; // eq01,   0 and 180 degree samples
    2'd3: phase_err <= phase_err4[2'b11]; // eq11, 135 and 315 degree samples
    2'd2: phase_err <= phase_err4[2'b10]; // eq10,  90 and 270 degree samples
    endcase
  end
  endgenerate

  always @(posedge fastclock) begin
    d0 <= (~reset) & rising;
    d1 <= (~reset) & falling;
  end

  generate

  //----------------------------------------------------------------------------------------------------------------
  // manual control by external input
  // use automatic control on the regularly timed SoT signal and assume that the s-bits share timing
  // S-bits need to be phase matched to the SoT by routing and/or IDELAY elements
  //----------------------------------------------------------------------------------------------------------------

  if (PHASE_SEL_EXTERNAL) begin

        // fanout & force use of the clock to squelch warning in manual mode
        reg [1:0] phase_sel_in_r = 2'd0;
        always @(posedge clock) begin
            phase_sel_in_r <= phase_sel_in;
        end

        assign phase_sel_local = phase_sel_in_r; // external input

  end


  else begin

        //----------------------------------------------------------------------------------------------------------------
        // automatic control by state machine
        //----------------------------------------------------------------------------------------------------------------

        reg [1:0] phase_sm=2'd0;

        assign phase_sel_local[1:0] = phase_sm; // sm controlled

        parameter sm_00 = 2'd0;
        parameter sm_01 = 2'd1;
        parameter sm_10 = 2'd2;
        parameter sm_11 = 2'd3;

        // add some hysterisis to keep a hiccup from oscillating the voter

        reg [1:0] phase_sm_last;

        reg [7:0] err_count=0;
        reg [7:0] stable_count=0;


        reg link_stable;
        reg vote_to_shift;

        always @(posedge fastclock) begin

          // count numbers of good cycles... allow large number of good cycles to reset occasional errors
          if (phase_err)
            stable_count <= 0;
          else begin
            if (stable_count < stable_count_to_reset)
              stable_count <= stable_count + 1'b1;
            else
              stable_count <= stable_count;
          end

          link_stable <= (stable_count == stable_count_to_reset);

          phase_sm_last <= phase_sm;

          // accumulate error counter
          // reset if the link has long term stability
          // or reset if we are changing states already

          vote_to_shift <= (err_count == err_count_to_shift);

          if (link_stable || (phase_sm_last != phase_sm))
            err_count <= 0;
          else if (phase_err) begin
            if (err_count < err_count_to_shift)
              err_count <= err_count + 1'b1;
            else
              err_count <= err_count ;
          end

        end


        // change states according to xapp881 state machine
        // require some number of errors before switching
        always @(posedge fastclock) begin
          if (vote_to_shift) begin
            case (phase_sm)
              sm_00: begin
                if      (eq4[0]) phase_sm <= sm_10;
                else if (eq4[3]) phase_sm <= sm_01;
              end
              sm_01: begin
                if      (eq4[1]) phase_sm <= sm_00;
                else if (eq4[0]) phase_sm <= sm_11;
              end
              sm_11: begin
                if      (eq4[2]) phase_sm <= sm_01;
                else if (eq4[1]) phase_sm <= sm_10;
              end
              sm_10: begin
                if      (eq4[3]) phase_sm <= sm_11;
                else if (eq4[2]) phase_sm <= sm_00;
              end
            endcase
          end
        end

  end
  endgenerate

endmodule
