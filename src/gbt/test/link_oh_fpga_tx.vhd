------------------------------------------------------------------------------------------------------------------------------------------------------
-- Company: TAMU
-- Engineer: Evaldas Juska (evaldas.juska@cern.ch, evka85@gmail.com)
--
-- Create Date:    03:10 2017-11-04
-- Module Name:    link_oh_fpga_tx
-- Description:    this module handles the OH FPGA packet encoding for register access and ttc commands
------------------------------------------------------------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

entity link_oh_fpga_tx is
generic(
    g_FRAME_COUNT_MAX : integer := 8;
    g_FRAME_WIDTH     : integer := 6
);
port(

    reset_i                 : in  std_logic;
    ttc_clk_40_i            : in  std_logic;

    l1a_i                   : in  std_logic;
    bc0_i                   : in  std_logic;
    resync_i                : in  std_logic;

    elink_data_o            : out std_logic_vector(7 downto 0);

    request_valid_i         : in  std_logic;
    request_write_i         : in  std_logic;
    request_addr_i          : in  std_logic_vector(15 downto 0);
    request_data_i          : in  std_logic_vector(31 downto 0);

    busy_o                  : out std_logic

);
end link_oh_fpga_tx;

architecture link_oh_fpga_tx_arch of link_oh_fpga_tx is

    type state_t is (IDLE, HEADER, DATA);


    signal state            : state_t := IDLE;
    signal data_frame_cnt   : integer range 0 to g_FRAME_COUNT_MAX-1 := 0;

    signal elink_data       : std_logic_vector(7 downto 0);
    signal frame_data       : std_logic_vector(g_FRAME_WIDTH-1 downto 0);

    signal send_idle        : std_logic;

    signal reg_data         : std_logic_vector(47 downto 0);

begin
    busy_o <= '0' when state = IDLE else '1';
    reg_data <= request_addr_i & request_data_i;

    --== State FSM ==--

    process(ttc_clk_40_i)
    begin
        if (rising_edge(ttc_clk_40_i)) then
            if (reset_i = '1') then
                state <= IDLE;
                data_frame_cnt <= 0;
            else
                case state is
                    when IDLE =>
                        if (request_valid_i = '1') then
                            state <= HEADER;
                            data_frame_cnt <= 0;
                        else
                            state <= IDLE;
                            data_frame_cnt <= 0;
                        end if;
                    when HEADER =>
                        state <= DATA;
                        data_frame_cnt <= 0;
                    when DATA =>
                        if ( l1a_i ='1' or resync_i ='1'  or bc0_i ='1' ) then
                            state <= DATA;
                        else
                            if (data_frame_cnt = g_FRAME_COUNT_MAX-1) then
                                state <= IDLE;
                            else
                                data_frame_cnt <= data_frame_cnt + 1;
                            end if;
                        end if;
                    when others =>
                        state <= IDLE;
                        data_frame_cnt <= 0;
                end case;
            end if;
        end if;
    end process;

    --== Data transmission ==--

    process(ttc_clk_40_i)
    begin
        if (rising_edge(ttc_clk_40_i)) then
            if (state=IDLE) then
                    send_idle <= '1';
            else
                    send_idle <= '0';
            end if;
        end if;
    end process;

    process(ttc_clk_40_i)
    begin
        if (rising_edge(ttc_clk_40_i)) then
            if (reset_i = '1') then
                frame_data <= (others => '0');
            else
                case state is
                    when IDLE =>
                        frame_data <= "000000";
                    when HEADER =>
                        frame_data <= "1" & request_write_i & x"b";
                    when DATA =>
                        frame_data <= reg_data(((g_FRAME_COUNT_MAX - data_frame_cnt) * g_FRAME_WIDTH) - 1 downto (g_FRAME_COUNT_MAX-1-data_frame_cnt)*g_FRAME_WIDTH);
                    when others =>
                        frame_data <= (others => '0');
                end case;
            end if;
        end if;
    end process;

    -- 8b to 6b conversion
    sixbit_eightbit_inst : entity work.sixbit_eightbit
    port map (
        eightbit     => elink_data,
        sixbit       => frame_data,
        l1a          => l1a_i,
        bc0          => bc0_i,
        resync       => resync_i,
        idle         => send_idle
   );

    process(ttc_clk_40_i)
    begin
        if (rising_edge(ttc_clk_40_i)) then
            elink_data_o <= elink_data;
        end if;
    end process;

end link_oh_fpga_tx_arch;
