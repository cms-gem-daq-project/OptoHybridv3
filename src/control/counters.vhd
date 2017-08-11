----------------------------------------------------------------------------------
-- CMS Muon Endcap
-- GEM Collaboration
-- Optohybrid v3 Firmware -- Counters
-- T. Lenzi, A. Peck
----------------------------------------------------------------------------------
-- Description:
--   This module implements all counters in the OH and the wishbone interface to
--   read them out
----------------------------------------------------------------------------------
-- 2017/07/24 -- Initial port to version 3 electronics
-- 2017/07/25 -- Clear synthesis warnings from module
-- 2017/08/10 -- Add reset fanout tree
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;

library work;
use work.types_pkg.all;
use work.wb_pkg.all;

entity counters is
generic(
    N_COUNTERS          : integer := 21;
    N_TIMERS            : integer := 24
);
port(

    clock               : in std_logic;
    reset_i             : in std_logic;

    -- Wishbone slave
    wb_slv_req_i        : in  wb_req_t;
    wb_slv_res_o        : out wb_res_t;

    -- Wishbone request
    wb_m_req_i          : in wb_req_array_t ((WB_MASTERS - 1) downto 0);
    wb_m_res_i          : in wb_res_array_t ((WB_MASTERS - 1) downto 0);
    wb_s_req_i          : in wb_req_array_t ((WB_SLAVES  - 1) downto 0);
    wb_s_res_i          : in wb_res_array_t ((WB_SLAVES  - 1) downto 0);

    -- Trigger

    active_vfats_i : in std_logic_vector (23 downto 0);
    sbit_overflow_i : in std_logic;

    -- GBT
    gbt_link_error_i    : in std_logic;

    -- MMCM
    mmcms_locked_i        : in std_logic;
    eprt_mmcm_locked_i    : in std_logic;
    dskw_mmcm_locked_i    : in std_logic;

    -- TTC
    ttc_l1a    : in std_logic;
    ttc_bc0    : in std_logic;
    ttc_resync : in std_logic;

    -- SEM
    sem_correction_i    : in std_logic;

    -- SUMP

    sump_o : out std_logic

);
end counters;

architecture Behavioral of counters is

    constant N          : integer := N_COUNTERS+N_TIMERS;

    -- Signals from the Wishbone Hub
    signal wb_stb       : std_logic_vector((N - 1) downto 0);
    signal wb_we        : std_logic;
    signal wb_addr      : std_logic_vector(31 downto 0);
    signal wb_data      : std_logic_vector(31 downto 0);

    -- Signals for the registers
    signal reg_ack      : std_logic_vector((N - 1) downto 0);
    signal reg_err      : std_logic_vector((N - 1) downto 0);
    signal reg_data     : std32_array_t   ((N - 1) downto 0);

    -- Sbits
    signal ors          : std_logic_vector (23 downto 0);

    signal cnt_en       : std_logic_vector ((N-1) downto 0);

    signal reset_en     : std_logic_vector ((N-1) downto 0);

    signal wb_sump : std_logic;

    signal reset : std_logic;

begin

    process (clock) begin
        if (rising_edge(clock)) then
            reset <= reset_i;
        end if;
    end process;

    --===============================--
    --== Wishbone request splitter ==--
    --===============================--

    wb_splitter_inst : entity work.wb_splitter
    generic map(
        SIZE        => N,
        OFFSET      => 0
    )
    port map(
        ref_clk_i   => clock,
        reset_i     => reset,
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

    --==============--
    --== Counters ==--
    --==============--

    counter_loop : for I in 0 to (N_COUNTERS-1) generate
    begin

    reset_en (I) <= wb_stb  (I) and wb_we;

    u_counter_loop : entity work.counter
    port map (
        ref_clk_i => clock,
        reset_i   => reset_en(I), -- reset counter by writing to the register
        en_i      => cnt_en  (I),
        data_o    => reg_data(I)
    );
    end generate;

    -- accumulator enables
    process(clock)
    begin
        if (rising_edge(clock)) then

            -- wishbone masters
            cnt_en(0) <= wb_m_req_i(0).stb;
            cnt_en(1) <= wb_m_res_i(0).ack;

            -- wishbone slaves strobe and ack
            cnt_en(2)  <= wb_s_req_i( 0).stb;
            cnt_en(3)  <= wb_s_req_i( 1).stb;
            cnt_en(4)  <= wb_s_req_i( 2).stb;
            cnt_en(5)  <= wb_s_req_i( 3).stb;
            cnt_en(6)  <= wb_s_req_i( 4).stb;

            cnt_en(7)  <= wb_s_res_i( 0).ack;
            cnt_en(8)  <= wb_s_res_i( 1).ack;
            cnt_en(9)  <= wb_s_res_i( 2).ack;
            cnt_en(10) <= wb_s_res_i( 3).ack;
            cnt_en(11) <= wb_s_res_i( 4).ack;

            -- ttc
            cnt_en(12) <= ttc_l1a;
            cnt_en(13) <= ttc_resync;
            cnt_en(14) <= ttc_bc0;

            -- mmcms
            cnt_en(15) <= (not eprt_mmcm_locked_i);
            cnt_en(16) <= (not dskw_mmcm_locked_i);
            cnt_en(17) <= (not mmcms_locked_i);

            -- gbt
            cnt_en(18) <= gbt_link_error_i;

            -- sem correction
            cnt_en(19) <= sem_correction_i;

            -- sbit overflow
            cnt_en(20) <= sbit_overflow_i;

        end if;
    end process;


    -- time from the OR of s-bits to the L1A for each VFAT


    timer_loop : for I in 0 to (N_TIMERS-1) generate
    begin

        reset_en (N_COUNTERS+I) <= wb_stb  (N_COUNTERS+I) and wb_we;

        u_timer_loop : entity work.timer
        port map(
            ref_clk_i => clock,
            reset_i   => reset_en(N_COUNTERS+I),
            start_i   => active_vfats_i(I),
            stop_i    => ttc_l1a,
            data_o    => reg_data(N_COUNTERS + I)
        );
    end generate;

    -- sump unused signals

    wb_sump <=     or_reduce(wb_m_req_i(0).addr) or or_reduce(wb_m_req_i(0).data)
                or or_reduce(wb_s_req_i(0).data) or or_reduce(wb_s_req_i(1).data) or or_reduce(wb_s_req_i(2).data)
                or or_reduce(wb_m_res_i(0).stat) or or_reduce(wb_m_res_i(0).data)
                or or_reduce(wb_s_req_i(0).addr) or or_reduce(wb_s_req_i(1).addr) or or_reduce(wb_s_req_i(2).addr)
                or or_reduce(wb_s_res_i(0).stat) or or_reduce(wb_s_res_i(1).stat) or or_reduce(wb_s_res_i(2).stat)
                or or_reduce(wb_s_res_i(0).data) or or_reduce(wb_s_res_i(1).data) or or_reduce(wb_s_res_i(2).data)
                or wb_m_req_i(0).we
                or wb_s_req_i(0).we or wb_s_req_i(1).we or wb_s_req_i(2).we;


    sump_o <= wb_sump or or_reduce(wb_addr) or or_reduce(wb_data);

end Behavioral;
