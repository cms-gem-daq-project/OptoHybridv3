module led_control (
  input clock,
  input mmcm_locked,
  input gbt_eclk,
  input gbt_rxready,
  input gbt_rxvalid,

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

  always @(posedge clock) begin
    if (mmcm_locked)
      led_out <= (cylon_mode) ? led_cylon : led_logic;
    else
      led_out <= clk_led;
 end

//----------------------------------------------------------------------------------------------------------------------
// LED Blinkers
//----------------------------------------------------------------------------------------------------------------------

  // count to 20 bits for 40 MHz clock to divide to 4 Hz

  wire clk = clock;

  reg [19:0] clk_cnt;
  reg        clk_led;
  always @(posedge clk) begin
    clk_cnt <= clk_cnt + 1'b1;

    if (clk_cnt==0)
      clk_led <= ~ clk_led;
  end

  // count to 19 bits for 80 MHz clock to divide to 4 Hz

  wire eclk = gbt_eclk;

  reg [19:0] eclk_cnt;
  reg        eclk_led;
  always @(posedge eclk) begin
    eclk_cnt <= eclk_cnt + 1'b1;

    if (eclk_cnt==0)
      eclk_led <= ~ eclk_led;
  end

//----------------------------------------------------------------------------------------------------------------------
// Rate Display
//----------------------------------------------------------------------------------------------------------------------

  wire [11:0] progress_bar;


  rate_counter #(
    .g_CLK_FREQUENCY         (32'd40000000), // 40MHz LHC frequency
    .g_COUNTER_WIDTH         (32'd32),
    .g_INCREMENTER_WIDTH     (32'd8),
    .g_PROGRESS_BAR_WIDTH    (32'd12),       // we'll have 13 LEDs as a rate progress bar
    .g_PROGRESS_BAR_STEP     (32'd20000),    // each bar is 20KHz
    .g_SPEEDUP_FACTOR        (32'd4)         // update 16 times per second
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

  cylon1 u_cylon (clock, 2'd0, led_cylon[11:0]);

  assign led_cylon [15:12] = led_logic[15:12];

  // go into cylon mode if we've seen a cluster this run
  reg clustered = 0;
  always @(posedge clock) begin
    if (cluster_count > 0)
      clustered <= 1'b1;
  end

  assign cylon_mode = clustered;

//----------------------------------------------------------------------------------------------------------------------
// Logic LED Assignments
//----------------------------------------------------------------------------------------------------------------------

  assign led_logic [11:0] = progress_bar;
  assign led_logic [12]   = clk_led;
  assign led_logic [13]   = eclk_led;
  assign led_logic [14]   = mmcm_locked;
  assign led_logic [15]   = gbt_rxready && gbt_rxvalid;

endmodule
