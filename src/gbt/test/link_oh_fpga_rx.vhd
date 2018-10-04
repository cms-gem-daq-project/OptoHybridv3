------------------------------------------------------------------------------------------------------------------------
-- Company: TAMU
-- Engineer: Evaldas Juska (evaldas.juska@cern.ch, evka85@gmail.com)
--
-- Create Date:    03:10 2017-11-04
-- Module Name:    link_oh_fpga_rx
-- Description:    this module handles the OH FPGA packet decoding for register data
------------------------------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

entity link_oh_fpga_rx is
generic(
    g_ELINK_WIDTH     : integer := 8;
    g_FRAME_COUNT_MAX : integer := 6;
    g_FRAME_WIDTH     : integer := 6;
    g_READY_COUNT_MAX : integer := 64 -- number of good consecutive frames to mark the output as ready
);
port(

    reset_i                 : in std_logic;
    ttc_clk_40_i            : in std_logic;

    elink_data_i            : in std_logic_vector(g_ELINK_WIDTH-1 downto 0);

    reg_data_valid_o        : out std_logic;
    reg_data_o              : out std_logic_vector(31 downto 0);
    error_o                 : out std_logic

);
end link_oh_fpga_rx;

architecture link_oh_fpga_rx_arch of link_oh_fpga_rx is

    type state_t is (IDLE, DATA);

    signal state            : state_t := IDLE;

    signal data_frame_cnt   : integer range 0 to g_FRAME_COUNT_MAX-1 := 0;

    signal reg_data_valid   : std_logic;
    signal reg_data         : std_logic_vector(g_FRAME_COUNT_MAX*g_FRAME_WIDTH-1 downto 0) := (others => '0');

    signal frame_data       : std_logic_vector(g_FRAME_WIDTH-1 downto 0) := (others => '0');
    signal frame_data_delay : std_logic_vector(g_FRAME_WIDTH-1 downto 0) := (others => '0');

    signal char_is_data       : std_logic := '0';
    signal char_is_data_delay : std_logic := '0';
    signal not_in_table       : std_logic := '0';
    signal idle_rx            : std_logic := '0';

    signal bitslip_buf  : std_logic_vector(g_ELINK_WIDTH*2-1 downto 0) := (others => '0');
    signal bitslip_data : std_logic_vector(g_ELINK_WIDTH-1   downto 0) := (others => '0');

    signal bitslip_cnt  : integer range 0 to g_ELINK_WIDTH-1;

    signal ready : std_logic := '0';
    signal ready_cnt  : integer range 0 to g_READY_COUNT_MAX;

    signal rx_err : std_logic;

    signal even_odd : std_logic := '0'; -- simple strobe to increment bitslip only every other bx


