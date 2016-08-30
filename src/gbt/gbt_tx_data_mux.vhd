library ieee;
use ieee.std_logic_1164.all;

entity gbt_tx_data_mux is
port(
    fabric_clk  : in std_logic;
    reset       : in std_logic;
    rx_aligned  : in std_logic;
    tx_aligned  : in std_logic;
    din         : in std_logic_vector(31 downto 0);
    dout        : out std_logic_vector(31 downto 0)
);
end gbt_tx_data_mux;

architecture behavioral of gbt_tx_data_mux is
begin

    process(fabric_clk)
    begin
        if (rising_edge(fabric_clk)) then
            if (reset = '1') then
                dout <= (others => '0');
            elsif (rx_aligned = '0' and tx_aligned = '0') then
                dout <= (others => '0');
            elsif (rx_aligned = '1' and tx_aligned = '0') then
                dout <= x"76bc76bc";
            elsif (rx_aligned = '1' and tx_aligned = '1') then
                dout <= din;
            else
                dout <= (others => '0');
            end if;
        end if;
    end process;
    
end behavioral;

