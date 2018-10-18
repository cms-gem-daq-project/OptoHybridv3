----------------------------------------------------------------------------------
-- CMS Muon Endcap
-- GEM Collaboration
-- Optohybrid v3 Firmware -- GBT SerDes
-- T. Lenzi, E. Juska, A. Peck
----------------------------------------------------------------------------------
-- Description:
--   This module serializes and deserializes e-link data to and from the GBTx
----------------------------------------------------------------------------------
-- 2017/07/24 -- Conversion to 16 bit (2 elinks only)
-- 2017/07/24 -- Addition of flip-flop synchronization stages for X-domain transit
-- 2017/08/09 -- rework of module to cleanup and document source
-- 2017/08/26 -- Addition of actual CDC fifo
-- 2018/04/19 -- Addition of Artix-7 Support
-- 2018/09/27 -- Conversion to single elink communication
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

library work;
use work.param_pkg.all;

entity gbt_serdes is
generic(
    BITSLIP_ERR_CNT_MAX : integer := 16;
    MXBITS : integer := 8
);
port(

    reset_i          : in std_logic;

    -- input clocks

    gbt_clk40      : in std_logic; -- 40 MHz phase shiftable frame clock from GBT
    gbt_clk80      : in std_logic; -- 320 MHz phase shiftable frame clock from GBT
    gbt_clk160_0   : in std_logic; -- 320 MHz phase shiftable frame clock from GBT
    gbt_clk160_90  : in std_logic; -- 320 MHz phase shiftable frame clock from GBT
    gbt_clk160_180 : in std_logic; -- 320 MHz phase shiftable frame clock from GBT
    gbt_clk320     : in std_logic; -- 320 MHz phase shiftable frame clock from GBT

    clock            : in std_logic;

    tx_delay_i       : in std_logic_vector (4 downto 0) := (others => '0');

    -- serial data to/from GBTx
    elink_o_p        : out std_logic;
    elink_o_n        : out std_logic;

    elink_i_p        : in  std_logic;
    elink_i_n        : in  std_logic;

    gbt_link_error_i : in std_logic; -- error on gbt rx
    gbt_ready_i      : in std_logic;

    -- parallel data to/from FPGA logic
    data_i           : in  std_logic_vector (MXBITS-1 downto 0);
    data_o           : out std_logic_vector (MXBITS-1 downto 0)
);
end gbt_serdes;