begin

    --------------------------------------------------------------------------------------------------------------------
    -- Combinatorial assignments
    --------------------------------------------------------------------------------------------------------------------
    ready <= '1' when ready_cnt =  (g_READY_COUNT_MAX-1) else '0';

    error_o <= rx_err;

    --------------------------------------------------------------------------------------------------------------------
    -- Output
    --------------------------------------------------------------------------------------------------------------------

    reg_data_valid_o <= reg_data_valid;
    process (ttc_clk_40_i) begin
        if (rising_edge(ttc_clk_40_i)) then
            if (ready='0') then
                reg_data_o       <= x"00000000";
            else
                reg_data_o       <= reg_data (31 downto 0);
            end if;
        end if;
    end process;

    --------------------------------------------------------------------------------------------------------------------
    -- Ready Counter
    --------------------------------------------------------------------------------------------------------------------

    process (ttc_clk_40_i) begin
    if (rising_edge(ttc_clk_40_i)) then
        if (rx_err='1') then
            ready_cnt <= 0;
        elsif (ready_cnt =  (g_READY_COUNT_MAX-1)) then
            ready_cnt <= ready_cnt;
        elsif (idle_rx='1') then
            ready_cnt <= ready_cnt + 1;
        end if;
    end if;
    end process;

    -- create a 20 MHz strobe
    process (ttc_clk_40_i) begin
    if (rising_edge(ttc_clk_40_i)) then
            even_odd <= not even_odd;
    end if;
    end process;

    --------------------------------------------------------------------------------------------------------------------
    -- Bitslip alignment
    --------------------------------------------------------------------------------------------------------------------
    process(ttc_clk_40_i)
    begin
    if (rising_edge(ttc_clk_40_i)) then
        if (even_odd = '1'  and rx_err = '1' and idle_rx='0' and ready='0') then
            if (bitslip_cnt = g_ELINK_WIDTH-1) then
                bitslip_cnt <= 0;
            else
                bitslip_cnt <= bitslip_cnt + 1;
            end if;
        end if;
    end if;
    end process;

    process(ttc_clk_40_i)
    begin
        if (rising_edge(ttc_clk_40_i)) then
            bitslip_buf  <= bitslip_buf(g_ELINK_WIDTH-1 downto 0) & elink_data_i(g_ELINK_WIDTH-1 downto 0);
            bitslip_data <= bitslip_buf((g_ELINK_WIDTH-1 + bitslip_cnt) downto bitslip_cnt);
        end if;
    end process;


    --------------------------------------------------------------------------------------------------------------------
    -- 8b to 6b conversion
    --------------------------------------------------------------------------------------------------------------------

    eightbit_sixbit_inst : entity work.eightbit_sixbit
    port map (
        eightbit     => bitslip_data,
        sixbit       => frame_data,
        not_in_table => not_in_table,
        char_is_data => char_is_data,
        l1a          => open,
        bc0          => open,
        resync       => open,
        idle         => idle_rx
    );

    --------------------------------------------------------------------------------------------------------------------
    -- State FSM
    --------------------------------------------------------------------------------------------------------------------

    process(ttc_clk_40_i)
    begin
    if (rising_edge(ttc_clk_40_i)) then

    if (reset_i = '1') then
        state <= IDLE;
        data_frame_cnt <= 0;
    else
        case state is
            when IDLE =>
                if (char_is_data='1') then
                    state <= DATA;
                    data_frame_cnt <= 0;
                else
                    state <= IDLE;
                    data_frame_cnt <= 0;
                end if;
            when DATA =>
                if (data_frame_cnt = g_FRAME_COUNT_MAX-1) then
                    state <= IDLE;
                else
                    data_frame_cnt <= data_frame_cnt + 1;
                end if;
            when others =>
                state <= IDLE;
                data_frame_cnt <= 0;
        end case;
    end if;

    end if;
    end process;

    --------------------------------------------------------------------------------------------------------------------
    -- Data Delay
    --------------------------------------------------------------------------------------------------------------------

    process (ttc_clk_40_i) begin
        if (rising_edge(ttc_clk_40_i)) then
            -- only latch if char_is_data so that we can "pause" the sequencer if a ttc command is received
            -- during a packet
            if (char_is_data='1') then
                frame_data_delay <= frame_data;
            end if;

            char_is_data_delay <= char_is_data;

        end if;
    end process;

    --------------------------------------------------------------------------------------------------------------------
    -- Register data latching
    --------------------------------------------------------------------------------------------------------------------

    process(ttc_clk_40_i)
    begin
        if (rising_edge(ttc_clk_40_i)) then
            if (reset_i = '1') then
                reg_data_valid <= '0';
                reg_data <= (others => '0');
            else
                reg_data_valid <= '0';
                if (state = DATA) then
                    reg_data ((g_FRAME_COUNT_MAX - data_frame_cnt) * g_FRAME_WIDTH - 1 downto (g_FRAME_COUNT_MAX-1-data_frame_cnt) * g_FRAME_WIDTH) <= frame_data_delay;
                    if (data_frame_cnt = g_FRAME_COUNT_MAX) then
                        reg_data_valid <= '1';
                    end if;
                end if;
            end if;
        end if;
    end process;

    --------------------------------------------------------------------------------------------------------------------
    -- Error checking
    --------------------------------------------------------------------------------------------------------------------

    process(ttc_clk_40_i)
    begin
        if (rising_edge(ttc_clk_40_i)) then
            if (reset_i = '1') then
                rx_err <= '0';
            else
                if (not_in_table = '1' or (state=DATA and char_is_data_delay/='1') or (ready='0' and idle_rx='0')) then
                    rx_err <= '1';
                else
                    rx_err <= '0';
                end if;
            end if;
        end if;
    end process;

end link_oh_fpga_rx_arch;

