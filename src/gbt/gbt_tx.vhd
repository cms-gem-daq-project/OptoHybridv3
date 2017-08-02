----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
--
-- Create Date:    08:37:33 07/07/2015
-- Design Name:    OptoHybrid v2
-- Module Name:    gbt_tx_tracking - Behavioral
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description:
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library unisim;
use unisim.vcomponents.all;

library work;

entity gbt_tx is
port(

    clock   : in std_logic;
    reset_i     : in std_logic;

    data_o      : out std_logic_vector(15 downto 0);
    valid_i     : in std_logic;

    req_en_o    : out std_logic;
    req_valid_i : in std_logic;
    req_data_i  : in std_logic_vector(31 downto 0)
);
end gbt_tx;

architecture Behavioral of gbt_tx is

    type state_t is (SYNCING, HEADER, REG_DATA0, REG_DATA1);

    signal state        : state_t;

    signal req_valid    : std_logic;
    signal req_data     : std_logic_vector(15 downto 0);

begin

    --== STATE ==--

    process(clock)
    begin
        if (rising_edge(clock)) then
            if (reset_i = '1' or valid_i = '0') then
                state <= SYNCING;
            else
                case state is
                    when SYNCING   => state <= HEADER;
                    when HEADER    => state <= REG_DATA0;
                    when REG_DATA0 => state <= REG_DATA1;
                    when REG_DATA1 => state <= HEADER;
                    when others    => state <= SYNCING;
                end case;
            end if;
        end if;
    end process;

    --== REQUEST and TRACKING DATA==--

    process(clock)
    begin
        if (rising_edge(clock)) then
            if (reset_i = '1') then
                req_en_o <= '0';
                req_valid <= '0';
                req_data <= (others => '0');
            else
                case state is
                    when SYNCING =>
                        req_en_o <= '0';
                        req_valid <= '0';
                    when HEADER =>
                        req_en_o <= '1';
                    when REG_DATA0 =>
                        req_en_o  <= '0';
                        req_valid <= req_valid_i;
                        req_data  <= req_data_i(31 downto 16);
                    when REG_DATA1 =>
                        req_en_o  <= '0';
                        req_valid <= req_valid_i;
                        req_data  <= req_data_i(15 downto 0);
                    when others =>
                        req_en_o  <= '0';
                        req_valid <= '0';
                        req_data  <= (others => '0');
                end case;
            end if;
        end if;
    end process;

    --== SEND ==--

    process(clock)
    begin
        if (rising_edge(clock)) then
            if (reset_i = '1') then
                data_o <= (others => '0');
            else
                case state is
                    when SYNCING =>
                        data_o <= (others => '0');
                    when HEADER =>
                        data_o <= x"BCBC" and (req_valid & "111" & x"fff");
                    when REG_DATA0 =>
                        data_o <= req_data;
                    when REG_DATA1 =>
                        data_o <= req_data;
                    when others =>
                        data_o <= (others => '0');
                end case;
            end if;
        end if;
    end process;

end Behavioral;
