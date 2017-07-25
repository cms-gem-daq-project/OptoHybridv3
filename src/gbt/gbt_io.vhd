----------------------------------------------------------------------------------
-- CMS Muon Endcap
-- GEM Collaboration
-- Optohybrid v3 Firmware -- GBT io
-- 2017/07/24 -- Initial. Wrapper around GBT components to simplify top-level
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library unisim;
use unisim.vcomponents.all;

library work;
use work.types_pkg.all;
use work.wb_pkg.all;

entity gbt_io is
generic(
    DEBUG : boolean := FALSE
);
port(

    reset_i : in std_logic;

    clock_i : in std_logic; -- 40 MHz logic clock

    frame_clk_i : in std_logic; -- 40 MHz frame clock  from GBT
    data_clk_i  : in std_logic; -- 320 MHz frame clock  from GBT

    elink_i_p : in  std_logic_vector (1 downto 0);
    elink_i_n : in  std_logic_vector (1 downto 0);

    elink_o_p : out std_logic_vector (1 downto 0);
    elink_o_n : out std_logic_vector (1 downto 0);

    gbt_link_error_o : out std_logic;

    l1a_o    : out std_logic;
    bc0_o    : out std_logic;
    resync_o : out std_logic;

    -- wishbone
    wb_mst_req_o : out wb_req_t;
    wb_mst_res_i : in  wb_res_t
);

end gbt_io;

architecture Behavioral of gbt_io is

    signal gbt_dout  : std_logic_vector(15 downto 0) := (others => '0');
    signal gbt_din   : std_logic_vector(15 downto 0) := (others => '0');

    signal gbt_valid      : std_logic;
    signal gbt_sync_reset : std_logic;

begin
    --=========--
    --== GBT ==--
    --=========--

    gbt_inst : entity work.gbt
    port map(
        -- reset
       sync_reset_i     => gbt_sync_reset,    -- reset input

       -- input clocks
       data_clk_i       => data_clk_i,  -- 320 MHz sampling clock
       frame_clk_i      => frame_clk_i, -- 40 MHz frame clock
       clock            => clock_i,     -- 40 MHz logic clock

       -- serial data
       elink_o_p      => elink_o_p,  -- output e-links
       elink_o_n      => elink_o_n,  -- output e-links

       elink_i_p       => elink_i_p,   -- input e-links
       elink_i_n       => elink_i_n,   -- input e-links


       -- parallel data
       data_o           => gbt_din,           -- Parallel data out
       data_i           => gbt_dout,          -- Parallel data in
       valid_o          => gbt_valid          -- Data valid
    );

    -- This module controls the DATA of the GBT

    gbt_link_inst : entity work.gbt_link
    port map(

        -- reset
        reset_i         => reset_i,

        -- clock inputs
        clock           => clock_i, -- 40 MHz ttc fabric clock

        -- parallel data
        data_i          => gbt_din,
        data_o          => gbt_dout,
        valid_i         => gbt_valid,

        -- wishbone master
        wb_mst_req_o    => wb_mst_req_o,
        wb_mst_res_i    => wb_mst_res_i,

        -- decoded TTC
        resync_o        => resync_o,
        l1a_o           => l1a_o,
        bc0_o           => bc0_o,

        -- outputs
        error_o         => gbt_link_error_o,

        -- slow reset
        sync_reset_o    => gbt_sync_reset

    );

end Behavioral;
