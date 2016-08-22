library ieee;
use ieee.std_logic_1164.all;

entity gbt_rx_aligner is
port(
    fabric_clk  : in std_logic;
    reset       : in std_logic;
    from_gbt    : in std_logic_vector(15 downto 0);
    bitslip     : out std_logic;
    gbt_aligned : out std_logic
);
end gbt_rx_aligner;

architecture behavioral of gbt_rx_aligner is

    signal is_aligned : std_logic := '0';
    signal timeout : integer range 0 to 7 := 0;

begin

    process(fabric_clk)
    begin
        if (rising_edge(fabric_clk)) then
            if (reset = '1') then
                bitslip <= '0';
                gbt_aligned <= '0';
                is_aligned <= '0';
                timeout <= 0;
            else
                if (is_aligned = '1') then
                    bitslip <= '0';
                    gbt_aligned <= '1';
                    is_aligned <= '1';
                    timeout <= 0;
                elsif (from_gbt = x"76bc") then
                    bitslip <= '0';
                    gbt_aligned <= '1';
                    is_aligned <= '1';
                    timeout <= 0;
                elsif (timeout = 0) then
                    bitslip <= '1';
                    gbt_aligned <= '0';
                    is_aligned <= '0';
                    timeout <= 7;
                else
                    bitslip <= '0';
                    gbt_aligned <= '0';
                    is_aligned <= '0';
                    timeout <= timeout - 1;
                end if;
            end if;
        end if;
    end process;

end behavioral;

