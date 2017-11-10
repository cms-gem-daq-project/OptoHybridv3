----------------------------------------------------------------------------------
-- CMS Muon Endcap
-- GEM Collaboration
-- Optohybrid v3 Firmware -- GBT
-- A. Peck
----------------------------------------------------------------------------------
-- Description:
--   This module implements all functionality required for communicating with GBTx
----------------------------------------------------------------------------------
-- 2017/07/24 -- Initial. Wrapper around GBT components to simplify top-level
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library unisim;
use unisim.vcomponents.all;

library work;
use work.types_pkg.all;
use work.ipbus_pkg.all;

entity gbt is
generic(
    DEBUG : boolean := FALSE
);
port(

    reset_i : in std_logic;

    clock_i : in std_logic; -- 40 MHz logic clock

    gbt_rx_clk_div_i : in std_logic; -- 40 MHz phase shiftable frame clock from GBT
    gbt_rx_clk_i     : in std_logic; -- 320 MHz phase shiftable frame clock from GBT

    gbt_tx_clk_div_i : in std_logic; -- 40 MHz phase shiftable frame clock from GBT
    gbt_tx_clk_i     : in std_logic; -- 320 MHz phase shiftable frame clock from GBT

    elink_i_p : in  std_logic_vector (1 downto 0);
    elink_i_n : in  std_logic_vector (1 downto 0);

    elink_o_p : out std_logic_vector (1 downto 0);
    elink_o_n : out std_logic_vector (1 downto 0);

    gbt_link_error_o : out std_logic;

    l1a_o         : out std_logic;
    bc0_o         : out std_logic;
    resync_o      : out std_logic;
    reset_vfats_o : out std_logic;

    -- wishbone
    ipb_mosi_o : out ipb_wbus;
    ipb_miso_i : in  ipb_rbus
);

end gbt;

architecture Behavioral of gbt is

    signal gbt_tx_data  : std_logic_vector(15 downto 0) := (others => '0');
    signal gbt_rx_data   : std_logic_vector(15 downto 0) := (others => '0');

    signal reset     : std_logic;

begin

    -- fanout reset tree

    process (clock_i) begin
        if (rising_edge(clock_i)) then
            reset <= reset_i;
        end if;
    end process;

    --=========--
    --== GBT ==--
    --=========--

    -- at 320 MHz performs ser-des on incoming
    gbt_serdes_inst : entity work.gbt_serdes
    port map(
        -- reset
       reset_i          => reset,

       -- input clocks

       gbt_rx_clk_div_i => gbt_rx_clk_div_i , -- 40 MHz phase shiftable frame clock from GBT
       gbt_rx_clk_i     => gbt_rx_clk_i     , -- 320 MHz phase shiftable frame clock from GBT

       gbt_tx_clk_div_i => gbt_tx_clk_div_i , -- 40 MHz phase shiftable frame clock from GBT
       gbt_tx_clk_i     => gbt_tx_clk_i     , -- 320 MHz phase shiftable frame clock from GBT

       clock            => clock_i,     -- 40 MHz logic clock

       -- serial data
       elink_o_p      => elink_o_p,  -- output e-links
       elink_o_n      => elink_o_n,  -- output e-links

       elink_i_p       => elink_i_p,   -- input e-links
       elink_i_n       => elink_i_n,   -- input e-links


       -- parallel data
       data_o           => gbt_rx_data,           -- Parallel data out
       data_i           => gbt_tx_data           -- Parallel data in
    );

    -- decodes GBT frames to build packets

    gbt_link_inst : entity work.gbt_link
    port map(

        -- reset
        reset_i         => reset,

        -- clock inputs
        clock           => clock_i, -- 40 MHz ttc fabric clock

        -- parallel data
        data_i          => gbt_rx_data,
        data_o          => gbt_tx_data,

        -- wishbone master
        ipb_mosi_o    => ipb_mosi_o,
        ipb_miso_i    => ipb_miso_i,

        -- decoded TTC
        reset_vfats_o   => reset_vfats_o,
        resync_o        => resync_o,
        l1a_o           => l1a_o,
        bc0_o           => bc0_o,

        -- outputs
        error_o         => gbt_link_error_o

    );

end Behavioral;
