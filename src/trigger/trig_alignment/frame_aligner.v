// takes in 8 serial data streams from a single VFAT, and phase aligns them to 40 MHz LHC clock
// align the bitstream to the frame clock and deserialize to 40MHz

module frame_aligner (
  input [MXIO-1:0] d0, // data from posedge of ddr
  input [MXIO-1:0] d1, // data from negedge of ddr

  input start_of_frame,

  input reset,
  input mask,

  input clock,
  input fastclock,

  output alignment_error,
  output sof_delayed,
  output [MXSBITS-1:0] sbits
);

parameter DDR=0;
parameter MXSBITS=64+64*DDR;
parameter MXIO = 8;
parameter WORD_SIZE = MXSBITS / MXIO;

wire posneg;
reg ready=0;

wire [7:0] d0_dly_pos;
wire [7:0] d1_dly_pos;

wire [7:0] d0_dly_neg;
wire [7:0] d1_dly_neg;

wire sof_dly;
wire sof_dly180;

// delay sof by a to compensate for the s-bit even/odd fifo output equivalent delay
wire sof_dly0b, sof_dly180b;
wire [3:0] srl_adr2 = 4'd3;


reg [3:0] srl_adr=0; // frame alignment srl_adr

SRL16E  srlsof0a   (.CLK( fastclock),.CE(1'b1),.D(start_of_frame),.A0(srl_adr[0]),.A1(srl_adr[1]),.A2(srl_adr[2]),.A3(srl_adr[3]),.Q(sof_dly));
SRL16E  srlsof180a (.CLK(~fastclock),.CE(1'b1),.D(start_of_frame),.A0(srl_adr[0]),.A1(srl_adr[1]),.A2(srl_adr[2]),.A3(srl_adr[3]),.Q(sof_dly180));

// use SRL instead of flip-flops
SRL16E  srlsof0b   (.CLK( fastclock),.CE(1'b1),.D(sof_dly   ),.A0(srl_adr2[0]),.A1(srl_adr2[1]),.A2(srl_adr2[2]),.A3(srl_adr2[3]),.Q(sof_dly0b));
SRL16E  srlsof180b (.CLK(~fastclock),.CE(1'b1),.D(sof_dly180),.A0(srl_adr2[0]),.A1(srl_adr2[1]),.A2(srl_adr2[2]),.A3(srl_adr2[3]),.Q(sof_dly180b));

// data delay

wire [4:0] srl_adr0 = srl_adr;
wire [4:0] srl_adr1 = srl_adr;

genvar ibit;
generate
  for (ibit=0; ibit<8; ibit=ibit+1) begin: bloop
  // odd bits
  SRL16E srldat0_pos (.CLK( fastclock),.CE(1'b1),.D(d0[ibit]),.A0(srl_adr0[0]),.A1(srl_adr0[1]),.A2(srl_adr0[2]),.A3(srl_adr0[3]),.Q(d0_dly_pos[ibit]));
  SRL16E srldat0_neg (.CLK(~fastclock),.CE(1'b1),.D(d0[ibit]),.A0(srl_adr0[0]),.A1(srl_adr0[1]),.A2(srl_adr0[2]),.A3(srl_adr0[3]),.Q(d0_dly_neg[ibit]));

  // even bits
  SRL16E srldat1_pos (.CLK( fastclock),.CE(1'b1),.D(d1[ibit]),.A0(srl_adr1[0]),.A1(srl_adr1[1]),.A2(srl_adr1[2]),.A3(srl_adr1[3]),.Q(d1_dly_pos[ibit]));
  SRL16E srldat1_neg (.CLK(~fastclock),.CE(1'b1),.D(d1[ibit]),.A0(srl_adr1[0]),.A1(srl_adr1[1]),.A2(srl_adr1[2]),.A3(srl_adr1[3]),.Q(d1_dly_neg[ibit]));
  end
endgenerate

wire [7:0] d0_dly = posneg ? d0_dly_pos : d0_dly_neg;
wire [7:0] d1_dly = posneg ? d1_dly_pos : d1_dly_neg;

// fifo rising (even) and falling (odd) bits separately, interleave leater
reg [WORD_SIZE/2-1:0] sbit_fifo_odd_pos  [MXIO-1:0];
reg [WORD_SIZE/2-1:0] sbit_fifo_even_pos [MXIO-1:0];
reg [WORD_SIZE/2-1:0] sbit_fifo_odd_neg  [MXIO-1:0];
reg [WORD_SIZE/2-1:0] sbit_fifo_even_neg [MXIO-1:0];

wire [WORD_SIZE/2-1:0] sbit_fifo_odd      [MXIO-1:0];
wire [WORD_SIZE/2-1:0] sbit_fifo_even     [MXIO-1:0];


wire [7:0] sbits_interleaved_lsbs [MXIO-1:0];
wire [7:0] sbits_interleaved_msbs [MXIO-1:0];
wire [WORD_SIZE-1:0] sbits_interleaved      [MXIO-1:0];


genvar ipin;
generate
for (ipin=0; ipin<8; ipin=ipin+1) begin: bloop2

  always @(posedge fastclock) begin
    sbit_fifo_odd_pos  [ipin][WORD_SIZE/2-1:0] <= {sbit_fifo_odd_pos  [ipin][WORD_SIZE/2-2:0] , d0_dly_pos[ipin]};
    sbit_fifo_even_pos [ipin][WORD_SIZE/2-1:0] <= {sbit_fifo_even_pos [ipin][WORD_SIZE/2-2:0] , d1_dly_pos[ipin]};
  end

  always @(negedge fastclock) begin
    sbit_fifo_odd_neg  [ipin][WORD_SIZE/2-1:0] <= {sbit_fifo_odd_neg  [ipin][WORD_SIZE/2-2:0] , d0_dly_neg[ipin]};
    sbit_fifo_even_neg [ipin][WORD_SIZE/2-1:0] <= {sbit_fifo_even_neg [ipin][WORD_SIZE/2-2:0] , d1_dly_neg[ipin]};
  end


  assign sbit_fifo_odd[ipin]  = posneg ? sbit_fifo_odd_pos[ipin]  : sbit_fifo_odd_neg[ipin];
  assign sbit_fifo_even[ipin] = posneg ? sbit_fifo_even_pos[ipin] : sbit_fifo_even_neg[ipin];

  // at VFAT double-data rate, we want to deserialize 16 bits at once
  if (DDR) begin
  assign sbits_interleaved_msbs[ipin] =

    DDR ?

    { sbit_fifo_even[ipin][7],
    sbit_fifo_odd [ipin][7],
    sbit_fifo_even[ipin][6],
    sbit_fifo_odd [ipin][6],
    sbit_fifo_even[ipin][5],
    sbit_fifo_odd [ipin][5],
    sbit_fifo_even[ipin][4],
    sbit_fifo_odd [ipin][4] } :

    0 ;

  end

  // at VFAT single-data rate, we want to deserialize 8 bits at once
  assign sbits_interleaved_lsbs[ipin] = {
    sbit_fifo_even[ipin][3],
    sbit_fifo_odd [ipin][3],
    sbit_fifo_even[ipin][2],
    sbit_fifo_odd [ipin][2],
    sbit_fifo_even[ipin][1],
    sbit_fifo_odd [ipin][1],
    sbit_fifo_even[ipin][0],
    sbit_fifo_odd [ipin][0]
   };

  if (DDR)
    assign sbits_interleaved[ipin]= {sbits_interleaved_msbs[ipin], sbits_interleaved_lsbs[ipin]};
  else
    assign sbits_interleaved[ipin] = sbits_interleaved_lsbs[ipin];

end
endgenerate

// output
reg [MXSBITS-1:0] sbits_reg;
assign sbits = sbits_reg;

always @(posedge clock) begin
  // kill the outputs if we aren't aligned to SOF
  if (reset || mask || ~ready)
    sbits_reg <= {MXSBITS{1'b0}};
  else
    sbits_reg <= {
      sbits_interleaved[7],
      sbits_interleaved[6],
      sbits_interleaved[5],
      sbits_interleaved[4],
      sbits_interleaved[3],
      sbits_interleaved[2],
      sbits_interleaved[1],
      sbits_interleaved[0]
      };
end

// look for rising edge of the sof signal
reg sof_last_pos;
reg sof_last_neg;
always @(posedge fastclock) begin
  sof_last_pos <= sof_dly0b;
  sof_last_neg <= sof_dly180b;
end

// 40 MHz stable sof aligned flag
reg sof_aligned_pos = 0;
reg sof_aligned_neg = 0;
always @(posedge clock) begin
  sof_aligned_pos <= !sof_last_pos && sof_dly0b;
  sof_aligned_neg <= !sof_last_neg && sof_dly180b;
end

// posneg==1 choose positive
assign posneg = (sof_aligned_pos);

assign sof_delayed = posneg ? sof_dly0b : sof_dly180b;

wire sof_aligned = sof_aligned_pos || sof_aligned_neg;

reg [7:0] sof_r;
always @(posedge clock) begin
  sof_r <= {sof_r[6:0],sof_aligned};
  ready <= &sof_r;
end

// can't check this every clock cycle because there is latency between changing it and the result propagating to the output
reg check_sof = 0;
always @(negedge clock) begin

  check_sof <= ! check_sof;

  if (check_sof && !sof_aligned)
    srl_adr=srl_adr+1'b1;
end

assign alignment_error = ready && !sof_aligned;

endmodule
