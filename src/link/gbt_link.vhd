----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
--
-- Create Date:    08:37:33 07/07/2015
-- Design Name:    OptoHybrid v2
-- Module Name:    link - Behavioral
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description:
--
-- This entity controls the DATA level of the GTX.
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library unisim;
use unisim.vcomponents.all;

library work;
use work.types_pkg.all;

entity gbt_link is
port(

    ref_clk_i       : in std_logic;
    reset_i         : in std_logic;

    data_i          : in std_logic_vector(15 downto 0);
    data_o          : out std_logic_vector(31 downto 0);
    valid_i         : in std_logic;

    wb_mst_req_o    : out wb_req_t;
    wb_mst_res_i    : in wb_res_t;

    vfat2_tk_data_i : in tk_data_array_t(23 downto 0);
    vfat2_tk_mask_i : in std_logic_vector(23 downto 0);
    zero_suppress_i : in std_logic;

    vfat2_t1_i      : in t1_t;
    vfat2_t1_o      : out t1_t;

    error_o         : out std_logic;
    evt_sent_o      : out std_logic;

    sync_reset_o    : out std_logic
    
);
end gbt_link;

architecture Behavioral of gbt_link is

    --== GTX requests ==--

    signal g2o_req_en       : std_logic;
    signal g2o_req_data     : std_logic_vector(64 downto 0);

    signal o2g_req_en       : std_logic;
    signal o2g_req_valid    : std_logic;
    signal o2g_req_data     : std_logic_vector(31 downto 0);

    --== VFAT2 event data ==--

    signal evt_en           : std_logic;
    signal evt_valid        : std_logic;
    signal evt_data         : std_logic_vector(223 downto 0);

begin

    evt_sent_o <= evt_valid;

    --============--
    --== GBT RX ==--
    --============--

    gbt_rx_inst : entity work.gbt_rx
    port map(
        ref_clk_i    => ref_clk_i,
        reset_i      => reset_i,
        data_i       => data_i,
        valid_i      => valid_i,
        vfat2_t1_o   => vfat2_t1_o,
        req_en_o     => g2o_req_en,
        req_data_o   => g2o_req_data,
        error_o      => error_o,
        sync_reset_o => sync_reset_o
    );

    --============--
    --== GBT TX ==--
    --============--

    gbt_tx_inst : entity work.gbt_tx
    port map(
        ref_clk_i   => ref_clk_i,
        reset_i     => reset_i,
        data_o      => data_o,
        valid_i     => valid_i,
		req_en_o    => o2g_req_en,
		req_valid_i => o2g_req_valid,
		req_data_i  => o2g_req_data,
		evt_en_o    => evt_en,
		evt_valid_i => evt_valid,
		evt_data_i  => evt_data
	);

    --========================--
    --== Request forwarding ==--
    --========================--

    link_request_inst : entity work.link_request
    port map(
        ref_clk_i       => ref_clk_i,
        link_clk_i      => ref_clk_i,
        reset_i         => reset_i,
        wb_mst_req_o    => wb_mst_req_o,
        wb_mst_res_i    => wb_mst_res_i,
        rx_en_i         => g2o_req_en,
        rx_data_i       => g2o_req_data,
        tx_en_i         => o2g_req_en,
        tx_valid_o      => o2g_req_valid,
        tx_data_o       => o2g_req_data
    );

    --======================================--
    --== VFAT2 tracking data concentrator ==--
    --======================================--

    link_tracking_inst : entity work.link_tracking
    port map(
		ref_clk_i       => ref_clk_i,
		link_clk_i      => ref_clk_i,
		reset_i         => reset_i,
        vfat2_t1_i      => vfat2_t1_i,
		vfat2_tk_data_i => vfat2_tk_data_i,
        vfat2_tk_mask_i => vfat2_tk_mask_i,
        zero_suppress_i => zero_suppress_i,
		evt_en_i        => evt_en,
		evt_valid_o     => evt_valid,
		evt_data_o      => evt_data
	);

end Behavioral;
