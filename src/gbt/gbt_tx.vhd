----------------------------------------------------------------------------------
-- CMS Muon Endcap
-- GEM Collaboration
-- Optohybrid v3 Firmware -- GBT Transmit Packet Builder
-- T. Lenzi, E. Juska, A. Peck
----------------------------------------------------------------------------------
-- Description:
--   This module generates data packets for transmission to the CTP-7
--   takes 32 bit register data and formats it into 16-bit frames with a header
----------------------------------------------------------------------------------
-- 2017/07/24 -- Initial working version adapted from v2
-- 2017/08/09 -- Add "10 bit" transmit mode for OHv3a
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library unisim;
use unisim.vcomponents.all;

library work;

entity gbt_tx is
    generic(
        g_16BIT : boolean := false
    );
port(

    clock   : in std_logic;
    reset_i     : in std_logic;

    data_o      : out std_logic_vector(15 downto 0);

    req_en_o    : out std_logic;
    req_valid_i : in std_logic;
    req_data_i  : in std_logic_vector(31 downto 0)
);
end gbt_tx;

architecture Behavioral of gbt_tx is

    type state_t is (SYNCING, HEADER, REG_DATA0, REG_DATA1, REG_DATA2, REG_DATA3);

    signal state        : state_t;

    signal req_valid    : std_logic;
    signal frame        : std_logic_vector (15 downto 0);

    signal reset : std_logic;

begin

    -- fanout reset tree

    process (clock) begin
        if (rising_edge(clock)) then
            reset <= reset_i;
        end if;
    end process;

    --=========================--
    --== 16 bit decoding     ==--
    --=========================--

    g_sixteen : IF (g_16BIT) GENERATE

    --== STATE ==--

    process(clock)
    begin
        if (rising_edge(clock)) then
            if (reset = '1') then
                state <= SYNCING;
            else
                case state is

                    when SYNCING   =>
                        if (req_valid_i='1') then
                            state <= HEADER;
                        end if;

                    when HEADER    => state <= REG_DATA0;

                    when REG_DATA0 => state <= REG_DATA1;

                    when REG_DATA1 =>
                        if (req_valid_i='1') then
                            state <= HEADER;
                        else
                            state <= SYNCING;
                        end if;

                    when others => state <= SYNCING;
                end case;
            end if;
        end if;
    end process;

    --== REQUEST and TRACKING DATA==--

    process(clock)
    begin
        if (rising_edge(clock)) then
            if (reset = '1') then
                req_en_o <= '0';
                req_valid <= '0';
            else
                case state is

                    when SYNCING =>
                        req_en_o <= '1';
                        req_valid <= req_valid_i;

                    when HEADER =>
                        req_en_o <= '0';

                    when REG_DATA0 =>
                        req_en_o <= '1'; -- prefect to account for fifo latency

                    when REG_DATA1 =>
                        req_en_o <= '0';
                        req_valid <= req_valid_i;

                    when others =>
                        req_en_o  <= '0';
                        req_valid <= '0';

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
                    when SYNCING =>
                        frame <= x"FCFC";

                    when HEADER =>
                        if (req_valid='1') then
                            frame <= x"BCBC";
                        else
                            frame <= x"FCFC";
                        end if;

                    when REG_DATA0 =>
                        if (req_valid='0') then
                            frame <= x"0000";
                        else
                            frame <= req_data_i(31 downto 16);
                        end if;

                    when REG_DATA1 =>
                        if (req_valid='0') then
                            frame <= x"0000";
                        else
                            frame <= req_data_i(15 downto 0);
                        end if;

                    when others =>
                        frame <= (others => '0');

                end case;
            end if;
        end if;
    end process;

    -- duplicate the 2 MSBS to transmit at 320 MHz
    data_o (15 downto 0) <= frame (15 downto 0);

    END GENERATE g_sixteen;

    --=====================--
    --== 10 bit encoding ==--
    --=====================--

    --== STATE ==--

    g_ten : IF (not g_16BIT) GENERATE

    process(clock)
    begin
        if (rising_edge(clock)) then
            if (reset = '1') then
                state <= SYNCING;
            else
                case state is

                    when SYNCING   =>
                        if (req_valid_i='1') then
                            state <= HEADER;
                        end if;

                    when HEADER    => state <= REG_DATA0;
                    when REG_DATA0 => state <= REG_DATA1;
                    when REG_DATA1 => state <= REG_DATA2;
                    when REG_DATA2 => state <= REG_DATA3;

                    when REG_DATA3 =>
                        if (req_valid_i='1') then
                            state <= HEADER;
                        else
                            state <= SYNCING;
                        end if;

                    when others => state <= SYNCING;
                end case;
            end if;
        end if;
    end process;

    --== REQUEST and TRACKING DATA==--

    process(clock)
    begin
        if (rising_edge(clock)) then
            if (reset = '1') then
                req_en_o <= '0';
                req_valid <= '0';
            else
                case state is

                    when SYNCING =>
                        req_en_o <= '1';
                        req_valid <= req_valid_i;

                    when HEADER =>
                        req_en_o <= '0';

                    when REG_DATA0 =>
                        req_en_o  <= '0';

                    when REG_DATA1 =>
                        req_en_o  <= '0';

                    when REG_DATA2 =>
                        req_en_o  <= '1'; -- prefect to account for fifo latency

                    when REG_DATA3 =>
                        req_en_o  <= '0';
                        req_valid <= req_valid_i;

                    when others =>
                        req_en_o  <= '0';
                        req_valid <= '0';

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
                    when SYNCING =>
                        frame <= x"00FC";

                    when HEADER =>
                        if (req_valid='1') then
                            frame <= x"00BC";
                        else
                            frame <= x"00FC";
                        end if;

                    when REG_DATA0 =>
                        if (req_valid='0') then
                            frame <= x"0000";
                        else
                            frame <= "000000" & "01" & req_data_i(31 downto 24);
                        end if;

                    when REG_DATA1 =>
                        if (req_valid='0') then
                            frame <= x"0000";
                        else
                            frame <= "000000" & "01" & req_data_i(23 downto 16);
                        end if;

                    when REG_DATA2 =>
                        if (req_valid='0') then
                            frame <= x"0000";
                        else
                            frame <= "000000" & "01" & req_data_i(15 downto 8);
                        end if;

                    when REG_DATA3 =>
                        if (req_valid='0') then
                            frame <= x"0000";
                        else
                            frame <= "000000" & "01" & req_data_i(7 downto 0);
                        end if;

                    when others =>
                        frame <= (others => '0');
                end case;
            end if;
        end if;
    end process;

    -- duplicate the 2 MSBS to transmit at 320 MHz
    data_o (15 downto 0) <= frame (9) & frame (9) & frame(9) & frame(9) &
                            frame (8) & frame (8) & frame(8) & frame(8) &
                            frame (7 downto 0);

    END GENERATE g_ten;

end Behavioral;
