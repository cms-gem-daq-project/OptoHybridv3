library ieee;
library unisim;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use unisim.vcomponents.all;

entity a7_trig_tx_buf_bypass_cpll_railing is
  generic(
    USE_BUFG       : integer := 0
  );
  port  (
    cpll_reset_out : out std_logic;
    cpll_pd_out    : out std_logic;
    refclk_out     : out std_logic;
    refclk_in      : in std_logic
  );
end a7_trig_tx_buf_bypass_cpll_railing;

architecture RTL of a7_trig_tx_buf_bypass_cpll_railing is

------------------------------------------------------------------------------------------------------------------------
-- Signals
------------------------------------------------------------------------------------------------------------------------

    -- ground and tied_to_vcc_i signals
    signal tied_to_ground_i     : std_logic;
    signal tied_to_ground_vec_i : std_logic_vector(63 downto 0);
    signal tied_to_vcc_i        : std_logic;
    signal cpllpd_wait           : std_logic_vector(95 downto 0)  := x"FFFFFFFFFFFFFFFFFFFFFFFF";
    signal cpllreset_wait        : std_logic_vector(127 downto 0) := x"000000000000000000000000000000FF";

    attribute equivalent_register_removal: string;
    attribute equivalent_register_removal of cpllpd_wait : signal is "no";
    attribute equivalent_register_removal of cpllreset_wait : signal is "no";
    signal    gtrefclk0_i      :std_logic ;

begin

  ---------------------------  Static signal Assignments ---------------------

  tied_to_ground_i                    <= '0';
  tied_to_ground_vec_i(63 downto 0)   <= (others => '0');
  tied_to_vcc_i                       <= '1';

  use_bufg_cpll:
  if(USE_BUFG = 1) generate
    refclk_buf : BUFG
    port map (O   => gtrefclk0_i, I   => refclk_in);
  end generate;

  use_bufh_cpll:
  if(USE_BUFG = 0) generate
    refclk_buf : BUFH
    port map (O   => gtrefclk0_i, I   => refclk_in);
  end generate;

  process( gtrefclk0_i )
  begin
    if(gtrefclk0_i'event and gtrefclk0_i = '1') then
      cpllpd_wait <= cpllpd_wait(94 downto 0) & '0';
      cpllreset_wait <= cpllreset_wait(126 downto 0) & '0';
    end if;
  end process;

cpll_pd_out    <= cpllpd_wait(95);
cpll_reset_out <= cpllreset_wait(127);
refclk_out     <= gtrefclk0_i;

 end RTL;
