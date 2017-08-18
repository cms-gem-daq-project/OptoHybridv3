----------------------------------------------------------------------------------
-- CMS Muon Endcap
-- GEM Collaboration
-- Optohybrid v3 Firmware -- Loopback
-- A. Peck
----------------------------------------------------------------------------------
-- Description:
--   Provides a loopback register on the wishbone bus
----------------------------------------------------------------------------------
-- 2017/07/31 -- Port from stat.vhd
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;

library work;
use work.types_pkg.all;
use work.param_pkg.all;
use work.wb_pkg.all;

entity loopback is
generic(
    N               : integer := 1
);
port(

    ref_clk_i           : in std_logic;
    reset_i             : in std_logic;

    -- Wishbone slave
    wb_slv_req_i        : in wb_req_t;
    wb_slv_res_o        : out wb_res_t;

    -- Sump

    sump_o : out std_logic

);
end loopback;

architecture Behavioral of loopback is

    -- Signals from the Wishbone Hub
    signal wb_stb       : std_logic_vector((N - 1) downto 0);
    signal wb_we        : std_logic;
    signal wb_addr      : std_logic_vector(WB_ADDR_SIZE-1 downto 0) := x"ffff";
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

    reg_data(0) <= wb_data; -- loop the output back into the input

    --=============--
    --== Sump    ==--
    --=============--

    sump_o <= or_reduce(wb_addr) or or_reduce(wb_data) or wb_we;

end Behavioral;
