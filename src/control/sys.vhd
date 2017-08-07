----------------------------------------------------------------------------------
-- CMS Muon Endcap
-- GEM Collaboration
-- Optohybrid v3 Firmware -- System
-- T. Lenzi, A. Peck
----------------------------------------------------------------------------------
-- Description:
--   This module provides writable registers to control the optohybrid
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

entity sys is
generic(
    N                   : integer := 11
);
port(

    ref_clk_i           : in std_logic;
    reset_i             : in std_logic;

    -- Wishbone slave
    wb_slv_req_i        : in wb_req_t;
    wb_slv_res_o        : out wb_res_t;

    -- outputs

    sys_sbit_sel_o      : out std_logic_vector(29 downto 0) := (others => '0');
    sys_loop_sbit_o     : out std_logic_vector( 4 downto 0) := "00000";
    sys_sbit_mode_o     : out std_logic_vector( 1 downto 0) := "00";

    vfat_reset_o        : out std_logic                     := '0';

    vfat_sbit_mask_o    : out std_logic_vector(23 downto 0) := x"000000";

    -- ttc / fmm

    fmm_ignore_startstop_o : out std_logic                      := '1';
    fmm_force_stop_o       : out std_logic                      := '0';
    fmm_dont_wait_o        : out std_logic                      := '0';

    ttc_bxn_offset_o       : out std_logic_vector (11 downto 0) := x"000";

    -- Sump

    sump_o : out std_logic

);
end sys;

architecture Behavioral of sys is

    -- Signals from the Wishbone Hub
    signal wb_stb       : std_logic_vector((N - 1) downto 0);
    signal wb_we        : std_logic;
    signal wb_addr      : std_logic_vector(31 downto 0);
    signal wb_data      : std_logic_vector(31 downto 0);

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
        -- fabric clock
        ref_clk_i   => ref_clk_i,

        -- reset
        reset_i     => reset_i,

        -- requestinput
        wb_req_i    => wb_slv_req_i,

        -- strobe
        stb_o       => wb_stb,
        we_o        => wb_we,
        ack_i       => reg_ack,
        err_i       => reg_err,

        data_i      => reg_data,     -- 32 bit data input
        wb_res_o    => wb_slv_res_o, -- 32 bit response to wishbone bus

        addr_o      => wb_addr, -- 32 bit address
        data_o      => wb_data  -- 32 bit data output from wishbone bus
    );

    --===============--
    --== Registers ==--
    --===============--

    registers_inst : entity work.registers
    generic map(
        SIZE        => N
    )
    port map(
        ref_clk_i   => ref_clk_i,
        reset_i     => reset_i,

        stb_i       => wb_stb,
        we_i        => wb_we,
        data_i      => wb_data,

        ack_o       => reg_ack,
        err_o       => reg_err,
        data_o      => reg_data
    );

    --=============--
    --== Mapping ==--
    --=============--

    -- copy to register; allows initializtion in ports list
    -- better fanout anyway...

    process (ref_clk_i)
    begin

        if (rising_edge(ref_clk_i)) then

            -- ADR=2
            if (reg_ack(2)='1') then
                sys_loop_sbit_o  <= reg_data(2)(4 downto 0)  ;
            end if;

            -- ADR=3
            vfat_reset_o     <= wb_stb  (3) and wb_we    ;

            -- ADR=4
            if (reg_ack(4)='1') then
            vfat_sbit_mask_o <= reg_data(4)(23 downto 0) ;
            end if;

            -- ADR=5
            if (reg_ack(4)='1') then
            sys_sbit_sel_o   <= reg_data(5)(29 downto 0) ;
            end if;

            -- ADR=8
            if (reg_ack(8)='1') then
            sys_sbit_mode_o  <= reg_data(8)(1 downto 0)  ;
            end if;

            -- ADR=9
            if (reg_ack(9)='1') then
            fmm_ignore_startstop_o <= reg_data(9)(0)  ;
            fmm_force_stop_o       <= reg_data(9)(1)  ;
            fmm_dont_wait_o        <= reg_data(9)(2)  ;
            end if;

            -- ADR=10
            if (reg_ack(10)='1') then
            ttc_bxn_offset_o       <= reg_data(10)(11 downto 0)  ;
            end if;

        end if;
    end process;

    --=============--
    --== Sump    ==--
    --=============--

    sump_o <= or_reduce(wb_addr) or or_reduce(wb_data);

end Behavioral;

