module led_control (
  input clock,
  input mmcm_locked,
  input gbt_eclk,

  input ttc_l1a, 
  input ttc_bc0, 
  input ttc_resync, 
  input vfat_reset,

  input gbt_rxready,
  input gbt_rxvalid,
  input gbt_request_received,

  input reset,

  input [7:0] cluster_count,

  output [31:0] cluster_rate,

  output reg [15:0] led_out
);

//----------------------------------------------------------------------------------------------------------------------
// LED Source
//----------------------------------------------------------------------------------------------------------------------


  wire cylon_mode;

  wire [15:0] led_cylon;
  wire [15:0] led_logic;
  wire [15:0] led_err;

  reg [15:0] led;

  //synthesis attribute IOB of led_out is "FORCE"
  always @(posedge clock) begin
      led_out <= led;
  end

  always @(*) begin
    if (mmcm_locked && !reset)
      led <= (cylon_mode) ? led_cylon : led_logic;
    else
      led <= led_err;
  end

//----------------------------------------------------------------------------------------------------------------------
// LED Blinkers
//----------------------------------------------------------------------------------------------------------------------

  // count to 21 bits for 40 MHz clock to divide to 2 Hz

  wire clk = clock;

  reg [20:0] clk_cnt=0;
  reg        clk_led=0;
  always @(posedge clk) begin
    clk_cnt <= clk_cnt + 1'b1;

    if (clk_cnt==0)
      clk_led <= ~ clk_led;
  end

  // count to 21 bits for 40 MHz clock to divide to 2 Hz

  wire eclk = gbt_eclk;

  reg [20:0] eclk_cnt=0;
  reg        eclk_led=0;
  always @(posedge eclk) begin
    eclk_cnt <= eclk_cnt + 1'b1;

    if (eclk_cnt==0)
      eclk_led <= ~ eclk_led;
  end

//----------------------------------------------------------------------------------------------------------------------
// Rate Display
//----------------------------------------------------------------------------------------------------------------------

  wire [7:0] progress_bar;


  rate_counter #(
    .g_LOGARITHMIC           (32'd1), // 1 for LOG scale (ignores step )
    .g_CLK_FREQUENCY         (32'd40079000), // 40MHz LHC frequency
    .g_COUNTER_WIDTH         (32'd32),
    .g_INCREMENTER_WIDTH     (32'd8),
    .g_PROGRESS_BAR_WIDTH    (32'd8),   // we'll have 8 LEDs as a rate progress bar
    .g_PROGRESS_BAR_STEP     (32'd100), // each bar is 100 Hz
    .g_SPEEDUP_FACTOR        (32'd4)    // update 16 times per second
  )
  u_rate_cnt (
    .clk_i           (clock),
    .reset_i         (reset),
    .increment_i     (cluster_count),
    .rate_o          (cluster_rate),
    .progress_bar_o  (progress_bar)
  );

//----------------------------------------------------------------------------------------------------------------------
// Cylon Mode
//----------------------------------------------------------------------------------------------------------------------

  cylon1 u_cylon (clock, 2'd0, led_cylon[7:0]);

  assign led_cylon [15:8] = led_logic[15:8];

  // go into cylon mode if we've seen a cluster this run
  reg first_sbit_seen = 0;
  always @(posedge clock) begin
    if (ttc_resync) 
      first_sbit_seen <= 1'b0; 
    else if (cluster_count > 0)
      first_sbit_seen <= 1'b1;
  end

  // once we see s-bits, leave cylon mode and start the rate counter
  assign cylon_mode = ~first_sbit_seen;

//----------------------------------------------------------------------------------------------------------------------
// Error Mode
//----------------------------------------------------------------------------------------------------------------------

  err_indicator u_err_ind (clock, 2'd0, ~mmcm_locked, led_err[15:0]);

//----------------------------------------------------------------------------------------------------------------------
// GBT Req Rx
//----------------------------------------------------------------------------------------------------------------------

  wire gbt_flash;
  x_flashsm flash_gbt (gbt_request_received, 1'b0, clock, gbt_flash);

//----------------------------------------------------------------------------------------------------------------------
// TTC Flash
//----------------------------------------------------------------------------------------------------------------------

  wire bc0_flash, resync_flash, l1a_flash, vfat_reset_flash;

  x_flashsm flash_l1a        (ttc_l1a,    1'b0, clock, l1a_flash);
  x_flashsm flash_bc0        (ttc_bc0,    1'b0, clock, bc0_flash);
  x_flashsm flash_resync     (ttc_resync, 1'b0, clock, resync_flash);
  x_flashsm flash_vfat_reset (vfat_reset, 1'b0, clock, vfat_reset_flash);

//----------------------------------------------------------------------------------------------------------------------
// Logic LED Assignments
//----------------------------------------------------------------------------------------------------------------------

  assign led_logic [7:0]  = progress_bar;

  assign led_logic [8]    = vfat_reset_flash;
  assign led_logic [9]    = bc0_flash;
  assign led_logic [10]   = resync_flash;
  assign led_logic [11]   = l1a_flash;

  assign led_logic [12]   = gbt_flash;
  assign led_logic [13]   = clk_led;
  assign led_logic [14]   = eclk_led;
  assign led_logic [15]   = gbt_rxready && gbt_rxvalid;

endmodule
