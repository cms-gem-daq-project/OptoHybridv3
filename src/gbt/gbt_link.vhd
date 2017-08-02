----------------------------------------------------------------------------------
-- CMS Muon Endcap
-- GEM Collaboration
-- Optohybrid v3 Firmware -- GBT Link Parser
-- 2017/07/24 -- Removal of VFAT2 event building and Calpulse
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library unisim;
use unisim.vcomponents.all;

library work;
use work.types_pkg.all;

entity gbt_link is
port(

    -- reset
    reset_i         : in std_logic;

    -- clock inputs
    clock         : in std_logic;

    -- parallel data to/from serdes
    data_i          : in std_logic_vector (15 downto 0);
    data_o          : out std_logic_vector(15 downto 0);
    valid_i         : in std_logic;

    -- wishbone
    wb_mst_req_o    : out wb_req_t;
    wb_mst_res_i    : in  wb_res_t;

    -- decoded ttc
    l1a_o           : out std_logic;
    bc0_o           : out std_logic;
    resync_o        : out std_logic;

    -- status
    error_o         : out std_logic;

    -- slow reset
    sync_reset_o    : out std_logic

);
end gbt_link;

architecture Behavioral of gbt_link is

    --== GTX requests ==--

    signal gbt_rx_req       : std_logic;
    signal gbt_rx_data     : std_logic_vector(64 downto 0);

    signal oh_tx_req       : std_logic;
    signal oh_tx_valid    : std_logic;
    signal oh_tx_data     : std_logic_vector(31 downto 0);

begin

    --============--
    --== GBT RX ==--
    --============--

    gbt_rx_inst : entity work.gbt_rx
    port map(
        -- reset
        reset_i      => reset_i,

        -- ttc clock input
        clock      => clock,

        -- parallel data input from deserializer
        data_i       => data_i,
        valid_i      => valid_i,

        -- decoded ttc commands
        l1a_o        => l1a_o,
        bc0_o        => bc0_o,
        resync_o     => resync_o,

        -- 65 bit output packet to fifo
        req_en_o     => gbt_rx_req,
        req_data_o   => gbt_rx_data,

        -- status
        error_o      => error_o,

        -- slow reset output
        sync_reset_o => sync_reset_o
    );

    --============--
    --== GBT TX ==--
    --============--

    gbt_tx_inst : entity work.gbt_tx
    port map(
        -- reset
        reset_i     => reset_i,

        -- ttc clock input
        clock     => clock,

        -- parallel data input from fifo
        valid_i     => valid_i,     -- SERDES ready (reset done)
        req_valid_i => oh_tx_valid, -- 1  bit write request from OH logic (through request fifo)
        req_data_i  => oh_tx_data,  -- 32 bit data from OH logic
        req_en_o    => oh_tx_req,   -- fifo read enable

        -- parallel data output to serializer
        data_o      => data_o       -- 16 bit output frames
    );

    --========================--
    --== Request forwarding ==--
    --========================--

    -- create fifos to buffer between GBT and wishbone

    link_request_inst : entity work.link_request
    port map(
        -- clocks
        fabric_clock_i  => clock, -- 40 MHz logic clock
        ext_clock_i     => clock, -- 40 MHz logic clock -- sync is handled in GBT module

        -- reset
        reset_i         => reset_i,

        -- rx parallel data (from GBT)
        wb_mst_req_o    => wb_mst_req_o, -- 32 bit adr + 32 bit data + we
        rx_en_i         => gbt_rx_req,
        rx_data_i       => gbt_rx_data,  -- 32 bit adr + 32 bit data

        -- tx parallel data (to GBT)
        wb_mst_res_i    => wb_mst_res_i, -- 32 bit data
        tx_en_i         => oh_tx_req,
        tx_valid_o      => oh_tx_valid,
        tx_data_o       => oh_tx_data    -- 32 bit data
    );

end Behavioral;
