library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

entity oversample is
generic (
  g_PHASE_SEL_EXTERNAL : boolean := FALSE;
  g_BIT_WIDTH          : integer := 8;
  g_NUM_TAPS_45        : integer := 10
);
port(
  invert        : in std_logic := '0';
  rxd_p         : in std_logic;
  rxd_n         : in std_logic;
  clk2x_0       : in std_logic;
  clk2x_90      : in std_logic;
  clk2x_180     : in std_logic;
  clk1x_logic   : in std_logic;
  clk2x_logic   : in std_logic;
  rst           : in std_logic;
  tap_delay_i   : in std_logic_vector (4 downto 0) := "00000";
  phase_sel_in  : in std_logic_vector (1 downto 0) := "00";
  phase_sel_out : out std_logic_vector (1 downto 0);
  rxdata_o      : out std_logic_vector (g_BIT_WIDTH-1 downto 0)
);
end oversample;

architecture behavioral of oversample is

  signal reset         : std_logic;
  signal data_p,data_n : std_logic;
  signal q             : std_logic_vector(g_BIT_WIDTH-1 downto 0);
  signal rxdata        : std_logic_vector(g_BIT_WIDTH-1 downto 0):=(others=>'0');
  signal rxdata_inv    : std_logic_vector(g_BIT_WIDTH-1 downto 0):=(others=>'0');
  signal rxce          : std_logic:='0';
  signal data          : std_logic_vector(1 downto 0);
  signal tap_delay_0   : std_logic_vector (tap_delay_i'high downto 0);
  signal tap_delay_45  : std_logic_vector (tap_delay_i'high downto 0);

begin

  ----------------------------------------------------------------------------------------------------------------------
  -- Reset
  ----------------------------------------------------------------------------------------------------------------------

  process(clk2x_0)
  begin
    if rising_edge(clk2x_0) then
      reset <= rst;
    end if;
  end process;

  ----------------------------------------------------------------------------------------------------------------------
  -- Tap Delay Addition
  ----------------------------------------------------------------------------------------------------------------------

  process(clk2x_0)
  begin
    if rising_edge(clk2x_0) then
      tap_delay_0  <= tap_delay_i ;
      tap_delay_45 <= std_logic_vector (unsigned(tap_delay_i)  + to_unsigned(g_NUM_TAPS_45,tap_delay_i'length));
    end if;
  end process;

  ----------------------------------------------------------------------------------------------------------------------
  -- IBUFDS
  ----------------------------------------------------------------------------------------------------------------------

  rx_ibuf_d:ibufds_diff_out
  generic map(
          IBUF_LOW_PWR => TRUE,
          DIFF_TERM    => TRUE,
          IOSTANDARD   => "LVDS_25")
  port map(
          i=>rxd_p,
          ib=>rxd_n,
          o=>data_p,
          ob=>data_n
  );

  ----------------------------------------------------------------------------------------------------------------------
  -- IODELAY in FPGA agnostic wrapper
  ----------------------------------------------------------------------------------------------------------------------

  delay_master : entity work.iodelay
  port map(
          tap_delay_i => tap_delay_0,
          data_i      => data_p,
          data_o      => data(0)
  );

  delay_slave  : entity work.iodelay
  port map(
          tap_delay_i => tap_delay_45,
          data_i      => data_n,
          data_o      => data(1)
  );

  ----------------------------------------------------------------------------------------------------------------------
  -- ISERDES in FPGA agnostic wrapper
  ----------------------------------------------------------------------------------------------------------------------

  ise1_m: entity work.iserdes
  port map(
          reset_i   => reset,
          clk2x_0   => clk2x_0,
          clk2x_180 => clk2x_180,
          clk2x_90  => clk2x_90,
          data_i    => data(0),
          data_o(0) => q(1),
          data_o(1) => q(5),
          data_o(2) => q(3),
          data_o(3) => q(7)
  );

  ise1_s: entity work.iserdes
  port map(
          reset_i   => reset,
          clk2x_0   => clk2x_0,
          clk2x_180 => clk2x_180,
          clk2x_90  => clk2x_90,
          data_i    => data(1),
          data_o(0) => q(0),
          data_o(1) => q(4),
          data_o(2) => q(2),
          data_o(3) => q(6)
  );

  ----------------------------------------------------------------------------------------------------------------------
  -- Data Recovery Unit
  ----------------------------------------------------------------------------------------------------------------------

  dru: entity work.dru
  generic map(
    g_PHASE_SEL_EXTERNAL => g_PHASE_SEL_EXTERNAL
  )
  port map(
          i             => q,             -- the even bits are inverted!
          clk1x         => clk1x_logic,   --
          clk2x         => clk2x_logic,   --
          phase_sel_in  => phase_sel_in,  --
          phase_sel_out => phase_sel_out, --
          o             => rxdata,        -- 8-bit deserialized data
          vo            => rxce           --
  );

  rxdata_inv <= rxdata when invert='0' else not rxdata;

  rxdata_o <= (others => '0') when reset='1' else rxdata_inv (g_BIT_WIDTH-1 downto 0);

end behavioral;
