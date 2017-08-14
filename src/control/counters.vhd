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
-- 2017/08/14 -- Add global reset and SNAP machine
-- 2017/08/14 -- Reset counters on resync
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
    N_COUNTERS          : integer := 48;
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
    ttc_l1a          : in std_logic;
    ttc_bc0          : in std_logic;
    ttc_resync       : in std_logic;
    ttc_bx0_sync_err : in std_logic;

    -- SEM
    sem_correction_i    : in std_logic

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
    signal cnt_data     : std32_array_t   ((N - 1) downto 0);

    signal snap_data    : std32_array_t   ((N - 1) downto 0);

    -- Sbits
    signal ors          : std_logic_vector (23 downto 0);

    signal cnt_en       : std_logic_vector ((N-1) downto 0);

    signal snap_en      : std_logic;

    signal reset_all    : std_logic;

    signal reset_en     : std_logic_vector ((N-1) downto 0);

    signal wb_sump      : std_logic;

    signal reset        : std_logic;

    signal snap_id    : integer := 0;
    signal reset_id   : integer := 1;
    signal resync_id  : integer := 15;

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
        data_i      => snap_data
    );

    --========================--
    --== Automatic response ==--
    --========================--

    ack_err_loop : for I in 0 to (N - 1) generate
    begin
        reg_ack(I) <= wb_stb(I);
        reg_err(I) <= '0';
    end generate;

    --==========--
    --== SNAP ==--
    --==========--

    -- accumulator enables
    process(clock)
    begin
        if (rising_edge(clock)) then
            if (snap_en = '1') then
                snap_data <= cnt_data;
            end if;
        end if;
    end process;

    --==============--
    --== Counters ==--
    --==============--

    counter_loop : for I in 0 to (N_COUNTERS-1) generate
    begin

        u_counter_loop : entity work.counter
        port map (
            ref_clk_i => clock,
            reset_i   => reset_en(I), -- reset counter by writing to the register
            en_i      => cnt_en  (I),
            data_o    => cnt_data(I)
        );

        process(clock)
        begin
            if (rising_edge(clock)) then

                -- don't reset the resync counter on resync
                if (I = reset_id ) then
                    reset_en (I) <= (wb_stb  (I) and wb_we);
                elsif (I = resync_id) then
                    reset_en (I) <= (wb_stb  (I) and wb_we) or reset_all;
                else
                    reset_en (I) <= (wb_stb  (I) and wb_we) or reset_all or ttc_resync;
                end if;

        end if;
        end process;

    end generate;

    -- accumulator enables

    process(clock)
    begin
        if (rising_edge(clock)) then

            -- snapshot

            snap_en         <= wb_stb (snap_id) and wb_we;
            cnt_en(snap_id) <= wb_stb (snap_id) and wb_we;

            -- reset all

            reset_all        <= wb_stb (reset_id) and wb_we;
            cnt_en(reset_id) <= wb_stb (reset_id) and wb_we;

            -- wishbone masters
            cnt_en(2) <= wb_m_req_i(0).stb;
            cnt_en(3) <= wb_m_res_i(0).ack;

            -- wishbone slaves strobe and ack
            cnt_en(4)  <= wb_s_req_i( 0).stb;
            cnt_en(5)  <= wb_s_req_i( 1).stb;
            cnt_en(6)  <= wb_s_req_i( 2).stb;
            cnt_en(7)  <= wb_s_req_i( 3).stb;
            cnt_en(8)  <= wb_s_req_i( 4).stb;

            cnt_en(9)  <= wb_s_res_i( 0).ack;
            cnt_en(10) <= wb_s_res_i( 1).ack;
            cnt_en(11) <= wb_s_res_i( 2).ack;
            cnt_en(12) <= wb_s_res_i( 3).ack;
            cnt_en(13) <= wb_s_res_i( 4).ack;

            -- ttc
            cnt_en(14)        <= ttc_l1a;
            cnt_en(resync_id) <= ttc_resync;
            cnt_en(16)        <= ttc_bc0;

            cnt_en(17)        <= ttc_bx0_sync_err;

            -- mmcms
            cnt_en(18) <= (not eprt_mmcm_locked_i);
            cnt_en(19) <= (not dskw_mmcm_locked_i);
            cnt_en(20) <= (not mmcms_locked_i);

            -- gbt
            cnt_en(21) <= gbt_link_error_i;

            -- sem correction
            cnt_en(22) <= sem_correction_i;

            -- sbit overflow
            cnt_en(23) <= sbit_overflow_i;

            -- s-bit counters

            cnt_en(24) <= active_vfats_i(0);
            cnt_en(25) <= active_vfats_i(1);
            cnt_en(26) <= active_vfats_i(2);
            cnt_en(27) <= active_vfats_i(3);
            cnt_en(28) <= active_vfats_i(4);
            cnt_en(29) <= active_vfats_i(5);
            cnt_en(30) <= active_vfats_i(6);
            cnt_en(31) <= active_vfats_i(7);
            cnt_en(32) <= active_vfats_i(8);
            cnt_en(33) <= active_vfats_i(9);
            cnt_en(34) <= active_vfats_i(10);
            cnt_en(35) <= active_vfats_i(11);
            cnt_en(36) <= active_vfats_i(12);
            cnt_en(37) <= active_vfats_i(13);
            cnt_en(38) <= active_vfats_i(14);
            cnt_en(39) <= active_vfats_i(15);
            cnt_en(40) <= active_vfats_i(16);
            cnt_en(41) <= active_vfats_i(17);
            cnt_en(42) <= active_vfats_i(18);
            cnt_en(43) <= active_vfats_i(19);
            cnt_en(44) <= active_vfats_i(20);
            cnt_en(45) <= active_vfats_i(21);
            cnt_en(46) <= active_vfats_i(22);
            cnt_en(47) <= active_vfats_i(23);

        end if;
    end process;

    -- time from the OR of s-bits to the L1A for each VFAT
    -- counters 21 to 44

    timer_loop : for I in 0 to (N_TIMERS-1) generate
    begin

        process(clock)
        begin
            if (rising_edge(clock)) then
            reset_en (N_COUNTERS+I) <= wb_stb  (N_COUNTERS+I) and wb_we;
        end if;
        end process;

        u_timer_loop : entity work.timer
        port map(
            ref_clk_i => clock,
            reset_i   => reset_en(N_COUNTERS+I),
            start_i   => active_vfats_i(I),
            stop_i    => ttc_l1a,
            data_o    => cnt_data(N_COUNTERS + I)
        );

    end generate;

end Behavioral;
