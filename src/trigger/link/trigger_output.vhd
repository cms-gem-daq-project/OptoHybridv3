
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

library work;
use work.types_pkg.all;
use work.ipbus_pkg.all;
use work.hardware_pkg.all;

entity trigger_output is
  generic (
    NUM_CLUSTERS         : integer := 5;
    NUM_OVERFLOW_MAX     : integer := 5;
    NUM_ELINKS           : integer := 11;
    USE_TMR_MGT_CONTROL  : integer := 1;
    USE_TMR_MGT_DATA     : integer := 1;
    FPGA_TYPE_IS_VIRTEX6 : integer := 0;
    FPGA_TYPE_IS_ARTIX7  : integer := 0;
    ALLOW_TTC_CHARS      : integer := 1;
    ALLOW_RETRY          : integer := 1;
    FRAME_CTRL_TTC       : integer := 1
    );
  port(
    ----------------------------------------------------------------------------------------------------------------------
    -- Core
    ----------------------------------------------------------------------------------------------------------------------

    clocks : in clocks_t;

    reset_i : in std_logic;

    ----------------------------------------------------------------------------------------------------------------------
    -- Physical
    ----------------------------------------------------------------------------------------------------------------------

    -- gtp/gtx
    trg_tx_n : out std_logic_vector(3 downto 0);
    trg_tx_p : out std_logic_vector(3 downto 0);

    -- refclk
    refclk_p : in std_logic_vector(1 downto 0);
    refclk_n : in std_logic_vector(1 downto 0);

    -- gbtx trigger data (ge21)
    gbt_trig_p : out std_logic_vector(NUM_ELINKS-1 downto 0);
    gbt_trig_n : out std_logic_vector(NUM_ELINKS-1 downto 0);

    ----------------------------------------------------------------------------------------------------------------------
    -- Data
    ----------------------------------------------------------------------------------------------------------------------

    clusters          : in sbit_cluster_array_t (7 downto 0);

    ttc : in ttc_t;

    overflow_i : in std_logic;          -- 1 bit gem has more than 8 clusters

    bxn_counter_i : in std_logic_vector (11 downto 0);  -- 12 bit bxn counter

    error_i : in std_logic;             -- 1  bit error flag

    ----------------------------------------------------------------------------------------------------------------------
    -- Control
    ----------------------------------------------------------------------------------------------------------------------

    mgt_control : in  mgt_control_t;
    mgt_status  : out mgt_status_t

    );
end trigger_output;

architecture Behavioral of trigger_output is

  signal reset : std_logic;

  signal elink_data    : std_logic_vector (NUM_ELINKS*8-1 downto 0);
  signal optical_data0 : std_logic_vector (79 downto 0);
  signal optical_data1 : std_logic_vector (79 downto 0);

  signal ecc8     : std_logic_vector (7 downto 0);
  signal ecc8_2nd : std_logic_vector (7 downto 0);
  signal comma    : std_logic_vector (7 downto 0);

  signal reserved_bit : std_logic_vector (NUM_CLUSTERS-1 downto 0) := (others => '0');
  signal special_bit  : std_logic_vector (NUM_CLUSTERS-1 downto 0);

  signal cluster_output : t_std16_array (4 downto 0);

  signal mgt_reset : std_logic;

begin

  --------------------------------------------------------------------------------
  -- Reset
  --------------------------------------------------------------------------------
  process (clocks.clk40)
  begin
    if (rising_edge(clocks.clk40)) then
      reset <= reset_i;
    end if;
  end process;

  --------------------------------------------------------------------------------
  -- Special bit allocation
  --------------------------------------------------------------------------------

  -- 3'h0 BXN[1:0]==2'h0
  -- 3'h1 BXN[1:0]==2'h1
  -- 3'h2 BXN[1:0]==2'h2
  -- 3'h3 BXN[1:0]==2'h3
  -- 3'h4 Overflow
  -- 3'h5 Resync
  -- 3'h6 Reserved
  -- 3'h7 Error

  special_bit(0) <= ttc.bc0;
  process (error_i, ttc, overflow_i)
  begin
    if (error_i = '1') then
      special_bit (3 downto 1) <= std_logic_vector(to_unsigned(7,3));
    elsif (ttc.resync = '1') then
      special_bit (3 downto 1) <= std_logic_vector(to_unsigned(5,3));
    elsif (overflow_i = '1') then
      special_bit (3 downto 1) <= std_logic_vector(to_unsigned(4,3));
    else
      special_bit (3 downto 1) <= '0' & bxn_counter_i(1 downto 0);
    end if;
  end process;

  --------------------------------------------------------------------------------
  -- Cluster assignment
  --------------------------------------------------------------------------------

  clusterloop : for I in 0 to NUM_CLUSTERS-1 generate  -- 5 clusters in GE2/1, 4 + 4 in GE1/1
  begin
    cluster_output (I) <= '0' & special_bit(I) & reserved_bit(I) &
                          clusters(I).cnt & clusters(I).prt & clusters(I).adr;
  end generate;

  --------------------------------------------------------------------------------
  -- ECC
  --------------------------------------------------------------------------------

--  ecc64_inst : entity work.ecc64
--    port map (
--      enc_in     => (cluster_output(3) & cluster_output(2) & cluster_output(1) & cluster_output(0)),
--      parity_out => ecc8
--      );
--
--  ge11_ecc8_2nd : if (GE11 = 1) generate
--    ecc64_inst : entity work.ecc64
--      port map (
--        enc_in     => (cluster_output(7) & cluster_output(6) & cluster_output(5) & cluster_output(4)),
--        parity_out => ecc8_2nd
--        );
--  end generate;

  --------------------------------------------------------------------------------
  -- Data Format
  --------------------------------------------------------------------------------

  comma <= x"DC" when ttc.bc0='1' else x"BC";

  process (clocks.clk40)
  begin
    if (rising_edge(clocks.clk40)) then
      elink_data    <= ecc8 & cluster_output(4) & cluster_output(3) & cluster_output(2) & cluster_output(1) & cluster_output(0);
      optical_data0 <= comma & ecc8 & cluster_output(3) & cluster_output(2) & cluster_output(1) & cluster_output(0);
    end if;
  end process;

  ge11_data : if (GE11 = 1) generate
    process (clocks.clk40)
    begin
      if (rising_edge(clocks.clk40)) then
        optical_data1 <= comma & ecc8 & cluster_output(7) & cluster_output(6) & cluster_output(5) & cluster_output(4);
      end if;
    end process;
  end generate;

  --------------------------------------------------------------------------------
  -- Copper output
  --------------------------------------------------------------------------------

  ge21_elink_gen : if (GE21 = 1) and HAS_ELINK_OUTPUTS generate
    elink_outputs : for I in 0 to (NUM_ELINKS-1) generate
    begin
      to_gbt_ser_inst : entity work.to_gbt_ser
        port map (
          data_out_from_device => elink_data(8*(I+1)-1 downto 8*I),
          data_out_to_pins_p(0)   => gbt_trig_p(I),
          data_out_to_pins_n(0)   => gbt_trig_n(I),
          clk_in                  => clocks.clk160_0,
          clk_div_in              => clocks.clk40,
          io_reset                => reset
          );
    end generate;
  end generate;

  --------------------------------------------------------------------------------
  -- Optical Links
  --------------------------------------------------------------------------------

--    gem_fiber_out_inst : entity work.gem_fiber_out (
--
--
--    );

end Behavioral;
