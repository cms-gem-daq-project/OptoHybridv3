----------------------------------------------------------------------------------
-- CMS Muon Endcap
-- GEM Collaboration
-- Optohybrid v3 Firmware -- GBT Transmit Packet Builder
-- T. Lenzi, E. Juska, A. Peck
----------------------------------------------------------------------------------
-- Description:
--   This module generates data packets for transmission to the CTP-7
--   takes 32 bit register data and formats it into frames for transmission on elinks
----------------------------------------------------------------------------------
-- 2017/07/24 -- Initial working version adapted from v2
-- 2017/08/09 -- Add "10 bit" transmit mode for OHv3a
-- 2018/09/27 -- Convert to sixbit_eightbit, single elink encoding
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

library work;

entity gbt_tx is port(

    clock       : in std_logic;

    reset_i     : in std_logic;

    data_o      : out std_logic_vector(7 downto 0);

    req_en_o    : out std_logic;
    req_valid_i : in std_logic; --valid request from fifo
    req_data_i  : in std_logic_vector(31 downto 0)
);
end gbt_tx;

architecture Behavioral of gbt_tx is

    type state_t is (IDLE, START, REG_DATA0, REG_DATA1, REG_DATA2, REG_DATA3, REG_DATA4, REG_DATA5);

    signal state : state_t;

    signal req_valid : std_logic;
    signal frame     : std_logic_vector (5 downto 0);

    signal send_idle : std_logic;

    signal reset : std_logic;

begin

    -- fanout reset tree

    process (clock) begin
        if (rising_edge(clock)) then
            reset <= reset_i;
        end if;
    end process;


    process(clock)
    begin
        if (rising_edge(clock)) then
            if (reset = '1') then
                state <= IDLE;
            else
                case state is

                    when IDLE =>
                        if (req_valid_i='1') then
                            state <= REG_DATA0;
                        end if;
                    when REG_DATA0 => state <= REG_DATA1;
                    when REG_DATA1 => state <= REG_DATA2;
                    when REG_DATA2 => state <= REG_DATA3;
                    when REG_DATA3 => state <= REG_DATA4;
                    when REG_DATA4 => state <= REG_DATA5;

                    when REG_DATA5 =>
                        if (req_valid_i='1') then
                            state <= REG_DATA0;
                        else
                            state <= IDLE;
                        end if;

                    when others => state <= IDLE;
                end case;
            end if;
        end if;
    end process;

    --== REQUEST and TRACKING DATA==--

    process(clock)
    begin
        if (rising_edge(clock)) then
            if (reset = '1') then
                                      req_en_o <= '0'; req_valid <= '0';
            else
                case state is
                    when IDLE =>      send_idle <= '1'; req_en_o  <= '1'; req_valid <= req_valid_i;
                    when REG_DATA0 => send_idle <= '0'; req_en_o  <= '0';
                    when REG_DATA1 => send_idle <= '0'; req_en_o  <= '0';
                    when REG_DATA2 => send_idle <= '0'; req_en_o  <= '0';
                    when REG_DATA3 => send_idle <= '0'; req_en_o  <= '0';
                    when REG_DATA4 => send_idle <= '0'; req_en_o  <= '1'; -- prefetch by 1 bx from end to account for fifo latency
                    when REG_DATA5 => send_idle <= '0'; req_en_o  <= '0'; req_valid <= req_valid_i;
                    when others =>    send_idle <= '1'; req_en_o  <= '0'; req_valid <= '0';

                end case;
            end if;
        end if;
    end process;

    --== SEND ==--

    process(clock)
    begin
        if (rising_edge(clock)) then
            if (reset = '1') then
                frame <= (others => '0');
            else
                case state is
                    when IDLE      => frame <= "00" & x"0";
                    when REG_DATA0 => frame <= x"0" & req_data_i(31 downto 30);
                    when REG_DATA1 => frame <= req_data_i(29 downto 24);
                    when REG_DATA2 => frame <= req_data_i(23 downto 18);
                    when REG_DATA3 => frame <= req_data_i(17 downto 12);
                    when REG_DATA4 => frame <= req_data_i(11 downto 6);
                    when REG_DATA5 => frame <= req_data_i(5 downto 0);
                    when others    => frame <= (others => '0');
                end case;
            end if;
        end if;
    end process;
	 
	 
    -- 8b to 6b conversion
    sixbit_eightbit_inst : entity work.sixbit_eightbit
    port map (
        eightbit     => data_o,
        sixbit       => frame,
        l1a          => '0',
        bc0          => '0',
        resync       => '0',
        idle         => send_idle
    );

end Behavioral;
