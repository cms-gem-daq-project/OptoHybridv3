------------------------------------------------------------------------------------------------------------------------------------------------------
-- Company: TAMU
-- Engineer: Evaldas Juska (evaldas.juska@cern.ch, evka85@gmail.com)
--
-- Create Date:    02:35 2016-05-31
-- Module Name:    link_gbt_rx
-- Description:    this module provides GBT RX link decoding
------------------------------------------------------------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

entity link_gbt_rx is
port(

    ttc_clk_40_i            : in std_logic;
    reset_i                 : in std_logic;

    req_en_o                : out std_logic;
    req_data_o              : out std_logic_vector(31 downto 0);

    gbt_rx_data_i           : in std_logic_vector(15 downto 0)

);
end link_gbt_rx;

architecture link_gbt_rx_arch of link_gbt_rx is

    type state_t is (HEADER00, HEADER01, REG_DATA);

    signal state            : state_t;

    signal req_valid        : std_logic := '0';

    signal oh_data          : std_logic_vector(15 downto 0) := (others => '0');

begin

    -- on OH v3a, two e-links are connected to the FPGA
    oh_data <= gbt_rx_data_i(15 downto 0);

    --== STATE ==--

    process(ttc_clk_40_i)
    begin
        if (rising_edge(ttc_clk_40_i)) then
            if (reset_i = '1') then
                state <= HEADER00;
            else
                case state is
                    when HEADER00 =>
                        if (oh_data(15 downto 0) = x"BCBC") then
                            state <= HEADER01;
                        end if;
                    when HEADER01 =>
                        state <= REG_DATA;
                    when REG_DATA => state <= HEADER00;
                    when others =>
                        state <= HEADER00;
                end case;
            end if;
        end if;
    end process;

    --== REQUEST ==--

    process(ttc_clk_40_i)
    begin
        if (rising_edge(ttc_clk_40_i)) then
            if (reset_i = '1') then
                req_en_o <= '0';
                req_data_o <= (others => '0');
                req_valid <= '0';
            else
                case state is
                    when HEADER00 =>    req_en_o   <= '0';
                                        req_data_o <= (others => '0');

                    when HEADER01 =>    req_valid  <= oh_data(15); -- copies the 1 from 0xB... in 0xbcbc... the other 15 bits are wasted :(
                                        req_data_o <= (others => '0');

                    when REG_DATA =>    req_en_o   <= req_valid;
                                        req_data_o <= oh_data;

                    when others =>      req_en_o   <= '0';
                                        req_data_o <= (others => '0');
                end case;
            end if;
        end if;
    end process;

end link_gbt_rx_arch;
