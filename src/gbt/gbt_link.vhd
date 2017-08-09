----------------------------------------------------------------------------------
-- CMS Muon Endcap
-- GEM Collaboration
-- Optohybrid v3 Firmware -- GBT Link Parser
-- T. Lenzi, E. Juska, A. Peck
----------------------------------------------------------------------------------
-- Description:
--   This module counts receives builds wishbone requests received from the GBT
--   and puts them into a FIFO for handling in the OH, and takes wishbone responses
--   from the OH and builds packets to send out to the GBTx
----------------------------------------------------------------------------------
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

    -- wishbone
    wb_mst_req_o    : out wb_req_t;
    wb_mst_res_i    : in  wb_res_t;

    -- decoded ttc
    l1a_o           : out std_logic;
    bc0_o           : out std_logic;
    resync_o        : out std_logic;
    reset_vfats_o   : out std_logic;

    -- status
    error_o         : out std_logic

);
end gbt_link;

architecture Behavioral of gbt_link is

    --== GTX requests ==--

    signal gbt_rx_req  : std_logic; -- rx fifo write request
    signal gbt_rx_data : std_logic_vector(64 downto 0);

    signal oh_tx_req   : std_logic; -- tx fifo read request
    signal oh_tx_valid : std_logic; -- tx fifo data available
    signal oh_tx_data  : std_logic_vector(31 downto 0);

    signal reset       : std_logic;

begin

    -- reset fanout
    process (clock) begin
        if (rising_edge(clock)) then
            reset <= reset_i;
        end if;
    end process;

    --============--
    --== GBT RX ==--
    --============--

    gbt_rx_inst : entity work.gbt_rx
    port map(
        -- reset
        reset_i      => reset,

        -- ttc clock input
        clock      => clock,

        -- parallel data input from deserializer
        data_i       => data_i,

        -- decoded ttc commands
        l1a_o         => l1a_o,
        bc0_o         => bc0_o,
        resync_o      => resync_o,
        reset_vfats_o => reset_vfats_o,

        -- 65 bit output packet to fifo
        req_en_o     => gbt_rx_req,
        req_data_o   => gbt_rx_data,

        -- status
        error_o      => error_o
    );

    --============--
    --== GBT TX ==--
    --============--

    gbt_tx_inst : entity work.gbt_tx
    port map(
        -- reset
        reset_i     => reset,

        -- ttc clock input
        clock     => clock,

        -- parallel data input from fifo
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

        -- reset
        reset_i         => reset,

        -- rx parallel data (from GBT)
        wb_mst_req_o    => wb_mst_req_o, -- 32 bit adr + 32 bit data + we
        rx_en_i         => gbt_rx_req,
        rx_data_i       => gbt_rx_data,  -- 32 bit adr + 32 bit data

        -- tx parallel data (to GBT)

        -- input
        wb_mst_res_i    => wb_mst_res_i, -- 32 bit data
        tx_en_i         => oh_tx_req,    -- read enable

        -- output
        tx_valid_o      => oh_tx_valid, -- data available
        tx_data_o       => oh_tx_data   -- 32 bit data
    );

end Behavioral;