architecture Behavioral of gbt_serdes is

    signal from_gbt_raw      : std_logic_vector(MXBITS-1 downto 0) := (others => '0');
    signal from_gbt          : std_logic_vector(MXBITS-1 downto 0) := (others => '0');

    signal to_gbt            : std_logic_vector(MXBITS-1 downto 0) := (others => '0');
    signal to_gbt_sync       : std_logic_vector(MXBITS-1 downto 0) := (others => '0');

    signal iserdes_reset     : std_logic := '1';
    signal oserdes_reset     : std_logic := '1';

    signal bitslip_err_cnt   : integer range 0 to BITSLIP_ERR_CNT_MAX-1 := 0;

    signal rx_bitslip_cnt    : integer range 0 to MXBITS-1 := 0;
    signal rx_bitslip_cnt_stdlog : std_logic_vector(2 downto 0) := (others => '0');

    signal bitslip_increment : std_logic := '0';

    signal reset             : std_logic := '0';


    --==============--
    --== Virtex-6 ==--
    --==============--

    component to_gbt_ser
    port(
        data_out_from_device : in std_logic_vector(7 downto 0);
        delay_reset          : in std_logic;
        delay_data_ce        : in std_logic_vector(0 to 0);
        delay_data_inc       : in std_logic_vector(0 to 0);
        delay_tap_in         : in std_logic_vector(4 downto 0);
        clk_in               : in std_logic;
        clk_div_in           : in std_logic;
        io_reset             : in std_logic;
        data_out_to_pins_p   : out std_logic_vector(0 to 0);
        data_out_to_pins_n   : out std_logic_vector(0 to 0);
        delay_tap_out        : out std_logic_vector(4 downto 0)
    );
    end component;

    --===============--
    --== Artix-7 ==--
    --===============--

    component to_gbt_ser_a7
        generic
        (-- width of the data for the system
            SYS_W       : integer := 1;
        -- width of the data for the device
            DEV_W       : integer := 8);
        port
        (
                -- From the device out to the system
            data_out_from_device    : in    std_logic_vector(DEV_W-1 downto 0);
            data_out_to_pins_p      : out   std_logic_vector(SYS_W-1 downto 0);
            data_out_to_pins_n      : out   std_logic_vector(SYS_W-1 downto 0);


                -- Clock and reset signals
            clk_in                  : in    std_logic;                    -- Fast clock from PLL/MMCM
            clk_div_in              : in    std_logic;                    -- Slow clock from PLL/MMCM
            io_reset                : in    std_logic);                   -- Reset signal for IO circuit
    end component;

    --------------------------------------------------------------------------------------------------------------------
    begin
    --------------------------------------------------------------------------------------------------------------------

    --================--
    --==    RESET   ==--
    --================--

    -- power-on reset - this must be a clock synchronous pulse of a minimum of 2 and max 32 clock cycles (ISERDES spec)
    --  1)  Wait until all MMCM/PLL used in the design are locked.
    --  2)  Reset should only be deasserted when it is known that CLK and CLKDIV are stable and present.
    --  3)  Wait until all IDELAYCTRL components, when used, show RDY high.
    --  4)  Use on the reset net one flip-flop clocked by CLKDIV per ISERDESE1/OSERDESE1 pair.
    --      Put the flip-flop in the FPGA logic in front of the ISERDESE1/OSERDESE1 pair
    --      Put a timing constraint on the flip-flop to ISERDESE1/OSERDESE1 of one CLKDIV period or less.

    process (clock) begin
    if (rising_edge(clock)) then
        reset <= reset_i;
    end if;
    end process;

    --------------------------------------------------------------------------------------------------------------------
    -- synchronize resets from logic clock to gbt clock domains
    --------------------------------------------------------------------------------------------------------------------

    synchronizer_oserdes_reset:
    entity work.synchronizer generic map(N_STAGES => 2)
    port map(
      async_i => reset_i,
      clk_i   => gbt_clk40,
      sync_o  => oserdes_reset
    );

    synchronizer_iserdes_reset:
    entity work.synchronizer generic map(N_STAGES => 2)
    port map(
      async_i => reset_i,
      clk_i   => gbt_clk40,
      sync_o  => iserdes_reset
    );

    --================--
    --== INPUT DATA ==--
    --================--

    gbt_oversample : entity work.oversample
    port map (
        rst         => '0',
        rxd_p       => elink_i_p,
        rxd_n       => elink_i_n,
        clk1x_logic => gbt_clk80,
        clk2x_logic => gbt_clk160_0,
        clk2x_0     => gbt_clk160_0,
        clk2x_90    => gbt_clk160_90,
        clk2x_180   => gbt_clk160_180,
        rxdata_o    => from_gbt_raw
    );

    --------------------------------------------------------------------------------------------------------------------
    -- Bitslip
    --------------------------------------------------------------------------------------------------------------------

    process (gbt_clk40) begin
        if (rising_edge(gbt_clk40)) then

          if (gbt_ready_i='1') then
            bitslip_err_cnt <= 0;
          elsif (bitslip_err_cnt = BITSLIP_ERR_CNT_MAX-1) then
            bitslip_err_cnt <= 0;
          elsif (gbt_link_error_i='1') then
            bitslip_err_cnt <= bitslip_err_cnt + 1;
          end if;
        end if;
    end process;

    bitslip_increment <= '1' when bitslip_err_cnt = BITSLIP_ERR_CNT_MAX-1 else '0';

    process (gbt_clk40) begin
    if (rising_edge(gbt_clk40)) then
            if (bitslip_increment='1') then
                if (rx_bitslip_cnt = 7) then
                    rx_bitslip_cnt <= 0;
                else
                    rx_bitslip_cnt <= rx_bitslip_cnt + 1;
                end if;
            end if;
        end if;
    end process;

    -- typecasting
    rx_bitslip_cnt_stdlog <= std_logic_vector(to_unsigned(rx_bitslip_cnt,rx_bitslip_cnt_stdlog'length));

    i_gbt_rx_bitslip : entity work.bitslip
    generic map(
      g_WORD_SIZE => MXBITS
    )
    port map(
        fabric_clk  => gbt_clk40,
        reset       => reset,
        bitslip_cnt => rx_bitslip_cnt_stdlog,
        din         => from_gbt_raw,
        dout        => from_gbt
    );

    --------------------------------------------------------------------------------------------------------------------
    -- cross domain from GBT rx clock to FPGA logic clock
    --------------------------------------------------------------------------------------------------------------------

    gbt_rx_data_sync : entity work.fifo_8b
    port map(
        wr_clk => gbt_clk40,
        rd_clk => clock,
        din    => from_gbt,
        wr_en  => '1',
        rd_en  => '1',
        dout   => data_o,
        full   => open,
        empty  => open
    );

    --------------------------------------------------------------------------------------------------------------------
    -- Output Data
    --------------------------------------------------------------------------------------------------------------------

    process(clock)
    begin
    if (rising_edge(clock)) then
          to_gbt<= data_i(0) & data_i(1) & data_i(2) & data_i(3) & data_i(4) & data_i(5) & data_i(6) & data_i(7);
    end if;
    end process;

    -- To ensure that data flows out of all OSERDESE1 blocks in a multiple bit output structure:
    --  1) Place a register in front of the OSERDESE1 inputs.
    --  2) Clock the register by the CLKDIV clock of the OSERDESE1.
    --  3) Use the same reset signal for the register as for the OSERDESE1.

    gbt_tx_data_sync : entity work.fifo_8b
    port map(
        wr_clk => clock,
        rd_clk => gbt_clk40,
        din    => to_gbt,
        wr_en  => '1',
        rd_en  => '1',
        dout   => to_gbt_sync,
        full   => open,
        empty  => open
    );

    -- Output serializer
    -- we want to output the data on the falling edge of the clock so that the GBT can sample on the rising edge

    --------------------------------------------------------------------------------------------------------------------
    to_gbt_ser_gen_v6 : IF (FPGA_TYPE="VIRTEX6") GENERATE
    --------------------------------------------------------------------------------------------------------------------

    i_to_gbt_ser : to_gbt_ser
    port map(
        -- POLARITY SWAP ON ELINK #1
        data_out_from_device    => ("not"(to_gbt_sync)),
        data_out_to_pins_p(0)   => elink_o_p,
        data_out_to_pins_n(0)   => elink_o_n,
        clk_in                  => gbt_clk320  ,
        clk_div_in              => gbt_clk40  ,
        io_reset                => oserdes_reset,

        DELAY_RESET             => '1',
        DELAY_DATA_CE           => (others => '1'),
        DELAY_DATA_INC          => (others => '0'),
        DELAY_TAP_IN            => tx_delay_i,
        DELAY_TAP_OUT           => open
    );

    END GENERATE to_gbt_ser_gen_v6;

    --------------------------------------------------------------------------------------------------------------------
    to_gbt_ser_gen_a7: IF (FPGA_TYPE="ARTIX7") GENERATE
    --------------------------------------------------------------------------------------------------------------------

    i_to_gbt_ser : to_gbt_ser_a7
    port map(
        data_out_from_device    => to_gbt_sync,
        data_out_to_pins_p(0)   => elink_o_p,
        data_out_to_pins_n(0)   => elink_o_n,
        clk_in                  => gbt_clk320,
        clk_div_in              => gbt_clk40,
        io_reset                => oserdes_reset
    );

    END GENERATE to_gbt_ser_gen_a7;


end Behavioral;
