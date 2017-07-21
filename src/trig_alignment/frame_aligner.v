// takes in 8 serial data streams from a single VFAT, and phase aligns them to 40 MHz LHC clock
// align the bitstream to the frame clock and deserialize to 40MHz

module frame_aligner (
  input [MXIO-1:0] d0, // data from posedge of ddr
  input [MXIO-1:0] d1, // data from negedge of ddr

  input start_of_frame,

  input clock,
  input fastclock,

  output alignment_error,
  output sof_delayed,
  output [MXSBITS-1:0] sbits
);

// Startup -- keeps outputs off during powerup
//---------------------------------------------

wire [3:0] powerup_dly = 4'd8;

reg powerup_ff  = 0;
SRL16E u_startup (.CLK(clock),.CE(!powerup),.D(1'b1),.A0(powerup_dly[0]),.A1(powerup_dly[1]),.A2(powerup_dly[2]),.A3(powerup_dly[3]),.Q(powerup));
always @(posedge clock) powerup_ff <= powerup;
wire ready = powerup_ff;

parameter DDR=0;
parameter MXSBITS=64+64*DDR;
parameter MXIO = 8;
parameter WORD_SIZE = MXSBITS / MXIO;


wire [7:0] d0_dly;
wire [7:0] d1_dly;

wire sof_dly;


reg [3:0] adr=0; // frame alignment adr

SRL16E  srlsof (.CLK(fastclock),.CE(1'b1),.D(start_of_frame),.A0(adr[0]),.A1(adr[1]),.A2(adr[2]),.A3(adr[3]),.Q(sof_dly));

genvar ibit;
generate
  for (ibit=0; ibit<8; ibit=ibit+1) begin: bloop
  SRL16E srldat0 (.CLK(fastclock),.CE(1'b1),.D(d0[ibit]),.A0(adr[0]),.A1(adr[1]),.A2(adr[2]),.A3(adr[3]),.Q(d0_dly[ibit]));
  SRL16E srldat1 (.CLK(fastclock),.CE(1'b1),.D(d1[ibit]),.A0(adr[0]),.A1(adr[1]),.A2(adr[2]),.A3(adr[3]),.Q(d1_dly[ibit]));
  end
endgenerate

// ff the output of the srl
reg [7:0] d0_dly2;
reg [7:0] d1_dly2;

// fifo rising (even) and falling (odd) bits separately, interleave leater
reg [WORD_SIZE/2-1:0] sbit_fifo_odd  [MXIO-1:0];
reg [WORD_SIZE/2-1:0] sbit_fifo_even [MXIO-1:0];

wire [7:0] sbits_interleaved_lsbs [MXIO-1:0];
wire [7:0] sbits_interleaved_msbs [MXIO-1:0];
wire [WORD_SIZE-1:0] sbits_interleaved      [MXIO-1:0];

wire sof_dly2;
wire [3:0] adr_dly2 = 4'd3;

// delay sof by a 3 ff equivalent to compensate for the s-bit even/odd fifo output equivalent delay
// use SRL instead of flip-flops
SRL16E  srlsof2 (.CLK(fastclock),.CE(1'b1),.D(sof_dly),.A0(adr_dly2[0]),.A1(adr_dly2[1]),.A2(adr_dly2[2]),.A3(adr_dly2[3]),.Q(sof_dly2));

genvar ipin;
generate
for (ipin=0; ipin<8; ipin=ipin+1) begin: bloop2

  always @(posedge fastclock) begin
    sbit_fifo_odd  [ipin][WORD_SIZE/2-1:0] <= {sbit_fifo_odd [ipin][WORD_SIZE/2-2:0] , d0_dly[ipin]};
    sbit_fifo_even [ipin][WORD_SIZE/2-1:0] <= {sbit_fifo_even[ipin][WORD_SIZE/2-2:0] , d1_dly[ipin]};
  end

  // at VFAT double-data rate, we want to deserialize 16 bits at once
  assign sbits_interleaved_msbs[ipin] =
    DDR ?
    {
    sbit_fifo_even[ipin][7],
    sbit_fifo_odd [ipin][7],
    sbit_fifo_even[ipin][6],
    sbit_fifo_odd [ipin][6],
    sbit_fifo_even[ipin][5],
    sbit_fifo_odd [ipin][5],
    sbit_fifo_even[ipin][4],
    sbit_fifo_odd [ipin][4]
    }
    : 0
    ;

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

// if the data is aligned to POSEDGE of the 40 MHz clock then we need to sample on the NEGEDGE
// use the remaining 1/2 clock to transfer to the cluster finder on the posedge of its inputs
always @(negedge clock) begin
  // kill the outputs if we aren't aligned to SOF
  if (~sof_aligned)
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
reg sof_last;
always @(posedge fastclock) begin
  sof_last <= start_of_frame;
end

// 40 MHz stable sof aligned flag
reg sof_aligned = 0;
always @(posedge clock) begin
  sof_aligned <= sof_dly2 && sof_last==1'b0;
end

assign sof_delayed = sof_dly2;

always @(negedge clock) begin
  if (!sof_aligned)
    adr=adr+1'b1;
end

assign alignment_error = ready && !sof_aligned;

endmodule
