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

    ref_clk_i   : in std_logic;
    reset_i     : in std_logic;
    
    data_o      : out std_logic_vector(31 downto 0);
    valid_i     : in std_logic;

    req_en_o    : out std_logic;
    req_valid_i : in std_logic;
    req_data_i  : in std_logic_vector(31 downto 0);

    evt_en_o    : out std_logic;
    evt_valid_i : in std_logic;
    evt_data_i  : in std_logic_vector(223 downto 0)

);
end gbt_tx;

architecture Behavioral of gbt_tx is

    type state_t is (SYNCING, HEADER, TK_DATA, REG_DATA);

    signal state        : state_t;

    signal tk_counter   : integer range 0 to 7;

    signal evt_valid    : std_logic;
    signal evt_data     : std_logic_vector(223 downto 0);
    signal req_valid    : std_logic;
    signal req_data     : std_logic_vector(31 downto 0);

begin

    --== STATE ==--

    process(ref_clk_i)
    begin
        if (rising_edge(ref_clk_i)) then
            if (reset_i = '1' or valid_i = '0') then
                state <= SYNCING;
                tk_counter <= 0;
            else
                case state is
                    when SYNCING => state <= HEADER;
                    when HEADER =>
                        state <= TK_DATA;
                        tk_counter <= 6;
                    when TK_DATA =>
                        if (tk_counter = 0) then
                            state <= REG_DATA;
                        else
                            tk_counter <= tk_counter - 1;
                        end if;
                    when REG_DATA => state <= HEADER;
                    when others =>
                        state <= SYNCING;
                        tk_counter <= 0;
                end case;
            end if;
        end if;
    end process;

    --== REQUEST and TRACKING DATA==--

    process(ref_clk_i)
    begin
        if (rising_edge(ref_clk_i)) then
            if (reset_i = '1') then
                req_en_o <= '0';
                req_valid <= '0';
                req_data <= (others => '0');
                evt_en_o <= '0';
                evt_valid <= '0';
                evt_data <= (others => '0');
            else
                case state is
                    when SYNCING =>
                        req_en_o <= '0';
                        evt_en_o <= '0';
                        req_valid <= '0';
                        evt_valid <= '0';
                    when TK_DATA => 
                        if (tk_counter = 1) then -- Will be high on TK_DATA 0 and response on REG_DATA
                            req_en_o <= '1';
                            evt_en_o <= '1';
                        else
                            req_en_o <= '0';
                            evt_en_o <= '0';
                        end if;
                    when REG_DATA =>
                        req_en_o <= '0';
                        evt_en_o <= '0';
                        req_valid <= req_valid_i;
                        evt_valid <= evt_valid_i;
                        req_data <= req_data_i;
                        evt_data <= evt_data_i;
                    when others => 
                        req_en_o <= '0';
                        evt_en_o <= '0';
                end case;
            end if;
        end if;
    end process;

    --== SEND ==--

    process(ref_clk_i)
    begin
        if (rising_edge(ref_clk_i)) then
            if (reset_i = '1') then
                data_o <= (others => '0');
            else
                case state is
                    when HEADER =>
                        data_o <= req_valid & evt_valid & "00" & x"000BCBC";
                    when TK_DATA =>
                        data_o <= evt_data((32 * tk_counter + 31) downto (32 * tk_counter));
                    when REG_DATA =>
                        data_o <= req_data;
                    when others =>
                        data_o <= (others => '0');
                end case;
            end if;
        end if;
    end process;

end Behavioral;
