//--------------------------------------------------------------------------------
// CMS Muon Endcap
// GEM Collaboration
// Optohybrid v3 Firmware -- Trigger Alignment
// A. Peck
//--------------------------------------------------------------------------------
// Description:
//   This module takes in 192 s-bits and 24 start-of-frame signals and outputs
//   1536 (or x2 at DDR) aligned S-bits
//--------------------------------------------------------------------------------
// 2017/07/24 -- Initial
//--------------------------------------------------------------------------------

module trig_alignment (

  input [23:0]  sbit_mask,

  input [191:0] sbits_p,
  input [191:0] sbits_n,

  input reset,

  input [23:0]  start_of_frame_p,
  input [23:0]  start_of_frame_n,

  input fastclk_0,
  input fastclk_90,
  input fastclk_180,

  input delay_refclk,

  input clock,

  output [191:0] phase_err,

  output [MXSBITS*24-1:0] sbits,

  output sump
);

parameter DDR=0;
parameter MXSBITS=64+64*DDR;
parameter MXFATS = 8;
parameter WORD_SIZE = MXSBITS / MXFATS;

wire [191:0] d0; // rising edge sample
wire [191:0] d1;

wire [23:0] start_of_frame_d0;
wire [23:0] start_of_frame_d1;
wire [2:0]  vfat_phase_sel [23:0];

wire [23:0] alignment_err;
wire [23:0] sot_phase_err;

wire [23:0] sof_dly;

wire [23:0] sof_sump;
wire [191:0] sbit_sump;

wire [192*3-1:0] phase_sel_sump;

`include "tap_delays.v"

wire idelay_ready;

IDELAYCTRL idelayctl (

    // The ready (RDY) signal indicates when the IDELAYE2 and
    // ODELAYE2 modules in the specific region are calibrated. The RDY
    // signal is deasserted if REFCLK is held High or Low for one clock
    // period or more. If RDY is deasserted Low, the IDELAYCTRL module
    // must be reset. If not needed, RDY to be unconnected/ignored.
    .RDY    (idelay_ready),

    // Time reference to IDELAYCTRL to calibrate all IDELAYE2 and
    // ODELAYE2 modules in the same region. REFCLK can be supplied
    // directly from a user-supplied source or the MMCME2/PLLE2 and
    // must be routed on a global clock buffer
    .REFCLK (delay_refclk),

    // Active-High asynchronous reset. To ensure proper IDELAYE2
    // and ODELAYE2 operation, IDELAYCTRL must be reset after
    // configuration and the REFCLK signal is stable. A reset pulse width
    // Tidelayctrl_rpw is required
    .RST    (reset)
);

// use the start of frame signals to produce a phase alignment parameter for each transmission unit
genvar ifat;
generate
for (ifat=0; ifat<24; ifat=ifat+1) begin: fatloop

  // sample the start of frame signals
  oversampler #(
    .DDR              (DDR),
    .TAP_OFFSET       (SOF_OFFSET [ifat*5+:4]),
    .POSNEG           (SOF_POSNEG [ifat]),
    .PHASE_SEL_MANUAL (0) // automatic control
  )
  ovs2 (

    .rx_p (start_of_frame_p[ifat]),
    .rx_n (start_of_frame_n[ifat]),

    .clock       (clock),
    .fastclock   (fastclk_0),
    .fastclock90 (fastclk_90),
    .fastclock180(fastclk_180),

    .phase_sel_in     (3'd0),
    .phase_sel_out    (vfat_phase_sel[ifat]),
    .phase_err        (sot_phase_err[ifat]),
    .d0(start_of_frame_d0[ifat]),
    .d1(start_of_frame_d1[ifat]),

    .sump (sof_sump[ifat])
  );

end
endgenerate

genvar ipin;
generate
for (ipin=0; ipin<192; ipin=ipin+1) begin: sampler
  oversampler #(
    .DDR              (DDR),
    .TAP_OFFSET       (TU_OFFSET [ipin*5+:4]),
    .POSNEG           (TU_POSNEG [ipin]),
    .PHASE_SEL_MANUAL (1) // manual control
  )
  ovs1 (
    .rx_p (sbits_p[ipin]),
    .rx_n (sbits_n[ipin]),

    .clock       (clock),
    .fastclock   (fastclk_0),
    .fastclock90 (fastclk_90),
    .fastclock180(fastclk_180),

    .phase_sel_in     (vfat_phase_sel[ipin/8]),
    .phase_sel_out    (phase_sel_sump[ipin*3+:3]),
    .phase_err        (phase_err[ipin]),

    .sump             (sbit_sump[ipin]),

    .d0(d0[ipin]),
    .d1(d1[ipin])
  );
end
endgenerate

generate
for (ifat=0; ifat<24; ifat=ifat+1) begin: fatloop2

  frame_aligner #(.DDR(DDR))
  frame_align (
    .d0 (d0[ifat*8 +: 8]),
    .d1 (d1[ifat*8 +: 8]),

    .mask  (sbit_mask[ifat]),
    .reset (reset || ~(idelay_ready)),

    .start_of_frame (start_of_frame_d0[ifat]),
    .clock          (clock),
    .fastclock      (fastclk_0),

    .sof_delayed    (sof_dly[ifat]),

    .alignment_error (alignment_err[ifat]),
    .sbits(sbits[ifat*MXSBITS +: MXSBITS])
  );

end
endgenerate

assign sump = (|phase_err) || (|alignment_err) || (|sot_phase_err) || (|start_of_frame_d1) || (|sof_dly) || (|phase_sel_sump) || (|sof_sump) || (|sbit_sump);

endmodule
