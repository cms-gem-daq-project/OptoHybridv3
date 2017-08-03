----------------------------------------------------------------------------------
-- CMS Muon Endcap
-- GEM Collaboration
-- Optohybrid v3 Firmware -- Status
-- T. Lenzi, A. Peck
----------------------------------------------------------------------------------
-- Description:
--   This module provides readable registers to monitor the status of the OH
----------------------------------------------------------------------------------
-- 2017/07/24 -- Initial port to version 3 electronics
-- 2017/07/25 -- Clear synthesis warnings from module
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;

library work;
use work.types_pkg.all;
use work.param_pkg.all;

entity stat is
generic(
    N               : integer := 6
);
port(

    ref_clk_i           : in std_logic;
    reset_i             : in std_logic;

    -- Wishbone slave
    wb_slv_req_i        : in wb_req_t;
    wb_slv_res_o        : out wb_res_t;

    -- MMCM
    mmcms_locked_i       : in std_logic;
    dskw_mmcm_locked_i   : in std_logic;
    eprt_mmcm_locked_i   : in std_logic;

    -- SEM
    sem_critical_i      : in std_logic;

    -- GBT

    gbt_rxready_i : in std_logic;
    gbt_rxvalid_i : in std_logic;
    gbt_txready_i : in std_logic;
    gbt_txvalid_i : in std_logic;

    cluster_rate_i : in std_logic_vector (31 downto 0);

    -- Sump

    sump_o : out std_logic

);
end stat;

architecture Behavioral of stat is

    -- Signals from the Wishbone Hub
    signal wb_stb       : std_logic_vector((N - 1) downto 0);
    signal wb_we        : std_logic;
    signal wb_addr      : std_logic_vector(31 downto 0) := x"ffffffff";
    signal wb_data      : std_logic_vector(31 downto 0) := x"ffffffff";

    -- Signals for the registers
    signal reg_ack      : std_logic_vector((N - 1) downto 0);
    signal reg_err      : std_logic_vector((N - 1) downto 0);
    signal reg_data     : std32_array_t((N - 1) downto 0);

begin

    --===============================--
    --== Wishbone request splitter ==--
    --===============================--

    wb_splitter_inst : entity work.wb_splitter
    generic map(
        SIZE        => N,
        OFFSET      => 0
    )
    port map(
        ref_clk_i   => ref_clk_i,
        reset_i     => reset_i,
        wb_req_i    => wb_slv_req_i,
        wb_res_o    => wb_slv_res_o,
        stb_o       => wb_stb,
        we_o        => wb_we,
        addr_o      => wb_addr,
        data_o      => wb_data,
        ack_i       => reg_ack,
        err_i       => reg_err,
        data_i      => reg_data
    );

    --========================--
    --== Automatic response ==--
    --========================--

    ack_err_loop : for I in 0 to (N - 1) generate
    begin

        reg_ack(I) <= wb_stb(I);
        reg_err(I) <= '0';

    end generate;

    --=============--
    --== Mapping ==--
    --=============--

    reg_data(0) <=                        RELEASE_YEAR & RELEASE_MONTH & RELEASE_DAY;
    reg_data(1) <= (31 downto 3 => '0') & eprt_mmcm_locked_i & dskw_mmcm_locked_i & mmcms_locked_i;
    reg_data(2) <= (31 downto 1 => '0') & sem_critical_i;
    reg_data(3) <= (31 downto 4 => '0') & gbt_rxready_i & gbt_rxvalid_i & gbt_txready_i & gbt_txvalid_i;
    reg_data(4) <= cluster_rate_i;

    -- dummb readout to shut up ISE
    reg_data(5) <= (31 downto 0 => '1');

    --=============--
    --== Sump    ==--
    --=============--

    sump_o <= or_reduce(wb_addr) or or_reduce(wb_data) or wb_we;

end Behavioral;

