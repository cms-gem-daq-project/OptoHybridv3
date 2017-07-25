// adapted from Xilinx OVERSAMPLE.vhd XAPP8812


module oversampler (

  input rx_p,
  input rx_n,

  input clock,

  input fastclock, // input clocks should be 1/2 the data rate (160 MHz for standard operation, 320 for DDR)
  input fastclock90,
  input fastclock180,

  input  [1:0] phase_sel_in,
  output [1:0] phase_sel_out,

  output reg phase_err,

  output d0,
  output d1

);

parameter       DDR        = 1;
parameter       POSNEG     = 0; // setting posneg to 1 adds an additional 180 degree delay
parameter       TAP_OFFSET = 0;

parameter       PHASE_SEL_MANUAL = 0;

parameter       DATA_RATE = 320+320*DDR;
parameter [4:0] NUM_TAPS  = DDR ? 5 : 10; // 45 degree phase shift in either 320 or 160 MHz clocks, using 78 ps taps

IBUFDS_DIFF_OUT #(.IBUF_LOW_PWR("FALSE"), .DIFF_TERM("TRUE"), .IOSTANDARD("LVDS_25"))
ibufds (
  .I  (rx_p),
  .IB (rx_n),
  .O  ( rxd),
  .OB (_rxd)
);


IODELAYE1 #(
  .IDELAY_TYPE           ("FIXED"),
  .IDELAY_VALUE          (TAP_OFFSET + 0),
  .HIGH_PERFORMANCE_MODE ("TRUE"),
  .REFCLK_FREQUENCY      (200))
delay0   (
    .C           (1'b0),
    .T           (1'b1),
    .RST         (1'b0),
    .CE          (1'b0),
    .INC         (1'b0),
    .CINVCTRL    (1'b0),
    .CNTVALUEIN  (5'd0),
    .CLKIN       (1'b0),
    .IDATAIN     (rxd),
    .DATAIN      (1'b0),
    .ODATAIN     (1'b0),
    .DATAOUT     (rxd_delay0),
    .CNTVALUEOUT ()
  );

  IODELAYE1 #(
    .IDELAY_TYPE           ("FIXED"),
    .IDELAY_VALUE          (TAP_OFFSET + NUM_TAPS), // ~50 ps per tap, need to adjust
    .HIGH_PERFORMANCE_MODE ("TRUE"),
    .REFCLK_FREQUENCY      (310))
delay1   (
    .C           (1'b0),
    .T           (1'b1),
    .RST         (1'b0),
    .CE          (1'b0),
    .INC         (1'b0),
    .CINVCTRL    (1'b0),
    .CNTVALUEIN  (NUM_TAPS),
    .CLKIN       (1'b0),
    .IDATAIN     (_rxd),
    .DATAIN      (1'b0),
    .ODATAIN     (1'b0),
    .DATAOUT     (_rxd_delay45),
    .CNTVALUEOUT ()
  );

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
    .RST          (1'b0),
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
      .RST          (1'b0),
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


    reg [7:0] qq;
    reg       qqq7;

    reg [3:0] eq4 = 0;

    always @(posedge fastclock) begin
      qq   <= q;

      qqq7 <= qq[7];

      eq4[0] <= ~(qq[0]^qq[1]) || ~(qq[4]^qq[5]);
      eq4[1] <= ~(qq[1]^qq[2]) || ~(qq[5]^qq[6]);
      eq4[2] <= ~(qq[2]^qq[3]) || ~(qq[6]^qq[7]);
      eq4[3] <= ~(qq[3]^qq[4]) || ~(qqq7 ^qq[0]);

    end

    wire [3:0] phase_err4;

    // refer to XAPP881 figure 7 state machine
    assign phase_err4[2'b00] = (eq4[0] || eq4[1]);
    assign phase_err4[2'b01] = (eq4[3] || eq4[0]);
    assign phase_err4[2'b10] = (eq4[2] || eq4[1]);
    assign phase_err4[2'b11] = (eq4[3] || eq4[2]);

    reg [1:0] d01_mux;

    wire [1:0] sel;

    assign phase_sel_out = sel;

    always @(posedge fastclock) begin

      case (sel)
      2'd0: d01_mux[1:0] <= {qq[0],qq[4]}; // eq00,  45 and 225 degree samples
      2'd1: d01_mux[1:0] <= {qq[1],qq[5]}; // eq01,   0 and 180 degree samples
      2'd2: d01_mux[1:0] <= {qq[3],qq[7]}; // eq10,  90 and 270 degree samples
      2'd3: d01_mux[1:0] <= {qq[2],qq[6]}; // eq11, 225 and 315 degree samples
      endcase

      case (sel)
      2'd0: phase_err <= phase_err4[2'b00]; // eq00,  45 and 225 degree samples
      2'd1: phase_err <= phase_err4[2'b01]; // eq01,   0 and 180 degree samples
      2'd2: phase_err <= phase_err4[2'b10]; // eq10,  90 and 270 degree samples
      2'd3: phase_err <= phase_err4[2'b11]; // eq11, 225 and 315 degree samples
      endcase
    end

    // a delay of 1 DDR clock is equal to the effect of switching the sampling edges (0 becomes 1 and vice versa)
    // we can use this feature to implement DDR delays without having a double data rate clock
    generate
    if (POSNEG) begin
      assign d0 = d01_mux[1];
      assign d1 = d01_mux[0];
    end
    else begin
      assign d0 = d01_mux[0];
      assign d1 = d01_mux[1];
    end
    endgenerate

    generate

    // manual control by external input
    if (PHASE_SEL_MANUAL) begin
      assign sel = phase_sel_in; // external input
    end

    // automatic control by state machine
    else begin

      reg [1:0] phase_sm=2'd0;
      assign sel = phase_sm; // sm controlled
      parameter sm_00 = 2'd0;
      parameter sm_01 = 2'd1;
      parameter sm_10 = 2'd2;
      parameter sm_11 = 2'd3;

      always @(posedge fastclock) begin
        case (phase_sm)
          sm_00: begin
            if (eq4[0]) phase_sm <= sm_10;
            if (eq4[1]) phase_sm <= sm_01;
          end
          sm_01: begin
          if (eq4[3]) phase_sm <= sm_00;
          if (eq4[0]) phase_sm <= sm_11;
          end
        sm_11: begin
          if (eq4[3]) phase_sm <= sm_10;
          if (eq4[2]) phase_sm <= sm_01;
        end
        sm_10: begin
          if (eq4[1]) phase_sm <= sm_11;
          if (eq4[2]) phase_sm <= sm_00;
        end
        endcase
      end
    end
    endgenerate

endmodule
